--[[
    Game board settings
]]

GameBoard = Class{}

function GameBoard:init(rows, cols, deck)
    self.rows = rows
    self.cols = cols
    self.deck = deck
    self.cardMargin = 25
    self.count = 0
    self.currentRows = 0
    self.currentCols = 0
    self.x = self:getStartX()
    self.y = self:getStartY()
end

function GameBoard:getStartX()
    return 100
end

function GameBoard:getStartY()
    return 170
end

function GameBoard:position(card)
    self.count = self.count + 1

    if(self.count > 1) then
        self.x = self.x + card.width + self.cardMargin

        if(self.count == 7) then
            self.x = self:getStartX()
            self.y = self:getStartY() + card.height + self.cardMargin
        end
    end

    card:position(self.x, self.y)
end