function index = colorindex(colors, color)
    index = 1;
    for i=1:idivide(numel(colors), int16(4), 'fix')
       if colors(i,1) == color(1) && colors(i,2) == color(2) && colors(i,3) == color(3)
           index = colors(i,4);
           break;
       end
    end
end