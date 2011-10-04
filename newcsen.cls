%%  Class newcsen by Georg Jung

%   Inspired by uebungsblatt package by Igor Akkerman
%   and by uebungsblatt package by Slim Abdennadher

%   The German University in Cairo GUC
%   Department for Media Engineering and Technology
%   Fall 2011

\def\fileversion{v0.1}
\def\filedate{2011/09/20}

%----------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{newcsen}[2011/09/20 Georg Jung]
\typeout{New class for courses at Dpt. for Media Engineering and Technology, the GUC}
\typeout{NewCSEN: \fileversion\ <\filedate> (Georg Jung)}
%----------------------------------------------------------------------%

%   Document class options:
%     solution   - show solution
%     practice   - compile a practice assignment
%     assignment - compile an assignment
%     popquiz    - compile a popquiz
%     quiz       - compile a quiz
%     mock       - compile a mock exam
%     midterm    - compile the midterm exam
%     final      - compile the final exam
%     makeup     - compile the makeup exam
%     logo       - add a logo to the output

%----------------------------------------------------------------------%
%   Commands for config.tex

%   \Institute     - sets the institute (defaults to "The German University in Cairo")
%   \Department    - sets the department (defaults to "Dpt. for Media Engineering and Technology")
%   \Class{}       - sets the class code
%   \Title{}       - sets the title of the class
%   \Lecturer[]{}  - sets the class lecturer (optional short name)
%   \Email{}       - sets the e-mail address of the lecturer
%   \Logo{}        - sets the name of an image file that contains a logo (defaults to "GUC-logo")

%----------------------------------------------------------------------%
%   Commands for individual files

%   \Topic         - sets the topic of the exercise set
%   \Date          - sets the discussion/submission/exam date

%----------------------------------------------------------------------%
%   Environments


%======================================================================%

%----------------------------------------------------------------------%
%   Required packages

\RequirePackage[utf8]{inputenx}
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{fancyhdr}
\RequirePackage{multido}
\RequirePackage[a4paper]{geometry}
%\RequirePackage[pdfauthor={\Author},pdftitle={\Title},pdfsubject={A Dissertation},pdfkeywords={\Keywords},hypertexnames=false,plainpages=false,pdfpagelabels,bookmarks,colorlinks=true,linktocpage=true,backref,letterpaper,hyperindex]{hyperref}

\makeatletter

%----------------------------------------------------------------------%
%   Options and flags

\newboolean{solution}
\newboolean{practice}
\newboolean{assignment}
\newboolean{popquiz}
\newboolean{quiz}
\newboolean{mock}
\newboolean{midterm}
\newboolean{final}
\newboolean{makeup}
\newboolean{subtitle}
\newboolean{cover}
\newboolean{identity}
\newboolean{marking}
\newboolean{logo}

\newcommand{\@csenassessmenttitle}{Practice assignment}
\setboolean{practice}{true}

\DeclareOption{solution}{\setboolean{solution}{true}}%
\DeclareOption{practice}{\setboolean{practice}{true}%
  \setboolean{assignment}{false}%
  \setboolean{popquiz}{false}%
  \setboolean{quiz}{false}%
  \setboolean{mock}{false}%
  \setboolean{midterm}{false}%
  \setboolean{final}{false}%
  \setboolean{makeup}{false}%
  \setboolean{identity}{false}%
  \setboolean{cover}{false}%
  \setboolean{marking}{false}%
  \renewcommand{\@csenassessmenttitle}{Practice assignment}}%
\DeclareOption{assignment}{\setboolean{assignment}{true}%
  \setboolean{practice}{false}%
  \setboolean{popquiz}{false}%
  \setboolean{quiz}{false}%
  \setboolean{mock}{false}%
  \setboolean{midterm}{false}%
  \setboolean{final}{false}%
  \setboolean{makeup}{false}
  \setboolean{identity}{true}%
  \setboolean{cover}{false}%
  \setboolean{marking}{true}%
  \renewcommand{\@csenassessmenttitle}{Assignment}}%
\DeclareOption{popquiz}{\setboolean{popquiz}{true}%
  \setboolean{practice}{false}%
  \setboolean{assignment}{false}%
  \setboolean{quiz}{false}%
  \setboolean{mock}{false}%
  \setboolean{midterm}{false}%
  \setboolean{final}{false}%
  \setboolean{makeup}{false}
  \setboolean{identity}{true}%
  \setboolean{cover}{false}%
  \setboolean{marking}{true}%
  \renewcommand{\@csenassessmenttitle}{Pop quiz}}%
\DeclareOption{quiz}{\setboolean{quiz}{true}%
  \setboolean{practice}{false}%
  \setboolean{assignment}{false}%
  \setboolean{popquiz}{false}%
  \setboolean{mock}{false}%
  \setboolean{midterm}{false}%
  \setboolean{final}{false}%
  \setboolean{makeup}{false}
  \setboolean{identity}{true}%
  \setboolean{cover}{true}%
  \setboolean{marking}{true}%
  \renewcommand{\@csenassessmenttitle}{Quiz}}%
\DeclareOption{mock}{\setboolean{mock}{true}%
  \setboolean{practice}{false}%
  \setboolean{assignment}{false}%
  \setboolean{popquiz}{false}%
  \setboolean{quiz}{false}%
  \setboolean{midterm}{false}%
  \setboolean{final}{false}%
  \setboolean{makeup}{false}
  \setboolean{identity}{false}%
  \setboolean{cover}{true}%
  \setboolean{marking}{false}%
  \renewcommand{\@csenassessmenttitle}{Mock exam}}%
\DeclareOption{midterm}{\setboolean{midterm}{true}%
  \setboolean{practice}{false}%
  \setboolean{assignment}{false}%
  \setboolean{popquiz}{false}%
  \setboolean{quiz}{false}%
  \setboolean{mock}{false}%
  \setboolean{final}{false}%
  \setboolean{makeup}{false}
  \setboolean{identity}{false}%
  \setboolean{cover}{true}%
  \setboolean{marking}{false}%
  \renewcommand{\@csenassessmenttitle}{Midterm exam}}%
\DeclareOption{final}{\setboolean{final}{true}%
  \setboolean{practice}{false}%
  \setboolean{assignment}{false}%
  \setboolean{popquiz}{false}%
  \setboolean{quiz}{false}%
  \setboolean{mock}{false}%
  \setboolean{midterm}{false}%
  \setboolean{makeup}{false}
  \setboolean{identity}{false}%
  \setboolean{cover}{true}%
  \setboolean{marking}{true}%
  \renewcommand{\@csenassessmenttitle}{Final exam}}%
\DeclareOption{makeup}{\setboolean{makeup}{true}%
  \setboolean{practice}{false}%
  \setboolean{assignment}{false}%
  \setboolean{popquiz}{false}%
  \setboolean{quiz}{false}%
  \setboolean{mock}{false}%
  \setboolean{midterm}{false}%
  \setboolean{final}{false}
  \setboolean{identity}{false}%
  \setboolean{cover}{true}%
  \setboolean{marking}{true}%
  \renewcommand{\@csenassessmenttitle}{Makeup exam}}%

\setboolean{logo}{false}%
\DeclareOption{logo}{\setboolean{logo}{true}}%

\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}%
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}%
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}%

\ProcessOptions

\LoadClass[pdftex,a4paper]{article}


%----------------------------------------------------------------------%
%   Variables and commands

\newcommand{\@cseninst}{The German University in Cairo}
\newcommand{\Institute}[1]{\renewcommand{\@csendpt}{#1}}

\newcommand{\@csendpt}{Dpt.\ for Media Engineering and Technology}
\newcommand{\Department}[1]{\renewcommand{\@csendpt}{#1}}

\newcommand{\@logofile}{GUC-logo}
\newcommand{\Logo}[1]{\renewcommand{\@logofile}{#1}\setboolean{logo}{true}}

\newcommand{\@csenclass}{CODE}
\newcommand{\Class}[1]{\renewcommand{\@csenclass}{#1}}

\newcommand{\@csentitle}{LECTURE TITLE}
\newcommand{\Title}[1]{\renewcommand{\@csentitle}{#1}}

\newcommand{\@csenedition}{SEMESTER}
\newcommand{\Edition}[1]{\renewcommand{\@csenedition}{#1}}

\newcommand{\@csenlecturer}{RESPONSIBLE LECTURER}
\newcommand{\@csenshortlecturer}{LECTURER}
\newcommand{\Lecturer}[2][]{%
  \renewcommand{\@csenshortlecturer}{\ifthenelse{\equal{#1}{}}{#2}{#1}}%
  \renewcommand{\@csenlecturer}{#2}}

\newcommand{\@csenemail}{E-Mail}
\newcommand{\Email}[1]{\renewcommand{\@csenemail}{#1}}

\newcommand{\@csensubtitle}{}
\newcommand{\Topic}[1]{\setboolean{subtitle}{true}\renewcommand\@csensubtitle{#1}}


%----------------------------------------------------------------------%
%   Counters

\newcommand{\@csendate}{}
\newcommand{\Date}[1]{\renewcommand{\@csendate}{#1}}

\newcounter{assessment}
\setcounter{assessment}{1}
\renewcommand{\theassessment}{\arabic{assessment}}
\newcommand{\assessmentnumber}{\@csenassessmenttitle\ \theassessment}
\newcommand{\Number}[1]{\setcounter{assessment}{#1}}

\newcounter{exercise}
\setcounter{exercise}{0}
\renewcommand{\theexercise}{\arabic{exercise}}

\newcounter{marktableexercise}
\setcounter{marktableexercise}{0}

\newcounter{csenmarktotal}
\setcounter{csenmarktotal}{0}


%----------------------------------------------------------------------%
%   Environments

\newcommand{\@exercisename}{Exercise}
\newcommand{\Exercisename}[1]{\renewcommand{\@exercisename}{#1}}

\newcommand{\@exercisehead}[3]{%
  {\textbf{\@exercisename\ \theexercise\\}}}

\newcommand{\@addexercise}[1]{%
  \stepcounter{exercise}%
  \write\@mainaux{\noexpand\@writefile{loq}{%
      \noexpand\addtocounter{csenmarktotal}{#1}%
      \noexpand\addtocounter{marktableexercise}{1}%
      \noexpand\eaddto{\noexpand\marksrow}{#1&}}}}


\newenvironment{exercise}[1]{%
  \@addexercise{#1}\@exercisehead
}%
{}



%----------------------------------------------------------------------%
%   Convenient automatic functions by Igor Akkerman

%   Extracting assessment number
%   \extractleadingnumber {<string>} {<countername>}
\newcommand{\extractleadingnumber}[2]{%
  \setbox0=\hbox{\global\csname c@#2\endcsname 0#1\relax}%
}
%   \extractnumber {<string>} {<countername>}
\newcommand{\extractnumber}[2]{%
  \def\@restof##1##2!!!{##2}%
  \def\@remblank##1##2!!!{##1##2}%
  \edef\@string{#1}%
  \extractleadingnumber\@string{#2}%
  \whiledo{\(\not \equal{\@string}{}\) \and \value{#2} = 0} {%
    \edef\@string{\expandafter\@restof\@string!!!}%
    \edef\@string{\expandafter\@remblank\@string!!!}%
    \extractleadingnumber\@string{#2}%
  }%
}
\extractnumber{\jobname}{assessment}
\typeout{[newcsen] file name: \jobname}
\typeout{[newcsen] assessment number: \theassessment}

%   Searching and loading of config.tex
\typeout{[newcsen] Searching 'config.tex'}
\InputIfFileExists{config.tex}{
  \typeout{[newcsen] File 'config.tex' found in current directory. loading.}
}
{
  \InputIfFileExists {../config.tex} {
    \typeout{[newcsen] File 'config.tex' found in parent directory. loading.}
  }
  {
    \typeout{[newcsen] File 'config.tex' not found.}
  }
}


%----------------------------------------------------------------------%
%   Layout and headings

\geometry{paper=a4paper, left=15mm, right=15mm, top=10mm, bottom=5mm,
  headheight=3\baselineskip, includehead, includefoot}
\pagestyle{fancy}
\lhead{\ifthenelse{\boolean{logo}}{
    \includegraphics[height=.8\headheight]{\@logofile}
    \hspace*{1mm}
    \begin{minipage}[b]{.4\linewidth}
      \small\bfseries \@cseninst\\\@csendpt\\\@csenlecturer
    \end{minipage}}
  {\small\bfseries \@cseninst\\\@csendpt\\\@csenlecturer}}
\chead{}
\rhead{\ifthenelse{\boolean{logo}}{
    \begin{minipage}[b]{.4\linewidth}
      \flushright{\small \@csenclass\\\@csentitle\\\@csenedition}
    \end{minipage}}
  {\small \@csenclass\\\@csentitle\\\@csenedition}}
\lfoot{\bfseries \assessmentnumber}
\cfoot{}
\rfoot{Page \thepage/\pageref{lastpage}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}


%----------------------------------------------------------------------%
%   Titleline / coverpage

\AtBeginDocument{%
  \noindent
  \begin{center}
    {\Large \bfseries \assessmentnumber}\\[2mm]
    \ifthenelse{\boolean{subtitle}}{{\large\@csensubtitle\\[2mm]}}{}
    {\ifthenelse{\equal{\@csendate}{}}{\ifthenelse{\boolean{marking}}{\bfseries\color{red}
          Define submission date!\\}{}}{%
    \rule{\linewidth}{2pt}
    {\ifthenelse{\boolean{marking}}{\bfseries Submission: }{Discussion: }{\@csendate}}
    \rule{\linewidth}{2pt}}}
  \end{center}
}

\AtEndDocument{%
    \label{lastpage}%
}

%----------------------------------------------------------------------%
%   Magic

%   building lines with tab markers
\def\addto#1#2{%
  \ifx#1\@undefined
    \def#1{#2}%
  \else
    \ifx#1\relax
      \def#1{#2}%
    \else
      {\toks@\expandafter{#1#2}%
        \xdef#1{\the\toks@}}%
    \fi
  \fi
}
\newcommand*\eaddto[2]{%
   \edef\tmp{#2}%
   \expandafter\addto
   \expandafter#1%
   \expandafter{\tmp}%
}
\def\numbersrow{}
\def\marksrow{}

%----------------------------------------------------------------------%
%   Table of results (Currently only works at end of file)

\newsavebox\@ignore
\newcommand{\csenmarktable}{%
  \savebox\@ignore{\@starttoc{loq}}
  \begin{center}
    \begin{tabular}{| r || *{\value{marktableexercise}}{c |}| c |}
      \hline
      \@exercisename
      \multido{\i=1+1}{\value{marktableexercise}}{\eaddto\numbersrow{&\i}}\numbersrow & $\mathbf{\Sigma}$ \\
      \hline
      Possible marks & \marksrow \textbf{\arabic{csenmarktotal}} \\
      \hline
      \hline
      \raisebox{-.75em}{Final marks}
      \def\numbersrow{}
      \multido{\i=1+1}{\value{marktableexercise}}{\eaddto\numbersrow{&\noexpand\hspace*{2em}}}\numbersrow
      & \hspace*{3em} \\[1.5em]
      \hline
    \end{tabular}
  \end{center}}




%----------------------------------------------------------------------%
\makeatother
