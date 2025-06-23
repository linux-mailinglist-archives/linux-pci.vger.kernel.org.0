Return-Path: <linux-pci+bounces-30369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75DAE3E2B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE4716449B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB323C390;
	Mon, 23 Jun 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJQ3ID8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7B219A86;
	Mon, 23 Jun 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678972; cv=none; b=IpNIuk6TnkIv5b1Hk0+jyaVJMu+ysc1KaaqKgUJgpZtJ6czm7uneD3XnvfpFPAjetvhhEfYGHqcLEQDrfB38BMUMH4EfhfDr9w/dutAqmdGcUb5k/GDU8txfWwaxIILLSHTU6hbgLj0oXOhrXyfqllNbCumL9In3FNx4rJfA/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678972; c=relaxed/simple;
	bh=2m5CfZQaw2dv5R3Bx1BYdCmiNkSM8d2I9a7oqNpDaJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbTP4YF6ZYZt0fjClHQyHa244UnULPiiqT4GISgFYXkxynPwAdroTL4toWMOpF+ausimBsaTlpPTowoGkElsnh4Ib59IKIoMItdeC+tIBGAf1oHe2LUmwuK1A2HBdS/OdZf1jYbklFKcg/hmQAzJBgU5J5ts2pCLATRD9s32Lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJQ3ID8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E13C4CEEA;
	Mon, 23 Jun 2025 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750678972;
	bh=2m5CfZQaw2dv5R3Bx1BYdCmiNkSM8d2I9a7oqNpDaJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJQ3ID8qLCiFR8Pxde6rF2KJJUAOZVH8hsgrPoPWLp9XsVub8YquvV1sgl7Xc7+ep
	 owTauxF/ndQDiCzVeTf2yjAcNYDE/pW79OdZKaH6JbutbKuWrCSeGIi/Joi25lDODC
	 uBi3KqSVZav3oTXjLfjJadHCrwVa2fHUmhMBabGYPVDhK2i1vkp/9Tmg72GCOdjQn8
	 1la1NsNuC4JyZ59DCFc9mXQT/RJHTgQrYRjZA5yhQMrCbFzuvCAbURgwj65ULx4ayz
	 E2Pi5T2PJt/7QLTKK7VUDglj7VtKrzyylDa9NGdbCYpWq1IBICjrRHHdWc/z9tCqyJ
	 8ZOHbkT/1SwBg==
Date: Mon, 23 Jun 2025 05:42:50 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v3 1/2] PCI: imx6: Remove apps_reset toggle in
 _core_reset functions
Message-ID: <kjsaipr2xq777dmiv2ac7qzrxw47nevc75j7ryma32vsnyr2le@mrwurn6rgnac>
References: <20250616085742.2684742-1-hongxing.zhu@nxp.com>
 <20250616085742.2684742-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616085742.2684742-2-hongxing.zhu@nxp.com>

On Mon, Jun 16, 2025 at 04:57:41PM +0800, Richard Zhu wrote:
> apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms.
> Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
> wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();
> 

What about other i.MX chipsets like 6Q and its cousins? Wouldn't this change
affect them since they treat 'apps_reset' differently?

- Mani

> Remove apps_reset toggle in imx_pcie_assert_core_reset() and
> imx_pcie_deassert_core_reset() functions. Use imx_pcie_ltssm_enable()
> and imx_pcie_ltssm_disable() to configure apps_reset directly.
> 
> Fix fail to enumerate reliably PI7C9X2G608GP (hotplug) at i.MX8MM, which
> reported By Tim.
> 
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Closes: https://lore.kernel.org/all/CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZcMHDy+poj9=jSy+w@mail.gmail.com/
> Fixes: ef61c7d8d032 ("PCI: imx6: Deassert apps_reset in imx_pcie_deassert_core_reset()")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9754cc6e09b9..f5f2ac638f4b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -860,7 +860,6 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_assert(imx_pcie->pciephy_reset);
> -	reset_control_assert(imx_pcie->apps_reset);
>  
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, true);
> @@ -872,7 +871,6 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_deassert(imx_pcie->pciephy_reset);
> -	reset_control_deassert(imx_pcie->apps_reset);
>  
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, false);
> @@ -1247,6 +1245,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		}
>  	}
>  
> +	/* Make sure that PCIe LTSSM is cleared */
> +	imx_pcie_ltssm_disable(dev);
> +
>  	ret = imx_pcie_deassert_core_reset(imx_pcie);
>  	if (ret < 0) {
>  		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

