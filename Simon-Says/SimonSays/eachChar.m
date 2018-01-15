function [] = eachChar( ard )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(ard)
    char = ard(i);
    touchIP(char);
end

end

