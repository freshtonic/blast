# depends: base_ship

Body = Matter.Body

class @EnemyShip extends @BaseShip

  load: (data) ->
    Body.translate @body,
      x: data.position.x - @body.position.x
      y: data.position.y - @body.position.y
    Body.rotate @body, data.angle - @body.angle
    @body.velocity = data.velocity
