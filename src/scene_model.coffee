
# The model is defined in the same units as we used in world coordinates, I.E,
# metres.
class @SceneModel

  constructor: (@mesh, @body) ->

  update: ->
    @mesh.position.set(@body.position.x, -@body.position.y, 0)
    @mesh.rotation.z = -@body.angle - Math.PI/2
