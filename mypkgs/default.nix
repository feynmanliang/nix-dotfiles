{ nixpkgs ? import <nixpkgs> { }, stdenv ? nixpkgs.stdenv, ... }:

let 
  pkgs = with nixpkgs; rec {
    nvchad = import ./nvchad { pkgs = nixpkgs; };
  };
in
pkgs
