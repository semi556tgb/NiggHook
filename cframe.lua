return function(library)
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer

    local moving = {W=false, A=false, S=false, D=false}
    local hrp = nil

    -- Wait for character
    local function getHRP()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        hrp = character:WaitForChild("HumanoidRootPart")
    end

    getHRP()

    -- Update hrp on respawn
    LocalPlayer.CharacterAdded:Connect(function(char)
        hrp = char:WaitForChild("HumanoidRootPart")
    end)

    -- WASD movement tracking
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.W then moving.W = true end
        if input.KeyCode == Enum.KeyCode.A then moving.A = true end
        if input.KeyCode == Enum.KeyCode.S then moving.S = true end
        if input.KeyCode == Enum.KeyCode.D then moving.D = true end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then moving.W = false end
        if input.KeyCode == Enum.KeyCode.A then moving.A = false end
        if input.KeyCode == Enum.KeyCode.S then moving.S = false end
        if input.KeyCode == Enum.KeyCode.D then moving.D = false end
    end)

    -- Movement loop
    RunService.Heartbeat:Connect(function()
        if library.flags.cframe_enabled and hrp then
            local power = (library.flags.cframe_value or 10) / 10
            local dir = Vector3.zero

            if moving.W then dir = dir + hrp.CFrame.LookVector end
            if moving.S then dir = dir - hrp.CFrame.LookVector end
            if moving.A then dir = dir - hrp.CFrame.RightVector end
            if moving.D then dir = dir + hrp.CFrame.RightVector end

            if dir.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + dir.Unit * power
            end
        end
    end)
end
