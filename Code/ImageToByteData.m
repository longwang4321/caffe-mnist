clear;
clc;
close all;

for k = 1 : 60000
    num_train=num2str(k);     
    imagename_train=strcat(num_train,'.png');
    imagepathname_train=strcat('E:\Python\Caffe\examples\mnist\mnist-原数据\train_data\',imagename_train);
    image_buffer_train=imread(imagepathname_train);
    images_data_train((k-1)*28*28+1:k*28*28) = reshape(image_buffer_train(1:28,1:28),1,28*28);
end

index_data_train=csvread('train_label.csv');

% fid1=fopen('mnist_bin(imageTobin)\train_images.bin','wb');
% fid2=fopen('mnist_bin(imageTobin)\train_labels.bin','wb');
fid1=fopen('mnist_bin(imageTobin)\train-images.idx3-ubyte','wb');
fid2=fopen('mnist_bin(imageTobin)\train_labels.idx3-ubyte','wb');
fwrite(fid1,images_data_train','uint8');
fwrite(fid2,index_data_train,'uint8');


for j = 1 : 10000
    num_test=num2str(j);     
    imagename_test=strcat(num_test,'.png');
    imagepathname_test=strcat('E:\Python\Caffe\examples\mnist\mnist-原数据\train_data\',imagename_test);
    image_buffer_test=imread(imagepathname_test);
    images_data_test((k-1)*28*28+1:k*28*28) = reshape(image_buffer_test(1:28,1:28),1,28*28);
end

index_data_test=csvread('test_label.csv');

% fid3=fopen('mnist_bin(imageTobin)\test_images.bin','wb');
% fid4=fopen('mnist_bin(imageTobin)\test_labels.bin','wb');
fid3=fopen('mnist_bin(imageTobin)\test-images.idx3-ubyte','wb');
fid4=fopen('mnist_bin(imageTobin)\test_labels.idx3-ubyte','wb');
fwrite(fid3,images_data_test','uint8');
fwrite(fid4,index_data_test,'uint8');
