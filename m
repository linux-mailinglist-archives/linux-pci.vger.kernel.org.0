Return-Path: <linux-pci+bounces-19402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521EFA03E16
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585AB7A19B0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940DF1E3DD6;
	Tue,  7 Jan 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EFuOI6mN"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645D1EB9EF;
	Tue,  7 Jan 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250290; cv=none; b=fgxU5zPtBL+zJGDccy7PqjeBr0NIm5op43Zu5wmTTVcbXRyQrPPRoxkR3jtbiDFlIeyzaOZQZ+29acvpzf7mlV8G1mzxOa3wA0NBhvfpt1WSmg5JLadoAbvrCy23FIV9E1Ig/1ER+cZE3j6myVDYXukl7h5CtdZQee7Bca0vjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250290; c=relaxed/simple;
	bh=nvqMeuDTfZgH1m0kgkeC9rUI30xVUZ5If34vfsgD108=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTDkm5T5CmRZACSgDi6TCx7Gk77V6md+0+1K61xak2KD3B868Dg+okAyuEkf3884OqtZf0cB8IcFkEESe9GnqIEzja/8E0l1K0OYPmiUspk9W/Ia8Ztv5UeRsTWRIfwaEZdEWzxiiB+U9iOFN1EaiBT+evq7TqSLcTxMjtDxTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EFuOI6mN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736250285;
	bh=nvqMeuDTfZgH1m0kgkeC9rUI30xVUZ5If34vfsgD108=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EFuOI6mN+NcYESN+8h5Lm8qNaeVahsukk+9CT10YTgVzCyd+4f7/sDH9+bQujFO/b
	 fs5W4sudz5V5xsdbHVZB2aXZfYakIjViPDwXxQDntq+r3SMr5lgCMJY3aAG68Onkng
	 hR4jp9m3rHf5NVDvwwimGRzZIIKpUr47Omh+E4zKnB8RWmuWsqYeLW0bEX+YKVdieU
	 t1sz2Xm7HY06OUFJycn91NMyXWp9HThlOqBEbE1XPE0mW1ZIUvwdE5udJp1kqV6HOT
	 wWbEhOBSpLmIVG2HT7DP+qG6PHBHqxO5x2B3AtugpRBdIjba78ySFEieWEj7N/Gdh1
	 EBUiqSVn9+Gag==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3965017E1562;
	Tue,  7 Jan 2025 12:44:44 +0100 (CET)
Message-ID: <1a48feae-f55f-4df8-b165-84c1cb2f6658@collabora.com>
Date: Tue, 7 Jan 2025 12:44:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
To: =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-4-jianjun.wang@mediatek.com>
 <b5ef9501-e07d-4150-9518-dd982518919e@collabora.com>
 <cecd7ebf0ccac9638b8e93b28fcf4df5bb81a794.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <cecd7ebf0ccac9638b8e93b28fcf4df5bb81a794.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/01/25 03:18, Jianjun Wang (王建军) ha scritto:
> On Fri, 2025-01-03 at 10:16 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 03/01/25 07:00, Jianjun Wang ha scritto:
>>> Disable ASPM L0s support because it does not significantly save
>>> power
>>> but impacts performance.
>>>
>>
>> That may be a good idea but, without numbers to support your
>> statement, it's a bit
>> difficult to say.
>>
>> How much power does ASPM L0s save on MediaTek SoCs, in microwatts?
>> How is the performance impacted, and on which specific device(s) on
>> the PCIe bus?
> 
> It's hard to tell the exact number because it is difficult to measure,
> and the number of entries into the L0s state may vary even in the same
> test scenario.
> 
> However, we have encountered some compatibility issues when connected
> with some PCIe EPs, and disabling the L0s can fix it. I think disabling
> L0s might be the better way, since we usually use L1ss for power-saving
> when the link is idle.
> 

To actually decide, we should know what's actually broken, then.

Is the MediaTek controller broken, or is the device broken?
So, is it a MTK quirk, or a device quirk?

If the problem is actually device-related, then this should be handled as
a device-specific quirk, as not just MediaTek platforms would be affected
by compatibility issues.

If the MediaTek PCIe controller is at fault, instead, I agree about just
disabling L0s at the controller level - but then this shall be mentioned
in the commit message, and should have a Fixes tag as well.

Cheers,
Angelo

> Thanks.
> 
>>
>> Cheers,
>> Angelo
>>
>>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
>>> ---
>>>    drivers/pci/controller/pcie-mediatek-gen3.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
>>> b/drivers/pci/controller/pcie-mediatek-gen3.c
>>> index ed3c0614486c..4bd3b39eebe2 100644
>>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>>> @@ -84,6 +84,9 @@
>>>    #define PCIE_MSI_SET_ENABLE_REG             0x190
>>>    #define PCIE_MSI_SET_ENABLE         GENMASK(PCIE_MSI_SET_NUM - 1,
>>> 0)
>>>
>>> +#define PCIE_LOW_POWER_CTRL_REG              0x194
>>> +#define PCIE_FORCE_DIS_L0S           BIT(8)
>>> +
>>>    #define PCIE_PIPE4_PIE8_REG         0x338
>>>    #define PCIE_K_FINETUNE_MAX         GENMASK(5, 0)
>>>    #define PCIE_K_FINETUNE_ERR         GENMASK(7, 6)
>>> @@ -458,6 +461,14 @@ static int mtk_pcie_startup_port(struct
>>> mtk_gen3_pcie *pcie)
>>>        val &= ~PCIE_INTX_ENABLE;
>>>        writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
>>>
>>> +     /*
>>> +      * Disable L0s support because it does not significantly save
>>> power
>>> +      * but impacts performance.
>>> +      */
>>> +     val = readl_relaxed(pcie->base + PCIE_LOW_POWER_CTRL_REG);
>>> +     val |= PCIE_FORCE_DIS_L0S;
>>> +     writel_relaxed(val, pcie->base + PCIE_LOW_POWER_CTRL_REG);
>>> +
>>>        /* Disable DVFSRC voltage request */
>>>        val = readl_relaxed(pcie->base + PCIE_MISC_CTRL_REG);
>>>        val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
>>
>>


