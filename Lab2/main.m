clear; close all;

file_x = fopen('lab2x.txt','r');
X = fscanf(file_x,'%d');
fclose(file_x);

file_y = fopen('lab2y.txt','r');
Y = fscanf(file_y,'%d');
fclose(file_y);
X_str = num2str(X);
Y_str = num2str(Y);

X_dec(X_str(:,1) == '1') = (1023-bin2dec(X_str(X_str(:,1) == '1',:))+1) * -1;
Y_dec(Y_str(:,1) == '1') = (1023-bin2dec(Y_str(Y_str(:,1) == '1',:))+1) * -1;

X_dec(X_str(:,1) ~= '1') = bin2dec(X_str(X_str(:,1) ~= '1',:));
Y_dec(Y_str(:,1) ~= '1') = bin2dec(Y_str(Y_str(:,1) ~= '1',:));


% F = 5;
% X_dec = X_dec ./ 2^F;
% Y_dec = Y_dec ./ 2^F;

MAC = 0;
max_MAC = 0;
for i = 1:1000
    MAC = MAC + X_dec(i) * Y_dec(i);
    if(MAC > max_MAC)
        max_MAC = MAC;
    end
end







