package body Tecs.Resource is

   procedure Add (Storage : in out Storage_Type; Resource : Resource_Type) is
   begin
      if not Storage.Exists then
         Storage.Added  := True;
         Storage.Value  := Resource;
         Storage.Exists := True;
      else
         raise Storage_Error with "Cannot add exists resource";
      end if;
   end Add;

   procedure Set (Storage : in out Storage_Type; Resource : Resource_Type) is
   begin
      if Storage.Exists then
         Storage.Updated := True;
         Storage.Value   := Resource;
      else
         raise Storage_Error with "Cannot update non-existent resource";
      end if;
   end Set;

   procedure Update
     (Storage : in out Storage_Type;
      F       :    not null access procedure (Resource : in out Resource_Type))
   is
   begin
      if Storage.Exists then
         Storage.Updated := True;
         F (Storage.Value);
      else
         raise Storage_Error with "Cannot update non-existent resource";
      end if;
   end Update;

   procedure Remove (Storage : in out Storage_Type) is
   begin
      if Storage.Exists then
         Storage.Removed := True;
         Storage.Exists  := False;
      else
         raise Storage_Error
           with "Cannot remove  non-existent exists resource";
      end if;
   end Remove;

   function Get (Storage : Storage_Type) return Resource_Type is
   begin
      if Storage.Exists then
         return Storage.Value;
      else
         raise Storage_Error with "Cannot access non-existent resource";
      end if;
   end Get;

   function Not_Empty (Storage : Storage_Type) return Boolean is
   begin
      return Storage.Exists;
   end Not_Empty;

   function Is_Added (Storage : Storage_Type) return Boolean is
   begin
      return Storage.Added;
   end Is_Added;

   function Is_Removed (Storage : Storage_Type) return Boolean is
   begin
      return Storage.Removed;
   end Is_Removed;

   function Is_Updated (Storage : Storage_Type) return Boolean is
   begin
      return Storage.Updated;
   end Is_Updated;

   procedure Flush (Storage : in out Storage_Type) is
   begin
      Storage.Added   := False;
      Storage.Updated := False;
      Storage.Removed := False;
   end Flush;

end Tecs.Resource;
