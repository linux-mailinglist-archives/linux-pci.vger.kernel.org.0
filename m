Return-Path: <linux-pci+bounces-25279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCEDA7B81D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 09:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365323B7638
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39AA18DB0C;
	Fri,  4 Apr 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3RnzofV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2218C930;
	Fri,  4 Apr 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743750715; cv=none; b=s6is7zxmwRi3pTBLir1ufuRNGXypc4N+BuoUGyxSclPPnhKidfNIB7ge1NrGSPGe6BMAAevcGUiu0hS74rLJHccyfRBwfMCFN8SPYUNZG/eGEylVA4HN1fN/KcNd9hCo+0GEEuhXW0bPuTHyv1/ZAwvjFhJv5ec7Opk8/HLWMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743750715; c=relaxed/simple;
	bh=FjMPHVS0p/AMhYK43KwHzjWKcIUzufN+U2ZEu6dgFIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntaxnayfHEWd0uU5nS0slnMZOWwmausv4Z65ldLVdGAJsBmUXpguJlQM2oaqoDCmv/LkjhguFx/G6Lg+D9PJUO6IXwGv6jNY5KgAd1eLlOZbLqQLZUAD8Y6R3yybbaNQqW49gf254uinFV26IzBsAnaaRYihbuAIjMozAVmAIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3RnzofV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B56BC4CEDD;
	Fri,  4 Apr 2025 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743750713;
	bh=FjMPHVS0p/AMhYK43KwHzjWKcIUzufN+U2ZEu6dgFIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X3RnzofVsxxAWLBVr6wErJOHulxI4ZDUp2vTZMDA7vpBeB6+h3kEk7ITA7mCRTWw+
	 CTd638aOn+tYDeC4LErz7ltwCx9DNXBK8zV54YQCo7m0NwFXe5yCvivB8pmbmWJeXY
	 ertgeJ48wWstISX+0qUBIDffjChu7a1hGXQXHwa1BJpEjQepRL2EX+OYCd9e124S5o
	 zwaoYZiqgN0zYpkoeu3iZrV8x+MronVLRQmKiEOsHaFZOd2WpE9tVxIkuaB7z19d28
	 IPE7K6KWaUJ0ftOmYPGctoc39pYesJ2V+hCFDjyTGIF2kE08MIfG50aj6rJ+VAvmpR
	 Tem7hp2tnDOKg==
Message-ID: <45429e61-9219-42ca-b901-ff9508b9e985@kernel.org>
Date: Fri, 4 Apr 2025 09:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cassel@kernel.org" <cassel@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
 "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-3-sai.krishna.musham@amd.com>
 <cjrb3idrj3x7vo4fujl6nakj3foyu64gtxwovmxd4qvovvhwqq@26bpt5b4zjao>
 <f65db82b-fedb-43d8-9d61-53e1bacda3ba@kernel.org>
 <DM4PR12MB61587CD51275A8E63A9B704ECDA92@DM4PR12MB6158.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <DM4PR12MB61587CD51275A8E63A9B704ECDA92@DM4PR12MB6158.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2025 09:03, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Krzysztof,
> 
> Thank you for reviewing.
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Thursday, March 27, 2025 11:38 PM
>> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Musham, Sai
>> Krishna <sai.krishna.musham@amd.com>
>> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
>> krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.org; linux-
>> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Simek, Michal <michal.simek@amd.com>; Gogada, Bharat Kumar
>> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
>> <thippeswamy.havalige@amd.com>
>> Subject: Re: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
>> signal
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 27/03/2025 18:25, Manivannan Sadhasivam wrote:
>>>>  /**
>>>> @@ -551,6 +600,27 @@ static int xilinx_cpm_pcie_parse_dt(struct
>> xilinx_cpm_pcie *port,
>>>>              port->reg_base = port->cfg->win;
>>>>      }
>>>>
>>>> +    port->crx_base = devm_platform_ioremap_resource_byname(pdev,
>>>> +                                                           "cpm_crx");
>>>> +    if (IS_ERR(port->crx_base)) {
>>>> +            if (PTR_ERR(port->crx_base) == -EINVAL)
>>>> +                    port->crx_base = NULL;
>>>> +            else
>>>> +                    return PTR_ERR(port->crx_base);
>>>> +    }
>>>> +
>>>> +    if (port->variant->version == CPM5NC_HOST) {
>>>> +            port->cpm5nc_attr_base =
>>>> +                    devm_platform_ioremap_resource_byname(pdev,
>>>> +
>>>> + "cpm5nc_attr");
>>>
>>> Where is this resource defined in the binding?
>>>
>>
>> So this is v6 and still not tested.
>>
>> Where is the DTS using this binding and driver, so we can verify that AMD is not
>> sending us such totally bogus, downstream code?
>>
> 
> This patch is tested for mentioned CPM versions, I apologize that

No, it wasn't. Testing would point that out.

> I missed adding the cpm5nc_attr resource in DT binding. I will not
> repeat this again. I will add the resource in the next patch.
> Thanks for your understanding.

Again, where is the DTS?

Best regards,
Krzysztof

