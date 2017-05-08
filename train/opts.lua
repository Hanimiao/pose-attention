local M = { }

function M.parse(arg)
    local cmd = torch.CmdLine()
    cmd:text()
    cmd:text(' ---------- General options ------------------------------------')
    cmd:text()
    cmd:option('-expID',       'default', 'Experiment ID')
    cmd:option('-dataset',        'mpii', 'Dataset choice: mpii | flic')
    cmd:option('-dataDir',     '../data', 'Data directory')
    cmd:option('-expDir','../checkpoints','Experiments directory')
    cmd:option('-manualSeed',         -1, 'Manually set RNG seed')
    cmd:option('-GPU',                 1, 'Default preferred GPU, if set to -1: no GPU')
    cmd:option('-nGPU',                1, 'Number of GPUs to use by default')
    cmd:option('-finalPredictions',    0, 'Generate a final set of predictions at the end of training (default no, set to 1 for yes)')
    cmd:option('-nThreads',            8, 'Number of data loading threads')
    cmd:text()
    cmd:text(' ---------- Model options --------------------------------------')
    cmd:text()
    cmd:option('-netType','hg-attention', 'Options: hg-attention')
    cmd:option('-loadModel',      'none', 'Provide full path to a previously trained model')
    cmd:option('-optimState',      'none','Provide full path to a previously trained model') 
    cmd:option('-continue',        false, 'Pick up where an experiment left off')
    cmd:option('-branch',         'none', 'Provide a parent expID to branch off')
    cmd:option('-snapshot',            1, 'How often to take a snapshot of the model (0 = never)')
    cmd:option('-task',       'pose-int', 'Network task: pose | pose-int')
    cmd:option('-nFeats',            256, 'Number of features in the hourglass (for hg-generic)')
    cmd:option('-nStack',              8, 'Number of stacks in the provided hourglass model (for hg-generic)')
    cmd:option('-nModules',            1, 'Number of residual modules at each location in the hourglass')
    cmd:text()
    cmd:text(' ---------- Hyperparameter options -----------------------------')
    cmd:text()
    cmd:option('-LR',             2.5e-4, 'Learning rate')
    cmd:option('-LRdecay',           0.0, 'Learning rate decay')
    cmd:option('-momentum',          0.0, 'Momentum')
    cmd:option('-weightDecay',       0.0, 'Weight decay')
    cmd:option('-crit',            'MSE', 'Criterion type')
    cmd:option('-optMethod',   'rmsprop', 'Optimization method: rmsprop | sgd | nag | adadelta')
    cmd:option('-threshold',        .001, 'Threshold (on validation accuracy growth) to cut off training early')
    cmd:text()
    cmd:text(' ---------- Training options -----------------------------------')
    cmd:text()
    cmd:option('-nEpochs',           100, 'Total number of epochs to run')
    cmd:option('-trainIters',       3000, 'Number of train iterations per epoch')
    cmd:option('-trainBatch',          8, 'Mini-batch size')
    cmd:option('-validIters',        370, 'Number of validation iterations per epoch')
    cmd:option('-validBatch',          8, 'Mini-batch size for validation')
    cmd:text()
    cmd:text(' ---------- Data options ---------------------------------------')
    cmd:text()
    cmd:option('-inputRes',          256, 'Input image resolution')
    cmd:option('-outputRes',          64, 'Output heatmap resolution')
    cmd:option('-trainFile',          '', 'Name of training data file')
    cmd:option('-validFile',          '', 'Name of validation file')
    cmd:option('-scaleFactor',       .25, 'Degree of scale augmentation')
    cmd:option('-rotFactor',          30, 'Degree of rotation augmentation')
    cmd:text(' ---------- experiment seting ---------------------------------------')
    cmd:option('-LRNKer',              1, 'kernel size of LRN')
    cmd:option('-meanVal',           0.5, 'minus mean value of the input data')
    cmd:option('-trainBg',         false, 'if true, we will have np+1 labelmaps')
    cmd:option('-nPool',               4, 'pooling resolution 4')
    cmd:option('-poolUnit',        false, 'using pooling unit')
    local opt = cmd:parse(arg or {})
    opt.expDir = paths.concat(opt.expDir, opt.dataset)
    opt.dataDir = paths.concat(opt.dataDir, opt.dataset)
    opt.save = paths.concat(opt.expDir, opt.expID)
    return opt
end

return M
