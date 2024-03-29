{
  description = ''Reveal.js theme for nimib'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimiSlides-v0_1.flake = false;
  inputs.src-nimiSlides-v0_1.ref   = "refs/tags/v0.1";
  inputs.src-nimiSlides-v0_1.owner = "HugoGranstrom";
  inputs.src-nimiSlides-v0_1.repo  = "nimib-reveal";
  inputs.src-nimiSlides-v0_1.type  = "github";
  
  inputs."nimib".owner = "nim-nix-pkgs";
  inputs."nimib".ref   = "master";
  inputs."nimib".repo  = "nimib";
  inputs."nimib".dir   = "v0_3_4";
  inputs."nimib".type  = "github";
  inputs."nimib".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimib".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."toml_serialization".owner = "nim-nix-pkgs";
  inputs."toml_serialization".ref   = "master";
  inputs."toml_serialization".repo  = "toml_serialization";
  inputs."toml_serialization".dir   = "master";
  inputs."toml_serialization".type  = "github";
  inputs."toml_serialization".inputs.nixpkgs.follows = "nixpkgs";
  inputs."toml_serialization".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimiSlides-v0_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimiSlides-v0_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}