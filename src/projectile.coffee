Body = Matter.Body
Bodies = Matter.Bodies

class @Projectile

  constructor: (pos, force) ->
    @body = Bodies.circle pos.x, pos.y, 5
    @body.owner = @
    Body.applyForce(@body, {x: 0, y: 0}, force)
    particleGeometry = new THREE.CubeGeometry(5, 5, 5)
    mat = new THREE.MeshLambertMaterial(color: 0xffff00, ambient: 0x33ff00)
    @mesh = new THREE.Mesh(particleGeometry, mat)

  explode: (game) ->
    return if @dead
    @dead = true
    game.partical.explode(toThreeVector(@body.position), new THREE.Color(0xdd380c))
    game.remove(@)
    game.playSound 'hit'
