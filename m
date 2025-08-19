Return-Path: <linux-pci+bounces-34305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F288B2C6F8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1788C1BC2AB4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C6F25229C;
	Tue, 19 Aug 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCTPkpq2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F21DF756;
	Tue, 19 Aug 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613681; cv=none; b=Il91PdPlw49mp9Ta9vMf3OsAzHbmEbEBb9If4Z4GTS58h781vchbPdc0244Cfx8khNITxOuQXalN6uHWUr6W1MI4wK37clva5vAf3mN42wjsymq3qvgVrV4sYSJgV+Bh/UV1enMy+CIVrKMqEYUBPwS8CzGMnJ4J0UMXaQLHkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613681; c=relaxed/simple;
	bh=Mfb/JnDJzyPSwOWfwKNljxJBiGU1tZif6yiH46BsXDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0UcE9FHaPROGqsykNBAp88Dff1Djt6YOYwOdzL9kK7l4dvo0lqRfRuSXWCb5xabnxGcH+oMMRug6aV0QuieLZT+TRNjPm9TlDorvBQdESAi+r1wgq+xPzCftrhkESS+g+rcluUwORzQlir7vtoLEyWtx58MWclOYm/b7kq/jag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCTPkpq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5961C4CEF1;
	Tue, 19 Aug 2025 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613681;
	bh=Mfb/JnDJzyPSwOWfwKNljxJBiGU1tZif6yiH46BsXDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCTPkpq2+5osYcwBFB2fCOuFJgtRFhXn7gK+vWu2oN0FhoIghk4lWZVH2MX2OGHwi
	 U+6eOqzw8ylA1Re2jgD7G6hlL5q5+AQvzWKx2esSF8Fsb7YBmElbNC0KkPM/DBS2zI
	 RmCoxNjS4FQIagF2VXOjMe5NBSxBDlSY8WT/T/vs/WDutb+1PxDEtfqeIkJzKJ6Z2p
	 /FzeqxjxzIiqKIdW6Q+KFIOEB4ERtQ/cwuL/OINj2q+RXIzEz3nC9xrmOAbvXhBz6R
	 cxgGFvZt4aH58ZO8oej+NGEuTLLiIIeYH+FMUGyfzlHyX2Hhxx/NH18YnSxpP/vqK6
	 CPFdNeN2CRI7g==
Date: Tue, 19 Aug 2025 19:57:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jianjun.wang@mediatek.com, ryder.lee@mediatek.com, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/3] PCI: mediatek-gen3: Implement sys clock ready
 time setting
Message-ID: <lwvp5j5okfc6sny2ypiljgq7hyshjyfiyczsglrq4ds75voqoa@mdwrbozqcinv>
References: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
 <20250703120847.121826-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703120847.121826-2-angelogioacchino.delregno@collabora.com>

On Thu, Jul 03, 2025 at 02:08:45PM GMT, AngeloGioacchino Del Regno wrote:
> In preparation to add support for the PCI-Express Gen3 controller
> found in newer MediaTek SoCs, such as the Dimensity 9400 MT6991
> and the MT8196 Chromebook SoC, add the definition for the PCIE
> Resource Control register and a new sys_clk_rdy_time_us variable
> in platform data.
> 
> If sys_clk_rdy_time_us is found (> 0), set the new value in the
> aforementioned register only after configuring the controller to
> RC mode, as this may otherwise be reset.
> 
> Overriding the register defaults for SYS_CLK_RDY_TIME allows to
> work around sys_clk_rdy signal glitching in MT6991 and MT8196.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 5464b4ae5c20..8035f7f812aa 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -101,6 +101,9 @@
>  #define PCIE_MSI_SET_ADDR_HI_BASE	0xc80
>  #define PCIE_MSI_SET_ADDR_HI_OFFSET	0x04
>  
> +#define PCIE_RESOURCE_CTRL_REG		0xd2c
> +#define PCIE_RSRC_SYS_CLK_RDY_TIME_MASK	GENMASK(7, 0)
> +
>  #define PCIE_ICMD_PM_REG		0x198
>  #define PCIE_TURN_OFF_LINK		BIT(4)
>  
> @@ -148,6 +151,7 @@ enum mtk_gen3_pcie_flags {
>   * struct mtk_gen3_pcie_pdata - differentiate between host generations
>   * @power_up: pcie power_up callback
>   * @phy_resets: phy reset lines SoC data.
> + * @sys_clk_rdy_time_us: System clock ready time override (microseconds)
>   * @flags: pcie device flags.
>   */
>  struct mtk_gen3_pcie_pdata {
> @@ -156,6 +160,7 @@ struct mtk_gen3_pcie_pdata {
>  		const char *id[MAX_NUM_PHY_RESETS];
>  		int num_resets;
>  	} phy_resets;
> +	u8 sys_clk_rdy_time_us;
>  	u32 flags;
>  };
>  
> @@ -436,6 +441,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  		writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
>  	}
>  
> +	/* If parameter is present, adjust SYS_CLK_RDY_TIME to avoid glitching */
> +	if (pcie->soc->sys_clk_rdy_time_us) {
> +		val = readl_relaxed(pcie->base + PCIE_RESOURCE_CTRL_REG);
> +		val &= ~PCIE_RSRC_SYS_CLK_RDY_TIME_MASK;
> +		val |= FIELD_PREP(PCIE_RSRC_SYS_CLK_RDY_TIME_MASK,
> +				  pcie->soc->sys_clk_rdy_time_us);

Nit: Mask and update could be simplified with:

		FIELD_MODIFY(PCIE_RSRC_SYS_CLK_RDY_TIME_MASK, &val,
			     pcie->soc->sys_clk_rdy_time_us);

I'll ammend it while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

