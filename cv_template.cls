\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my_cv}[2011/03/26 My custom CV class]
\LoadClass{article}

\RequirePackage{titlesec}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{xparse}
\RequirePackage{hyperref}
\RequirePackage{geometry}
\RequirePackage{float}
\RequirePackage{graphicx}
%  ----------------------------
%           SPACING
%  ----------------------------

% -------- PAGE MARGINS
\def\Lmargin{1.5cm}
\def\Rmargin{1.5cm}
\def\Tmargin{1.5cm}
\def\Bmargin{1.5cm}

\def\titleTopSpacing{-\baselineskip} % default = -\baselineskip
\def\titleBottomMargin{-\baselineskip} % default = -\baselineskip
\def\titleInnerTopSpacing{-\baselineskip} % default = -\baselineskip
\def\titleInnerBottomSpacing{-1.25\baselineskip} % default = -1.25\baselineskip

\def\sectionTopSpacing{2.5ex plus 1ex minus .2ex} % default = 1ex plus 1ex minus .2ex
\def\sectionBottomSpacing{0em} % default = 1ex plus 1ex minus .2ex

\def\subsectionTopSpacing{0em}
\def\subsectionBottomSpacing{-\baselineskip}

\def\datedsubsectionTopSpacing{-0.5\baselineskip} % default =
\def\datedsubsectionBottomSpacing{-2em plus 0em minus 0em} % default =

\def\workitemTopSpacing{1em plus 0em minus 0em}
\def\workitemBottomSpacing{-\baselineskip}
\def\workitemBetweenSpacing{0em}



% ---------- END SPACING -----------
\geometry{
  a4paper,
  portrait,
  left=\Lmargin,
  right=\Rmargin, 
  top=\Tmargin,
  bottom=\Bmargin
}

% ----------- SECTION ------------------
\titleformat{\section}         % Customise the \section command 
  {\Large\scshape\raggedright} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           % Can be used to insert code before the heading
  [\titlerule]                 % Inserts a horizontal line after the heading

\titlespacing*{\section}{0pt}{\sectionTopSpacing}{\sectionBottomSpacing}
% -------------------------------------

% ------------ SUBSECTION --------------
\titleformat{\subsection}
{\large\scshape\raggedright}
{}{0em}
{}

\titlespacing*{\subsection}{0pt}{\subsectionTopSpacing}{\subsectionBottomSpacing}
% --------------------------------------


% ----------- NAME AND CONTACT -----------
\ExplSyntaxOn
\newcommand{\nameAndContact}[1]{
  \vspace*{\titleTopSpacing}
  
  \clist_set:Nn \contactList {#1} % Store the clist in a temporary variable
  \clist_pop:NN \contactList \firstContact % Pop the first item and store it in a token list
  
  \begin{table}[!htbp]
      \vspace*{\titleInnerTopSpacing}
      
      \begin{tabularx}{\textwidth}{ >{\Huge\centering\arraybackslash}X r}
          \multirow{\clist_count:N \contactList }{*}{ \firstContact }
          \clist_map_inline:Nn \contactList { & ##1 \\ }
      \end{tabularx}

      \vspace*{\titleInnerBottomSpacing} 
  \end{table}
    
  \vspace*{\titleBottomMargin} 
}
\ExplSyntaxOff
% ------------------------------------------


% ----------- PHOTO + NAME AND CONTACT -----------
\ExplSyntaxOn
\NewDocumentCommand{\cvHeader}{o m m}{%
  % #1 = photo - optional
  % #2 = name
  % #3 = list of contacts
  \vspace*{\titleTopSpacing}
  
  \clist_set:Nn \contactList {#3} % Store the clist in a temporary variable
  \clist_pop:NN \contactList \firstContact % Pop the first item and store it in a token list

  \begin{table}[!htbp]
      \vspace*{\titleInnerTopSpacing}

      % Version 1 - with photo
      \IfValueTF{#1}{%
        \begin{tabularx}{\textwidth}{>{\centering\arraybackslash}c >{\huge\centering\arraybackslash}X r }
          \multirow{\clist_count:N \contactList}{*}{ \includegraphics[height=2.5cm]{#1} } &
          \multirow{\clist_count:N \contactList }{*}{ #2 } & \firstContact \\
          \clist_map_inline:Nn \contactList { & & ##1 \\ }
        \end{tabularx}
      }{%
        % Version 2 - no photo
        \begin{tabularx}{\textwidth}{>{\Huge\centering\arraybackslash}X r }
          \multirow{\clist_count:N \contactList }{*}{ #2 } & \firstContact \\
          \clist_map_inline:Nn \contactList { & ##1 \\ }
        \end{tabularx}
      }
      \vspace*{\titleInnerBottomSpacing} 
  \end{table}
    
  \vspace*{\titleBottomMargin} 
}
\ExplSyntaxOff
% ------------------------------------------


% -------- DATED SECTION --------
\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}
% -------------------------------

% --------- DATED SUBSECTION ------------
% Make subsection with 3 columns
\NewDocumentCommand{\datedsubsection}{ O{X} O{X} O{X} m m m }{%\
  \subsection[#4]{}
  % removes margin before eliminates the space between the first line and the table. 
  % You can replace the size with some other value to adjust
  % the vertical spacing, for example \vspace*{-5mm}
  \vspace*{\datedsubsectionTopSpacing}

  \begin{table}[H]
    \bfseries

    % @{} to eliminate the the column spacing
    \begin{tabularx}{\textwidth}{ >{\raggedright\arraybackslash}#1 >{\centering\arraybackslash}#2 >{\raggedleft\arraybackslash}#3 }
        #4 & #5 & #6
    \end{tabularx}
  \end{table}

  \vspace*{\datedsubsectionBottomSpacing} 
}
% --------------------------------------

% ----------- WORK ITEMS ------------
\NewDocumentCommand{\workitems}{o o o o o}{%
  \renewcommand\labelitemi{\tiny$\bullet$}
  \vspace*{\workitemTopSpacing}

  \begin{itemize}
      \setlength\itemsep{\workitemBetweenSpacing}
      \item #1
      \IfNoValueTF{#2}{}{\item #2}
      \IfNoValueTF{#3}{}{\item #3}
      \IfNoValueTF{#4}{}{\item #4}
      \IfNoValueTF{#5}{}{\item #5}
  \end{itemize}%

  \vspace*{\workitemBottomSpacing}
}
% ------------------------------------


\newcommand{\name}[1]{%
  \centerline{\Huge{#1}}
}

\newcommand{\longcontact}[5]{%
    \noindent
    #1\hfill {\large}\hfill #2\hfill
    {\large}\hfill #3\\
    #4\hfill #5%
}
