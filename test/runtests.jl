using JuliaPrediction
using Test

@testset "JuliaPrediction.jl" begin
    @test JuliaPrediction.greet_your_package_name() == "Hello JuliaPrediction!"
    @test JuliaPrediction.greet_your_package_name() != "Hello world!"
end
