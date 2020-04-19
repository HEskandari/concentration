--[[
    A class representing a deck of cards
]]

Deck = Class{}

function Deck:init()
    cards = {}
    self.shuffledDeck = {}

    local count = 1
    
    for i=1,13 do
        table.insert(cards, count, Card('diamonds', i))
        count = count + 1
    end

    for i=1,13 do
        table.insert(cards, count, Card('spades', i))
        count = count + 1
    end

    for i=1,13 do
        table.insert(cards, count, Card('hearts', i))
        count = count + 1
    end

    for i=1,13 do
        table.insert(cards, count, Card('clubs', i))
        count = count + 1
    end
end

function Deck:shuffle()
    for i, v in ipairs(cards) do
	    local pos = math.random(1, #self.shuffledDeck+1)
	    table.insert(self.shuffledDeck, pos, v)
    end
end

function Deck:layout()
    local posx = 100;
    local posy = 100;
    local row = 1;

    for k,card in pairs(self.shuffledDeck) do
        card:position(posx,posy)
        posx = posx + 50
        if(posx > WINDOW_WIDTH) then
            posx = 0
            posy = posy + 200
        end
    end
end

function Deck:update(dt)
    
end
