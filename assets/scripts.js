let eventEmitter = new EventTarget();
function formatBytes(a, b = 2, k = 1024) { with (Math) { let d = floor(log(a) / log(k)); return 0 == a ? "0 Bytes" : parseFloat((a / pow(k, d)).toFixed(max(0, b))) + " " + ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"][d] } }
function resetUploadForm() {
   document.getElementById('selectedFileName').innerHTML = ''
   document.getElementById("btnUpload").disabled = false;
   document.getElementById("btnUpload").value = 'Upload File';
}
document.getElementById('file1').onchange = function () {
   document.getElementById('selectedFileName').innerHTML = "<small>(" + formatBytes(this.files.item(0).size) + ")</small> " + this.files.item(0).name
};
var form = document.getElementById("form1");
document.addEventListener('DOMContentLoaded', function () {
   //Wait  for ajax request to complete
   eventEmitter.addEventListener('complete', function () {
      // do something here
      console.log("Ajax request finished");
   })
});

form.onsubmit = async (e) => {
   e.preventDefault();

   const form = e.currentTarget;
   const url = form.action;
   try {
      if (form["file1"].files.length > 0) {
         document.getElementById("btnUpload").disabled = true; document.getElementById("btnUpload").value = 'Uploading';
         var formData = new FormData(form);
         const response = await fetch(url, {
            method: 'POST',
            body: formData
         });
         const text = await response.text();
         simpleToast(text);
         getFileList();
         resetUploadForm();
      } else {
         simpleToast('Nothing selected!')
         resetUploadForm();
      }
   } catch (error) {
      console.error(error);
      simpleToast(error);
      //alert(error);
      resetUploadForm();
   }
}

async function getFileList() {
   try {
      const formData = new FormData(form);
      const response = await fetch("getFileList.asp", { method: 'GET' });
      const res = await response.json();
      result = res.files.reduce(function (r, a) {
         r[a.Type] = r[a.Type] || [];
         r[a.Type].push(a);
         return r;
      }, Object.create(null));
      createListing(result);
      document.getElementById("btnUpload").disabled = false; document.getElementById("btnUpload").value = 'Upload File';

   } catch (error) {
      simpleToast(error);
   }
}

function createListing(res) {
   var ulList = document.getElementById('fileTypes')
   var panelHTML = '';
   var ulHTML = '';
   var count = 0;
   for (const property in res) {
       ++count ;
      ulHTML += '<li><a href="#table_' + property + '">' + property + ' <i>(' + res[property].length + ')</i><a></li>';

      panelHTML += '              <nav class="panel is-10">';
      panelHTML += '                <p class="panel-heading">' + property + '</p>';
      panelHTML += '                <div class="panel-block">';
      panelHTML += '                    <table class="table is-fullwidth" id="table_' + property + '">';
      panelHTML += '                      <thead>';
      panelHTML += '                      <tr>';
      panelHTML += '                      <th width="80%" class="teksatir">File Name</th>';
      panelHTML += '                      <th width="5%" class="teksatir">File Size</th>';
      panelHTML += '                      <th width="10%" class="teksatir">Upload Date</th>';
      panelHTML += '                      <th width="5%" class="teksatir">Download</th>';
      panelHTML += '                      </tr>';
      panelHTML += '                      </thead>';
      panelHTML += '                      <tbody>';

      res[property].forEach(element => {
         panelHTML += '                      <tr>';
         panelHTML += '                      <td>' + element.Name + '</td>';
         panelHTML += '                      <td class="teksatir">' + formatBytes(element.Size) + '</td>';
         panelHTML += '                      <td class="teksatir">' + element.DateCreated + '</td>';
         panelHTML += '                      <td class="teksatir"><a href="download.asp?file=' + encodeURIComponent(element.Name) + '">Download</a></td>';
         panelHTML += '                      </tr>';

      });

      panelHTML += '                      </tbody>';
      panelHTML += '                      </table>';
      panelHTML += '                    </div>';
      panelHTML += '              </nav>';
   }
   document.getElementById('Listings').innerHTML = panelHTML;
   ulList.innerHTML = ulHTML
   if (count > 0 ) { document.getElementById('FileTypesList').style.display = 'block' } else { document.getElementById('FileTypesList').style.display = 'none'};
}

function simpleToast(msg) {
   // Get the SIMPLE-TOAST DIV
   var x = document.getElementById("simpleToast");
   var m = document.getElementById("toastMsg");
   // Add the "show" class to DIV
   x.className = "show";
   x.innerHTML = msg
   // After 3 seconds, remove the show class from DIV
   setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
 }

 window.onload = getFileList()
