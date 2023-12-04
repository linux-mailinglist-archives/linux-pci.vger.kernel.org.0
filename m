Return-Path: <linux-pci+bounces-406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DAB803139
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 12:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EB71F20D3C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F97224DB;
	Mon,  4 Dec 2023 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKbyNvIu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41DCC
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 03:04:01 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a42549764so29329416d6.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Dec 2023 03:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701687840; x=1702292640; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swbDV6YHNPw6cNT5rrUA42erB6Nky2n0v5A5UtdMoss=;
        b=zKbyNvIu8HvlX7TQC0jmPB6fQvT/bYlEw6W5IWUBpGRNgEKx0jdzhpfuDx25lYUM5p
         GQkUxJdSbbZxrkbmwFB5QH6fUaAC+TFF2RwKdchJnE+Vn/Y5B91hrHIJZLm/GTuB+vHf
         r8qty9rO8UoacOTQQ5hg/9ND8p2zJuZLo6Z+m+q9N2KrKl3K9c/SmIiPEIlhNnbB7/mD
         uTiOXQLL7BNsuAmPsKjognfYLHfewFY0pCUDAzl01IpHda1gzyiqLDKN8TeeNZs4iAHE
         NYcjxSRs/Yn4t1iMYQ6esKxnS/MxQXD6JYqVvzkKnxTL08gX9QtTD97VpC+5MGrrBFkW
         TP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687840; x=1702292640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swbDV6YHNPw6cNT5rrUA42erB6Nky2n0v5A5UtdMoss=;
        b=uDZ2yBouao1iwu0U5UFgiVjX9ueY3/7kyk/IMOALmgiakGuJ5DO4eowLbwl/vXI+FL
         NFggxsKFJ8XLDXiGu3RIbTZQKkX3l9NV9AjGE/f+lkUjYlLvT3zbwarGQ5iZ6BwHVFgx
         Q2WCFALgeM8AP2ykHQYpLDGF0mbpwaSUniBAsQokBcrWZ4ByqqCsFvhi9mlCxMaPuGbY
         PAjDdMeilw0V6AbBOf9PzYQvmd4mfSF+Ly+tIZ/qDtYAjJJVLwp/uSbnXLhyYxQcxI0e
         QoVILmpqDcTBj27+Lj3sdit1seqLeWTXEh0vvFAdWkbq1Ia7ir4rX+FhgFzsNkmNKQwQ
         mhVA==
X-Gm-Message-State: AOJu0Yx2JTSgrMA4fGO+3CDNBWRZGkSTguAQYLpWgwx0ynuWxaZdkxPV
	8/QLnLhmpL1j140CS3DTZpCU
X-Google-Smtp-Source: AGHT+IEgXLrF2rPbXYX2KHUUrMiPsTUsWl8BAdec3IVSKfGCgd1GC+GpFcUTXWfC1rG8OjStFT63Sg==
X-Received: by 2002:a05:6214:847:b0:67a:b372:721c with SMTP id dg7-20020a056214084700b0067ab372721cmr3864545qvb.34.1701687840504;
        Mon, 04 Dec 2023 03:04:00 -0800 (PST)
Received: from thinkpad ([117.213.101.240])
        by smtp.gmail.com with ESMTPSA id z6-20020a0cf006000000b0067a17c8696esm2572644qvk.82.2023.12.04.03.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 03:04:00 -0800 (PST)
Date: Mon, 4 Dec 2023 16:33:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
	robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v5 4/4] PCI: layerscape: Add suspend/resume for ls1043a
Message-ID: <20231204110350.GD35383@thinkpad>
References: <20231201161712.1645987-1-Frank.Li@nxp.com>
 <20231201161712.1645987-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201161712.1645987-5-Frank.Li@nxp.com>

On Fri, Dec 01, 2023 at 11:17:12AM -0500, Frank Li wrote:
> Add suspend/resume support for Layerscape LS1043a.
> 
> In the suspend path, PME_Turn_Off message is sent to the endpoint to
> transition the link to L2/L3_Ready state. In this SoC, there is no way to
> check if the controller has received the PME_To_Ack from the endpoint or
> not. So to be on the safer side, the driver just waits for
> PCIE_PME_TO_L2_TIMEOUT_US before asserting the SoC specific PMXMTTURNOFF
> bit to complete the PME_Turn_Off handshake. Then the link would enter L2/L3
> state depending on the VAUX supply.
> 
> In the resume path, the link is brought back from L2 to L0 by doing a
> software reset.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Change from v4 to v5
>     - update commit message
>     - use comments
>     /* Reset the PEX wrapper to bring the link out of L2 */
>     
>     Change from v3 to v4
>     - Call scfg_pcie_send_turnoff_msg() shared with ls1021a
>     - update commit message
>     
>     Change from v2 to v3
>     - Remove ls_pcie_lut_readl(writel) function
>     
>     Change from v1 to v2
>     - Update subject 'a' to 'A'
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 63 ++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index a9151e98fde6f..715365e91f8ef 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -41,6 +41,15 @@
>  #define SCFG_PEXSFTRSTCR	0x190
>  #define PEXSR(idx)		BIT(idx)
>  
> +/* LS1043A PEX PME control register */
> +#define SCFG_PEXPMECR		0x144
> +#define PEXPME(idx)		BIT(31 - (idx) * 4)
> +
> +/* LS1043A PEX LUT debug register */
> +#define LS_PCIE_LDBG	0x7fc
> +#define LDBG_SR		BIT(30)
> +#define LDBG_WE		BIT(31)
> +
>  #define PCIE_IATU_NUM		6
>  
>  struct ls_pcie_drvdata {
> @@ -224,6 +233,45 @@ static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>  	return scfg_pcie_exit_from_l2(pcie->scfg, SCFG_PEXSFTRSTCR, PEXSR(pcie->index));
>  }
>  
> +static void ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +
> +	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR, PEXPME(pcie->index));
> +}
> +
> +static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	u32 val;
> +
> +	/*
> +	 * Reset the PEX wrapper to bring the link out of L2.
> +	 * LDBG_WE: allows the user to have write access to the PEXDBG[SR] for both setting and
> +	 *	    clearing the soft reset on the PEX module.
> +	 * LDBG_SR: When SR is set to 1, the PEX module enters soft reset.
> +	 */
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> +	val |= LDBG_WE;
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> +	val |= LDBG_SR;
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> +	val &= ~LDBG_SR;
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> +	val &= ~LDBG_WE;
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> +
> +	return 0;
> +}
> +
>  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
>  	.host_init = ls_pcie_host_init,
>  	.pme_turn_off = ls_pcie_send_turnoff_msg,
> @@ -241,6 +289,19 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
>  	.exit_from_l2 = ls1021a_pcie_exit_from_l2,
>  };
>  
> +static const struct dw_pcie_host_ops ls1043a_pcie_host_ops = {
> +	.host_init = ls_pcie_host_init,
> +	.pme_turn_off = ls1043a_pcie_send_turnoff_msg,
> +};
> +
> +static const struct ls_pcie_drvdata ls1043a_drvdata = {
> +	.pf_lut_off = 0x10000,
> +	.pm_support = true,
> +	.scfg_support = true,
> +	.ops = &ls1043a_pcie_host_ops,
> +	.exit_from_l2 = ls1043a_pcie_exit_from_l2,
> +};
> +
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
>  	.pf_lut_off = 0xc0000,
>  	.pm_support = true,
> @@ -252,7 +313,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
>  	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
>  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
>  	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
> -	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1021a_drvdata },
> +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
>  	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
>  	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
>  	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

