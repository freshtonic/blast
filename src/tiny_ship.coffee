
# depends: ship
# depends: tiny_ship_scene_model

class @TinyShip extends Ship
  constructor: ->
    @sceneModel = new TinyShipSceneModel()

