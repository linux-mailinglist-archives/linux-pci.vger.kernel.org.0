Return-Path: <linux-pci+bounces-28187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E4ABF031
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8371D1890CFA
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC4253940;
	Wed, 21 May 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzZiJuhe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E423D2A3;
	Wed, 21 May 2025 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820447; cv=none; b=O09L1GGlMQK3PypaIaRr7imIWBvheoRsAWd+vMpchj3NadbbLhG9FYLMvQ96BL2Bfx2G8RjIkEWnc5b1YSxGQ3PIrFQMU2vYIKdtaMhLtatcNUPcFGYeZyoFFU8wOkptmBigDCUS1UU/CnyiCogsGRRhbEybRfQMiFjo7unf0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820447; c=relaxed/simple;
	bh=yhP6RYW9dqB8JMXo88zjJmunfH6pOCZWTpDZQbfq8nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/Obb3UBuSlQ1A3q1R2ljVWQ0z+Qp/RAAmMpfxn8q+MAnOFBGgVbqXTUzyDlVl5KGLEefk6HZhvdT9FdHlT1GnZ/zk6qOoEPr0zwLblVZ959sEIwmN1mvNq1A0UEC3mdRDTHDvfvRyK/8cT19s5DCVPSktnUCcVVTh9mcCnsmuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzZiJuhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F64AC4CEE4;
	Wed, 21 May 2025 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747820446;
	bh=yhP6RYW9dqB8JMXo88zjJmunfH6pOCZWTpDZQbfq8nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzZiJuhedKMD6D/oNExLGoyRWAc0fD1zTIF7Ogb5etlZmYfnpEM3EoGpygsTuCDWe
	 UhXKwssazdkQ+nX8RYpNE2xQuu56iYGEpqIi74apeZvkZhw8z84Y1IajCq7+QdvD5D
	 ka/IKOfwwdW2bldAIODOUciwgk4jemCongSEdL8ocE4pICu9pM+9jDOZ4Wotp5F2G+
	 OrTdAVw4CJAGTN0IpDnLYmqSs4zQ4M+RucMOtEPsCIz8Zh8Ivc/ALf7+BAkXBX1Os6
	 5gHrC4sSU55AZQNS3VUPhT9zBmUzMMk4E+GevJz5ky/AntM+46ualdzrCiubtKZIOf
	 lG81rsCJrUeWA==
Date: Wed, 21 May 2025 11:40:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, 
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com
Subject: Re: [PATCH 08/10] phy: exynos: Add PCIe PHY support for FSD SoC
Message-ID: <20250521-certain-quoll-from-vega-11885b@kuoka>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193256epcas5p442e9549fd8fd810522f960df74c22e34@epcas5p4.samsung.com>
 <20250518193152.63476-9-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-9-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:50AM GMT, Shradha Todi wrote:
> Add PCIe PHY support for Tesla FSD SoC.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/phy/samsung/phy-exynos-pcie.c | 357 +++++++++++++++++++++++++-
>  1 file changed, 356 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
> index 53c9230c2907..0e4c00c1121e 100644
> --- a/drivers/phy/samsung/phy-exynos-pcie.c
> +++ b/drivers/phy/samsung/phy-exynos-pcie.c
> @@ -34,11 +34,121 @@
>  /* PMU PCIE PHY isolation control */
>  #define EXYNOS5433_PMU_PCIE_PHY_OFFSET		0x730
>  
> +/* FSD: PCIe PHY common registers */
> +#define FSD_PCIE_PHY_TRSV_CMN_REG03	0x000c
> +#define FSD_PCIE_PHY_TRSV_CMN_REG01E	0x0078
> +#define FSD_PCIE_PHY_TRSV_CMN_REG02D	0x00b4
> +#define FSD_PCIE_PHY_TRSV_CMN_REG031	0x00c4
> +#define FSD_PCIE_PHY_TRSV_CMN_REG036	0x00d8
> +#define FSD_PCIE_PHY_TRSV_CMN_REG05F	0x017c
> +#define FSD_PCIE_PHY_TRSV_CMN_REG060	0x0180
> +#define FSD_PCIE_PHY_TRSV_CMN_REG062	0x0188
> +#define FSD_PCIE_PHY_TRSV_CMN_REG061	0x0184
> +#define FSD_PCIE_PHY_AGG_BIF_RESET	0x0200
> +#define FSD_PCIE_PHY_AGG_BIF_CLOCK	0x0208
> +#define FSD_PCIE_PHY_CMN_RESET		0x0228
> +
> +/* FSD: PCIe PHY lane registers */
> +#define FSD_PCIE_PHY_LANE_OFFSET	0x400
> +#define FSD_PCIE_PHY_TRSV_REG001_LN_N	0x404
> +#define FSD_PCIE_PHY_TRSV_REG002_LN_N	0x408
> +#define FSD_PCIE_PHY_TRSV_REG005_LN_N	0x414
> +#define FSD_PCIE_PHY_TRSV_REG006_LN_N	0x418
> +#define FSD_PCIE_PHY_TRSV_REG007_LN_N	0x41c
> +#define FSD_PCIE_PHY_TRSV_REG009_LN_N	0x424
> +#define FSD_PCIE_PHY_TRSV_REG00A_LN_N	0x428
> +#define FSD_PCIE_PHY_TRSV_REG00C_LN_N	0x430
> +#define FSD_PCIE_PHY_TRSV_REG012_LN_N	0x448
> +#define FSD_PCIE_PHY_TRSV_REG013_LN_N	0x44c
> +#define FSD_PCIE_PHY_TRSV_REG014_LN_N	0x450
> +#define FSD_PCIE_PHY_TRSV_REG015_LN_N	0x454
> +#define FSD_PCIE_PHY_TRSV_REG016_LN_N	0x458
> +#define FSD_PCIE_PHY_TRSV_REG018_LN_N	0x460
> +#define FSD_PCIE_PHY_TRSV_REG020_LN_N	0x480
> +#define FSD_PCIE_PHY_TRSV_REG026_LN_N	0x498
> +#define FSD_PCIE_PHY_TRSV_REG029_LN_N	0x4a4
> +#define FSD_PCIE_PHY_TRSV_REG031_LN_N	0x4c4
> +#define FSD_PCIE_PHY_TRSV_REG036_LN_N	0x4d8
> +#define FSD_PCIE_PHY_TRSV_REG039_LN_N	0x4e4
> +#define FSD_PCIE_PHY_TRSV_REG03B_LN_N	0x4ec
> +#define FSD_PCIE_PHY_TRSV_REG03C_LN_N	0x4f0
> +#define FSD_PCIE_PHY_TRSV_REG03E_LN_N	0x4f8
> +#define FSD_PCIE_PHY_TRSV_REG03F_LN_N	0x4fc
> +#define FSD_PCIE_PHY_TRSV_REG043_LN_N	0x50c
> +#define FSD_PCIE_PHY_TRSV_REG044_LN_N	0x510
> +#define FSD_PCIE_PHY_TRSV_REG046_LN_N	0x518
> +#define FSD_PCIE_PHY_TRSV_REG048_LN_N	0x520
> +#define FSD_PCIE_PHY_TRSV_REG049_LN_N	0x524
> +#define FSD_PCIE_PHY_TRSV_REG04E_LN_N	0x538
> +#define FSD_PCIE_PHY_TRSV_REG052_LN_N	0x548
> +#define FSD_PCIE_PHY_TRSV_REG068_LN_N	0x5a0
> +#define FSD_PCIE_PHY_TRSV_REG069_LN_N	0x5a4
> +#define FSD_PCIE_PHY_TRSV_REG06A_LN_N	0x5a8
> +#define FSD_PCIE_PHY_TRSV_REG06B_LN_N	0x5ac
> +#define FSD_PCIE_PHY_TRSV_REG07B_LN_N	0x5ec
> +#define FSD_PCIE_PHY_TRSV_REG083_LN_N	0x60c
> +#define FSD_PCIE_PHY_TRSV_REG084_LN_N	0x610
> +#define FSD_PCIE_PHY_TRSV_REG086_LN_N	0x618
> +#define FSD_PCIE_PHY_TRSV_REG087_LN_N	0x61c
> +#define FSD_PCIE_PHY_TRSV_REG08B_LN_N	0x62c
> +#define FSD_PCIE_PHY_TRSV_REG09C_LN_N	0x670
> +#define FSD_PCIE_PHY_TRSV_REG09D_LN_N	0x674
> +#define FSD_PCIE_PHY_TRSV_REG09E_LN_N	0x678
> +#define FSD_PCIE_PHY_TRSV_REG09F_LN_N	0x67c
> +#define FSD_PCIE_PHY_TRSV_REG0A2_LN_N	0x688
> +#define FSD_PCIE_PHY_TRSV_REG0A4_LN_N	0x690
> +#define FSD_PCIE_PHY_TRSV_REG0CE_LN_N	0x738
> +#define FSD_PCIE_PHY_TRSV_REG0FC_LN_N	0x7f0
> +#define FSD_PCIE_PHY_TRSV_REG0FD_LN_N	0x7f4
> +#define FSD_PCIE_PHY_TRSV_REG0FE_LN_N	0x7f8
> +#define FSD_PCIE_PHY_TRSV_REG0CE_LN_1	0xb38
> +#define FSD_PCIE_PHY_TRSV_REG0CE_LN_2	0xf38
> +#define FSD_PCIE_PHY_TRSV_REG0CE_LN_3	0x1338
> +
> +/* FSD: PCIe PCS registers */
> +#define FSD_PCIE_PCS_BRF_0		0x0004
> +#define FSD_PCIE_PCS_BRF_1		0x0804
> +#define FSD_PCIE_PCS_CLK		0x0180
> +
> +/* FSD: PCIe SYSREG registers */
> +#define FSD_PCIE_SYSREG_PHY_0_CON_MASK			0x3ff
> +#define FSD_PCIE_SYSREG_PHY_0_CON			0x042C
> +#define FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK		0x3
> +#define FSD_PCIE_SYSREG_PHY_0_REF_SEL			(0x2 << 0)
> +#define FSD_PCIE_SYSREG_PHY_0_SSC_EN_MASK		0x8
> +#define FSD_PCIE_SYSREG_PHY_0_SSC_EN			BIT(3)
> +#define FSD_PCIE_SYSREG_PHY_0_AUX_EN_MASK		0x10
> +#define FSD_PCIE_SYSREG_PHY_0_AUX_EN			BIT(4)
> +#define FSD_PCIE_SYSREG_PHY_0_CMN_RSTN_MASK		0x100
> +#define FSD_PCIE_SYSREG_PHY_0_CMN_RSTN			BIT(8)
> +#define FSD_PCIE_SYSREG_PHY_0_INIT_RSTN_MASK		0x200
> +#define FSD_PCIE_SYSREG_PHY_0_INIT_RSTN			BIT(9)
> +
> +#define FSD_PCIE_SYSREG_PHY_1_CON_MASK			0x1ff
> +#define FSD_PCIE_SYSREG_PHY_1_CON			0x0500
> +#define FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK		0x30
> +#define FSD_PCIE_SYSREG_PHY_1_REF_SEL			(0x2 << 4)
> +#define FSD_PCIE_SYSREG_PHY_1_SSC_EN_MASK		0x80
> +#define FSD_PCIE_SYSREG_PHY_1_SSC_EN			BIT(7)
> +#define FSD_PCIE_SYSREG_PHY_1_AUX_EN_MASK		0x1
> +#define FSD_PCIE_SYSREG_PHY_1_AUX_EN			BIT(0)
> +#define FSD_PCIE_SYSREG_PHY_1_CMN_RSTN_MASK		0x2
> +#define FSD_PCIE_SYSREG_PHY_1_CMN_RSTN			BIT(1)
> +#define FSD_PCIE_SYSREG_PHY_1_INIT_RSTN_MASK		0x8
> +#define FSD_PCIE_SYSREG_PHY_1_INIT_RSTN			BIT(3)
> +
>  /* For Exynos pcie phy */
>  struct exynos_pcie_phy {
>  	void __iomem *base;
> +	void __iomem *pcs_base;
>  	struct regmap *pmureg;
>  	struct regmap *fsysreg;
> +	int phy_id;
> +	const struct samsung_drv_data *drv_data;
> +};
> +
> +struct samsung_drv_data {
> +	const struct phy_ops *phy_ops;
>  };
>  
>  static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32 offset)
> @@ -133,9 +243,244 @@ static const struct phy_ops exynos5433_phy_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +struct fsd_pcie_phy_pdata {
> +	u32 phy_con_mask;
> +	u32 phy_con;
> +	u32 phy_ref_sel_mask;
> +	u32 phy_ref_sel;
> +	u32 phy_ssc_en_mask;
> +	u32 phy_ssc_en;
> +	u32 phy_aux_en_mask;
> +	u32 phy_aux_en;
> +	u32 phy_cmn_rstn_mask;
> +	u32 phy_cmn_rstn;
> +	u32 phy_init_rstn_mask;
> +	u32 phy_init_rstn;
> +	u32 num_lanes;
> +	u32 lane_offset;
> +};
> +
> +struct fsd_pcie_phy_pdata fsd_phy_con[] = {
> +	{

Why this is global and RW?

> +	.phy_con		= FSD_PCIE_SYSREG_PHY_0_CON,
> +	.phy_con_mask		= FSD_PCIE_SYSREG_PHY_0_CON_MASK,
> +	.phy_ref_sel_mask	= FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK,
> +	.phy_ref_sel		= FSD_PCIE_SYSREG_PHY_0_REF_SEL,
> +	.phy_ssc_en_mask	= FSD_PCIE_SYSREG_PHY_0_SSC_EN_MASK,
> +	.phy_ssc_en		= FSD_PCIE_SYSREG_PHY_0_SSC_EN,
> +	.phy_aux_en_mask	= FSD_PCIE_SYSREG_PHY_0_AUX_EN_MASK,
> +	.phy_aux_en		= FSD_PCIE_SYSREG_PHY_0_AUX_EN,
> +	.phy_cmn_rstn_mask	= FSD_PCIE_SYSREG_PHY_0_CMN_RSTN_MASK,
> +	.phy_cmn_rstn		= FSD_PCIE_SYSREG_PHY_0_CMN_RSTN,
> +	.phy_init_rstn_mask	= FSD_PCIE_SYSREG_PHY_0_INIT_RSTN_MASK,
> +	.phy_init_rstn		= FSD_PCIE_SYSREG_PHY_0_INIT_RSTN,
> +	.num_lanes		= 0x4,
> +	.lane_offset		= FSD_PCIE_PHY_LANE_OFFSET,
> +	},
> +	{
> +	.phy_con		= FSD_PCIE_SYSREG_PHY_1_CON,
> +	.phy_con_mask		= FSD_PCIE_SYSREG_PHY_1_CON_MASK,
> +	.phy_ref_sel_mask	= FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK,
> +	.phy_ref_sel		= FSD_PCIE_SYSREG_PHY_1_REF_SEL,
> +	.phy_ssc_en_mask	= FSD_PCIE_SYSREG_PHY_1_SSC_EN_MASK,
> +	.phy_ssc_en		= FSD_PCIE_SYSREG_PHY_1_SSC_EN,
> +	.phy_aux_en_mask	= FSD_PCIE_SYSREG_PHY_1_AUX_EN_MASK,
> +	.phy_aux_en		= FSD_PCIE_SYSREG_PHY_1_AUX_EN,
> +	.phy_cmn_rstn_mask	= FSD_PCIE_SYSREG_PHY_1_CMN_RSTN_MASK,
> +	.phy_cmn_rstn		= FSD_PCIE_SYSREG_PHY_1_CMN_RSTN,
> +	.phy_init_rstn_mask	= FSD_PCIE_SYSREG_PHY_1_INIT_RSTN_MASK,
> +	.phy_init_rstn		= FSD_PCIE_SYSREG_PHY_1_INIT_RSTN,
> +	.num_lanes		= 0x4,
> +	.lane_offset		= FSD_PCIE_PHY_LANE_OFFSET,
> +	},
> +	{ },
> +};
> +
> +struct fsd_pcie_phy_setting {
> +	u32 addr;
> +	u32 val;
> +	bool is_cmn_reg;
> +};
> +
> +struct fsd_pcie_phy_setting fsd_pcie_phy0_setting[] = {

No. This is poor coding, please do first extensive internal reviews.

Please run standard kernel tools for static analysis, like coccinelle,
smatch and sparse, and fix reported warnings. Also please check for
warnings when building with W=1 for gcc and clang. Most of these
commands (checks or W=1 build) can build specific targets, like some
directory, to narrow the scope to only your code. The code here looks
like it needs a fix. Feel free to get in touch if the warning is not
clear.

...

> @@ -146,11 +491,18 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
>  	struct exynos_pcie_phy *exynos_phy;
>  	struct phy *generic_phy;
>  	struct phy_provider *phy_provider;
> +	const struct samsung_drv_data *drv_data;
> +
> +	drv_data = of_device_get_match_data(dev);
> +	if (!drv_data)
> +		return -ENODEV;
>  
>  	exynos_phy = devm_kzalloc(dev, sizeof(*exynos_phy), GFP_KERNEL);
>  	if (!exynos_phy)
>  		return -ENOMEM;
>  
> +	exynos_phy->drv_data = drv_data;
> +
>  	exynos_phy->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(exynos_phy->base))
>  		return PTR_ERR(exynos_phy->base);
> @@ -169,12 +521,15 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(exynos_phy->fsysreg);
>  	}
>  
> -	generic_phy = devm_phy_create(dev, dev->of_node, &exynos5433_phy_ops);
> +	generic_phy = devm_phy_create(dev, dev->of_node, drv_data->phy_ops);
>  	if (IS_ERR(generic_phy)) {
>  		dev_err(dev, "failed to create PHY\n");
>  		return PTR_ERR(generic_phy);
>  	}
>  
> +	exynos_phy->pcs_base = devm_platform_ioremap_resource(pdev, 1);
> +	exynos_phy->phy_id = of_alias_get_id(dev->of_node, "pciephy");

Where did you document aliases?

Anyway, all this looks because you have completely buggy way of handling
MMIO via syscon. That's a no-go. Use proper address ranges assigned to
ddevices. If you ever need to use syscon, you should pass the offset as
argument - just like other devices are doing.

Best regards,
Krzysztof


