
function hasPlayerIsInACL(player,acl)
    if player then
        local accountname = ""
        if (isGuestAccount(getPlayerAccount(player)) == false) then
           accountname = getAccountName (getPlayerAccount(player))
           if isObjectInACLGroup ( "user." .. accountname, aclGetGroup (ACL_DETRAN) ) then
             return true
           else
            return false
           end
        end
    else
        return nil
    end
end


function isCarAllowed(carType)
    for i,k in pairs (POSSIBLE_CARS)do
        if(k == carType) then
        return true
        end
    end
    return false;
end

function getElementsWithinMarker(marker)
	if (not isElement(marker) or getElementType(marker) ~= "marker") then
		return false
	end
	local markerColShape = getElementColShape(marker)
	local elements = getElementsWithinColShape(markerColShape)
	return elements
end

