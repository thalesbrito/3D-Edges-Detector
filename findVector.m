function [row1, col1] = findVector (vector, matrix)

    [row1,col1] = find(matrix(:,1) == vector(1));
    % row1 = sort(row1)
    % col1 = col1()

    [row2,col2] = find(matrix(row1,2) == vector(2));
    row1 = row1(row2);
    col1 = col1(col2);

    [row3,col3] = find(matrix(row1,3) == vector(3));
    row1 = row1(row3);
    col1 = col1(col3);
end