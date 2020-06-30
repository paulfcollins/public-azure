
$ManagedSub = '<ENTER SUBSCRIPTION ID>'

Select-AzSubscription -SubscriptionId $ManagedSub
$scope = '/subscriptions/' + $ManagedSub

$ManagedSubAssignment = Get-AzManagedServicesAssignment -Scope $scope

Remove-AzManagedServicesAssignment -ResourceId $ManagedSubAssignment.Id
