#include <Constants.au3>

Global $DOS, $Message = '' ;; added "= ''" for show only.

$DOS = Run(@ComSpec & " /c Ping www.google.com", "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
ProcessWaitClose($DOS)
$Message = StdoutRead($DOS)

MsgBox(0, "Stdout Read:", $Message)