Return-Path: <linux-pci+bounces-37143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDBBA53AC
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0434C7577
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A65F29D275;
	Fri, 26 Sep 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpYdeDfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A12A1CA;
	Fri, 26 Sep 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922327; cv=none; b=bGYhdPqCTAanRhY7h1MsJLA4Qr3JM6NZjRwXQyTBUKM5Vgduz2Qjli4oPHhkT41a0V95vj6vHTL5cERiLI1EfqTP1rGO0cTxeTzcH8QHsvrvvTD9/nWpDMFsnzFZB1Qgw54PQvRFef99qfwfve93NJehjbXrIGGMGohjL9aOfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922327; c=relaxed/simple;
	bh=s11rU3UFLaS0Sp8EzrbQgKe7uppn0ywvUykAZ5Jlu+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpEK/9fsMlehM3U/QUfRpWbtdDTlysYSw2ql1v5HmOVDo5Sl8rSBbrfnG7LDNph6WqoF24Wo0CityyIL8NdHBBNFb8mqk/Y57QvwB6AtjFFuWIDXnukbjNs+7PH2p8nnlreKxmfI39w+ghGCOktYRM8iZBo/qE/foWe5kkeKEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpYdeDfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA28C4CEF7;
	Fri, 26 Sep 2025 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758922326;
	bh=s11rU3UFLaS0Sp8EzrbQgKe7uppn0ywvUykAZ5Jlu+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpYdeDfnhMqz1YxGrCTA0V5KRELoLAUV9N8OpcWmOafoCcc2MoUgARxKF4e+LgwYB
	 bwf8l5nL/62riCbPcp1/3Jg2qR0xVozoaBP7lgUPISAvfDR2qplS0Bsyzth/Rg+sU1
	 cXfZM3eBYe6rJ5kKYSc7APTXRU+Dnhyj1WAoTvgvEjoG7nKRs4bhVExMyhO0J1s7VB
	 K6PXj5BZJoLWsY3r/pNNkYyxMUy/javEKi1h0IA/Q6qjYI9OZhzHgefObwy0TB/yyc
	 h7p+VMuNQgR3oxqKeQ3/Bwc6kgGa2+QxjRmcLxShiJxxmrZaC0A5dpNVc/usPR++dB
	 5Bvo4nOiPS6yw==
Date: Fri, 26 Sep 2025 16:32:02 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v3 4/4] PCI: mediatek: add support for Airoha AN7583 SoC
Message-ID: <20250926213202.GB1573360-robh@kernel.org>
References: <20250925162332.9794-1-ansuelsmth@gmail.com>
 <20250925162332.9794-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925162332.9794-5-ansuelsmth@gmail.com>

On Thu, Sep 25, 2025 at 06:23:18PM +0200, Christian Marangi wrote:
> Add support for the second PCIe line present on Airoha AN7583 SoC.
> 
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
> +		 */
> +		msleep(100);
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

This should check some match data flag rather than checking compatible 
again. Otherwise this becomes device_is_compatible() || 
device_is_compatible() || device_is_compatible()...

Rob

