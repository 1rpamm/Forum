# -*- encoding : utf-8 -*-
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$.tablesorter.addParser(
  id : "dataNum"
  is : (s) ->
    console.log(s)
    false
  format : (s) ->
    parseInt($(s).html())
  type : 'numeric'
)

$ ->
  $("table.users.sort").tablesorter({headers: {3: {sorter: 'dataNum'}}})
