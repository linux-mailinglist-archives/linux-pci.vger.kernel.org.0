Return-Path: <linux-pci+bounces-9166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA89143F0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 09:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F871F228BF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A944481C4;
	Mon, 24 Jun 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sj5d3Msl"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A2182B3;
	Mon, 24 Jun 2024 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215715; cv=none; b=IViKxPuKMnuuDv71KsXlDeTo0lzYjTDT1anaOJRHkz6WkDxw37AUAff7ZtyTnKUV6WAN+RgpySSnGQ2nCyXDFfhyMozHDyWTP3NwvxCsd6Mk0TAWZD+Zb1OsiYhCjI2gLG+QwJ/lYOeOn3O8nGWiN8u3pfADjIETT/1xBfEpszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215715; c=relaxed/simple;
	bh=UZ48f2dq1hVCb6YM9WT+jFPJEK1haWtngJCNK6x2nII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQ2qpCWrG3FlsQrlFEWcC6yIJwE1ed1nP+5kbM8StQ42N/YOLB/69jSMlWOK8SUQBVmza5PHwCQQ8JVGi8SaRkVZvUzds4cr7JfZu2Kg/O/sfhgA8skxvgpUAYYDZ3YRiuenfw41HXVRLq3KWJs9XX7idu1zTzSX6pGeqiDfYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sj5d3Msl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719215711;
	bh=UZ48f2dq1hVCb6YM9WT+jFPJEK1haWtngJCNK6x2nII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sj5d3Msl2DDt6hajTlr44EcKJZXS6diHURvjbMV5U/Z+jzeuplGrjayw0EOGyFVb0
	 Loou148vBngw7vhHsrq7MkBSiEvNi2W7bi1ZB2P8M3482Qao5VSk3dr/4t4nvc65YT
	 jayR49RaQIhTs8DdB8zTRaPzkDO422TvzLeDzRU2nc+p3CS3gaJOTK+RB/kygf0s8l
	 vdw832NJUCL7Slq046I9C2XZh6Yj/e0XMnOG4PjJBwoqMNPSeuCN6AtkmOECLWTozm
	 42Axeb0l7DQmGiPM4SEBDcK1xpQPGhIiQBraQfv0rmhSzLcuOg3E7ojJMr7pcd+Txj
	 o6jST4FpIOyQg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3E4F8378216A;
	Mon, 24 Jun 2024 07:55:10 +0000 (UTC)
Message-ID: <ec72c451-4d80-43a9-b469-726a6da29852@collabora.com>
Date: Mon, 24 Jun 2024 09:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, nbd@nbd.name,
 dd@embedd.com, upstream@airoha.com
References: <cover.1718980864.git.lorenzo@kernel.org>
 <f044eb44654522801d4a93e94918a32c72c4c49f.1718980864.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <f044eb44654522801d4a93e94918a32c72c4c49f.1718980864.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/06/24 16:48, Lorenzo Bianconi ha scritto:
> Introduce support for Airoha EN7581 pcie controller to mediatek-gen3
> pcie controller driver.
> 
> Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/pci/controller/Kconfig              |  2 +-
>   drivers/pci/controller/pcie-mediatek-gen3.c | 84 ++++++++++++++++++++-
>   2 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index e534c02ee34f..3bd6c9430010 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -196,7 +196,7 @@ config PCIE_MEDIATEK
>   
>   config PCIE_MEDIATEK_GEN3
>   	tristate "MediaTek Gen3 PCIe controller"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
>   	depends on PCI_MSI
>   	help
>   	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 9842617795a9..2dacfed665c6 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>   #include <linux/delay.h>
>   #include <linux/iopoll.h>
>   #include <linux/irq.h>
> @@ -21,6 +22,8 @@
>   #include <linux/pm_domain.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/reset.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_device.h>
>   
>   #include "../pci.h"
>   
> @@ -29,6 +32,7 @@
>   #define PCI_CLASS(class)		(class << 8)
>   #define PCIE_RC_MODE			BIT(0)
>   
> +#define PCIE_EQ_PRESET_01_REF		0x100
>   #define PCIE_CFGNUM_REG			0x140
>   #define PCIE_CFG_DEVFN(devfn)		((devfn) & GENMASK(7, 0))
>   #define PCIE_CFG_BUS(bus)		(((bus) << 8) & GENMASK(15, 8))
> @@ -68,6 +72,7 @@
>   #define PCIE_MSI_SET_ENABLE_REG		0x190
>   #define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1, 0)
>   
> +#define PCIE_PIPE4_PIE8_REG		0x338
>   #define PCIE_MSI_SET_BASE_REG		0xc00
>   #define PCIE_MSI_SET_OFFSET		0x10
>   #define PCIE_MSI_SET_STATUS_OFFSET	0x04
> @@ -100,7 +105,7 @@
>   #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
>   #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
>   
> -#define MAX_NUM_PHY_RSTS		1
> +#define MAX_NUM_PHY_RSTS		3
>   
>   struct mtk_gen3_pcie;
>   
> @@ -848,6 +853,72 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
>   	return 0;
>   }
>   
> +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	int err;
> +
> +	writel_relaxed(0x23020133, pcie->base + 0x10044);
> +	writel_relaxed(0x50500032, pcie->base + 0x15030);
> +	writel_relaxed(0x50500032, pcie->base + 0x15130);

Can anyone from MediaTek/Airoha help to identify those registers and the layout so
that we can avoid using magic numbers around?

Please.

Regards,
Angelo

> +
> +	err = phy_init(pcie->phy);
> +	if (err) {
> +		dev_err(dev, "failed to initialize PHY\n");
> +		return err;
> +	}
> +	mdelay(30);
> +
> +	err = phy_power_on(pcie->phy);
> +	if (err) {
> +		dev_err(dev, "failed to power on PHY\n");
> +		goto err_phy_on;
> +	}
> +
> +	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
> +					  pcie->phy_resets);
> +	if (err) {
> +		dev_err(dev, "failed to deassert PHYs\n");
> +		goto err_phy_deassert;
> +	}
> +	usleep_range(5000, 10000);
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
> +	if (err) {
> +		dev_err(dev, "failed to prepare clock\n");
> +		goto err_clk_prepare;
> +	}
> +
> +	writel_relaxed(0x41474147, pcie->base + PCIE_EQ_PRESET_01_REF);
> +	writel_relaxed(0x1018020f, pcie->base + PCIE_PIPE4_PIE8_REG);
> +	mdelay(10);
> +
> +	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
> +	if (err) {
> +		dev_err(dev, "failed to prepare clock\n");
> +		goto err_clk_enable;
> +	}
> +
> +	return 0;
> +
> +err_clk_enable:
> +	clk_bulk_unprepare(pcie->num_clks, pcie->clks);
> +err_clk_prepare:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
> +				  pcie->phy_resets);
> +err_phy_deassert:
> +	phy_power_off(pcie->phy);
> +err_phy_on:
> +	phy_exit(pcie->phy);
> +
> +	return err;
> +}
> +
>   static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>   {
>   	struct device *dev = pcie->dev;
> @@ -1117,8 +1188,19 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt8192 = {
>   	},
>   };
>   
> +static const struct mtk_pcie_soc mtk_pcie_soc_en7581 = {
> +	.power_up = mtk_pcie_en7581_power_up,
> +	.phy_resets = {
> +		.id[0] = "phy-lane0",
> +		.id[1] = "phy-lane1",
> +		.id[2] = "phy-lane2",
> +		.num_rsts = 3,
> +	},
> +};
> +
>   static const struct of_device_id mtk_pcie_of_match[] = {
>   	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
> +	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);




