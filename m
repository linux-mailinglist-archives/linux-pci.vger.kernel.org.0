Return-Path: <linux-pci+bounces-35265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DBB3E25B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 14:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA961A82494
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C5277020;
	Mon,  1 Sep 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgM4H5Hr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B092765DB;
	Mon,  1 Sep 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728716; cv=none; b=V9sM7oRSTCyAA02xy8ejdmpk3xKLxv+/m/26dzaMC1RG++TbtD3qZ0v9Me/YZweKt4d0/Vav54BnpnFNzCbc8oiTJZUhCxQ1lCOHB8wUBOHYS9nqPypcH0yjsDbU4eHJrm3vJtQraAXnPPNTlQRvj3oINkGBPI339sVA66TwLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728716; c=relaxed/simple;
	bh=qBCtOBJT2cV+mYRDVrXbHxe214BFli2AJqzlHAFeHmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkLo0XcLO7BLwMlxPvK/CeSlwuSGqBj2qaIStTWHFyxYdN4bkNU+FSpInAtIEdBn2utzGKwgs6bwpuGlddQUOywBB8EOe/AqoZHzHCAHRrgxBjAgIEbhWeSQIaJVfBgb0fwhH2ilAFutzZ3K8aqvRLFczOtiHGsSBPDOEjoL2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgM4H5Hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C32FC4CEF0;
	Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756728715;
	bh=qBCtOBJT2cV+mYRDVrXbHxe214BFli2AJqzlHAFeHmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgM4H5HrKPqzEWKaSZZ7G5TFgQ07XB5abKuclMAVTDyb72U8Mej25CusONsJTcqUA
	 D8HD6YysFa4BLj7g866Hk/j8mfg7NLIcRq0I57I4DBx+xCOH4xiVd3hwq4Ken3omiY
	 7P4hMwDYQ2lOEB7aFsWcQ+d7Sb82DMMfmmNCaffJJOTEepv71yzjo3FsRsD6TmfaQV
	 cT0/PVLi/7Iqh5DsfIOmEYvalaeUnHIjpNQVefdV6+GUxOV/0QZkbt0TC2+34r0eMt
	 u1fxeyrUs6OGR/HoSCu4I9xWptMRoncdQ2+GqxTpRL9Kx02riRJi1DhTi0bT0DQetk
	 hxABn07H4QR+w==
Date: Mon, 1 Sep 2025 17:41:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, kishon@kernel.org,
	arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 10/12] phy: exynos: Add PCIe PHY support for FSD SoC
Message-ID: <aLWNhv0eLj7LRrvM@vaman>
References: <20250811154638.95732-1-shradha.t@samsung.com>
 <CGME20250811154738epcas5p1d1202f799c4d950c5d5e7f45e39a51e7@epcas5p1.samsung.com>
 <20250811154638.95732-11-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811154638.95732-11-shradha.t@samsung.com>

On 11-08-25, 21:16, Shradha Todi wrote:
> Add PCIe PHY support for Tesla FSD SoC.

Can you pls add a bit more description of what you are adding, helps to
understand the change

> +/* FSD: PCIe PCS registers */
> +#define FSD_PCIE_PCS_BRF_0		0x0004
> +#define FSD_PCIE_PCS_BRF_1		0x0804
> +#define FSD_PCIE_PCS_CLK		0x0180
> +
> +/* FSD: PCIe SYSREG registers */
> +#define FSD_PCIE_SYSREG_PHY_0_CON			0x042c
> +#define FSD_PCIE_SYSREG_PHY_0_CON_MASK			0x03ff
> +#define FSD_PCIE_SYSREG_PHY_0_REF_SEL			(0x2 << 0)

Use GENMASK() please here and elsewhere

> +static int fsd_pcie_phy0_reset(struct phy *phy)
> +{
> +	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
> +
> +	writel(0x1, phy_ctrl->pcs_base + FSD_PCIE_PCS_CLK);
> +
> +	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
> +			FSD_PCIE_SYSREG_PHY_0_CON_MASK, 0x0);
> +	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
> +		FSD_PCIE_SYSREG_PHY_0_AUX_EN, FSD_PCIE_SYSREG_PHY_0_AUX_EN);
> +	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
> +		FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK, FSD_PCIE_SYSREG_PHY_0_REF_SEL);
> +	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
> +		FSD_PCIE_SYSREG_PHY_0_INIT_RSTN, FSD_PCIE_SYSREG_PHY_0_INIT_RSTN);

pls conform to coding style for these

> +
> +	return 0;

why return a value when this wont ever return anything else than 0?

> +
> +	writel(0x2, pbase + FSD_PCIE_PHY_CMN_RESET);
> +
> +	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_0);
> +	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_1);
> +	writel(0x00, pbase + FSD_PCIE_PHY_AGG_BIF_RESET);
> +	writel(0x00, pbase + FSD_PCIE_PHY_AGG_BIF_CLOCK);
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

Magic numbers?
-- 
~Vinod

