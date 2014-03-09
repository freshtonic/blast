class @NetworkManager

  constructor: ->
    @socket = io.connect('//'+location.host)
    @data = {}

    @socket.on 'state', (data) =>
      @data[data.id] = data

  update: (data) ->
    @socket.emit 'state', data.serialize()
