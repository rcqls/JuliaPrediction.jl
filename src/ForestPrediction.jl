using MLJ
function Forest(X,pred,target,n = 5)
    y = Matrix{Float64}(pred)
    MatX = Matrix{Float64}(X)
    Vecty = string.(target[:,1])
    
    train_index = perclass_splits(Vecty, 0.7)

    test_index = setdiff(1:length(Vecty), train_index)

    # split features

    X_train = MatX[train_index, :]

    # split classes

    y_train = Vecty[train_index]

    @load RandomForestClassifier verbosity=2 pkg = DecisionTree
    model = RandomForestClassifier(n_subfeatures = n)

    DecisionTree.fit!(model, X_train, y_train)

    y_hat = DecisionTree.predict(model, y)
    
    proba = DecisionTree.predict_proba(model, y)

    return [y_hat,proba]

end

function Tree_Process(data, indiv, n=5)
    t0 = time()
    process = EncodeData(data, indiv)
    res_predict = Forest(process[1], process[2], process[3], n)
    println(time() - t0)
    return res_predict
end