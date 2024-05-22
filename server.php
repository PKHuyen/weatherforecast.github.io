<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
$location = $_GET['location'];

if ($location) {
    $script_path = './weather.sh';

    $command = escapeshellcmd("$script_path $location");

    $output = shell_exec($command);
    if ($output === null) {
        error_log("Error executing script: $command");
    }

    echo $output;
} else {
    echo 'Please provide a location.';
}
?>