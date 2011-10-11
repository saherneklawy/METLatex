%%  Class newcsen by Georg Jung

%   Inspired by uebungsblatt package by Igor Akkerman
%   and by uebungsblatt package by Slim Abdennadher

%   The German University in Cairo GUC
%   Department for Media Engineering and Technology
%   Fall 2011

\def\fileversion{v1.0beta}
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
%     nobarcode  - suppress barcode placeholder (e.g., for
%                  computerized assessments)
%     idform     - print student id-form on cover page instead of
%                  barcode
%     nonumber   - suppress numbering
%     coverpage  - generate a cover page (default for quiz, mock exam,
%                  midterm, final, and makeup)
%     nocover    - do not generate a cover page (default for practice
%                  assignment, assignment, popquiz)
%     noinstruct - suppress instructions on cover page

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
%   \Duration{}        - sets the duration of the exam (defaults to
%                        120 min for midterm and 180 min for final and
%                        makeup)
%   \Instructions{}    - sets instructions other than the default for
%                        this exam
%   \AddFormula[]{}    - adds a formula for the formula sheet
%                        (optional title)
%   \SolutionSpace{}   - sets a space to be left for the solution if
%                        the solution is not shown
%   \Mark{}            - set marks for sub-exercises (no checks, no
%                        automatic adding! only typesetting)

%----------------------------------------------------------------------%
%   Commands for unofficial use only

%   \Exercisename{}       - Sets a name for the exercise header
%                           (default: Exercise)
%   \Bonusname{}          - Sets a name for the bonus exercise header
%                           (default: Bonus Exercise)
%   \Exerciseheadskip{}   - Sets a distance between number, theme and
%                           title
%   \Exerciseskip{}       - Sets the distance between two exercises

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
\newboolean{nomarktbl}%    - Suppresses the marking table if true
\newboolean{nobarcode}%    - Suppress printing of a barcode placeholder
\newboolean{noinstruct}%   - Suppress printing of instructions on cover page
\newboolean{formula}%      - Assessment contains a formula sheet

%----------------------------------------------------------------------%
%   Counters

\newcounter{assessment}
\setcounter{assessment}{1}

\newcounter{exercise}
\setcounter{exercise}{0}

\newcounter{marktableexercise}
\setcounter{marktableexercise}{0}

\newcounter{csenmarktotal}
\setcounter{csenmarktotal}{0}

\newcounter{scratchpages}
\setcounter{scratchpages}{0}

\newcounter{@scratchpage}
\setcounter{@scratchpage}{0}

%----------------------------------------------------------------------%
%   Options

\newcommand{\@csenassessmenttitle}{Practice assignment}
\newcommand{\Assessmenttype}[1]{\renewcommand{\@csenassessmenttitle}{#1}}

\newcommand{\@csenduration}{}
\newcommand{\Duration}[1]{\renewcommand{\@csenduration}{#1}}

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
\setboolean{nobarcode}{false}%
\setboolean{noinstruct}{false}%
\setboolean{formula}{false}%

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
  \setboolean{cover}{false}%
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
  \setboolean{marking}{true}%
  \setcounter{scratchpages}{3}%
  \renewcommand{\@csenduration}{120 minutes}%
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
  \setcounter{scratchpages}{3}%
  \renewcommand{\@csenduration}{180 minutes}%
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
  \setcounter{scratchpages}{3}%
  \renewcommand{\@csenduration}{180 minutes}%
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

\DeclareOption{coverpage}{\setboolean{cover}{true}}%
\DeclareOption{nocover}{\setboolean{cover}{false}}%

\DeclareOption{nobarcode}{\setboolean{nobarcode}{true}}%

\DeclareOption{idform}{\setboolean{identity}{true}}%

\DeclareOption{noinstruct}{\setboolean{noinstruct}{true}}%

\DeclareOption{formula}{\setboolean{formula}{true}}%

\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}%
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}%
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}%

\ProcessOptions

\LoadClass[pdftex,a4paper]{article}

%----------------------------------------------------------------------%
%   Variables and commands

\newcommand{\@csendate}{}
\newcommand{\Date}[1]{\renewcommand{\@csendate}{#1}}

\renewcommand{\theassessment}{\arabic{assessment}}
\newcommand{\@assessmentform}{\@csenassessmenttitle\ifthenelse{\boolean{numbered}}{\ \theassessment}{}}
\newcommand{\Number}[1]{\setcounter{assessment}{#1}}

\renewcommand{\theexercise}{\ifthenelse{\boolean{numbered}}{\theassessment}{}%
  \ifthenelse{\equal{\@csenversion}{}}{}{(\@csenversion)}%
  \ifthenelse{\boolean{numbered}}{--}{}\arabic{exercise}}%

\newcommand{\@spelled}[2][u]{%
  \ifthenelse{\equal{#1}{l}}%
  {\ifcase#2\or{one}\or{two}\or{three}\or{four}\or{five}\or{six}\or{seven}\or{eight}\or{nine}\or{ten}\or{eleven}\or{Twelve}\else\@ctrerr\fi}
  {\ifcase#2\or{One}\or{Two}\or{Three}\or{Four}\or{Five}\or{Six}\or{Seven}\or{Eight}\or{Nine}\or{Ten}\or{Eleven}\or{Twelve}\else\@ctrerr\fi}}

\newcommand{\@scratchspelled}[1][u]{%
  \ifthenelse{\value{scratchpages}>12}{\arabic{scratchpages}}{\@spelled[#1]{\value{scratchpages}}}}

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

\newcommand{\Scratchpages}{\arabic{scratchpages}}
\newcommand{\Scratchpaper}[1]{\setcounter{scratchpages}{#1}}

\newcommand{\@mkscratch}%
{\multido{\i=1+1}{\value{scratchpages}}{\newpage%
    \thispagestyle{scratch}
    \begin{center}
      \rule{\linewidth}{1pt}\\
      \raisebox{-.25\baselineskip}{contents of the scratch paper will
        not be graded unless a reference on the problem page indicates
        that a solution extends here}\\
      \rule{\linewidth}{1pt}
    \end{center}\stepcounter{@scratchpage}}}

\newcommand{\Pages}{\pageref{lastpage}}

\newcommand{\SolutionSpace}[1]{%
  \ifthenelse{\boolean{solution}}{}{\vspace*{#1}}}

\newcommand{\@cseninstructions}{%
    \begin{enumerate}
      \ifthenelse{\equal{\@csenduration}{}}{}{
      \item The duration of this exam is \textbf{\@csenduration}.}
    \item Non-programmable calculators are allowed
    \item No books or other aids are permitted for this test.
    \item This exam booklet contains a total of \textbf{\Pages\
        pages}, including this one.
      \ifthenelse{\value{scratchpages}>0}{\@scratchspelled\ extra
        sheets of scratch paper are attached and have to be kept
        attached.}{}
      \ifthenelse{\boolean{formula}}{A fomula sheet is attached and
        may be detached for convenience
        (page~\pageref{formulapage}). The formula sheet does not need
        to be submitted.}{}
      \textbf{Note that if one or more pages are missing, you will
        lose their points. Thus, you must check that your exam booklet
        is complete.}
    \item Write your solutions in the space provided. If you need more
      space, write on the back of the sheet containing the
      problem\ifthenelse{\value{scratchpages}>0}{ or on the
      \@scratchspelled[l]\ extra sheets and indicate that clearly on
      the problem page. \textbf{Scratch sheets will not be graded
        unless a reference on the problem page indicates that the
        solution extends to the scratch sheets.}}{.}
    \item When you are told that time is up, stop working on the test.
    \end{enumerate}}
\newcommand{\Instructions}[1]{\renewcommand{\@cseninstructions}{#1}}

\newcommand{\AddFormula}[2][]{%
  \ifthenelse{\equal{#1}{}}{%
    \write\@mainaux{\noexpand\@writefile{for}{%
        \noexpand\item[$\bullet$]\noexpand~\noexpand\\\noexpand{#2}}}}
  {\write\@mainaux{\noexpand\@writefile{for}{%
        \noexpand\item[#1]\noexpand~\noexpand\\\noexpand{#2}}}}}

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
  {\ifthenelse{\boolean{mock} \OR \boolean{midterm} \OR \boolean{final} \OR \boolean{makeup}}%
    {\newpage}{\vspace{\baselineskip}\par}}}%
\newcommand{\Exerciseskip}[1]{\renewcommand{\@exerciseskip}{#1}}

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
    {(1~Mark)}%
    {(#1~Marks)}}}%

\renewcommand{\labelenumi}{(\alph{enumi})}

\newcommand{\Mark}[1]{\hspace*{\stretch{1}}{\@exercisemarks{#1}}}
\newcommand{\Bonus}[1]{\hspace*{\stretch{1}}{\textbf{\@exercisemarks{#1}}}}

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
%   Formula sheet

\newcommand{\@mkformula}%
{\newpage%
  \thispagestyle{formula}
  \label{formulapage}
  \begin{center}
    \rule{\linewidth}{1pt}\\
    \raisebox{-.25\baselineskip}{The formula sheet can be detached for
    convenience. It does not have to be submitted.}\\
    \rule{\linewidth}{1pt}
  \end{center}
  \begin{description}
    \item[\large Formulas:]~
    \@starttoc{for}
  \end{description}}


%----------------------------------------------------------------------%
%   Identity

\newcommand{\@csenidentity}{%
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
  \\}

\newcommand{\@barcodebox}{%
  \fbox{%
    \begin{minipage}{10cm}
      \vspace*{30mm}
      \begin{flushright}
        {\small\textbf{Barcode}}
      \end{flushright}
    \end{minipage}}}


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

\fancypagestyle{plain}{
  \fancyhf{}
  \rfoot{Page \thepage/\pageref{lastpage}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0.4pt}}

\fancypagestyle{scratch}{
  \lhead{}%
  \chead{\large\textbf{Scratch paper sheet \arabic{@scratchpage}}}%
  \rhead{}%
  \lfoot{\@csenclass\ (\@csenedition)}%
  \cfoot{\textbf{\@assessmentform,\ \@csendate}}}%

\fancypagestyle{formula}{
  \lhead{}%
  \chead{\large\textbf{Formula sheet}}%
  \rhead{}%
  \lfoot{\@csenclass\ (\@csenedition)}%
  \cfoot{\textbf{\@assessmentform,\ \@csendate}}}%

\parindent0pt
\parskip1\baselineskip

%----------------------------------------------------------------------%
%   Titleline / coverpage

\AtBeginDocument{%
  \ifthenelse{\boolean{cover}}{%
    \thispagestyle{plain}
    \noindent
    \ifthenelse{\boolean{logo}}{%
      \includegraphics[height=3\baselineskip]{\@logofile}\hspace*{1mm}}{}
    \begin{minipage}[b]{.5\linewidth}
      \bfseries\sf \@cseninst\\\@csendpt\\\@csenlecturer
    \end{minipage}
    \hspace*{\stretch{1}}
    \begin{minipage}[b]{.2\linewidth}
      \flushright{\@csendate}\\~\\~
    \end{minipage}
    \vspace*{3\baselineskip}
    \begin{center}
      \textbf{\LARGE\@csenclass: \@csentitle\\[5mm]}
      \textbf{\Large\@csenedition\\[5mm]}
      {\Large \@assessmentform\\[1cm]}
      \ifthenelse{\boolean{marking}}{%
        \ifthenelse{\boolean{identity}}{\@csenidentity}{%
          \ifthenelse{\boolean{nobarcode}}{}{\@barcodebox}}}{}
    \end{center}
    \ifthenelse{\boolean{noinstruct}{}}{}{%
      \textbf{Instructions. Please read carefully before proceeding.}
      \@cseninstructions}
    \begin{center}
      \textbf{\large Good luck!}
    \end{center}
    \vspace*{\stretch{1}}
    \ifthenelse{\boolean{marking}}{\ifthenelse{\boolean{nomarktbl}}{}{
    \rule{\linewidth}{3pt}\\
    Do not write anything below this line.
    \begin{center}
      \@csenmarktable
    \end{center}}}{}
    \pagebreak
  }{%
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
    \ifthenelse{\boolean{identity}}{\@csenidentity}{}
    \ifthenelse{\boolean{marking}}{\ifthenelse{\boolean{nomarktbl}}{}{
        \vspace*{2cm}
        \begin{center}
          {\small Do \textbf{not} write anything into this table!}\\
          \@csenmarktable
        \end{center}\vspace*{2cm}}}{}
  }}

\AtEndDocument{%
  \ifthenelse{\boolean{solution}}{}{\@mkscratch}%
  \ifthenelse{\boolean{formula}}{\@mkformula}{}%
  \label{lastpage}%
}

%----------------------------------------------------------------------%
\makeatother
