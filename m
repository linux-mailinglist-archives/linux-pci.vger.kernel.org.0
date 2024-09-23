Return-Path: <linux-pci+bounces-13382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAFF97EFC0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D374281A94
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F2C19F104;
	Mon, 23 Sep 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+zpBNoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE119E969
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111444; cv=none; b=MCxTsUxe6gMqb9h7lz5ebf/XZzmfYm8Cj+JMzGi8CBovGVWLxjv58V6KkOxWERRvPqPu93I+HaW7nHONAAxacQaqeMW9mzEBGJG/zRcttOK1lNoffxiDKUx+ASjcgy8W7WIq5Fte3mYT4Fkk6gnGzrbqn0j2zuSpz2ukn0a3u1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111444; c=relaxed/simple;
	bh=ERL1mF7EifE8Btv5ZllVfGqAXg7eda+uXs6jOm6xI4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qr04VgJ9/O0zROtU+X/YeGb7jQkua7QWAYvCzh/l8FF5B0x7yJvT5R8XbovpFIC3T2YLMkpnQ8W3/kFCfHLVCryQ4pGbWFzkhlpSnWQYb7MN9r9k/0a3irPgHZlVHEysSJs5IojndRpO57KP9mpXhZt93VHx0F87E/Ebu1MFWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+zpBNoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAF4C4CEC4;
	Mon, 23 Sep 2024 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727111443;
	bh=ERL1mF7EifE8Btv5ZllVfGqAXg7eda+uXs6jOm6xI4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k+zpBNoWwL1UaXRyVPe3bA+peFdHQ6shIBOEnqufaDmEx37SI4K2MahdzJxgyqPLJ
	 UiyM3xlhk/JjTIOYHOAmhuNbYGIVDIMHwEmo9J+PsmJIMQGPegO0I8+DwB/nF749ar
	 4spbjxYlStgCBaBgMY8EFlhHyfPAm4eX3OI7S8MFvpQmUD5dr9NOOkkN+XzvCTiy8L
	 8xU0d8/25IpycmP/AVYkf6qbn9SZPNdYxFQgNcHkco+DIRt+U5g6ks5lM8nn0/eflU
	 bOeQyagxlfPAtUGwKDa4cxWrydYP1C8X4tf6cZPF1blByhxRywzuaihi74Zs1r1oFR
	 +bH/9Sa+rHibA==
Date: Mon, 23 Sep 2024 12:10:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Avoid PCIe resetting for Airoha
 EN7581 SoC
Message-ID: <20240923171041.GA1158802@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org>

On Fri, Sep 20, 2024 at 10:26:28AM +0200, Lorenzo Bianconi wrote:
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
> Tested-by: Hui Ma <hui.ma@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 44 ++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 5c19abac74e8..9cea67e92d98 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -128,10 +128,12 @@ struct mtk_gen3_pcie;
>  /**
>   * struct mtk_gen3_pcie_pdata - differentiate between host generations
>   * @power_up: pcie power_up callback
> + * @reset: pcie reset callback
>   * @phy_resets: phy reset lines SoC data.
>   */
>  struct mtk_gen3_pcie_pdata {
>  	int (*power_up)(struct mtk_gen3_pcie *pcie);
> +	void (*reset)(struct mtk_gen3_pcie *pcie);
>  	struct {
>  		const char *id[MAX_NUM_PHY_RESETS];
>  		int num_resets;
> @@ -373,6 +375,28 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
>  	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
>  }
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

I see you're just moving this, but it's a good chance to use
PCIE_T_PVPERL_MS.

> +
> +	/* De-assert reset signals */
> +	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> +	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +}
> +
>  static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  {
>  	struct resource_entry *entry;
> @@ -402,22 +426,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
>  	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
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

I don't see any real "request" from the hardware.  IIUC, this is more
like "assert reset if this hardware supports it".

> +	if (pcie->soc->reset)
> +		pcie->soc->reset(pcie);
>  
>  	/* Check if the link is up or not */
>  	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
> @@ -1207,6 +1218,7 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
>  
>  static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
>  	.power_up = mtk_pcie_power_up,
> +	.reset = mtk_pcie_reset,
>  	.phy_resets = {
>  		.id[0] = "phy",
>  		.num_resets = 1,
> 
> ---
> base-commit: f2024903cb387971abdbc6398a430e735a9b394c
> change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 

