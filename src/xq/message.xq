xquery version "3.1" encoding "UTF-8";
declare variable $message as xs:string external;
let $msg := <msg>{$message}</msg>
return
  $msg

