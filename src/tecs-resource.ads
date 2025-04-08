generic
   type Resource_Type is private;
package TECS.Resource is

   procedure Add (Resource : Resource_Type);
   procedure Set (Resource : Resource_Type);
   procedure Update(F: not null access procedure (Resource : in out Resource_Type));
   procedure Remove;
   function Get return Resource_Type;

   function Not_Empty return Boolean;
   function Is_Added return Boolean;
   function Is_Removed return Boolean;
   function Is_Updated return Boolean;

   procedure Flush;

private

   Exists  : Boolean := False;
   Added   : Boolean := False;
   Removed : Boolean := False;
   Updated : Boolean := False;

   To_Add    : Boolean := False;
   To_Remove : Boolean := False;
   To_Update : Boolean := False;

   Value : Resource_Type;

end TECS.Resource;
