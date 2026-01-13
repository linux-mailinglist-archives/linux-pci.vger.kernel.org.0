Return-Path: <linux-pci+bounces-44620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B9CD19EE2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF5B23038D19
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7363933F9;
	Tue, 13 Jan 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUbW/ctG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE523933F4;
	Tue, 13 Jan 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318064; cv=none; b=PqMNMHdlJc+vr0ShC1zx2+Bdt+lFQspqdBMm2Ol4MFb3FwUWYeacQe4TQO/W9KoWXeH48HS8Jli7tTQco/O0yowf5/ANYQf5sj9Xo5RZlKwK8kET6CKUjovu79cBHNQKKYEdhlzpNKFDHspntxe/JNmHJNlsOTvtZvJUhisrYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318064; c=relaxed/simple;
	bh=YnOpqEglNY3vQ34HlVAtTWoHG1niNCbvODOpEPP4Da0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbSJjv/fpyDVv0G8hwxArzhfMjELiKMhKjHRbxTKhHlrXXiS0Imc3oYuekw1iqUJqQey9pxyOoosY+VgeS4KcErF5n9W94JSArWz7Xzzgqbt2/dyKfV7S2VcJ77GUfasskkXp+7VDoV7bACORZgNEHkQUiWR6vpesfhkc3L5Ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUbW/ctG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E390BC19422;
	Tue, 13 Jan 2026 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318058;
	bh=YnOpqEglNY3vQ34HlVAtTWoHG1niNCbvODOpEPP4Da0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUbW/ctGDpVNHIWSDXuEs4Lg//dBztmnD1lFa1/DswaUBhGMQG8LcNuaWyVh8lSqa
	 bdrX9NbeJiGGjUjpK2fl6RC36mlUcGahyYWHrkY1m2q1xMZ4gnnT6c2IbCC//qp6TV
	 09uxecf2G5d7dFC76MYa7M5MHwou7AYuciyDmbFLuS1ebmNJWJUsDdm654jCu0m4Hh
	 ohp2M0fVGDTiBGN2w+FM7hxCGErdkTrYPp7bsn33nEduJX3zTl9i9QWa3zouJsRUqL
	 rQiinTcLS7VzUANttixMWtyzidyb93Jos0p179GjByaNs3drEjIfBA5lAQoX6nUTDu
	 VHBFvTrD5RRbg==
Date: Tue, 13 Jan 2026 20:57:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 1/2] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Message-ID: <g3yuqj2yyq236x7fzwdfl5s7onvuwd2ot7btadf3qs36vchleb@4kwfwpo4ni36>
References: <20260107024553.3307205-1-hongxing.zhu@nxp.com>
 <20260107024553.3307205-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107024553.3307205-2-hongxing.zhu@nxp.com>

On Wed, Jan 07, 2026 at 10:45:52AM +0800, Richard Zhu wrote:
> Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
> 
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
> 
> The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
> PME_Turn_Off is sent out.
> 
> To support this case, don't poll L2 state and apply a simple delay of
> PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set
> in suspend.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c         |  4 +++
>  .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
>  3 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4668fc9648bf..d84bfcd1079c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
>  	enum imx_pcie_variants variant;
>  	enum dw_pcie_device_mode mode;
>  	u32 flags;
> +	u32 quirk;
>  	int dbi_length;
>  	const char *gpr;
>  	const u32 ltssm_off;
> @@ -1765,6 +1766,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pci->quirk_flag = imx_pcie->drvdata->quirk;
>  	pci->use_parent_dt_ranges = true;
>  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
> @@ -1849,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  		.core_reset = imx6qp_pcie_core_reset,
>  		.ops = &imx_pcie_host_ops,
> +		.quirk = QUIRK_NOL2POLL_IN_PM,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> @@ -1860,6 +1863,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
>  		.core_reset = imx7d_pcie_core_reset,
> +		.quirk = QUIRK_NOL2POLL_IN_PM,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 43d091128ef7..06cbfd9e1f1e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1179,15 +1179,29 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  			return ret;
>  	}
>  
> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> -				val == DW_PCIE_LTSSM_L2_IDLE ||
> -				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		/* Only log message when LTSSM isn't in DETECT or POLL */
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> +		/*
> +		 * Add the QUIRK_NOL2_POLL_IN_PM case to avoid the read hang,
> +		 * when LTSSM is not powered in L2/L3/LDn properly.
> +		 *
> +		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
> +		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
> +		 * transferred to LDn directly. On the LTSSM states poll broken
> +		 * platforms, add a max 10ms delay refer to PCIe r6.0,
> +		 * sec 5.3.3.2.1 PME Synchronization.
> +		 */
> +		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> +	} else {
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +					val == DW_PCIE_LTSSM_L2_IDLE ||
> +					val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			/* Only log message when LTSSM isn't in DETECT or POLL */
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}
>  	}
>  
>  	/*
> @@ -1204,7 +1218,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  
>  	pci->suspended = true;
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 31685951a080..dd760c17bdcc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -305,6 +305,9 @@
>  /* Default eDMA LLP memory size */
>  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
>  
> +#define QUIRK_NOL2POLL_IN_PM		BIT(0)
> +#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
> +

Though I like this quirk idea, I think at this point a simple flag will do the
job.

>  struct dw_pcie;
>  struct dw_pcie_rp;
>  struct dw_pcie_ep;
> @@ -520,6 +523,7 @@ struct dw_pcie {
>  	const struct dw_pcie_ops *ops;
>  	u32			version;
>  	u32			type;
> +	u32			quirk_flag;

You can just add a flag "skip_l23_wait" in dw_pcie_rp as this is a Root Port
behavior.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

