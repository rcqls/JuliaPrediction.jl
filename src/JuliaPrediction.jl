module JuliaPrediction
using DataFrames
using MLJ
using DecisionTree
using Random

export greet_your_package_name
export perclass_splits
include("functions.jl")

export EncodeData
include("Encoder.jl")

export Tree_Process
include("ForestPrediction.jl")

end