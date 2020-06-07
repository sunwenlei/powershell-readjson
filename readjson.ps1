
# ログの出力先
$LogPath = (Convert-Path .\log);
# ログフォルダーがなかったら作成
if( -not (Test-Path $LogPath) ) {
    New-Item $LogPath -Type Directory
}

# ログファイル名
$LogFile = "CopyData" + "_" + (Get-Date).ToString("yyyyMMdd-HHmmss") + ".log";

# ログファイル名
$LogFileName = Join-Path $LogPath $LogFile

function Log($LogString){
    $Now = Get-Date
    # Log 出力文字列に時刻を付加(YYYY/MM/DD HH:MM:SS.MMM $LogString)
    $Log = $Now.ToString("yyyy/MM/dd HH:mm:ss.fff") + " ";
    $Log += $LogString;

    # ログ出力
    Write-Output $Log | Out-File -FilePath $LogFileName -Encoding Default -append

    # echo させるために出力したログを戻す
    Return $LogString
}

$CONF = (Get-Content "mapping.json") | ConvertFrom-Json ;
$tbllist = $CONF.targettable ;

foreach($tbl in $tbllist){
    Log $tbl;

    $col =$CONF.$tbl;

    if($null -ne $col){
        Log $col;
    }
    else{
        Log ($tbl + " is null");
    }
}

