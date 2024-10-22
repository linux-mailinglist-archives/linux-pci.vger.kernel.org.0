Return-Path: <linux-pci+bounces-15020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FC09AB2D2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F0B28127F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9501B141D;
	Tue, 22 Oct 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrzyoCB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ECC1A2C11;
	Tue, 22 Oct 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612432; cv=none; b=qqycrjvFUPCqCKB491gALRn5rn4Em/NMOBY1QZIEDGjXBthtNk1CYjd3Vr8UX8atagcxcNcEUxe1zuBKHUNYykcoRwMpxGPE+NJrkpH/vUi9Gc/YY45UVWETsYujy8NXBlwLK9NHUN6cwTMZ8qN/eGchPLUfIrcc9SmVm8phy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612432; c=relaxed/simple;
	bh=NCPHS5bmUtmyFfGQb7gvqJyh2iCM3PUOw9Dl1pgSsME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=duinIqd0517xk8sLnwwml8bDlIwu8SropO10R2G/SSLTsf7nG769Gna16bTZ2R6x1wP68q68j6cKoVB1coj6TRa3leFf6BeSj+w7UI+8hJXHL/KATfqwi4Mkat6JABsta7FViVC6YNuU71pHORN6D0l9ts6I60QACJPu1YCA5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrzyoCB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7A8C4CEC7;
	Tue, 22 Oct 2024 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729612431;
	bh=NCPHS5bmUtmyFfGQb7gvqJyh2iCM3PUOw9Dl1pgSsME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KrzyoCB5kRxaoJ9qB7Q1JxYdRfnriknOZAkJvZC1q7+njWYo9p8Phs6KoT0l/su4Y
	 Y0BkWhS3J89Ru6Oymx0vVsjWMlvoqEMWBUJVysJnKD+WiVc2VsJiMHPPiPcjtECGlU
	 jdqPTDsPgcn/335zWliWtmBeVUViRcQgcFcfRFHjGOyr3t2eW/ATLoSGKPDOUcQEoD
	 JwuKJ6Ra5Fx5J6U7fDl0eqnsBFcO6hsMMYM9+Wm3RZmwUOXS2oNDTjJ3VdX6IT2qp2
	 LltwbygvlJOXnDegjq2zaKyzX77SrRDpQ+Pg/EQqdQnqhzYSBNFgCb9+ot28WDukDd
	 K0/KkOvqYw1SA==
Date: Tue, 22 Oct 2024 10:53:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v3] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241022155349.GA880566@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021124922.5361-1-eichest@gmail.com>

On Mon, Oct 21, 2024 at 02:49:13PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The suspend/resume support is broken on the i.MX6QDL platform. This
> patch resets the link upon resuming to recover functionality. It shares
> most of the sequences with other i.MX devices but does not touch the
> critical registers, which might break PCIe. This patch addresses the
> same issue as the following downstream commit:
> https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> In comparison this patch will also reset the device if possible because
> the downstream patch alone would still make the ath10k driver crash.
> Without this patch suspend/resume will not work if a PCIe device is
> connected. The kernel will hang on resume and print an error:
> ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> 8<--- cut here ---
> Unhandled fault: imprecise external abort (0x1406) at 0x0106f944

https://chris.beams.io/posts/git-commit/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v6.11#n134

Add blank lines between paragraphs.  Drop the "8<--- cut here" thing.

What does "reset the link" mean?  Please use the same terminology as
the PCIe spec when possible.

The downstream commit log ("WARNING: this is not the official
workaround; user should take own risk to use it") doesn't exactly
inspire confidence.

It sounds like this resets *endpoints*?  That sounds scary and
unexpected in suspend/resume.

> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
> Changes in v3:
> - Added a new flag to the driver data to indicate that the suspend/resume
>   is broken on the i.MX6QDL platform. (Frank)
> - Fix comments to be more relevant (Mani)
> - Use imx_pcie_assert_core_reset in suspend (Mani)
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 57 +++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 808d1f1054173..09e3b15f0908a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,6 +82,11 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
>  #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> +/**
> + * Because of ERR005723 (PCIe does not support L2 power down) we need to
> + * workaround suspend resume on some devices which are affected by this errata.
> + */
> +#define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1237,9 +1242,19 @@ static int imx_pcie_suspend_noirq(struct device *dev)
>  		return 0;
>  
>  	imx_pcie_msi_save_restore(imx_pcie, true);
> -	imx_pcie_pm_turnoff(imx_pcie);
> -	imx_pcie_stop_link(imx_pcie->pci);
> -	imx_pcie_host_exit(pp);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
> +		/**

Single asterisks above, here, and below.

> +		 * The minimum for a workaround would be to set PERST# and to
> +		 * set the PCIE_TEST_PD flag. However, we can also disable the
> +		 * clock which saves some power.
> +		 */
> +		imx_pcie_assert_core_reset(imx_pcie);
> +		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
> +	} else {
> +		imx_pcie_pm_turnoff(imx_pcie);
> +		imx_pcie_stop_link(imx_pcie->pci);
> +		imx_pcie_host_exit(pp);
> +	}
>  
>  	return 0;
>  }
> @@ -1253,14 +1268,32 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>  
> -	ret = imx_pcie_host_init(pp);
> -	if (ret)
> -		return ret;
> -	imx_pcie_msi_save_restore(imx_pcie, false);
> -	dw_pcie_setup_rc(pp);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
> +		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> +		if (ret)
> +			return ret;
> +		ret = imx_pcie_deassert_core_reset(imx_pcie);
> +		if (ret)
> +			return ret;
> +		/**
> +		 * Using PCIE_TEST_PD seems to disable msi and powers down the
> +		 * root complex. This is why we have to setup the rc again and
> +		 * why we have to restore the msi register.

s/msi/MSI/

> +		 */
> +		ret = dw_pcie_setup_rc(&imx_pcie->pci->pp);
> +		if (ret)
> +			return ret;
> +		imx_pcie_msi_save_restore(imx_pcie, false);
> +	} else {
> +		ret = imx_pcie_host_init(pp);
> +		if (ret)
> +			return ret;
> +		imx_pcie_msi_save_restore(imx_pcie, false);
> +		dw_pcie_setup_rc(pp);
>  
> -	if (imx_pcie->link_is_up)
> -		imx_pcie_start_link(imx_pcie->pci);
> +		if (imx_pcie->link_is_up)
> +			imx_pcie_start_link(imx_pcie->pci);
> +	}
>  
>  	return 0;
>  }
> @@ -1485,7 +1518,9 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE,
> +			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.clk_names = imx6q_clks,
> -- 
> 2.43.0
> 

