<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
$apikey = 'Have to replace with Google Cloud Key'; 
$text = isset($_GET['text']) ? $_GET['text'] : '';
$targetLanguage = isset($_GET['target']) ? $_GET['target'] : '';

$apiUrl = "https://translation.googleapis.com/language/translate/v2?key=$apikey";

$data = [
    'q' => $text,
    'target' => $targetLanguage,
    'format' => 'text'
];

$dataJson = json_encode($data);

$options = [
    'http' => [
        'header' => "Content-type: application/x-www-form-urlencoded\r\n",
        'method' => 'POST',
        'content' => http_build_query($data),
    ],
];

$context = stream_context_create($options);
$response = file_get_contents($apiUrl, false, $context);

if ($response) {
    $responseJson = json_decode($response, true);

    if (isset($responseJson['data']['translations'][0]['translatedText'])) {
        echo $responseJson['data']['translations'][0]['translatedText'];
    } else {
        echo "Error: Could not find translated text.";
    }
} else {
    echo "Error: Could not fetch translation.";
}
