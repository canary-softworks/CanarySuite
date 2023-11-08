local Statistics = { }

function Statistics.GetMedian(numberList: {number}): number
	local TotalNumbers = #numberList
	local IsTotalEven = TotalNumbers % 2 == 0

	if not IsTotalEven then
		return numberList[(TotalNumbers / 2) + 0.5]
	end

	local FirstMedian = numberList[TotalNumbers / 2]
	local SecondMedian = numberList[(TotalNumbers / 2) + 1]

	return (FirstMedian + SecondMedian) / 2
end

function Statistics.GetMean(numberList: {number}): number
	local Total = 0

	for _, number in numberList do
		Total += number
	end

	return Total / #numberList
end

function Statistics.GetMode(numberList: {number}): number?
	local IndexOccurAmount = { }

	for _, value in numberList do
		if IndexOccurAmount[value] then
			IndexOccurAmount[value] += 1
		else
			IndexOccurAmount[value] = 1
		end
	end

	local MaxCount = 0
	local Uniform = true

	for value, amount in IndexOccurAmount do
		if amount > MaxCount then
			MaxCount = amount
		elseif amount < MaxCount then
			Uniform = false
			break
		end
	end

	local Mode: number = nil

	if not Uniform then
		for value, amount in IndexOccurAmount do
			if amount == MaxCount then
				Mode = value
				break
			end
		end
	end

	return Mode
end

return Statistics