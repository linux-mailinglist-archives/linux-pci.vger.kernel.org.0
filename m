Return-Path: <linux-pci+bounces-36278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A254CB59DB6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 18:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCFD87A5F92
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5D2F25F9;
	Tue, 16 Sep 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S+5EebsK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE12F25F0;
	Tue, 16 Sep 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040301; cv=none; b=qWihHZwVvDVQ/yHLSUVchmh1Q3yugk8uBV4wSXp2tWiatIR4dKkpWaabXCTCTWjyPYev0wf58hCBWDsZPEF2UocfTe+mzUQCpk7E7SvxOFlhq3kgQ9YZ4OG6oHq3MP23M5O1QDQQDN3IKwF3IQgFBWx4qgrUNhF8KeRX6vo5WlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040301; c=relaxed/simple;
	bh=BltXC8YlMLrjfU6C9r+PBU0BGmin7H8ZvWuum5aLgtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gggDw55I2QFaCpAAwZ/wqk4iW++iW3xpiEIu0x4b+3yW9+pcSxW06P8tpMjFJMmBTMAP0rHSOUbNfn/PaWKFifoSRT2P0ANud9yFaVKnkMcFIY+z0O1I1GV7UC92qQXwiGfJO+ybyVXCDSy6MIH6bP2JtFpoZX6+SvJSD0bodB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=S+5EebsK; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cR6qC5nK9z9tLN;
	Tue, 16 Sep 2025 18:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758040295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6W41cfQ50dYJGCxKy8xGf4kfyuBoS72cimGr06okuNA=;
	b=S+5EebsKGMZbLclYFOTsVAi1q0HWBtv97dNmHbwbDrhrxBhvbVqFtqZl5sDQE3BRt2ctno
	xnlcUwkYODOtVM11MZzVdh7OoI7T5dOIeAcjPorLmi4kVHNIjw0sRhXfBkEjMNFJNPcTk3
	WuF9W4jHwcp42YXWg6tExXqc0yPokuMOKooJuvB/NWj+KVM3S0Dt3cGxcpFC56OQMT/5S5
	k2d9b40+DJJVZsO5qP4r2sLz3NNbnKrKBZw4lGmnj2qZMg2c7VNBtBjCQc9AlSZ7Lrff8T
	jstalkKHdKAk3OXPI+hLai2Kq/hNREkPzZvbomYV2YY9A9PtkUKUg8siSt1DGQ==
Message-ID: <de4e4003-214f-4260-854c-d15efc81bb74@mailbox.org>
Date: Tue, 16 Sep 2025 18:31:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY
 initialization
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com>
 <6fdc7d1e-8eaa-4244-a6b4-4a07e719dd73@mailbox.org>
 <CAMuHMdVrw1Mr_hKvgve03DQwvpqSPNaN5XUnYRJPXMeX1wvv0A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdVrw1Mr_hKvgve03DQwvpqSPNaN5XUnYRJPXMeX1wvv0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ff03ac2e315504a3809
X-MBO-RS-META: q7aucn58c5n4waiub9q64zo95sgiotaf

On 9/16/25 3:57 PM, Geert Uytterhoeven wrote:

Hello Geert,

> On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
>> On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
>>> On Tue, 16 Sept 2025 at 01:59, Marek Vasut
>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
>>>> Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
>>>> indicates that register 0xf8 should be polled until bit 18 becomes set to 1.
>>>>
>>>> Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
>>>> to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
>>>> condition is inverted and returns when register 0xf8 bit 18 is set to 0,
>>>> which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
>>>> the timing changes just enough for the first readl_poll_timeout() poll to
>>>> already read register 0xf8 bit 18 as 1 and afterward never read register
>>>> 0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
>>>> controller.
>>>>
>>>> Fix this by inverting the poll condition to match the reference manual
>>>> initialization sequence.
>>>>
>>>> Fixes: faf5a975ee3b ("PCI: rcar-gen4: Add support for R-Car V4H")
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>> @@ -711,7 +711,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
>>>>           val &= ~APP_HOLD_PHY_RST;
>>>>           writel(val, rcar->base + PCIERSTCTRL1);
>>>>
>>>> -       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
>>>> +       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 100, 10000);
>>>>           if (ret < 0)
>>>>                   return ret;
>>>>
>>>
>>> This change looks correct, and fixes the timeout seen on White Hawk
>>> with CONFIG_DEBUG_LOCK_ALLOC=y.
>>> However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
>>>
>>>       SError Interrupt on CPU0, code 0x00000000be000011 -- SError
>>
>> ...
>>
>>>        el1h_64_error_handler+0x2c/0x40
>>>        el1h_64_error+0x70/0x74
>>>        dw_pcie_read+0x20/0x74 (P)
>>>        rcar_gen4_pcie_additional_common_init+0x1c/0x6c
>>
>> SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
>> this fix.
>>
>> Does the following patch make this SError go away ?
> 
>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
>> rcar_gen4_pcie *rcar)
>>           if (ret)
>>                   goto err_unprepare;
>>
>> +mdelay(1);
>> +
>>           if (rcar->drvdata->additional_common_init)
>>                   rcar->drvdata->additional_common_init(rcar);
>>
> 
> Yes it does, thanks!
So with this one extra mdelay(1), the PCIe is fully good on your side, 
or is there still anything weird/flaky/malfunctioning ?

If you could give me a RB/TB on this fix, it would be nice.

