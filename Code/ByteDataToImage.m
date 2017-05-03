clear;
clc;
close all;

image_file_name = 'mnist_bin\train-images.idx3-ubyte';
index_file_name = 'mnist_bin\train-labels.idx1-ubyte';
image_file2_name = 'mnist_bin\test-images.idx3-ubyte';
index_file2_name = 'mnist_bin\test-labels.idx1-ubyte';

fid1 = fopen(image_file_name,'rb');
fid2 = fopen(index_file_name,'rb');
fid3 = fopen(image_file2_name,'rb');
fid4 = fopen(index_file2_name,'rb');

images_data_train = fread(fid1,'uint8');
index_data_train = fread(fid2,'uint8');
images_data_test = fread(fid3,'uint8');
index_data_test = fread(fid4,'uint8');

fclose(fid1);
fclose(fid2);
fclose(fid3);
fclose(fid4);

images_data_train_cut = images_data_train(17:end);
index_data_train_cut = index_data_train(9:end);
image_buffer_train = zeros(28,28);
images_data_test_cut = images_data_test(17:end);
index_data_test_cut = index_data_test(9:end);
image_buffer_test = zeros(28,28);

dlmwrite('train_label.csv',index_data_train_cut);           %训练集标签　
dlmwrite('test_label.csv',index_data_test_cut);             %测试集标签

for k = 1 : length(images_data_train_cut)/28/28
    image_buffer_train = reshape(images_data_train_cut((k-1)*28*28 + 1 : k*28*28),28,28);
    num_train=num2str(k);     
    imagename_train=strcat(num_train,'.png');
    imagepathname_train=strcat('E:\Python\Caffe\examples\mnist\mnist-原数据\train_data\',imagename_train);
    %imshow(uint8(image_buffer)');
    %title(num2str(index_data(k)));
    imwrite(uint8(image_buffer_train)',imagepathname_train);   %训练集数据　　
    %pause(0.1);
end
for j = 1 : length(images_data_test_cut)/28/28
    image_buffer_test = reshape(images_data_test_cut((j-1)*28*28 + 1 : j*28*28),28,28);
    num_test=num2str(j);     
    imagename_test=strcat(num_test,'.png');
    imagepathname_test=strcat('E:\Python\Caffe\examples\mnist\mnist-原数据\test_data\',imagename_test);
    %imshow(uint8(image_buffer)');
    %title(num2str(index_data(k)));
    imwrite(uint8(image_buffer_test)',imagepathname_test); %测试集数据　
    %pause(0.1);
end
