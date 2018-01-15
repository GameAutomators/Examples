function xy = touchIP( ardXY )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   y-400,800 b-200,400 r-200,800 g-400,400

    if(ardXY == 'B')
        xy = '200 450';
    end
    if(ardXY == 'G')
        xy = '550 450';
    end
    if(ardXY == 'Y')
        xy = '550 800';
    end
    if(ardXY == 'R')
        xy = '200 800';
    end
system(['adb shell input swipe ' xy ' 375 625 100']);
end

