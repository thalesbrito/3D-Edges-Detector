D = cursor_info(1).Position
C = cursor_info(2).Position
B = cursor_info(3).Position
A = cursor_info(4).Position
[rowA, col1] = findVector(A,obj.v);
[rowB, col2] = findVector(B,obj.v);
[rowC, col3] = findVector(C,obj.v);
[rowD, col3] = findVector(D,obj.v);
rowA'
rowB'
rowC'
rowD'

[rowA, col] = find(noDuplicateFaces ==rowA(1));
[rowB, col] = find(noDuplicateFaces ==rowB(2));
[rowC, col] = find(noDuplicateFaces ==rowC(1));
rowA'
rowB'
rowC'
