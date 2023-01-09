<#
This script was written to convert strings that look lie "1 day, 2 hours and 15 minutes" into minutes
#>

$Tickerrs = import-csv 'tickets.csv'

foreach ($t in $Tickerrs){
                                                            #ONLY DAY 
    if($t.calendar_stc -match "day" -and $t.calendar_stc -notmatch "hour" -and $t.calendar_stc -notmatch "minute"){
    [int]$day = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').trim(',')
    
    #$t.calendar_stc
    $final = (($day * 24) * 60)
    $ticketnumber = $t.number
    $description = $t.short_description.Replace(',','')
  
        [PSCustomObject]@{
          INC = $t.number
          Time = $t.calendar_stc
          Minutes = $final
       } 
    #| out-file $newcsv -Append

    }   
                                                        #DAY + HOUR
    elseif($t.calendar_stc -match "day" -and $t.calendar_stc -match "hour" -and $t.calendar_stc -notmatch "minute"){
        $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
        $days = [int]$num[0]
        $hours = [int]$num[1]
    
        $final = (($days * 24)*60) + ($hours * 60)
        [PSCustomObject]@{
          INC = $t.number
          Time = $t.calendar_stc
          Minutes = $final
       } 
   
       #| out-file $newcsv -Append
    }
                                                          #DAY + MINUTES
      elseif($t.calendar_stc -match "day" -and $t.calendar_stc -notmatch "hour" -and $t.calendar_stc -match "minute"){
    $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').trim(',').split(',') 
    $day = [int]$num[0]
    $hours = [int]$num[1] 
    $final = (($day * 24)*60) + ($minute)
    
    [PSCustomObject]@{
      INC = $t.number
      Time = $t.calendar_stc
      Minutes = $final
   } #| out-file $newcsv -Append

    }        
                                                       #DAY + HOUR + MINUTES
      elseif($t.calendar_stc -match "day" -and $t.calendar_stc -match "hour" -and $t.calendar_stc -match "minute"){
          $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
          $days = [int]$num[0]
          $hours = [int]$num[1]
          $minute = [int]$num[2]         
          $final = (($days * 24)*60) + ($hours * 60) + ($minute)
          [PSCustomObject]@{
            INC = $t.number
            Time = $t.calendar_stc
            Minutes = $final
         } #| out-file $newcsv -Append
      }      
                                                           #HOURS + MINUTES
      elseif($t.calendar_stc -notmatch "day" -and $t.calendar_stc -match "hour" -and $t.calendar_stc -match "minute"){
       $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
       $hours = [int]$num[0]
       $minute = [int]$num[1]

       $final = ($hours * 60) + ($minute)
       [PSCustomObject]@{
        INC = $t.number
        Time = $t.calendar_stc
        Minutes = $final
     } #| out-file $newcsv -Append
      
      }
        
    
                                                          #ONLY HOURS
    if($t.calendar_stc -notmatch "day" -and $t.calendar_stc -match "hour" -and $t.calendar_stc -notmatch "minute"){
    $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',') 
    $hours = [int]$num[0]
    $final = ($hours * 60)

    [PSCustomObject]@{
      INC = $t.number
      Time = $t.calendar_stc
      Minutes = $final
   } #| out-file $newcsv -Append

   }
                                                  ### ONLY MINUTES
elseif($t.calendar_stc -notmatch "day" -and $t.calendar_stc -notmatch "hour" -and $t.calendar_stc -match "minute"){
  $num = ($t.calendar_stc -replace '[A-Z]','' -replace '   |  ',' ').Replace(' ',',').split(',')  
  $minute = [int]$num[0]
  [PSCustomObject]@{
    INC = $t.number
    Time = $t.calendar_stc
    Minutes = $minute
 } # | out-file $newcsv -Append
 }

 elseif(!($t.calendar_stc)){
  <#
  [PSCustomObject]@{
    INC = $t.number
    Time = $t.calendar_stc
    Minutes = $final
 } #| out-file $newcsv -Append #>
 }
}
