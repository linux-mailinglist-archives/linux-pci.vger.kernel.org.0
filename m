Return-Path: <linux-pci+bounces-15936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C399BB16B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 11:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54F8B20E38
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CED1AB505;
	Mon,  4 Nov 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SpaJntKC"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6F1AA78E;
	Mon,  4 Nov 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717037; cv=none; b=rPuDgKhN4baGkYLx0F+iin7z1twzoVhF9O2tnADsR4N9GcQX+mLNPegmKcCMEc6RfL/5Vhf8MhDUDElRCj2jw5foijrphoS6bvWvsY5Hop9aD6Pj5zniekvmYe3OY3ZTNrT7qxiggdEqKPiOx+7Z6HhkdBfAlbPBIZGnTN1WKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717037; c=relaxed/simple;
	bh=jSAdqX1Ad8ImwxDLwbjTUxB6CFLUWZ3Ps8wu2h3Cl7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ast4B28luy3T8W+rx0Vw73KC8LsU1yAaQuyZPc+a2lw2HtJENOq0LLidCon0s7NwpxAWt9EOxzv2m8OB2obUx1B4w/wMTNMCvD2nrLu4oCg2AXTS4lXeEDjrHwidaCLiBDqXyf1sNPJpmrVfQ7b93d8uMy1ZTybYKiWzycG+IEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SpaJntKC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730717033;
	bh=jSAdqX1Ad8ImwxDLwbjTUxB6CFLUWZ3Ps8wu2h3Cl7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SpaJntKC9FuJVx0pEuryCi2LC8GpnietV2/bSAJXucHXphnfb2OJZqdM0liwOWWFg
	 cncW2y312i2LFTQCZCLwFAt5gn9Y/SHw64xMYrtdg4IWs+Z3/B01/rf4kNHOY+QmsC
	 lO31XX9KjRGhQI9IoARW95qZ++THuNKj/BMQerbmLZm+wLr5PaPUFBTyB43yKHKOPt
	 Rhpjdg+/zmPvaXZVyk7RAf8JEByaeA2Txrc/xATxLoHKzYpYrO2CIA+P0te/6szCpM
	 dU8XPyqVJGBoc89OcICgJ7k6oFpY/JUk4NV6anlr5CgKEi8LNyvs1yjlPV3HTOOpr/
	 xq2ybN6LyVQsA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DEB3917E35D3;
	Mon,  4 Nov 2024 11:43:52 +0100 (CET)
Message-ID: <9351c903-8141-4721-a352-776215afbfa1@collabora.com>
Date: Mon, 4 Nov 2024 11:43:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
To: =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>, "fshao@chromium.org" <fshao@chromium.org>
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com>
 <20240918081307.51264-3-angelogioacchino.delregno@collabora.com>
 <9e56fbe0b1a388b4e0da20cca53e157f51288916.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <9e56fbe0b1a388b4e0da20cca53e157f51288916.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/11/24 09:56, Jianjun Wang (王建军) ha scritto:
> Hi Angelo,
> 
> Thanks for your patch.
> 
> On Wed, 2024-09-18 at 10:13 +0200, AngeloGioacchino Del Regno wrote:
>> Add support for restricting the port's link width by specifying
>> the num-lanes devicetree property in the PCIe node.
>>
>> The setting is done in the GEN_SETTINGS register (in the driver
>> named as PCIE_SETTING_REG), where each set bit in [11:8] activates
>> a set of lanes (from bits 11 to 8 respectively, x16/x8/x4/x2).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/pci/controller/pcie-mediatek-gen3.c | 20
>> ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
>> b/drivers/pci/controller/pcie-mediatek-gen3.c
>> index 8d4b045633da..8dd2e5135b01 100644
>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>> @@ -32,6 +32,7 @@
>>   #define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
>>   
>>   #define PCIE_SETTING_REG		0x80
>> +#define PCIE_SETTING_LINK_WIDTH		GENMASK(11, 8)
>>   #define PCIE_SETTING_GEN_SUPPORT	GENMASK(14, 12)
>>   #define PCIE_PCI_IDS_1			0x9c
>>   #define PCI_CLASS(class)		(class << 8)
>> @@ -168,6 +169,7 @@ struct mtk_msi_set {
>>    * @clks: PCIe clocks
>>    * @num_clks: PCIe clocks count for this port
>>    * @max_link_speed: Maximum link speed (PCIe Gen) for this port
>> + * @num_lanes: Number of PCIe lanes for this port
>>    * @irq: PCIe controller interrupt number
>>    * @saved_irq_state: IRQ enable state saved at suspend time
>>    * @irq_lock: lock protecting IRQ register access
>> @@ -189,6 +191,7 @@ struct mtk_gen3_pcie {
>>   	struct clk_bulk_data *clks;
>>   	int num_clks;
>>   	u8 max_link_speed;
>> +	u8 num_lanes;
>>   
>>   	int irq;
>>   	u32 saved_irq_state;
>> @@ -401,6 +404,14 @@ static int mtk_pcie_startup_port(struct
>> mtk_gen3_pcie *pcie)
>>   			val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT,
>>   					  GENMASK(pcie->max_link_speed
>> - 2, 0));
>>   	}
>> +	if (pcie->num_lanes) {
>> +		val &= ~PCIE_SETTING_LINK_WIDTH;
>> +
>> +		/* Zero means one lane, each bit activates x2/x4/x8/x16
>> */
>> +		if (pcie->num_lanes > 1)
>> +			val |= FIELD_PREP(PCIE_SETTING_LINK_WIDTH,
>> +					  GENMASK(pcie->num_lanes >> 1,
>> 0));
> 
> It should be GENMASK(fls(pcie->num_lanes) - 2, 0).
> 

You're right in that there's a mistake in that one, and I see it now,
but I don't get why this should be "fls(...) - 2".

The datasheet says that "LinkWidths" is

Bit 8 = x2 supported
Bit 9 = x4 supported
Bit 10 = x8 supported
Bit 11 = x16 supported

pcie->num_lanes can be set to either 2, 4, 8 or 16.

2>>2 = 0   -> fls(0) == 0 (after field_prep/genmask: bit 8)
4>>2 = 1   -> fls(1) == 1 (after field_prep/genmask: bit 9 to 8)
8>>2 = 2   -> fls(2) == 2 (after field_prep/genmask: bit 10 to 8)
16>>2 = 4  -> fls(4) == 3 (after field_prep/genmask: bit 11 to 8)

So, this should be
	GENMASK(fls(pcie->num_lanes >> 2), 0)

Right? :-)

In which case, should I send a new version, or can you fix that while
applying? I'd really appreciate the latter due to lack of time.

Cheers,
Angelo

> Thanks.
> 
>> +	};
>>   	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>>   
>>   	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
>> @@ -838,6 +849,7 @@ static int mtk_pcie_parse_port(struct
>> mtk_gen3_pcie *pcie)
>>   	struct device *dev = pcie->dev;
>>   	struct platform_device *pdev = to_platform_device(dev);
>>   	struct resource *regs;
>> +	u32 num_lanes;
>>   
>>   	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "pcie-mac");
>>   	if (!regs)
>> @@ -883,6 +895,14 @@ static int mtk_pcie_parse_port(struct
>> mtk_gen3_pcie *pcie)
>>   		return pcie->num_clks;
>>   	}
>>   
>> +	ret = of_property_read_u32(dev->of_node, "num-lanes",
>> &num_lanes);
>> +	if (ret == 0) {
>> +		if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1
>> && num_lanes % 2))
>> +			dev_warn(dev, "Invalid num-lanes, using
>> controller defaults\n");
>> +		else
>> +			pcie->num_lanes = num_lanes;
>> +	}
>> +
>>   	return 0;
>>   }
>>   




