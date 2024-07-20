Return-Path: <linux-pci+bounces-10567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C00938282
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B98C1F217C7
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1519E146D6C;
	Sat, 20 Jul 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I29YE8YR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DB1B86E6;
	Sat, 20 Jul 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721500242; cv=none; b=bLDxEmbEcVpbRRH2Q9Sg2PpucK4jpFHKwhLKmoI9zzkfjc24YDuvycVkM+Jertu6aaWvrgDWguWjbycqDaNXCc8WJQqdOu+/8UhPfbWa/DPMBK7Jwlyfe3MsF04SF+Z8+iXYWvCG31bJJ3UOlzz46kVa3w0Tp8/MquBT5SO4qyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721500242; c=relaxed/simple;
	bh=N0thndlb9Rc77vx54WY3aUNoYfyGWgbYGRzNclFlqZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Edai0Ecgst/hhcqy+MjNQbdM3IVe8OW31NG0TD8Cu6m/pLSJ8y0LUI8OLZvtI54xLkn0Z0vHxAEW/SPl0xfo5s4EuJT+J4RCcgT0Cts4PDsa/NwJUfICXL/+wLE8/yX1wFFP/YK3apZGaZBtgmtyNdslKea4Eg3YG5IunnnVfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I29YE8YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D5FC2BD10;
	Sat, 20 Jul 2024 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721500241;
	bh=N0thndlb9Rc77vx54WY3aUNoYfyGWgbYGRzNclFlqZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I29YE8YRAm9zGA5TQZHMSFZqt87/BaRjiJ+i7d4OAdPq6jWdlYrJ7Y3T0AOF5zDYO
	 DL65OGlJGpcB1DPYlkJ/jYHK4ZpG44oHXw9Gq0Nz0A/tNCaqTMrxMmQq6Js+G4szKu
	 +9B9VOahOP/LvDjE77Wf/I6SB3DeYW/jUAb/yf94goaN+vyyD6mWwyZSq62GtVTvEo
	 TZZ9TYR5kYC9ax0FCLh7KnZYrQXWaHb/264z7jxn1Xkd+4Gt9kwjfdC41qi4bsYgdd
	 Z/W1aataRLkCS70MgIOZ30Vnw5FWkAhhZeDABHZs3yF+ihy3Y5Fjx8M7s5Ejvqm7w6
	 ZcS293U3O7tNw==
Message-ID: <24aee2d7-927b-4ea0-bb34-e8f63d8e7856@kernel.org>
Date: Sat, 20 Jul 2024 20:30:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V226/7] dt-bindings: PCI: host-generic-pci: Add
 snps,dw-pcie-ecam-msi binding
To: Mayank Rana <quic_mrana@quicinc.com>, will@kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org, cassel@kernel.org,
 yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com,
 u.kleine-koenig@pengutronix.de, dlemoal@kernel.org, amishin@t-argos.ru,
 thierry.reding@gmail.com, jonathanh@nvidia.com, Frank.Li@nxp.com,
 ilpo.jarvinen@linux.intel.com, vidyas@nvidia.com,
 marek.vasut+renesas@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Cc: quic_ramkri@quicinc.com, quic_nkela@quicinc.com,
 quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
 quic_nitegupt@quicinc.com
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-7-git-send-email-quic_mrana@quicinc.com>
 <5f029f16-2030-4e86-929b-0b2832958912@kernel.org>
 <083e1e6f-714d-4a3e-a864-59e06bba0559@quicinc.com>
 <3221423a-d5b3-47e3-8b98-623d9b26363d@kernel.org>
 <f06ab1ee-6078-4d89-b236-e11be4d28fc5@quicinc.com>
 <609c2420-4bf9-4d1b-b998-2dea825139b2@kernel.org>
 <1a6f5cdf-9256-4d8d-b8c7-92bd6e7d3813@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <1a6f5cdf-9256-4d8d-b8c7-92bd6e7d3813@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/07/2024 01:19, Mayank Rana wrote:
> Hi Krzysztof
> 
> On 7/17/2024 11:05 PM, Krzysztof Kozlowski wrote:
>> On 17/07/2024 19:20, Mayank Rana wrote:
>>> Hi Krzysztof
>>>
>>> On 7/16/2024 11:47 PM, Krzysztof Kozlowski wrote:
>>>> On 17/07/2024 00:09, Mayank Rana wrote:
>>>>> Hi Krzysztof
>>>>>
>>>>> On 7/16/2024 12:28 AM, Krzysztof Kozlowski wrote:
>>>>>> On 15/07/2024 20:13, Mayank Rana wrote:
>>>>>>> To support MSI functionality using Synopsys DesignWare PCIe controller
>>>>>>> based MSI controller with ECAM driver, add "snps,dw-pcie-ecam-msi
>>>>>>> compatible binding which uses provided SPIs to support MSI functionality.
>>>>>>
>>>>>> To support MSI, you add MSI support... That's a tautology. Describe
>>>>>> hardware instead.
>>>>> Ok. let me repharse it to provide more useful information.
>>>>>>>
>>>>>>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>>>>>>> ---
>>>>>>>     .../devicetree/bindings/pci/host-generic-pci.yaml  | 57 ++++++++++++++++++++++
>>>>>>>     1 file changed, 57 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>>>>> index 9c714fa..9e860d5 100644
>>>>>>> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>>>>> @@ -81,6 +81,12 @@ properties:
>>>>>>>                   - marvell,armada8k-pcie-ecam
>>>>>>>                   - socionext,synquacer-pcie-ecam
>>>>>>>               - const: snps,dw-pcie-ecam
>>>>>>> +      - description: |
>>>>>>> +         Firmware is configuring Synopsys DesignWare PCIe controller in RC mode with
>>>>>>> +         ECAM compatible fashion. To use MSI controller of Synopsys DesignWare PCIe
>>>>>>> +         controller for MSI functionality, this compatible is used.
>>>>>>> +        items:
>>>>>>> +          - const: snps,dw-pcie-ecam-msi
>>>>>>
>>>>>> MSI is already present in the binding, isn't it?
>>>>> It is mentioning as msi-parent usage which could be different MSI
>>>>> controller (GIC or vendor specific one) not related to designware PCIe
>>>>> controller based MSI controller.
>>>>>
>>>>>> Anyway, aren't you
>>>>>> forgetting specific compatible? Please open your internal (quite
>>>>>> comprehensive) guideline on bindings and DTS.
>>>>> Here I am trying to define Designware based PCIe ECAM controller
>>>>> supporting MSIcontroller based device. Hence I am not mentioning vendor
>>>>> specific compatible usage
>>>>> and keeping generic compatible binding for such device.
>>>>
>>>> I know what you try, yet it feels simply wrong. Read your guideline.
>>>> Are you sure you work on Designware core itself, not on one used in
>>>> Qualcomm? I would expect people from Designware to design Designware
>>>> cores and people from Qualcomm only to design licensed cores.
>>> Ok. let me not make generic comment here. I refereed how it is done with
>>> other
>>> snps based IP usage for example USB, and would follow same.
>>
>> Well, it is not. If you read their bindings or any reviews related to
>> such cores, you would see that single Designware compatible is always
>> never appropriate. Such cores always have customization per user.
>>
>> You can also look at the binding you are changing. Do you see Designware
>> alone? No.
> I found reference in this binding as below:
>   79         items:
>   80           - enum:
>   81               - marvell,armada8k-pcie-ecam
>   82               - socionext,synquacer-pcie-ecam
>   83           - const: snps,dw-pcie-ecam
> 
> And as you mentioned in previous emails about how to add such usage, I 
> ACKed it but let me put reason why I tried to add differently to start 
> with it.
> 
> This specific driver under-discussion is really not vendor specific 
> driver. It can work with any PCIe controller which is already configured 
> in ECAM mode by firmware (i.e. PCIe controller from SNPS or any other 
> vendor). There are few quirks only added to get specific vendor based 
> SOC configuration for SNPS PCIe controller by different SOC vendors.
> 
>   90       - description:
>   91           CAM or ECAM compliant PCI host controllers without any quirks
>   92         enum:
>   93           - pci-host-cam-generic
>   94           - pci-host-ecam-generic
> 
> Above enum based usage works for SA8775P platform which is having SNPS 
> PCIe controller which doesn't need any quirks, and firmware is able to 
> configure PCIe controller into ECAM mode. Here I tried adding PCIe SNPS 
> controller based MSI support as SA8775P doesn't support LPI/ITS for MSI. 
> I need to differentiate it hence added generic enum as MSI controller is 
> part of SNPS PCIe controller, and not separate MSI IP here. Although how 
> many MSI can be supported it depends on how many SPIs are available/used 
> with MSI controller depend on particular SOC. Hence put as 
> snps,dw-pcie-ecam-msi as usage and variable number of MSI. hopefully I 
> am able to convey why this driver binding modified differently.

Your binding already defines some specifics for specific device, but you
still claim all of them are identical.

Sorry, I am confused. Read carefully writing bindings, consult internal
guideline (go/upstream - it is really detailed!) and then come with a
solution.

Best regards,
Krzysztof


