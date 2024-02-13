Return-Path: <linux-pci+bounces-3390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C3852E7C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 11:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0764A1F23545
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD17B2BB08;
	Tue, 13 Feb 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INTKDBba"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963D28E3C;
	Tue, 13 Feb 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821883; cv=none; b=KfZYWbKXhk9dH6ZS/dWrWIh7VqZHKnPIy5daib7eftiWNcTbGDFuReTjq72RQ7OObTL4N7g40ashTPvn3S01Ufq4LtmsPduvP7ZVOoR7Rz91Qd3xd3Wn8Sgb2C/ta8aY6RN6x9SwHiKXesacptn+h6lfsU8H1C+W7sqBqph0S18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821883; c=relaxed/simple;
	bh=UbTGdcO5Bm4Sgp9Ihu7UwBcjhxFPyxzYn0e9t6YIqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIM52w8TH4eZcBrLNVYO4RMOIdZZJHEWvy0B7y1UISKxgUpEhQO74Vf/OYBnNn7uFRD3LGE9Vgdhx+NPYUhf9nDSiY003rI+7msRUSZIQawnu82UMB5qRMMADSUnKaJJuyRb93KYAo8zdDv7qPc6KQj1atcZyiyLFb0Ou2r8oDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INTKDBba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC3EC433C7;
	Tue, 13 Feb 2024 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707821883;
	bh=UbTGdcO5Bm4Sgp9Ihu7UwBcjhxFPyxzYn0e9t6YIqgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INTKDBba8hXyE6vt/uWzBbB8QaeDqCluqtP9DTn56EQMqVjm8m/dZhZOgIWvnp0Lx
	 RBnicsUYj5AyrzCAHVDl+rD6TT6dW5u64WXYorKlZox6b+otEToPRFEhV/NvJipswD
	 UfthNFX2YltDLZJg//Skp/N+rWyG17ClDyTLKtRUk+mcQntw02vmltuirlILX+yZNT
	 jyBWD52c2ztAnHujkwSNhnsToO/T+EyZVPPsCM/wmo1WMMVkerMiQ5nJFUmsuYf88q
	 dVA6aMdHPEkcp8BDjhqcLyKmAIo0puRTDNnvCZ6FTIg9MP85hJgbPr+Y6+vn1X6Hzp
	 WZxmOwNmUn5TQ==
Date: Tue, 13 Feb 2024 11:57:55 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v9 07/16] PCI: imx6: Simplify configure_type() by using
 mode_off and mode_mask
Message-ID: <ZctLM7xLf7L3CJrr@lpieralisi>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <20240119171122.3057511-8-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119171122.3057511-8-Frank.Li@nxp.com>

On Fri, Jan 19, 2024 at 12:11:13PM -0500, Frank Li wrote:
> Add drvdata::mode_off and drvdata::mode_mask to simplify
> imx6_pcie_configure_type() logic.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Chagne from v8 to v9
>     - add Manivannan's review tag
>     Change from v7 to v8
>     - replace simple with simplify
>     - remove reduntant comments about FILED_PREP
>     Change from v3 to v7
>     - none
>     Change from v2 to v3
>     - none
>     Change from v1 to v2
>     - use ffs() to fixe build error.
>     
>     Change from v2 to v3
>     - none
>     Change from v1 to v2
>     - use ffs() to fixe build error.
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 59 ++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index d19fcb54fde0d..8df07b71c93e5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -68,6 +68,7 @@ enum imx6_pcie_variants {
>  
>  #define IMX6_PCIE_MAX_CLKS       6
>  
> +#define IMX6_PCIE_MAX_INSTANCES			2
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
>  	enum dw_pcie_device_mode mode;
> @@ -78,6 +79,8 @@ struct imx6_pcie_drvdata {
>  	const u32 clks_cnt;
>  	const u32 ltssm_off;
>  	const u32 ltssm_mask;
> +	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
> +	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
>  };
>  
>  struct imx6_pcie {
> @@ -174,32 +177,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>  {
> -	unsigned int mask, val, mode;
> +	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
> +	unsigned int mask, val, mode, id;
>  
> -	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
> +	if (drvdata->mode == DW_PCIE_EP_TYPE)
>  		mode = PCI_EXP_TYPE_ENDPOINT;
>  	else
>  		mode = PCI_EXP_TYPE_ROOT_PORT;
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -		if (imx6_pcie->controller_id == 1) {
> -			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
> -			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> -					  mode);
> -		} else {
> -			mask = IMX6Q_GPR12_DEVICE_TYPE;
> -			val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
> -		}
> -		break;
> -	default:
> -		mask = IMX6Q_GPR12_DEVICE_TYPE;
> -		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
> -		break;
> -	}
> +	id = imx6_pcie->controller_id;
> +
> +	/* If mode_mask[id] is zero, means each controller have its individual gpr */
> +	if (!drvdata->mode_mask[id])
> +		id = 0;

I don't understand what this means. If the mode mask for id is == 0, we
are falling back to mode_mask and mode_off for controller ID 0 ? Is that
what this code is supposed to do ? If so the comment makes no sense to
me.

Lorenzo

> +
> +	mask = drvdata->mode_mask[id];
> +	val = mode << (ffs(mask) - 1);
>  
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
>  }
>  
>  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
> @@ -1385,6 +1380,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx6q_clks),
>  		.ltssm_off = IOMUXC_GPR12,
>  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1396,6 +1393,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
>  		.ltssm_off = IOMUXC_GPR12,
>  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1408,6 +1407,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx6q_clks),
>  		.ltssm_off = IOMUXC_GPR12,
>  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> @@ -1417,6 +1418,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx7d-iomuxc-gpr",
>  		.clk_names = imx6q_clks,
>  		.clks_cnt = ARRAY_SIZE(imx6q_clks),
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> @@ -1425,6 +1428,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
>  		.clk_names = imx8mq_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.mode_off[1] = IOMUXC_GPR12,
> +		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1434,6 +1441,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> @@ -1443,6 +1452,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> @@ -1452,6 +1463,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
>  		.clk_names = imx8mq_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.mode_off[1] = IOMUXC_GPR12,
> +		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> @@ -1460,6 +1475,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> @@ -1468,6 +1485,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> +		.mode_off[0] = IOMUXC_GPR12,
> +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
>  };
>  
> -- 
> 2.34.1
> 

