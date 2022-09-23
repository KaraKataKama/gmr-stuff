---VERSION v1.0.0
---Just drop this file in your project, and hopefully your IDE will use it as source for quick advices
---(or how to proper name it)
---
---This doc is not finished, i just gather all info about functions and tables from GMR, and make that doc. Feel free
---to make a pull request to add more info

---@class GMR
---@field Questing GMR.Questing
GMR = {}

function GMR.AIRespondTo() end
---@param id number quest id
---@return void
function GMR.AbandonQuest(id) end
function GMR.AcceptQuest() end
function GMR.AcceptTrade() end
function GMR.AddMessage() end
function GMR.AllowChat() end
function GMR.AllowSpeedUp() end
function GMR.AmmoExists() end
function GMR.AnnouncementProfile() end
function GMR.ApplyFishingLure() end
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return boolean Wether first and second position are in line of sight
function GMR.ArePositionsInLoS(x1, y1, z1, x2, y2, z2) end
function GMR.AscendStop() end
function GMR.AvoidUnit() end
function GMR.BattlegroundHandler() end
function GMR.BindHearthstone() end
---@param guid string object's GUID
---@return void
function GMR.BlacklistGUID(guid) end
---@param id number object Id
---@return void
function GMR.BlacklistId(id) end
function GMR.BlacklistSetNode() end
function GMR.BuildingHandler() end
function GMR.BuyAmmo() end
function GMR.BuyGoods() end
function GMR.BuyItemWithId() end
function GMR.ByteToChinese() end
function GMR.CCUnit() end
function GMR.CallPet() end
function GMR.CallbackObjects() end
function GMR.CanJoinBattlefield() end
---@param spell string
---@return void
function GMR.CancelBuff(spell) end
function GMR.CancelPendingSpell() end
function GMR.CancelUnitBuff() end
---Cast a spell
---@param spell string
---@param unit string|userdata
---@return void
function GMR.Cast(spell, unit) end
---Cast aoe (with zone) spell
---@param spell string
---@param unit string|userdata
---@return void
function GMR.CastAoE(spell, unit) end
function GMR.CastId() end
function GMR.CastMaxRank() end
function GMR.CastRacialSpell() end
function GMR.CastShapeshift() end
function GMR.CastSpellByName() end
function GMR.CastWithBeat() end
function GMR.CheckInLoS() end
function GMR.ChineseToByte() end
function GMR.CircleAroundCursor() end
function GMR.ClassTrainerHandler() end
function GMR.ClearFocus() end
function GMR.ClearInvalidUnstuckEntries() end
function GMR.ClearTarget() end
function GMR.ClickChatTab1() end
function GMR.ClickGossipButton() end
function GMR.ClickPosition() end
function GMR.ClickQuestButton() end
function GMR.CloseDropDownMenus() end
function GMR.CombatRotation() end
function GMR.CombatRotationToggle() end
function GMR.CombatStrafe() end
function GMR.CompleteObjectiveTrackerQuest() end
function GMR.CompleteQuest() end
function GMR.Conjure() end
function GMR.ConnectMapZones() end
function GMR.ConnectProfiles() end
function GMR.ConvertQuests() end
function GMR.CopyToClipboard() end
function GMR.CreateCenter() end
function GMR.CreateCenters() end
function GMR.CreateDirectory() end
function GMR.CreateDungeonTimer() end
function GMR.CreateFlightPath() end
function GMR.CreateGryphonMasterTimer() end
function GMR.CreateTableEntry() end
function GMR.CustomCombatConditions() end
function GMR.CustomPathHandler() end
function GMR.Debug() end
function GMR.DebugActions() end
function GMR.DebugEmptyQuestFrame() end
function GMR.DebugLoader() end
function GMR.DebugLootWindow() end
function GMR.DebugOpenedFrames() end
function GMR.DebugQuestFrame() end
function GMR.DefenseWhileRunning() end
---Defines an ammo vendor for a profile
---@param x number
---@param y number
---@param z number
---@param id number Vendor ID
---@return void
function GMR.DefineAmmoVendor(x, y, z, id) end
---Defines a blacklist to avoid objects at a given position within a given radius
---@param x number
---@param y number
---@param z number
---@param radius number
---@return void
function GMR.DefineAreaBlacklist(x, y, z, radius) end
function GMR.DefineBattlegroundMap() end
function GMR.DefineBlacklistItem() end
function GMR.DefineBuilding() end
function GMR.DefineClickedDungeonObject() end
---Defines a custom object to collect
---@param id number Object Id
---@return void
function GMR.DefineCustomObjectId(id) end
function GMR.DefineExecuteStep() end
---Defines a goods vendor for a profile
---@param x number
---@param y number
---@param z number
---@param id number Vendor Id
---@return void
function GMR.DefineGoodsVendor(x, y, z, id) end
function GMR.DefineGryphonMaster() end
---Defines an Innkeeper for a profile
---@param x number
---@param y number
---@param z number
---@param id number Innkeeper ID
---@return void
function GMR.DefineHearthstoneBindLocation(x, y, z, id) end
function GMR.DefineInterzonePath() end
---Defines a hardcoded path to a mailbox
---@param x number
---@param y number
---@param z number
---@return void
function GMR.DefineMailboxPath(x, y, z) end
function GMR.DefineMailingItem() end
function GMR.DefineMeshAreaBlacklist() end
function GMR.DefineMeshPathIndex() end
---Defines the next profile being loaded automatically under certain conditions
---Example: GMR.DefineNextProfile("Northshire 3-6", "Grinding", 3)
---@param profileName string The name of the next profile
---@param profileType string The type of the next profile (Grinding, Herbalism, Mining, Skinning, Fishing, Minutes)
---@param value number Threshold
---@return void
function GMR.DefineNextProfile(profileName, profileType, value) end
function GMR.DefineNextQuester() end
---Defines a center for a profile at given coordinates
---@param x number
---@param y number
---@param z number
---@param radius number Radius around x, y, z
---@return void
function GMR.DefineProfileCenter(x, y, z, radius) end
---@param continent string The profiles continent (Kalimdor, Eastern Kingdoms, Outland, ...)
---@return void
function GMR.DefineProfileContinent(continent) end
---Defines a profile enemy mob
---@param id number The enemy mobs id
---@return void
function GMR.DefineProfileEnemyId(id) end
function GMR.DefineProfileJump() end
---@param x number
---@param y number
---@param z number
---@return void
function GMR.DefineProfileMailbox(x, y, z) end
---Defines a profile name
---@param name string
---@return void
function GMR.DefineProfileName(name) end
---Defines a profile type
---@param profileType string The profiles type (Grinding, Gathering, Dungeon, ..)
function GMR.DefineProfileType(profileType) end
---@return void
function GMR.DefineQuest(race, class, questId, questName, questType, pickupX, pickupY, pickupZ, pickupId, turninX,
						 turninY, turninZ, turninId, questInfo, profileData, questRewards, isRepeatable) end
---Defines a quest enemy mob
---@param id number The enemy mobs id
---@return void
function GMR.DefineQuestEnemyId(id) end
function GMR.DefineQuestId() end
function GMR.DefineQuestMob() end
---@param questerName string
---@param quests any @?????
---@return void
function GMR.DefineQuester(questerName, quests) end
function GMR.DefineQuestingIndex() end
---Defines a repair vendor for a profile
---@param x number
---@param y number
---@param z number
---@param id number Vendor ID
---@return void
function GMR.DefineRepairVendor(x, y, z, id) end
---Defines a sell vendor for a profile
---@param x number
---@param y number
---@param z number
---@param id number Vendor ID
---@return void
function GMR.DefineSellVendor(x, y, z, id) end
---@param state any @???
---@param setting any @???
function GMR.DefineSetting(state, setting) end
---@param state any @????
---@param settings any @????
---@return void
function GMR.DefineSettings(state, settings) end
---Defines a blacklist to avoid objects at a given position within a given radius for a given time
---Example: GMR.DefineTempAreaBlacklist(1, 2, 3, 10, GetTime()+60)
---@param x number
---@param y number
---@param z number
---@param radius number The blacklists radius in yards
---@param timer number The blacklists expiration in seconds
---@return void
function GMR.DefineTempAreaBlacklist(x, y, z, radius, timer) end
function GMR.DefineUnstuck() end
function GMR.DefineUnstuckRoad() end
---Defines a hardcoded path to a vendor
---@param vendorType string The vendor type (Goods, Sell, Repair, Ammo)
---@param x number
---@param y number
---@param z number
---@return void
function GMR.DefineVendorPath(vendorType, x, y, z) end
---@param name string
---@param faction string
---@param execution any @????
---@return any @????
function GMR.DefineVendors(name, faction, execution) end
function GMR.DeleteCursorItem() end
function GMR.DeleteItems() end
function GMR.DenyChat() end
function GMR.DenySpeedUp() end
function GMR.DeobfuscateString() end
function GMR.DeobfuscateUnitPosition() end
function GMR.Descend() end
function GMR.DescendStop() end
function GMR.DestroyMaxCountItems() end
function GMR.DirectoryExists() end
function GMR.DisableFlying() end
function GMR.DisableUnstuck() end
function GMR.DiscoverFlightmaster() end
function GMR.DisenchantHandler() end
function GMR.Dismount() end
function GMR.DismountForFlyingMount() end
function GMR.DistanceMovement() end
function GMR.Drink() end
function GMR.DropItemOnUnit() end
function GMR.DropdownHandler() end
function GMR.EagleEyeXYZ() end
function GMR.Eat() end
function GMR.EnableUnstuck() end
---@param str string
---@return string
function GMR.Encode(str) end
function GMR.EndQuest() end
function GMR.EnemyMovement() end
function GMR.EngageMeshTo() end
---GMR starts executing
---@return void
function GMR.Execute() end
function GMR.ExecutePath() end
function GMR.ExecuteStringAfter() end
---@param fileName string fileName to save
function GMR.ExportSettings(fileName) end
---@param x number
---@param y number
---@param z number
---@return void
function GMR.FaceDirection(x, y, z) end
function GMR.FaceMeshPoint() end
function GMR.FaceSmoothly() end
function GMR.Fight() end
function GMR.FindMob() end
function GMR.FindObject() end
function GMR.FindString() end
function GMR.FishingHandler() end
function GMR.FlagObjectId() end
function GMR.FlagRepeatableQuestComplete() end
function GMR.FocusUnit() end
function GMR.FollowUnit() end
function GMR.ForceMovement() end
function GMR.ForceProfileValidation() end
function GMR.ForceQuit() end
function GMR.ForceReload() end
function GMR.FrameTextExists() end
function GMR.GenerateSafePosition() end
function GMR.GetAccountId() end
function GMR.GetAddOnName() end
---@param object userdata The object you want to check
---@return number range
function GMR.GetAggroRange(object) end
function GMR.GetAmmoType() end
function GMR.GetAnglePercentageBetween() end
function GMR.GetAnglePercentageBetweenObjects() end
function GMR.GetAngles() end
---@param object1 string|userdata
---@param object2 string|userdata
---@return number The angles between object1 and object2
function GMR.GetAnglesBetweenObjects(object1, object2) end
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return number The angles between first and second position
function GMR.GetAnglesBetweenPositions(x1, y1, z1, x2, y2, z2) end
function GMR.GetArrivalDistance() end
function GMR.GetAssistDistance() end
---@return userdata The closest object (Unlocker specific) attacking the player
function GMR.GetAttackingEnemy() end
function GMR.GetAverageProfileZ() end
function GMR.GetBandage() end
function GMR.GetBattlefieldStatus() end
function GMR.GetBattlegroundCondition() end
function GMR.GetBattlegroundInfo() end
function GMR.GetBattlegroundName() end
function GMR.GetBattlegroundTypeButton() end
---@param unit string|userdata
---@param spell string
function GMR.GetBuffExpiration(unit, spell) end
function GMR.GetButtonTexture() end
function GMR.GetBuyOption() end
function GMR.GetCCUnit() end
function GMR.GetCameraPosition() end
---@return number The currently active center index
function GMR.GetCentralIndex() end
function GMR.GetCentralPoint() end
function GMR.GetCentralPoints() end
---@param unit string|userdata
function GMR.GetClass(unit) end
function GMR.GetClassQuestId() end
function GMR.GetClassTrainer() end
function GMR.GetClient() end
function GMR.GetClosestMeshPolygon() end
function GMR.GetClosestPointOnMesh() end
function GMR.GetClusterUnitPosition() end
function GMR.GetCombatItem() end
function GMR.GetCombatRange() end
function GMR.GetCombopointDropdownValue() end
---@param spell string
---@return number @????
function GMR.GetCombopointFilter(spell) end
function GMR.GetCondition() end
function GMR.GetConditionDropdownValue() end
function GMR.GetContainerItemCount() end
function GMR.GetContinentId() end
--- @return any @???
function GMR.GetCorpsePosition() end
function GMR.GetCredentials() end
function GMR.GetCripplingPoison() end
function GMR.GetCursorMapPosition() end
function GMR.GetCursorWorldPosition() end
function GMR.GetCustomObject() end
function GMR.GetDate() end
function GMR.GetDeadlyPoison() end
---@param unit string|userdata
---@param spell string
---@return number
function GMR.GetDebuffExpiration(unit, spell) end
function GMR.GetDelay() end
function GMR.GetDelayedQuestNpc() end
function GMR.GetDestGryphonMaster() end
function GMR.GetDestinationDistance() end
function GMR.GetDifference() end
function GMR.GetDirectoryFiles() end
function GMR.GetDiscordWebhook() end
function GMR.GetDiscoverFlightmasters() end
function GMR.GetDisenchantableItem() end
function GMR.GetDistance() end
---@param object1 string|userdata
---@param object2 string|userdata
---@return number The distance between object1 and object2
function GMR.GetDistanceBetweenObjects(object1, object2) end
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return number Distance between first and second position
function GMR.GetDistanceBetweenPositions(x1, y1, z1, x2, y2, z2) end
function GMR.GetDistanceMovement() end
function GMR.GetDistanceToPosition() end
function GMR.GetDistanceToQuestNpc() end
function GMR.GetDistancedPartymember() end
---@return string, boolean, number, number, number itemName, isDrinking, itemCount, containerSlot, bagSlot
function GMR.GetDrink() end
function GMR.GetDrinkingValue() end
function GMR.GetDrinksRebuyValue() end
function GMR.GetDungeonAccessStatus() end
function GMR.GetDungeonEntrance() end
function GMR.GetDungeonExit() end
function GMR.GetDungeonTimerExpiration() end
function GMR.GetDungeonTimers() end
function GMR.GetEatingValue() end
function GMR.GetEnchantingInfo() end
function GMR.GetEnemy() end
function GMR.GetExpansion() end
function GMR.GetExpirationDate() end
function GMR.GetFaction() end
function GMR.GetFactionInfo() end
function GMR.GetFactionQuestId() end
function GMR.GetFishingBobberInteractableFlag() end
function GMR.GetFishingInfo() end
function GMR.GetFishingLure() end
function GMR.GetFishingMainhandWeapon() end
function GMR.GetFishingOffhandWeapon() end
function GMR.GetFishingRod() end
function GMR.GetFishingStayPerCenter() end
function GMR.GetFlightForm() end
---@param startX number
---@param startY number
---@param startZ number
---@param destX number
---@param destY number
---@param destZ number
---@param adjust any @???
---@return any @???
function GMR.GetFlightPath(startX, startY, startZ, destX, destY, destZ, adjust) end
function GMR.GetFlyingMount() end
function GMR.GetFlyingMountingRange() end
---@param folder string
---@return table Contains all profiles of a given profile folder
function GMR.GetFolderProfiles(folder) end
---@return string, boolean, number, number, number itemName, isEating, itemCount, containerSlot, bagSlot
function GMR.GetFood() end
function GMR.GetFoodsRebuyValue() end
function GMR.GetGasCloud() end
function GMR.GetGatheringObject() end
function GMR.GetGhostPartyMember() end
function GMR.GetGround() end
function GMR.GetGroundMountingRange() end
---@param x number
---@param y number
---@param z number
---@return number Terrain z coordinate
function GMR.GetGroundZ(x, y, z) end
function GMR.GetGryphonMaster() end
function GMR.GetGryphonMasterXY() end
function GMR.GetHardcodedPath() end
function GMR.GetHealingUnit() end
---@param unit string|userdata
---@return number Unit's HP in percent (0-100)
function GMR.GetHealth(unit) end
---@param spell string
---@return number @????
function GMR.GetHealthFilter(spell) end
function GMR.GetHealthstoneCast() end
function GMR.GetHearthstoneBindLocation() end
function GMR.GetHearthstoneData() end
function GMR.GetHearthstoneOption() end
function GMR.GetHerbMinimumValue() end
function GMR.GetHerbalismInfo() end
function GMR.GetHighestDruidForm() end
function GMR.GetHitAbovePosition() end
function GMR.GetHitBetweenPositions() end
function GMR.GetHost() end
function GMR.GetHunterPetStatus() end
function GMR.GetImportableSettings() end
function GMR.GetInstantPoison() end
function GMR.GetInterruptCount() end
function GMR.GetInventorySpace() end
---@param itemId number
---@return number @????
function GMR.GetItemHealthFilter(itemId) end
function GMR.GetItemId() end
---@param itemId number
---@return number @????
function GMR.GetItemManaFilter(itemId) end
function GMR.GetItemTexture() end
function GMR.GetJunkItems() end
function GMR.GetKeepRunning() end
function GMR.GetLastWorldClickPosition() end
function GMR.GetLockpickingInfo() end
function GMR.GetLogoutTimerValue() end
function GMR.GetLootingDelay() end
function GMR.GetLootingObject() end
function GMR.GetMailbox() end
function GMR.GetMailboxData() end
function GMR.GetMailboxGoldKept() end
function GMR.GetMailboxGoldReceiver() end
function GMR.GetMailboxGoldSent() end
function GMR.GetMailboxPath() end
function GMR.GetMailingItems() end
---@param unit string|userdata
---@return number Unit's mana in percent
function GMR.GetMana(unit) end
---@param spell string
---@return number @????
function GMR.GetManaFilter(spell) end
function GMR.GetMapFromZoneId() end
function GMR.GetMapId() end
function GMR.GetMapZoneName() end
function GMR.GetMaximumLevel() end
function GMR.GetMaximumLevelState() end
function GMR.GetMaximumLevelValue() end
function GMR.GetMerchantAmmoIndex() end
function GMR.GetMerchantDrinkIndex() end
function GMR.GetMerchantFoodIndex() end
function GMR.GetMeshDestination() end
function GMR.GetMeshDistance() end
function GMR.GetMeshPointArrivalDistance() end
function GMR.GetMeshPoints() end
function GMR.GetMeshToDestination() end
function GMR.GetMinMoneyRequired() end
function GMR.GetMinimumInventorySpace() end
function GMR.GetMinimumLevel() end
function GMR.GetMinimumLevelDefault() end
function GMR.GetMinimumLevelState() end
function GMR.GetMinimumLevelValue() end
function GMR.GetMinimumMailingInventorySpace() end
function GMR.GetMiningInfo() end
function GMR.GetMode() end
function GMR.GetMount() end
function GMR.GetNearbyEnemy() end
---@param distance number
---@return table<string, GMR_Helper.Object> Map objectId to Object
function GMR.GetNearbyObjects(distance) end
function GMR.GetNearbyPosition() end
function GMR.GetNearestCentralPoint() end
function GMR.GetNearestMailboxPathPoint() end
function GMR.GetNearestObject() end
function GMR.GetNearestPartyPlayerCluster() end
function GMR.GetNearestTableEntry() end
function GMR.GetNearestVendorPathPoint() end
function GMR.GetNextCentralPoint() end
function GMR.GetNextQuest() end
function GMR.GetNextTalent() end
function GMR.GetNode() end
function GMR.GetNormalPositionFromPosition() end
function GMR.GetNumAmmo() end
---@param unit string|userdata
---@param distance number
---@return number
function GMR.GetNumAttackingEnemies(unit, distance) end
function GMR.GetNumBuyingAmmo() end
function GMR.GetNumBuyingDrinks() end
function GMR.GetNumBuyingFoods() end
function GMR.GetNumDrink() end
function GMR.GetNumDungeonTimers() end
---@param unit string|userdata
---@param distance number
---@return number
function GMR.GetNumEnemies(unit, distance) end
function GMR.GetNumEnemiesAtXYZ() end
function GMR.GetNumEnemyPlayersAroundPosition() end
function GMR.GetNumEnemyPlayersAroundUnit() end
function GMR.GetNumFood() end
function GMR.GetNumFreeTalents() end
function GMR.GetNumFriends() end
function GMR.GetNumPartyMembers() end
function GMR.GetNumPartyMembersAroundPosition() end
function GMR.GetNumPartyMembersAroundUnit() end
function GMR.GetNumQuests() end
function GMR.GetNumRunes() end
function GMR.GetNumSelectedBattlegroundsNotInQueue() end
---Return number of scanned enemies around player
---@return number
function GMR.GetNumSurroundingEnemies() end
function GMR.GetNumericDropdownValue() end
function GMR.GetObject() end
function GMR.GetObjectWithFlag() end
function GMR.GetObjectWithIndex() end
---Example: object = GetObjectWithInfo({ id = 123, rawType = 8, isAlive = true, inCombat = true, speed = 3 })
---@param object GMR_Helper.GetObjectWithInfo Contains filters to find specific objects
---@return table founded object
function GMR.GetObjectWithInfo(object) end
function GMR.GetObjectWithXYZ() end
function GMR.GetObstacleDistance() end
function GMR.GetOppositeFaction() end
function GMR.GetOreMinimumValue() end
function GMR.GetParty1Pointer() end
function GMR.GetParty2Pointer() end
function GMR.GetParty3Pointer() end
function GMR.GetParty4Pointer() end
function GMR.GetPartyBuff() end
function GMR.GetPartyBuffs() end
function GMR.GetPartyCorpsePosition() end
function GMR.GetPartyEnemy() end
function GMR.GetPartyHealer() end
function GMR.GetPartyHealerPointer() end
function GMR.GetPartyHealth() end
function GMR.GetPartyHealthOverall() end
function GMR.GetPartyLeader() end
function GMR.GetPartyLeaderXYZ() end
function GMR.GetPartyModeChannel() end
function GMR.GetPartyModeChannelIndex() end
---@param destX number
---@param destY number
---@param destZ number
---@param isHardcoded boolean
---@return any @???
function GMR.GetPath(destX, destY, destZ, isHardcoded) end
function GMR.GetPathBetweenPoints() end
function GMR.GetPercentDropdownValue() end
function GMR.GetPetFood() end
---@param spell string
---@return number @?????
function GMR.GetPetHealthFilter(spell) end
function GMR.GetPetPointer() end
function GMR.GetPickPocketWaypointIndex() end
function GMR.GetPitch() end
function GMR.GetPitchBetweenCoordinates() end
function GMR.GetPitchTurnDirection() end
function GMR.GetPitchTurningSpeed() end
---@return userdata Unlocker specific object
function GMR.GetPlayerAttackingEnemy() end
---The closest object attacking player
---@return userdata Unlocker specific object
function GMR.GetPlayerAttackingPlayer() end
function GMR.GetPlayerPointer() end
function GMR.GetPlayerPosition() end
function GMR.GetPositionAroundObjectOnCircle() end
function GMR.GetPositionBehindPlayer() end
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@param distance number
---@return number, number, number x, y, z of new position
function GMR.GetPositionBetweenPositions(x1, y1, z1, x2, y2, z2, distance) end
function GMR.GetPositionFromPosition() end
function GMR.GetPositionFromPositionInLoS() end
function GMR.GetPositionsBetweenPositions() end
---@param spell string
---@return number @???
function GMR.GetPowerFilter(spell) end
function GMR.GetProfessionInfo() end
function GMR.GetProfessionTrainer() end
function GMR.GetProfessions() end
function GMR.GetProfileContinentId() end
function GMR.GetProfileFolders() end
function GMR.GetProfileHearthstoneBindLocation() end
function GMR.GetProfileMailbox() end
---@return string profile name
function GMR.GetProfileName() end
---@return string profile type
function GMR.GetProfileType() end
function GMR.GetProfiles() end
function GMR.GetPullCount() end
function GMR.GetPulledEnemies() end
function GMR.GetPushoverKey() end
function GMR.GetPvPEnemy() end
function GMR.GetQuestButton() end
function GMR.GetQuestGossip() end
function GMR.GetQuestId() end
function GMR.GetQuestNpcIds() end
function GMR.GetQuestingIndex() end
function GMR.GetQuestingState() end
function GMR.GetRace() end
function GMR.GetRacialSpell() end
---@param unit string|userdata
---@return number unit's rage
function GMR.GetRage(unit) end
function GMR.GetRealTalentPosition() end
function GMR.GetRelogTimerValue() end
function GMR.GetRepairStatus() end
function GMR.GetRepairValue() end
function GMR.GetResurrectableMember() end
function GMR.GetResurrectingUnit() end
function GMR.GetSafePosition() end
function GMR.GetSavedEnemy() end
function GMR.GetSavedProfile() end
function GMR.GetSavedProfileFolder() end
function GMR.GetSavedProfileIndex() end
function GMR.GetSavedProfileType() end
function GMR.GetSavedQuester() end
function GMR.GetScanRadius() end
function GMR.GetSessionId() end
function GMR.GetSessionIndex() end
function GMR.GetShapeshift() end
function GMR.GetShapeshiftFormManaCosts() end
function GMR.GetShardDropdownValue() end
---@param spell string
---@return number @????
function GMR.GetShardsFilter(spell) end
function GMR.GetShutdownTimerValue() end
function GMR.GetSkinningDelay() end
function GMR.GetSkinningInfo() end
function GMR.GetSkinningObject() end
function GMR.GetSmoothPath() end
function GMR.GetSoulstoneCast() end
function GMR.GetSpecialization() end
function GMR.GetSpeedDistance() end
function GMR.GetSpellCooldown() end
---@param spell string
---@return number @????
function GMR.GetStackFilter(spell) end
function GMR.GetSubdirectories() end
function GMR.GetSurroundingWaterXYZ() end
function GMR.GetTexture() end
function GMR.GetThreat() end
function GMR.GetTime() end
function GMR.GetTradeRecipient() end
function GMR.GetTrainingOption() end
function GMR.GetTrainingSpell() end
function GMR.GetTrinketInfo() end
function GMR.GetTurnDirection() end
function GMR.GetTurningSpeed() end
function GMR.GetTurningSpeedExtra() end
function GMR.GetUnitDropdownValue() end
---@param spell string
---@return number @????
function GMR.GetUnitFilter(spell) end
function GMR.GetUnitSpeed() end
function GMR.GetUnitZoneId() end
function GMR.GetUnlocker() end
function GMR.GetUsableItem() end
function GMR.GetVehicleSpeed() end
function GMR.GetVendor() end
function GMR.GetVendorMode() end
function GMR.GetVendorPath() end
function GMR.GetWeaponDropdownValue() end
---@param spell string
---@return number @????
function GMR.GetWeaponFilter(spell) end
function GMR.GetWeaponStatus() end
function GMR.GetWhisperResponse() end
function GMR.GetWoWVisionToken() end
---@param mapId string
---@param x number
---@param y number
---@return any @???
function GMR.GetWorldPositionFromMap(mapId, x, y) end
function GMR.GetWowMapId() end
function GMR.GetX() end
function GMR.GetXYZ() end
function GMR.GetYawTurningSpeed() end
function GMR.GetZCoordinate() end
function GMR.GetZoneId() end
function GMR.GryphonMasterHandler() end
function GMR.GuidToLetter() end
function GMR.HandleCustomPath() end
---Check buff on unit. Buff from any source, it may be player, other players, npcs
---@param unit string|userdata
---@param buff string
---@param byPlayer boolean Wether the buff was casted by player or not
---@return boolean
function GMR.HasBuff(unit, buff, byPlayer) end
function GMR.HasBuffId() end
function GMR.HasBuffStacks() end
function GMR.HasColdWeatherFlying() end
---Check debuff on unit. Debuff from any source, it may be player, other players, npcs
---@param unit string|userdata
---@param debuff string
---@return boolean
function GMR.HasDebuff(unit, debuff) end
function GMR.HasDebuffStacks() end
function GMR.HasHerbalism() end
function GMR.HasManaGem() end
function GMR.HasMinimumSkillLevel() end
function GMR.HasMining() end
function GMR.HasMoney() end
function GMR.HasPetSacrificeBuff() end
---Check unit has player's buff
---@param unit string|userdata
---@param buff string
---@return boolean
function GMR.HasPlayerBuff(unit, buff) end
---Check unit has debuff, that belongs to player
---@param unit string|userdata
---@param debuff string
---@return boolean
function GMR.HasPlayerDebuff(unit, debuff) end
---Get stacks count of player's debuff on unit (?)
---(NEED TEST)
---@param unit string|userdata
---@param debuff string
---@return number count of stacks
function GMR.HasPlayerDebuffStacks(unit, debuff) end
function GMR.HasSkinning() end
function GMR.HasTalent() end
function GMR.HasToFight() end
function GMR.HasTotem() end
function GMR.HasVendorMount() end
function GMR.Heal() end
function GMR.HealthstoneExists() end
function GMR.HideErrors() end
function GMR.HideUnavailableTrainerSpells() end
---@param name string
function GMR.ImportSettings(name) end
---Wether a given unit is in combat or not [and being targeted or not]
---@param unit string|userdata
---@param isBeingTargeted boolean ether the unit is being targeted or not
---@return boolean
function GMR.InCombat(unit, isBeingTargeted) end
function GMR.InFrontOfCamera() end
---Wether unit and otherUnit are in line of sight
---@param unit string|userdata
---@param otherUnit string|userdata
---@return boolean
function GMR.InLoS(unit, otherUnit) end
function GMR.InMeeleRange() end
function GMR.Interact() end
function GMR.InteractObject() end
function GMR.InteractUnit() end
function GMR.InteractVendor() end
function GMR.IsAdmin() end
---@param unit string|userdata
---@return boolean
function GMR.IsAlive(unit) end
function GMR.IsAmmoBag() end
function GMR.IsAmmoEquipped() end
function GMR.IsAmmoItem() end
---@param spell string
---@param unit string|userdata
---@return boolean
function GMR.IsAoECastable(spell, unit) end
function GMR.IsArrayQuestComplete() end
function GMR.IsAttacking() end
function GMR.IsAttackingHealer() end
function GMR.IsAttackingLeader() end
function GMR.IsAvoidingPvP() end
function GMR.IsBandage() end
function GMR.IsBandaging() end
function GMR.IsBattlegroundChecked() end
function GMR.IsBattlegroundFinished() end
---Wether the position is temporary blacklisted or not
---@param x number
---@param y number
---@param z number
---@return boolean
function GMR.IsBlacklistedArea(x, y, z) end
function GMR.IsBlacklistedEnemyAttacking() end
function GMR.IsBlacklistedGUID() end
function GMR.IsBlacklistedId() end
function GMR.IsBlacklistedItem() end
function GMR.IsBlacklistedNode() end
function GMR.IsBuying() end
function GMR.IsCachedEnemyNearPosition() end
---Check is spell can be casted
---@param spell string
---@param unit string|userdata
---@param range number
---@param otherUnit string|userdata
---@param ignoreMana boolean
---@param ignoreCooldown boolean
---@param hasItem boolean
---@return boolean
function GMR.IsCastable(spell, unit, range, otherUnit, ignoreMana, ignoreCooldown, hasItem) end
function GMR.IsCastableDistance() end
function GMR.IsCasting() end
function GMR.IsCentralObject() end
function GMR.IsCentralPointInRange() end
function GMR.IsChecked() end
---@param itemId number
---@return boolean
function GMR.IsCheckedItem(itemId) end
---@param spell string
---@return boolean
function GMR.IsCheckedSpell(spell) end
function GMR.IsChineseChar() end
function GMR.IsClassTrainerNeeded() end
function GMR.IsCleansable() end
function GMR.IsClickedDungeonObject() end
function GMR.IsCombatStrafingAllowed() end
function GMR.IsConjurable() end
function GMR.IsConjuredItem() end
function GMR.IsConnectionPointReachable() end
function GMR.IsCustomObjectId() end
function GMR.IsCustomPathHandling() end
---@param unit string|userdata
---@return boolean
function GMR.IsDead(unit) end
function GMR.IsDeathSkipping() end
function GMR.IsDejunkActive() end
function GMR.IsDestInsideBuilding() end
function GMR.IsDisenchantingValid() end
---@param itemId number
---@return boolean
function GMR.IsDrinkable(itemId) end
---@param unit string|userdata
---@return boolean
function GMR.IsDrinking(unit) end
function GMR.IsDrowning() end
function GMR.IsDungeonCompleted() end
function GMR.IsDungeonProfile() end
---Wether the item is eatable or not
---@param itemId number
---@return boolean
function GMR.IsEatable(itemId) end
---@param unit string|userdata
---@return boolean
function GMR.IsEating(unit) end
function GMR.IsEnemyNearPosition() end
function GMR.IsEnemyWithIdAttacking() end
function GMR.IsEvadingEnemy() end
---Whether GMR is currently executing or not
---@return boolean
function GMR.IsExecuting() end
function GMR.IsFacingXYZ() end
function GMR.IsFactionNPC() end
function GMR.IsFishing() end
function GMR.IsFishingLureApplyable() end
function GMR.IsFlaggedObjectId() end
function GMR.IsFlamestrikeUsable() end
function GMR.IsFleeingEnemy() end
function GMR.IsFlightmasterDiscoverable() end
function GMR.IsFlyable() end
function GMR.IsFlyingDisabled() end
---@return boolean
function GMR.IsFullyLoaded() end
function GMR.IsGasCloud() end
---@param unit string|userdata
---@return boolean
function GMR.IsGhost(unit) end
function GMR.IsGossipButtonVisible() end
function GMR.IsGroundPosition() end
function GMR.IsGryphonMasterDenied() end
function GMR.IsGryphonMasterKnown() end
function GMR.IsGryphonMasterRequired() end
function GMR.IsGryphonMasterStored() end
function GMR.IsHealthPotion() end
function GMR.IsHearthstoneSetable() end
function GMR.IsHyperspawnFarming() end
function GMR.IsHyperspawnProfile() end
function GMR.IsIdling() end
function GMR.IsIgnoringCombat() end
function GMR.IsImmune() end
function GMR.IsInAuberdine() end
function GMR.IsInBaradinBay() end
function GMR.IsInBattleground() end
function GMR.IsInBattlegroundQueue() end
function GMR.IsInDarkmaulCitadel() end
function GMR.IsInDeeprunTramZone() end
function GMR.IsInLoadingScreen() end
function GMR.IsInNorthrend() end
function GMR.IsInPartyMode() end
function GMR.IsInVehicle() end
function GMR.IsInVendorMode() end
function GMR.IsInteractingWithTrainer() end
---@param unit string|userdata
---@return boolean
function GMR.IsInterruptable(unit) end
function GMR.IsInvalidMesh() end
function GMR.IsInvalidVendor() end
function GMR.IsItemDisenchantable() end
---Wether an item with itemId as ID exists in your bags or not
---@param itemId number
---@return boolean
function GMR.IsItemInBags(itemId) end
function GMR.IsLatinAlphabet() end
function GMR.IsLibDrawValid() end
function GMR.IsLoSMeshing() end
function GMR.IsLootedObject() end
function GMR.IsLooting() end
function GMR.IsMageInParty() end
function GMR.IsMailboxSet() end
function GMR.IsMailing() end
function GMR.IsMailingItem() end
function GMR.IsMailingWhitelisted() end
function GMR.IsManaPotion() end
function GMR.IsMapLoaded() end
function GMR.IsMassQuestId() end
function GMR.IsMeshAreaBlacklisted() end
function GMR.IsMeshLoaded() end
function GMR.IsMeshPointSkipable() end
function GMR.IsMountDenied() end
function GMR.IsMountStuck() end
function GMR.IsMountable() end
function GMR.IsMoving() end
function GMR.IsMovingValid() end
function GMR.IsNearDestination() end
function GMR.IsNearVendor() end
function GMR.IsNearVendorPath() end
function GMR.IsNearWaterSurface() end
function GMR.IsNodeInteractable() end
function GMR.IsNodeMaxGatheringRangeRequired() end
function GMR.IsObjectCreatureType() end
function GMR.IsObjectFleeing() end
function GMR.IsObjectFound() end
function GMR.IsObjectGatherable() end
function GMR.IsObjectIndoors() end
---@param object userdata
---@return boolean
function GMR.IsObjectInteractable(object) end
---@param object string|userdata
---@return boolean
function GMR.IsObjectLootable(object) end
function GMR.IsObjectPickPocketable() end
function GMR.IsObjectPosition(object) end
function GMR.IsObjectSet() end
---@param object string|userdata
---@return boolean
function GMR.IsObjectSkinnable(object) end
function GMR.IsObjectTapDenied() end
function GMR.IsObjectZValid() end
function GMR.IsOnExilesReachShip() end
function GMR.IsOnMeshPoint() end
function GMR.IsOutdoors() end
function GMR.IsPaidPack() end
function GMR.IsPartyAssistant() end
function GMR.IsPartyEnemy() end
function GMR.IsPartyGUID() end
function GMR.IsPartyLeaderInInstance() end
function GMR.IsPartyMember() end
function GMR.IsPartyMemberResurrectable() end
function GMR.IsPartyMissingGoods() end
function GMR.IsPartyPreparing() end
function GMR.IsPartyRecovering() end
function GMR.IsPartyTogether() end
function GMR.IsPathable() end
function GMR.IsPetDenied() end
function GMR.IsPetStarving() end
---Whether you are at x, y, z or not
---@param x number
---@param y number
---@param z number
---@param radius number
---@return boolean
function GMR.IsPlayerPosition(x, y, z, radius) end
function GMR.IsPlayerStealthed() end
function GMR.IsPlayerXY() end
---@param x number
---@param y number
---@param z number
---@return boolean
function GMR.IsPointInTheAir(x, y, z) end
---@param x number
---@param y number
---@param z number
---@return boolean
function GMR.IsPointUnderwater(x, y, z) end
function GMR.IsPoisonItem() end
function GMR.IsPositionBelowTerrain() end
function GMR.IsPositionInArea() end
function GMR.IsPositionInAuberdine() end
function GMR.IsPositionInDunMorogh() end
function GMR.IsPositionInLoS() end
function GMR.IsPositionInPolygon() end
function GMR.IsPositionInTeldrassil() end
function GMR.IsPositionInThunderBluff() end
function GMR.IsPositionOnMesh() end
function GMR.IsPreparing() end
function GMR.IsProwlCondition() end
---@param id number quest id
---@return boolean
function GMR.IsQuestActive(id) end
function GMR.IsQuestButtonVisible() end
---@param id number quest id
---@return boolean
function GMR.IsQuestCompletable(id) end
---@param id number quest id
---@return boolean
function GMR.IsQuestCompleted(id) end
function GMR.IsQuestEnemyId() end
function GMR.IsQuestEnemySet() end
function GMR.IsQuestTraveling() end
function GMR.IsQuesting() end
function GMR.IsRangedEquipped() end
function GMR.IsReadyToFly() end
function GMR.IsRecovering() end
function GMR.IsRefillDenied() end
function GMR.IsRepairing() end
function GMR.IsRepeatableQuestComplete() end
function GMR.IsRepopAllowed() end
function GMR.IsSelling() end
function GMR.IsShapeshiftable() end
function GMR.IsShapeshifted() end
---@param spell string
---@param unit string|userdata
---@return boolean
function GMR.IsShapeshiftedCastable(spell, unit) end
function GMR.IsShooting() end
function GMR.IsSkinnable() end
function GMR.IsSkinnedObject() end
function GMR.IsSpeedUpDenied() end
function GMR.IsSpellImmune() end
---@param spell string
---@param unit string|userdata
function GMR.IsSpellInRange(spell, unit) end
---@param spell string|number
---@return boolean
function GMR.IsSpellKnown(spell) end
function GMR.IsSpellTrainable() end
function GMR.IsSpellTraining() end
function GMR.IsSpellUsable() end
function GMR.IsStandingCentral() end
function GMR.IsStandingDistanced() end
function GMR.IsStealthCondition() end
function GMR.IsSummonedByPlayer() end
function GMR.IsTableEntry() end
function GMR.IsTableSortable() end
function GMR.IsTamingUnit() end
function GMR.IsTargetPosition() end
function GMR.IsTargetable() end
function GMR.IsTargetless() end
function GMR.IsTempBlacklistedArea() end
function GMR.IsTotem() end
function GMR.IsTraceValid() end
function GMR.IsTrainerDisplayingUnavailableSpells() end
function GMR.IsTrainerFrameShown() end
function GMR.IsTrainerTarget() end
function GMR.IsTrainingDummy() end
function GMR.IsTrainingSpellAvailable() end
function GMR.IsTrinketUsable() end
function GMR.IsTurnInSkipped() end
function GMR.IsUnitFlying() end
---Wether unit was killed by player or not
---@param unit string|userdata
---@return boolean
function GMR.IsUnitKilledByPlayer(unit) end
function GMR.IsUnitWalking() end
function GMR.IsUnstuckEnabled() end
function GMR.IsUsingCTM() end
function GMR.IsUsingPointSystem() end
function GMR.IsValidDrink() end
function GMR.IsValidFood() end
function GMR.IsValidStringIndex() end
function GMR.IsVendorId() end
function GMR.IsVendorPosition() end
function GMR.IsVendorSet() end
function GMR.IsVendoring() end
function GMR.IsWandUsable() end
function GMR.IsWanding() end
---@param spell string
---@param unit string|userdata
---@return boolean
function GMR.IsWarriorCastable(spell, unit) end
function GMR.IsWeapon() end
function GMR.IsWhitelistedItem() end
---Wether an item with itemId as ID is existant either in your bags or equipped
---@param itemId number
---@return boolean
function GMR.ItemExists(itemId) end
function GMR.ItemHandler() end
function GMR.JoinBattlefield() end
function GMR.JoinPartyModeChannel() end
function GMR.Jump() end
function GMR.JumpOrAscendStart() end
function GMR.LaunchQuester() end
function GMR.LoadCustomQuestingCode() end
function GMR.LoadFile() end
function GMR.LoadHearthstoneBindLocation() end
function GMR.LoadMap() end
function GMR.LoadMeshFiles() end
---@return void
function GMR.LoadNextQuest() end
function GMR.LoadPickPocketHandler() end
function GMR.LoadPlugins() end
---@param profileFolder string
---@param profileName string
---@return void
function GMR.LoadProfile(profileFolder, profileName) end
---@param questerName string
---@return void
function GMR.LoadQuester(questerName) end
function GMR.LoadVariables() end
---Displays a given text in GMR_LOG
---@param msg string
---@return void
function GMR.Log(msg) end
function GMR.Logout() end
function GMR.LogoutTimerHandler() end
function GMR.MailboxHandler() end
function GMR.MailboxPathHandler() end
function GMR.MapExists() end
function GMR.MapMove() end
function GMR.MerchantMenu() end
function GMR.Mesh() end
function GMR.MeshCallback() end
function GMR.MeshHandler() end
function GMR.MeshInLoS() end
function GMR.MeshJump() end
function GMR.MeshMovementHandler() end
---Meshes to a given position
---@param x number
---@param y number
---@param z number
---@return void
function GMR.MeshTo(x, y, z) end
function GMR.ModifyPath() end
function GMR.Mount() end
function GMR.MountVendoring() end
function GMR.MouseoverGryphonMaster() end
function GMR.MoveBackwardStart() end
function GMR.MoveBackwardStop() end
function GMR.MoveForwardStart() end
function GMR.MoveForwardStop() end
---@param x number
---@param y number
---@param z number
---@param normal any @???
function GMR.MoveTo(x, y, z, normal) end
function GMR.MovementHandler() end
function GMR.MovementHumanizer() end
function GMR.NavigatorMounts() end
function GMR.NodeBlacklistHandler() end
function GMR.NormalizePitch() end
function GMR.NormalizeRadian() end
function GMR.Notify() end
function GMR.ObfuscateString() end
function GMR.ObfuscateUnitPosition() end
function GMR.ObjectAnimationFlag() end
---@return number
function GMR.ObjectCount() end
---@param unit string|userdata
---@return number creatureTypeId
function GMR.ObjectCreatureTypeId(unit) end
---@param object string|userdata
---@return any @???
function GMR.ObjectDynamicFlags(object) end
---@param object string|userdata
---@return boolean
function GMR.ObjectExists(object) end
---@param object string|userdata
---@return any @???
function GMR.ObjectFlags(object) end
---@param object string|userdata
---@return any @???
function GMR.ObjectFlags2(object) end
function GMR.ObjectHasGossip() end
---@param object string|userdata
---@return number object id
function GMR.ObjectId(object) end
function GMR.ObjectInteract() end
---@param object1 string|userdata
---@param object2 string|userdata
---@return boolean
function GMR.ObjectIsFacing(object1, object2) end
function GMR.ObjectName() end
function GMR.ObjectPointer() end
---@param object userdata
---@return any @???
function GMR.ObjectPosition(object) end
function GMR.ObjectRawFacing() end
---@param object string|userdata
---@return number object raw type
function GMR.ObjectRawType(object) end
function GMR.ObjectTarget() end
function GMR.OffMeshHandler() end
function GMR.OverrideCentralPoint() end
function GMR.PartyMovement() end
function GMR.PathExists() end
function GMR.PetAttack() end
function GMR.PetFollow() end
function GMR.PetPathUnavailable() end
function GMR.PetWait() end
function GMR.PlaySound() end
function GMR.PlayerHasAura() end
function GMR.PlayerHasBubble() end
function GMR.PlayerHasEnemies() end
function GMR.PlayerHasPet() end
function GMR.PlayerHasSeal() end
function GMR.Prepare() end
function GMR.PreventDrowning() end
---Prints a given text including the GMR prefix
---@param msg string
---@return void
function GMR.Print(msg) end
function GMR.ProfileConnector() end
function GMR.ProfileExists() end
function GMR.ProfileJumpXYZ() end
function GMR.QuestHandler() end
function GMR.QuestSettingsHandler() end
function GMR.QueueBattleground() end
---@param path string Absolute path to file
---@return string File's content
function GMR.ReadFile(path) end
function GMR.Recover() end
function GMR.RecoverStealthed() end
function GMR.Reload() end
function GMR.RemoveBlacklistItem() end
function GMR.RemoveCentralPoint() end
function GMR.RemoveMailingItem() end
function GMR.RemoveTableEntries() end
function GMR.RepairEquipment() end
function GMR.ReplaceSpecialChars() end
function GMR.Repop() end
function GMR.RequestFile() end
function GMR.RequestPaidProfile() end
function GMR.RequestPartyLead() end
function GMR.RequestQuester() end
function GMR.ResetClass() end
function GMR.ResetClickedDungeonObjects() end
function GMR.ResetDistanceMovement() end
function GMR.ResetDungeon() end
function GMR.ResetObjectIteration() end
function GMR.ResetPathHandling() end
function GMR.ResetPointSystem() end
---Resets loaded profile data
---@return void
function GMR.ResetProfile() end
function GMR.ResetProfileCenters() end
---@return void
function GMR.ResetQuester() end
function GMR.ResetRequestPositionTimer() end
function GMR.ResetSafePosition() end
---Resets defined objects (Lootables, Nodes, Skinnables, ..)
---@return void
function GMR.ResetSetObject() end
function GMR.ResetVariables() end
function GMR.ResetVendorMode() end
function GMR.ResetVendorMount() end
function GMR.ResurrectPartyMember() end
function GMR.Revive() end
---@param str string
function GMR.RunEncoded(str) end
---@param text string
---@return void
function GMR.RunMacroText(text) end
---@param input string
---@param dest any @???
function GMR.RunString(input, dest) end
function GMR.SaveDungeonTimer() end
function GMR.SaveFlightpoint() end
function GMR.SaveObject() end
function GMR.SavePosition() end
function GMR.SaveVariable() end
function GMR.ScanObjects() end
function GMR.ScreenToWorld() end
function GMR.SecurityHandler() end
function GMR.SelectGossipOption() end
function GMR.SelectOption() end
function GMR.SendBlizzardMessage() end
function GMR.SendDiscordMessage() end
---Send HTTP request
---@param object GMR_Helper.SendHttpRequestObject request params and options
function GMR.SendHttpRequest(object) end
function GMR.SendNotification() end
function GMR.SendPartyModeMessage() end
---@param url string
---@param path string
---@param isHttps boolean
---@param body string
---@param headers string
---@param onSuccess fun(respContent:string) @???
function GMR.SendPostRequest(url, path, isHttps, body, headers, onSuccess) end
function GMR.SendRemoteData() end
function GMR.SendRequest() end
function GMR.SendRequest2() end
---@param url string
---@param callback fun(content:string):void
function GMR.SendRequestAndThen(url, callback) end
function GMR.SendRocketChatMessage() end
function GMR.SetAssistUnit() end
function GMR.SetAutoBlacklist() end
function GMR.SetCastingDelay() end
---Defines your current center index
---@param index number
---@return void
function GMR.SetCentralIndex(index) end
function GMR.SetChecked() end
function GMR.SetCombatRange() end
function GMR.SetDelay() end
function GMR.SetDiscoverFlightmasters() end
function GMR.SetItemMaxCount() end
function GMR.SetKeepRunning() end
function GMR.SetMaximumLevel() end
function GMR.SetMinimumLevel() end
function GMR.SetMode() end
function GMR.SetPitch() end
function GMR.SetQuestNpcInteractRange() end
---@param x any @???
---@return void
function GMR.SetQuestingState(x) end
function GMR.SetScanRadius() end
function GMR.SetVendorMode() end
function GMR.SetYaw() end
function GMR.Shapeshift() end
function GMR.Shutdown() end
function GMR.ShutdownTimerHandler() end
function GMR.SitStandOrDescendStart() end
function GMR.SkipFlightMeshPoints() end
function GMR.SkipTurnIn() end
function GMR.SmartBlacklist() end
function GMR.SoulshardExists() end
function GMR.SoulstoneExists() end
function GMR.SpellStopCasting() end
function GMR.SquireBot_ReceiveHttpResponse() end
function GMR.SquireBot_SendHttpRequest() end
function GMR.StandUp() end
function GMR.StartAttack() end
function GMR.StartQuest() end
---GMR stops executing
---@return void
function GMR.Stop() end
function GMR.StopAttack() end
---Stops GMR's navigation
---@return void
function GMR.StopMoving() end
function GMR.StopWandCast() end
function GMR.StoreTalent() end
function GMR.StrafeLeftStart() end
function GMR.StrafeLeftStop() end
function GMR.StrafeRightStart() end
function GMR.StrafeRightStop() end
function GMR.SwitchFishingWeapons() end
function GMR.TargetObject() end
function GMR.TargetTrainer() end
function GMR.TargetUnit() end
function GMR.TempBlacklistSetNode() end
function GMR.TimerExecution() end
function GMR.ToggleMovement() end
function GMR.ToggleRun() end
function GMR.TraceLine() end
function GMR.TrackPlayerPosition() end
function GMR.Trade() end
function GMR.TradeGoods() end
function GMR.Translate() end
function GMR.TurnLeftStart() end
function GMR.TurnLeftStop() end
function GMR.TurnRightStart() end
function GMR.TurnRightStop() end
function GMR.UnitAffectingCombat() end
function GMR.UnitBuff() end
---@param unit string|userdata
---@param anotherUnit string|userdata
---@return boolean
function GMR.UnitCanAttack(unit, anotherUnit) end
function GMR.UnitCanHeal() end
function GMR.UnitCastingInfo() end
---Wether units cast is < than timeInSec
---@param unit string|userdata
---@param timeInSec number
---@return boolean
function GMR.UnitCastingTime(unit, timeInSec) end
function GMR.UnitChannelInfo() end
function GMR.UnitClass() end
function GMR.UnitClassification() end
function GMR.UnitCreatureType() end
---@param unit string|userdata
---@param index number
---@return string, number, number, string, number, number, nil, boolean, boolean, number, boolean, boolean, boolean, boolean, number, boolean Locale name, ?, ?, type, duration, expireAtTime, ?, ?, skillId, ?, ?, ?, ?, ?, ?
function GMR.UnitDebuff(unit, index) end
function GMR.UnitDetailedThreatSituation() end
function GMR.UnitExists() end
function GMR.UnitFactionGroup() end
function GMR.UnitGUID() end
function GMR.UnitHasPaladinAura() end
function GMR.UnitHasPaladinBuff() end
function GMR.UnitHasScrollBuff() end
function GMR.UnitHealth() end
function GMR.UnitHealthMax() end
function GMR.UnitInParty() end
function GMR.UnitInRaid() end
function GMR.UnitInteract() end
function GMR.UnitIsAFK() end
function GMR.UnitIsAttackable() end
function GMR.UnitIsCorpse() end
---@param unit string|userdata
---@return boolean
function GMR.UnitIsDead(unit) end
---@param unit string|userdata
---@return boolean
function GMR.UnitIsDeadOrGhost(unit) end
function GMR.UnitIsFacing() end
function GMR.UnitIsGhost() end
function GMR.UnitIsPlayer() end
function GMR.UnitIsTapDenied() end
function GMR.UnitIsTrivial() end
---Compare two units
---@param unit1 string|userdata
---@param unit2 string|userdata
---@return boolean
function GMR.UnitIsUnit(unit1, unit2) end
function GMR.UnitIsVisible() end
function GMR.UnitLevel() end
function GMR.UnitMovementFlags() end
function GMR.UnitName() end
function GMR.UnitPlayerControlled() end
function GMR.UnitPower() end
function GMR.UnitPowerMax() end
function GMR.UnitPowerType() end
function GMR.UnitRace() end
function GMR.UnitReaction() end
function GMR.UnitTarget() end
function GMR.UnitThreatSituation() end
function GMR.Unshift() end
function GMR.Unstuck() end
function GMR.UnstuckHandler() end
function GMR.UnstuckPathHandler() end
function GMR.UpdateAFK() end
function GMR.UpdateAutoGear() end
function GMR.UpdateBags() end
function GMR.UpdateBattlegroundCluster() end
function GMR.UpdateCentralIndex() end
function GMR.UpdateCircleAroundCursor() end
function GMR.UpdateCombatRange() end
function GMR.UpdateDisableFlying() end
function GMR.UpdateDiscordWebhook() end
function GMR.UpdateDungeonTimers() end
function GMR.UpdateFishingItems() end
function GMR.UpdateFlightmasterTable() end
function GMR.UpdateGryphonMaster() end
function GMR.UpdateGryphonMasters() end
function GMR.UpdateInformation() end
function GMR.UpdateLocalProfiles() end
function GMR.UpdateMailingData() end
function GMR.UpdateMassLooting() end
function GMR.UpdateMeshDestination() end
function GMR.UpdateMounts() end
function GMR.UpdateNextQuester() end
function GMR.UpdatePartyConnections() end
function GMR.UpdatePartyCorpsePosition() end
function GMR.UpdatePetDenied() end
function GMR.UpdatePushoverKey() end
function GMR.UpdateQuestButtonIndex() end
function GMR.UpdateQuestingFile() end
function GMR.UpdateQuestingIndex() end
function GMR.UpdateSavedEnemy() end
function GMR.UpdateSavedProfile() end
function GMR.UpdateSavedProfileFolder() end
function GMR.UpdateSavedProfileIndex() end
function GMR.UpdateSavedProfileType() end
function GMR.UpdateSavedQuester() end
function GMR.UpdateTalents() end
function GMR.UpdateTempBlacklist() end
function GMR.UpdateVendorMounts() end
function GMR.UpdateWoWVisionToken() end
function GMR.Use() end
function GMR.UseContainerItem() end
function GMR.UseItemByName() end
function GMR.UseWand() end
function GMR.ValidateProfiles() end
function GMR.VendorPathHandler() end
function GMR.WeaponMissingEnchant() end
function GMR.WorldToScreen() end
---@param path string
---@param content string
function GMR.WriteFile(path, content) end
function GMR._WorldToScreen() end

GMR.Errors = {}
GMR.Frames = {}
GMR.GUI = {}
GMR.Loader = {}

---@class GMR.Questing
GMR.Questing = {}
---@param id number
---@param distance number
---@return any @???
function GMR.Questing.FollowNpc(id, distance) end
---@param x number
---@param y number
---@param z number
---@param id number
---@param dynamicFlag number @???
---@param distance number
---@param delay number
---@return any @???
function GMR.Questing.InteractWith(x, y, z, id, dynamicFlag, distance, delay) end
---@param x number
---@param y number
---@param z number
---@param id number @???
---@return any @???
function GMR.Questing.KillEnemy(x, y, z, id) end
---@param x number
---@param y number
---@param z number
---@param npcId number
---@param itemId number
---@param distance number
---@return any @???
function GMR.Questing.UseItemOnNpc(x, y, z, npcId, itemId, distance) end
---@param x number
---@param y number
---@param z number
---@param npcId number
---@param spellId number
---@param distance number
function GMR.Questing.CastSpellOnNpc(x, y, z, npcId, spellId, distance) end
function GMR.Questing.EmoteAtNpc(x, y, z, npcId, emote, distance) end
function GMR.Questing.UseItemOnPosition(x, y, z, itemId, distance) end
function GMR.Questing.UseItemOnGround(x, y, z, itemId, distance) end
function GMR.Questing.ExtraActionButton1(x, y, z) end
function GMR.Questing.GossipWith(x, y, z, id, delay, distance, buttonIndex) end
function GMR.Questing.GetQuestInfo(questId) end
function GMR.Questing.IsObjectiveCompleted(questId, index) end
function GMR.Questing.GetObjectiveFulfilled(questId, index) end
---???
function GMR.Questing.BlacklistGUID() end
---???
function GMR.Questing.GetGossipOption() end
---???
function GMR.Questing.IsBlacklistedObject() end
---???
function GMR.Questing.FleeTo() end
---???
function GMR.Questing.IsAutoBlacklisting() end
---???
function GMR.Questing.MoveTo() end
---???
function GMR.Questing.AvoidAoE() end
---???
function GMR.Questing.UseExtraActionButton1() end

GMR.Tables = {}
GMR.Timer = {}
---@class GMR.Variables
GMR.Variables = {
	---Absolute path to GMR dir
	---@type string
	Directory = "",
	---Customer's login
	---@type string
	Customer = "",
}
GMR.json = {}

GMR_Helper = {}

---@class GMR_Helper.SendHttpRequestObject
---@field Url string
---@field Method string
---@field Callback fun(content:string):void

---@class GMR_Helper.Object
---@field Id number

---@class GMR_Helper.GetObjectWithInfo
---@field id number The objects id
---@field creatureTypeId number The objects createtype ID
---@field rawType number The objects rawtype
---@field position table The objects position
---@field health number The objects health (requires GMR_Helper.GetObjectWithInfo.healthVar)
---@field healthVar string @"<" or ">" depending if the objects health is > info.health or < info.health
---@field isAlive boolean Whether the object is alive or not
---@field inCombat boolean Wether the object is in combat or not
---@field movementFlag number The object must have number as movement flag
---@field dynamicFlag number The object must have number as dynamic flag
---@field flag number The object must have number as flag
---@field flag2 number The object must have number as flag2
---@field killedByPlayer boolean The object must be killed by the player
---@field speed number The objects speed must be equal to number
---@field canAttack boolean Wether the object is attackable or not
---@field hasBuff string The object must have a given buff
---@field hasDebuff string The object must have a given debuff
---@field notHasBuff string The object must not have a given buff
---@field notHasDebuff string The object must not have a given debuff
---@field distance number The object must be within a given distance
---@field isInteractable boolean Wether the object is interactable or not
---@field hasGossip boolean Wether the object has a gossip or not
---@field isPickPocketable boolean Wether the object is pickpocketable or not