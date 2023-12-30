local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('kuban_multijob:client:deleteJob', function(args)
    TriggerServerEvent('kuban_multijob:server:deleteJob', args.job)
    Wait(100)
    ExecuteCommand('myjobs')
end)

AddEventHandler('kuban_multijob:client:choiceMenu', function(args)
    local displayChoices = {
        id = 'choice_menu',
        title = 'Job Actions',
        menu = 'job_menu',
        options = {
            {
                title = 'Switch Job',
                description = 'Switch your job to: '..args.jobLabel,
                icon = 'fa-solid fa-circle-check',
                event = 'kuban_multijob:client:changeJob',
                args = {job = args.job, grade = args.grade}
            },
            {
                title = 'Quit Job',
                description = 'Quit the selected job: '..args.jobLabel,
                icon = 'fa-solid fa-trash-can',
                event = 'kuban_multijob:client:deleteJob',
                args = {job = args.job}
            },
        }
    }
    lib.registerContext(displayChoices)
    lib.showContext('choice_menu')
end)

AddEventHandler('kuban_multijob:client:toggleDuty', function()
    TriggerServerEvent('QBCore:ToggleDuty')
    Wait(500)
    ExecuteCommand('myjobs')
end)

RegisterCommand('myjobs', function(source, args)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local dutyStatus = PlayerData.job.onduty and 'On Duty' or 'Off Duty'
    local dutyIcon = PlayerData.job.onduty and 'fa-solid fa-toggle-on' or 'fa-solid fa-toggle-off'
    local jobMenu = {
        id = 'job_menu',
        title = 'My Gov',
        options = {
            {
                title = 'Go On/Off Duty',
                description = 'Current Status: ' .. dutyStatus,
                icon = dutyIcon,
                event = 'kuban_multijob:client:toggleDuty',
                args = {},
            },
        },
    }
    
    lib.callback('kuban_multijob:server:myJobs', false, function(myJobs)
        if myJobs then
            for _, job in ipairs(myJobs) do
                local isDisabled = PlayerData.job.name == job.job
                jobMenu.options[#jobMenu.options + 1] = {
                    title = job.jobLabel,
                    description = 'Rank: ' .. job.gradeLabel .. ' [' .. tonumber(job.grade) .. ']\nIncome: $' .. job.salary,
                    icon = Config.JobIcons[job.job] or 'fa-solid fa-briefcase',
                    arrow = true,
                    disabled = isDisabled,
                    event = 'kuban_multijob:client:choiceMenu',
                    args = {jobLabel = job.jobLabel, job = job.job, grade = job.grade},
                }
            end
            lib.registerContext(jobMenu)
            lib.showContext('job_menu')
        end
    end)
end)

RegisterKeyMapping('myjobs', 'Multi Job', 'keyboard', 'F4')

AddEventHandler('kuban_multijob:client:changeJob', function(args)
    TriggerServerEvent('kuban_multijob:server:changeJob', args.job, args.grade)
    Wait(100)
    ExecuteCommand('myjobs')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    TriggerServerEvent('kuban_multijob:server:newJob', JobInfo)
end)
