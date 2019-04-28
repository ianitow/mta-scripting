ACL_NAME = "Mecanico"

------------------FUNCTION------------------
function hasPlayerIsInACL(player,acl)
    if player then
        local accountname = ""
        if (isGuestAccount(getPlayerAccount(player)) == false) then
           accountname = getAccountName (getPlayerAccount(player))
           if isObjectInACLGroup ( "user." .. accountname, aclGetGroup (acl) ) then
             return true
           else
            return false
           end
        end
    else
        return nil
    end
end