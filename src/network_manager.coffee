class @NetworkManager

  constructor: ->
    @socket = io.connect('//'+location.host)
    @data = {}

    @socket.on 'state', (data) =>
      @data[data.id] = data

    @socket.on 'disconnect', (id) =>
      @data[id] = null

  update: (data) ->
    @socket.emit 'state', data.serialize()
