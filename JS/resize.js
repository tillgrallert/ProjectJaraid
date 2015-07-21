function autoResize(id){
    var newwidth;

    if(document.getElementById){
        newwidth=document.getElementById(id).contentWindow.document .body.scrollWidth;
    }

    document.getElementById(id).width= (newwidth);
}