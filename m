Return-Path: <linux-pci+bounces-7380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6648C3008
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402341C20D2B
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A381746E;
	Sat, 11 May 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2PbT+hT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E24A33;
	Sat, 11 May 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715412430; cv=none; b=CXtaSgAql/fQ2pO1cDMTFQnSlUht2r6/IPMAMXogj3iD5hauslhCOyozJ5a5RQrsWR1/j4Ky6p4tE2dkQ52KaP4zizc4qPNLMz5rDFtkuf80yWM4QcJAdYjaRJTXn1ogQMJ7i6rkw9QfJhWdn4LtriNTxaokIXTcHF7RqlHfRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715412430; c=relaxed/simple;
	bh=pho0PmFfIhbXkPZtW4UZllE0y/5im6qi/bN4LGe074w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnwxthqERjtpb+ovoQaa/0w0aPQ+QC60AsQ6Vy4mUcxy9zRCEPEW3fCVV2keevPMvQ/D/07hT5kizNFOOuawhn8au1peOcdOxHN6ueh7ZIX8yEiYxCBboJ4MNxMlYblQZmVUhcG/R33xo9OYL+Xb6FvOWe2cD6uUWj4aAMfcENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2PbT+hT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3208DC2BD10;
	Sat, 11 May 2024 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715412429;
	bh=pho0PmFfIhbXkPZtW4UZllE0y/5im6qi/bN4LGe074w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2PbT+hT8VgSxNsqWa/JyyLMhEnb8UwGEUbeE045CY4K2c+NLY1ZrDU1hlwv6jSPr
	 qT/2//5zP7yE5IetJROO0eNvVce71Pro5rqgwLNRvpD89yTqsP6qBRX5+NRz8upY8i
	 sOP2Kt8CPTKwyI/+nY20m+Mie3nqBTMQLaSbKBqgfxH0aIzNi6fWpVPaqgrW2wKWlV
	 v7kUy8zo3byVf1k/SrFoUYJ1CehN4EXMZzmAI/JDdRpHR75WyRePhj9SzSq+UZIbKP
	 u237q1nwXmItM1dfdnPvPSdAfae/FbQvx+gG/luqxhLLzm0bSGujw+Ih2ech4dMnbW
	 ne+XKzWLPK1/Q==
Date: Sat, 11 May 2024 12:57:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 4/7] PCI: rcar-gen4: Add rcar_gen4_pcie_drvdata
Message-ID: <20240511072702.GD6672@thinkpad>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-5-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415081135.3814373-5-yoshihiro.shimoda.uh@renesas.com>

On Mon, Apr 15, 2024 at 05:11:32PM +0900, Yoshihiro Shimoda wrote:
> In other to support future SoCs such as r8a779g0 and r8a779h0 that
> require different initialization settings, let's introduce SoC
> specific driver data with the initial member being the device mode.
> No functional change.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

One nitpick below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++++++-------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 0be760ed420b..3da0a844e1b6 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -48,11 +48,15 @@
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
>  
> +struct rcar_gen4_pcie_drvdata {
> +	enum dw_pcie_device_mode mode;
> +};
> +
>  struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
>  	struct platform_device *pdev;
> -	enum dw_pcie_device_mode mode;
> +	const struct rcar_gen4_pcie_drvdata *drvdata;
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
> @@ -137,7 +141,7 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
>  	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
>  	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
>  	 */
> -	if (changes && rcar->mode == DW_PCIE_RC_TYPE)
> +	if (changes && rcar->drvdata->mode == DW_PCIE_RC_TYPE)
>  		changes--;
>  
>  	for (i = 0; i < changes; i++) {
> @@ -172,9 +176,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>  
>  	val = readl(rcar->base + PCIEMSR0);
> -	if (rcar->mode == DW_PCIE_RC_TYPE) {
> +	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
>  		val |= DEVICE_TYPE_RC;
> -	} else if (rcar->mode == DW_PCIE_EP_TYPE) {
> +	} else if (rcar->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		val |= DEVICE_TYPE_EP;
>  	} else {
>  		ret = -EINVAL;
> @@ -437,9 +441,9 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  /* Common */
>  static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
>  {
> -	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
> +	rcar->drvdata = of_device_get_match_data(&rcar->pdev->dev);

Even though rcar->drvdata won't be NULL, the lack of NULL check will cause
folks to send fixup patch later. So please add a NULL check here itself.

- Mani

>  
> -	switch (rcar->mode) {
> +	switch (rcar->drvdata->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		return rcar_gen4_add_dw_pcie_rp(rcar);
>  	case DW_PCIE_EP_TYPE:
> @@ -480,7 +484,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
>  
>  static void rcar_gen4_remove_dw_pcie(struct rcar_gen4_pcie *rcar)
>  {
> -	switch (rcar->mode) {
> +	switch (rcar->drvdata->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		rcar_gen4_remove_dw_pcie_rp(rcar);
>  		break;
> @@ -500,14 +504,22 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>  	rcar_gen4_pcie_unprepare(rcar);
>  }
>  
> +static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie",
> -		.data = (void *)DW_PCIE_RC_TYPE,
> +		.data = &drvdata_rcar_gen4_pcie,
>  	},
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie-ep",
> -		.data = (void *)DW_PCIE_EP_TYPE,
> +		.data = &drvdata_rcar_gen4_pcie_ep,
>  	},
>  	{},
>  };
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

