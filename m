Return-Path: <linux-pci+bounces-7381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E68C3019
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 09:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F655284A1A
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66ACDDAD;
	Sat, 11 May 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq+T2DKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F733D27D;
	Sat, 11 May 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413100; cv=none; b=PA7/wdvNkMVbCgPGJX+jPIbOsLAkcKp0fcnvURDg7mBOoSer3tan0cSGg1nS4NUjvjKBATUKy6ymThKssIdQ2D4g/hDwC1BO2nscWoawgvxQtLrHgTZE7BZAPSqTBYRRGS6ipvV6+U4pk/Bs1qeUrSk8cG23gyUKw3Ex8i/kcg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413100; c=relaxed/simple;
	bh=3XqU5e2jg+oxlMFAfddy7rmL3p06MwkS0Osy+ZTGxCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjnP77YQUdqTUInYveFADHffj+LBq+Io+WiD2CCLdRg2gVnAVCs/QEOK9xKNB+wxYlue/2E1brVxNOziICToui5npd7w5C29+CCpe05lEL4GEzYJpaad8gRZd8/1eYWThj303FfkeCH+Lp6vWnBHfqpuIssvDnaMHM1RUdqp6HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq+T2DKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE98C2BD10;
	Sat, 11 May 2024 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715413100;
	bh=3XqU5e2jg+oxlMFAfddy7rmL3p06MwkS0Osy+ZTGxCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uq+T2DKv/taQiRxDwoI36ksVvtx2rtR+G7Xy3E7pX+JUx+hb5yQyWJKifzVrCDpot
	 hoIipBQGCLxoB3QP5vudsBk2jtqwhbYMSkpZe2GOjl+Loyl+uf6IovsPsYvdKIGiog
	 bcp1fmZHn7WsviEYUPuP/DbmQhZocaDMlwAItUXs8UmyvCxIyCfxBbbt1ARtXT3/uh
	 DPLGj7cl/VucFJ77KTruxCFK85vu2xg4o3jBbOUOmB1YYSqxDPWkTx6IZY79pWCfGL
	 99wuuStdL7b+RRYDva6WT48eaosKwCRvrpoZW/vtw1Ex5LIXbQQGzuNXJiCMXL7iDs
	 vJRl2jvrg4Efw==
Date: Sat, 11 May 2024 13:08:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 5/7] PCI: rcar-gen4: Add .ltssm_enable() for other SoC
 support
Message-ID: <20240511073812.GE6672@thinkpad>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-6-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415081135.3814373-6-yoshihiro.shimoda.uh@renesas.com>

PCI: rcar-gen4: Move LTSSM handling to ltssm_control() callback

On Mon, Apr 15, 2024 at 05:11:33PM +0900, Yoshihiro Shimoda wrote:
> This driver can reuse other R-Car Gen4 SoCs support like r8a779g0 and
> r8a779h0. However, r8a779g0 and r8a779h0 require other initializing
> settings that differ than r8a779f0. So, add a new function pointer
> .ltssm_enable() for it.
> 
> After applied this patch, probing SoCs by rcar_gen4_pcie_of_match[]
> will be changed like below:
> 
> - r8a779f0 as "renesas,r8a779f0-pcie" and "renesas,r8a779f0-pcie-ep"
> 
> Existing dts files have the compatible above. So, no behavior changes.
> 

How about:

Sequence for controlling the LTSSM state machine is going to change for SoCs
like r8a779f0. So let's move the LTSSM code to a new callback ltssm_control()
and populate it for each SoCs.

This also warrants the addition of new compatibles for r8a779g0 and r8a779h0.
But since they are already part of the DT binding, it won't make any difference.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 41 ++++++++++++++++++---
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 3da0a844e1b6..980a916933d6 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -48,7 +48,9 @@
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
>  
> +struct rcar_gen4_pcie;
>  struct rcar_gen4_pcie_drvdata {
> +	int (*ltssm_enable)(struct rcar_gen4_pcie *rcar);

int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);

>  	enum dw_pcie_device_mode mode;
>  };
>  
> @@ -61,8 +63,8 @@ struct rcar_gen4_pcie {
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
>  /* Common */
> -static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> -					bool enable)
> +static void rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar,
> +					 bool enable)
>  {
>  	u32 val;
>  
> @@ -127,9 +129,13 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
>  static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
>  {
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> -	int i, changes;
> +	int i, changes, ret;
>  
> -	rcar_gen4_pcie_ltssm_enable(rcar, true);
> +	if (rcar->drvdata->ltssm_enable) {
> +		ret = rcar->drvdata->ltssm_enable(rcar);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/*
>  	 * Require direct speed change with retrying here if the link_gen is
> @@ -157,7 +163,7 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
>  {
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>  
> -	rcar_gen4_pcie_ltssm_enable(rcar, false);
> +	rcar_gen4_pcie_ltssm_control(rcar, false);

You should use the callback here as like above.

>  }
>  
>  static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> @@ -504,6 +510,23 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>  	rcar_gen4_pcie_unprepare(rcar);
>  }
>  
> +static int r8a779f0_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar)
> +{
> +	rcar_gen4_pcie_ltssm_control(rcar, true);
> +
> +	return 0;
> +}
> +
> +static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
> +	.ltssm_enable = r8a779f0_pcie_ltssm_enable,

Just pass rcar_gen4_pcie_ltssm_control() directly.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

