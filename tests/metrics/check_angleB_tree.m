%% check_angleB_tree

%% test 1
angleB_tree      (sample_tree, '-m');

%% test 2
dLPTCs           = load_tree ('dLPTCs.mtr');
for counterN     = 1 : 100
    for counter  = 1 : length (dLPTCs{1})
        tree     = dLPTCs{1}{counter};
        angleB_tree  (tree);
    end
end

%% test 3
angleB_tree      (sample_tree, '-s');
tprint           ('./panels/angleB_tree1', ...
    '-jpg -HR',                [10 10]);

%% test 4
tree             = sample2_tree;
angleB           = angleB_tree (tree);
clf;
HP               = plot_tree   (tree, [1 0 0], [], [], [], '-b');
set              (HP, ...
    'facealpha',               0.2, ...
    'edgecolor',               'none');

HP               = patch ( ...
    [ ...
    (tree.X (3)) (tree.X (10)) ...
    (tree.X (10) + tree.X (4) - tree.X (3)) (tree.X (4))], ...
    [ ...
    (tree.Y (3)) (tree.Y (10)) ...
    (tree.Y (10) + tree.Y (4) - tree.Y (3)) (tree.Y (4))], ...
    [ ...
    (tree.Z (3)) (tree.Z (10)) ...
    (tree.Z (10) + tree.Z (4) - tree.Z (3)) (tree.Z (4))], [0 0 0]);
set              (HP, ...
    'facealpha',               0.2, ...
    'linestyle','none');
vtext_tree       (sample2_tree, [], [0 0 0]);
axis             off;
tprint           ('./panels/angleB_tree2', ...
    '-jpg -HR',                [10 10]);
