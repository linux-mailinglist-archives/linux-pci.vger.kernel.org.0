Return-Path: <linux-pci+bounces-40785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A7C497EA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080541888875
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5472FFF94;
	Mon, 10 Nov 2025 22:15:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E82F83BE;
	Mon, 10 Nov 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812908; cv=none; b=CnRWgbEMOpGpT94LqxFpmwrvUUq2Wo/M59Fp8oxpBsqtJBHR6QQfue0GQ2nxUy02kru+wG2FM1I4ic+yoou9/6n2dPlLMDRbP9j5+EvvjfqijI2EVYQzl0QEVumq0bQzwVCkDbctVFrwdDJ5ar/oNf86rB0yfmNWOSivk9oOYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812908; c=relaxed/simple;
	bh=+WlH/NbDr0mjjatqb4cIN9yWJOlXS/1+eJwQztpVPIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAZWEhBuXClGdcxeqJMgct0aOXv0soUx9AhsaOweUXupzIaMb43h5bswEvM8EmxgxVh1eI4pdFG0HDwfqWvMFnzq/UOmEI4PFPB8xGQNvnHcVKHkTUaX7KL+W8BlOt7ZYdIuOL1su6VlHArCzlIHDBcZIVfNVTS/oXx7ZdOgtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1762812868t96193133
X-QQ-Originating-IP: E9Yl8bFeRQ31iU6DcptQALqHx/7FY2qbcwSWHKucAQI=
Received: from [IPV6:240f:10b:7440:1:62e3:2c99 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 06:14:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3378252220156844302
Message-ID: <326A5CF08811110E+7785bc1e-6245-453d-9312-1b5726e7aed1@radxa.com>
Date: Tue, 11 Nov 2025 07:14:23 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Damien Le Moal
 <dlemoal@kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
References: <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
 <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
 <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>
 <aRHb4S40a7ZUDop1@ryzen>
 <2n3wamm3txxc6xbmvf3nnrvaqpgsck3w4a6omxnhex3mqeujib@2tb4svn5d3z6>
 <aRJEDEEJr9Ic-RKN@fedora>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <aRJEDEEJr9Ic-RKN@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MIfEOJQLr2d3R5VWvHtd3WXY3phVeHxbPzqeNq5Gp8qpfCZ5LghL9pHW
	neXswakvSU6G+GriCMfvO4Oz6PbIPMNiQ8ICbTqwi3NNCY6Y05Nw5QgP/GNSmpU5+XBAU+3
	sbqOmMb1NLQ6FhNz4EC3UyLrFEmiPP62qAUMjucX5mtXIDU0bhQB7jqjDFkMyv9nDdQB09n
	d9Shhlbf8fQO8SOeDAijUc2rWDmzG7qZM/OSpaleaKoyR7HFuz3PcX0SmIMaQ6obqKVyuUD
	WijWjZ1NWxoniE8phTPNTRxVC0CzJr1y+I93ZjXQ0bglP/xJfSuXOrTHBtewM0AOjFILkZ2
	cdIYgtbjOQvTM428g59Yjq8p5Q1rGgNBcZKMOBwyDg0BjzZj8l7LYAvFNyzx64lByhsToQi
	osgJSTnDCaNOEicp3JT0cJRTyQN/rX5viMVDSn3AKQ1RZXTtkYqX3BN1ekTJtwie1t2n57w
	TmlG0XtiPj8FlVMzhNhy7uAdNUJq2IF/SoCOc+KbhD5TgBVH9yBf5EXsD0tj9/L5DvnNMZY
	GOHA5q50tgVUevbZEzEFz211eYnaCBW+MqrI+iy+LKeTSbPE6PgBlZKjjeMKub0pi/fkNJ3
	p32X2jkBY6Vygwh0QCvyINKYUvqtwMguXqL3sq/ADUJw5XHXCrFRkh4AUcpOrpafCWRWp3b
	Yw/qhRHC0L9tjPvo+CAyQRa+glNkWF5DiAryi58cQmgCd5NHK6gFtD6O0wH0yPHNDoQgTrP
	cIrX2NN/VT4Zvi+dzm/u3KOr8PvXeX7Kzeun5IYMPXbuKPkBiueCpE3G1EVUYNs/CncJof3
	4/A802S4zD2ECW/qQLTJnskrt9gPj+N3m9HZVWKC7y/nyVQ9Qh5YNDDoYa6vQ23YNGan1Rc
	76CUB1VonyGOhcKKUmqcEBUP1A6n3X3mfn8QZkTDLqlYZqqt63JDl6JNLL8SDydkyjoAgoD
	sOyjBvzuuIKRMSmXW2QCG9NQJzaU90flUocpR/p+0a1OO2M2uXc9O1vcWKBzs1YiwIhk=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi Niklas,

On 11/11/25 04:59, Niklas Cassel wrote:
> On Mon, Nov 10, 2025 at 09:23:02PM +0530, Manivannan Sadhasivam wrote:
>>>
>>> Considering what Shawn says, that the switch gets enumerated properly
>>> if we simply add a msleep() in ->start_link(), which will be called
>>> by dw_pcie_host_init() before pci_host_probe() is called...
>>>
>>
>> Yes, that delay probably gives enough time for the link up IRQ to kick in before
>> the initial bus scan happens.
> 
> I think that the problem is that even for platforms with link up IRQ,
> we will always do:
> 1) dw_pcie_start_link() (if (!dw_pcie_link_up()))
> 2) pci_host_probe() from dw_pcie_host_init(), this will enumerate the bus
> 3) pci_rescan_bus() from the Link Up IRQ handler
> 
> Thus, in 2, when enumerating the bus, without performing any of the delays
> mandated by the PCIe spec, it still seems possible to detect a device (it
> must have been really quick to initialize), and to communicate with that
> device, however since we have not performed the delays mandated by the spec,
> it appears that the device might not yet behave properly.
> 
> Hence my suggestion to never call pci_host_probe() in dw_pcie_host_init()
> for platforms with Link Up IRQ.
> 
> At least for pcie-dw-rockchip.c, we only unmask the Link Up IRQ after
> dw_pcie_host_init() has returned, so I think that your theory: that Shawn's
> suggested delay causes the Link Up IRQ to kick in before the initial bus
> scan, is incorrect. (Since the IRQ should not be able to trigger until
> dw_pcie_host_init() has returned.)
> 
> 
>>
>>> ...we already have a delay in the link up IRQ handler, before calling
>>> pci_rescan_bus().
>>>
>>
>> That delay won't help in this case.
> 
> Sure, I was just saying that even though Shawn's patch made things work,
> it seems incorrect, as we do not want to add "the same delay" that we
> already have in the Link Up IRQ. (The delay in the Link Up IRQ should be
> the only one.)
> 
> 
>>> I think a better solution would be something like:
> 
> (snip)
> 
>> This solution will work as long as the PCIe device is powered ON before
>> start_link(). For CEM and M.2 Key M connectors, the host controller can power
>> manage the components. But for other specifications/keys requiring custom power
>> management, a separate driver would be needed.
>>
>> That's why I suggested using pwrctrl framework as it can satisfy both usecases.
>> However, as I said, it needs a bit of rework and I'm close to submitting it.
>>
>> But until that gets merged, either we need to revert your link up IRQ change or
>> have the below patch. IMO, the revert seems simple.
> 
> Using pwrctrl framework once it can handle this use case sounds good to me.
> 
> FUKAUMI, could you please send a revert of the two patches?

Well, I cannot write a detailed explanation...

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Kind regards,
> Niklas
> 



