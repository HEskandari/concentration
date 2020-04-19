--[[
    Represents a card game
]]

Game = Class{}

function Game:init()
    self.cards = {}
    self.board = GameBoard(2, 6, d)
    self.stack = Stack:Create()
    self.cardTimer = 0

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
            self:updateCardsStatus()
            self:selectCard(card)
        end
    end
end

function Game:selectCard(card)
    Card:flip(card)

    if(self.stack:getn() < 2) then
        self.stack:push(card)
    end

    if(self.stack:getn() == 2) then
        local first = self.stack:pop()
        local second = self.stack:pop()

        if(Card:matches(first, second)) then
            first:allowFlip(false)
            second:allowFlip(false)
        else
            self.resetUnmatched = true
        end
    end
end

function Game:updateCardsStatus()
    if(self.resetUnmatched == true) then
        for k,card in pairs(self.cards) do
            if(card.flipped == true) then
                Card:flip(card)
            end
        end
        self.resetUnmatched = false
    end
end

function Game:update(dt)
    self.cardTimer = self.cardTimer + dt
    if(self.cardTimer > 2) then
        self.cardTimer = 0
        self:updateCardsStatus()
    end
end

function Game:render()
    for k,card in pairs(self.cards) do
        card:render()
    end
end

function Game:start()
    for k,card in pairs(self.cards) do
        self.board:position(card)
    end
end