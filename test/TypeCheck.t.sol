pragma solidity ^0.8.0;

import {TypeChecker} from "@type-check/TypeChecker.sol";
import {Test} from "forge-std/Test.sol";

contract TypeCheck is Test {
    string public constant ADDRESSES_PATH = "addresses/Addresses.json";
    string public constant TYPE_CHECK_ADDRESSES_PATH =
        "addresses/TypeCheckAddresses.json";
    string public constant TYPE_CHECK_ADDRESSES_PATH_INCORRECT =
        "addresses/TypeCheckAddressesIncorrect.json";
    string public constant ADDRESSES_PATH_INCORRECT =
        "addresses/AddressesIncorrect.json";
    string public constant LIB_PATH = "";
    TypeChecker public typechecker;

    function test_typeCheck() public {
        typechecker = new TypeChecker(
            ADDRESSES_PATH,
            TYPE_CHECK_ADDRESSES_PATH,
            LIB_PATH
        );
    }

    // Artifact path is incorrect in TypeCheckAddresses.json
    function test_typeCheckIncorrectArtifact() public {
        vm.expectRevert(
            "StdCheats deployCode(string,bytes): Deployment failed."
        );
        typechecker = new TypeChecker(
            ADDRESSES_PATH,
            TYPE_CHECK_ADDRESSES_PATH_INCORRECT,
            LIB_PATH
        );
    }

    // Deployed bytecode is incorrect
    function test_typeCheckIncorrectByteCode() public {
        vm.expectRevert("Deployed bytecode not matched");
        typechecker = new TypeChecker(
            ADDRESSES_PATH_INCORRECT,
            TYPE_CHECK_ADDRESSES_PATH,
            LIB_PATH
        );
    }
}
