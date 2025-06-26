Return-Path: <linux-pci+bounces-30866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1186AEAA3B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6C81C200DA
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0782264C9;
	Thu, 26 Jun 2025 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4oisEhr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E332264BA;
	Thu, 26 Jun 2025 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979384; cv=none; b=Oh1Zk5QGiQAj4IwpiFaklTFO56M4qDBwPHaqmVRF/+qEbaATOhBm2KkQSeJWCEWsZFrHtVb9k4sC/rlqpYQY0vHBNM1+Gzv1HKbDCszGRJs7Xa6hGPUGPIANbb+I8eQqlO7P61ZVCxyiidAmxSdlYobG1oLeMhYIrccXxOYpBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979384; c=relaxed/simple;
	bh=3SYrm9nDQKoEyXYw+z2zEDkXhc9DJonzeOrnUMeFFtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is2+Vp1r69cneIGulyFF/kodyBQzKLPMnyQER+yKbHJ5HLF02v4y+4JkkDZ1jq7lJKPOz80eWT8hJrgjDCiZFfaJrJXGa+uPt+nYwKQVby/g6w30osuP45SAfJwOah3IPK+rCA7Tb/gOcdfvOZxyGMiRW1cFtBaAVsZnynWKvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4oisEhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E4EC4CEF0;
	Thu, 26 Jun 2025 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750979383;
	bh=3SYrm9nDQKoEyXYw+z2zEDkXhc9DJonzeOrnUMeFFtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4oisEhrwF+SdYXYyIwI/D9UtFTvlYYNjNEx0An9jedIZIvwQdD8IYzZJtLt9mNQR
	 65HdpG86yBwIpnGTCz4Q12BEWkdI4cCgV31FY95Z4UbVPE9gND//5u71cgRNBk8aVW
	 vSOmiuaODhM7jZceAYcCR3cPbpC+NPNS0XAzVJ4A4mXkHMXQJ0TTsz+ALxOCtHBK7T
	 jpdPbLh2S3/LVrxkFOmqJVFT7vxlcNFw+G646AZTLVhKrilkLkO01QqsnGaJzfsVzW
	 jE9jitDvH8C0m1OKnbysb7YF9c6sU440sqt9TkMEXhjoAYyDtcT5lH5tnuZ+a88wCi
	 KJQX485ZG+g0A==
Date: Thu, 26 Jun 2025 16:09:42 -0700
From: Vinod Koul <vkoul@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-fsd@tesla.com,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v2 08/10] phy: exynos: Add PCIe PHY support for FSD SoC
Message-ID: <aF3TNjyLlIF6TeKN@vaman>
References: <20250625165229.3458-1-shradha.t@samsung.com>
 <CGME20250625165323epcas5p44d291cb0b46df7e015907e4c2903447f@epcas5p4.samsung.com>
 <20250625165229.3458-9-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625165229.3458-9-shradha.t@samsung.com>

On 25-06-25, 22:22, Shradha Todi wrote:
> Add PCIe PHY support for Tesla FSD SoC.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/phy/samsung/phy-exynos-pcie.c | 317 +++++++++++++++++++++++++-
>  1 file changed, 316 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
> index 53c9230c2907..001a49bde2f4 100644
> --- a/drivers/phy/samsung/phy-exynos-pcie.c
> +++ b/drivers/phy/samsung/phy-exynos-pcie.c
> @@ -34,11 +34,113 @@
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
> +#define FSD_PCIE_LANE_OFFSET		0x0400
> +#define FSD_PCIE_NUM_LANES		0x4
> +
> +#define FSD_PCIE_PHY_TRSV_REG001_LN_N	0x0404
> +#define FSD_PCIE_PHY_TRSV_REG002_LN_N	0x0408
> +#define FSD_PCIE_PHY_TRSV_REG005_LN_N	0x0414
> +#define FSD_PCIE_PHY_TRSV_REG006_LN_N	0x0418
> +#define FSD_PCIE_PHY_TRSV_REG007_LN_N	0x041c
> +#define FSD_PCIE_PHY_TRSV_REG009_LN_N	0x0424
> +#define FSD_PCIE_PHY_TRSV_REG00A_LN_N	0x0428
> +#define FSD_PCIE_PHY_TRSV_REG00C_LN_N	0x0430
> +#define FSD_PCIE_PHY_TRSV_REG012_LN_N	0x0448
> +#define FSD_PCIE_PHY_TRSV_REG013_LN_N	0x044c
> +#define FSD_PCIE_PHY_TRSV_REG014_LN_N	0x0450
> +#define FSD_PCIE_PHY_TRSV_REG015_LN_N	0x0454
> +#define FSD_PCIE_PHY_TRSV_REG016_LN_N	0x0458
> +#define FSD_PCIE_PHY_TRSV_REG018_LN_N	0x0460
> +#define FSD_PCIE_PHY_TRSV_REG020_LN_N	0x0480
> +#define FSD_PCIE_PHY_TRSV_REG026_LN_N	0x0498
> +#define FSD_PCIE_PHY_TRSV_REG029_LN_N	0x04a4
> +#define FSD_PCIE_PHY_TRSV_REG031_LN_N	0x04c4
> +#define FSD_PCIE_PHY_TRSV_REG036_LN_N	0x04d8
> +#define FSD_PCIE_PHY_TRSV_REG039_LN_N	0x04e4
> +#define FSD_PCIE_PHY_TRSV_REG03B_LN_N	0x04ec
> +#define FSD_PCIE_PHY_TRSV_REG03C_LN_N	0x04f0
> +#define FSD_PCIE_PHY_TRSV_REG03E_LN_N	0x04f8
> +#define FSD_PCIE_PHY_TRSV_REG03F_LN_N	0x04fc
> +#define FSD_PCIE_PHY_TRSV_REG043_LN_N	0x050c
> +#define FSD_PCIE_PHY_TRSV_REG044_LN_N	0x0510
> +#define FSD_PCIE_PHY_TRSV_REG046_LN_N	0x0518
> +#define FSD_PCIE_PHY_TRSV_REG048_LN_N	0x0520
> +#define FSD_PCIE_PHY_TRSV_REG049_LN_N	0x0524
> +#define FSD_PCIE_PHY_TRSV_REG04E_LN_N	0x0538
> +#define FSD_PCIE_PHY_TRSV_REG052_LN_N	0x0548
> +#define FSD_PCIE_PHY_TRSV_REG068_LN_N	0x05a0
> +#define FSD_PCIE_PHY_TRSV_REG069_LN_N	0x05a4
> +#define FSD_PCIE_PHY_TRSV_REG06A_LN_N	0x05a8
> +#define FSD_PCIE_PHY_TRSV_REG06B_LN_N	0x05ac
> +#define FSD_PCIE_PHY_TRSV_REG07B_LN_N	0x05ec
> +#define FSD_PCIE_PHY_TRSV_REG083_LN_N	0x060c
> +#define FSD_PCIE_PHY_TRSV_REG084_LN_N	0x0610
> +#define FSD_PCIE_PHY_TRSV_REG086_LN_N	0x0618
> +#define FSD_PCIE_PHY_TRSV_REG087_LN_N	0x061c
> +#define FSD_PCIE_PHY_TRSV_REG08B_LN_N	0x062c
> +#define FSD_PCIE_PHY_TRSV_REG09C_LN_N	0x0670
> +#define FSD_PCIE_PHY_TRSV_REG09D_LN_N	0x0674
> +#define FSD_PCIE_PHY_TRSV_REG09E_LN_N	0x0678
> +#define FSD_PCIE_PHY_TRSV_REG09F_LN_N	0x067c
> +#define FSD_PCIE_PHY_TRSV_REG0A2_LN_N	0x0688
> +#define FSD_PCIE_PHY_TRSV_REG0A4_LN_N	0x0690
> +#define FSD_PCIE_PHY_TRSV_REG0CE_LN_N	0x0738
> +#define FSD_PCIE_PHY_TRSV_REG0FC_LN_N	0x07f0
> +#define FSD_PCIE_PHY_TRSV_REG0FD_LN_N	0x07f4
> +#define FSD_PCIE_PHY_TRSV_REG0FE_LN_N	0x07f8
> +#define FSD_PCIE_PHY_TRSV_REG0CE_LN_1	0x0b38
> +#define FSD_PCIE_PHY_TRSV_REG0CE_LN_2	0x0f38
> +#define FSD_PCIE_PHY_TRSV_REG0CE_LN_3	0x1338
> +
> +/* FSD: PCIe PCS registers */
> +#define FSD_PCIE_PCS_BRF_0		0x0004
> +#define FSD_PCIE_PCS_BRF_1		0x0804
> +#define FSD_PCIE_PCS_CLK		0x0180
> +
> +/* FSD: PCIe SYSREG registers */
> +#define FSD_PCIE_SYSREG_PHY_0_CON			0x042c
> +#define FSD_PCIE_SYSREG_PHY_0_CON_MASK			0x03ff
> +#define FSD_PCIE_SYSREG_PHY_0_REF_SEL			(0x2 << 0)

Please use GENMASK for this

> +#define FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK		0x3
> +#define FSD_PCIE_SYSREG_PHY_0_AUX_EN			BIT(4)
> +#define FSD_PCIE_SYSREG_PHY_0_CMN_RSTN			BIT(8)
> +#define FSD_PCIE_SYSREG_PHY_0_INIT_RSTN			BIT(9)
> +
> +#define FSD_PCIE_SYSREG_PHY_1_CON			0x0500
> +#define FSD_PCIE_SYSREG_PHY_1_CON_MASK			0x01ff
> +#define FSD_PCIE_SYSREG_PHY_1_REF_SEL			(0x2 << 4)
> +#define FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK		0x30
> +#define FSD_PCIE_SYSREG_PHY_1_AUX_EN			BIT(0)
> +#define FSD_PCIE_SYSREG_PHY_1_CMN_RSTN			BIT(1)
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
> @@ -133,9 +235,212 @@ static const struct phy_ops exynos5433_phy_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static void fsd_pcie_phy_writel(struct exynos_pcie_phy *phy_ctrl, u32 offset, u32 val)
> +{
> +	void __iomem *phy_base = phy_ctrl->base;
> +	u32 i;
> +
> +	for (i = 0; i < FSD_PCIE_NUM_LANES; i++)
> +		writel(val, phy_base + (offset + i * FSD_PCIE_LANE_OFFSET));
> +}
> +
> +struct fsd_pcie_phy_pdata {
> +	u32 phy_con_offset;
> +	u32 phy_con_mask;
> +	u32 phy_ref_sel;
> +	u32 phy_ref_sel_mask;
> +	u32 phy_aux_en;
> +	u32 phy_cmn_rstn;
> +	u32 phy_init_rstn;
> +};
> +
> +static const struct fsd_pcie_phy_pdata fsd_phy_con[] = {
> +{
> +	.phy_con_offset		= FSD_PCIE_SYSREG_PHY_0_CON,
> +	.phy_con_mask		= FSD_PCIE_SYSREG_PHY_0_CON_MASK,
> +	.phy_ref_sel		= FSD_PCIE_SYSREG_PHY_0_REF_SEL,
> +	.phy_ref_sel_mask	= FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK,
> +	.phy_aux_en		= FSD_PCIE_SYSREG_PHY_0_AUX_EN,
> +	.phy_cmn_rstn		= FSD_PCIE_SYSREG_PHY_0_CMN_RSTN,
> +	.phy_init_rstn		= FSD_PCIE_SYSREG_PHY_0_INIT_RSTN,
> +	},
> +	{
> +	.phy_con_offset		= FSD_PCIE_SYSREG_PHY_1_CON,
> +	.phy_con_mask		= FSD_PCIE_SYSREG_PHY_1_CON_MASK,
> +	.phy_ref_sel		= FSD_PCIE_SYSREG_PHY_1_REF_SEL,
> +	.phy_ref_sel_mask	= FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK,
> +	.phy_aux_en		= FSD_PCIE_SYSREG_PHY_1_AUX_EN,
> +	.phy_cmn_rstn		= FSD_PCIE_SYSREG_PHY_1_CMN_RSTN,
> +	.phy_init_rstn		= FSD_PCIE_SYSREG_PHY_1_INIT_RSTN,
> +	},
> +	{ },
> +};
> +
> +static int fsd_pcie_phy_reset(struct phy *phy)
> +{
> +	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
> +	const struct fsd_pcie_phy_pdata *pdata = &fsd_phy_con[phy_ctrl->phy_id];
> +
> +	writel(0x1, phy_ctrl->pcs_base + FSD_PCIE_PCS_CLK);
> +
> +	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
> +			pdata->phy_con_mask, 0x0);
> +	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
> +			pdata->phy_aux_en, pdata->phy_aux_en);
> +	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
> +			pdata->phy_ref_sel_mask, pdata->phy_ref_sel);
> +	/* perform init reset release */
> +	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
> +			pdata->phy_init_rstn, pdata->phy_init_rstn);
> +
> +	return 0;
> +}
> +
> +static void fsd_pcie_phy1_init(struct exynos_pcie_phy *phy_ctrl)
> +{
> +	void __iomem *pbase = phy_ctrl->base;
> +
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG07B_LN_N, 0x20);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG052_LN_N, 0x00);
> +	writel(0xaa, pbase + FSD_PCIE_PHY_TRSV_CMN_REG01E);
> +	writel(0x28, pbase + FSD_PCIE_PHY_TRSV_CMN_REG02D);
> +	writel(0x28, pbase + FSD_PCIE_PHY_TRSV_CMN_REG031);
> +	writel(0x21, pbase + FSD_PCIE_PHY_TRSV_CMN_REG036);
> +	writel(0x12, pbase + FSD_PCIE_PHY_TRSV_CMN_REG05F);
> +	writel(0x23, pbase + FSD_PCIE_PHY_TRSV_CMN_REG060);
> +	writel(0x0, pbase + FSD_PCIE_PHY_TRSV_CMN_REG061);
> +	writel(0x0, pbase + FSD_PCIE_PHY_TRSV_CMN_REG062);
> +	writel(0x15, pbase + FSD_PCIE_PHY_TRSV_CMN_REG03);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG039_LN_N, 0xf);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03B_LN_N, 0x13);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03C_LN_N, 0x66);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG044_LN_N, 0x57);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03E_LN_N, 0x10);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03F_LN_N, 0x44);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG043_LN_N, 0x11);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG046_LN_N, 0xef);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG048_LN_N, 0x06);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG049_LN_N, 0xaf);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG04E_LN_N, 0x28);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG068_LN_N, 0x1f);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG069_LN_N, 0xc);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG06A_LN_N, 0x8);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG06B_LN_N, 0x78);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG083_LN_N, 0xa);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG084_LN_N, 0x80);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG087_LN_N, 0x30);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG08B_LN_N, 0xa0);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09C_LN_N, 0xf7);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09E_LN_N, 0x33);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0A2_LN_N, 0xfa);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0A4_LN_N, 0xf2);
> +	writel(0x8, pbase + FSD_PCIE_PHY_TRSV_REG0CE_LN_N);
> +	writel(0x9, pbase + FSD_PCIE_PHY_TRSV_REG0CE_LN_1);
> +	writel(0x9, pbase + FSD_PCIE_PHY_TRSV_REG0CE_LN_2);
> +	writel(0x9, pbase + FSD_PCIE_PHY_TRSV_REG0CE_LN_3);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0FE_LN_N, 0x33);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG001_LN_N, 0x3f);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG005_LN_N, 0x2b);
> +}
> +
> +static void fsd_pcie_phy0_init(struct exynos_pcie_phy *phy_ctrl)
> +{
> +	void __iomem *pbase = phy_ctrl->base;
> +
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG07B_LN_N, 0x20);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG052_LN_N, 0x00);
> +	writel(0x11, pbase + FSD_PCIE_PHY_TRSV_CMN_REG05F);
> +	writel(0x23, pbase + FSD_PCIE_PHY_TRSV_CMN_REG060);
> +	writel(0x0, pbase + FSD_PCIE_PHY_TRSV_CMN_REG062);
> +	writel(0x15, pbase + FSD_PCIE_PHY_TRSV_CMN_REG03);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0CE_LN_N, 0x8);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG039_LN_N, 0xf);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03B_LN_N, 0x13);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03C_LN_N, 0xf6);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG044_LN_N, 0x57);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03E_LN_N, 0x10);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03F_LN_N, 0x04);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG043_LN_N, 0x11);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG049_LN_N, 0x6f);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG04E_LN_N, 0x18);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG068_LN_N, 0x1f);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG069_LN_N, 0xc);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG06B_LN_N, 0x78);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG083_LN_N, 0xa);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG084_LN_N, 0x80);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG086_LN_N, 0xff);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG087_LN_N, 0x3c);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09D_LN_N, 0x7c);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09E_LN_N, 0x33);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09F_LN_N, 0x33);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG001_LN_N, 0x3f);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG002_LN_N, 0x1c);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG005_LN_N, 0x2b);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG006_LN_N, 0x3);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG007_LN_N, 0x0c);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG009_LN_N, 0x10);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG00A_LN_N, 0x1);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG00C_LN_N, 0x93);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG012_LN_N, 0x1);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG013_LN_N, 0x0);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG014_LN_N, 0x70);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG015_LN_N, 0x0);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG016_LN_N, 0x70);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0FC_LN_N, 0x80);
> +	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0FD_LN_N, 0x0);
> +}
> +
> +static int fsd_pcie_phy_init(struct phy *phy)
> +{
> +	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
> +	void __iomem *phy_base = phy_ctrl->base;
> +	const struct fsd_pcie_phy_pdata *pdata = &fsd_phy_con[phy_ctrl->phy_id];
> +
> +	fsd_pcie_phy_reset(phy);
> +
> +	if (phy_ctrl->phy_id == 1)
> +		writel(0x2, phy_base + FSD_PCIE_PHY_CMN_RESET);
> +
> +	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_0);
> +	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_1);
> +	writel(0x00, phy_base + FSD_PCIE_PHY_AGG_BIF_RESET);
> +	writel(0x00, phy_base + FSD_PCIE_PHY_AGG_BIF_CLOCK);
> +
> +	if (phy_ctrl->phy_id == 1) {
> +		fsd_pcie_phy1_init(phy_ctrl);
> +		writel(0x3, phy_base + FSD_PCIE_PHY_CMN_RESET);
> +	} else {
> +		fsd_pcie_phy0_init(phy_ctrl);
> +	}
> +
> +	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
> +			pdata->phy_cmn_rstn, pdata->phy_cmn_rstn);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops fsd_phy_ops = {
> +	.init		= fsd_pcie_phy_init,
> +	.reset		= fsd_pcie_phy_reset,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct samsung_drv_data exynos5433_drv_data = {
> +	.phy_ops		= &exynos5433_phy_ops,
> +};
> +
> +static const struct samsung_drv_data fsd_drv_data = {
> +	.phy_ops		= &fsd_phy_ops,
> +};
> +
>  static const struct of_device_id exynos_pcie_phy_match[] = {
>  	{
>  		.compatible = "samsung,exynos5433-pcie-phy",
> +		.data = &exynos5433_drv_data,
> +	},
> +	{
> +		.compatible = "tesla,fsd-pcie-phy",
> +		.data = &fsd_drv_data,
>  	},
>  	{},
>  };

Can you split this to two patches, one for the move and second for
adding fsd one...

Also, no need to post everything togther, phy can be sent as a
standalone one

-- 
~Vinod

