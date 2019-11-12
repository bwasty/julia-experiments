# -*- coding: utf-8 -*-
# ---
# jupyter:
#   jupytext:
#     formats: ipynb,jl:light
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.4'
#       jupytext_version: 1.2.4
#   kernelspec:
#     display_name: Julia 1.2.0
#     language: julia
#     name: julia-1.2
# ---

# +
using Dates

module M
using Dates

@enum State begin
    TooEarly #white
    Early #blue
    Good #green
    Okay #yellow
    Late #orange
    Latest #red
    TooLate #black
end

emojis = [
    ['⚪', '💜', '🥚'], 
    ['🔵', '💙', '📘'], 
    ['🟢', '💚', '📗'], 
    ['🟡', '💛', '🌕', '📔', '📒'], 
    ['🟠', '🧡', '📙'], 
    ['🔴','❤', '♥', '🛑', '📕'], 
    ['⚫', '🖤'],
]

BasePeriod = Minute
#BasePeriod = Second # for testing

mutable struct FuzzyTimer
    name::String
    start::Union{DateTime, Nothing}
    
    too_early::BasePeriod
    early::BasePeriod
    good::BasePeriod
    okay::BasePeriod
    late::BasePeriod
    latest::BasePeriod
    too_late::BasePeriod
    
    inverted::Bool
    
    FuzzyTimer(good::Period, latest::Period; name="Timer") = begin
        good = BasePeriod(good)
        latest = BasePeriod(latest)
        interval = (latest - good) / 3 # 3 steps between: Good, Okay, Late
        
        too_early = good - 2interval
        early     = good - 1interval
        
        okay      = good + 1interval
        late      = latest - 1interval
        
        too_late  = latest + 1interval
        
        new(name, nothing, too_early, early, good, okay, late, latest, too_late)
    end  
    
    FuzzyTimer(good::Time, latest::Time; name="Timer") = begin
        interval = BasePeriod(latest - good) / 3 # 3 steps between: Good, Okay, Late
        start = DateTime(today(), good - 3interval)
        
        too_early = 1interval
        early     = 2interval
        good      = 3interval
        okay      = 4interval
        late      = 5interval
        latest    = 6interval
        too_late  = 7interval
        
        new(name, start, too_early, early, good, okay, late, latest, too_late)
    end
end

function start(timer::FuzzyTimer)
    timer.start = now()
end

function state(timer::FuzzyTimer, now=now())::State
    @assert timer.start !== nothing
    elapsed = now - timer.start
    if elapsed < timer.early
        TooEarly
    elseif elapsed < timer.good
        Early
    elseif elapsed < timer.okay
        Good
    elseif elapsed < timer.late
        Okay
    elseif elapsed < timer.latest
        Late
    elseif elapsed < timer.too_late
        Latest
    else
        TooLate
    end
end

function remaining_in_state(timer::FuzzyTimer, now=now())::BasePeriod
    @assert timer.start !== nothing
    elapsed = round(now - timer.start, BasePeriod)
    if elapsed < timer.early
        timer.early - elapsed
    elseif elapsed < timer.good
        timer.good - elapsed
    elseif elapsed < timer.okay
        timer.okay - elapsed
    elseif elapsed < timer.late
        timer.late - elapsed
    elseif elapsed < timer.latest
        timer.latest - elapsed
    elseif elapsed < timer.too_late
        timer.too_late - elapsed
    else
        BasePeriod(0)
    end
end

end

t = M.FuzzyTimer(Minute(60), Hour(2))
display(t)
t2 = M.FuzzyTimer(Time(11), Time(12))
#t, t2
# M.start(t)
# M.state(t) |> display
# M.state(t, now() + Minute(50)) |> display
# M.state(t, now() + Minute(60)) |> display
# M.state(t, now() + Minute(100)) |> display

# M.remaining_in_state(t, now() + Minute(61))
# -

using Plots

gr()

?bar

bar([1,2,3],[4,5,6],fillcolor=[:red,:green,:blue],fillalpha=[0.2,0.4,0.6], orientation=:horizontal, bar_position=:overlay)

bar([(1,4),(2,5),(3,6)])

using StatsPlots


