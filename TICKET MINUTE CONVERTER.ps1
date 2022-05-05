$tickets = import-csv C:\Users\michaelshirazi\Downloads\AllTickets.csv

foreach ($t in $tickets){

                                                            #ONLY DAY 
    if($t.calendar_stc -match "day" -and $t.calendar_stc -notmatch "hour" -and $t.calendar_stc -notmatch "minute"){
    [int]$day = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').trim(',') 
    
    $t.calendar_stc
    $final = (($day * 24) * 60)
    Write-Host $final

    }   
                                                           #DAY + HOUR
    elseif($t.calendar_stc -match "day" -and $t.calendar_stc -match "hour" -and $t.calendar_stc -notmatch "minute"){
        $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
        $days = [int]$num[0]
        $hours = [int]$num[1]
        $t.calendar_stc
        $final = (($days * 24)*60) + ($hours * 60)
	$final
    }
                                                          #DAY + MINUTES
      elseif($t.calendar_stc -match "day" -and $t.calendar_stc -notmatch "hour" -and $t.calendar_stc -match "minute"){
    $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').trim(',').split(',') 
    $t.calendar_stc
    $day = [int]$num[0]
    $hours = [int]$num[1] 
    $final = (($day * 24)*60) + ($minute)
    $final
    } 
         
                                                       #DAY + HOUR + MINUTES
      elseif($t.calendar_stc -match "day" -and $t.calendar_stc -match "hour" -and $t.calendar_stc -match "minute"){
          $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
          $days = [int]$num[0]
          $hours = [int]$num[1]
          $minute = [int]$num[2]
          
          
          $t.calendar_stc
          $final = (($days * 24)*60) + ($hours * 60) + ($minute)
          $final
      }      
                                                           #HOURS + MINUTES
      elseif($t.calendar_stc -notmatch "day" -and $t.calendar_stc -match "hour" -and $t.calendar_stc -match "minute"){
       $t.calendar_stc
       $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
       $hours = [int]$num[0]
       $minute = [int]$num[1]

       $final = ($hours * 60) + ($minute)
       $final 
        
    
                                                          #ONLY HOURS
    if($t.calendar_stc -notmatch "day" -and $t.calendar_stc -match "hour" -and $t.calendar_stc -notmatch "minute"){
    $t.calendar_stc
    $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
    $hours = [int]$num[0]
    $final = ($hours * 60)
    $final
   }

              ### ONLY MINUTES
elseif($t.calendar_stc -notmatch "day" -and $t.calendar_stc -notmatch "hour" -and $t.calendar_stc -match "minute"){
  $t.calendar_stc
  $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
  $minute = [int]$num[0]
  $minute
 }


}

