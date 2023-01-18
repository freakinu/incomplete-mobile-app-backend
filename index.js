/**
 * part of the incomplete-hybrid-mobile-app repo 
 * for testing only, not ready for production
 * 
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004
 
Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.
 
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.
 */

const express = require('express')
const sessions = require('express-session')
const app = express()
const mysql = require('mysql')
const port = process.env.port ||  3000
const nodemailer = require('nodemailer')
const crypto = require('crypto')
const jwt = require('jsonwebtoken')
const path = require('path')
const cookieParser = require('cookie-parser')
const morgan = require('morgan')
const validator = require('validator')
const fileUpload = require('express-fileupload')
const fs = require('fs')


app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'dist/views'))
app.use(express.static(path.join(__dirname, 'dist/static')))
app.use(express.urlencoded({extended:true}))
app.use(express.json())
app.use(cookieParser())
app.use(fileUpload())


morgan.token('body', (req, res) => JSON.stringify(req.body));
app.use(morgan(':method :url :status :response-time ms - :res[content-length] :body - :req[content-length]', {stream: fs.createWriteStream('/tmp/access.log', {flags:'a'})}) );


const JWT_KEY = 'YOUR_KEY'
const month = 3600 * 24 * 30 * 1000

let pool = mysql.createPool({
    host:'172.19.0.2', 
    user:'user',
    password:'a l33t password',
    database:'soccer',
    dateStrings:false
})


app.use(sessions({
    secret:"YOUR_KEY",
    resave:false,
    saveUninitialized: true,
    cookie: {maxAge: month}
    
}))


const mail_transport = nodemailer.createTransport({
        host:'smtp.examp.le',
        port:465,
        auth: {
            user: 'noreply@examp.le',
            pass: "a l33t password",
        }
    }
) 

function status(status, _res){
    _res.write(JSON.stringify(status))
    _res.end()

}

async function send_mail(from,to,subject,msg){
    await mail_transport.sendMail({from: from, to:to, subject: subject, html : msg})
}

app.post('/rest/register', (_req, _res) => {

    let email = _req.body.email
    let password = _req.body.password

    if(email == null || password == null){
        _res.end()
        return
    }

    let json = {status: 'success'}

    if(!validator.isEmail(email)){
        json.status = 'error'
        json.message = 'Invalid Email Address'
        status(json, _res)
        return
    }

    email = email.toLowerCase()

    password = crypto.createHash('sha256').update(_req.body.password).digest('hex')

    let random = Math.floor(Math.random() * (99999 - 10000)) +  10000;

    pool.query('SELECT email FROM users WHERE email = ?', [email], function(err, rows){

        if(rows.length > 0){
            json.status = 'error'
            json.message = 'email address is already registered'
            status(json, _res)
            return
        }

        pool.query("INSERT INTO users(email,password,verification_code,verified) VALUES (?,?,?,?)", [email, password,random, 'false' ], function(err, rows){
            if(err){
                json.status = 'error'
                status(json, _res)
                return
            }
            
            send_mail("Football App Test <leo@codeventa.com>", email, 'Your Verification Code', random.toString())
            status(json, _res)
        })
       
    })
 
})

app.post('/rest/verify', (_req, _res) => {
    let email = _req.body.email
    let code  = _req.body.code 

    let json = {status:'success'}

    if(email == null || code == null){
        _res.end()
        return
    }

    pool.query("SELECT id,email,verification_code FROM users WHERE email = ? AND verification_code = ? ", [email, code], function(err, rows){
        if(err){
            json.status = 'error'
            status(json,_res)
            return
        }

       
        if(rows.length > 0){

            let user_id = rows[0]['id']
            let token = jwt.sign({id:user_id}, JWT_KEY)

            pool.query("UPDATE users SET verified = ?, token = ? WHERE id = ?", ['true', token, id], function(err, rows){
                if(err){
                    json.status = 'error'
                    status(json, _res)
                    return
                }

                json.token = token
                json.user_id = user_id 
                status(json, _res)
            })

            return
        }

        json.status = 'error'
        json.message = 'Invalid Code'
        status(json, _res)

    })

})


app.post('/rest/login', (_req, _res) => {

    let email = _req.body.email 
    let password = _req.body.password

    let json = {status:'success'}

    if(email == null || password == null){
        _res.end()
        return
    }

    password = crypto.createHash('sha256').update(_req.body.password).digest('hex')
    
    pool.query('SELECT id,email,full_name,age,sex,pp FROM users WHERE email = ? AND password = ?', [email,password], function(err,rows){
        if(rows.length > 0){
            
            pool.query("SELECT id,verified FROM users WHERE email = ?", [email], function(err, rows){
            
                if(rows[0]['verified'] === 'true'){
                    let row = rows[0]
                    let user_id = row['id']
                    let token = jwt.sign({id:user_id}, JWT_KEY)
                    pool.query('UPDATE users SET token = ? WHERE id = ?', [token, row['id']], function(err, rows){
                        if(err){
                            json.status = 'error'
                            status(json , _res)
                            return 
                        }

                        json.token = token
                        json.user_id = user_id
                        status(json , _res)
                    })

                    return
                }

                json.status = 'error'
                json.message = 'user needs verification'
                status(json, _res)
            })

            return
        }

        json.status = 'error'
        json.message = 'email or password are incorrect'
        status(json, _res)
    })
})

app.get('/rest/matches', (_req, _res) => {
    

    if(_req.query.simple !== undefined){
        pool.query("SELECT GROUP_CONCAT( (DATE_FORMAT(due,'%d %b %H:%i')) , ' ', (SELECT name FROM teams WHERE id=team_1), ' vs ' , (SELECT name FROM teams WHERE id=team_2) ) as m,id FROM matches GROUP BY id ORDER BY due ASC", function(err, rows){
            _res.write(JSON.stringify(rows))
            _res.end()
            //test
        })

        return 
    }

    pool.query('SELECT (SELECT cc FROM teams WHERE id=team_1) as cc1, (SELECT cc FROM teams WHERE id=team_2) as cc2,id,DATE_FORMAT(due,\'%Y-%m-%d %H:%i\') as due_fr,team_1,team_2,score_1,score_2 FROM matches ORDER BY due ASC', function(err, rows){
       
        _res.write(JSON.stringify(rows))
        _res.end()
        
    })
})



app.get('/rest/scorers', (_req, _res) => {
    pool.query('SELECT name,points,pp FROM scorers ORDER BY points DESC', function(err, rows){

        _res.write(JSON.stringify(rows))
        _res.end()

    })
})



app.get('/rest/groups', (_req, _res) => {

        pool.query("SELECT team_groups.group_letter as lt, group_concat((SELECT name FROM teams WHERE id= team_groups.team_id ), ':',(SELECT cc FROM teams WHERE id = team_groups.team_id) ) as teams FROM teams INNER JOIN team_groups ON team_groups.team_id = teams.id GROUP BY lt ORDER BY lt ASC", function(err,rows){
             _res.write(JSON.stringify(rows))
            _res.end() 
        });
        
})


app.get('/rest/prizes', (_req, _res) => {
    pool.query('SELECT id,name,points_to_win,prize_img,sponsor_img FROM prizes ORDER by points_to_win DESC', function(err, rows){
        _res.write(JSON.stringify(rows))
        _res.end()
    })
})

app.get('/rest/stickers', (_req, _res) => {
    pool.query('SELECT id,url FROM stickers', function(err, rows){
        _res.write(JSON.stringify(rows))
        _res.end()
    })
})

app.get('/admin/', (_req, _res) => {
    if(_req.session.logged_in){
        _res.redirect('/admin/prizes')
        return
    }

    _res.render('login')
})



app.get('/admin/prizes', (_req, _res) => {
    if(!_req.session.logged_in){
        _res.redirect('/admin')
        return
    }

    pool.query("SELECT id,name,points_to_win,prize_img,sponsor_img FROM prizes", function(err, rows){
        _res.render('prizes', {prizes:rows})
    })

    
})

app.post('/admin/prizes', (_req,_res) => {
    if(!_req.session.logged_in){
        _res.redirect('/admin')
        return 
    }

    let name = _req.body.name 
    let points_to_win = _req.body.points_to_win
    let prize_img = _req.files.prize_img 
    let sponsor_img = _req.files.sponsor_img 

    if(name == null || points_to_win == null || prize_img == null  || sponsor_img == null)
        return

    if(prize_img.mimetype.split('/')[0] !== 'image' || sponsor_img.mimetype.split('/')[0] !== 'image'){
        _res.end('File Type not Allowed.')
        return 
    }
        
    
    fs.writeFile(path.join(__dirname, 'dist/static/uploads', prize_img.name),  prize_img.data , function(err, file){})
    fs.writeFile(path.join(__dirname, 'dist/static/uploads', sponsor_img.name),sponsor_img.data ,  function(err, file){})

    pool.query('INSERT INTO prizes (name,points_to_win,prize_img, sponsor_img) VALUES (?,?,?,?)', [name, points_to_win, `/uploads/${prize_img.name}`, `/uploads/${sponsor_img.name}`], function(err, rows){
        if(err) console.log(err)
        _res.redirect('/admin/prizes')
    })
    
})





app.post('/admin/delete', (_req, _res) => {

    if(!_req.session.logged_in){
        _res.redirect('/admin')
        return
    }

    let type = _req.body.type 

    if(type == 'prize' && _req.body.id !== null){
        pool.query('DELETE FROM prizes WHERE id = ?', [_req.body.id], (err,rows) => {
            _res.redirect('/admin/prizes')
        })

        return
    }

    _res.redirect('/admin')
    
})

app.post('/admin/login', (_req, _res) => {
    
    let user = _req.body.user
    let password = _req.body.password 

    if(user == null || password == null){
        _res.end()
        return
    }

    password = crypto.createHash('sha256').update(password).digest('hex')

    pool.query('SELECT id,username,password from admin_users WHERE username = ? AND password = ?', [user,password], function(err, rows){

        if(rows.length > 0){
            _req.session.logged_in = true
            _req.session.user_id = rows[0]['id']
            _req.session.username = rows[0]['username'] 
            _res.redirect('/admin')
            return 
        } 
        _res.render('login', {failed: true})
        
    })
})


app.get('/rest/get_user_info', (_req, _res) => {
    let token = _req.query.token 
    let json = {'status':'success'}

    if(token == null){
        _res.end() 
        return
    }

    pool.query('SELECT id,points,full_name,age,sex,email FROM users WHERE token = ?', [token], function(err, rows){
         
    
        if(rows.length > 0){
            json.data = rows[0]
            status(json, _res)
            return
        }

        json.status = 'error'
        status(json, _res)

    })
})


app.post('/rest/update_user_pic', (_req, _res) => {
    let token = _req.body.token
    let id    = _req.body.id
    let pp    = _req.body.pp
    let json = {'status':'success'}


    if(id == undefined){
        json.status     = 'error'
        json.message    = 'User ID not defined'
        status(json, _res)
        return
    }

    if(token == null){
        json.req        = _req.query.token
        json.status     = 'error'
        json.message    = 'You\re no logged in'
        status(json, _res)
        return
    }

    pool.query('SELECT token FROM users WHERE token = ? AND id = ?', [token,id], function(err, rows){

        if (err) {
            json.status  = 'error'
            json.message = 'Invalid Token'
            status(json, _res)
            _res.render('login')
        }

        if(rows.length > 0){
            pool.query('UPDATE users SET ? WHERE id = ?', [{pp: pp},id], function(err, rows){
                if (err) {
                    json.status  = 'error'
                    json.message = 'Picture Not Updated'
                }
        
            })
        }
        
        status(json, _res)
        return  
    })
})

app.get('/rest/challenges', (_req, _res) => {
    pool.query('SELECT id,challenge_name FROM challenges', function(err, rows){
        _res.write(JSON.stringify(rows))
        _res.end()
    })
})



app.get('/rest/match', (_req,_res) => {

    let json = {status:'success'}
    let id = _req.query.id

    if(id == undefined){
        _res.end()
        return
    }

    pool.query("SELECT (SELECT cc FROM teams WHERE id=team_1) as cc1, (SELECT cc FROM teams WHERE id=team_2) as cc2,id,DATE_FORMAT(due,\'%Y-%m-%d %H:%i\') as due_fr,team_1,team_2,score_1,score_2 FROM matches WHERE id = ?", [id], function(err, rows){

        if(rows.length > 0){
            json.data = rows[0] 
            status(json, _res)
            return
        }

        json.status = 'error'
        json.message = 'match id is invalid'
        status(json, _res)
       
    })


})

// Group APIS start here

// Create a Group API
app.post('/rest/create_group', (_req, _res) => {
    
    let user_id         = _req.body.user_id

    let name            = _req.body.name
    let match_id        = _req.body.match_id
    let challenge_id    = _req.body.challenge_id
    let group_link      = name + match_id + _req.body.max
    let max             = _req.body.max
    let grp_status      = "1"
    let usr_status      = "1"
    let team_id         = _req.body.team_id

    if (user_id == null || name == null || challenge_id == null || max == null || team_id == null){
        _res.end() 
        return
    }

    let json            = {status: 'success'}

    if(max > 8){
        json.status = 'error'
        json.message = 'Sorry, maximum allowed members to join the group is 8'
        status(json, _res)
        return
    } else if(max == 1 || max == 3 || max == 5) {
        json.status = 'error'
        json.message = 'Group requires even numbers made of 2 or 4 or 6'
        status(json, _res)
        return 
    } else if(max <= 0) {
        json.status = 'error'
        json.message = 'Group creations should include members'
        status(json, _res)
        return 
    }

    pool.query('INSERT INTO challenge_grp (name,match_id,challenge_id,group_link,max,status) VALUES (?,?,?,?,?,?)', [name, match_id, challenge_id, group_link, max, grp_status] , function(err, results){
        if (err) {
            json.status = 'error'
            json.data   = err.message
            status(json, _res)
            return
        }

        if(results.affectedRows == 1){
            let group_id = results.insertId
            json.id = group_id
            pool.query('INSERT INTO challenge_grp_users (user_id,group_id,team_id,status) VALUES (?,?,?,?)', [user_id, group_id, team_id, usr_status] , function(err, result) {
                if (err) {
                    json.status = 'error'
                    json.data   = err.message
                    status(json, _res)
                    return
                }

            })
        }

        status(json, _res)
        return
    })


})

// Get Group Information
app.get('/rest/group_info', (_req,_res) => {

    let json = {status:'success'}
    let id = _req.query.id

    if(id == undefined){
        _res.end()
        return
    }

    pool.query("SELECT (SELECT challenge_name FROM challenges WHERE id = challenge_grp.challenge_id) as challenge_name,max,name FROM challenge_grp WHERE id = ?", [id], function(err, rows){

        if(rows.length > 0){
            json.data = rows[0]
            status(json, _res)
            return 
        }

        json.status = 'error'
        json.message = 'group id is invalid'
        status(json, _res)

    })
})

// Get list of all groups per USER ID
app.get('/rest/challenge_groups', (_req, _res) => {
    let json = {status:'success'}
    
    pool.query("SELECT id,name,max,match_id,(SELECT teams.name FROM matches INNER JOIN teams ON matches.team_1 = teams.id WHERE matches.id = challenge_grp.match_id) as team_1,(SELECT teams.name FROM matches INNER JOIN teams ON matches.team_2 = teams.id WHERE matches.id = challenge_grp.match_id) as team_2 FROM challenge_grp ORDER BY date DESC", function(err, rows){

        if(err){
            json.status = 'error'
            status(json, _res)
            return 
        }

        json.data = rows 
        status(json, _res)
        
    })
})

// Join a Group
app.post('/rest/join_group', (_req,_res) => {

    let json        = {'status':'success'}
    let group_id    = _req.body.group_id
    let user_id     = _req.body.user_id
    let team_id     = _req.body.team_id
    let usr_status  = "1"

    let token       = _req.query.token 


    if(token == null){
        json.req    = _req.query.token
        json.status = 'error'
        json.message = 'You\re no logged in'
        status(json, _res)
        return
    }

    pool.query('SELECT token FROM users WHERE token = ?', [token], function(err, rows){
        
        pool.query("SELECT max FROM challenge_grp as cg INNER JOIN challenge_grp_users as cgu WHERE cg.id = cgu.group_id", [group_id], function(err, rows){

            if (err) {
                json.status = 'error'
                json.data   = err.message
                status(json, _res)
                return
            }

            json.data = rows 
            status(json, _res)
            return

        })

        json.data = "Accessed" 
        // if(rows.length > 0){

        //     pool.query('UPDATE challenge_grp_users set user_id=? team_id=? status=? WHERE group_id=?', [user_id, team_id, usr_status,group_id], function(err,rows){
        //         status(json,_res)
        //         return
        //     })
        // }

        // json.status = 'error'
        // status(json, _res)

    })

    status(json, _res)
    return

})

// Add Group Message
app.post('/rest/add_group_msg', (_req,_res) => {

    let json = {status:'success'}

    let group   = _req.body.group
    let sticker = _req.body.sticker
    let user    = _req.body.user 

    if(group == null || sticker == null || user == null){
        _res.end() 
        return
    }

    pool.query('INSERT INTO stickers_log (user,sticker,group_id,time) VALUES (?,?,?,NOW())', [user, sticker, group], function(err,rows){
        status(json,_res)
    })
})

// List all group messages
app.get('/rest/group_msgs', (_req,_res) => {

    let json = {status:'success'}
    let id = _req.query.id

    if(id == undefined){
        _res.end()
        return
    }

    pool.query("SELECT (SELECT full_name FROM users WHERE id = user) as user,(SELECT url FROM stickers WHERE id = sticker) as sticker FROM stickers_log WHERE group_id = ? ORDER BY time DESC", [id], function(err, rows){
      //  if(rows.length > 0){
            json.data = rows
            status(json, _res)
        //    return
      //  }

       /* json.status = 'error'
        json.message = 'invalid group id'
        status(json , _res)*/
    })

})


app.listen(port, '0.0.0.0', () => {
    console.log('Fucking Football App server have been started.')
})
