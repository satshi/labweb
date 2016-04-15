function ad(){
  md="ayamughch@tep.yh.scs.isoka-a.ucaj.p";
  n=md.length /2;
  res="";
  for(i=0;i<n;i++)
  {
    res+=md.charAt(2*i+1);
    res+=md.charAt(2*i);
  }
  return res;
}
function snd(){
  this.location.href ="mai"+"lto:"+ad();
}
document.write('<a href="JavaScript:snd()">' + ad() + '</a>');