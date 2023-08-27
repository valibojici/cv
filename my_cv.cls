\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my_cv}[2011/03/26 My custom CV class]
\LoadClass{article}

\RequirePackage{titlesec}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{xparse}
\RequirePackage{hyperref}

\RequirePackage[a4paper, portrait, margin=2cm]{geometry}

\titleformat{\section}         % Customise the \section command 
  {\Large\scshape\raggedright} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           % Can be used to insert code before the heading
  [\titlerule]                 % Inserts a horizontal line after the heading

\titleformat{\subsection}
  {\large\scshape\raggedright}
  {}{0em}
  {}

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}



% Make subsection with 3 columns
\NewDocumentCommand{\datedsubsection}{ O{X} O{X} O{X} m m m }{%\

% removes margin before eliminates the space between the first line and the table. 
% You can replace the size with some other value to adjust
% the vertical spacing, for example \vspace*{-5mm}
\vspace*{-\baselineskip} 
\begin{table}[htbp]
        \bfseries

         % @{} to eliminate the the column spacing
        \begin{tabularx}{\textwidth}{ >{\raggedright\arraybackslash}#1 | >{\centering\arraybackslash}#2 | >{\raggedleft\arraybackslash}#3 }
            #4 & #5 & #6
        \end{tabularx}
    \end{table}
    \vspace*{-\baselineskip} 
}

\ExplSyntaxOn
\newcommand{\nameAndContact}[1]{
    \vspace*{-\baselineskip} 

    \clist_set:Nn \l_tmpa_clist {#1} % Store the clist in a temporary variable
    \clist_pop:NN \l_tmpa_clist \l_tmpa_tl % Pop the first item and store it in a token list
    
    \begin{table}[htbp]
        \begin{tabularx}{\textwidth}{ >{\Huge\centering\arraybackslash}X r}
            \multirow{\clist_count:N \l_tmpa_clist }{*}{ \l_tmpa_tl }
            \clist_map_inline:Nn \l_tmpa_clist { & ##1 \\ }
        \end{tabularx}
    \end{table}
    
    \vspace*{-1cm} 
}
\ExplSyntaxOff

\newcommand{\name}[1]{%
  \centerline{\Huge{#1}}
}

\newcommand{\longcontact}[5]{%
    \noindent
    #1\hfill {\large}\hfill #2\hfill
    {\large}\hfill #3\\
    #4\hfill #5%
}

\newcommand{\workitems}[3]{%
    \begin{itemize}
    \item #1
    \item #2
    \item #3
    \end{itemize}%
}
