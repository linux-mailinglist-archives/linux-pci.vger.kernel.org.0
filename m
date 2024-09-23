Return-Path: <linux-pci+bounces-13358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38897E8EE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD754B209E0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382EC194A4C;
	Mon, 23 Sep 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SbsPVhNG"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB51946C7
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084506; cv=none; b=iu8aYKHcKgs0FqJHfvnwLfr4yl3fjHSMM7ImoPmlzFeCYIK2NPgH2jWWMWpVPq3TItf3eEuvQy8rTEAjyzyS3IQsayLxD0pXnDuBs+GR5tl2YW1bfPI4lAHKw+Cpel/k0/rzToOwzPvbpHtiRyRs6lviayD34FYw/73p13V9ijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084506; c=relaxed/simple;
	bh=GRnjXSpl7frDI6cTVufd4Tb5HHjLXwrTKQEtkTBHYxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhsVfdhpT5FS95EbHvDwy2nlYQ9Q4Y4KwhYNavzd2/CC9y5LVYm2syyE67AVuUzvYTOIT1j4TvgA3mdCUJoCPFrQ/sOXoIB8CdaFMJ3vZF/2/z5QhEnA6IymcV2NKCSYOum3P/nTh1hH2RrOi82DX0jMtIjOy4bFGCSy6fvCUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SbsPVhNG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727084502;
	bh=GRnjXSpl7frDI6cTVufd4Tb5HHjLXwrTKQEtkTBHYxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SbsPVhNG82UW0fgWeME1nVKz+9KnUBEZGROHGCQrTfFS54sPGJdiut28l3814a0zi
	 0ELjx/zvnArs3teaxH4zZzlVV11968VV4B5GIJi3wOaWBb6Hjc3y1kBCfELbFsiMvi
	 FX8ZNZrareec+lPJ6E4X5gz7pdZRp+TAiHXlGXxM5IxL8K5SAu/m12aStqXRkEWy09
	 B0XV7VK3/xwVF5kTioR1kx7ebmIdolLKTLtobssQypHNQZJgaYJGj/XWDgzYjp4C1H
	 dx5uaX4k8UvWgW/lTvKNT7EhULas+6uiGcPT4NOrao5sXK9+z2OpJFp+m4dgO1a5CT
	 SJLmSZ7rYUgeQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D2B0A17E10AA;
	Mon, 23 Sep 2024 11:41:41 +0200 (CEST)
Message-ID: <d8941149-9125-4fe2-a1c0-ab29223a0c87@collabora.com>
Date: Mon, 23 Sep 2024 11:41:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: Avoid PCIe resetting for Airoha
 EN7581 SoC
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 upstream@airoha.com, Hui Ma <hui.ma@airoha.com>
References: <20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/09/24 10:26, Lorenzo Bianconi ha scritto:
> The PCIe controller available on the EN7581 SoC does not support reset
> via the following lines:
> - PCIE_MAC_RSTB
> - PCIE_PHY_RSTB
> - PCIE_BRG_RSTB
> - PCIE_PE_RSTB
> 
> Introduce the reset callback in order to avoid resetting the PCIe port
> for Airoha EN7581 SoC.
> 

EN7581 doesn't support pulling up/down PERST#?!
That looks definitely odd, as that signal is part of the PCI-Express CEM spec.

Besides, there's another PERST# assertion at mtk_pcie_suspend_noirq()...

Cheers,
Angelo

> Tested-by: Hui Ma <hui.ma@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 44 ++++++++++++++++++-----------
>   1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 5c19abac74e8..9cea67e92d98 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -128,10 +128,12 @@ struct mtk_gen3_pcie;
>   /**
>    * struct mtk_gen3_pcie_pdata - differentiate between host generations
>    * @power_up: pcie power_up callback
> + * @reset: pcie reset callback
>    * @phy_resets: phy reset lines SoC data.
>    */
>   struct mtk_gen3_pcie_pdata {
>   	int (*power_up)(struct mtk_gen3_pcie *pcie);
> +	void (*reset)(struct mtk_gen3_pcie *pcie);
>   	struct {
>   		const char *id[MAX_NUM_PHY_RESETS];
>   		int num_resets;
> @@ -373,6 +375,28 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
>   	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
>   }
>   
> +static void mtk_pcie_reset(struct mtk_gen3_pcie *pcie)
> +{
> +	u32 val;
> +
> +	/* Assert all reset signals */
> +	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> +	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> +	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +
> +	/*
> +	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> +	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> +	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> +	 * for the power and clock to become stable.
> +	 */
> +	msleep(100);
> +
> +	/* De-assert reset signals */
> +	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> +	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +}
> +
>   static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>   {
>   	struct resource_entry *entry;
> @@ -402,22 +426,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>   	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
>   	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
>   
> -	/* Assert all reset signals */
> -	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> -	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> -
> -	/*
> -	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> -	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> -	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> -	 * for the power and clock to become stable.
> -	 */
> -	msleep(100);
> -
> -	/* De-assert reset signals */
> -	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +	/* Reset the PCIe port if requested by the hw */
> +	if (pcie->soc->reset)
> +		pcie->soc->reset(pcie);
>   
>   	/* Check if the link is up or not */
>   	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
> @@ -1207,6 +1218,7 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
>   
>   static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
>   	.power_up = mtk_pcie_power_up,
> +	.reset = mtk_pcie_reset,
>   	.phy_resets = {
>   		.id[0] = "phy",
>   		.num_resets = 1,
> 
> ---
> base-commit: f2024903cb387971abdbc6398a430e735a9b394c
> change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> 
> Best regards,


