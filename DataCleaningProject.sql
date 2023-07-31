select* from data_cleaning;

/*breaking out propertyaddress into individual columns 
(would have used PARCENAME if it was available*/
select PropertyAddress
from data_cleaning;

Select 
substring(propertyaddress,1,locate(',',propertyaddress )-1) as SplitAddress,
substring(propertyaddress,locate(',',propertyaddress)+1, 
length(propertyaddress)) as City
from data_cleaning;

Alter table data_cleaning
add SplitAddress varchar(250);

update data_cleaning
set SplitAddress =
substring(propertyaddress,1,locate(',',propertyaddress )-1);

Alter table data_cleaning
add City varchar(250);

update data_cleaning
set City = substring(propertyaddress,locate(',',propertyaddress)+1, 
length(propertyaddress));
 
Select splitaddress,city
from data_cleaning;

/* Owner Address*/
Select owneraddress
from data_cleaning;

Select OwnerAddress,
substring(owneraddress,1,locate(',',owneraddress)-1) as OwnerSplitAddress,
substring(owneraddress,
locate(',',owneraddress)+1,locate(',',owneraddress)-4) as OwnersplitCity,
substring(owneraddress,length(owneraddress)-1) as OwnerSplitState
from data_cleaning ;

Alter table data_cleaning
add OwnerSplitAddress varchar(250);

Update data_cleaning
set ownersplitaddress = substring(owneraddress,1,locate(',',owneraddress)-1);

Alter Table data_cleaning
add OwnerSplitCity varchar(100);

Update data_cleaning
set OwnerSplitCity = substring(owneraddress,
locate(',',owneraddress)+1,locate(',',owneraddress)-4);

Alter Table data_cleaning
add OwnerSplitState varchar(50);

Update data_cleaning
set OwnerSplitState = substring(owneraddress,length(owneraddress)-1);

Select ownersplitaddress,ownersplitcity,ownersplitstate
from data_cleaning;

/*Change to yes and no only in sold as vacant field*/

Select distinct SoldAsVacant , count(soldasvacant)
from data_cleaning
group By soldasvacant
order by 2;

Select Soldasvacant,
case when Soldasvacant = 'Y' Then 'Yes'
 When soldasvacant = 'N' Then 'No' 
 Else  soldasvacant
 End
From data_cleaning;

Update data_cleaning
set soldasvacant = case 
 when Soldasvacant = 'Y' Then 'Yes'
 When soldasvacant = 'N' Then 'No' 
 Else soldasvacant
 End;
 
 Select	distinct SoldAsVacant,Count(SoldAsVacant)
 from data_cleaning
 group by soldasvacant;
 
 /* Remove Duplicates*/
 WITH RowNumCte AS (
 Select *,
 row_number() Over (
 partition by ParcelID,
 PropertyAddress,
 SalePrice,
 SaleDate,
 LegalReference
 Order By UniqueID ) Row_num
 From data_cleaning)
 
 Delete from rownumcte
 Where row_num > 1;
 

/* Delete Unused Columns*/
Select* From data_cleaning;

Alter Table Data_cleaning 
Drop Column TaxDistrict

