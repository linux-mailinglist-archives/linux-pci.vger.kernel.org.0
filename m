Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192C22BA789
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 11:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgKTKgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 05:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgKTKgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 05:36:21 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F712224C;
        Fri, 20 Nov 2020 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605868580;
        bh=0t0f07AEWpiGNTgrmuuQl9A+2LbIKKtAk4aNaS1pRKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7/uXCu3/h00q4Ae4CuB5vjovu9cNPa1NjnqTNdYpu60KPOTC6s5enNz0x+TeXq5o
         2n7YQkNL2xxoKKCZ+xTIJWI1wDc+J+yw/bjEyVI5UQaqdXNEvkXzgAxAh40/K+vkWP
         pTrJqnbWX0Uv7KLSkicqJzODLQ54S9kYRYS5DVOs=
Date:   Fri, 20 Nov 2020 16:06:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 4/5 REBASED RESEND] phy: samsung: phy-exynos-pcie:
 rework driver to support Exynos5433 PCIe PHY
Message-ID: <20201120103612.GJ2925@vkoul-mobl>
References: <20201120101138.GI2925@vkoul-mobl>
 <CGME20201120102654eucas1p2f7395e14632a019a58f0ed5002eff556@eucas1p2.samsung.com>
 <20201120102627.14450-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120102627.14450-1-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-11-20, 11:26, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
> variant found in the Exynos5433 SoCs.

Applied, thanks


My scripts found a typo, have applied fix for that as well

From: Vinod Koul <vkoul@kernel.org>
Date: Fri, 20 Nov 2020 16:04:01 +0530
Subject: [PATCH] phy: samsung: phy-exynos-pcie: fix typo 'tunning'

Fix the typo s/tunning/tuning

Fixes: 496db029142f ("phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433 PCIe PHY")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/samsung/phy-exynos-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index d91de323dd0e..578cfe07d07a 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -69,7 +69,7 @@ static int exynos5433_pcie_phy_init(struct phy *phy)
 	exynos_pcie_phy_writel(ep->base, 0, PCIE_PHY_OFFSET(0x20));
 	exynos_pcie_phy_writel(ep->base, 0, PCIE_PHY_OFFSET(0x4b));
 
-	/* jitter tunning */
+	/* jitter tuning */
 	exynos_pcie_phy_writel(ep->base, 0x34, PCIE_PHY_OFFSET(0x4));
 	exynos_pcie_phy_writel(ep->base, 0x02, PCIE_PHY_OFFSET(0x7));
 	exynos_pcie_phy_writel(ep->base, 0x41, PCIE_PHY_OFFSET(0x21));
--
~Vinod
