<?php
/* PHP Function: GenerateUIDv2 using slug-generator
 * Part of the SCARDInc/UIDv2 Project
 * Version 1.0.0
 *
 * Note: This example is provided "unoptimised" for logic readability. JetBrains and ChatGPT will refactor the $strLastCode and $strFirstCode loops into a separate function.
 */

// From https://github.com/ausi/slug-generator
use Ausi\SlugGenerator\SlugGenerator;

/**
 * Returns the UID for a person.
 * @param string $strLastName - The last name of the person
 * @param string $strFirstName - The first name of the person
 * @param string $strDateOfBirth - The date-of-birth of the person in the ISO 8601 format
 * @param int $intSex - The sex of the person as an int: 0 - Not known, 1 - Male, 2 - Female, 9 - Not Applicable
 * @return string - The UID generated for the person
 */
function GenerateUIDv2(string $strLastName, string $strFirstName, string $strDateOfBirth = '9999-99-99', int $intSex = 0): string {
    $objGenerator = new SlugGenerator;
    $strFirstCode = null;
    $strLastCode = null;
    $strFirst = $objGenerator->generate($strFirstName, ['delimiter' => '', 'validChars' => 'A-Z0-9']);
    $intFirst = strlen($strFirst);
    $arrFirst = str_split($strFirst);
    $strLast = $objGenerator->generate($strLastName, ['delimiter' => '', 'validChars' => 'A-Z0-9']);
    $intLast = strlen($strLast);
    $arrLast = str_split($strLast);
    if (empty($strFirstName) || empty($strLastName) || empty($strDateOfBirth) || empty($intSex)) {
        throw new InvalidArgumentException('Invalid input parameters.');
    }
    // Validate date format
    $dateOfBirth = DateTime::createFromFormat('Y-m-d', $strDateOfBirth);
    if (!$dateOfBirth || $dateOfBirth->format('Y-m-d') !== $strDateOfBirth) {
        throw new InvalidArgumentException('Invalid DateOfBirth format. Use YYYY-MM-DD.');
    }

    if ($intLast > 4) {
        $strLastCode = $arrLast[1] . substr($strLast, -1) . $arrLast[2] . $arrLast[4] . $arrLast[0];
    } elseif (($intLast == 4) || ($intLast == 3)) {
        $strLastCode = $arrLast[1] . substr($strLast, -1) . $arrLast[2] . '2' . $arrLast[0];
    } elseif ($intLast == 2) {
        @$strLastCode = $arrLast[1] . substr($strLast, -1) . '22' . $arrLast[0];
    } else {
        $strLastCode = '2' . substr($strFirst, -1) . '22' . $arrLast[0];
    }
    if ($intFirst > 4) {
        $strFirstCode = $arrFirst[1] . substr($strFirst, -1) . $arrFirst[2] . $arrFirst[4] . $arrFirst[0];
    } elseif (($intFirst == 4) || ($intFirst == 3)) {
        $strFirstCode = $arrFirst[1] . substr($strFirst, -1) . $arrFirst[2] . '2' . $arrFirst[0];
    } elseif ($intFirst == 2) {
        @$strFirstCode = $arrFirst[1] . substr($strFirst, -1) . '22' . $arrFirst[0];
    } else {
        $strFirstCode = '2' . substr($strFirst, -1) . '22' . $arrFirst[0];
    }
    $strDateOfBirthCode = strtoupper(dechex(str_replace('-', '', $strDateOfBirth)));

    return strtoupper($strLastCode.$strFirstCode.$strDateOfBirthCode.$intSex);
}
