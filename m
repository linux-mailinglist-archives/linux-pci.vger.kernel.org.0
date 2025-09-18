Return-Path: <linux-pci+bounces-36397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B16B82BBB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 05:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C0E4A4926
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 03:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E45C1FBEB9;
	Thu, 18 Sep 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gSRyPFPK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBBE23C4F4;
	Thu, 18 Sep 2025 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165412; cv=none; b=TlSB62Np8AVNraWLOp/fdAYnCnlwp0h+DI/oKu15u2Zyk7TAN04sXB9/gDc8d5+QxERqtfIVK9qZcxcM0ihmlhx+Hd5rUswmssORoJ36xH2j6VKdGqxT53gXW6qHccUpKesMkifWL/JprS5FdMuiSuLqecNDGeOKiYG0QvibJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165412; c=relaxed/simple;
	bh=ryTT3N25mG7wS1phsm1BBg04KF1Hd0yABxMx56lwJXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiM8Y1u70SqZHqDuP0YuOK+S2Ooa86zBhoTKSZPwuQWIl5DiQuRAWnTbzE9tDZPDVmCYubPOmCFCmWX1yTcHj48N3Bwx8pjPOSnit1HDZqFvFsgRjoWRAioWdqOCUuJKEyx2+3o5rTN/fLOP0Mk5Fr0qlA7RCi5O3BlB1bH5H+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gSRyPFPK; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cS1596G9fz9tgv;
	Thu, 18 Sep 2025 05:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758165405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJiellIJxOMKYBDkQCC2kMZIE2wxTzAMm26GhkPt9Jg=;
	b=gSRyPFPKICc2fMJT/Zf4K+kDOPoIQ/gtz0OtsPajy8ngZL3zlP89Tc67NjN2OVUvdfoRIx
	U8CdJX6VPWp5xmioK78MM7A/EWOhKViOyiIgrWdxTZE3tQoAotLSft8GpSW0/LFNLyoOh0
	IqGcUqhVorQwcHr10ZI704bJ8sIW5dj/A98mBuP7y0++a/MP7HoLZtkUXrPB2ZrOw2/f0G
	U32FC0pEg0jYoiztsPQfI78sUMmGjmYIQIiw6q40Tt/SKcTeBkUPYay+CZvyTsOwow4Oor
	kjb+xC3kUgf3l56sSgDEhvq2CID9PIiOs6w9Sq+UjVBy7AE8TjrynvmoNNzhlA==
Message-ID: <12b54030-5505-416b-9e4e-2338263c5c7a@mailbox.org>
Date: Thu, 18 Sep 2025 05:16:43 +0200
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
 <de4e4003-214f-4260-854c-d15efc81bb74@mailbox.org>
 <CAMuHMdVgFNb-3TgL7a+AJMYE6tqOiMpGYFDhXnQoz9R5gLz=-A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdVgFNb-3TgL7a+AJMYE6tqOiMpGYFDhXnQoz9R5gLz=-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 31s7ai5uoss1fgcmjc99mwgm3nccu1ok
X-MBO-RS-ID: c4ff34d47b981fde408

On 9/17/25 9:23 AM, Geert Uytterhoeven wrote:

Hello Geert,

> On Tue, 16 Sept 2025 at 18:31, Marek Vasut <marek.vasut@mailbox.org> wrote:
>> On 9/16/25 3:57 PM, Geert Uytterhoeven wrote:
>>> On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>> On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
>>>>> On Tue, 16 Sept 2025 at 01:59, Marek Vasut
>>>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>>> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
>>>>>> Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
>>>>>> indicates that register 0xf8 should be polled until bit 18 becomes set to 1.
>>>>>>
>>>>>> Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
>>>>>> to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
>>>>>> condition is inverted and returns when register 0xf8 bit 18 is set to 0,
>>>>>> which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
>>>>>> the timing changes just enough for the first readl_poll_timeout() poll to
>>>>>> already read register 0xf8 bit 18 as 1 and afterward never read register
>>>>>> 0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
>>>>>> controller.
>>>>>>
>>>>>> Fix this by inverting the poll condition to match the reference manual
>>>>>> initialization sequence.
>>>>>>
>>>>>> Fixes: faf5a975ee3b ("PCI: rcar-gen4: Add support for R-Car V4H")
>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>>>> @@ -711,7 +711,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
>>>>>>            val &= ~APP_HOLD_PHY_RST;
>>>>>>            writel(val, rcar->base + PCIERSTCTRL1);
>>>>>>
>>>>>> -       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
>>>>>> +       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 100, 10000);
>>>>>>            if (ret < 0)
>>>>>>                    return ret;
>>>>>>
>>>>>
>>>>> This change looks correct, and fixes the timeout seen on White Hawk
>>>>> with CONFIG_DEBUG_LOCK_ALLOC=y.
>>>>> However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
>>>>>
>>>>>        SError Interrupt on CPU0, code 0x00000000be000011 -- SError
>>>>
>>>> ...
>>>>
>>>>>         el1h_64_error_handler+0x2c/0x40
>>>>>         el1h_64_error+0x70/0x74
>>>>>         dw_pcie_read+0x20/0x74 (P)
>>>>>         rcar_gen4_pcie_additional_common_init+0x1c/0x6c
>>>>
>>>> SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
>>>> this fix.
>>>>
>>>> Does the following patch make this SError go away ?
>>>
>>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>> @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
>>>> rcar_gen4_pcie *rcar)
>>>>            if (ret)
>>>>                    goto err_unprepare;
>>>>
>>>> +mdelay(1);
>>>> +
>>>>            if (rcar->drvdata->additional_common_init)
>>>>                    rcar->drvdata->additional_common_init(rcar);
>>>>
>>>
>>> Yes it does, thanks!
>> So with this one extra mdelay(1), the PCIe is fully good on your side,
>> or is there still anything weird/flaky/malfunctioning ?
>>
>> If you could give me a RB/TB on this fix, it would be nice.
> 
> You can have my
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> but only for the combination of both (A) "[PATCH] PCI: rcar-gen4: Fix
> inverted break condition in PHY initialization" and (B) the addition
> of the mdelay.
> 
>    - (A) without (B) causes an SError if CONFIG_DEBUG_LOCK_ALLOC=n,
> 
>    - (B) without (A) causes a timeout if CONFIG_DEBUG_LOCK_ALLOC=n
>      (i.e. same behavior as with CONFIG_DEBUG_LOCK_ALLOC=y).
I have instead posted what I think are proper fixes for that SError:

PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
https://patchwork.kernel.org/project/linux-pci/patch/20250918030058.330960-1-marek.vasut+renesas@mailbox.org/

clk: renesas: cpg-mssr: Add missing 1ms delay into reset toggle callback
https://patchwork.kernel.org/project/linux-clk/patch/20250918030552.331389-1-marek.vasut+renesas@mailbox.org/

clk: renesas: cpg-mssr: Read back reset registers to assure values latched
https://patchwork.kernel.org/project/linux-clk/patch/20250918030723.331634-1-marek.vasut+renesas@mailbox.org/

I hope those help. Can you please let me know if they do help ?

