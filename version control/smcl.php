<?php
/* smcl.php 1.0.3  CFB 2723 with help from WWG */
/* 1.0.1: change ref from ftp to ftpeagle */
/* 1.0.2: add "Req" info from ssc.php */
/* 1.0.3: mod for PHP5 (xena), ereg()->preg_match()
/* emulates ssc.php producing Stata SMCL rather than HTML, net links rather than links to IDEAS web pages */ 
/* revised 1 July 2024 to access x,y HTTP files */

date_default_timezone_set('America/Detroit');
$today=date('Y-M-d T O H:i:s');
$tyme = getdate();
$mon = $tyme["mon"];
$year = $tyme["year"];
$yrb4 = $year;
$mday = $tyme["mday"];
$monb4 = $mon-1;
$dyb4 = $mday;
if ($mon==1) {
	$monb4 = 12;
	$yrb4 = $yrb4-1;
	}
$curmo = $mon;
$cmp = ($curmo<10) ? "0" : "";
$mp = ($monb4<10) ? "0" : "";
$dp = ($dyb4<10) ? "0" : "";
print "{smcl}\n\n{txt}{net \"from http://repec.org/bocode\":SSC} Stata modules created or revised ";

$currdt=$year.$cmp.$curmo.$dp.$dyb4;
$prevdt=$yrb4.$mp.$monb4.$dp.$dyb4;
print "$yrb4-$mp$monb4-$dp$dyb4 to $year-$cmp$curmo-$dp$dyb4\n{hline}\n";

$fs=0;
$desc="";
$cred="";
$revd="";
$xFile = file ("http://RePEc.org/boc/bocode/bocodex.rdf");
$yFile = file ("http://RePEc.org/boc/bocode/bocodey.rdf");
$st = count($xFile);
for ($i=0; $i < count($yFile); $i++) {
	$xFile[$st+$i] = $yFile[$i];
	}
/* $zFile = file ("http://RePEc.org/boc/bocode/bocodez.rdf");
$st = count($xFile);
for ($i=0; $i < count($zFile); $i++) {
        $xFile[$st+$i] = $zFile[$i];
        }
*/
for ($i=0; $i < count($xFile); $i++) {
/*	if(ereg("^Title: (.+): Stata (.+)$",$xFile[$i],$matches)) { */
	if(preg_match('/^Title: (.+): Stata (.+)$/',$xFile[$i],$matches)) {
		$name = $matches[1];
		$namelc = strtolower($name);
		$first = strtolower(substr($name,0,1));
		$desc = $matches[2];
		$an = "";
		}
	if(preg_match('/^Author-Name: (.+)$/',$xFile[$i],$ma)) {
		$an = $an.chop($ma[1])."  ";
		}
	if(preg_match('/^Creation-Date: (.+)$/',$xFile[$i],$cd)) {
		$cred = $cd[1];
		$cre=fmt($cred);
		}
    if(preg_match('/^Revision-Date: (.+)$/',$xFile[$i],$rd)) {
		$revd = $rd[1];
		$rev = fmt($revd);
		}
	if(preg_match('/^Requires: (.+)$/',$xFile[$i],$rq)) {
		$req = $rq[1];
		}
        if(preg_match('/^Handle: (.+)bocode:S(.+)\n$/',$xFile[$i],$han)) {
		if($cred > $prevdt | $revd > $prevdt) {
			$handl=$han[2];
			echo "\n{net \"describe http://repec.org/bocode/$first/$namelc\":$name}\n";
			echo "{txt} $desc";
			echo "{txt} Authors: $an     Req: $req\n";
			if($revd>$cred) { 
				echo "{txt} Revised: $rev\n"; 
				}
			else { 
				echo "{txt} Created: $cre\n"; 
				}	
			$cred="";
			$revd="";
			$an="";
			}
		}
	}
print "\n{hline}\n{txt} End of recent additions and updates\n";

function fmt($d8) {
		$y = floor($d8/10000);
		$m = floor($d8/100-$y*100);
		$d = floor($d8-$y*10000-$m*100);
		$mp = ($m<10) ? "0" : "";
		$dp = ($d<10) ? "0" : "";
		$df = $y."-".$mp.$m."-".$dp.$d;
		return $df;
		}
?>

