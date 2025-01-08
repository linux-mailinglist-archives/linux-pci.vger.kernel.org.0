Return-Path: <linux-pci+bounces-19528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00090A057B2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06203A19A0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0C1F76B9;
	Wed,  8 Jan 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tksCyIxg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904041AB511;
	Wed,  8 Jan 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331063; cv=none; b=K05qWS5sH67FGHZCU9JgxBfpBfgpCu/x6o9ky7/Hlg3/YeWqm2jimXtvJEIfrKjguEqDtwzTUl2uxqHU4NZ+1wImwN6E3zpzqNyFdL4XDBJZ/HvOjF0xvMWbASnJgE4T7B67/2+YZ3bfbjX3YzVsO4Inpo1OzhuBYbP93QH+LHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331063; c=relaxed/simple;
	bh=SlVmib1m1310d4/mE0OzqhXLkoQrPL2iREBvRmzMl/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laWG+wcJhP4W2KqAY2GHrr8loZ/+r3nLyfrG6edb2SjA9VQCOTsySDp6+HLmoJO2bl8PA+wpk3GbKfNP3t6Eo0tEHfrnMlXYgCJA7PI7dwwYnsR7dUTINCvijCMtuax0AM0W5zL/x2LGU8lRREikM4auPf+qweQImtugqPt0lCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tksCyIxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD248C4CEE0;
	Wed,  8 Jan 2025 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736331063;
	bh=SlVmib1m1310d4/mE0OzqhXLkoQrPL2iREBvRmzMl/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tksCyIxgPEhLV+IRSQPxYyzDt5/4KneOuLKlZC0Q7sd4niHxofs0vK9OWJXK1Nc+O
	 i9LdwEiQcG9DdL2cuOLkMrbYzoNagDoevbGzwb/SnsftDtEFizNuR4OcTVYJt+378v
	 X/Wj1UiRbXUbfSN9T+A9LfiI3TOWP6bxRfDP/WX/+fkjRvSIbQYHwcbW3oTviCWUVr
	 hsyUllUCjoqeCUyi380ST5gREWNz8B8hgWQ31y4lJRzT8N77cNBeBMv88U/C/e6FVV
	 CxX3IK8HVUBns8+on5z8XPZo6xWFuRFjrPOD2XSqdKBLzbvo9EDdSVbuGxH7w/CmmJ
	 00Cf3B60eYqDA==
Message-ID: <9cf60fb9-c4ab-49f0-bb48-102333fe411e@kernel.org>
Date: Wed, 8 Jan 2025 11:10:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, p.zabel@pengutronix.de,
 quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
 <20250102113019.1347068-4-quic_varada@quicinc.com>
 <4hwclzotaowog6rzfejiixqvvg7iumg4udbvq3h72mmh42dbki@piphsf37vhpv>
 <Z30KZM1RGdFvB1dy@hu-varada-blr.qualcomm.com>
 <50b03189-bf2c-46c8-b7c2-4aa5eed97c35@kernel.org>
 <Z34r9D8htoDNvagK@hu-varada-blr.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z34r9D8htoDNvagK@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2025 08:40, Varadarajan Narayanan wrote:
> On Wed, Jan 08, 2025 at 08:19:19AM +0100, Krzysztof Kozlowski wrote:
>> On 07/01/2025 12:05, Varadarajan Narayanan wrote:
>>>>> ---
>>>>>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++++--
>>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> index bd87f6b49d68..9f37eca1ce0d 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> @@ -26,7 +26,6 @@ properties:
>>>>>            - qcom,pcie-ipq8064-v2
>>>>>            - qcom,pcie-ipq8074
>>>>>            - qcom,pcie-ipq8074-gen3
>>>>> -          - qcom,pcie-ipq9574
>>>>
>>>> I don't understand this change at all and your commit msg explains
>>>> here nothing.
>>>
>>> All DT entries except "reg" is similar between ipq5332 and
>>> ipq9574. ipq9574 has 5 registers while ipq5332 has 6. MHI is the
>>> additional (i.e. sixth) entry for ipq5332.
>>>
>>> If ipq9574 is not removed from here, dt_binding_check gives the
>>> following errors
>>>
>>> 1.	/local/mnt/workspace/varada/upstream/pci-v6/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dtb: pcie@18000000: reg: [[557056, 12288], [402653184, 3869], [402657056, 168], [402657280, 4096], [403701760, 4096], [569344, 4096]] is too long
>>>
>>> 	Failed validating 'maxItems' in schema['allOf'][2]['then']['properties']['reg']:
>>> 	    {'maxItems': 5, 'minItems': 5}
>>>
>>> 2.	/local/mnt/workspace/varada/upstream/pci-v6/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dtb: pcie@18000000: reg-names: ['parf', 'dbi', 'elbi', 'atu', 'config', 'mhi'] is too long
>>>
>>> 	Failed validating 'maxItems' in schema['allOf'][2]['then']['properties']['reg-names']:
>>> 	    {'items': [{'const': 'dbi'},
>>> 		       {'const': 'elbi'},
>>> 		       {'const': 'atu'},
>>> 		       {'const': 'parf'},
>>> 		       {'const': 'config'}],
>>> 	     'maxItems': 5,
>>> 	     'minItems': 5,
>>> 	     'type': 'array'}
>>>
>>> Hence had to remove it from here and add it to the sdx55 reg
>>> definition.
>>
>> So you entirely dropped constrain for regs. No. This has to be fixed,
>> not dropped.
> 
> ipq9574 is not dropped entirely. It is clubbed with sdx55's
> constraints. Please see this
> 
> 	@@ -206,6 +208,8 @@ allOf:
> 		 compatible:
> 		   contains:
> 		     enum:
> 	+              - qcom,pcie-ipq5332
> 	+              - qcom,pcie-ipq9574
> 		       - qcom,pcie-sdx55
Correct, not dropped entirely, but now it receives mhi for no reason.
This should be separate commit with its own explanation - why ipq9574
has now MHI address space.

Best regards,
Krzysztof

