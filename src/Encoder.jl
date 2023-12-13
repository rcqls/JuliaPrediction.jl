function EncodeData(data, indiv)
    df = copy(data)
    select!(df, Not([:success]))
    transform!(df, :sex => ByRow(x -> x == "F" ? 0 : 1) => :sex) 
    y_dict = Dict(
        "peak_name" => [indiv[1]],
        "season" => [indiv[2]],
        "citizenship" => [indiv[3]],
        "expedition_role" => [indiv[4]],
        "year" => [indiv[5]],
        "sex" => [indiv[6] == "M" ? 0 : 1],
        "age" => [indiv[7]],
        "hired" => [indiv[8] == "false" ? 0 : 1],
        "solo" => [indiv[9]== "false" ? 0 : 1],
        "oxygen_used" => [indiv[10] == "false" ? 0 : 1],
        "died" => [indiv[11] == "false" ? 0 : 1],
        "injured" => [indiv[12] == "false" ? 0 : 1]
    )
    ydf = DataFrame(y_dict)
    select!(ydf,8,9,2,4,12,10,1,5,11,7,3,6)
    append!(df,ydf)

    coerce!(df, :peak_name => Multiclass, :season => Multiclass, :citizenship => Multiclass, :expedition_role => Multiclass, :year => Continuous, :sex => Continuous, :age => Continuous, :hired => Continuous, :solo => Continuous, :oxygen_used => Continuous, :died => Continuous, :injured => Continuous)
         
    ohe = machine(OneHotEncoder(), df)
    MLJ.fit!(ohe)
    Encode = MLJ.transform(ohe, df)
    X_encode = Encode[1:73000,:]
    Y_encode = last(Encode,1)
    target = data.success
    dftarget = DataFrame(success = target)
    transform!(dftarget, :success => ByRow(x -> x == false ? 0 : 1) => :success)
    transform!(dftarget, :success => ByRow(x -> convert(Float64,x)) => :success)
    ytarget = dftarget[:,1]

    return [X_encode,Y_encode,ytarget]
end