-- sh_reload.lua
function SWEP:CanReload()
    if self:GetReloading() then return false end

    -- clip already full
    if self:Clip1() >= self.Primary.ClipSize then return false end

    local owner = self:GetOwner()
    if not IsValid(owner) then return false end

    -- no reserve ammo
    if owner:GetAmmoCount(self.Primary.Ammo) <= 0 then return false end

    return true
end

function SWEP:Reload()
    if not self:CanReload() then return end

    self:SetZoomed(false)

    if self.ShotgunReload then
        self:StartShotgunReload()
    else
        self:StartMagazineReload()
    end
end

function SWEP:StartMagazineReload()
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
	
	self:SendWeaponAnim(ACT_VM_RELOAD)

    self:SetReloading(true)
    self.ReloadEnd = CurTime() + self:GetAnimDuration(ACT_VM_RELOAD)
	
	-- networked timestamps
	local now = CurTime()
	local dur = self:GetAnimDuration(ACT_VM_RELOAD)
	self:SetReloadStartTime(now)
	self:SetReloadEndTime(now + dur)

    -- play 3p animation
    owner:DoAnimationEvent(self.ReloadGesture)
	
	-- stop looping sound
	self:MW_StopLoopingSound()
end

function SWEP:FinishMagazineReload()
    self:SetReloading(false)

    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    local ammo = owner:GetAmmoCount(self.Primary.Ammo)
    local needed = self.Primary.ClipSize - self:Clip1()

    local toLoad = math.min(needed, ammo)

    self:SetClip1(self:Clip1() + toLoad)
    owner:SetAmmo(ammo - toLoad, self.Primary.Ammo)
	
	self:SendWeaponAnim(ACT_RELOAD_FINISH)
end

function SWEP:ThinkMagazineReload()
    if self:GetReloading() and CurTime() >= self:GetReloadEndTime() then
        self:FinishMagazineReload()
    end
end

function SWEP:GetAnimDuration(act)
    local vm = self:GetOwner():GetViewModel()
    if not IsValid(vm) then return 0 end

    local seq = vm:SelectWeightedSequence(act)
    if seq < 0 then return 0 end

    return vm:SequenceDuration(seq)
end

function SWEP:StartShotgunReload()
    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    self:SetReloading(true)
    self.ReloadStage = "start"

    self:SendWeaponAnim(ACT_RELOAD_START)
    owner:DoAnimationEvent(self.ReloadGesture)

    self.NextReloadTime = CurTime() + self:GetAnimDuration(ACT_RELOAD_START)
	
	-- networked timestamps
	local now = CurTime()
	local dur = self:GetAnimDuration(ACT_RELOAD_START)
	self:SetReloadStartTime(now)
	self:SetReloadEndTime(now + dur)
	
	-- stop looping sound
	self:MW_StopLoopingSound()
end

function SWEP:ThinkShotgunReload()
    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    if self:GetReloading() and self.NextReloadTime and CurTime() < self.NextReloadTime then
		return
	end

    -- start to insert
    if self.ReloadStage == "start" then
        self.ReloadStage = "insert"
        self:InsertShell()
        return
    end

    -- insert shells
    if self.ReloadStage == "insert" then

        -- is clip full
        if self:Clip1() >= self.Primary.ClipSize then
            self:FinishShotgunReload()
            return
        end

        -- has no ammo
        if owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
            self:FinishShotgunReload()
            return
        end

        -- insert another shell
        self:InsertShell()
        return
    end
end

function SWEP:InsertShell()
    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    -- animation
    self:SendWeaponAnim(ACT_VM_RELOAD)

    -- timing from animation
    self.NextReloadTime = CurTime() + self:GetAnimDuration(ACT_VM_RELOAD)
	
	-- networked timestamps
	local now = CurTime()
	local dur = self:GetAnimDuration(ACT_VM_RELOAD)
	self:SetReloadStartTime(now)
	self:SetReloadEndTime(now + dur)
	
    timer.Simple(dur, function()
		if not IsValid(self) then return end
		local owner = self:GetOwner()
		if not IsValid(owner) then return end
		if not self:GetReloading() then return end
		
		-- actual ammo transfer
		local ammo = owner:GetAmmoCount(self.Primary.Ammo)
		if ammo <= 0 then return end

		owner:SetAmmo(ammo - 1, self.Primary.Ammo)
		self:SetClip1(self:Clip1() + 1)
    end)
end

function SWEP:FinishShotgunReload()
    self.ReloadStage = "finish"

    self:SendWeaponAnim(ACT_RELOAD_FINISH)

    self.NextReloadTime = CurTime() + self:GetAnimDuration(ACT_RELOAD_FINISH)
	
	-- networked timestamps
	local now = CurTime()
	local dur = self:GetAnimDuration(ACT_RELOAD_FINISH)
	self:SetReloadStartTime(now)
	self:SetReloadEndTime(now + dur)

    -- after finish animation ends fully exit reload
    timer.Simple(self:GetAnimDuration(ACT_RELOAD_FINISH), function()
        if not IsValid(self) then return end
        self:SetReloading(false)
        self.ReloadStage = nil
    end)
end

function SWEP:GetReloadProgress()
    if not self:GetReloading() then return 0 end

    local start  = self:GetReloadStartTime() or 0
    local finish = self:GetReloadEndTime() or 0
    local now    = CurTime()

    if start <= 0 or finish <= start then
        return 0
    end

    if now >= finish then
        return 1
    end

    return math.Clamp((now - start) / (finish - start), 0, 1)
end

