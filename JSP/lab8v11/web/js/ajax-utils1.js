
function getPrevStation(userid,callbackFunction) {
    $.getJSON(
        "ChooseStationController",
        { action: 'getPrevStation', userid: userid },
        callbackFunction
    );
}

function getRoute(userid,callbackFunction) {
    $.getJSON(
        "ChooseStationController",
        { action: 'getRoute', userid: userid },
        callbackFunction
    );
}

function getChoosePrev(userid,callbackFunction) {
    $.getJSON(
        "ChooseStationController",
        { action: 'getPrev', userid: userid },
        callbackFunction
    );
}

function getChooseNext(userid,name,callbackFunction) {
    $.getJSON(
        "ChooseStationController",
        { action: 'getNext', userid: userid , name:name  },
        callbackFunction
    );
}

function getChooseStation(userid,callbackFunction) {
    $.getJSON(
        "ChooseStationController",
        { action: 'getAll', userid: userid  },
        callbackFunction
    );
}


function getUserAssets(userid, callbackFunction) {
    $.getJSON(

        "ChooseStationController",
        { action: 'getAll', userid: userid },
        callbackFunction
    );
}



function updateAsset(id, userid, description, value, callbackFunction) {
    $.get("AssetsController",
        { action: "update",
            id: id,
            userid: userid,
            description: description,
            value: value
        },
        callbackFunction
    );
}
