
# depends: scene_model

class @TinyShipSceneModel extends SceneModel
  constructor: ->
    @model = Bodies.polygon 0, 0, 3, 10

  render: (to) ->
