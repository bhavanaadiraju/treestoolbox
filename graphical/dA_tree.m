% DA_TREE   Displays the adjacency matrix of a tree.
% (trees package)
%
% HP = dA_tree (intree, color, DD, xyscale, options)
% --------------------------------------------------
%
% Displays the adjacency matrix of a tree by filling in an N x N square
% with 1s and 0s if N < 50 and by black dots if tree is bigger.
%
% Input
% -----
% - intree   ::integer:      index of tree in trees structure or structured
%     tree or simply an adjacency matrix
% - color    ::RGB 3-tupel:  RGB values
%     {DEFAULT black [0 0 0]}
% - DD       :: XY-tupel or XYZ-tupel: coordinates offset
%     {DEFAULT no offset [0,0,0]}
% - xyscale  ::value: scaling factor for X and Y
%     {DEFAULT no scaling ==1}
% - options  ::string:
%     '-t'   : force text output
%     '-g'   : force graphical output
%     {DEFAULT ''}
%
% Output
% ------
% - HP       ::handles:      depending on options HP links to the graphical
%     objects.
%
% Example
% -------
% dA_tree      (sample2_tree, [1 0 0]); axis off;
% dA_tree      (sample_tree)
%
% See also   start_trees
% Uses       X, Y, Z
%
% the TREES toolbox: edit, generate, visualise and analyse neuronal trees
% Copyright (C) 2009 - 2023  Hermann Cuntz

function HP = dA_tree (intree, varargin)

%=============================== Parsing inputs ===============================%
p = inputParser;
p.addParameter('color', [0 0 0])
p.addParameter('DD', [0 0 0])
p.addParameter('xyscale', 1)
p.addParameter('t', false, @isBinary)
p.addParameter('g', false, @isBinary)
pars = parseArgs(p, varargin, {'color', 'DD', 'xyscale'}, {'t', 'g'});
%==============================================================================%

% use only directed adjacency for this function (obviously..)
if ~isstruct (intree)
    dA       = intree;
else
    ver_tree (intree);     % verify that input is a tree structure
    dA       = intree.dA;
end

if length (pars.DD) < 3
    % append 3-tupel with zeros:
    pars.DD      = [pars.DD (zeros (1, 3 - length (pars.DD)))];
end

N                = size (dA, 1); % number of nodes in tree
hold on;
% X and Y positions of non-zero entries of dA:
[Y, X]           = ind2sub (size (dA), find (dA));
X                = pars.xyscale * X + pars.DD (1);
Y                = pars.xyscale * Y - pars.DD (2);
if ...
        (~pars.g && (N < 50)) || ...
        (pars.t)
    HP1          = line ( ...
        repmat   (pars.xyscale  * (0.5 : 1 : N + 0.5), 2, 1)     + pars.DD (1), ...
        repmat   (-pars.xyscale * [0.5 (N + 0.5)]',    1, N + 1) + pars.DD (2));
    set          (HP1, ...
        'color',               pars.color);
    HP2          = line ( ...
        repmat   ( pars.xyscale * [0.5 (N + 0.5)]',    1, N + 1) + pars.DD (1), ...
        repmat   (-pars.xyscale * (0.5 : 1 : N + 0.5), 2, 1)     + pars.DD (2));
    set          (HP2, ...
        'color',               pars.color);
    HT1          = text (...
        pars.xyscale * (1 : N) + pars.DD (1), ...
        zeros     (1,  N) + pars.DD (2), ...
        num2str  ((1 : N)'));
    set          (HT1, ...
        'horizontalalignment', 'center', ...
        'color',               pars.color);
    HT2          = text (...
        zeros      (1,  N) + pars.DD (1), ...
        -pars.xyscale * (1 : N) + pars.DD (2),...
        num2str   ((1 : N)'));
    set          (HT2, ...
        'horizontalalignment', 'right', ...
        'verticalalignment',   'middle', ...
        'color',               pars.color);
    HT3          = text (X, -Y, '1');
    set          (HT3,...
        'horizontalalignment', 'center', ...
        'verticalalignment',   'middle', ...
        'color',               pars.color);
    HP3          = patch ( ...
        (repmat  (X,  1, 5) + ...
        repmat   (pars.xyscale * [-0.5 0.5  0.5 -0.5 -0.5], length (X), 1))', ...
        (repmat  (-Y, 1, 5) + ...
        repmat   (pars.xyscale * [ 0.5 0.5 -0.5 -0.5  0.5], length (X), 1))', ...
        pars.color);
    set          (HP3, ...
        'facealpha',           0.2, ...
        'linestyle',           'none');
    % the opposite... fill with "0":
    [Y, X]       = ind2sub (size (dA), find (~dA));
    X            = pars.xyscale * X + pars.DD (1);
    Y            = pars.xyscale * Y - pars.DD (2);
    HT4          = text (X, -Y, '0');
    set          (HT4,...
        'horizontalalignment', 'center', ...
        'verticalalignment',   'middle',...
        'color',               pars.color);
    HP           = [HP1; HP2; HP3; HT1; HT2; HT3; HT4];
else
    HP1          = line ( ...
        repmat   ( pars.xyscale * [0.5 (N + 0.5)]  + pars.DD (1), 2, 1), ...
        repmat   (-pars.xyscale * [0.5 (N + 0.5)]' + pars.DD (2), 1, 2));
    set          (HP1, ...
        'color',               pars.color);
    HP2          = line ( ...
        repmat   ( pars.xyscale * [0.5 (N + 0.5)]' + pars.DD (1), 1, 2),...
        repmat   (-pars.xyscale * [0.5 (N + 0.5)]  + pars.DD (2), 2, 1));
    set          (HP2, ...
        'color',               pars.color);
    HT1          = text ( ...
        pars.xyscale * [1 N]  + pars.DD (1), ...
        zeros     (1, 2) + pars.DD (2), ...
        num2str  ([1 N]'));
    set          (HT1, ...
        'verticalalignment',   'bottom', ...
        'horizontalalignment', 'center', ...
        'color',               pars.color);
    HT2          = text ( ...
        zeros      (1, 2) + pars.DD (1), ...
        -pars.xyscale * [1 N]  + pars.DD (2), ...
        num2str   ([1 N]'));
    set          (HT2, ...
        'horizontalalignment', 'right', ...
        'color',               pars.color);
    HP3          = patch ( ...
        (repmat (X, 1, 5) + ...
        repmat  (pars.xyscale * [-0.5 0.5  0.5 -0.5 -0.5], length (X), 1))', ...
        (repmat (-Y, 1, 5) + ...
        repmat  (pars.xyscale * [ 0.5 0.5 -0.5 -0.5  0.5], length (X), 1))', ...
        pars.color);
    set          (HP3, ...
        'facealpha',           0.2, ...
        'linestyle',           'none');
    HP4          = plot (X, -Y, 'ko');
    set          (HP4, ...
        'color',               pars.color, ...
        'Markerfacecolor', pars.color, ...
        'markersize', 4);
    HP           = [HP1; HP2; HP3; HP4; HT1; HT2];
end
if sum (get (gca, 'Dataaspectratio') == [1 1 1]) ~= 3
    axis         equal
end

