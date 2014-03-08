var express = require('express');
var app = express(),
    server = require('http').createServer(app),
    io = require('socket.io').listen(server);

app.use(express.static(__dirname));
app.use('dist', express.static(__dirname + '/dist'));
app.use('vendor', express.static(__dirname + '/vendor'));

server.listen(3000);

io.sockets.on('connection', function (socket) {
  socket.on('state', function (data) {
    for (sid in io.sockets.sockets) {
      if (socket.id != sid) {
        io.sockets.socket(sid, false).emit('state', data);
      }
    }
  });
});
