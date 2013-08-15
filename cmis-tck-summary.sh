#!/bin/sh
# Count how many OK,WARN,FAIL in the TCK HTML output.
# Nicolas Raoul
#
# Usage: ./cmis-tck-summary.sh cmistck3664992454630300137.html

LINES=`mktemp`
<$1 tr "\n" " " | sed "s/<\/div>/\n/g" | sed -e "s/ <div style=\"padding: 5px;\">//g" > $LINES

OK=`grep "^ <div class=\"tckResultOK\">" $LINES | wc -l`
WARNING=`grep "^ <div class=\"tckResultWARNING\">" $LINES | wc -l`
FAILURE=`grep "^ <div class=\"tckResultFAILURE\">" $LINES | wc -l`

TOTAL=`expr $OK + $WARNING + $FAILURE`
RATE_OK=`expr $OK \* 100 / $TOTAL`
RATE_WARNING=`expr $WARNING \* 100 / $TOTAL`
RATE_FAILURE=`expr $FAILURE \* 100 / $TOTAL`

echo "OK:      $OK  ($RATE_OK%)"
echo "WARNING: $WARNING  ($RATE_WARNING%)"
echo "FAILURE: $FAILURE  ($RATE_FAILURE%)"
