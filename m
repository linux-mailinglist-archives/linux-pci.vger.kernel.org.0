Return-Path: <linux-pci+bounces-13613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A93988D12
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 01:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405721F21C50
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920B1B3F33;
	Fri, 27 Sep 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgc0B/X6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA3187345;
	Fri, 27 Sep 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727481286; cv=none; b=V4L1mq6KNPEMj3MJ2ghMm3dU/k2OA3Hqt/MuKY9tpxgGYeuCcswWHgr26JTGlThXdU7slbTo4FCu2J6bkc4taZx3lW2fymPmKIhImboPU9hSylvU7X9w0iTxiE3EC4YS937fWfmcl/swHV/CiWDLJHNVNfcRLmRTUMGLn15xNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727481286; c=relaxed/simple;
	bh=xuljhnvBCGrJKOmRNT+0jGIXwSOHGJy+hMu8r7QwgC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ne8TT1a1zlf0KVx+qLDHka9nq8fIeeT/iXwsiiz/lDkt9j04MtPtFrJdsloCS8SIkIwKUM3fYIReSlXBeFn+B40zIecU+EZs8XvtZ9Tmu7dr9HtBIqfrkRw9+xJIcXdzhCvBhZAn1ZVNI04OUbQwdq4NcyE/9gX1sHfxrTCYwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgc0B/X6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9CCC4CEC4;
	Fri, 27 Sep 2024 23:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727481286;
	bh=xuljhnvBCGrJKOmRNT+0jGIXwSOHGJy+hMu8r7QwgC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Wgc0B/X6N9Wpa23OFUqvPsmyDacOOMPxTRWZca6USb44APmwCH1LTlX7CSftlXD4n
	 THkDexcFUOI0t5CKfrY6D3Eh82TGVYEF7DXQHd4l0vMQMOLL5u+oSPn0dSL45o1faK
	 lYqrTokvnKclH8/5lK81DgwIvEfLK0yjwM2TImkuz3Nt3Y+df5AAY5wT3qzPx8ljsj
	 T0pCkQfsyYdR6OnMRVfqAAiLc+0D1vpeBfDXc9saqJUa1mPtSXOnSwqY8ig3aKwW5x
	 fmNDlzhoPAgPXkjv6G63HDci1RpDcJOy+BkT4Yi25d243V1zpOs/dWStLKAHcwKxwy
	 97mYpxIHWERHA==
Date: Fri, 27 Sep 2024 18:54:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/3] PCI: imx6: Remove cpu_addr_fixup()
Message-ID: <20240927235444.GA98792@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-pci_fixup_addr-v2-3-e4524541edf4@nxp.com>

On Thu, Sep 26, 2024 at 12:47:15PM -0400, Frank Li wrote:
> Remove cpu_addr_fixup() because dwc common driver already handle address
> translate.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - set using_dtbus_info true
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1e58c24137e7f..94f3411352bf0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,7 +82,6 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> -#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1015,22 +1014,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>  
> -static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> -{
> -	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> -	struct dw_pcie_rp *pp = &pcie->pp;
> -	struct resource_entry *entry;
> -
> -	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> -		return cpu_addr;
> -
> -	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> -	if (!entry)
> -		return cpu_addr;
> -
> -	return cpu_addr - entry->offset;
> -}
> -
>  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> @@ -1039,7 +1022,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = imx_pcie_start_link,
>  	.stop_link = imx_pcie_stop_link,
> -	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,

This is tremendous, thank you very much for doing this!

Have you looked at the other users of .cpu_addr_fixup()?  It looks
like cadence, dra7xx, artpec6, intel-gw, and visconti all use it.

Do we know whether any of them have to deal with DTs that don't
describe the correct translations?  It would be even better if we
could fix them all and we didn't need using_dtbus_info.

>  };
>  
>  static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
> @@ -1459,6 +1441,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pci->using_dtbus_info = true;
>  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
>  		if (ret < 0)
> @@ -1598,8 +1581,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8Q] = {
>  		.variant = IMX8Q,
> -		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
> -			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
> +		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
>  		.clk_names = imx8q_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8q_clks),
>  	},
> 
> -- 
> 2.34.1
> 

