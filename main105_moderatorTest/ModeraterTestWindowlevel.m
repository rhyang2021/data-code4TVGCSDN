clear;clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('/Users/yangruihan/Desktop/data&code/taskfMRI/resultData/finalData_windowLevel')
roiSeq = nchoosek(1:3,2);
data = FinalDataAll(:,[1,5:12,13:18]);
% data = data((data(:,1)==3)>0.5,:);
g1 = data(:,4);  % BA10 -> rTPJ
g2 = data(:,3);  % rDLPFC -> BA10
g3 = data(:,6);  % rDLPFC -> rTPJ
g4 = data(:,7);  % rTPJ -> rDLPFC
active = data(:,[13,14,15]);
phenoData = data(:,10:12);
g = deleteoutliers(g1,0.005,1);
idx1 = ~isnan(g);
% [~,idx1] = pbb_outlier(g1);
g = deleteoutliers(g2,0.005,1);
idx2 = ~isnan(g);
g = deleteoutliers(g3,0.005,1);
idx3 = ~isnan(g);
g = deleteoutliers(g4,0.005,1);
idx4 = ~isnan(g);
idx5 = idx3.*idx4;
g1 = g1(idx5==1,:);
g2 = g2(idx5==1,:);
g3 = g3(idx5==1,:);
g4 = g4(idx5==1,:);
y = data(idx5==1,8);
g12 = (g1-mean(g1)).*(g2-mean(g2)); 
g14 = (g1-mean(g1)).*(g4-mean(g4));
g13 = (g1-mean(g1)).*(g3-mean(g3));
g134 = ((g1-mean(g1)).*(g3-mean(g3))).*((g1-mean(g1)).*(g4-mean(g4)));
c1 = data(idx5==1,10);    % Gender
c2 = data(idx5==1,11);    % Age
c3 = data(idx5==1,12);    % SES --social economic status
c4 = data(idx5==1,13);    % Activation of BA10
c5 = data(idx5==1,14);    % Activation of rDLPFC
c6 = data(idx5==1,15);    % Activation of rTPJ
[~,tbl0] = anovan(y,{g1,g4,g14},...
    'continuous',1:3,'varnames',{'g1','g4','g1*g4'});
[~,tbl1] = anovan(y,{g1,g4,g14,c1,c2,c3,c4,c5,c6},...
    'continuous',1:9,'varnames',{'g1','g4','g1*g4','c1','c2','c3','c4','c5','c6'});
% [~,tbl2] = anovan(y,{g1,g2,g4,g12,g14,c1,c2,c3,c4,c5,c6},...
%     'continuous',1:11,'varnames',{'g1','g2','g4','g1*g2','g1*g4','c1','c2','c3','c4','c5','c6'});
[~,tbl3] = anovan(y,{g1,g3,g13,c1,c2,c3,c4,c5,c6},...
    'continuous',1:9,'varnames',{'g1','g3','g1*g3','c1','c2','c3','c4','c5','c6'});
% [~,tbl4] = anovan(y,{g1,g2,g3,g4,g12,g13,g14,c1,c2,c3,c4,c5,c6},...
%     'continuous',1:13,'varnames',{'g1','g2','g3','g4','g1*g2','g1*g3','g1*g4','c1','c2','c3','c4','c5','c6'});
[~,tbl5] = anovan(y,{g1,g3,g4,g13,g14,c1,c2,c3,c4,c5,c6},...
    'continuous',1:11,'varnames',{'g1','g3','g4','g13','g14','c1','c2','c3','c4','c5','c6'});
disp('The end ... ...')