<?php
require 'vendor/autoload.php';
use Goutte\Client;

$css_selector = "a.title.may-blank";
$thing_to_scrape = "_text";

$client = new Client();

// TODO: set up an api. Design brainstormer below:
// VERBS: 
//  - test: test a scrape (pass `url` and any number of `filter`, `filterxpath`, `extract`, ... methods)
//  - add: as test, but store scrape configuration in database
//  - ...


$verb = $_GET['verb'];
if ($verb == 'test') {
  if ( !filter_has_var( INPUT_GET, 'url') ) { $url = "https://industra.space"; } else {
  $url = filter_input( INPUT_GET, 'url', FILTER_SANITIZE_URL);
  $crawler = $client->request('GET', $url);
  $output = $crawler;
  //$output = $crawler->filterXPath('descendant-or-self::body');
  //$output = $crawler->filter($css_selector)->extract($thing_to_scrape);
  print_r($output->html());
}}
else {
  echo "<h1>BAD VERB</h1>";
  echo "ALLOWED VERBS: test<br />";
  echo "EXAMPLE: http://localhost/?verb=test&url=https://google.com";
}

?>