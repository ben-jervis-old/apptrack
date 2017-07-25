// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require vue
//= require_tree .

var doc_ready = function() {
	$('#login-page-tabs a').click(function(e) {
		e.preventDefault();
		$(this).tab('show');
	});

	$('#login-page-tabs a:first').tab('show');

	$('#register-tab-button').click(function(e) {
		e.preventDefault();
		$('#login-page-tabs a:last').tab('show');
	});

	$('#login-tab-button').click(function(e) {
		e.preventDefault();
		$('#login-page-tabs a:first').tab('show');
	});
}

$(document).ready(doc_ready);
$(document).on('turbolinks:load', doc_ready);
