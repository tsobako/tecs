package body TECS.Resource is

   procedure Add (Resource : Resource_Type) is
   begin
      if not Exists then
         Added  := True;
         Value  := Resource;
         Exists := True;
      else
         raise Storage_Error with "Cannot add exists resource";
      end if;
   end Add;

   procedure Set (Resource : Resource_Type) is
   begin
      if Exists then
         Updated := True;
         Value   := Resource;
      else
         raise Storage_Error with "Cannot update non-existent resource";
      end if;
   end Set;

   procedure Update(F: not null access procedure (Resource : in out Resource_Type)) is
   begin
      if Exists then
         Updated := True;
         F(Value);
      else
         raise Storage_Error with "Cannot update non-existent resource";
      end if;
   end Update;

   procedure Remove is
   begin
      if Exists then
         Removed := True;
         Exists  := False;
      else
         raise Storage_Error with "Cannot remove  non-existent exists resource";
      end if;
   end Remove;

   function Get return Resource_Type is
   begin
      if Exists then
         return Value;
      else
         raise Storage_Error with "Cannot access non-existent resource";
      end if;
   end Get;

   function Not_Empty return Boolean is
   begin
      return Exists;
   end Not_Empty;

   function Is_Added return Boolean is
   begin
      return Added;
   end Is_Added;

   function Is_Removed return Boolean is
   begin
      return Removed;
   end Is_Removed;

   function Is_Updated return Boolean is
   begin
      return Updated;
   end Is_Updated;

   procedure Flush is
   begin
      Added   := False;
      Updated := False;
      Removed := False;
   end Flush;

end TECS.Resource;
