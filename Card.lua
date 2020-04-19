--[[
    A class representing a card object
]]

Card = Class{}


function Card:init(rank, suite)
    self.rank = rank
    self.suite = suite
    self.key = rank.."-"..suite
    self.frontImage = gCards[self.key]
    self.backImage = gCards['backside']
    self.image = self.backImage
    self.width = self.image:getWidth() * CARD_SIZE_FACTOR
    self.height = self.image:getHeight() * CARD_SIZE_FACTOR
    self.canFlip = true
    self.x = 0
    self.y = 0
end

function Card:copy()
    local copy = Card(self.rank, self.suite)
    copy.key = 'copy'..self.key
    copy.x = self.x
    copy.y = self.y
    return copy
end

function Card:position(x, y)
    self.x = x
    self.y = y
end

function Card:allowFlip(flip)
    self.canFlip = flip;
end

function Card:matches(first, second)
    return first ~= second and first.rank == second.rank and first.suite == second.suite
end

function Card:flip(card)
    if(card ~= nil and card.canFlip == true) then
        if(card.flipped == true) then
            card.flipped = false
            card.image = card.backImage
        else
            card.flipped = true
            card.image = card.frontImage
        end
    end
end

function Card:update(dt)

end

function Card:render()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.25, 0.25)
end