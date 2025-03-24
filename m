Return-Path: <linux-pci+bounces-24524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF3BA6DACC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212A2163238
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF932EB1D;
	Mon, 24 Mar 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJLHb1r3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3961ADC86;
	Mon, 24 Mar 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821552; cv=none; b=UGSjZxf8hu/tRpN9ZnaoUOYDHtep2kQxWGJrdT4c8usNOzHGh9q3xRkK8XDnp/rnJms5thVoxF6MkLqe4TKW8b/sMekV2B1yNNAqu85Gfki8Jx/f7hbu5t0I1G/VNCfRnY00/QOLgnGfFFtJN084VMJDPqabDBrv3aVWz6+QCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821552; c=relaxed/simple;
	bh=vJfBDHCxyVQns/5+3y7fqVp7wz/PXkviSSt+13f9mwU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FE//w+G6oxt8eVNX6SCjJefW3d/+ziZKJzlrD7J1MHEXeL9RYDosWiGJMroKYMSYdo70sz8xe4J1jp8zTaOLxLRFzTrfqq7dy/j5nZMllpenV8I2YrerE7jKn5nDnC8sC/uC6VjNjd8X0/BBHev30JsUAa3X6T7RWazoqEmQWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJLHb1r3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742821550; x=1774357550;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vJfBDHCxyVQns/5+3y7fqVp7wz/PXkviSSt+13f9mwU=;
  b=iJLHb1r3CX7af4jiJIttCJi5U4789injaBoYVTsWfDJaBco7XJVhf19V
   E40aK3TW/mG3gNSWA2htf4B6wS6Z6YmBJpheJzOHh8wmE3PCNlTnSyqH3
   DhU+ZIyaExH8NcVYsVY4kUjqZ9oYZg+00sggEvYbJP8qv5qLSTAU1B8H5
   Gk8wFxqXhLKHxMqn1nE5fBRZWBBb5uXNGPFfsfDtMlYdB7caLAQ+io02m
   6UEzh0ods99+RLlq16U+WiHVwSLAr5xJ6t9gQkijVf/1WVGkO23tRX6SF
   8fuXoekY4QYo2XE6rL9jh0E0JBcN5pj9ylh4bfWgEe9y+De1i2oiTOwSA
   w==;
X-CSE-ConnectionGUID: c3ocgGUeS1m9kT6l2mxUIA==
X-CSE-MsgGUID: nXWxjN2kT4WTLs1s3XvCMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="54229803"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="54229803"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:05:50 -0700
X-CSE-ConnectionGUID: hPJMrlbWRneuwdv8CFBM3g==
X-CSE-MsgGUID: mLbWTvKnSjK5/IiIFlZfFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="129107999"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.251])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:05:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Mar 2025 15:05:41 +0200 (EET)
To: Richard Zhu <hongxing.zhu@nxp.com>
cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
    kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, 
    bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
    kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] PCI: imx6: Start link directly when workaround
 is not required
In-Reply-To: <20250324062647.1891896-2-hongxing.zhu@nxp.com>
Message-ID: <73205114-bdb5-2995-e00a-7df7046ea91d@linux.intel.com>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com> <20250324062647.1891896-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Mar 2025, Richard Zhu wrote:

> The current link setup procedure is more like one workaround to detect
> the device behind PCIe switches on some i.MX6 platforms.
> 
> To describe more accurately, change the flag name from
> IMX_PCIE_FLAG_IMX_SPEED_CHANGE to IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND.
> 
> Then, start PCIe link directly when this flag is not set on i.MX7 or
> later paltforms to simple and speed up link training.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++----------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c1f7904e3600..aa5c3f235995 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -91,7 +91,7 @@ enum imx_pcie_variants {
>  };
>  
>  #define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
> -#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
> +#define IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND	BIT(1)

WORDaround ?? :-)

-- 
 i.

>  #define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
>  #define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
>  #define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> @@ -860,6 +860,12 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	u32 tmp;
>  	int ret;
>  
> +	if (!(imx_pcie->drvdata->flags &
> +	    IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND)) {
> +		imx_pcie_ltssm_enable(dev);
> +		return 0;
> +	}
> +
>  	/*
>  	 * Force Gen1 operation when starting the link.  In case the link is
>  	 * started in Gen2 mode, there is a possibility the devices on the
> @@ -896,22 +902,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  
> -		if (imx_pcie->drvdata->flags &
> -		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
> -
> -			/*
> -			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
> -			 * from i.MX6 family when no link speed transition
> -			 * occurs and we go Gen1 -> yep, Gen1. The difference
> -			 * is that, in such case, it will not be cleared by HW
> -			 * which will cause the following code to report false
> -			 * failure.
> -			 */
> -			ret = imx_pcie_wait_for_speed_change(imx_pcie);
> -			if (ret) {
> -				dev_err(dev, "Failed to bring link up!\n");
> -				goto err_reset_phy;
> -			}
> +		ret = imx_pcie_wait_for_speed_change(imx_pcie);
> +		if (ret) {
> +			dev_err(dev, "Failed to bring link up!\n");
> +			goto err_reset_phy;
>  		}
>  
>  		/* Make sure link training is finished as well! */
> @@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND |
>  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
> @@ -1681,7 +1675,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
> @@ -1696,7 +1690,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORDAROUND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> 

