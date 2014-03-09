# depends: base_ship

class @PlayerShip extends @BaseShip

  update: (game) ->
    @firePrimary(game) if game.input.actions.primary
    @thrust(game) if game.input.actions.thrust
    @turnRight() if game.input.actions.right
    @turnLeft() if game.input.actions.left
    super
