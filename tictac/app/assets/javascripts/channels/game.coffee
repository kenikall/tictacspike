App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    $('status').html("waiting for another player")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    switch data.action
      when "gmae_start"
        $('#status').html("Player found")
        App.gmaePlay = new Game ('#gmae-container', data.msg)

      when "take_turn"
        App.gamePlay.newGame()

      when "new_game"
        App.gamePlay.newGame()

      when "opponent_withdraw"
        $('#status').html("Oppoent withdraw, You win!")
        $('#new-match').removeClass('hidden');

    take_turn: (move) ->
      @perform 'take_turn', data: move

    new_game: () ->
    @perform 'new_game'
