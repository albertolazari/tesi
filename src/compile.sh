#!/bin/sh

### Params ###
# LaTeX build files directory
BUILD="build"

# Thesis root .tex file name
THESIS="tesi"

loadParams() {
  glossary=1
  bibliography=1
  clean=1
  log=0

  while getopts :bcd:glh flag
  do
    case "${flag}" in
      b) bibliography=0;;
      c) clean=0;;
      d) BUILD=$OPTARG;;
      g) glossary=0;;
      l) log=1;;
      h) printHelp; exit 0;;
      *) printHelp; exit 1;;
    esac
  done
}

printHelp() {
  echo "LaTeX FIUP thesis compile script"
  echo "Usage:    compile.sh [-bdghl]"
  echo "Shell options:"
  echo "    -b    skip bibliography compile"
  echo "    -c    skip build directory clean"
  echo "    -d    directory to put temporary files in"
  echo "    -g    skip glossary compile"
  echo "    -l    keep logs in build/ directory"
  echo "    -h    print this message"
}

compile() {
  pdflatex -output-directory=$BUILD -interaction=nonstopmode $THESIS 
}

makeGlossary() {
  makeindex -s $THESIS.ist -t $THESIS.glg -o $THESIS.gls $THESIS.glo
  makeglossaries -d $BUILD $THESIS
  makeindex -s $THESIS.ist -t $THESIS.alg -o $THESIS.acr $THESIS.acn
}

makeBibliography() {
  biber --input_directory $BUILD --output_directory $BUILD $THESIS
}

clean() {
  rm $BUILD/*.acn $BUILD/*.aux $BUILD/*.bbl $BUILD/*.bcf $BUILD/*.glo
  rm $BUILD/*.ist $BUILD/*.lof $BUILD/*.lot $BUILD/*.run.xml $BUILD/*.toc
  if [[ $log != 1 ]]
  then
    rm $BUILD/*.blg  $BUILD/*.log
  fi
}

main() {
  # Move to script directory
  cd $PWD/$( dirname -- "$0" )
  
  loadParams $*

  if [[ ! -d $BUILD ]];
  then
    mkdir $BUILD;
  fi

  compile

  if [[ $glossary == 1 ]]
  then
    makeGlossary
  fi

  if [[ $bibliography == 1 ]]
  then
    makeBibliography
  fi

  if [[ $glossary == 1 ]] || [[ $bibliography == 1 ]]
  then
    compile
  fi

  if [[ $glossary == 1 ]]
  then
    compile
  fi

  if [[ $clean == 1 ]]
  then
    clean
  fi

  # Move generated pdf to the same level of the source file
  mv $BUILD/$THESIS.pdf ./
}

main $*
