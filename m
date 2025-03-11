Return-Path: <linux-pci+bounces-23409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D60FDA5BA49
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 08:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3343B7A977E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B52236F7;
	Tue, 11 Mar 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx5Q8A9D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353E1386DA;
	Tue, 11 Mar 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679705; cv=none; b=sXqD5dwB988qKq/cGx1gLOqqEc/ur+YkHpN6+EgCo6TbpPLyKAWxlI/3wL5S+oo54aI/GaxmdtzDdPLRKvglBO2kzYqX8ISRdfVI/kInnOLupO7Qs15oHuDyiJyZPftinlTWQHLCuXifTCeorEUqg06CKEQeBHdB5UONdOBIcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679705; c=relaxed/simple;
	bh=VUW7JbS09K3eHvnTUq5EVfSChPS6oMO+mH9yFSbdepM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTLuuq43PoaRl83ZrdMAwXkqtlUElnOCmpOxRdqt3HimEZRQXlZlHv5qbluVcixOLc6KKH85nEpIgMSo59NNbfXeAQUgW0KG/BFOSzxGEX0ramkstFlf89LIrjZOvOAkEO8vGlhxfMJT6nUqUMuh8nw5WooifYuVKhONr4o5mXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx5Q8A9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989A6C4CEE9;
	Tue, 11 Mar 2025 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741679705;
	bh=VUW7JbS09K3eHvnTUq5EVfSChPS6oMO+mH9yFSbdepM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wx5Q8A9DQaH3NN0kUB4+ZcFK4gFdfG0u+FX0hWXIr+HuxZx42aMFO8JZsZ3QRm3Uj
	 ImmFlilYR7CjZW1qucYXZoVMyzLLSyPOcRkFN30gfn5XFDXP0B0bBihCTpsCucB0q3
	 leuzDdMyJVl7lRYH22GlFVKlpjz1BoXn2jneTMsT0Z//rTEz1M2NbeqvjaupmNGbly
	 QBI/mUBhAB4cdKe7kwuuuwerkwRnALNEX2wRIM3vpa11W0YEq1TYHZ0KMg072M3ARW
	 nJQN51eOTqKiKsIHumGChc/YF5Uvy1tm8fAHpK/lv5KyWiw7vodZU3d69u8iC3XrSw
	 mURkGg3j8eAdQ==
Message-ID: <01a7918b-dc4b-4ed3-8f74-bc59a9629ce9@kernel.org>
Date: Tue, 11 Mar 2025 08:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] dt-bindings: PCI: qcom: Use sdx55 reg description
 for ipq9574
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, p.zabel@pengutronix.de,
 quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20250220094251.230936-1-quic_varada@quicinc.com>
 <20250220094251.230936-4-quic_varada@quicinc.com>
 <41b400fe-5e08-42c0-9bc6-a238d25d155a@kernel.org>
 <33bb1cb2-0c5e-402b-a5c6-9604b1dd8d99@kernel.org>
 <Z86YReHsKeF165F6@hu-varada-blr.qualcomm.com>
 <84456c70-e933-469f-ac7a-7d899f85e777@linaro.org>
 <Z8/Dto1fZWvemiY5@hu-varada-blr.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z8/Dto1fZWvemiY5@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2025 06:01, Varadarajan Narayanan wrote:
> On Mon, Mar 10, 2025 at 12:37:28PM +0100, Krzysztof Kozlowski wrote:
>> On 10/03/2025 08:44, Varadarajan Narayanan wrote:
>>> On Thu, Mar 06, 2025 at 01:06:13PM +0100, Krzysztof Kozlowski wrote:
>>>> On 06/03/2025 12:52, Krzysztof Kozlowski wrote:
>>>>> On 20/02/2025 10:42, Varadarajan Narayanan wrote:
>>>>>> All DT entries except "reg" is similar between ipq5332 and ipq9574. ipq9574
>>>>>> has 5 registers while ipq5332 has 6. MHI is the additional (i.e. sixth
>>>>>> entry). Since this matches with the sdx55's "reg" definition which allows
>>>>>> for 5 or 6 registers, combine ipq9574 with sdx55.
>>>>>>
>>>>>> This change is to prepare ipq9574 to be used as ipq5332's fallback
>>>>>> compatible.
>>>>>>
>>>>>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>
>>>>> Unreviewed.
>>>>>
>>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>>> ---
>>>>>> v8: Add 'Reviewed-by: Krzysztof Kozlowski'
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>> index 7235d6554cfb..4b4927178abc 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>> @@ -169,7 +169,6 @@ allOf:
>>>>>>              enum:
>>>>>>                - qcom,pcie-ipq6018
>>>>>>                - qcom,pcie-ipq8074-gen3
>>>>>> -              - qcom,pcie-ipq9574
>>>>>
>>>>> Why you did not explain that you are going to affect users of DTS?
>>>>>
>>>>> NAK
>>>
>>> Sorry for not explicitly calling this out. I thought that would be seen from the
>>> following DTS related patches.
>>>
>>>> I did not connect the dots, but I pointed out that you break users and
>>>> your DTS is wrong:
>>>> https://lore.kernel.org/all/f7551daa-cce5-47b3-873f-21b9c5026ed2@kernel.org/
>>>>
>>>> so you should come back with questions to clarify what to do, not keep
>>>> pushing this incorrect patchset.
>>>>
>>>> My bad, I should really have zero trust.
>>>
>>> It looks like it is not possible to have ipq9574 as fallback (for ipq5332)
>>> without making changes to ipq9574 since the "reg" constraint is different
>>> between the two. And this in turn would break the ABI w.r.t. ipq9574.
>>
>> I don't get why this is not possible. You have one list for ipq9574 and
>> existing compatible devices, and you add second list for new device.
>>
>> ... or you just keep existing order. Why you need to keep changing order
>> every time you add new device?
> 
> Presently, sdx55 and ipq9574 have the following reg/reg-names constraints.
> 
> 	compatible	| qcom,pcie-sdx55	| qcom,pcie-ipq9574
> 	----------------+-----------------------+------------------
>         reg	minItems| 5			| 5
> 		maxItems| 6			| 5
> 	----------------+-----------------------+------------------
>         reg-names	|			|
> 		minItems| 5			| 5
> 	----------------+-----------------------+------------------
> 		maxItems|			| 5 (6 for ipq5332)
> 	----------------+-----------------------+------------------
> 		items	|			|
> 			| parf			| dbi
> 			| dbi			| elbi
> 			| elbi			| atu
> 			| atu			| parf
> 			| config		| config
> 			| mhi			| (add mhi for ipq5332)
> 	----------------+-----------------------+------------------
> 
> To make ipq9574 as fallback for ipq5332, have to add "mhi" to reg-names of
> ipq9574. 

only ipq5332 gets additional item, not ipq9574. Your sentence is not
correct. You do not have to add mhi to ipq9574. Neither we, nor schema
asked you to do this.


> Once I add that, the sdx55 and ipq9574 is the same list but in
> different order.
> 

You cannot change the order in existing devices.

> If this would not be considered as duplication of the same constraint, then I
> can club ipq5332 with ipq9574.
> 
> If this would be considered as duplication, then sdx55 and ipq9574 would have to
> use the same reg-names list and sdx55 or ipq9574 reg-names order would change.
> 
>>> To overcome this, two approaches seem to be availabe
>>>
>>> 	1. Document that ipq9574 is impacted and rework these patches to
>>> 	   minimize the impact as much as possible
>>
>> What impact? What is the reason to impact ipq9574? What is the actual issue?
> 
> By impact, I meant the change in the reg-names order as mentioned above (for
> considered as duplication).

Then you must eliminate the impact, not minimize it.

> 
>>> 		(or)
>>>
>>> 	2. Handle ipq5332 as a separate compatible (without fallback) and reuse
>>> 	   the constraints of sdx55 for "reg" and ipq9574 for the others (like
>>> 	   clock etc.). This approach will also have to revert [1], as it
>>> 	   assumes ipq9574 as fallback.
>>>
>>> Please advice which of the above would be appropriate. If there is a better 3rd
>>> alternative please let me know, will align with that approach.
>>
>> Keep existing order. Why every time we see new device, it comes up with
>> a different order?
> 
> Will be able to do that based on the answer to 'duplication' question and how to
> handle that.

I don't understand what is duplication of something here.

> 
> 	if (adding mhi to ipq9574 reg-names != duplication)
> 
> 		/* Keep existing order */
> 
> 		* Append "mhi" to ipq9574

ipq9574 does not have mhi, does it?

If it has, it should be separate patch with its own explanation of the
hardware.


Best regards,
Krzysztof

