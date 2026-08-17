Add-Type -AssemblyName System.IO.Compression.FileSystem

$outputFile = Join-Path $PSScriptRoot '..\Student_Expense_Dashboard_Project_Report.docx'
$tempFolder = Join-Path $env:TEMP 'student_dashboard_docx'

Remove-Item -LiteralPath $tempFolder -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path "$tempFolder\_rels", "$tempFolder\word\_rels" -Force | Out-Null

function Escape-Xml([string]$text) {
    return [System.Security.SecurityElement]::Escape($text)
}

function Paragraph([string]$text, [string]$style = 'Normal', [bool]$bold = $false) {
    $boldTag = if ($bold) { '<w:b/>' } else { '' }
    return "<w:p><w:pPr><w:pStyle w:val=`"$style`"/></w:pPr><w:r><w:rPr>$boldTag</w:rPr><w:t>$(Escape-Xml $text)</w:t></w:r></w:p>"
}

function Bullet([string]$text) {
    return "<w:p><w:pPr><w:ind w:left=`"720`" w:hanging=`"360`"/></w:pPr><w:r><w:t>• $(Escape-Xml $text)</w:t></w:r></w:p>"
}

$body = @()
$body += '<w:p><w:pPr><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:b/><w:sz w:val="36"/></w:rPr><w:t>STUDENT EXPENSE DASHBOARD</w:t></w:r></w:p>'
$body += '<w:p><w:pPr><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:sz w:val="28"/></w:rPr><w:t>Flutter Mobile Application Project Report</w:t></w:r></w:p>'
$body += '<w:p><w:r><w:br w:type="page"/></w:r></w:p>'
$body += Paragraph 'Submitted by' 'Heading1'
$body += Paragraph 'Member 1: ______________________________'
$body += Paragraph 'Member 2: ______________________________'
$body += Paragraph 'Course/Section: _________________________'
$body += Paragraph 'Instructor: ______________________________'
$body += Paragraph 'Date Submitted: __________________________'
$body += '<w:p><w:r><w:br w:type="page"/></w:r></w:p>'

$body += Paragraph '1. Project Overview' 'Heading1'
$body += Paragraph 'Student Expense Dashboard is a Flutter application that displays monthly allowance and expense records. It also contains student profiles with contact information, address, course, and individual expenses. The program uses local Dart maps as its data source.'

$body += Paragraph '2. Objectives' 'Heading1'
$body += Bullet 'Display a student allowance and expense summary.'
$body += Bullet 'Allow the user to switch between July, August, and September.'
$body += Bullet 'Show the complete expense list for the selected month.'
$body += Bullet 'Show four student profiles and their individual information.'
$body += Bullet 'Apply basic Flutter widgets, navigation, lists, maps, and state updates.'

$body += Paragraph '3. Main Features' 'Heading1'
$body += Bullet 'Dashboard: shows the selected month, allowance, and expense summary.'
$body += Bullet 'Month selector: a DropdownButton changes the selected month.'
$body += Bullet 'Expense page: displays all expenses for the selected month.'
$body += Bullet 'Profile list: shows all student members.'
$body += Bullet 'Profile details: shows contact, address, course, and personal expenses.'

$body += Paragraph '4. Folder and File Organization' 'Heading1'
$body += Bullet 'lib/main.dart - starts the application, sets the theme, and registers the profile route.'
$body += Bullet 'lib/data/student_data.dart - contains monthly expense data, student profiles, and drawer data.'
$body += Bullet 'lib/screens/dashboard_screen.dart - dashboard UI and selectedMonth state.'
$body += Bullet 'lib/screens/expenses_page.dart - full expense list for one selected month.'
$body += Bullet 'lib/screens/profile_list_page.dart - student list and profile details page.'
$body += Bullet 'lib/utils/asset_helper.dart - checks if an avatar asset exists before displaying it.'
$body += Bullet 'assets/avatars/ - optional local student avatar images.'

$body += Paragraph '5. Program Flow' 'Heading1'
$body += Paragraph '1. main.dart runs MyApp and opens DashboardScreen.'
$body += Paragraph '2. DashboardScreen starts with selectedMonth set to July.'
$body += Paragraph '3. The dropdown changes selectedMonth through setState().'
$body += Paragraph '4. The dashboard reads the allowance and expenses from monthlyExpenses[selectedMonth].'
$body += Paragraph '5. See All opens ExpensesPage and passes the selected month through its constructor.'
$body += Paragraph '6. The drawer opens the Profiles page, where each student can be viewed in detail.'

$body += Paragraph '6. Important Code Explanation' 'Heading1'
$body += Paragraph 'The dashboard uses a StatefulWidget because the displayed data changes when the month changes. selectedMonth stores the currently selected month. setState() rebuilds the screen after a user selects another month. The expense page receives the month using required this.month, so it displays the same month selected on the dashboard.'

$body += Paragraph '7. Division of Work and Presentation' 'Heading1'
$body += Paragraph 'Member 1: ______________________________' 'Heading2'
$body += Bullet 'Developed and explains main.dart and dashboard_screen.dart.'
$body += Bullet 'Implemented the month dropdown, selectedMonth variable, allowance display, and expense preview.'
$body += Bullet 'Explains StatefulWidget, setState(), DropdownButton, Card, and ListView.'
$body += Bullet 'Demonstrates changing July, August, and September on the dashboard.'
$body += Paragraph 'Member 2: ______________________________' 'Heading2'
$body += Bullet 'Developed and explains student_data.dart, expenses_page.dart, profile_list_page.dart, and asset_helper.dart.'
$body += Bullet 'Prepared the student data maps, profile records, expense detail page, and avatar handling.'
$body += Bullet 'Explains Map data, constructor parameters, Navigator, MaterialPageRoute, ListTile, and FutureBuilder.'
$body += Bullet 'Demonstrates See All, opening a profile, and viewing the profile details.'

$body += Paragraph '8. Suggested Presentation Sequence' 'Heading1'
$body += Paragraph 'Member 1 presents the project goal, folder structure, main.dart, and the dashboard. Member 1 changes the month to prove that the data updates. Member 2 presents the expense page, student profiles, and data maps. Member 2 ends by explaining the use of local data and the app navigation.'

$body += Paragraph '9. Testing Performed' 'Heading1'
$body += Bullet 'Verified that the month dropdown changes the allowance and expense values.'
$body += Bullet 'Verified that See All opens the selected month expenses.'
$body += Bullet 'Verified that the profile list opens each student profile.'
$body += Bullet 'Ran flutter analyze with no reported issues.'

$body += Paragraph '10. Conclusion' 'Heading1'
$body += Paragraph 'The application demonstrates basic Flutter development using widgets, local maps, navigation, state updates, and organized source files. The project is divided into separate files so each feature can be explained independently during the group presentation.'

$documentXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
    $($body -join "`n")
    <w:sectPr><w:pgSz w:w="12240" w:h="15840"/><w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440"/></w:sectPr>
  </w:body>
</w:document>
"@

$contentTypes = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
</Types>
'@

$relationships = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>
'@

$documentRelationships = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
</Relationships>
'@

$styles = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:docDefaults><w:rPrDefault><w:rPr><w:sz w:val="22"/><w:szCs w:val="22"/><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/></w:rPr></w:rPrDefault></w:docDefaults>
  <w:style w:type="paragraph" w:default="1" w:styleId="Normal"><w:name w:val="Normal"/></w:style>
  <w:style w:type="paragraph" w:styleId="Heading1"><w:name w:val="heading 1"/><w:rPr><w:b/><w:sz w:val="28"/><w:color w:val="1F4E79"/></w:rPr><w:pPr><w:spacing w:before="240" w:after="120"/></w:pPr></w:style>
  <w:style w:type="paragraph" w:styleId="Heading2"><w:name w:val="heading 2"/><w:rPr><w:b/><w:sz w:val="24"/><w:color w:val="1F4E79"/></w:rPr><w:pPr><w:spacing w:before="180" w:after="80"/></w:pPr></w:style>
</w:styles>
'@

[System.IO.File]::WriteAllText("$tempFolder\[Content_Types].xml", $contentTypes)
[System.IO.File]::WriteAllText("$tempFolder\_rels\.rels", $relationships)
[System.IO.File]::WriteAllText("$tempFolder\word\document.xml", $documentXml)
[System.IO.File]::WriteAllText("$tempFolder\word\styles.xml", $styles)
[System.IO.File]::WriteAllText("$tempFolder\word\_rels\document.xml.rels", $documentRelationships)

Remove-Item -LiteralPath $outputFile -Force -ErrorAction SilentlyContinue
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempFolder, $outputFile)
Remove-Item -LiteralPath $tempFolder -Recurse -Force

Write-Output "Created: $outputFile"
