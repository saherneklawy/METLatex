%%  Class newcsen by Georg Jung

%   Inspired by uebungsblatt package by Igor Akkerman
%   and by uebungsblatt package by Slim Abdennadher

%   The German University in Cairo GUC
%   Department for Media Engineering and Technology
%   Fall 2011

\def\fileversion{v0.3}
\def\filedate{2011/09/20}

%----------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{newcsen}[2011/09/20 Georg Jung]
\typeout{New class for courses at Dpt. for Media Engineering and Technology, the GUC}
\typeout{NewCSEN: \fileversion\ <\filedate> (Georg Jung)}
%----------------------------------------------------------------------%

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

%     nomarktbl  - suppress marking table on first page
%                  (for marked assessments)
%     noid       - suppress student identification form
%                  (e.g., for computerized assessments)
%     nonumber   - suppress numbering

%----------------------------------------------------------------------%
%   Commands for config.tex

%   \Institute{}       - sets the institute
%                        (defaults to "The German University in Cairo")
%   \Department{}      - sets the department
%                        (defaults to "Dpt. for Media Engineering and
%                        Technology")
%   \Class{}           - sets the class code
%   \Title{}           - sets the title of the class
%   \Edition{}         - sets the semester for this class
%   \Lecturer[]{}      - sets the class lecturer (optional short name)
%   \Email{}           - sets the e-mail address of the lecturer
%   \Logo{}            - sets the name of an image file that contains
%                        a logo (defaults to "GUC-logo")

%----------------------------------------------------------------------%
%   Commands for individual files

%   \Assessmenttype{}  - sets an individual assessment type if
%                        necessary (e.g. "Practical Assignment",
%                        usually set through appropriate option)
%   \Number{}          - sets the number of this assessment (usually
%                        set automatically from filename)
%   \Topic{}           - sets the topic of the exercise set
%   \Version{}         - sets the version number, necessary if
%                        multiple versions are prepared
%   \Date{}            - sets the discussion/submission/exam date
%   \Pages             - returns the total number of pages
%   \Scratchpaper{}    - sets the number of pages for jotting paper in
%                        the end (defaults to three for marked exam
%                        types, zero otherwise)
%   \Scratchpages      - returns the number of pages for jotting paper
%                        in the end

%----------------------------------------------------------------------%
%   Commands for inofficial use only

%   \Exercisename{}       - Sets a name for the exercise header
%                           (default: Exercise)
%   \Bonusname{}          - Sets a name for the bonus exercise header
%                           (default: Bonus Exercise)
%   \Exerciseheadskip{}   - Sets a distance between number, theme and
%                           title

%----------------------------------------------------------------------%
%   Environments

%   \begin{exercise}{<marks>}{<theme>}{<title>} ... \end{exercise}
%   \begin{bonusexercise}{<marks>}{<theme>}{<title>} ... \end{bonusexercise}
%   \begin{solution} ... \end{solution}

%======================================================================%

%----------------------------------------------------------------------%
%   Required packages

\RequirePackage[utf8]{inputenx}
\RequirePackage[a4paper]{geometry}
\RequirePackage{xifthen}
\RequirePackage{verbatim}
\RequirePackage{multido}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{fancyhdr}
\RequirePackage{colortbl}

%----------------------------------------------------------------------%
\makeatletter

%----------------------------------------------------------------------%
%   Options and flags

\newboolean{solution}%     - Solution is shown
\newboolean{numbered}%     - Assessment is numbered

\newboolean{practice}%     - Assessment is a practice assignment
\newboolean{assignment}%   - Assessment is an assignment
\newboolean{popquiz}%      - Assessment is a pop-quiz
\newboolean{quiz}%         - Assessment is a quiz

\newboolean{mock}%         - Assessment is a mock exam
\newboolean{midterm}%      - Assessment is a midterm exam
\newboolean{final}%        - Assessment is a final exam
\newboolean{makeup}%       - Assessment is a makeup exam

\newboolean{subtitle}%     - A subtitle will be printed
\newboolean{exam}%         - Assessment is some kind of exam
\newboolean{cover}%        - A cover page is generated
\newboolean{identity}%     - A form for name and tutorial is generated
\newboolean{marking}%      - The assessment is marked (no practice, no mock)
\newboolean{logo}%         - A logo is printed on each left header
\newboolean{nomarktbl}%    - Supresses the marking table if true

\newcommand{\@csenassessmenttitle}{Practice assignment}
\newcommand{\Assessmenttype}[1]{\renewcommand{\@csenassessmenttitle}{#1}}

\setboolean{practice}{true}%
\setboolean{numbered}{true}%
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

\DeclareOption{practice}{\setboolean{practice}{true}%
  \setboolean{numbered}{true}%
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
  \setboolean{numbered}{true}%
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
  \setboolean{numbered}{true}%
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
  \setboolean{numbered}{true}%
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
  \setboolean{numbered}{false}%
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
  \setboolean{numbered}{false}%
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
  \setboolean{numbered}{false}%
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
  \setboolean{numbered}{false}%
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

\DeclareOption{solution}{\setboolean{solution}{true}
  \setboolean{nomarktbl}{true}
  \setboolean{identity}{false}}%

\setboolean{logo}{false}%
\DeclareOption{logo}{\setboolean{logo}{true}}%

\DeclareOption{noid}{\setboolean{identity}{false}}%

\DeclareOption{nonumber}{\setboolean{numbered}{false}}%

\setboolean{nomarktbl}{false}%
\DeclareOption{nomarktbl}{\setboolean{nomarktbl}{true}}%

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

\newcommand{\@csenversion}{}
\newcommand{\Version}[1]{\renewcommand{\@csenversion}{#1}}

\newcounter{scratchpages}
\setcounter{scratchpages}{0}
\newcommand{\Scratchpages}{\arabic{scratchpages}}
\newcommand{\Scratchpaper}[1]{\setcounter{scratchpages}{#1}}

\newcounter{@scratchpage}
\setcounter{@scratchpage}{0}

\newcommand{\@mkscratch}%
{\multido{\i=1+1}{\value{scratchpages}}{\newpage%
    \lhead{}%
    \chead{\large\textbf{Scratch paper sheet \arabic{@scratchpage}}}%
    \rhead{}%
    \lfoot{\@csenclass\ (\@csenedition)}%
    \cfoot{\textbf{\@assessmentform,\ \@csendate}}%
    \begin{center}
      \rule{\linewidth}{1pt}\\
      \raisebox{-.25\baselineskip}{contents of the scratch paper will
        not be graded unless a reference on the problem page indicates
        that a solution extends here}\\
      \rule{\linewidth}{1pt}
    \end{center}\stepcounter{@scratchpage}}}
\newcommand{\Pages}{\pageref{lastpage}}

%----------------------------------------------------------------------%
%   Counters

\newcommand{\@csendate}{}
\newcommand{\Date}[1]{\renewcommand{\@csendate}{#1}}

\newcounter{assessment}
\setcounter{assessment}{1}
\renewcommand{\theassessment}{\arabic{assessment}}
\newcommand{\@assessmentform}{\@csenassessmenttitle\ifthenelse{\boolean{numbered}}{\ \theassessment}{}}
\newcommand{\Number}[1]{\setcounter{assessment}{#1}}

\newcounter{exercise}
\setcounter{exercise}{0}
\renewcommand{\theexercise}{\ifthenelse{\boolean{numbered}}{\theassessment}{}%
  \ifthenelse{\equal{\@csenversion}{}}{}{(\@csenversion)}%
  \ifthenelse{\boolean{numbered}}{--}{}\arabic{exercise}}%

\newcounter{marktableexercise}
\setcounter{marktableexercise}{0}

\newcounter{csenmarktotal}
\setcounter{csenmarktotal}{0}

%----------------------------------------------------------------------%
%   Environments

%   Exercise
\newcommand{\@exercisename}{Exercise}
\newcommand{\Exercisename}[1]{\renewcommand{\@exercisename}{#1}}

\newcommand{\@bonusname}{\ifthenelse{\boolean{marking}}{Bonus\ }{}Exercise}
\newcommand{\Bonusname}[1]{\renewcommand{\@bonusname}{#1}}

\newcommand{\@exerciseheadskip}{2em}
\newcommand{\Exerciseheadskip}[1]{\renewcommand{\@exerciseheadskip}{#1}}

\newcommand{\@exerciseskip}{%
  \ifthenelse{\value{exercise}=1}%
  {\par}%
  {\vspace{\baselineskip}\par}}%

\newcommand{\@exerciselabel}{%
  \textbf{\@exercisename\ \theexercise}}

\newcommand{\@bonuslabel}{%
  \textbf{\@bonusname\ \theexercise}}

\newcommand{\@exerciselabelplusskip}{%
  \@exerciselabel\hspace*{\@exerciseheadskip}}

\newcommand{\@bonuslabelplusskip}{%
  \@bonuslabel\hspace*{\@exerciseheadskip}}

\newcommand{\@exercisemarks}[1]{%
  \ifthenelse{\equal{#1}{}}%
  {}%
  {\ifthenelse{\equal{#1}{1}}%
    {(1 Mark)}%
    {(#1 Marks)}}}%

\newcommand{\@exercisetheme}[1]{%
  \ifthenelse{\equal{#1}{}}%
  {}%
  {\\\phantom{\@exerciselabelplusskip}\textbf{#1}}}%

\newcommand{\@bonustheme}[1]{%
  \ifthenelse{\equal{#1}{}}%
  {}%
  {\\\phantom{\@bonuslabelplusskip}\textbf{#1}}}%

\newcommand{\@exercisehead}[3]{%
  {\samepage
    \@exerciselabelplusskip{}#2\ifthenelse{\boolean{marking}}{\hfill\ifthenelse{\equal{#1}{}}{\textbf{Marks
        not specified}}{\@exercisemarks{#1}}}{}\@exercisetheme{#3}\par\nopagebreak[4]}}

\newcommand{\@bonushead}[3]{%
  {\samepage
    \@bonuslabelplusskip{}#2\ifthenelse{\boolean{marking}}{\hfill\ifthenelse{\equal{#1}{}}{\textbf{Marks
        not specified}}{\@exercisemarks{#1}}}{}\@bonustheme{#3}\par\nopagebreak[4]}}

\newcommand{\@addexercise}[1]{%
  \stepcounter{exercise}%
  \ifthenelse{\boolean{marking}}{
    \ifthenelse{\equal{#1}{}}{%
      \write\@mainaux{\noexpand\@writefile{loq}{%
          \noexpand\addtocounter{marktableexercise}{1}%
          \noexpand\eaddto{\noexpand\marksrow}{?&}}}}
    {%
      \write\@mainaux{\noexpand\@writefile{loq}{%
          \noexpand\addtocounter{csenmarktotal}{#1}%
          \noexpand\addtocounter{marktableexercise}{1}%
          \noexpand\eaddto{\noexpand\marksrow}{#1&}}}}}{}}

\newcommand{\@addbonus}[1]{%
  \stepcounter{exercise}%
  \ifthenelse{\boolean{marking}}{
    \ifthenelse{\equal{#1}{}}{%
      \write\@mainaux{\noexpand\@writefile{loq}{%
          \noexpand\addtocounter{marktableexercise}{1}%
          \noexpand\eaddto{\noexpand\marksrow}{Bonus: ?&}}}}
    {%
      \write\@mainaux{\noexpand\@writefile{loq}{%
          \noexpand\addtocounter{marktableexercise}{1}%
          \noexpand\eaddto{\noexpand\marksrow}{Bonus: #1&}}}}}{}}

\newenvironment{exercise}[3]{%
  \@addexercise{#1}\@exerciseskip\@exercisehead{#1}{#2}{#3}}{}

\newenvironment{bonusexercise}[3]{%
  \@addbonus{#1}\@exerciseskip\@bonushead{#1}{#2}{#3}}{}

%   Solution

\newcommand{\solutionskip}{%
  \vspace{\baselineskip}\par}

\newcommand{\solutionheading}{%
  {\samepage\textbf{Solution:}\par\nopagebreak[4]}}

\newenvironment{solution}%
{\ifthenelse{\boolean{solution}}%
  {\solutionskip\solutionheading}%
    {\comment}}%
{\ifthenelse{\boolean{solution}}%
  {}%
{\endcomment}}

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
\InputIfFileExists{config.tex}{%
  \typeout{[newcsen] File 'config.tex' found in current directory. loading.}}%
{
  \InputIfFileExists {../config.tex}{%
    \typeout{[newcsen] File 'config.tex' found in parent directory. loading.}}%
  {
    \InputIfFileExists {../../config.tex}{%
      \typeout{[newcsen] File 'config.tex' found in second parent directory. loading.}}%
    {
      \typeout{[newcsen] File 'config.tex' not found.}
    }
  }
}

%----------------------------------------------------------------------%
%   Magic (necessary for creating the table of results)

%   building lines with tab marker symbols
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
\def\emptyrow{}

%----------------------------------------------------------------------%
%   Table of results

\newsavebox\@ignore
\newcommand{\@csenmarktable}{%
  \savebox\@ignore{\@starttoc{loq}}
  \begin{tabular}{| >{\columncolor[gray]{0.9}}r | *{\value{marktableexercise}}{c |}| c |}
    \hline
    \rowcolor[gray]{0.9}\@exercisename
    \multido{\i=1+1}{\value{marktableexercise}}{\eaddto\numbersrow{&\i}}\numbersrow & $\mathbf{\Sigma}$ \\
    \hline
    \rowcolor[gray]{0.9}Possible marks & \marksrow \textbf{\arabic{csenmarktotal}} \\
    \hline
    \hline
    \raisebox{-.75em}{Final marks}
    \multido{\i=1+1}{\value{marktableexercise}}{\eaddto\emptyrow{&\noexpand\hspace*{2em}}}\emptyrow
    & \hspace*{3em} \\[1.5em]
    \hline
  \end{tabular}}

%----------------------------------------------------------------------%
%   Layout and headings

\geometry{paper=a4paper, left=15mm, right=15mm, top=10mm, bottom=5mm,
  headheight=3\baselineskip, includehead, includefoot}
\pagestyle{fancy}
\lhead{\ifthenelse{\boolean{logo}}{
    \includegraphics[height=.8\headheight]{\@logofile}
    \hspace*{1mm}
    \begin{minipage}[b]{.4\linewidth}
      \small\bfseries\sf \@cseninst\\\@csendpt\\\@csenlecturer
    \end{minipage}}
  {\small\bfseries\sf \@cseninst\\\@csendpt\\\@csenlecturer}}
\chead{}
\rhead{\ifthenelse{\boolean{logo}}{
    \begin{minipage}[b]{.4\linewidth}
      \flushright{\small \@csenclass\\\@csentitle\\\@csenedition}
    \end{minipage}}
  {\small \@csenclass\\\@csentitle\\\@csenedition}}
\lfoot{\bfseries \@assessmentform}
\cfoot{}
\rfoot{Page \thepage/\pageref{lastpage}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

\parindent0pt
\parskip1\baselineskip

%----------------------------------------------------------------------%
%   Titleline / coverpage

\AtBeginDocument{%
  \noindent
  \begin{center}
    {\LARGE \bfseries \@assessmentform}\\[2mm]
    \ifthenelse{\boolean{subtitle}}{{\Large\@csensubtitle\\[2mm]}}{}
    \ifthenelse{\equal{\@csenversion}{}}{}{{\large ---\ Version\ \@csenversion\ ---\\[2mm]}}
    {\ifthenelse{\equal{\@csendate}{}}{\ifthenelse{\boolean{marking}}{\bfseries\color{red}
          Define submission date!\\}{}}{%
        \rule{\linewidth}{2pt}
        \raisebox{-.25\baselineskip}{%
          \ifthenelse{\boolean{solution}}{\bfseries Model Solutions}%
          {\ifthenelse{\boolean{marking}}{\bfseries Submission: }{Discussion: }{\@csendate}}}
        \rule{\linewidth}{2pt}}}
  \end{center}
  \ifthenelse{\boolean{identity}}{
    \vspace*{1cm}
    {\large Name}\dotfill%
    \begin{tabular}[b]{|r|*{7}{p{1.5em}|}}
      \hline
      \raisebox{-.75em}{Student ID \#} & & &
      \raisebox{-.75em}{\parbox{\linewidth}{\centering \textbf{---}}}
      & & & & \\[1.5em]
      \hline
    \end{tabular}%
    \\[1cm]
    {\large Name of your TA}\dotfill%
    \begin{tabular}[b]{|r|*{4}{p{1.5em}|}}
      \hline
      \raisebox{-.75em}{Group \#} &
      \raisebox{-.75em}{\parbox{\linewidth}{\centering \textbf{T}}} &
      \raisebox{-.75em}{\parbox{\linewidth}{\centering \textbf{---}}} & & \\[1.5em]
      \hline
    \end{tabular}%
    \\}{}
  \ifthenelse{\boolean{marking}}{\ifthenelse{\boolean{nomarktbl}}{}{
      \vspace*{2cm}
      \begin{center}
        \small{Do \textbf{not} write anything into this table!}\\
        \@csenmarktable
      \end{center}\vspace*{2cm}}}{}
}

\AtEndDocument{%
  \@mkscratch
  \label{lastpage}%
}

%----------------------------------------------------------------------%
\makeatother
