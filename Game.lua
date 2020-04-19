--[[
    Represents a card game
]]

Game = Class{}

function Game:init()
    self.cards = {}
    self.score = Score(self)
    self.board = GameBoard(2, 6, d)
    self.stack = Stack:Create()
    self.matches = 0
    self.finished = false
    self:setupDeck()
    self:shuffle(self.cards)
end

function Game:setupDeck()
    for i=1,6 do
        local card = gDeck.shuffledDeck[i]
        local match = card:copy()
        table.insert(self.cards, card) --first card
        table.insert(self.cards, match) --matching card
    end
end

function Game:shuffle(cards)
    local iterations = #cards
    local j

    for i = iterations, 2, -1 do
        j = math.random(i)
        cards[i], cards[j] = cards[j], cards[i]
    end
end

function Game:mousepressed(x, y)
    for k,card in pairs(self.cards) do
        if(x > card.x and x < card.x + card.width and
           y > card.y and y < card.y + card.height) then
            self:checkMatches()
            self:selectCard(card)
        end
    end
end

function Game:selectCard(card)
    Card:flip(card)

    if(self.stack:getn() < 2) then
        self.stack:push(card)
    end
end

function Game:checkFinished()
    if(self.matches == #self.cards / 2) then
        self.finished = true
    end
end

function Game:checkMatches()
    if(self.stack:getn() == 2) then
        local first = self.stack:pop()
        local second = self.stack:pop()

        if(Card:matches(first, second)) then
            first:allowFlip(false)
            second:allowFlip(false)
            self.score:update(1)
            self.matches = self.matches + 1
        else
            Timer.after(1, function() 
                Card:flip(first)
                Card:flip(second)
                self.score:update(-1)
            end)
        end
    end
end

function Game:update(dt)
    self:checkMatches()
    self:checkFinished()
    Timer.update(dt)
end

function Game:render()
    for k,card in pairs(self.cards) do
        card:render()
    end
    self.score:render()
end

function Game:start()
    for k,card in pairs(self.cards) do
        card:allowFlip(true)
        self.board:position(card)        
    end
end