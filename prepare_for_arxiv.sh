#!/bin/bash

DOCUMENT_DIR_PATH=`pwd`
DOCUMENT_DIR_NAME=`basename $DOCUMENT_DIR_PATH`

ARXIV_DIR_PATH="$DOCUMENT_DIR_PATH"-arxiv
ARXIV_DIR_NAME="$DOCUMENT_DIR_NAME"-arxiv

# Copy current directory to new working directory

cp -rf $DOCUMENT_DIR_PATH $ARXIV_DIR_PATH
cd $ARXIV_DIR_PATH

cp .texpadtmp/"$DOCUMENT_DIR_NAME".bbl references.bbl 
sed -i '' '/bibliographystyle/d' "$DOCUMENT_DIR_NAME".tex
sed -i '' '/bibliography{references}/c\
\\input{references.bbl}' "$DOCUMENT_DIR_NAME".tex

rm -rf .[^.] .??*
rm references.bib
rm "$DOCUMENT_DIR_NAME".pdf
rm prepare_for_arxiv.sh
# rm compress_pdf_files.sh
find . -name '*.sketch' -delete

cd ..

zip -qr "$ARXIV_DIR_NAME".zip $ARXIV_DIR_NAME
rm -rf $ARXIV_DIR_PATH

echo "Successfully generated $ARXIV_DIR_NAME.zip"
