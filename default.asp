<!-- #include file="required.asp" -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">
    <title>File Upload</title>

</head>

<body>
    <section class="section">
        <div class="container is-fullwidth">
            <h1 class="title">
                File Upload
            </h1>
            <p class="subtitle">
                A section for <strong>uploading files</strong>!
            </p>
            <div class="columns">
                <div class="column is-2">
                    <form METHOD="Post" ENCTYPE="multipart/form-data" ACTION="upload.asp" id="form1">
                        <div class="file has-name is-boxed">
                            <label class="file-label">
                                <input class="file-input" type="file" id="file1" name="file1" >
                                <span class="file-cta">
                                    <span class="file-icon">
                                        <i class="fas fa-upload"></i>
                                    </span>
                                    <span class="file-label">
                                        Choose a file…
                                    </span>
                                </span>
                                <span class="file-name" id="selectedFileName">
                                </span>
                            </label>
                        </div>
                        <br>
                        <div id="selectedFileInfo"></div>
                        <div class="buttons">
                            <button class="button is-primary is-small is-fullwidth" name="btnUpload" id="btnUpload">Upload File</button>
                        </div>
                    </form>
                    <div class="content is-small mt-5" id="FileTypesList" style="display: none;">
                        <p>File Groups;</p>
                        <ul id="fileTypes"></ul>
                    </div>
                </div>
                <div class="column is-10" id="Listings"></div>
            </div>
        </div>
        </div>

    </section>

    <div id="simpleToast">
      ⚠️ <span id="toastMsg"></span>
    </div>
</body>
<script src="assets/scripts.js" type="text/javascript"></script>



</html>
