Return-Path: <linux-pci+bounces-8342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0A8FD41F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF1C1F2457C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4999139D10;
	Wed,  5 Jun 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9e//+Tg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C2139D0A;
	Wed,  5 Jun 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608557; cv=none; b=qqxaqRk2S4XQI38/0w6e0bjVt0sN1UH0lR4qTGzap4Y/E99FTMRyhRU3shZs0PbeK/zEHS8cs9YQSBtw2UAtXpamohOvJG+q/vRXtmy767w5BdmMbqaHYsmdBj2qvQCa9hWIin725Jdhkg2j02DT+o0ak8TJZSKyEkDAHBQSKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608557; c=relaxed/simple;
	bh=0iQ7XXPT6iNQjj6X/jsBk2JZyR5C3kXy+KKvwkRPBCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YOMtTPY8yCkXToP5U/ebNTyYJS8OtRAFXHq7A/8fkmryvG5AnhWKa1EJVFRV7AbZTSB22ATlFWl+EMz2+Wgz25KBweQyFVZgb4wvWuLEWxyajWSAJLRYIIj8Y+J+PhVjQGJO+7u8Qi+gg67nltg5rZ1Za2xQ4vmpd/D7lR+ePEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9e//+Tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9427C2BD11;
	Wed,  5 Jun 2024 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717608557;
	bh=0iQ7XXPT6iNQjj6X/jsBk2JZyR5C3kXy+KKvwkRPBCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r9e//+TgJgvKSQkJZhT35XvtyeEBQ7q28wvteScsdkYlZKJ11IjYZ1FUY/nNL1ffJ
	 7GFsIjp5TcMk1Yu/CoFcbyBsEqv0PgJT7BUo7YEDla1lXtEqYbLtfTlW58uneQzWUN
	 0vjLUuE3HCmm2c3zCIgJr/fZrL57eKKzs9Ngld84MTE48H7DAvFZizUp9F16JKlW2O
	 bIryINIVFg35j21qTvo3/XtL1jWCyVhmr9tTQSa63MkPz3wq9/s6kOMtTQ2Cfo4qWb
	 MVPTnac4dfo5ymyGc+hXqP9MTzIQQlhA2WxO1zzR+36c5DByzWtKvPgdLR631806W0
	 K5hKKk6BuDOgA==
Date: Wed, 5 Jun 2024 12:29:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 3/5] PCI: rcar-gen4: Add .ltssm_control() for other
 SoC support
Message-ID: <20240605172915.GA767034@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520074300.125969-4-yoshihiro.shimoda.uh@renesas.com>

On Mon, May 20, 2024 at 04:42:58PM +0900, Yoshihiro Shimoda wrote:
> Sequence for controlling the LTSSM state machine is going to change
> for SoCs like r8a779f0. So let's move the LTSSM code to a new callback
> ltssm_control() and populate it for each SoCs.

s/So let's move/Move/

No need to repost for this, whoever applies it can tweak it.

> This also warrants the addition of new compatibles for r8a779g0 and
> r8a779h0. But since they are already part of the DT binding, it won't
> make any difference.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
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

