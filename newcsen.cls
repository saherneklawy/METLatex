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

%----------------------------------------------------------------------%
%   Commands for config.tex

%   \Class{}       - sets the class code
%   \Title{}       - sets the title of the class
%   \Lecturer[]{}  - sets the class lecturer (optional short name)
%   \Email{}       - sets the e-mail address of the lecturer

%----------------------------------------------------------------------%
%   Commands for individual files

%   \Topic         - sets the topic of the exercise set
%   \Date          - sets the discussion/submission/exam date

%----------------------------------------------------------------------%
%   Environments


%----------------------------------------------------------------------%

\RequirePackage[utf8]{inputenx}
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{fancyhdr}
\RequirePackage[a4paper]{geometry}
%\RequirePackage[pdfauthor={\Author},pdftitle={\Title},pdfsubject={A Dissertation},pdfkeywords={\Keywords},hypertexnames=false,plainpages=false,pdfpagelabels,bookmarks,colorlinks=true,linktocpage=true,backref,letterpaper,hyperindex]{hyperref}

\geometry{a4paper}
\geometry{left=5mm, right=5mm, top=5mm, bottom=5mm, headheight=15mm, includefoot}

\makeatletter

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

\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}%
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}%
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}%

\ProcessOptions

\LoadClass[pdftex,a4paper]{article}

\newcommand{\@csenclass}{CODE}
\newcommand{\Class}[1]{\renewcommand{\@csenclass}{#1}}

\newcommand{\@csentitle}{LECTURE TITLE}
\newcommand{\Title}[1]{\renewcommand{\@csentitle}{#1}}

\newcommand{\@csenlecturer}{RESPONSIBLE LECTURER}
\newcommand{\@csenshortlecturer}{LECTURER}
\newcommand{\Lecturer}[2][]{%
  \renewcommand{\@csenshortlecturer}{\ifthenelse{\equal{#1}{}}{#2}{#1}}%
  \renewcommand{\@csenlecturer}{#2}}

\newcommand{\@csenemail}{E-Mail}
\newcommand{\Email}[1]{\renewcommand{\@csenemail}{#1}}

\newcommand{\@csendate}{\today}
\newcommand{\Date}[1]{\renewcommand{\@csendate}{#1}}

\newcounter{assessment}
\setcounter{assessment}{1}
\renewcommand{\theassessment}{\arabic{assessment}}
\newcommand{\assessmentnumber}{\@csenassessmenttitle\ \theassessment}
\newcommand{\Number}[1]{\setcounter{assessment}{#1}}

\newcounter{exercise}
\setcounter{exercise}{1}
\renewcommand{\theexercise}{\arabic{exercise}}
\newcommand{\exercisenumber}{Exercise \theexercise}

\newcommand{\@csensubtitle}{}
\newcommand{\Topic}[1]{\setboolean{subtitle}{true}\renewcommand\@csensubtitle{#1}}

% Extracting assessment number
% \extractleadingnumber {<string>} {<countername>}
\newcommand{\extractleadingnumber}[2]{%
  \setbox0=\hbox{\global\csname c@#2\endcsname 0#1\relax}%
}
% \extractnumber {<string>} {<countername>}
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
\extractnumber \jobname {assessment}
\typeout{[newcsen] file name: \jobname}
\typeout{[newcsen] assessment number: \theassessment}

% searching and loading of config.tex
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

\AtBeginDocument{%
  \noindent
  \rule{\linewidth}{1mm}
  \begin{center}
    {\LARGE \assessmentnumber}
    \ifthenelse{\boolean{subtitle}}{\\[2mm]{\Large\@csensubtitle}}{}
  \end{center}
  \rule{\linewidth}{1mm}
}

\AtEndDocument{%
    \label{lastpage}%
}










\makeatother
