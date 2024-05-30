Return-Path: <linux-pci+bounces-8081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4858D4E52
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD431C220CD
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88CF17D8AE;
	Thu, 30 May 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF/HR1HP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128D17D8A6;
	Thu, 30 May 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080478; cv=none; b=r6uUuA+uLU73KLnvewF3W7WxtBHJ67+teLR6nFuG9LuC3jaTjNQevTNoXgXWCmk/ad3TXjeDMxvsGeAPiLJt5FVSb+vgND0AQ18ySpPyib4jyqKXJg3zHXqhyb7en88Z3bKdulAozPUjs4OR+bIM9tqTF2IPnzowndz4VDptWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080478; c=relaxed/simple;
	bh=0YtxMgJS9VghyYhRb60rtBUg4WCZN3CLjIawzdARKwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dxn/0KFTCisKJ/U35RVmrjYZjMPXnJ1DS1yAsThUu47wTnUFKm5AHhYfozJW6X8wTXvGJ/qZrrjLdXb+w5gbxN+YsX+MzA9I/2uxD6P/541g2uEKij9DfMz0stuQAj9i/z/fka5Q+uZ7iKKN7Ud6ywHtuqYvJLtT1umTHXQI4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF/HR1HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444A6C2BBFC;
	Thu, 30 May 2024 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717080478;
	bh=0YtxMgJS9VghyYhRb60rtBUg4WCZN3CLjIawzdARKwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MF/HR1HP/m3XZlqOeBpT0r2512CquhGyBGTC3WMFzQQXDQ9ILKP5g1WYBCXOzJGLz
	 +xlqWxQuMFeFA6t2EvaQgTEIv9d6AMccLM9f+zRUwYJXJb+nllidonx2B9hHsK101J
	 4MRuFjEqFe0x+pqGtRb8UIVpK2iOxxfHEJHQxIxmMf3CiWm4P8T1uYZ2vMKrgt0Qor
	 p1npNlYt1jsi5whPMW+O88Bp8xfzdq2LB6QVyVOEEl6VcIiJcK7Q0VAIcE74lRICc0
	 syuxcjn4Bwe4JnvpmdpmBlQ6cwdbUeMHoltLGPJy7OAHjm7jEKm/VVaSWPv8sjSYEM
	 eZSRJq3V9HyOQ==
Date: Thu, 30 May 2024 20:17:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: devi priya <quic_devipriy@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V5 6/6] PCI: qcom: Add support for IPQ9574
Message-ID: <20240530144730.GG2770@thinkpad>
References: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
 <20240512082858.1806694-7-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240512082858.1806694-7-quic_devipriy@quicinc.com>

On Sun, May 12, 2024 at 01:58:58PM +0530, devi priya wrote:
> The IPQ9574 platform has 4 Gen3 PCIe controllers:
> two single-lane and two dual-lane based on SNPS core 5.70a
> 
> The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
> Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
> which reuses all the members of 'ops_2_9_0' except for the post_init
> as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
> and 1_27_0.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V5:
> 	- Rebased on top of the below series which adds support for fetching
> 	  clocks from the device tree
> 	  https://lore.kernel.org/linux-pci/20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org/
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3d2eeff9a876..af36a29c092e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -106,6 +106,7 @@
>  
>  /* PARF_SLV_ADDR_SPACE_SIZE register value */
>  #define SLV_ADDR_SPACE_SZ			0x10000000
> +#define SLV_ADDR_SPACE_SZ_1_27_0		0x08000000

Can you please explain what this value corresponds to? Even though there is an
old value, I didn't get much info earlier on what it is.

- Mani

>  
>  /* PARF_MHI_CLOCK_RESET_CTRL register fields */
>  #define AHB_CLK_EN				BIT(0)
> @@ -1095,16 +1096,13 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>  	return clk_bulk_prepare_enable(res->num_clks, res->clks);
>  }
>  
> -static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +static int qcom_pcie_post_init(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
>  	int i;
>  
> -	writel(SLV_ADDR_SPACE_SZ,
> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> -
>  	val = readl(pcie->parf + PARF_PHY_CTRL);
>  	val &= ~PHY_TEST_PWR_DOWN;
>  	writel(val, pcie->parf + PARF_PHY_CTRL);
> @@ -1144,6 +1142,22 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> +{
> +	writel(SLV_ADDR_SPACE_SZ_1_27_0,
> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	return qcom_pcie_post_init(pcie);
> +}
> +
> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +	writel(SLV_ADDR_SPACE_SZ,
> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	return qcom_pcie_post_init(pcie);
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1297,6 +1311,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> +/* Qcom IP rev.: 1.27.0  Synopsys IP rev.: 5.80a */
> +static const struct qcom_pcie_ops ops_1_27_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_9_0,
> +	.init = qcom_pcie_init_2_9_0,
> +	.post_init = qcom_pcie_post_init_1_27_0,
> +	.deinit = qcom_pcie_deinit_2_9_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  	.ops = &ops_1_0_0,
>  };
> @@ -1334,6 +1357,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>  	.no_l0s = true,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_1_27_0 = {
> +	.ops = &ops_1_27_0,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1603,6 +1630,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

