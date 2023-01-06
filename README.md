# Game Collector

### Description

Game Collector is an application that contains current games, their release dates, ratings and brief information about the games. In this application, you can also add games to your favorites and create notes about games.

### Libraries Used
<li>pod 'AlamofireImage', '~> 4.1'</li>
<li>pod 'Alamofire'</li>
<li>pod 'MaterialActivityIndicator'</li>
<li>pod 'SwiftAlertView', '~> 2.2.1'</li>

### XCODE Version
<li>XCode Version 14.1</li>

### Swift Versiyon
<li>Swift 5 </li>

### Minimum iOS Version
<li>iOS 16.1</li>

### API
<li>https://api.rawg.io/docs</li>
<li>A key is needed to use the API.</li>


### Screens

  #### Game List 
  
<div align="center">
<table>
<tr>
<td><img src="images/IMG_1165.PNG" alt="drawing" width="275"/></td>  
<td><img src="images/IMG_1167.PNG" alt="drawing" width="275"/></td>  
</td>  
</tr>
</table>
</div>
<ul>
<li>The Game List screen lists the current games with the data provided by https://api.rawg.io/docs/. </li>
<li>Games can be found using search by game names.</li>
<li>Games can be filtered for all or by genre (action, adventure, etc.).</li>
</ul>
<div align="center">
<table>
<tr>
<td><img src="images/IMG_1168.PNG" alt="drawing" width="275"/></td>  
</td>  
</tr>
</table>
</div>
<li>Games can be sorted alphabetically, by score and release date.</li>
<li>Finding, sorting and filtering the games using search is done with service requests. </li>
<li>When games are selected, the detail page of the game is reached</li>

#### Game Detail

<div align="center">
<table>
<tr>
<td><img src="images/IMG_1166.PNG" alt="drawing" width="275"/></td>  
</td>  
</tr>
</table>
</div>
 <li>On the detail page of each game, there are game images, rating information, release date of the game and information about the game.</li>
<li>Under the image on the detail page, there is the heart symbol used to select favorites.</li>
<li>When the button is checked, the relevant game is saved on the "Favorites" screen.</li>

#### Favorites

<div align="center">
<table>
<tr>
<td><img src="images/IMG_1169.PNG" alt="drawing" width="275"/></td>  
<td><img src="images/IMG_1177.PNG" alt="drawing" width="275"/></td>  
</td>  
</tr>
</table>
</div>
    <li>After adding favorites on the detail screens of the games, these games are saved on the favorites page and listed here.</li>
    <li>Favorite games can be removed from favorites with the "Delete" option by swiping left. </li>
    <li>When the game is selected on the Favorites page, the detail screen can be accessed.</li>

#### Notes

<div align="center">
<table>
<tr>
<td><img src="images/IMG_1170.PNG" alt="drawing" width="275"/></td>  
<td><img src="images/IMG_1171.PNG" alt="drawing" width="275"/></td>  
</td>  
</tr>
</table>
</div>
    <li>After the notes are saved, they are listed on the screen.</li>
<div align="center">
<table>
<tr>
<td><img src="images/IMG_1172.PNG" alt="drawing" width="275"/></td>  
<td><img src="images/IMG_1173.PNG" alt="drawing" width="275"/></td>  
</td>  
</tr>
</table>
</div>

<li>Game Name and Note About Game fields are designed as mandatory fields on the note creation screen.</li> 
<li>If the information about any of these fields is not filled in, an "Error" warning is displayed on the screen.</li>


<div align="center">
<table>
<tr>
<td><img src="images/IMG_1175.PNG" alt="drawing" width="275"/></td>  
<td><img src="images/IMG_1176.PNG" alt="drawing" width="275"/></td>  
<td><img src="images/IMG_1179.PNG" alt="drawing" width="275"/></td>  
</td>  
</tr>
</table>
</div>
<li>After the notes are saved, they are listed on the screen.</li>
<li>The list displays the game name, the date the note was recorded, and the note written.</li>
<li>When information is wanted to be changed in the same note, the "Add" button on the first save screen changes to "Update". With this button, changes can be made to the recorded note. </li>
<li>The note selected in the list can be removed from the list with the "Delete" button.</li>





