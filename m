Return-Path: <linux-pci+bounces-33874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B588B22EAF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B811A24B2F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493572F83D8;
	Tue, 12 Aug 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXx9gseD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF72286D61;
	Tue, 12 Aug 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018748; cv=none; b=GoK7lavrVcrPZ1McQ/GQPpP+i0P9YbjSeo3GtPSKyaP1iHkUr5azqC2cLmpTcU6+lxkHaFvOrtdm1lFkQ0n3OUvbayoaStn7VtpaRHlcX+LqaLkWEqZuZsu2g3XBFmBb3MBR9G9/hbUF/jzhz8l1mrnx1/MWx7ytFCqV/m5Ffrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018748; c=relaxed/simple;
	bh=sbkCPKwftTrUkZdiXc/EE3AJ3jJBcpouENbdl33Fz34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqP1T4AcejwfOEHWbQIcFtST9FsaVABNxY3lL/lZLMAYuAxJtGPEpwYnmppoCC9C2L+pZOXmJS8FNvNk5QFZ6vIoo2vm1FILHHa63OZBPmn7ksS2dvy2tZmcy8opVX1bIBMaXA06Czlp7NaMPTXNH+ANoDN22h//hKdUavg4jpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXx9gseD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B54C4CEF0;
	Tue, 12 Aug 2025 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755018747;
	bh=sbkCPKwftTrUkZdiXc/EE3AJ3jJBcpouENbdl33Fz34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXx9gseDXKIuFwtIIhveZDwIf2HCNERDvQcwjBm11f0IoKqQfl16vACxSWboPJ2vT
	 ZmlgdaRgw2T11JvWC+MrugfTSEOKkcNF6de6dcUu4+7+L2XiA8dzz/DTpkF2wbxSA8
	 lkFScCz4E8iTgYebg9Uvan5h7Z/NOnpSGCtwdsN1BDbSHMdaCbpCpJjwICJEJ4llkX
	 EJhhnU+PAyYoGwX31zZaNUjgy+DQ15n0nZ014YLlUciPnPdD39h5neAMEZfxyd2jQU
	 Q1BvJaIxYpI3gnnUvezXBXr07frMKY7rYXSIBnp81Og5N/djbx+PnhKikvjnmYK88/
	 LeHLfMA/8TgsA==
Date: Tue, 12 Aug 2025 22:42:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Enable the vpcie regulator when fetch it
Message-ID: <zl6ie74kyeen2oudt3l2hv6ba5fwjsuiqlpdgaao5l7al7zjwu@bsj3agyukypn>
References: <20250619072438.125921-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250619072438.125921-1-hongxing.zhu@nxp.com>

On Thu, Jun 19, 2025 at 03:24:38PM GMT, Richard Zhu wrote:
> Enable the vpcie regulator at probe time and keep it enabled for the
> entire PCIe controller lifecycle. This ensures support for outbound
> wake-up mechanism such as WAKE# signaling.

I'm not sure about this part. For supporting WAKE#, Vaux supply has to be
supplied to the endpoint. But here, 'vpcie' looks like the main 3.3V supply. So
keeping it always on to support WAKE#, sounds to me that the component never
enters the D3Cold state. So no WAKE# is required.

- Mani

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..7cab4bcfae56 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -159,7 +159,6 @@ struct imx_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
> -	struct regulator	*vpcie;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
>  
> @@ -1198,15 +1197,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	int ret;
>  
> -	if (imx_pcie->vpcie) {
> -		ret = regulator_enable(imx_pcie->vpcie);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	}
> -
>  	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
>  		pp->bridge->enable_device = imx_pcie_enable_device;
>  		pp->bridge->disable_device = imx_pcie_disable_device;
> @@ -1222,7 +1212,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	ret = imx_pcie_clk_enable(imx_pcie);
>  	if (ret) {
>  		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> -		goto err_reg_disable;
> +		return ret;
>  	}
>  
>  	if (imx_pcie->phy) {
> @@ -1269,9 +1259,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	phy_exit(imx_pcie->phy);
>  err_clk_disable:
>  	imx_pcie_clk_disable(imx_pcie);
> -err_reg_disable:
> -	if (imx_pcie->vpcie)
> -		regulator_disable(imx_pcie->vpcie);
>  	return ret;
>  }
>  
> @@ -1286,9 +1273,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		phy_exit(imx_pcie->phy);
>  	}
>  	imx_pcie_clk_disable(imx_pcie);
> -
> -	if (imx_pcie->vpcie)
> -		regulator_disable(imx_pcie->vpcie);
>  }
>  
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> @@ -1739,12 +1723,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>  
> -	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
> -	if (IS_ERR(imx_pcie->vpcie)) {
> -		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> -			return PTR_ERR(imx_pcie->vpcie);
> -		imx_pcie->vpcie = NULL;
> -	}
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vpcie");
>  
>  	imx_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
>  	if (IS_ERR(imx_pcie->vph)) {
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

