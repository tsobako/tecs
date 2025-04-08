with Ada.Containers.Hashed_Sets;
with Ada.Containers.Vectors;

package Tecs is

   type EntityId is new Natural;

   type EntityStorage is private;



   function EntityIdHash (Element : EntityId) return Ada.Containers.Hash_Type;

   function EntityIdEquivalent_Elements
     (Left, Right : EntityId) return Boolean;


   package EntityVectorPackage is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => EntityId);

   procedure Next_EntityId (Storage : in out EntityStorage; Id : out EntityId);

   function IsEntityAlive
     (Storage : EntityStorage; Id : EntityId) return Boolean;

   procedure DeleteEntity (Storage : in out EntityStorage; Id : EntityId);

   procedure Maintain (Storage : in out EntityStorage);

   function GetDeletedEntities
     (Storage : EntityStorage) return EntityVectorPackage.Vector;

private
   package Entities is new Ada.Containers.Hashed_Sets
     (Element_Type        => EntityId, Hash => EntityIdHash,
      Equivalent_Elements => EntityIdEquivalent_Elements);

   type EntityStorage is record
      CurrentEntityId : EntityId     := EntityId'First;
      Storage         : Entities.Set := Entities.Empty_Set;
      Deleted         : Entities.Set := Entities.Empty_Set;
   end record;

end Tecs;
