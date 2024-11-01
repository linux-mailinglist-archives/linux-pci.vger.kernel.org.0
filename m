Return-Path: <linux-pci+bounces-15813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3EB9B98B3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 20:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10881F2629C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CB71C7601;
	Fri,  1 Nov 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy+q2VQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58896135A63;
	Fri,  1 Nov 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489654; cv=none; b=q+1bvXs8SB1U9qJwOFcnU9OAS0ik04bOJnQaH62FG44e+HjSVD79yb6Tv2aV/OF2+fO3LcGW5BCIYxu9Gai34u3fyFuK6PLGYEY69YfwW6hBqdw1KQnK1H1UqPVJc80vyH9aJgH3AC5Z4E1FNSXZUUhxI8tYxj3Bn8ScTVW6qWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489654; c=relaxed/simple;
	bh=7e9jDreQwHjgDrpNnSCJNcACMMOlV2ucUiJHzRNtnGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ouioCiCCo/8ak/arvzfweZpf66Ia0s9+JU7EYiH2h3Y7jb+CYLs5Mah6kMNxT6s0NlNl2WjfhGWZDZx61TEn+Xnm7tU24aDQ9h4XVtZj2MAMF58ur99ERN/XBsHwEoxQGO/ZgeVSm0mVJiZohi1DhKus7XrguPhIf2D5VWNmHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy+q2VQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13110C4CECD;
	Fri,  1 Nov 2024 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489654;
	bh=7e9jDreQwHjgDrpNnSCJNcACMMOlV2ucUiJHzRNtnGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gy+q2VQMdeHnjT5y9u5t9/F6PhF4uzgoSRel0mDRxxSyq3QjYHlyR4JkyEpXP8DV3
	 NeeZZkqknM2VXeMV9BBFpQDx5/GPmVVoWetU6spQS9H2CQ3fzgckmHv3TmKRx9CNOF
	 9LamE0J7mmr/CfZm2sXjfEBuujzSZdz7fwU9dP8P/IceaUMELWqXxj6a5Jp2kNdgo1
	 lTV8bFkOtCBbVdt4w5kdTXRqpo2esomrCNQqXTliqOkebr1XfYjhQxMGHIF41TFvlE
	 cFF9mSY87h88i+ZHBUH+zvZzdw5IQllMK89EDpz4QgXnua1Kz00jrJw6m4A26J6BJi
	 Ar+DeHd6YbhrA==
Date: Fri, 1 Nov 2024 14:34:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241101193412.GA1317741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030103250.83640-1-eichest@gmail.com>

On Wed, Oct 30, 2024 at 11:32:45AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The suspend/resume functionality is currently broken on the i.MX6QDL
> platform, as documented in the NXP errata (ERR005723):
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
> 
> This patch addresses the issue by sharing most of the suspend/resume
> sequences used by other i.MX devices, while avoiding modifications to
> critical registers that disrupt the PCIe functionality. It targets the
> same problem as the following downstream commit:
> https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> 
> Unlike the downstream commit, this patch also resets the connected PCIe
> device if possible. Without this reset, certain drivers, such as ath10k
> or iwlwifi, will crash on resume. The device reset is also done by the
> driver on other i.MX platforms, making this patch consistent with
> existing practices.
> 
> Without this patch, suspend/resume will fail on i.MX6QDL devices if a
> PCIe device is connected. Upon resuming, the kernel will hang and
> display an error. Here's an example of the error encountered with the
> ath10k driver:
> ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Richard and Lucas, does this look OK to you?  Since you're listed as
maintainers of pci-imx6.c, I'd like to have your ack before merging
this.

> ---
> Changes in v4:
> - Improve commit message (Bjorn)
> - Fix style issue on comments (Bjorn)
> - s/msi/MSI (Bjorn)
> 
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
> index 808d1f1054173..c8d5c90aa4d45 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,6 +82,11 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
>  #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> +/*
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
> +		/*
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
> +		/*
> +		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
> +		 * root complex. This is why we have to setup the rc again and
> +		 * why we have to restore the MSI register.
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

