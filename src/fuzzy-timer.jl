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

@enum State begin
    TooEarly #white
    Early #blue
    Good #green
    Okay #yellow
    Late #orange
    Latest #red
    TooLate #black
end

# +
using Dates

module M
using Dates

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

function state(timer::FuzzyTimer)
    show(42)
end

end

t = M.FuzzyTimer(Minute(60), Hour(2))
t2 = M.FuzzyTimer(Time(11), Time(12))
t, t2
# -

M.start(t)

M.state(t)

methods(FuzzyTimer)

t2


