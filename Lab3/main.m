clear; close all;

% result
file_x = fopen('lab3out.txt','r');
A = fscanf(file_x,'%s');
fclose(file_x);
A = strsplit(A,{'\n'})';
A = char(A);
for i = 1:999
    temp(i,:) = A((i-1)*17+1:(i)*17);
end
A = temp;
A_str = num2str(A);
A_dec(A_str(:,1) == '1') = (131071-bin2dec(A_str(A_str(:,1) == '1',:))+1) * -1;
A_dec(A_str(:,1) ~= '1') = bin2dec(A_str(A_str(:,1) ~= '1',:));
A_dec = A_dec';

F = 15;
A_dec = A_dec ./ 2^F;

% converted
file_x = fopen('lab3x.txt','r');
B = fscanf(file_x,'%c');
fclose(file_x);
X = strsplit(B,{'\n'})';
X = char(X);

X_str = num2str(X);
X_dec(X_str(:,1) == '1') = (65535-bin2dec(X_str(X_str(:,1) == '1',:))+1) * -1;
X_dec(X_str(:,1) ~= '1') = bin2dec(X_str(X_str(:,1) ~= '1',:));
X_dec = X_dec';

F = 15;
X_dec = X_dec ./ 2^F;

% filter coeff
file_x = fopen('lab3coef.txt','r');
C = fscanf(file_x,'%c');
fclose(file_x);
C = strsplit(C,{'\n'})';
C = char(C);

C_str = num2str(C);
C_dec(C_str(:,1) == '1') = (65535-bin2dec(C_str(C_str(:,1) == '1',:))+1) * -1;
C_dec(C_str(:,1) ~= '1') = bin2dec(C_str(C_str(:,1) ~= '1',:));
C_dec = C_dec';

F = 15;
C_dec = C_dec ./ 2^F;

y_expected = filter(C_dec,1,X_dec);
figure,
plot(A_dec)
hold on
plot(y_expected)

error_pwr = (A_dec - y_expected).^2;
plot(error_pwr)

rmse = sqrt(sum((A_dec - y_expected).^2)/999)






