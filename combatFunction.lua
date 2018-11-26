local addOn, addOnTable = ...

-- Variable Definitions
-----------------------
local events = {}

-- Function Definitions
-----------------------
function events:PLAYER_ENTER_COMBAT(...)
  local instanceInfo = {}
  local instanceName, _, _, instanceDifficultyName = GetInstanceInfo()
  -- Check instance
  if instanceName == "Siege of Boralus" then
    if instanceDifficultyName == "Mythic" then
      -- Check if Stand By Me is completed
      _, achivementName, _, completed = GetAchievementInfo(12727)
      if completed then
        print(achivementName .. " has been completed. Congratulations.")
      else
        print(achivementName .. " has NOT been completed.")
      end
    else
      return "Not in Mythic difficulty. Achivements cannot be earned."
    end
  end
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
      print("You are in " .. instanceName)
      break
    end
  end

  if foundDungeon then
    print("You have entered" .. instanceName)
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
