function bindOption(key, app)
    hs.hotkey.bind({ "alt" }, key, function()
        hs.application.launchOrFocus(app)
    end)
end

bindOption("1", "Safari")
bindOption("2", "kitty")
bindOption("3", "Zed")
bindOption("0", "Slack")

local urls = {
    -- Parakey
    { text = "Parakey Prod",            url = "https://web.parakey.co" },
    { text = "Parakey Staging",         url = "https://staging.parakey.co" },
    { text = "Parakey Prod Console",    url = "https://web.parakey.co/back-office/console" },
    { text = "Parakey Staging console", url = "https://staging.parakey.co/back-office/console" },
    { text = "Parakey Docs",            url = "https://internal-api-doc.parakey.co" },
    -- Github
    { text = "Github Core",             url = "https://github.com/parakey-ab/parakey-core" },
    { text = "Github iOS",              url = "https://github.com/parakey-ab/parakey-ios" },
    { text = "Github Android",          url = "https://github.com/parakey-ab/parakey-android" },
    { text = "Github SDK iOS",          url = "https://github.com/parakey-ab/parakey-sdk-ios" },
    { text = "Github SDK Android",      url = "https://github.com/parakey-ab/parakey-sdk-android" },
    { text = "Github SDK React Native", url = "https://github.com/parakey-ab/parakey-sdk-react-native" },
    -- CircleCI
    { text = "CircleCI iOS",            url = "https://app.circleci.com/pipelines/github/parakey-ab/parakey-ios" },
    { text = "CircleCI Android",        url = "https://app.circleci.com/pipelines/github/parakey-ab/parakey-android" },
    { text = "CircleCI Core",           url = "https://app.circleci.com/pipelines/github/parakey-ab/parakey-core" },
    -- Tools
    { text = "Figma",                   url = "https://figma.com" },
    { text = "Notion App Backlog",      url = "https://www.notion.so/parakey/App-team-backlog-b63b5857b47a40eba6054d67fd67a131" },
    { text = "Notion Roadmap",          url = "https://www.notion.so/parakey/85af6595a54540cab010fb815a877a53?v=004477b35fd24b1d8b51495928440c08" }
}


local function urlNoProtocol(url)
    return url:gsub("^https?://", "")
end

local function focusOrOpenSafariURL(url)
    local targetDomain = urlNoProtocol(url)
    local script = [[
        set targetDomain to "]] .. targetDomain .. [["
        tell application "Safari"
            activate
            set winList to windows
            repeat with aWin in winList
                set tabList to tabs of aWin
                repeat with aTab in tabList
                    try
                        set tabURL to (URL of aTab as string)
                    on error
                        set tabURL to ""
                    end try
                    if tabURL contains targetDomain then
                        set current tab of aWin to aTab
                        set index of aWin to 1
                        return true
                    end if
                end repeat
            end repeat
            -- If we made it here, tab wasn't found, open new tab
            tell front window
                set newTab to make new tab with properties {URL:"]] .. url .. [["}
                set current tab to newTab
            end tell
        end tell
        return false
    ]]
    hs.osascript.applescript(script)
end

hs.hotkey.bind({ "alt" }, "`", function()
    local chooser = hs.chooser.new(function(choice)
        if choice and choice.url then
            focusOrOpenSafariURL(choice.url)
        end
    end)

    chooser:choices(urls)
    chooser:show()
end)
