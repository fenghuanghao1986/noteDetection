clc;
clear;
warning off

time_file = 'D:\Howard_Feng\georgia_tech\espression_test\all_expression_time_stemp.csv';
select_data_path = 'D:\Howard_Feng\georgia_tech\espression_test\select_data';
fileType = '*.csv';

dd = dir(fullfile(select_data_path, fileType));
fileNames = {dd.name};
num = numel(fileNames);

whole_file = csvread(time_file);

time_mtrx = whole_file(1:20, 2:47);
loop_selection = whole_file(49: 69, 2: 7);

data = cell(num, 2);
data(:,1) = regexprep(fileNames, '.csv','');

znorm_q1_filter = cell(num, 1);
znorm_q2_filter = cell(num, 1);

scale_range = 1:100;

% 
% for i = 1: 15
%     for n = 1:7
%         frame_length(i, n) = time_mtrx(i, 2*n) - time_mtrx(i, 2*n-1);
%     end
% end

for file_num = 1: numel(fileNames)
    
    data{file_num, 2} = dlmread(fullfile(select_data_path, fileNames{file_num}));
    fprintf('reading q sensor data\n');
    q1_data = data{file_num, 2}(:, 4);
    q2_data = data{file_num, 2}(:, 7);
    
    [znorm_q1, mu_q1, sigma_q1] = zscore(q1_data);
    [znorm_q2, mu_q2, sigma_q2] = zscore(q2_data);
    
    fprintf('Znorm done for subject %d on both sensors\n', file_num);
    
    znorm_q1_filter{file_num} = medfilt1(znorm_q1.', 1);
    znorm_q2_filter{file_num} = medfilt1(znorm_q2.', 1); 
    
    start_frame = 0;
    end_frame = 0;
    
    for expression_num = 1:6
        
        switch expression_num
            case 1
                expression = 'Neutral';
            case 2
                expression = 'Smile_1';
            case 3
                expression = 'Smile_2';
            case 4
                expression = 'Smile_3';
            case 5
                expression = 'Negative';
            otherwise
                expression = 'Hat';
        end
        
        mkdir('D:\Howard_Feng\georgia_tech\espression_test\Raw_Expression', sprintf('Expression_%s', expression));
        fprintf('Loading expression %d data\n', expression_num);
        
        loop_num = loop_selection(file_num + 1, expression_num);
        
        if loop_num ~= 0;
                        
            for i = 1:loop_num
                
                start_frame = time_mtrx(file_num, i * 2 - 1);
                end_frame = time_mtrx(file_num, i * 2);
                
                expression_m_q1_plot = znorm_q1_filter{file_num}(start_frame: end_frame);
                expression_m_q2_plot = znorm_q2_filter{file_num}(start_frame: end_frame);
                
                expression_m_q1 = znorm_q1_filter{file_num}(start_frame: end_frame);
                expression_m_q2 = znorm_q2_filter{file_num}(start_frame: end_frame);

                expression_m_q1_spect{file_num, i} = imresize(expression_m_q1, [1, 32], ...
                    'bicubic');
                expression_m_q2_spect{file_num, i} = imresize(expression_m_q2, [1, 32], ...
                    'bicubic');
                
%                 BEpoch = 1: 10;
%                 BaseMat_1 = (expression_m_q1_spect{file_num, i}(:, BEpoch))';
%                 BaseMean_1 = repmat(mean(BaseMat_1)', 1, size(expression_m_q1_spect{file_num, i}, 2));
%                 BaseStd_1 = repmat(std(BaseMat_1)', 1, size(expression_m_q1_spect{file_num, i}, 2));
%                 expression_m_q1_spect{file_num, i} = (expression_m_q1_spect{file_num, i} - BaseMean_1) ./ BaseStd_1;
% 
% 
%                 BEpoch = 1: 10;
%                 BaseMat_2 = (expression_m_q2_spect{file_num, i}(:, BEpoch))';
%                 BaseMean_2 = repmat(mean(BaseMat_2)', 1, size(expression_m_q2_spect{file_num, i}, 2));
%                 BaseStd_2 = repmat(std(BaseMat_2)', 1, size(expression_m_q2_spect{file_num, i}, 2));
%                 expression_m_q2_spect{file_num, i} = (expression_m_q2_spect{file_num, i} - BaseMean_2) ./ BaseStd_2;
%         
                save_folder = ...
                    sprintf('D:\\Howard_Feng\\georgia_tech\\espression_test\\Raw_Expression\\Expression_%s\\', expression);
                
                q1_save_name = sprintf('subject_%d_expression_%s_q1.mat', file_num, expression);
                q2_save_name = sprintf('subject_%d_expression_%s_q2.mat', file_num, expression);
                
                saved_q1_spect_expression_m_clip = expression_m_q1_spect{file_num, i};
                saved_q2_spect_expression_m_clip = expression_m_q2_spect{file_num, i};
                
                save(fullfile(save_folder, q1_save_name), 'saved_q1_spect_expression_m_clip');
                save(fullfile(save_folder, q2_save_name), 'saved_q2_spect_expression_m_clip');

                id1 = figure;
                
                hold on
                grid on
                
                subplot(2,1,1);
                plot(expression_m_q1_plot(2:end), 'r');
                title(sprintf('subject %d expression_%s, q1, znorm filt data', file_num, expression));
                subplot(2,1,2);
                imagesc(expression_m_q1_spect{file_num, i});
                title(sprintf('subject%d expression %s, q1, sepectrogram data', file_num, expression));
                xlabel('frame(1/32)s');
                ylabel('EDA(us)');
                
                saveas(id1, strcat(save_folder, sprintf('subject_%d_expression_%s_q1_%s.fig', ...
                    file_num, expression, fileNames{file_num})));
                saveas(id1, strcat(save_folder, sprintf('subject_%d_expression_%s_q1_%s.tif', ...
                    file_num, expression, fileNames{file_num})));
                
                id2 = figure;
                
                hold on
                grid on
                
                subplot(2,1,1);
                plot(expression_m_q2_plot(2:end), 'r');
                title(sprintf('subject %d expression_%s, q2, znorm filt data', file_num, expression));
                subplot(2,1,2);
                imagesc(expression_m_q2_spect{file_num, i});
                title(sprintf('subject %d expression %s, q2, sepectrogram data', file_num, expression));
                xlabel('frame(1/32)s');
                ylabel('EDA(us)');
                
                saveas(id2, strcat(save_folder, sprintf('subject_%d_expression_%s_q2_%s.fig', ...
                    file_num, expression, fileNames{file_num})));
                saveas(id2, strcat(save_folder, sprintf('subject_%d_expression_%s_q2_%s.tif', ...
                    file_num, expression, fileNames{file_num})));
                
                close all;
                
                expression_m_q1 = [];
                expression_m_q2 = [];
                saved_q1_spect_expression_m_clip = [];
                saved_q2_spect_expression_m_clip = [];
                expression_m_q1_plot = [];
                expression_m_q2_plot = [];
                
                
            end
            
            
%             do stuff



        else fprintf('for subject %d, doesn''t show expression #%d\n', file_num, expression_num);
        end
        
    end
    
    
%     for exp_num = 1: 3
%         loop_num = loop_selection(sub_num +1 , exp_num);
%         if loop_selection(sub_num + 1, exp_num) ~= 0;
%             fprintf('do %d times\n', loop_num);
%             
%         end
%     end
% end
end
