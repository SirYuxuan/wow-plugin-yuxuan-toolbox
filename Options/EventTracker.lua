local addonName, ns = ...
local Core = ns.Core
local ETD = ns.EventTrackerData

--------------------------------------------------------------------------------
-- 事件追踪器 - 选项面板
--------------------------------------------------------------------------------

function ns.BuildEventTrackerOptions()
    local function CreateEventToggle(name, order, key)
        return {
            type = "toggle",
            name = name,
            order = order,
            width = 1.2,
            get = function() return Core.db.profile.eventTracker[key] end,
            set = function(_, val)
                Core.db.profile.eventTracker[key] = val
                if Core.UpdateEventTrackers then Core:UpdateEventTrackers() end
            end,
        }
    end

    return {
        type = "group",
        name = "事件追踪器",
        order = 10,
        childGroups = "tab",
        args = {
            basicGroup = {
                type = "group",
                name = "基础设置",
                order = 10,
                args = {
                    enabled = {
                        type = "toggle",
                        name = "启用事件追踪器",
                        order = 1,
                        width = 1.2,
                        get = function() return Core.db.profile.eventTracker.enabled end,
                        set = function(_, val)
                            Core.db.profile.eventTracker.enabled = val
                            if Core.ApplyEventTrackerSettings then Core:ApplyEventTrackerSettings() end
                        end,
                    },
                    alertEnabled = {
                        type = "toggle",
                        name = "事件提前通知",
                        order = 2,
                        width = 1.2,
                        get = function() return Core.db.profile.eventTracker.alertEnabled end,
                        set = function(_, val)
                            Core.db.profile.eventTracker.alertEnabled = val
                        end,
                    },
                    alertSecond = {
                        type = "range",
                        name = "提前通知时间(秒)",
                        order = 3,
                        min = 15,
                        max = 300,
                        step = 5,
                        width = 1.6,
                        disabled = function() return not Core.db.profile.eventTracker.alertEnabled end,
                        get = function() return Core.db.profile.eventTracker.alertSecond or 60 end,
                        set = function(_, val)
                            Core.db.profile.eventTracker.alertSecond = val
                        end,
                    },
                },
            },
            styleGroup = {
                type = "group",
                name = "样式设置",
                order = 20,
                args = {
                    fontSize = {
                        type = "range",
                        name = "字体大小",
                        order = 1,
                        min = 9,
                        max = 18,
                        step = 1,
                        get = function() return Core.db.profile.eventTracker.fontSize or 12 end,
                        set = function(_, val)
                            Core.db.profile.eventTracker.fontSize = val
                            if Core.ApplyEventTrackerFonts then Core:ApplyEventTrackerFonts() end
                            if Core.UpdateEventTrackers then Core:UpdateEventTrackers() end
                        end,
                    },
                    fontOutline = {
                        type = "toggle",
                        name = "字体描边",
                        order = 2,
                        get = function() return Core.db.profile.eventTracker.fontOutline end,
                        set = function(_, val)
                            Core.db.profile.eventTracker.fontOutline = val
                            if Core.ApplyEventTrackerFonts then Core:ApplyEventTrackerFonts() end
                        end,
                    },
                    trackerWidth = {
                        type = "range",
                        name = "追踪器宽度",
                        order = 3,
                        min = 160,
                        max = 320,
                        step = 5,
                        get = function() return Core.db.profile.eventTracker.trackerWidth or 220 end,
                        set = function(_, val)
                            Core.db.profile.eventTracker.trackerWidth = val
                            if Core.UpdateEventTrackers then Core:UpdateEventTrackers() end
                        end,
                    },
                    trackerHeight = {
                        type = "range",
                        name = "追踪器高度",
                        order = 4,
                        min = 22,
                        max = 40,
                        step = 1,
                        get = function() return Core.db.profile.eventTracker.trackerHeight or 28 end,
                        set = function(_, val)
                            Core.db.profile.eventTracker.trackerHeight = val
                            if Core.UpdateEventTrackers then Core:UpdateEventTrackers() end
                        end,
                    },
                    backdropAlpha = {
                        type = "range",
                        name = "背景透明度",
                        order = 5,
                        min = 0,
                        max = 1,
                        step = 0.05,
                        isPercent = true,
                        get = function() return Core.db.profile.eventTracker.backdropAlpha or 0.6 end,
                        set = function(_, val)
                            Core.db.profile.eventTracker.backdropAlpha = val
                            if Core.UpdateEventTrackers then Core:UpdateEventTrackers() end
                        end,
                    },
                },
            },
            eventSwitches = {
                type = "group",
                name = "事件开关",
                order = 30,
                args = {
                    -- ── 至暗之夜 ──
                    mnHeader = { type = "header", name = "至暗之夜", order = 10 },
                    weeklyMN             = CreateEventToggle("周常任务 (至暗之夜)", 11, "weeklyMN"),
                    professionsWeeklyMN  = CreateEventToggle("专业周常 (至暗之夜)", 12, "professionsWeeklyMN"),
                    stormarionAssault    = CreateEventToggle("斯托玛兰突袭战",       13, "stormarionAssault"),

                    -- ── 地心之战 ──
                    twwHeader = { type = "header", name = "地心之战", order = 20 },
                    weeklyTWW            = CreateEventToggle("周常任务 (地心之战)", 21, "weeklyTWW"),
                    nightfall            = CreateEventToggle("夜幕激斗",             22, "nightfall"),
                    theaterTroupe        = CreateEventToggle("剧团演出",             23, "theaterTroupe"),
                    ecologicalSuccession = CreateEventToggle("生态重构",             24, "ecologicalSuccession"),
                    ringingDeeps         = CreateEventToggle("回响深渊",             25, "ringingDeeps"),
                    spreadingTheLight    = CreateEventToggle("散布光芒",             26, "spreadingTheLight"),
                    underworldOperative  = CreateEventToggle("暗影行动",             27, "underworldOperative"),
                },
            },
        },
    }
end
