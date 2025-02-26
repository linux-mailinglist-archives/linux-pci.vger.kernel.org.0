Return-Path: <linux-pci+bounces-22467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A79DA46E31
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 23:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93003A596A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 22:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0026A08F;
	Wed, 26 Feb 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4H338xo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F02561D6;
	Wed, 26 Feb 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607709; cv=none; b=mdtfHzNsGqzHMBPISsMnketFAEEKziatwxqc5A9OEzc4d+kjoV4GEm3mBCCpp3qluPQuIXrYeGUq0uYcRY81mQEoQ940IgfJSgQacEXldZT0HRZfPaRCy7kwoJ+tfLDonl+qAGrbD2Z3q7CUhbx9ovmav7ygJbaf8FGRDcE8kDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607709; c=relaxed/simple;
	bh=QbUAkvbUHg9cT3BxA/KVVOs8O43DiKCmxS/Svt4jiFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=isRwo7jMJ7CfwFMTW0hrJvYwFDmR5Th5/H2a1Q0fs9FEhjUtrK/k9vPZTSCWopnhS089gO384sF35TvLAUmTlLiyYpu6nhJ88Bq0zLMImeAQ8O6JZ4XSkmZVVYDxa3MsX6noShw4E7TQ8LkN36cytZhAdx6THsXPXv6OUDrCawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4H338xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F498C4CED6;
	Wed, 26 Feb 2025 22:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740607708;
	bh=QbUAkvbUHg9cT3BxA/KVVOs8O43DiKCmxS/Svt4jiFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I4H338xo1mfVr6Ujw1djIt8JYyAEE2PEItm2qphZ7Vc0HhqmIzu9F+ebvxPfXqBMd
	 E9W7+ilz7ArbdgkYna8Qhzccp6ITfKfttaihg1KdcTLpuy9iNgSozYMj5dgS9dP+DK
	 fWkKwEOZe5nyATbwy6acLFTbGJF02O8nxPPzcFqfxoa2FCEo2Ca3DFSEVx8Wd2IotW
	 KdAF0Uv5YXwrYllDG33w2RT3aFsYaxpmfRf+W11+vbklY2jTINbEs6gIFDYT54Bh4d
	 Ri3cy33ZDoHUWP937iA9O6ylXMscdCo+0pw7UJwU2WnXHIsx3XdEPrLKQcTOCZrse9
	 SKSh9ginKHdlQ==
Date: Wed, 26 Feb 2025 16:08:26 -0600
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
Message-ID: <20250226220826.GA561554@bhelgaas>
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

Nice, thanks for getting rid of this!

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
> -
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

