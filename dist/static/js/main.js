$(document).ready( () => {

    $.datetimepicker.setDateFormatter({
        parseDate: function (date, format) {
            var d = moment(date, format);
            return d.isValid() ? d.toDate() : false;
        },
        formatDate: function (date, format) {
            return moment(date).format(format);
        },

        formatTime: function(date, format) {
            return moment(date).format(format)
        },
        parseTime: function(date, format){
            var t = moment(date, format);
            return t.isValid() ? t.toTime() : false;
        }
    });

    $('#match-date').datetimepicker({
        rtl:false,

        format:'YYYY-MM-DD HH:mm',
        formatDate:'YYYY-MM-DD',
        formatTime:'HH:mm',
	    
        inline:false
    })

    $('#match-date').attr('name','due')

    new TomSelect($('select[name="team_1"]') , {placeholder:'Team 1'});
    new TomSelect($('select[name="team_2"]') , {placeholder: 'Team 2'});


})