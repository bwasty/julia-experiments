# Inline plotting in iTerm
# use via include: `include("plot-terminal.jl")`
using TerminalExtensions
using Plots
Plots.GRBackend()
surface(rand(100, 40))
