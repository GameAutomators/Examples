% % capturing screenshot and saving it to sdcard of the android device
    system('adb shell screencap -p /sdcard/screen2.png');

% %  pulling image to your working directory
    system('adb pull /sdcard/screen2.png');
    
% % reading the image
im=imread('screen2.png');
imshow(im);
% % storing the notes of a song in a matrix
mat1=['C','C','D','C','F', 'E','C','C','D','C','G','F', 'C', 'C', 'K', 'A', 'F', 'E','D', '5', '5','A', 'F', 'G', 'E' ];
for a = 1:25
    switch mat1(a)
 case 'C'
     % % Simulating the touch with the coordinates
       cmd=['adb shell input swipe 64 621 65 622 '];
system(cmd);  
      
   case '1'
       cmd=['adb shell input swipe 128 371 129 372 '];
system(cmd);
      
   case 'D'
       cmd=['adb shell input swipe 181 605 182 606 '];
system(cmd);  
      
   
   case 'E'
       cmd=['adb shell input swipe 328 596 329 597 '];
system(cmd);
      
   case 'F'
       cmd=['adb shell input swipe 435 588 436 589 '];
system(cmd);
      
   case 'G'
       cmd=['adb shell input swipe 563 609 564 610 '];
system(cmd);
      
   case 'A'
       cmd=['adb shell input swipe 688 604 689 605 '];
system(cmd);
     
   case 'B'
       cmd=['adb shell input swipe 837 585 838 586 '];
system(cmd);
      
     case '2'
         cmd=['adb shell input swipe 428 263 429 264 '];
system(cmd);
      
       case '3'
           cmd=['adb shell input swipe 362 497 363 498 '];
system(cmd);
     
      case '4'
          cmd=['adb shell input swipe 377 629 378 630 '];
system(cmd);
      
       case '5'
           cmd=['adb shell input swipe 365 791 366 792 '];
system(cmd);
      case 'K'
           cmd=['adb shell input swipe 965 574 966 575 '];
system(cmd);
        
   
   otherwise
      x=0; y=0;
    end
end
