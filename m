Return-Path: <linux-pci+bounces-3008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC7846FED
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7A1C25F63
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A313F006;
	Fri,  2 Feb 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg2XxAik"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DF13E233;
	Fri,  2 Feb 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875969; cv=none; b=pKuV1Js+XwokNojqzbr2pjARVDjjedPZCnpWgnU/2RQX5KNiMxQN+cjcrq9cQg/baDElNbMOUCPw1g8NwABW+HGNid2/XnISlKiTZCfLiArioKmyrT0T9ckl1dYNwWNUitKjcddMdTuayPow2GVNg8gCO/OfXorkp4rBbda0nFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875969; c=relaxed/simple;
	bh=oBl1UUByToZvedSOfHD5+3blOO9P8Zfy2wDweeCcE6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol9rx5vs6oCNiquJwonapivsbCQVaZKemGhkqnpzzpjGHS9cj1H0FwkWT6LkAvkvZFxfahdaXsrYVmgej6fmBDe/YDMavPDVdYQOo72Z8yx+9Qi8Abts0lFo3JkJyVDxyNSS5S1TXE+QWxEsLpivsihbCLFEsnrqXxRFLvZ1v20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg2XxAik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39283C433C7;
	Fri,  2 Feb 2024 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706875969;
	bh=oBl1UUByToZvedSOfHD5+3blOO9P8Zfy2wDweeCcE6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zg2XxAikieEuRmr7UqhoU1xvBkC/IXu5I2XpZhA8Otveb340BCQGdiQgakxTCMgGV
	 V/PIYfoGCGjbVHi9S1mUT2HKfdOBjl3YhRI5f80Pe2J60bglkmBq7EKtEmC+0wylUH
	 z4HeMwCUSjcrgmyXPRXTc+ac0Nyf00X4+cfAtlO2eycDw4+WYA7XLjsRc2wPdF+11B
	 I8JWkACTO/PBLi4aVdQOuX3XVXcLVy1w/p4anoB7CSwh8GmeMH9Jb1NOvFTb+qAtvO
	 F/yg8sXh7DohmRYv5B1YmCvB/ot/7A4O+CNmszvIjkRCkK/KRaU3AWICvmWxR4t1kY
	 mbFViCGKqql6g==
Date: Fri, 2 Feb 2024 13:12:41 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v9 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <ZbzcOarorCS1MPRc@lpieralisi>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <20240119171122.3057511-6-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119171122.3057511-6-Frank.Li@nxp.com>

"PCI: imx6: Use "linux,pci-domain" as slot ID"

On Fri, Jan 19, 2024 at 12:11:11PM -0500, Frank Li wrote:
> Avoid use get slot id by compared with register physical address. If there
> are more than 2 slots, compared logic will become complex.
> 
> "linux,pci-domain" already exist at dts since commit:
> 	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).
> 
> So it is safe to remove compare basic address code:
> 	...
> 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> 		imx6_pcie->controller_id = 1;

No it is not unless you magically update all firmware out
there in the field.

> 	...
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v7 to v8
>     - fixed comments
>     - Added Manivannan Sadhasivam's review tag
>     Change from v5 to v7
>     - none
>     Change from v3 to v4
>     - remove compare basic address logic
>     Change from v2 to v3
>     - none
>     Change from v1 to v2
>     - fix of_get_pci_domain_nr return value check logic
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index eda6bc6ef80ee..773411d20329f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -33,6 +33,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -40,7 +41,6 @@
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
>  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
>  
>  #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
>  
> @@ -1279,13 +1279,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  					     "Failed to get PCIEPHY reset control\n");
>  	}
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX7D:
> -		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> -			imx6_pcie->controller_id = 1;
> -	default:
> -		break;
> -	}
> +	/* Using linux,pci-domain as PCI slot id */
> +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> +	/*
> +	 * If there are no "linux,pci-domain" property specified in DT, then assume only one
> +	 * controller is available.
> +	 */
> +	if (imx6_pcie->controller_id == -EINVAL)
> +		imx6_pcie->controller_id = 0;

See above, this breaks compatibility with old DTs (and -EINVAL is not
the only error code you should handle).

Lorenzo

> +	else if (imx6_pcie->controller_id < 0)
> +		return dev_err_probe(dev, imx6_pcie->controller_id,
> +				     "linux,pci-domain have wrong value\n");
>  
>  	/* Grab turnoff reset */
>  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> -- 
> 2.34.1
> 

