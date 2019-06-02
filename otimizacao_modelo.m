Mdl = fitcensemble(trainFeaturesMatrix, normTrainLabels, 'ClassNames', [-1,1], 'OptimizeHyperparameters', 'auto');
|===================================================================================================================================|
| Iter | Eval   | Objective   | Objective   | BestSoFar   | BestSoFar   |       Method | NumLearningC-|    LearnRate |  MinLeafSize |
|      | result |             | runtime     | (observed)  | (estim.)    |              | ycles        |              |              |
|===================================================================================================================================|
|    1 | Best   |     0.16667 |       8.195 |     0.16667 |     0.16667 |   LogitBoost |           12 |      0.10865 |         3315 |
|    2 | Accept |     0.16667 |       29.45 |     0.16667 |     0.16667 |   LogitBoost |           62 |    0.0043416 |           21 |
|    3 | Best   |     0.16644 |      9.0426 |     0.16644 |     0.16644 |  GentleBoost |           18 |      0.67202 |            2 |
|    4 | Accept |     0.17673 |      554.17 |     0.16644 |     0.16644 |   AdaBoostM1 |          252 |      0.34862 |          623 |
|    5 | Accept |     0.17066 |      15.611 |     0.16644 |     0.16644 |          Bag |           18 |            - |            2 |
|    6 | Accept |     0.43889 |      9.2866 |     0.16644 |     0.16667 |     RUSBoost |           10 |    0.0010135 |            3 |
|    7 | Accept |     0.16644 |      7.0239 |     0.16644 |     0.16644 |  GentleBoost |           18 |       0.6038 |            2 |
|    8 | Accept |     0.16644 |      7.4134 |     0.16644 |     0.16644 |  GentleBoost |           18 |      0.27651 |          764 |
|    9 | Accept |     0.16644 |      6.8502 |     0.16644 |     0.16644 |  GentleBoost |           18 |    0.0010232 |         3702 |
|   10 | Accept |     0.17389 |      188.59 |     0.16644 |     0.16648 |  GentleBoost |          498 |    0.0015528 |           35 |
|   11 | Best   |     0.16603 |      392.82 |     0.16603 |     0.16648 |          Bag |          499 |            - |            5 |
|   12 | Accept |      0.1669 |      3.9655 |     0.16603 |     0.16568 |  GentleBoost |           10 |    0.0097928 |         7207 |
|   13 | Accept |      0.1669 |      3.7947 |     0.16603 |      0.1661 |  GentleBoost |           10 |      0.13075 |         7610 |
|   14 | Accept |      0.1669 |      3.9067 |     0.16603 |     0.16605 |  GentleBoost |           10 |    0.0011228 |            1 |
|   15 | Accept |     0.16765 |      18.745 |     0.16603 |     0.16605 |   AdaBoostM1 |           10 |    0.0010488 |            9 |
|   16 | Accept |      0.1669 |      3.9066 |     0.16603 |     0.16667 |  GentleBoost |           10 |      0.99744 |          413 |
|   17 | Accept |     0.16748 |      195.37 |     0.16603 |     0.16662 |   LogitBoost |          500 |      0.75439 |            3 |
|   18 | Accept |     0.16667 |      4.1645 |     0.16603 |     0.16664 |   LogitBoost |           10 |     0.054852 |         3583 |
|   19 | Accept |     0.16667 |      147.37 |     0.16603 |     0.16665 |          Bag |          500 |            - |          514 |
|   20 | Accept |     0.16667 |      4.0373 |     0.16603 |     0.16667 |   LogitBoost |           10 |        0.022 |         4094 |
|===================================================================================================================================|
| Iter | Eval   | Objective   | Objective   | BestSoFar   | BestSoFar   |       Method | NumLearningC-|    LearnRate |  MinLeafSize |
|      | result |             | runtime     | (observed)  | (estim.)    |              | ycles        |              |              |
|===================================================================================================================================|
|   21 | Accept |     0.16667 |      4.0247 |     0.16603 |     0.16664 |   LogitBoost |           10 |    0.0024623 |         6137 |
|   22 | Accept |     0.16667 |      4.0404 |     0.16603 |     0.16664 |   LogitBoost |           10 |     0.040435 |         8264 |
|   23 | Accept |     0.43334 |      416.63 |     0.16603 |     0.16623 |     RUSBoost |          500 |    0.0099106 |            6 |
|   24 | Accept |     0.16667 |       8.068 |     0.16603 |     0.16616 |  GentleBoost |           22 |      0.01915 |         8086 |
|   25 | Accept |     0.16667 |      8.7896 |     0.16603 |     0.16658 |          Bag |           90 |            - |         8508 |
|   26 | Accept |     0.16667 |      42.408 |     0.16603 |     0.16659 |   AdaBoostM1 |           23 |     0.023469 |            2 |
|   27 | Accept |     0.16667 |      13.835 |     0.16603 |     0.16613 |          Bag |          142 |            - |         8188 |
|   28 | Accept |     0.16667 |      4.0764 |     0.16603 |     0.16613 |   LogitBoost |           10 |      0.42387 |            1 |
|   29 | Accept |     0.16794 |      20.567 |     0.16603 |     0.16657 |   AdaBoostM1 |           11 |      0.75312 |            1 |
|   30 | Accept |     0.16667 |      16.464 |     0.16603 |     0.16657 |          Bag |          171 |            - |         7663 |

__________________________________________________________
Optimization completed.
MaxObjectiveEvaluations of 30 reached.
Total function evaluations: 30
Total elapsed time: 2207.6173 seconds.
Total objective function evaluation time: 2152.6171

Best observed feasible point:
    Method    NumLearningCycles    LearnRate    MinLeafSize
    ______    _________________    _________    ___________

     Bag             499              NaN            5     

Observed objective function value = 0.16603
Estimated objective function value = 0.16657
Function evaluation time = 392.8197

Best estimated feasible point (according to models):
      Method       NumLearningCycles    LearnRate    MinLeafSize
    ___________    _________________    _________    ___________

    GentleBoost           18             0.27651         764    

Estimated objective function value = 0.16657
Estimated function evaluation time = 7.1849