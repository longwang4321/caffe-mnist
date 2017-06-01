%该程序为使用caffe中mnist训练出来的model，来预测待测图片的标签

% ---------------------------------------自写程序--------------------------------------
clc;clear all;close all;

im=imread('/testimage/1.png');

figure;imshow(im);
%输入im要进行转置
[scores,maxlabel]=classification_fuction(im',0);%获取得分 第二个参数0：cpu 1:gpu

figure;plot(scores);%画出得分情况
axis([0,10,-0.1,1.5]);%坐标轴范围
grid on;%有网格

fid=fopen('label.txt','r');
i=0;
while ~feof(fid)%test for end-of-file
    i=i+1;
    lin=fgetl(fid);%read line from file
    lin=strtrim(lin);%remove the leading and trailing white-space from string
    if(i==maxlabel)
        fprintf('(English)the maxlabel of %d in label txt is %c\n',i,lin);
        break;
    end
end