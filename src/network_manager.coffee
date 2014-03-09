class @NetworkManager

  constructor: ->
    @socket = io.connect('//'+location.host)
    @data = null

    @socket.on 'state', (data) =>
      @data = data

  update: (data) ->
    @socket.emit 'state', data.serialize()
