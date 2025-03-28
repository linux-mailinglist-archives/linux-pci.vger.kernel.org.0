Return-Path: <linux-pci+bounces-24917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC24A7444A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 08:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236B61898057
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764521148E;
	Fri, 28 Mar 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfDtM1qf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1919F11F;
	Fri, 28 Mar 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743146428; cv=none; b=is8wi1AVznz6/XwCKl3y+/CsbZe/I4cS+bZiQvTwZ84UMtUzp24rxPrqVZfbn8zW55Xmn4AOz2A66L3JCeU8VW+6NHmW9jG4LaSusCEEt5tUx+LS55gg3RTEUroKI/ZDHPHIGdaAGrJ+eP0+MbieASk71monNAauzAzBGfIQbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743146428; c=relaxed/simple;
	bh=tyNjwTGcUTBr1cGYdYH3l/AqGZbj90ulg1UKuRkqgmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPnNHgkTRlRG/3qFCgQ/zYNcr/DE+B2Qgrv7Zn+wrE1omNg7bbuf2bQ168HcvFtmuvGj1OkU2JMUozSFBW9m20JkaXe5MCxeCZYVAMwYaidUbny8lF6wGfT71YU8BtNqPIHbUgQHiTr7VX7IGT+plP2FCqcnTKGlyXKYkxP2RiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfDtM1qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F984C4CEE4;
	Fri, 28 Mar 2025 07:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743146428;
	bh=tyNjwTGcUTBr1cGYdYH3l/AqGZbj90ulg1UKuRkqgmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QfDtM1qfZEHlWZ0QKzEtnmzeMvkGjvtS8jdD29cc6g7B4vbT1nxach763FISX4ltW
	 ciAH1LlzwiOkDKCsSbeTpdyCvIShsie2OTxgoUYPvZOZSD9qMHYePhoufy7GXKGJTt
	 wBC/eokG58QmidmTb24NzqQjJFT69TdDYpUye/i1OTIvEVdxC/u/Nv9j1VW2vgZP3t
	 Wqmo6x7mBoe2OLrd3epOkSRFBpE7xrM03RtotDq0ehbhu6PSZHG1x+0uaXgH5oz+Hq
	 6QVlSiBcWo+g2YlwqciiWnHRL3OcQuV9AsbIhT6gj+8eTuyuUK+wvDSC71lBajl7UB
	 ypg9gnBZ2n27Q==
Message-ID: <bf329eeb-62e5-405e-8954-df9d4fc73d63@kernel.org>
Date: Fri, 28 Mar 2025 08:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: pci: cadence: Extend compatible for new
 platform configurations
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Milind Parab <mparab@cadence.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111106.2947888-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <6a487a73-3f2d-4373-8e02-ba749181bdfb@kernel.org>
 <DS0PR07MB1049293A9CDEBA2B3BCCED34DA2A02@DS0PR07MB10492.namprd07.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <DS0PR07MB1049293A9CDEBA2B3BCCED34DA2A02@DS0PR07MB10492.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2025 06:07, Manikandan Karunakaran Pillai wrote:
>> EXTERNAL MAIL
>>
>>
>> On 27/03/2025 12:19, Manikandan Karunakaran Pillai wrote:
>>> Document the compatible property for the newly added values for PCIe EP
>> and
>>> RP configurations. Fix the compilation issues that came up for the existing
>>> Cadence bindings
>>
>> These are two different commits.
> 
> Ok
> 
>>
>>>
>>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>>> ---
>>>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  12 +-
>>>  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 119 +++++++++++++++---
>>>  2 files changed, 110 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>>> index 98651ab22103..aa4ad69a9b71 100644
>>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>>> @@ -7,14 +7,22 @@ $schema:
>> https://urldefense.com/v3/__http://devicetree.org/meta-
>> schemas/core.yaml*__;Iw!!EHscmS1ygiU1lA!CB5lvkvRUKSEDPSjpW7GJoPNyXZ
>> xMge5SyndD4Z-VVLCZvzLIPDP-BMRjhKZ2UTxi6a18vaodaU$
>>>  title: Cadence PCIe EP Controller
>>>
>>>  maintainers:
>>> -  - Tom Joseph <tjoseph@cadence.com>
>>> +  - Manikandan K Pillai <mpillai@cadence.com>
>>>
>>>  allOf:
>>>    - $ref: cdns-pcie-ep.yaml#
>>>
>>>  properties:
>>>    compatible:
>>> -    const: cdns,cdns-pcie-ep
>>> +    oneOf:
>>> +      - const: cdns,cdns-pcie-ep
>>> +      - const: cdns,cdns-pcie-hpa-ep
>>
>> What is hpa? Which soc is that?
>>
>> I don't think this should keep growing, but instead use SoC based
>> compatibles.
>>
>> Anyway, that's enum.
>>
> 
> HPA is high performance architecture based controllers. The major difference here in PCIe controllers is that
> the address map changes. Each of the compatibles defined here have different address maps that allow the driver
> to support them from the driver using compable property that provides the info from related data "struct of_device_id" in the driver.

Just switch to SoC specific compatibles.

> 
>>> +      - const: cdns,cdns-cix-pcie-hpa-ep
>>
>> What is cix? If you want to stuff here soc in the middle, then no, no
>> no. Please read devicetree spec and writing bindings how the compatibles
>> are created.
>>
> 
> As mentioned in the earlier sections, cix is another implementation of the PCIe controller where 
> the address map is changed by our customer

So a SoC. Use SoC compatibles and follow every other recent binding.

> 
>>> +      - description: PCIe EP controller from cadence
>>> +        items:
>>> +          - const: cdns,cdns-pcie-ep
>>> +          - const: cdns,cdns-pcie-hpa-ep
>>> +          - const: cdns,cdns-cix-pcie-hpa-ep
>>
>> This makes no sense.
>>
> Only one of the above compatible is valid for PCIe controllers, which will be defined in the SoC related binding.

That's not how lists are working. Don't explain me what it does, because
I know that it does nothing good: it's broken code. You can explain me
what you wanted to achieve, but still this part is just wrong and makes
no sense. Drop.




> 
>>>
>>>    reg:
>>> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>> index a8190d9b100f..bb7ffb9ddaf9 100644
>>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>>
>>>  maintainers:
>>> -  - Tom Joseph <tjoseph@cadence.com>
>>> +  - Manikandan K Pillai <mpillai@cadence.com>
>>>
>>>  allOf:
>>> -  - $ref: cdns-pcie-host.yaml#
>>> +  - $ref: cdns-pcie.yaml#
>>
>> Why?
>>
> 
> The existing yaml files were throwing out errors and the changes in these files are for fixing them.

Then rather investigate the errors instead of doing random changes.

> 
>>>
>>>  properties:
>>> +  "#size-cells":
>>> +    const: 2
>>> +  "#address-cells":
>>> +    const: 3
>>
>> Huh? Why? Nothing here makes sense.
>>
>>
> Compilation error related fixes.

NAK, no point at all.

Best regards,
Krzysztof

