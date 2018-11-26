local addOn, addOnTable = ...

-- Variable Definitions
-----------------------
local events = {}

-- Function Definitions
-----------------------
function events:PLAYER_ENTER_COMBAT(...)
  print("Player ENTERED combat")
end

function events:PLAYER_LEAVE_COMBAT(...)
  print("Player LEFT combat")
end

function events:UPDATE_INSTANCE_INFO(...)
  print("You have entered an instance")
  -- Get instanceInfo
  local foundDungeon = false
  local instanceName, _, _, instanceDifficultyName = GetInstanceInfo()

  for i = 1 , table.getn(dungeonNames) do
    if instanceName == dungeonNames[i] then
      foundDungeon = true
      break
    end
  end

  if foundDungeon then
    print("You have entered " .. instanceName)
    for value = 2, table.maxn(dungeonAchievemnt[instanceName]), 2 do
      print(GetAchievementInfo(dungeonAchievemnt[instanceName][value]))
    end
  else
    print("I don't know where the fuck you are.")
  end

end

-- Event Handler
frame:SetScript("OnEvent", function(self, event, ...)
  events[event](self, ...);
end);

-- Registering Events
---------------------
-- 'frame' declared in main.lua
for eventName, eventId in pairs(events) do
  frame:RegisterEvent(eventName)
end
