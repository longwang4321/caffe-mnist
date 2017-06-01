function [scores, maxlabel] = classification_fuction(im, use_gpu)  

if exist('+caffe', 'dir')  
  addpath('');  
else  
  error('Please run this demo from caffe/matlab/demo');  
end  
  
% Set caffe mode  
if exist('use_gpu', 'var') && use_gpu  
  caffe.set_mode_gpu();  
  gpu_id = 0;  % we will use the first gpu in this demo  
  caffe.set_device(gpu_id);  
else  
  caffe.set_mode_cpu();  
end  
  
% Initialize the network using BVLC CaffeNet for image classification  
% Weights (parameter) file needs to be downloaded from Model Zoo.  
model_dir = '../';  
net_model = [model_dir 'lenet_deploy.prototxt'];  
net_weights = [model_dir 'lenet_iter_10000.caffemodel'];  
phase = 'test'; % run with phase test (so that dropout isn't applied)  
if ~exist(net_weights, 'file')  
  error('Please download CaffeNet from Model Zoo before you run this demo');  
end  
  
% Initialize a network  
net = caffe.Net(net_model, net_weights, phase);  
% prepare oversampled input  
% input_data is Height x Width x Channel x Num  
tic;  
    mean_data = caffe.io.read_mean('../mean.binaryproto');  
    scale=0.00390625;  
    im=double(im);  
    im=(im-mean_data)*scale;  
    input_data = {im};  
toc;  
  
% do forward pass to get scores  
% scores are now Channels x Num, where Channels == 1000  
tic;  
% The net forward function. It takes in a cell array of N-D arrays  
% (where N == 4 here) containing data of input blob(s) and outputs a cell  
% array containing data from output blob(s)  
scores = net.forward(input_data);  
toc;
  
scores = scores{1};  
scores = mean(scores, 2);  % take average scores over 10 crops  
[~, maxlabel] = max(scores);  

% call caffe.reset_all() to reset caffe  
caffe.reset_all(); 