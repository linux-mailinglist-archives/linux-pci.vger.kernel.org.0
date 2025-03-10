Return-Path: <linux-pci+bounces-23328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8F1A5993B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 16:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93053A8E87
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9C22CBE5;
	Mon, 10 Mar 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjok9gkM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643D22B8D2;
	Mon, 10 Mar 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619471; cv=none; b=hIhvDeC2Gw8p8MyqQk1dvBbdjW5oOh7md8+2ygrcVgHbIG/+xSen6wBfIJ9yR6yCLlPBvS4HPW+Hmxl0iDwBbFF5h+BpnS/ggxB+z7ONsiNlHQMfrlhSmpAeRRd5Wv+n/ueXd6I/96ud//mG/9oq0qN0v0qsTy+mcpMzWPyboA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619471; c=relaxed/simple;
	bh=atd+PUJZNIOrqCwFpaInjw5P9puj5TcBLXrLKnepJLc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tGKK4Aqxo6oUDtVf3E5aItBl2cNBS1SsVkQCrUVkylUg9dTwv8h7CjRw58LyLdcnynU+YZCiBPZ7MvnpOgRJ85sjAA5xf9jfPCgtwbWArYJt8toDaUELcXWMAHx0dYTVBd9BbiCH1DTXKjGyHq3y9liQLK7LqYrW8/Sa4tYKHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjok9gkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B093DC4CEEF;
	Mon, 10 Mar 2025 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741619470;
	bh=atd+PUJZNIOrqCwFpaInjw5P9puj5TcBLXrLKnepJLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gjok9gkMjFNUJMrB2dSFP20dG5MFn7ciouO2+4x4hxhoxDYl9c5fWmVN3QffQhhPI
	 E/Vb86Y/PO2Py7XNnZmgS9eCGTSyWtPQ3d8xFM7SqUDAp9uMiN2hjVGECHZ9UeHPLX
	 Ci7y2irDK/Rx0tcOfOQJytkBCpzi4PtXFjKnMebcC3mjLfkEAJlrUIYRgU0w3lfl4t
	 s4MROwNpDJY5UJjQ2mOf7p6/tU+LYXxNtE/BUxidtLN/YgsRbgOhPT4bwD7LvPFpZf
	 GztVz0hEL+LG/uAZtJC2NQoNjgGAeP6kHiqPcjdol6//isZLLS2SVma16WKPUbmTjp
	 sbMN3nL1VrIIw==
Date: Mon, 10 Mar 2025 10:11:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Message-ID: <20250310151109.GA540579@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226024256.1678103-3-hongxing.zhu@nxp.com>

On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> Use the domain number replace the hardcodes to uniquely identify
> different controller on i.MX8MQ platforms. No function changes.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 90ace941090f..ab9ebb783593 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -41,7 +41,6 @@
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
>  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
>  
>  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
>  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct imx_pcie *imx_pcie;
>  	struct device_node *np;
> -	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int i, ret, req_cnt;
>  	u16 val;
> @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  			return PTR_ERR(imx_pcie->phy_base);
>  	}
>  
> -	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0, &dbi_base);
> -	if (IS_ERR(pci->dbi_base))
> -		return PTR_ERR(pci->dbi_base);

This makes me wonder.

IIUC this means that previously we set controller_id to 1 if the first
item in devicetree "reg" was 0x33c00000, and now we will set
controller_id to 1 if the devicetree "linux,pci-domain" property is 1.
This is good, but I think this new dependency on the correct
"linux,pci-domain" in devicetree should be mentioned in the commit
log.

My bigger worry is that we no longer set pci->dbi_base at all.  I see
that the only use of pci->dbi_base in pci-imx6.c was to determine the
controller_id, but this is a DWC-based driver, and the DWC core
certainly uses pci->dbi_base.  Are we sure that none of those DWC core
paths are important to pci-imx6.c?

>  	/* Fetch GPIOs */
>  	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(imx_pcie->reset_gpiod))
> @@ -1565,8 +1559,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	switch (imx_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
> -		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> -			imx_pcie->controller_id = 1;
> +		ret = of_get_pci_domain_nr(node);
> +		if (ret < 0 || ret > 1)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "failed to get valid pcie domain\n");
> +		else
> +			imx_pcie->controller_id = ret;
>  		break;
>  	default:
>  		break;
> -- 
> 2.37.1
> 

