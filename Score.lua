--[[
    Score class
]]

Score = Class{}

function Score:init(game)
    self.game = game
    self.userScore = 0
    self.attempts = 0
end

function Score:update(num)
    self.attempts = self.attempts + 1
    if(self.userScore + num >= 0) then
        self.userScore = self.userScore + num
    end
end

function Score:render()
    love.graphics.setFont(gFonts['score'])
    love.graphics.printf('Score: '..self.userScore, 10, 10, BOARD_VIRTUAL_WIDTH, 'left')
    
    if(self.game.finished == true) then
        local msgFont = gFonts['message']
        local congrats = 'Congratulations! You finished in '..self.attempts..' tries.'
        local startx = BOARD_START_X
        local starty = BOARD_VIRTUAL_HEIGHT + msgFont:getHeight() + 20
        local width = BOARD_VIRTUAL_WIDTH

        love.graphics.setFont(msgFont)
        love.graphics.printf(congrats, startx, starty, width, 'center')

        starty = starty + msgFont:getHeight()
        love.graphics.printf("Press SPACE to start a new game", startx, starty, width, 'center')
    end
end
