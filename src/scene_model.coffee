Body = Matter.Body

# The model is defined in the same units as we used in world coordinates, I.E,
# metres.
class @SceneModel

  constructor: (@mesh, @body) ->

  wrap: (axis) ->
    if @body.position[axis] < 500
      translation = x: 0, y: 0
      translation[axis] = 1000
      Body.translate(@body, translation)
    if @body.position[axis] > 500
      translation = x: 0, y: 0
      translation[axis] = -1000
      Body.translate(@body, translation)

  update: ->
    @wrap('x')
    @wrap('y')
    @mesh.position.set(@body.position.x, -@body.position.y, 0)
    @mesh.rotation.z = -@body.angle - Math.PI/2

