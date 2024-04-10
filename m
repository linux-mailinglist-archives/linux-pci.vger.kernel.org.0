Return-Path: <linux-pci+bounces-6050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4606D89FE11
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7021F211F6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B236176FDB;
	Wed, 10 Apr 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJcW3Fsv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C317B4FD;
	Wed, 10 Apr 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769448; cv=none; b=TmUTO/rvdpI8ow1iPeKJkRRihhvuynYZ6xMXMIhhGYub6WV5mNi/lNLA4LPSSsilJDYHhGIDv8g7Vz7edhkutleIw09Tuwjp684wbxNDTr+hFE05trpInEeHIe31db1zyQbd88Yj2lsAyJbGbAAg1WfPOms3jU4ynvmGQO6MIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769448; c=relaxed/simple;
	bh=BCTZpGab+2FtCJfQ4PP88DWifxf6HwadzkSsuqa9U74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7aqDMUqZZX1BAVaMlzukTqvfvpI6rpty8n9j+NkquT3bnghnCJo5k4HS1JnmEkXM+i5OJnsntuLfMyrCaQnZv5Zbwm3gkwW9o+o30DlG4BaBJpqeOSPKOJdCZBUVX/N93itY53naSjxAjMdxULkwstkwT/8eZhq+3pb4Rz1Yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJcW3Fsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29321C433C7;
	Wed, 10 Apr 2024 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769447;
	bh=BCTZpGab+2FtCJfQ4PP88DWifxf6HwadzkSsuqa9U74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJcW3Fsvr3DEhz61yTJRsd8lCqvA7Ql/lS4irbb73HHT6Nfyo5oG0zABOrvXF/5bb
	 584qAUwmnRPZIboKBXlMdJ1z/Gln22ns+jEVQ++ksb1xTFPcWXI+Xbn+A2qGeW/LUu
	 oFMTTyd/wEi/mbYrljxUcBcexVxfr/Gc5+9oMibWZshY8wga0k63jw+nVN8T7a6YSa
	 b8RFpNaFfonqQArKtxIQpnyBLFmIrKUHYm3EMoQAJr/KuB7pm3mM2NEHssDL36jlQh
	 UZxDe1Q8yPdJrY7AznTIKwFGirzlkCr/X0YWpLJ159OoSmgxyUbBH5aT3nZjfYUdiV
	 jL6ktJc9WmCig==
Date: Wed, 10 Apr 2024 22:47:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 4/7] PCI: rcar-gen4: Add rcar_gen4_pcie_platdata
Message-ID: <20240410171713.GB16629@thinkpad>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
 <20240410004832.3726922-5-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410004832.3726922-5-yoshihiro.shimoda.uh@renesas.com>

On Wed, Apr 10, 2024 at 09:48:29AM +0900, Yoshihiro Shimoda wrote:
> This driver supports r8a779f0 now. In the future, add support for
> r8a779g0 and r8a779h0. To support these new SoCs, need other
> initializing settings. So, at first, add rcar_gen4_pcie_platdata
> and have a member with mode. No behavior changes.
> 

How about,

"In order to support future SoCs such as r8a779g0 and r8a779h0 that require
different initialization settings, let's introduce SoC specific driver data with
the initial member being the device mode. No functional change."

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++++++-------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 0be760ed420b..da2821d6efce 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -48,11 +48,15 @@
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
>  
> +struct rcar_gen4_pcie_platdata {

Common naming convention is 'drvdata'.

> +	enum dw_pcie_device_mode mode;
> +};
> +
>  struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
>  	struct platform_device *pdev;
> -	enum dw_pcie_device_mode mode;
> +	const struct rcar_gen4_pcie_platdata *platdata;
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
> @@ -137,7 +141,7 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
>  	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
>  	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
>  	 */
> -	if (changes && rcar->mode == DW_PCIE_RC_TYPE)
> +	if (changes && rcar->platdata->mode == DW_PCIE_RC_TYPE)

I'd recommend checking for the existence of the drvdata first. But if you are
sure that it will be present for all SoCs, then it can be left.

- Mani

>  		changes--;
>  
>  	for (i = 0; i < changes; i++) {
> @@ -172,9 +176,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>  
>  	val = readl(rcar->base + PCIEMSR0);
> -	if (rcar->mode == DW_PCIE_RC_TYPE) {
> +	if (rcar->platdata->mode == DW_PCIE_RC_TYPE) {
>  		val |= DEVICE_TYPE_RC;
> -	} else if (rcar->mode == DW_PCIE_EP_TYPE) {
> +	} else if (rcar->platdata->mode == DW_PCIE_EP_TYPE) {
>  		val |= DEVICE_TYPE_EP;
>  	} else {
>  		ret = -EINVAL;
> @@ -437,9 +441,9 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  /* Common */
>  static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
>  {
> -	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
> +	rcar->platdata = of_device_get_match_data(&rcar->pdev->dev);
>  
> -	switch (rcar->mode) {
> +	switch (rcar->platdata->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		return rcar_gen4_add_dw_pcie_rp(rcar);
>  	case DW_PCIE_EP_TYPE:
> @@ -480,7 +484,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
>  
>  static void rcar_gen4_remove_dw_pcie(struct rcar_gen4_pcie *rcar)
>  {
> -	switch (rcar->mode) {
> +	switch (rcar->platdata->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		rcar_gen4_remove_dw_pcie_rp(rcar);
>  		break;
> @@ -500,14 +504,22 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>  	rcar_gen4_pcie_unprepare(rcar);
>  }
>  
> +static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep = {
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie",
> -		.data = (void *)DW_PCIE_RC_TYPE,
> +		.data = &platdata_rcar_gen4_pcie,
>  	},
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie-ep",
> -		.data = (void *)DW_PCIE_EP_TYPE,
> +		.data = &platdata_rcar_gen4_pcie_ep,
>  	},
>  	{},
>  };
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

