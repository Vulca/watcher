<?php
require 'vendor/autoload.php';
use Goutte\Client;

$url = "http://industra.space";
$css_selector = "a.title.may-blank";
$thing_to_scrape = "_text";

$client = new Client();
$crawler = $client->request('GET', $url);
$output = $crawler;
#$output = $crawler->filterXPath('descendant-or-self::body');
#$output = $crawler->filter($css_selector)->extract($thing_to_scrape);

var_dump($output);
?>