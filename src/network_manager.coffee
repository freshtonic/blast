class @NetworkManager

  constructor: ->
    socket = io.connect('//'+location.host)

    socket.on 'ship', (data) ->
      console.log data

    socket.emit 'ship',
      coords: [0, 0]
      vector: [100, 100]
