Return-Path: <linux-pci+bounces-34715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F27B35456
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD39686BF4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 06:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2B2F5316;
	Tue, 26 Aug 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srk/9A0N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7512295DA6;
	Tue, 26 Aug 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189199; cv=none; b=lZ92VMN+idkcIq3b4FKs2+K0/4GWPnnFlUdDv625Bv9ogerQaITap4ru6rLCWAdS+4JKEjkOEGuiRg7hW9ERVs4nPLe00ZZyOlPmDIpmO4M9OhJDofbewkzFhmUib1ow/nR8FeCGkGkyLiCeLiftduXRSFRro11P2DCnx3/mb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189199; c=relaxed/simple;
	bh=DDG5Rsbax/UMy9XACIWAoumnDWbU7fr4l/OL8Vi1WqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8r5nvn/HUCGtfsleLtys8jk8ljYdb2idpYK+7fX2t4VaaY+3f+Wq/EnNS9qaosdYkgKxd8vUQKowyeJFVNq+LKCSU4fFl/5VJqvuObbPkpjgtWNqqNJ3BOkdUotzujId+8eUUWsK8LrQ3JllPWLn85FxVaHv+HzmEA5bV7jZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srk/9A0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDA8C4CEF1;
	Tue, 26 Aug 2025 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756189199;
	bh=DDG5Rsbax/UMy9XACIWAoumnDWbU7fr4l/OL8Vi1WqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srk/9A0Nsgxrs/FV1BMlezxJc/Q9zPLb6YnLDAWYecPcojnL68RqIxAVVDqhkqQAh
	 z4RxA1oYArTcOsOXBj/7eSQoiftwk++oGA+nUNkrWJe5yTPEMvONQxIeBsZAWceC8e
	 EYiqeR077U4K0Q2Rlyf9povA60nU7ZA7upT1BWdiseOc8Q/MGcJQfLe2UnwwM4npMq
	 kDVGt6Z+B64W4HcP9ZYxjRs3QRECl34Y7hj4ToyKgM/WHCrbH3mMCmjCIOU0NVje0E
	 bPBGtgA6PAAF31jwTjEySxCD8nEd1EmEFoiDzTDaP7eA+SQK/zkZpkShDPbOYl+gIi
	 bdE0a8onVtg0w==
Date: Tue, 26 Aug 2025 11:49:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com, 
	qiang.yu@oss.qualcomm.com, Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v3 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Message-ID: <fqtq3lbdnfkzngfym3k53jkrhp4addqvltvrfh35hhiiyf4qqw@2vdhide3lux5>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
 <20250825-glymur_pcie5-v3-4-5c1d1730c16f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825-glymur_pcie5-v3-4-5c1d1730c16f@oss.qualcomm.com>

On Mon, Aug 25, 2025 at 11:01:50PM GMT, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..011687e6191e7a496b56cd85a149b10f7f00a749 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -93,6 +93,12 @@ static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
>  	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
>  };
>  
> +static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_START_CTRL]		= QPHY_V8_50_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V8_50_PCS_POWER_DOWN_CONTROL,
> +};
> +
>  static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>  	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
> @@ -2963,6 +2969,7 @@ struct qmp_pcie_offsets {
>  	u16 rx2;
>  	u16 txz;
>  	u16 rxz;
> +	u16 txrxz;
>  	u16 ln_shrd;
>  };
>  
> @@ -3229,6 +3236,12 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
>  	.ln_shrd	= 0x8000,
>  };
>  
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
> +	.serdes     = 0x8000,
> +	.pcs        = 0x9000,
> +	.txrxz      = 0xd000,
> +};
> +
>  static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>  	.lanes			= 1,
>  
> @@ -4258,6 +4271,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
>  	.phy_status             = PHYSTATUS_4_20,
>  };
>  
> +static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
> +	.lanes = 4,
> +
> +	.offsets        = &qmp_pcie_offsets_v8_50,
> +
> +	.reset_list     = sdm845_pciephy_reset_l,
> +	.num_resets     = ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list      = qmp_phy_vreg_l,
> +	.num_vregs      = ARRAY_SIZE(qmp_phy_vreg_l),
> +
> +	.regs           = pciephy_v8_50_regs_layout,
> +
> +	.pwrdn_ctrl     = SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status     = PHYSTATUS_4_20,
> +};
> +
>  static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -5004,6 +5033,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	{
> +		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
> +		.data = &glymur_qmp_gen5x4_pciephy_cfg,
> +	}, {
>  		.compatible = "qcom,ipq6018-qmp-pcie-phy",
>  		.data = &ipq6018_pciephy_cfg,
>  	}, {
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

