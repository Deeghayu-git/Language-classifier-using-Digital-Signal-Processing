%%%%%%%%%%%%%%%%%%%%%%%%%training%%%%%%%%%%%%%%%%%%%

l_2=8192;

[num_a,den_a]=butter(6,[100,500]/(8000/2),'bandpass'); %filter 1

[num_b,den_b]=butter(6,[1000,1500]/(8000/2),'bandpass');    %filter 2

%give the direcory
p=dir('Training data path for language 1\*.wav');
q=dir('Training data path for language 2\*.wav');
ratio_tam=size(length(p));
ratio_sinh=size(length(q));

for r=1:length(p)
    temp_tam=p(r).name;
    temp_sinh=q(r).name;
    [y_test1,fs_test1]=audioread(['Training data path for language 1\',temp_lan1]);
    [y_test2,fs_test2]=audioread(['Training data path for language 2\',temp_lan2]);

            y1_t1=fft(y_test1);
            y1_avg1=abs(y1_t1);
            
            y1_t2=fft(y_test2);
            y1_avg2=abs(y1_t2);
            
            
%             figure
%             plot((0:(l_2/2)-1)*fs_test1/l_2,y1_avg1(1:l_2/2),'g');  %lan1
%             hold on
%             plot((0:(l_2/2)-1)*fs_test2/l_2,y1_avg2(1:l_2/2),'r');   %lan2
            
           
            y_test1_a = filter(num_a,den_a,y_test1);    %filter 1 for lan1
            Y1_a= fft(y_test1_a,l_2);
            Y_mag1_a= abs(Y1_a);
%             plot((0:(l_2/2)-1)*fs_test1/l_2,Y_mag1_a(1:l_2/2),'g');  %lan2
%             hold on
%             
            y_test1_b = filter(num_b,den_b,y_test1);    %filter 2 for lan1
            Y1_b= fft(y_test1_b,l_2);
            Y_mag1_b= abs(Y1_b);
%             plot((0:(l_2/2)-1)*fs_test1/l_2,Y_mag1_b(1:l_2/2),'g');
           
            ratio_tam(r)=sum((Y_mag1_a).^2)/sum((Y_mag1_b).^2);
            
            y_test2_a = filter(num_a,den_a,y_test2);    %filter 1 for lan2
            Y1_a= fft(y_test2_a,l_2);
            Y_mag2_a= abs(Y1_a);
%             plot((0:(l_2/2)-1)*fs_test1/l_2,Y_mag2_a(1:l_2/2),'r');
%             hold on  
            
            y_test2_b = filter(num_b,den_b,y_test2);    %filter 2 for lan2
            Y1_b= fft(y_test2_b,l_2);
            Y_mag2_b= abs(Y1_b);
%             plot((0:(l_2/2)-1)*fs_test1/l_2,Y_mag2_b(1:l_2/2),'r');
             
            ratio_sinh(r)=sum((Y_mag2_a).^2)/sum((Y_mag2_b).^2);
            
end


z=zeros(length(p),1);
figure;
scatter(ratio_tam,z,'g')
hold on
scatter(ratio_sinh,z,'r')
ratio_sinh

% By analysing take threshold as 100

%%%%%%%%%%%%%%%%%%%%%%%Testing%%%%%%%%%%%%%%%%%%%%%%%%%%

% l_2=8192;
% threshold= 100;
% 
% [num_a,den_a]=butter(6,[100,500]/(8000/2),'bandpass');   %filter 1
% 
% [num_b,den_b]=butter(6,[1000,1500]/(8000/2),'bandpass');   %filter 2
% 
% directory= dir('Testing data path for language 1\*.wav');
% 
% for r=1:length(directory)
%     temp=directory(r).name;
%     [y_test,fs_test]=audioread(['Testing data path for language 1\',temp]);
%     
%             y_test1_a = filter(num_a,den_a,y_test);    
%             Y1_a= fft(y_test1_a,l_2);
%             Y_mag1_a= abs(Y1_a);
%            
%             
%             y_test1_b = filter(num_b,den_b,y_test);    
%             Y1_b= fft(y_test1_b,l_2);
%             Y_mag1_b= abs(Y1_b);
%             
%             ratio=sum((Y_mag1_a).^2)/sum((Y_mag1_b).^2);
%             
%             if ratio<threshold
%                 disp('lan1');
% 
%             else
%                 disp('lan2');
% 
%             end
% end