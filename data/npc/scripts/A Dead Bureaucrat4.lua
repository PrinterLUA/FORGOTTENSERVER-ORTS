local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local config = {
	[1] = "S O R C E R E R",
	[2] = "D R U I D",
	[3] = "P A L A D I N",
	[4] = "K N I G H T"
}

local function greetCallback(cid)
	npcHandler:setMessage(MESSAGE_GREET, "Hello " .. (Player(cid):getSex() == 0 and "beautiful lady" or "handsome gentleman") .. ", welcome to the atrium of Pumin's Domain. We require some information from you before we can let you pass. Where do you want to go?")
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local vocationId = getBaseVocation(player:getVocation():getId())

	if msgcontains(msg, "pumin") then
		if player:getStorageValue(Storage.pitsOfInferno.Pumin) == 4 then
			player:setStorageValue(Storage.pitsOfInferno.Pumin, 5)
			npcHandler:say("I'm not sure if you know what you are doing but anyway. Your name is?", cid)
		end
	elseif msgcontains(msg, player:getName()) then
		if player:getStorageValue(Storage.pitsOfInferno.Pumin) == 5 then
			player:setStorageValue(Storage.pitsOfInferno.Pumin, 6)
			npcHandler:say("Alright " .. player:getName() ..". Vocation?", cid)
		end
	elseif msgcontains(msg, Vocation(vocationId):getName()) then
		if player:getStorageValue(Storage.pitsOfInferno.Pumin) == 6 then
			player:setStorageValue(Storage.pitsOfInferno.Pumin, 7)
			npcHandler:say(config[vocationId] .. ", is that right?! What do you want from me?", cid)
		end
	elseif msgcontains(msg, "356") then
		if player:getStorageValue(Storage.pitsOfInferno.Pumin) == 7 then
			player:setStorageValue(Storage.pitsOfInferno.Pumin, 8)
			npcHandler:say("Sorry, you need Form 145 to get Form 356. Come back when you have it", cid)
		if player:getStorageValue(Storage.pitsOfInferno.Pumin) == 23 then
			player:setStorageValue(Storage.pitsOfInferno.Pumin, 24)
			npcHandler:say("You are better than I thought! Congratulations, here you are: Form 356!", cid)
		end
	elseif msgcontains(msg, "hi") then
		if player:getStorageValue(Storage.pitsOfInferno.Pumin) == 22 then
			player:setStorageValue(Storage.pitsOfInferno.Pumin, 23)
			npcHandler:say("Hey! You are back!! How can I help you this time?", cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye and don't forget me!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and don't forget me!")
npcHandler:addModule(FocusModule:new())
