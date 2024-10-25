Return-Path: <linux-pci+bounces-15382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506979B12A6
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 00:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146A728307B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403C20EA57;
	Fri, 25 Oct 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMqCwlt3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9E20D4FC;
	Fri, 25 Oct 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895558; cv=none; b=XjTE8VHQM537vfK0wq6ISUyl/IASYUyUMqRjog/9GMY1DicS36e4eRDO+GTkWG5et3ouLeL/Fl1dv9/el0pwAWNW/vSq9GP4CC73C0zJ2m55k0K1VgM2lGMmOWK6DXJZyUjOj9LnHfycLh1sSwrNYAKClLdprD4yXE+bRoms16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895558; c=relaxed/simple;
	bh=lvgqZKZL3hTSMXjWYkYB2dg3KyAAN40oIeI42dzGJls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sDxGAwGisjA9+1TCWMWScdeY1pgjRLMEGmZ15F7g0vlBGubhNzqQxxDM41UQexRqHkDhCkvSffrGLV8NuR0NWEdOTqLTPNr83TU/zOZXX7rNJPDgwpsOSRj/lAG1W7Ska+z5L+qFKL4qfAble8YejgLTZDfZ8mquG789u0BCbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMqCwlt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7A4C4CEC3;
	Fri, 25 Oct 2024 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729895558;
	bh=lvgqZKZL3hTSMXjWYkYB2dg3KyAAN40oIeI42dzGJls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bMqCwlt3rfSKnmYXP3CO1qHyjKGshQkpsafQF2TFtPpe8OJLF2eHJv0QZVeGh+vbR
	 mbzYexzaFGMPKNILD/JuyECnaOF+BCjy7vXA8rpIu+ArdNAIBFHXogFUA7gI78NmNw
	 wOCRX2/ZwmipiTNEyEGV/F1wK5DWL6poIRULNFbfZmKBLUvU5H3rTni7OtT7niq9ka
	 6DyqbPXG8uK7S+Rc1Pr712yHYZUiycuKhtO6fWFTbc5fYdkealO2joTF2KcJlqVq1C
	 k9JPcaw/czcYbe+l2XGV0RtVOMjgzc35OBiIKlLVTsemNgsTlJayFIt4grrcdQFn/i
	 K0gq2aNy4BUKQ==
Date: Fri, 25 Oct 2024 17:32:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v4 4/4] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Message-ID: <20241025223236.GA1030308@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-pcie_ep_range-v4-4-08f8dcd4e481@nxp.com>

On Thu, Oct 24, 2024 at 04:41:46PM -0400, Frank Li wrote:
> Add support for i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
> Endpoint (EP). On i.MX8Q platforms, the PCI bus addresses differ from the
> CPU addresses. The DesignWare (DWC) driver already handles this in the
> common code.
> 
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Chagne from v3 to v4
> - none
> change from v2 to v3
> - add Mani's review tag
> - Add pci->using_dtbus_info = true;
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bdc2b372e6c13..5be9bac6206a7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -70,6 +70,7 @@ enum imx_pcie_variants {
>  	IMX8MQ_EP,
>  	IMX8MM_EP,
>  	IMX8MP_EP,
> +	IMX8Q_EP,
>  	IMX95_EP,
>  };
>  
> @@ -1079,6 +1080,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>  	.align = SZ_64K,
>  };
>  
> +static const struct pci_epc_features imx8q_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +	.bar[BAR_1] = { .type = BAR_RESERVED, },
> +	.bar[BAR_3] = { .type = BAR_RESERVED, },
> +	.bar[BAR_5] = { .type = BAR_RESERVED, },
> +	.align = SZ_64K,
> +};
> +
>  /*
>   * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
>   * ================================================================================================
> @@ -1448,6 +1459,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pci->using_dtbus_info = true;

I mentioned this elsewhere, but I think the using_dtbus_info part
should be part of a series that only deals with the address
translation, and adding IMX8Q_EP should be in a separate series.

>  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
>  		if (ret < 0)
> @@ -1645,6 +1658,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.epc_features = &imx8m_pcie_epc_features,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
> +	[IMX8Q_EP] = {
> +		.variant = IMX8Q_EP,
> +		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
> +		.mode = DW_PCIE_EP_TYPE,
> +		.epc_features = &imx8q_pcie_epc_features,
> +		.clk_names = imx8q_clks,
> +		.clks_cnt = ARRAY_SIZE(imx8q_clks),
> +	},
>  	[IMX95_EP] = {
>  		.variant = IMX95_EP,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> @@ -1674,6 +1695,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
>  	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
>  	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
> +	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
>  	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
>  	{},
>  };
> 
> -- 
> 2.34.1
> 

