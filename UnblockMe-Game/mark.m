function grid = mark(grid, S, start)
    grid = strcat(grid, ',');
    j = idivide(S.BoundingBox(1), int16(112), 'round');
    i = idivide(S.BoundingBox(2), int16(112), 'round');
    grid = strcat(grid, num2str(j));
    grid = strcat(grid, num2str(i));
    if S.BoundingBox(3) > S.BoundingBox(4)
        w = idivide(S.BoundingBox(3), int16(112), 'round');
        grid = strcat(grid, num2str(w));
        grid = strcat(grid, '1');
    else
        w = idivide(S.BoundingBox(4), int16(112), 'round');
        grid = strcat(grid, '1');
        grid = strcat(grid, num2str(w));
    end
    if start == 1
       grid = strcat(grid, 'g');
    end
end