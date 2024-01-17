Return-Path: <linux-pci+bounces-2270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BB830448
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3B81C216D9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C5E1D553;
	Wed, 17 Jan 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WGkVx8oP"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C841DFD7;
	Wed, 17 Jan 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489916; cv=none; b=kPhXKSanmgOwq9cxPghOAl0Ca3cmxXDiUbBG3/vioXY9k9uSxSjbt9itBI/OMBMWy8XqwiBj8k8mpGl92GqJ4/APrRY2Sd4qiBLjh9N0My72WbtVTwrTCvzX3g+YayknvEa0Pk1TMdUZ2D/fc5NFjAxt4DFtFwzIXmlGBqjKxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489916; c=relaxed/simple;
	bh=GnHcBZnjVc0rLES8KEhSGk91E7dxavFJpjAPdYgsG54=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EXCLAIMER-MD-CONFIG; b=s6WQzliINfeF06U0JnAT3pjvDdr6J4xiULghnVQgHXnXgahBlSPL2LCSdYydkJpAUO53zr2ZCOMuj58FyN6NjDXMY8+8D1fUimzb8+ArcLi6DU/vfUqzTraXu1EBz0pkzJvx3PTtBQOUB+xxChSI9IitTQs0Ptsf25Ld6H4/td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WGkVx8oP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HBBjPG114712;
	Wed, 17 Jan 2024 05:11:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705489905;
	bh=LCsY0X7YUdmmHSQX+auS0l5O0K3VRySj/An42OQmeDg=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=WGkVx8oPR0WQvIU6aza8uJJ56Isyesw4A4ZilcwkjexdrFuvliANVnJC58W/0anHP
	 hntmVqhfQi1zHY3NWQNHV31DbmeloSGAtHctHgExfGw7x5y8EcLBh/XJHIq5U0YGN0
	 KeK1XwB3+rogh6NGblR9AtjcopUr5h7ObgrHxBpY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HBBjaN067875
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 05:11:45 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 05:11:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 05:11:44 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HBBe4A102136;
	Wed, 17 Jan 2024 05:11:41 -0600
Message-ID: <ef9a7718-039c-4eef-915d-c96778d70a0f@ti.com>
Date: Wed, 17 Jan 2024 16:41:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: ti,j721e-pci-*: Fix check for
 num-lanes
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-2-s-vadapalli@ti.com>
 <28fd561a-7c13-48dc-9995-230dc758f257@linaro.org>
 <a25ea57b-4529-4a4c-9e0b-ccd85b0457d6@ti.com>
 <bd3e809f-5d97-428f-9387-a2475c4f0d7d@linaro.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <bd3e809f-5d97-428f-9387-a2475c4f0d7d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/01/24 16:23, Krzysztof Kozlowski wrote:
> On 17/01/2024 11:47, Siddharth Vadapalli wrote:
>> Hello Krzysztof,
>>
>> On 17/01/24 16:04, Krzysztof Kozlowski wrote:
>>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>>> The existing implementation for validating the "num-lanes" property
>>>> based on the compatible(s) doesn't enforce it. Fix it by updating the
>>>> checks to handle both single-compatible and multi-compatible cases.
>>>>
>>>> Fixes: b3ba0f6e82cb ("dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes")
>>>> Fixes: adc14d44d7cb ("dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings")
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
>>>>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 26 ++++++++++++++-----
>>>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 26 ++++++++++++++-----
>>>>  2 files changed, 38 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>>> index 97f2579ea908..278e0892f8ac 100644
>>>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>>> @@ -68,8 +68,9 @@ allOf:
>>>>    - if:
>>>>        properties:
>>>>          compatible:
>>>
>>> Missing contains:, instead of your change.
>>
>> I did try the "contains" approach before determining that the implementation in
>> this patch is more suitable. Please consider the following:
>>
>> For AM64 SoC the primary compatible is "ti,am64-pcie-ep" and fallback compatible
>> is "ti,j721e-pcie-ep". For J7200 SoC the primary compatible is
>> "ti,j7200-pcie-ep" while the fallback compatible is again "ti,j721e-pcie-ep".
>>
>> Therefore, the device-tree nodes for AM64 and J7200 look like:
>>
>> AM64:
>>     compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
>>     ...
>>     num-lanes = 1;
>>
>> J7200:
>>     compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
>>     ...
>>     num-lanes = 4;
>>
>> This implies that when the check for "num-lanes" is performed on the device-tree
>> node for PCIe in J7200, the fallback compatible of "ti,j721e-pcie-ep" within the
>> AM64's "compatible: contains:" check will match the schema and it will check the
>> existing "num-lanes" being described as "const: 1" against the value in J7200's
>> PCIe node resulting in a warning. 
> 
> What warning? What did you put to contains?

The warning is:
num-lanes: expected value is 1
which it has determined due to the presence of "ti,j721e-pcie-ep" in the first
check which is only applicable to AM64. The shared fallback compatible here is
responsible for incorrect checks when using "contains".

Using "contains", the check for "num-lanes" with "const: 1" corresponding to
AM64 ends up validating against the device-tree node for J7200 since the
fallback compatible "ti,j721e-pcie-ep" is "contained" in the list of compatibles
present in the device-tree node. That shouldn't be the case which is why "items"
is used in this patch to get an exact match.

> 
>> Therefore, using "contains" will result in
>> errors if the check has to be performed for device-tree nodes with fallback
>> compatibles. The "items" based approach I have used in this patch ensures that
>> the schema matches *only* when both the primary and fallback compatible are
>> present in the device-tree node.
> 
> Long message, but I don't understand it. Why this binding is different
> than all others which rely on contains?

This binding is different because of the existence of a shared fallback
compatible and a shared property being evaluated. In other bindings which use
contains, either there isn't a shared fallback compatible, or the property which
is present in device-tree nodes which have the shared fallback compatible isn't
evaluated.

In brief, with the existing device-tree, without any changes, adding "contains"
will throw warnings due to the incorrect schema matching for validating the
"num-lanes" property.

> 
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          items:
>>>> +            - const: ti,j784s4-pcie-ep
>>>
>>> Why? Previous code was correct.
>>
>> Though I used "patience diff", for some reason the addition of
>> "ti,j721e-pcie-ep" in the check has been treated as the removal of
>> "ti,j784s4-pcie-ep" first followed by adding the same later for generating the
>> diff in this patch. The diff above is equivalent to the addition of:
> 
> No, why do you change existing code? It is correct.

Either a "contains" or an "items" is required to evaluate the "num-lanes"
property and neither of them are present in the existing code.

-- 
Regards,
Siddharth.

