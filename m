Return-Path: <linux-pci+bounces-20314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C660A1B090
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 07:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E323188641B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0561D90BE;
	Fri, 24 Jan 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYtsc1+C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3E1D63DF;
	Fri, 24 Jan 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737701937; cv=none; b=ktTDbcfQGkgOZuBOiYTRfqfj+0viaINtQi9+bwG9pYrInd2apFHlQq90NJWHB5f0O0LR8GcP8cWbMjVPhcfXN077Fi4XP8+gGhBZITYuwalVK3incYQ21GeB895ueiFWFTWbAeYY/KWsO2Bt7PZ4vbCcFGeG6vPoblvKYekYVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737701937; c=relaxed/simple;
	bh=rPt77Coe5Zulhw136U/oU/5suFRS1l65UL3xb7q2sKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/sH54Nnu3RVcjMZ5raD1XJejkkRZ3A3ft4092kguRzXOBJLWWD9uYGAHuTfYsuoF5FlV8Dc9mdWa+eLffAGuyaVqS+h54kraLzk1UoZruLb2BQIfATcs7yAaPyALKS1e6ZVM8XtORQYFA9oZPAVjI4//nc5SboJSsqTmUS4ic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYtsc1+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE05C4CED2;
	Fri, 24 Jan 2025 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737701937;
	bh=rPt77Coe5Zulhw136U/oU/5suFRS1l65UL3xb7q2sKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYtsc1+CjrhyXgLIpObYL9lZrs4rBJnutVvjXNg3dWdNEq/nEPcV1QdeJleis1L87
	 PJK/gQGgF8N3bLgncRCAcweCJRHgohSwLEJmGaXww5GDbzTfixmAGauLCWoRtdQVLS
	 vqVcdFJmz1JBFmJGmuVB5QHOTNakbrzNOWfCN8PvWVIqX9yfRkRZXn24fXOgvpKyZp
	 0sMlhFf5P7/ecKJ+YMMFkRQf4AJ9FfF0ds/QZS3PmHIqSxpyHtYEIfEBUgSIAQc7Tg
	 KIZU3ohAGHJx4ys8jlfmiqsuByidAKucfNmbj55bH3Sa0HDMocTboiH0zYXvcnHbXK
	 FJxBrobQV102A==
Date: Fri, 24 Jan 2025 12:28:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	mmareddy@quicinc.com,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v3 4/4] PCI: qcom: Enable ECAM feature
Message-ID: <20250124065843.te5p55qgjyina53z@thinkpad>
References: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
 <20250121-enable_ecam-v3-4-cd84d3b2a7ba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121-enable_ecam-v3-4-cd84d3b2a7ba@oss.qualcomm.com>

On Tue, Jan 21, 2025 at 02:32:22PM +0530, Krishna Chaitanya Chundru wrote:
> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> gives us the offset from which ELBI starts. so use this offset and cfg
> win to map these regions instead of doing the ioremap again.
> 
> On root bus, we have only the root port. Any access other than that
> should not go out of the link and should return all F's. Since the iATU
> is configured for the buses which starts after root bus, block the
> transactions starting from function 1 of the root bus to the end of
> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
> outside the link through ECAM blocker through PARF registers.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index dc102d8bd58c..cf94718d3059 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -52,6 +52,7 @@
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>  #define PARF_Q2A_FLUSH				0x1ac
>  #define PARF_LTSSM				0x1b0
> +#define PARF_SLV_DBI_ELBI			0x1b4
>  #define PARF_INT_ALL_STATUS			0x224
>  #define PARF_INT_ALL_CLEAR			0x228
>  #define PARF_INT_ALL_MASK			0x22c
> @@ -61,6 +62,17 @@
>  #define PARF_DBI_BASE_ADDR_V2_HI		0x354
>  #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>  #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
> +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
> +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
> +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
> +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
> +#define PARF_ECAM_BASE				0x380
> +#define PARF_ECAM_BASE_HI			0x384
> +
>  #define PARF_NO_SNOOP_OVERIDE			0x3d4
>  #define PARF_ATU_BASE_ADDR			0x634
>  #define PARF_ATU_BASE_ADDR_HI			0x638
> @@ -84,6 +96,7 @@
>  
>  /* PARF_SYS_CTRL register fields */
>  #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
> +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
>  #define MST_WAKEUP_EN				BIT(13)
>  #define SLV_WAKEUP_EN				BIT(12)
>  #define MSTR_ACLK_CGC_DIS			BIT(10)
> @@ -294,15 +307,60 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
> +static int qcom_pci_config_ecam(struct dw_pcie_rp *pp)
> +{

void qcom_pci_config_ecam()?

> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u64 addr, addr_end;
> +	u32 val;
> +
> +	/* Set the ECAM base */
> +	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);

You can use _relaxed variants in this function.

> +	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
> +
> +	/*
> +	 * The only device on root bus is the Root Port. Any access other than that
> +	 * should not go out of the link and should return all F's. Since the iATU
> +	 * is configured for the buses which starts after root bus, block the transactions
> +	 * starting from function 1 of the root bus to the end of the root bus (i.e from
> +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.

Why can't you impose this limitation with the iATU mapping itself? I mean, why
can't the mapping be limited to 4K to cover only device 00.0? I believe the min
iATU window size is 4K on all platforms.

> +	 */
> +	addr = pci->dbi_phys_addr + SZ_4K;
> +	writel(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
> +	writel(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
> +
> +	writel(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
> +	writel(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
> +
> +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
> +
> +	writel(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
> +	writel(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
> +
> +	writel(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
> +	writel(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
> +
> +	val = readl(pcie->parf + PARF_SYS_CTRL);
> +	val |= PCIE_ECAM_BLOCKER_EN;
> +	writel(val, pcie->parf + PARF_SYS_CTRL);

nit; newline

> +	return 0;
> +}
> +
>  static int qcom_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	int ret;
>  
>  	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
>  		qcom_pcie_common_set_16gt_equalization(pci);
>  		qcom_pcie_common_set_16gt_lane_margining(pci);
>  	}
>  
> +	if (pci->pp.ecam_mode) {
> +		ret = qcom_pci_config_ecam(&pci->pp);
> +		if (ret)
> +			return ret;
> +	}
>  	/* Enable Link Training state machine */
>  	if (pcie->cfg->ops->ltssm_enable)
>  		pcie->cfg->ops->ltssm_enable(pcie);
> @@ -1233,6 +1291,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u16 offset;
>  	int ret;
>  
>  	qcom_ep_reset_assert(pcie);
> @@ -1241,6 +1300,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> +	if (pp->ecam_mode) {
> +		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);
> +		pcie->elbi = pci->dbi_base + offset;

Can't you derive this offset for non-ECAM mode also?

> +	}
> +
>  	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
>  	if (ret)
>  		goto err_deinit;
> @@ -1613,6 +1677,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
>  
> +	pp->bridge = devm_pci_alloc_host_bridge(dev, 0);
> +	if (!pp->bridge) {
> +		ret = -ENOMEM;
> +		goto err_pm_runtime_put;
> +	}
> +
> +	pci->pp.ecam_mode = dw_pcie_ecam_supported(pp);

you should be able to set this in designware-host.c

>  	pcie->pci = pci;
>  
>  	pcie->cfg = pcie_cfg;
> @@ -1629,10 +1700,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> -	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
> -	if (IS_ERR(pcie->elbi)) {
> -		ret = PTR_ERR(pcie->elbi);
> -		goto err_pm_runtime_put;
> +	if (!pp->ecam_mode) {
> +		pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
> +		if (IS_ERR(pcie->elbi)) {
> +			ret = PTR_ERR(pcie->elbi);
> +			goto err_pm_runtime_put;

You can drop this if the ELBI offset can be derived from PARF register on all
platforms.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

