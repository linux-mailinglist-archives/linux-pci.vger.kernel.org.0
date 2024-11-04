Return-Path: <linux-pci+bounces-15941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA99BB3DA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956C9B27AD9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566891AF4EE;
	Mon,  4 Nov 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QL/3fVI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE08185B4D;
	Mon,  4 Nov 2024 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720568; cv=none; b=tfxzNgmuxpW7ep19tK0CSX2c12g4Feht9hAwInLZ3X8hVfItLWuiZ+SX84MdZ43T0HyIFqFELR3WHdb1fNVthQAcLpO7gEUcyADaamJH0DnIDf/pZbMHMLX3QvCF8KR6ewIz1+Q11ENlwHVfiCQ2vshsbQRlcbz7gFnbWPepNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720568; c=relaxed/simple;
	bh=IfHGhqvt+TX0g3VwnO2/tu+CWRL4qJkPNdnSO85GnTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiHEFlKbgdYfIHSBYULpde0A5+RR+G1vsMkGS4BOOzYwODoCAJ36nVMh4bn/duWDdtK2GthsVMqKIF47c13wx+rAZd0Z9uKmqew6mKvS3eGwBptGcIE2Pw2sIJukJ4t6pMkMeQvtJ+5tbKgnwp/Zyt1Qg907enx9EtPuGw+zSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QL/3fVI0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730720564;
	bh=IfHGhqvt+TX0g3VwnO2/tu+CWRL4qJkPNdnSO85GnTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QL/3fVI0EQP4vYoK/Qlxs1yjMe2KxtZdB5fWsgzSV9wD7O8SMcMaG5Ua3ehbaTWSr
	 Ixb7OpvGeeJcRGsNifTGpV9CAQX1/3z7WtnmDXrJZOEz4gcOWX2iJC2pAyc0R1FpVr
	 C3MUtTXlghEemTNAQqX3coRfoeIFbmljpR6tmwqFOWpzM+kIaoeStfmZU/HNjjVGeg
	 hBjoNwsfgDzoDeJPJeBItvULqqwgzP99OZ1pv1X5TIyHMvOywXbwGv8ThsmTNZb18K
	 DBAmhByUMt/pb4VgYkZiyG+icw+HtYFsAK8TttzO7nI0CTirA4HksdRMygyLTW63rp
	 Zg5Xx/BgsmIeQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C9E417E3601;
	Mon,  4 Nov 2024 12:42:43 +0100 (CET)
Message-ID: <47154bc7-5e52-4d2c-ba30-730758bf1901@collabora.com>
Date: Mon, 4 Nov 2024 12:42:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
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
 <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
 <744a8362065b0c75178c3e0d402ea4932cb1fc96.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <744a8362065b0c75178c3e0d402ea4932cb1fc96.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/11/24 09:22, Jianjun Wang (王建军) ha scritto:
> Hi Angelo,
> 
> Thanks for your patch.
> 
> On Wed, 2024-09-18 at 10:13 +0200, AngeloGioacchino Del Regno wrote:
>> Add support for respecting the max-link-speed devicetree property,
>> forcing a maximum speed (Gen) for a PCI-Express port.
>>
>> Since the MediaTek PCIe Gen3 controllers also expose the maximum
>> supported link speed in the PCIE_BASE_CFG register, if property
>> max-link-speed is specified in devicetree, validate it against the
>> controller capabilities and proceed setting the limitations only
>> if the wanted Gen is lower than the maximum one that is supported
>> by the controller itself (otherwise it makes no sense!).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/pci/controller/pcie-mediatek-gen3.c | 55
>> ++++++++++++++++++++-
>>   1 file changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
>> b/drivers/pci/controller/pcie-mediatek-gen3.c
>> index 66ce4b5d309b..8d4b045633da 100644
>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>> @@ -28,7 +28,11 @@
>>   
>>   #include "../pci.h"
>>   
>> +#define PCIE_BASE_CFG_REG		0x14
>> +#define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
>> +
>>   #define PCIE_SETTING_REG		0x80
>> +#define PCIE_SETTING_GEN_SUPPORT	GENMASK(14, 12)
>>   #define PCIE_PCI_IDS_1			0x9c
>>   #define PCI_CLASS(class)		(class << 8)
>>   #define PCIE_RC_MODE			BIT(0)
>> @@ -125,6 +129,9 @@
>>   
>>   struct mtk_gen3_pcie;
>>   
>> +#define PCIE_CONF_LINK2_CTL_STS		0x10b0
> 
> Maybe it's better to use: (PCIE_CFG_OFFSET_ADDR + 0xb0).
> 

Makes sense.

>> +#define PCIE_CONF_LINK2_LCR2_LINK_SPEED	GENMASK(3, 0)
>> +
>>   /**
>>    * struct mtk_gen3_pcie_pdata - differentiate between host
>> generations
>>    * @power_up: pcie power_up callback
>> @@ -160,6 +167,7 @@ struct mtk_msi_set {
>>    * @phy: PHY controller block
>>    * @clks: PCIe clocks
>>    * @num_clks: PCIe clocks count for this port
>> + * @max_link_speed: Maximum link speed (PCIe Gen) for this port
>>    * @irq: PCIe controller interrupt number
>>    * @saved_irq_state: IRQ enable state saved at suspend time
>>    * @irq_lock: lock protecting IRQ register access
>> @@ -180,6 +188,7 @@ struct mtk_gen3_pcie {
>>   	struct phy *phy;
>>   	struct clk_bulk_data *clks;
>>   	int num_clks;
>> +	u8 max_link_speed;
>>   
>>   	int irq;
>>   	u32 saved_irq_state;
>> @@ -381,11 +390,27 @@ static int mtk_pcie_startup_port(struct
>> mtk_gen3_pcie *pcie)
>>   	int err;
>>   	u32 val;
>>   
>> -	/* Set as RC mode */
>> +	/* Set as RC mode and set controller PCIe Gen speed
>> restriction, if any */
>>   	val = readl_relaxed(pcie->base + PCIE_SETTING_REG);
>>   	val |= PCIE_RC_MODE;
>> +	if (pcie->max_link_speed) {
>> +		val &= ~PCIE_SETTING_GEN_SUPPORT;
>> +
>> +		/* Can enable link speed support only from Gen2 onwards
>> */
>> +		if (pcie->max_link_speed >= 2)
>> +			val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT,
>> +					  GENMASK(pcie->max_link_speed
>> - 2, 0));
>> +	}
>>   	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>>   
>> +	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
>> +	if (pcie->max_link_speed) {
>> +		val = readl_relaxed(pcie->base +
>> PCIE_CONF_LINK2_CTL_STS);
>> +		val &= ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;
>> +		val |= FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED,
>> pcie->max_link_speed);
>> +		writel_relaxed(val, pcie->base +
>> PCIE_CONF_LINK2_CTL_STS);
>> +	}
>> +
>>   	/* Set class code */
>>   	val = readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
>>   	val &= ~GENMASK(31, 8);
>> @@ -1004,9 +1029,21 @@ static void mtk_pcie_power_down(struct
>> mtk_gen3_pcie *pcie)
>>   	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
>> pcie->phy_resets);
>>   }
>>   
>> +static int mtk_pcie_get_controller_max_link_speed(struct
>> mtk_gen3_pcie *pcie)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	val = readl_relaxed(pcie->base + PCIE_BASE_CFG_REG);
>> +	val = FIELD_GET(PCIE_BASE_CFG_SPEED, val);
>> +	ret = fls(val);
>> +
>> +	return ret > 0 ? ret : -EINVAL;
>> +}
>> +
>>   static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>>   {
>> -	int err;
>> +	int err, max_speed;
>>   
>>   	err = mtk_pcie_parse_port(pcie);
>>   	if (err)
>> @@ -1031,6 +1068,20 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie
>> *pcie)
>>   	if (err)
>>   		return err;
>>   
>> +	err = of_pci_get_max_link_speed(pcie->dev->of_node);
>> +	if (err > 0) {
>> +		/* Get the maximum speed supported by the controller */
>> +		max_speed =
>> mtk_pcie_get_controller_max_link_speed(pcie);
>> +
>> +		/* Set max_link_speed only if the controller supports
>> it */
>> +		if (max_speed >= 0 && max_speed <= err) {
>> +			pcie->max_link_speed = err;
> 
> Do we need to set it to max_speed? Since the hardware only supports
> speeds lower than max_speed.
> 

The controller's default value is already "max speed" (all Gen supported)
so... no, we take action only if DT says to apply a limit.

Cheers,
Angelo

> Thanks.
> 
>> +			dev_dbg(pcie->dev,
>> +				"Max controller link speed Gen%d,
>> override to Gen%u",
>> +				max_speed, pcie->max_link_speed);
>> +		}
>> +	}
>> +
>>   	/* Try link up */
>>   	err = mtk_pcie_startup_port(pcie);
>>   	if (err)



