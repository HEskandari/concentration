
require 'dependencies'

function love.load()
    love.window.setTitle("Board Games")

    love.window.setMode(1080, 720, {
        fullscreen = false,
        resizable = false
    })

    math.randomseed(os.time())

    gDeck = Deck()
    gDeck:shuffle()
    --gDeck:layout()

    game = Game()
    game:start()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
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



