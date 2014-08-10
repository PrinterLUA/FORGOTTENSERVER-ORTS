local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end

local rnd_sounds = 0
function onThink()
	if rnd_sounds < os.time() then
		rnd_sounds = (os.time() + 5)
		if math.random(100) < 25 then
			Npc():say("Now, where was I...", TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	local player = Player(cid)
	-- GREET
	if msg == "DJANNI'HAH" and not npcHandler:isFocused(cid) then
		if player:getStorageValue(Factions) > 0 then
			npcHandler:addFocus(cid)
			if player:getStorageValue(GreenDjinn.MissionStart) < 1 or not BlueOrGreen then
				npcHandler:say("Hey! A human! What are you doing in my kitchen, " .. player:getName() .. "?", cid)
				npcHandler:addFocus(cid)
			end
		end
	end
	-- GREET
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, "mission") then
		if player:getStorageValue(BlueDjinn.MissionStart) == 1 and player:getStorageValue(BlueDjinn.MissionStart+1) < 1 then
			npcHandler:say({"My collection of recipes is almost complete. There are only but a few that are missing. ...",
							"Mmmm... now that we talk about it. There is something you could help me with. Are you interested?"}, cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "cookbook") then
		if player:getStorageValue(BlueDjinn.MissionStart+1) == 2 then
			npcHandler:say("Do you have the cookbook of the dwarven kitchen with you? Can I have it?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say({"Fine! Even though I know so many recipes, I'm looking for the description of some dwarven meals. ...",
							"So, if you could bring me a cookbook of the dwarven kitchen I will reward you well."}, cid)
			npcHandler.topic[cid] = 0
			player:setStorageValue(BlueDjinn.MissionStart+1, 1)
		elseif npcHandler.topic[cid] == 2 then
			if player:removeItem(2347, 1) then
				npcHandler:say({"The book! You have it! Let me see! <browses the book> ...",
								"Dragon Egg Omelette, Dwarven beer sauce... it's all there. This is great! Here is your well-deserved reward. ...",
								"Incidentally, I have talked to Fa'hradin about you during dinner. I think he might have some work for you. Why don't you talk to him about it?"}, cid)
				player:setStorageValue(BlueDjinn.MissionStart+1, 3)
				player:addItem(2146, 3)
				npcHandler.topic[cid] = 0
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye. I am sure you will come back for more. They all do.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Goodbye. I am sure you will come back for more. They all do.")
npcHandler:addModule(FocusModule:new())
