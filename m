Return-Path: <linux-pci+bounces-8335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB5F8FD079
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4874328306D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35F32F2D;
	Wed,  5 Jun 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9q0l8KH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505B19D8B7;
	Wed,  5 Jun 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596576; cv=none; b=kVdWqbxWtXc7YJ/4bY/4TlUxMtSyte4gYE2v/dlgNR5rulNTFdX1waSeXUDDrKYi6WZbZUkbLUqCLwsaX6bIyiWFRZl9JFuzALvOhcw0lAYk+L7s3q92tW8xYzcHfU/D/1eptvhc9XJzD+nSvhhv+ZqJRlnUYF5fgtDL8Xf8HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596576; c=relaxed/simple;
	bh=AYlu0W9K21h/dn3Rsw4VHe/mrxNb2Z1ux/syVqtI/dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7Pdpi5VoRNEMYX9IZM4ldvsAoBf2RbB/JyAdu3bMXkyKw9Gf5uCnDMXLCRhbcF/B6Btailaz0E/rBBq5uI1Nwlmv7x6wozVozi+Af3zyUv/w4vqz8NDgEMiFBeFk5IcWeWP9OZIH/tcm9zLFfWdXR84BTGSObDXdiin8sLOGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9q0l8KH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66933C2BD11;
	Wed,  5 Jun 2024 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717596576;
	bh=AYlu0W9K21h/dn3Rsw4VHe/mrxNb2Z1ux/syVqtI/dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9q0l8KHj3xq2XJwUf0NUIRWHm00JQwR+h/jQS0sXufILmcGyC1G24msWdsvfCfOI
	 MYOZt9rU1Fn6S9BspFV4K1Bb6wnyEDHoFdB6CVu3yY0imQ2jDvQ8B823iKN8Qjrn6v
	 KqCdfV5ScvntJskM8K6kubS/xCi3H+3aXSUY4XMcrG972+EBF+d29r/FG9krjdOhE+
	 cxtiTmvCz10SklMZ/E3XyIAzl03LtVcDwRakJzk8EDe7Y5ktle9OHiRlHacqIQ9sDf
	 G5pBrO7t+NQZUc+Vxh2J3l0MEvvkTKkMsXA03UWN+RqAeqfeGmvoJR2XidUkSHfHCS
	 FgeITJf+X7SDw==
Date: Wed, 5 Jun 2024 19:39:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 3/5] PCI: rcar-gen4: Add .ltssm_control() for other
 SoC support
Message-ID: <20240605140922.GN5085@thinkpad>
References: <20240520074300.125969-1-yoshihiro.shimoda.uh@renesas.com>
 <20240520074300.125969-4-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520074300.125969-4-yoshihiro.shimoda.uh@renesas.com>

On Mon, May 20, 2024 at 04:42:58PM +0900, Yoshihiro Shimoda wrote:
> Sequence for controlling the LTSSM state machine is going to change
> for SoCs like r8a779f0. So let's move the LTSSM code to a new callback
> ltssm_control() and populate it for each SoCs.
> 
> This also warrants the addition of new compatibles for r8a779g0 and
> r8a779h0. But since they are already part of the DT binding, it won't
> make any difference.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 74 ++++++++++++++-------
>  1 file changed, 50 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index b11e09505b0b..bcbf0a52890d 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -48,7 +48,9 @@
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
>  
> +struct rcar_gen4_pcie;
>  struct rcar_gen4_pcie_drvdata {
> +	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
>  	enum dw_pcie_device_mode mode;
>  };
>  
> @@ -61,27 +63,6 @@ struct rcar_gen4_pcie {
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
>  /* Common */
> -static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> -					bool enable)
> -{
> -	u32 val;
> -
> -	val = readl(rcar->base + PCIERSTCTRL1);
> -	if (enable) {
> -		val |= APP_LTSSM_ENABLE;
> -		val &= ~APP_HOLD_PHY_RST;
> -	} else {
> -		/*
> -		 * Since the datasheet of R-Car doesn't mention how to assert
> -		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
> -		 * hang-up issue happened in the dw_edma_core_off() when
> -		 * the controller didn't detect a PCI device.
> -		 */
> -		val &= ~APP_LTSSM_ENABLE;
> -	}
> -	writel(val, rcar->base + PCIERSTCTRL1);
> -}
> -
>  static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
>  {
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> @@ -127,9 +108,13 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
>  static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
>  {
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> -	int i, changes;
> +	int i, changes, ret;
>  
> -	rcar_gen4_pcie_ltssm_enable(rcar, true);
> +	if (rcar->drvdata->ltssm_control) {
> +		ret = rcar->drvdata->ltssm_control(rcar, true);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/*
>  	 * Require direct speed change with retrying here if the link_gen is
> @@ -157,7 +142,8 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
>  {
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>  
> -	rcar_gen4_pcie_ltssm_enable(rcar, false);
> +	if (rcar->drvdata->ltssm_control)
> +		rcar->drvdata->ltssm_control(rcar, false);
>  }
>  
>  static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> @@ -506,6 +492,38 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>  	rcar_gen4_pcie_unprepare(rcar);
>  }
>  
> +static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(rcar->base + PCIERSTCTRL1);
> +	if (enable) {
> +		val |= APP_LTSSM_ENABLE;
> +		val &= ~APP_HOLD_PHY_RST;
> +	} else {
> +		/*
> +		 * Since the datasheet of R-Car doesn't mention how to assert
> +		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
> +		 * hang-up issue happened in the dw_edma_core_off() when
> +		 * the controller didn't detect a PCI device.
> +		 */
> +		val &= ~APP_LTSSM_ENABLE;
> +	}
> +	writel(val, rcar->base + PCIERSTCTRL1);
> +
> +	return 0;
> +}
> +
> +static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
> +	.ltssm_control = r8a779f0_pcie_ltssm_control,
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
> +	.ltssm_control = r8a779f0_pcie_ltssm_control,
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
>  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
>  	.mode = DW_PCIE_RC_TYPE,
>  };
> @@ -515,6 +533,14 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
>  };
>  
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +	{
> +		.compatible = "renesas,r8a779f0-pcie",
> +		.data = &drvdata_r8a779f0_pcie,
> +	},
> +	{
> +		.compatible = "renesas,r8a779f0-pcie-ep",
> +		.data = &drvdata_r8a779f0_pcie_ep,
> +	},
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie",
>  		.data = &drvdata_rcar_gen4_pcie,
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

