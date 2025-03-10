%dw 2.0
fun stringifyAny(inputData: Any) =
    dw::Runtime::try(() ->
        if (isEmpty(inputData.^) or
            inputData.^mimeType == "*/*")
            inputData
        else if (inputData.^mimeType == "application/xml" or
                inputData.^mimeType == "application/dw" or
                inputData.^mimeType == "application/json")
            write(inputData, inputData.^mimeType, {indent:false})
        else
            write(inputData, inputData.^mimeType)
    ) match {
        case failed if !failed.success -> inputData.^raw
        else -> $.result
    }
						   	
fun stringifyNonJSON(inputData: Any) =
    dw::Runtime::try(() ->
        if (isEmpty(inputData.^) or
            inputData.^mediaType == "application/json" or
            inputData.^mediaType == "*/*")
            inputData
        else if (inputData.^mediaType == "application/xml" or
                inputData.^mediaType == "application/dw")
            write(inputData, inputData.^mediaType, {indent:false})
        else
            write(inputData, inputData.^mediaType)
    ) match {
        case failed if !failed.success -> inputData.^raw
        else -> $.result
    }

fun stringifyAnyWithMetadata(inputData: Any) = {
    data: dw::Runtime::try(() ->
            if (isEmpty(inputData.^) or
                inputData.^mimeType == "*/*")
                inputData
            else if (inputData.^mimeType == "application/xml" or
                    inputData.^mimeType == "application/dw" or
                    inputData.^mimeType == "application/json")
                write(inputData, inputData.^mimeType, {indent:false})
            else
                write(inputData, inputData.^mimeType)
        ) match {
            case failed if !failed.success -> inputData.^raw
            else -> $.result
        },
    (contentLength: inputData.^contentLength) if (inputData.^contentLength != null),
    (dataType: inputData.^mimeType) if (inputData.^mimeType != null),
    (class: inputData.^class) if (inputData.^class != null)
} 

fun stringifyNonJSONWithMetadata(inputData: Any) = { 
    data: dw::Runtime::try(() ->
            if (isEmpty(inputData.^) or
                inputData.^mimeType == "application/json" or
                inputData.^mimeType == "*/*")
                inputData
            else if (inputData.^mimeType == "application/xml" or
                    inputData.^mimeType == "application/dw")
                write(inputData, inputData.^mimeType, {indent:false})
            else
                write(inputData, inputData.^mimeType)
        ) match {
            case failed if !failed.success -> inputData.^raw
            else -> $.result
        },
    (contentLength: inputData.^contentLength) if (inputData.^contentLength != null),
    (dataType: inputData.^mimeType) if (inputData.^mimeType != null),
    (class: inputData.^class) if (inputData.^class != null)
} 
