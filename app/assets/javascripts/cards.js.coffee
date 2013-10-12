# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

  
$ ->
  $( ".carte" ).disableSelection()
  casFavorables = 0
  conjonction = ""
  set_rules = ->
    
    casFavorables = 0
    $("div .carte").each ->
      couleur = $(this).data("couleur")
      valeur = $(this).data("valeur")
      tags = $(this).data("tags").split(/[ ,]+/)
      conjonction = $('input[name=conjonction]:checked').val()
      switch conjonction
        when "et"
          ok = true
          $( 'input:checkbox:checked[data-couleur]' ).each ->
            ok = false if (couleur isnt $(this).data("couleur"))
          $( 'input:checkbox:checked[data-valeur]' ).each ->
            ok = false if (valeur isnt $(this).data("valeur"))
          $( 'input:checkbox:checked[data-tags]' ).each ->
            ok = false if ($(this).data("tags") not in tags)
        when "ou"
          ok = false
          $( 'input:checkbox:checked[data-couleur]' ).each ->
            ok = true if (couleur is $(this).data("couleur"))
            #alert $(this).data("couleur")
          $( 'input:checkbox:checked[data-valeur]' ).each ->
            ok = true if (valeur is $(this).data("valeur"))
          $( 'input:checkbox:checked[data-tags]' ).each ->
            ok = true if ($(this).data("tags") in tags)
        else
          alert "todo!"
      casFavorables++ if ok 
    $(".soluce").text "cas favorables=#{casFavorables}"

  
  
  $( 'input' ).change ->
    set_rules()
  
      
  $( "#random" ).click =>
    $( 'input:checkbox' ).each ->
      checked = [true,false][Math.floor(Math.random() * 2)]
      $( this ).attr("checked",checked)
    set_rules()
    
  
  $( ".ensemble" ).sortable
    connectWith: ".ensemble"
    placeholder: "carte placeholder"
    stop: (event, ui) ->
      liste = []
      found = 0

      $("#evenement div").each ->
        liste.push $(this).text()
        couleur = $(this).data("couleur")
        valeur = $(this).data("valeur")
        tags = $(this).data("tags").split(/[ ,]+/)
        switch conjonction
          when "et"
            ok = true
            $( 'input:checkbox:checked[data-couleur]' ).each ->
              ok = false if (couleur is not $(this).data("couleur"))
            $( 'input:checkbox:checked[data-valeur]' ).each ->
              ok = false if (valeur is not $(this).data("valeur"))
            $( 'input:checkbox:checked[data-tags]' ).each ->
              ok = false if ($(this).data("tags") not in tags)
          when "ou"
            ok = false
            $( 'input:checkbox:checked[data-couleur]' ).each ->
              ok = true if (couleur is $(this).data("couleur"))
              #alert $(this).data("couleur")
            $( 'input:checkbox:checked[data-valeur]' ).each ->
              ok = true if (valeur is $(this).data("valeur"))
            $( 'input:checkbox:checked[data-tags]' ).each ->
              ok = true if ($(this).data("tags") in tags)
          else
            alert "A"
        if ok
          found++ 
        else
          found--
      $("#progressbar").progressbar
        value: 100*found/casFavorables
      
      
      $(".listeEventualites").text liste
      if found != casFavorables
        $(".diagnostic").text "ne correspond pas encore"
      else
        $(".diagnostic").text "correspond"
 
      