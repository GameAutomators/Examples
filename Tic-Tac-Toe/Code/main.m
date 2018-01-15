%% Create a 9x9 Matrix to store the pixel values of the red layer of all the ...
%%  9 boxes for all the images
a = zeros(9,9);

%% Initialise the first pic. It's completely white
for p=1:9
    a(1,p)=255;
end

%% Mark a point in each box where we can differentiate the appearance of ...
%% red circle from pixel values
b=[867,46;863,407;871,771;1223,46;1227,411;1223,771;1587,42;1591,407;1591,767];

%% Start with the 9th box.
system('adb shell input swipe 767 1591 767 1591 10');

 %% Screenpic takes the screenshot,pulls it to the working laptop and detects ...
 %% the difference between two sucessive screenshots
 [a,p1]=screenpic(a,2);
 
 %% s1,s2,s3,s4,s5 are our moves 
 %% p1,p2,p3,p4 are the system automated moves
 %% The following code depicts our move based on the previous system automated ...
 %% move considering all possible cases
 
 
 %% System's First move
 %% Case1:
 if(p1==1 | p1==3)  
 	s2=7;
    system('adb shell input swipe 42 1587 42 1587 100');
 %% Case 2:
 elseif(p1==2 | p1==4 | p1==7)  
 	s2=3;
    system('adb shell input swipe 771 871 771 871 100');
 %% Case 3:
 elseif(p1==5 | p1==6 | p1==8)  
 	s2=1;
    system('adb shell input swipe 46 867 46 867 100');
 end

 %% System's Second move
 [a,p2]=screenpic(a,3);
 %% Case1:
 if(p1==1)
    if(p2~=8)   
    	   s3=8;
    	   system('adb shell input swipe 407 1591 407 1591 100');
    else
       s3=3;
       system('adb shell input swipe 771 871 771 871 100');
       [a,p3]=screenpic(a,4);
       if(p3~=5)  
       	 s4=5;
       	system('adb shell input swipe 411 1227 411 1227 100');
       else   
       	s4=6;
         system('adb shell input swipe 771 1223 771 1223 100');
       end
    end
 end
 %% Case2:
 if(p1==3)
    if(p2~=8)  
    	  s3=8;
    	  system('adb shell input swipe 407 1591 407 1591 100');
    else
        s3=1;
        system('adb shell input swipe 46 867 46 867 100');
        [a,p3]=screenpic(a,4);
        if(p3~=5) 
        	  s4=5;
        	  system('adb shell input swipe 411 1227 411 1227 100');
        else 
        	  s4=4;
        	 system('adb shell input swipe 46 1223 46 1223 100');
        end
    end
 end
 %% Case3:
 if(p1==7)
     if(p2~=6)   
     	s3=6;
         system('adb shell input swipe 771 1223 771 1223 100');
     else
         s3=1;
         system('adb shell input swipe 46 867 46 867 100');;
         [a,p3]=screenpic(a,4);
         if(p3==5) 
         	s4=2;
             system('adb shell input swipe 407 863 407 863 100');
         else   
         	s4=5;
             system('adb shell input swipe 411 1227 411 1227 100');
         end
     end
 end
 %% Case4:
 if(p1==2)
     if(p2~=6)   
     	s3=6;
        system('adb shell input swipe 771 1223 771 1223 100');
     else
         s3=5;
         system('adb shell input swipe 411 1227 411 1227 100');
         [a,p3]=screenpic(a,4);
         if(p3==1)  
         	s4=7;
             system('adb shell input swipe 42 1587 42 1587 100');
         else   
         	s4=1;
             system('adb shell input swipe 46 867 46 867 100');
         end
     end
 end
 %% Case5:
 if(p1==4)
     if(p2~=6)   
     	s3=6;
        system('adb shell input swipe 771 1223 771 1223 100');
     else
         s3=5;
         system('adb shell input swipe 411 1227 411 1227 100');
         [a,p3]=screenpic(a,4);
         if(p3==1)  
         	s4=7;
             system('adb shell input swipe 42 1587 42 1587 100');
         else   
         	s4=1;
             system('adb shell input swipe 46 867 46 867 100');
         end
     end
 end
 %% Case6:
 if(p1==6)
     if(p2~=5)   
     	s3=5;
         system('adb shell input swipe 411 1227 411 1227 100');
     else
         s3=4;
         system('adb shell input swipe 46 1223 46 1223 100');
         [a,p3]=screenpic(a,4);
         y=[2,8;8,2;3,7;7,3];
         for c=1:4
            if(p3==y(c,1))   
            	   s4=y(c,2);
            	   system(['adb shell input swipe' ' ' num2str(b(s4,2)) ' ' num2str(b(s4,1)) ...
         ' ' num2str(b(s4,2)) ' ' num2str(b(s4,1)) ' 100']);
            	   break;
            end
         end
         [a,p4]=screenpic(a,5);
         for c=1:4
            if(p4==y(c,1))   
            	   s5=y(c,2);
            	   system(['adb shell input swipe' ' ' num2str(b(s5,2)) ' ' num2str(b(s5,1)) ...
         ' ' num2str(b(s5,2)) ' ' num2str(b(s5,1)) ' 100']);
            	   break;
            end
         end
     end
 end
  %% Case 7:
 if(p1==8)
     if(p2~=5)   
     	s3=5;
         system('adb shell input swipe 411 1227 411 1227 100');
      else
         s3=2;
         system('adb shell input swipe 407 863 407 863 100');
         [a,p3]=screenpic(a,4);
         z=[4,6;6,4;3,7;7,3];
         for d=1:4
            if(p3==z(d,1))   
            	   s4=z(d,2);
            	   system(['adb shell input swipe' ' ' num2str(b(s4,2)) ' ' num2str(b(s4,1)) ...
         ' ' num2str(b(s4,2)) ' ' num2str(b(s4,1)) ' 100']);
            	   break;
            end
         end;
         [a,p4]=screenpic(a,5);
         for d=1:4
            if(p4==z(d,1))   
            	   s5=z(d,2);
            	   system(['adb shell input swipe' ' ' num2str(b(s5,2)) ' ' num2str(b(s5,1)) ...
         ' ' num2str(b(s5,2)) ' ' num2str(b(s5,1)) ' 100']);
            	   break;
            end
         end
      end
 end
 %% Case8:
 if(p1==5)
     if(p2==7)
          s3=3;
          system('adb shell input swipe 771 871 771 871 100');
          [a,p3]=screenpic(a,4);
          if(p3==2)   
          	s4=6;
          system('adb shell input swipe 771 1223 771 1223 100');
          else   
         	s4=2;
          system('adb shell input swipe 407 863 407 863 100');
          end
     elseif(p2==3)
          s3=7;
          system('adb shell input swipe 42 1587 42 1587 100');
          [a,p3]=screenpic(a,4);
          if(p3==4)   
          	s4=8;
             system('adb shell input swipe 407 1591 407 1591 100');
          else    
          	s4=4;
             system('adb shell input swipe 46 1223 46 1223 100');
          end
      else
          x=[2,8;8,2;4,6;6,4;3,7;7,3];
         for i=1:6
            if(p2==x(i,1))   
            	   s3=x(i,2);
            	   system(['adb shell input swipe' ' ' num2str(b(s3,2)) ' ' num2str(b(s3,1)) ...
         ' ' num2str(b(s3,2)) ' ' num2str(b(s3,1)) ' 100']);
            	   break;
            end
         end
         [a,p3]=screenpic(a,4);
         for i=1:6
            if(p3==x(i,1))   
            	  s4=x(i,2);
            	  system(['adb shell input swipe' ' ' num2str(b(s4,2)) ' ' num2str(b(s4,1)) ...
         ' ' num2str(b(s4,2)) ' ' num2str(b(s4,1)) ' 100']);
            	  break;
            end
         end
         [a,p4]=screenpic(a,5);
         for i=1:6
            if(p4==x(i,1))   
            	  s5=x(i,2);
            	  system(['adb shell input swipe' ' ' num2str(b(s5,2)) ' ' num2str(b(s5,1)) ...
         ' ' num2str(b(s5,2)) ' ' num2str(b(s5,1)) ' 100']);
            end
         end
     end
 end