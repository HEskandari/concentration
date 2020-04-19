
require 'dependencies'

function love.load()
    love.window.setTitle("Board Games")

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false
    })

    math.randomseed(os.time())

    gDeck = Deck()
    newGame()
end

function newGame()
    if(game == nill or game.finished == true) then
        gDeck:shuffle()
        game = Game()
        game:start()
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'space' then
        newGame()
    end
end

function love.mousepressed(x, y, button)
    game:mousepressed(x,y)
end


function love.update(dt)
    Lovebird:update()
    game:update(dt)
end


function love.draw()
    game:render();
end



