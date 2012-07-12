String::leftPad = (size) ->
 s = @
 while s.length < size
   s = " #{s}"
 s

$ ->
	$('.card').data('current', ' ').data('target', ' ')
	$cards = []
	$('.card').each (index, el) ->
		$cards[el.id] = $(el)
	
	flip = ->
		card = $cards[this.id]
		
		# finish up from last animation cycle
		targetClass = if card.hasClass('forwards') then '.low' else '.high'
		card.children(targetClass).html card.data('current')
		card.removeClass('flip forwards backwards')
		
		# do another cycle if needed
		unless card.data('current') is card.data('target')
		
			currentCode = card.data('current').charCodeAt()
			targetCode = card.data('target').charCodeAt()
			
			if currentCode < targetCode
				# forwards
				direction = 'forwards'
				newValue = String.fromCharCode(currentCode + 1)
				targetClass = 'high'
			else
				# backwards
				direction = 'backwards'
				newValue = String.fromCharCode(currentCode - 1)
				targetClass = 'low'
			
			setTimeout ->
				card.children('.' + targetClass).html(newValue)
				card.addClass('flip ' + direction)
				card.data('current', newValue)
			, 27
	
	$('.card').bind('webkitAnimationEnd', flip)

	ws = new WebSocket("ws://localhost:8080")

	ws.onmessage = (evt) ->
		newValue = evt.data.toUpperCase().leftPad(10)
		values = (char for char in newValue)
		$('.card').each (index, el) ->
			el = $(el)
			el.data('target', values[index])
			el.trigger('webkitAnimationEnd') unless el.hasClass('flip')