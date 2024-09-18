Return-Path: <linux-pci+bounces-13274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93C97B8F8
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 10:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708501F21606
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397715853D;
	Wed, 18 Sep 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ijDTiHnN"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92514A0A4;
	Wed, 18 Sep 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646893; cv=none; b=oxk89dvd/xHg9MDHgCH70KhD4JGtAF67CH4JwO1PKTCTQQ0wdE30SN+qmYkdzIyoPLflTfB2EGrlBLlTYQtTBHjXGzsbvN14AK/c3DLAFVAYIAVqHgPZN4va3nyrtn6xd+wio4TtdvRFjPq3DxyCq3FXMmDs379HFDJhn3SU+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646893; c=relaxed/simple;
	bh=ng5Lj/WapRf5wiGtbGUreHOyO8PcjhuIkJMfcNbzMvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rz/DkPjFllFJ+Y/A0ZWY6vbOQV0LjYw9CDvscM8ayxpKRwW0FZHZMEQ1ohVxsQ5a2J7EerhrJ0A50J8VY1MCyBESuhp+vqvi+6+qSuI1H13/z5DEO5nX130dHdIwuUmEIybXeAMJe97ME/+Px23cfVkiuJ9T7O6kW7IRZ4TbOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ijDTiHnN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726646883;
	bh=ng5Lj/WapRf5wiGtbGUreHOyO8PcjhuIkJMfcNbzMvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ijDTiHnNDsmYkHvbMLSVl1kMwUPuGyKeQ1drdgROrfUmC2+VBfE4cG2wtzIR+KFzQ
	 srPGeYamWqKpOTSso2UttdPrSy9tZrD9JVYH1Er3S8CSyTtQbSh0SbxAC2GIhOUkoy
	 Zf96lcbiKNezaEcY68j/8eO3CxV6pvFJ4diyPx9Ur15UUYg6IicYDCha5hNi3rmXHj
	 UvGMX/OLgorkKeYwRCuSN/sd1EcDpJOJiNbgro5QLcg5Gpoi63TzGckgH9Xz+1gj4W
	 N50wM2h0VwlBFZgA+MJ5gSutb1lPCxtWGNJ2/noCsuhQe/XlKo1pnxDzmS/dvnKayJ
	 WzvEycHiYeMOQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B846C17E0FD9;
	Wed, 18 Sep 2024 10:08:02 +0200 (CEST)
Message-ID: <8186d78e-2aa8-436e-be76-412860a3105a@collabora.com>
Date: Wed, 18 Sep 2024 10:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
To: Fei Shao <fshao@chromium.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
 jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240917091132.286582-1-angelogioacchino.delregno@collabora.com>
 <20240917091132.286582-2-angelogioacchino.delregno@collabora.com>
 <CAC=S1nhp_3EfG7g7GyLHQGPk_2mrfzj3Kqgi4u_gsA7-Wq8Zgg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAC=S1nhp_3EfG7g7GyLHQGPk_2mrfzj3Kqgi4u_gsA7-Wq8Zgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/09/24 18:15, Fei Shao ha scritto:
> On Tue, Sep 17, 2024 at 5:13 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
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
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/pci/controller/pcie-mediatek-gen3.c | 55 ++++++++++++++++++++-
>>   1 file changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
>> index 66ce4b5d309b..e1d1fb39d5c6 100644
>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>> @@ -28,7 +28,11 @@
>>
>>   #include "../pci.h"
>>
>> +#define PCIE_BASE_CFG_REG              0x14
>> +#define PCIE_BASE_CFG_SPEED_MASK       GENMASK(15, 8)
>> +
>>   #define PCIE_SETTING_REG               0x80
>> +#define PCIE_SETTING_GEN_SUPPORT_MASK  GENMASK(14, 12)
>>   #define PCIE_PCI_IDS_1                 0x9c
>>   #define PCI_CLASS(class)               (class << 8)
>>   #define PCIE_RC_MODE                   BIT(0)
>> @@ -125,6 +129,9 @@
>>
>>   struct mtk_gen3_pcie;
>>
>> +#define PCIE_CONF_LINK2_CTL_STS                0x10b0
>> +#define PCIE_CONF_LINK2_LCR2_LINK_SPEED        GENMASK(3, 0)
>> +
>>   /**
>>    * struct mtk_gen3_pcie_pdata - differentiate between host generations
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
>>          struct phy *phy;
>>          struct clk_bulk_data *clks;
>>          int num_clks;
>> +       u8 max_link_speed;
>>
>>          int irq;
>>          u32 saved_irq_state;
>> @@ -381,11 +390,27 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>>          int err;
>>          u32 val;
>>
>> -       /* Set as RC mode */
>> +       /* Set as RC mode and set controller PCIe Gen speed restriction, if any*/
> 
> NIt: one space before ending the comment.
> 

Yep. :-)

>>          val = readl_relaxed(pcie->base + PCIE_SETTING_REG);
>>          val |= PCIE_RC_MODE;
>> +       if (pcie->max_link_speed) {
>> +               val &= ~PCIE_SETTING_GEN_SUPPORT_MASK;
>> +
>> +               /* Can enable link speed support only from Gen2 onwards */
>> +               if (pcie->max_link_speed >= 2)
>> +                       val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT_MASK,
>> +                                         GENMASK(pcie->max_link_speed - 2, 0));
>> +       }
>>          writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>>
>> +       /* Set Link Control 2 (LNKCTL2) speed restriction, if any */
>> +       if (pcie->max_link_speed) {
>> +               val = readl_relaxed(pcie->base + PCIE_CONF_LINK2_CTL_STS);
>> +               val &= PCIE_CONF_LINK2_LCR2_LINK_SPEED;
> 
> I guess it needs a bitwise NOT operator over the mask.
>      val &= ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;
> 

I have no idea how the NOT disappeared from this line :o
Nice catch.

> Apart from that, I think appending _MASK to the name makes its usage
> clearer and consistent with other masks.
> (although the name gets even more lengthy...)

Actually, the only other ones that say _MASK are the ones that I am introducing
in this commit, other than PCIE_LTSSM_STATE_MASK... all of the others do *not*
have the _MASK suffix.

At this point, for consistency, I should rather drop the _MASK suffix from the
PCIE_BASE_CFG_SPEED and PCIE_SETTING_GEN_SUPPORT definitions that I introduce
here, so I'll do exactly that for v3.

> 
>> +               val |= FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED, pcie->max_link_speed);
>> +               writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
>> +       }
>> +
>>          /* Set class code */
>>          val = readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
>>          val &= ~GENMASK(31, 8);
>> @@ -1004,9 +1029,21 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
>>          reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
>>   }
>>
>> +static int mtk_pcie_get_controller_max_link_speed(struct mtk_gen3_pcie *pcie)
>> +{
>> +       u32 val;
>> +       int ret;
>> +
>> +       val = readl_relaxed(pcie->base + PCIE_BASE_CFG_REG);
>> +       val = FIELD_GET(PCIE_BASE_CFG_SPEED_MASK, val);
>> +       ret = fls(val);
>> +
>> +       return ret > 0 ? ret : -EINVAL;
>> +}
>> +
>>   static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>>   {
>> -       int err;
>> +       int max_speed, err;

Self-review: reorder this, e comes before m. Oops!

>>
>>          err = mtk_pcie_parse_port(pcie);
>>          if (err)
>> @@ -1031,6 +1068,20 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>>          if (err)
>>                  return err;
>>
>> +       err = of_pci_get_max_link_speed(pcie->dev->of_node);
>> +       if (err > 0) {
>> +               /* Get the maximum speed supported by the controller */
>> +               max_speed = mtk_pcie_get_controller_max_link_speed(pcie);
>> +
>> +               /* Set max_link_speed only if the controller supports it */
>> +               if (max_speed >= 0 && max_speed <= err) {
>> +                       pcie->max_link_speed = err;
>> +                       dev_dbg(pcie->dev,
>> +                               "Max controller link speed Gen%u, override to Gen%u",
>> +                               max_speed, pcie->max_link_speed);
> 
> Convert max_speed to an unsigned type to avoid potential typecheck warnings?
> 

I'll just change that to "[...] Gen%d, override to Gen%u", looks simply
cleaner, in the end...

Thanks!
Angelo

> Regards,
> Fei
> 
> 
>> +               }
>> +       }
>> +
>>          /* Try link up */
>>          err = mtk_pcie_startup_port(pcie);
>>          if (err)
>> --
>> 2.46.0
>>
>>



