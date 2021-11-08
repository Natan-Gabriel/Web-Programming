
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