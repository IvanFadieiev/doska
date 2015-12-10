// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require_tree .
//= require textile-editor
//= require ./textile-editor-config

$(document).ready(function () {
  $('#new_comment').submit(function(event) {
    event.preventDefault();
    $.ajax({
      url: $(this).attr('action')
      method: 'POST',
      data: $(this).serialize(),
      success: function (data) {
        $('#post_comments tbody').append(
          '<tr>'+'<td>'+data.comment.id+'</td>'+
          '<td><div class=\"round-image-50\">'+'<img src='+data.user_avatar+'></div></td>'+
          '<td>'+data.user.user+'</td>'+
          '<td>'+data.comment.body+'</td>'+
          '<td>'+'<a href=\"/posts/'+data.comment.post_id+'/comments/'+data.comment.id+'/edit\">Edit</a>'+'</td>'+
          '<td>'+'<a data-confirm=\"точно?\" class=\"deleteAction\" data-remote=\"true\" rel=\"nofollow\" data-method=\"delete\" href="/comments/'+data.comment.id+'\">Destroy</a>'+'</td>'+
          '</tr>'
        );
      },
      error: function (data) {
        console.log(data);
      }
    });
  });
});
