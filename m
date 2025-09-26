Return-Path: <linux-pci+bounces-37132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B2BA5229
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17467405F3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE33281366;
	Fri, 26 Sep 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmvtP3EQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981615667D;
	Fri, 26 Sep 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920031; cv=none; b=qOzZF/yMVV4wJJ9ZDIHpAOoHxqYLfHLaEKpwwijAxCynlfOy/gw4P6zFby1UxGi3sR4xCxLjrsejk9jTNgx3iEwapxrbhNbepraeNMshDcRYKz2UXbnqWxVkpS8uVtCN3DNEltw65hftkUiFlC+eojCcrnsm1hQJSCBRogd5uI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920031; c=relaxed/simple;
	bh=+2j9/0CdRMeV9jn7IdyUu73NHHsTC5nbTEOVlrmZkHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=irieNwqOaIbNNPcVat8yUUl8wgCcZyPynCanh1gqDlp9/3Mro9ELj3WyUZR0aafF7JWGxWWreWRtMUK+/hHgd2pBil1kK9JMm6X+KMAlXNISxO635XnvWhPdq11/KX1kWpQAEKgi4EAnMcY4p7C2d2Z0jODnc/PKbtdyOEa0yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmvtP3EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22861C4CEF4;
	Fri, 26 Sep 2025 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758920030;
	bh=+2j9/0CdRMeV9jn7IdyUu73NHHsTC5nbTEOVlrmZkHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MmvtP3EQERr0QqgKsC48/0imRxbynvn6Lx+1COGwNGlSb+ElEt1nsaqYPEODbYYlK
	 hLnKV9dVAZn8aUynnmXVEn98uJwFTDI3G03xHiu87tOqop1k56HYxOB6FwBqcWcspc
	 cy/ELMTE3aQOAUty5ZONn4BC3ECwkkLySQEvA0sb04SrQPMarGDHrGlm0zXHIYaE/M
	 /spoBSuskav8QFCqoxrTmClj30NXnDuhIzQF50I1cb2TjgNuvkvwGgwugyqONcfJ3E
	 bn8PPYEtIDdGTvQPdNTminngrfQ+uyYIFfWV+5DanTiuhPe2YDhgAbdxYhe8UJJfB3
	 RGqdkA3uIcujw==
Date: Fri, 26 Sep 2025 15:53:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v3 4/4] PCI: mediatek: add support for Airoha AN7583 SoC
Message-ID: <20250926205348.GA2266187@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925162332.9794-5-ansuelsmth@gmail.com>

In subject:

  PCI: mediatek: Add support for Airoha AN7583 SoC

On Thu, Sep 25, 2025 at 06:23:18PM +0200, Christian Marangi wrote:
> Add support for the second PCIe line present on Airoha AN7583 SoC.

What is a "second PCIe line"?  Does this mean a second Root Complex?
Or a second Root Port in a Root Complex?

I guess maybe it just means this adds support for another variant of
the Mediatek IP that is used in Airoha AN7583?

> This is based on the Mediatek Gen1/2 PCIe driver and similar to Gen3
> also require workaround for the reset signals.
> 
> Introduce a new bool to skip having to reset signals and also introduce
> some additional logic to configure the PBUS registers required for
> Airoha SoC.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 85 +++++++++++++++++++-------
>  1 file changed, 63 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 24cc30a2ab6c..640d1f1a6478 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -147,6 +147,7 @@ struct mtk_pcie_port;
>   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
>   * @need_fix_device_id: whether this host's device ID needed to be fixed or not
>   * @no_msi: Bridge has no MSI support, and relies on an external block
> + * @skip_pcie_rstb: Skip calling RSTB bits on PCIe probe
>   * @device_id: device ID which this host need to be fixed
>   * @ops: pointer to configuration access functions
>   * @startup: pointer to controller setting functions
> @@ -156,6 +157,7 @@ struct mtk_pcie_soc {
>  	bool need_fix_class_id;
>  	bool need_fix_device_id;
>  	bool no_msi;
> +	bool skip_pcie_rstb;
>  	unsigned int device_id;
>  	struct pci_ops *ops;
>  	int (*startup)(struct mtk_pcie_port *port);
> @@ -679,28 +681,30 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
>  	}
>  
> -	/* Assert all reset signals */
> -	writel(0, port->base + PCIE_RST_CTRL);
> -
> -	/*
> -	 * Enable PCIe link down reset, if link status changed from link up to
> -	 * link down, this will reset MAC control registers and configuration
> -	 * space.
> -	 */
> -	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> -
> -	/*
> -	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
> -	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> -	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
> -	 */
> -	msleep(100);
> -
> -	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> -	val = readl(port->base + PCIE_RST_CTRL);
> -	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> -	       PCIE_MAC_SRSTB | PCIE_CRSTB;
> -	writel(val, port->base + PCIE_RST_CTRL);
> +	if (!soc->skip_pcie_rstb) {
> +		/* Assert all reset signals */
> +		writel(0, port->base + PCIE_RST_CTRL);
> +
> +		/*
> +		 * Enable PCIe link down reset, if link status changed from link up to
> +		 * link down, this will reset MAC control registers and configuration
> +		 * space.
> +		 */
> +		writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> +
> +		/*
> +		 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
> +		 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> +		 * be delayed 100ms (TPVPERL) for the power and clock to become stable.

Wrap these comments to fit in 80 columns like the rest of the file.

You only moved the comment, without updating it, but since you're
touching it anyway, it's a chance to add the CEM spec revision, e.g.,
"PCIe CEM r5.0, sec 2.2"

> +		 */
> +		msleep(100);

Use PCIE_T_PVPERL_MS if that's what this is.

> +
> +		/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> +		val = readl(port->base + PCIE_RST_CTRL);
> +		val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> +		       PCIE_MAC_SRSTB | PCIE_CRSTB;
> +		writel(val, port->base + PCIE_RST_CTRL);
> +	}
>  
>  	/* Set up vendor ID and class code */
>  	if (soc->need_fix_class_id) {
> @@ -1105,6 +1109,33 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		goto put_resources;
>  
> +	if (device_is_compatible(dev, "airoha,an7583-pcie")) {
> +		struct resource_entry *entry;
> +		struct regmap *pbus_regmap;
> +		resource_size_t addr;
> +		u32 args[2], size;
> +
> +		/*
> +		 * Configure PBus base address and base address mask to allow the
> +		 * hw to detect if a given address is accessible on PCIe controller.

Wrap to fit in 80 columns.

> +		 */
> +		pbus_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
> +								   "mediatek,pbus-csr",
> +								   ARRAY_SIZE(args),
> +								   args);
> +		if (IS_ERR(pbus_regmap))
> +			return PTR_ERR(pbus_regmap);
> +
> +		entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
> +		if (!entry)
> +			return -ENODEV;
> +
> +		addr = entry->res->start - entry->offset;
> +		regmap_write(pbus_regmap, args[0], lower_32_bits(addr));
> +		size = lower_32_bits(resource_size(entry->res));
> +		regmap_write(pbus_regmap, args[1], GENMASK(31, __fls(size)));
> +	}
> +
>  	return 0;
>  
>  put_resources:
> @@ -1205,6 +1236,15 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
>  	.setup_irq = mtk_pcie_setup_irq,
>  };
>  
> +static const struct mtk_pcie_soc mtk_pcie_soc_an7583 = {
> +	.skip_pcie_rstb = true,
> +	.need_fix_class_id = true,
> +	.need_fix_device_id = false,

No need to specify "false" items; things are false by default since
members not explicitly initialized are set to zero.

> +	.ops = &mtk_pcie_ops_v2,
> +	.startup = mtk_pcie_startup_port_v2,
> +	.setup_irq = mtk_pcie_setup_irq,
> +};
> +
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
>  	.need_fix_class_id = true,
>  	.need_fix_device_id = true,
> @@ -1215,6 +1255,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
>  };
>  
>  static const struct of_device_id mtk_pcie_ids[] = {
> +	{ .compatible = "airoha,an7583-pcie", .data = &mtk_pcie_soc_an7583 },
>  	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
>  	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
>  	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
> -- 
> 2.51.0
> 

