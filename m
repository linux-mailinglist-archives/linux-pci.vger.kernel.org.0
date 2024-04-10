Return-Path: <linux-pci+bounces-6051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D789FE6B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593921F23E3D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B6B17BB35;
	Wed, 10 Apr 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuGinN19"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68117BB1B;
	Wed, 10 Apr 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769832; cv=none; b=BupeQEW9qRQurXlY49XDucRRAmOaLhPVG+LeMTRSksGZh7UmgBKBxCGf7xEWpBd24pPsPEDlPxRzPr3XEmliPuQ2e49q5Cpjxl5mWhbgZHQJx2RJcb3LvVNaexBX4bSkfKe6G4aG4nyBDIouGMYAhe4fu9hwk4szhrxYLzxK9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769832; c=relaxed/simple;
	bh=QVnKMzmS7cPaepB9Ny7sWzQZ4B0yeU+Pt0X7fTlrewc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3DVjhYrFrvTWc/AC14aWMZhfuppnT3x3GXdY5Jr+/EkDPMQ+wg+NYtawD8G728WJcM5rvIm/4o+7brgYBFssmd7aFQ2VtoiKPkwrrXo4u4Dz/q9LNqYcqAyifOZM5NyNzodxiu+uGYjJotsoLzM46UBpYw/YdfmuKMgDBWAiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuGinN19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0047C433F1;
	Wed, 10 Apr 2024 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769832;
	bh=QVnKMzmS7cPaepB9Ny7sWzQZ4B0yeU+Pt0X7fTlrewc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuGinN19EDHb+Cl/62f2PkQGqNeAjVO6r5pN7jY8urVpQWmigVGpJ4DJAorjdUmcY
	 ZHZGoqXoLn9Z6DdsYWugYT9DDvI41dlzMcBP+QeqrAoafWxi+7CrqY+0V8jZbXI1Uo
	 +AyvHr5vfLzm/woGdm3K2bhQFbAQO+AL5PcxhoZqQ1trRxvpUlHpBHvLwR163Wl+zh
	 FSnnElPLLThM8xfStfL3VtKXcAZVCPako40QB8P8GHwmCa2YJJ7jXuwDiMmr5SfTQf
	 L/ibkNwk8qIZq8fpiumdLenSRJuNFE2bTiWJIMz7+uYJICE2MwHSUa9+olaABxrz1v
	 +1IF2eOtHHI1Q==
Date: Wed, 10 Apr 2024 22:53:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 5/7] PCI: rcar-gen4: Add .ltssm_enable() for other SoC
 support
Message-ID: <20240410172339.GC16629@thinkpad>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
 <20240410004832.3726922-6-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410004832.3726922-6-yoshihiro.shimoda.uh@renesas.com>

On Wed, Apr 10, 2024 at 09:48:30AM +0900, Yoshihiro Shimoda wrote:
> This driver can reuse other R-Car Gen4 SoCs support like r8a779g0 and
> r8a779h0. However, r8a779g0 and r8a779h0 require other initializing
> settings that differ than r8a779f0. So, add a new function pointer
> .ltssm_enable() for it. No behavior changes.
> 
> After applied this patch, probing SoCs by rcar_gen4_pcie_of_match[]
> will be changed like below:
> 
> - r8a779f0 as "renesas,r8a779f0-pcie" and "renesas,r8a779f0-pcie-ep"
> 

If r8a779f0 SoC can work with the existing 'renesas,rcar-gen4-pcie' and
'renesas,rcar-gen4-pcie-ep' compatibles, then you should just leave it as it is
and add a new compatible with dedicated callbacks for only r8a779g0 and
r8a779h0.

- Mani

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 41 ++++++++++++++++++---
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index da2821d6efce..47ec394885f5 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -48,7 +48,9 @@
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
>  
> +struct rcar_gen4_pcie;
>  struct rcar_gen4_pcie_platdata {
> +	int (*ltssm_enable)(struct rcar_gen4_pcie *rcar);
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
> +	if (rcar->platdata->ltssm_enable) {
> +		ret = rcar->platdata->ltssm_enable(rcar);
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
> +static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie = {
> +	.ltssm_enable = r8a779f0_pcie_ltssm_enable,
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie_ep = {
> +	.ltssm_enable = r8a779f0_pcie_ltssm_enable,
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
>  static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie = {
>  	.mode = DW_PCIE_RC_TYPE,
>  };
> @@ -513,6 +536,14 @@ static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep = {
>  };
>  
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +	{
> +		.compatible = "renesas,r8a779f0-pcie",
> +		.data = &platdata_r8a779f0_pcie,
> +	},
> +	{
> +		.compatible = "renesas,r8a779f0-pcie-ep",
> +		.data = &platdata_r8a779f0_pcie_ep,
> +	},
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie",
>  		.data = &platdata_rcar_gen4_pcie,
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

