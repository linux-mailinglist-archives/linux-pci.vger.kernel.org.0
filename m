Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F6322CFD5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 22:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGXUqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 16:46:05 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.232.150]:34406 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgGXUpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 16:45:42 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id A634D1A043D;
        Fri, 24 Jul 2020 13:36:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com A634D1A043D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1595622994;
        bh=VlSMIaiQaCCPt3rusBGXPF9DWZFolZPcPIIcjR2LOMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5+iibz9NaoxFnyfIwbI8oUHBajtMVXjE6z/sLKS6TZJsKW2sEdFPr1aohj+bPRYe
         RoxgCwrjWgE6EGfmEcHfYZOxHbJAad9VpO2fc3XXDZp3dZvP0SGo+ndFpqjEzt2XnT
         PX2APgQZmzV4Dx/t32ri2R5EOZ4371at2L3iKCP8=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 593B214022B;
        Fri, 24 Jul 2020 13:34:24 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 07/12] PCI: brcmstb: Add control of rescal reset
Date:   Fri, 24 Jul 2020 16:33:49 -0400
Message-Id: <20200724203407.16972-8-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724203407.16972-1-james.quinlan@broadcom.com>
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Some STB chips have a special purpose reset controller named RESCAL (reset
calibration).  The PCIe HW can now control RESCAL to start and stop its
operation.  On probe(), the RESCAL is deasserted and the driver goes
through the sequence of setting registers and reading status in order to
start the internal PHY that is required for the PCIe.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 81 ++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e5e7f7d82eda..bfc2542d54a8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
+#include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -158,6 +159,16 @@
 #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
 #define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
 
+/* Rescal registers */
+#define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS			0x3
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK		0x4
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT	0x2
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK		0x2
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT		0x1
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
+
 enum {
 	RGR1_SW_INIT_1,
 	EXT_CFG_INDEX,
@@ -248,6 +259,7 @@ struct brcm_pcie {
 	const int		*reg_offsets;
 	const int		*reg_field_info;
 	enum pcie_type		type;
+	struct reset_control	*rescal;
 };
 
 /*
@@ -966,6 +978,47 @@ static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
 		dev_err(pcie->dev, "failed to enter low-power link state\n");
 }
 
+static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
+{
+	static const u32 shifts[PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS] = {
+		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT,
+		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT,
+		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT,};
+	static const u32 masks[PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS] = {
+		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK,
+		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK,
+		PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK,};
+	const int beg = start ? 0 : PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS - 1;
+	const int end = start ? PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS : -1;
+	u32 tmp, combined_mask = 0;
+	u32 val = !!start;
+	void __iomem *base = pcie->base;
+	int i;
+
+	for (i = beg; i != end; start ? i++ : i--) {
+		tmp = readl(base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
+		tmp = (tmp & ~masks[i]) | ((val << shifts[i]) & masks[i]);
+		writel(tmp, base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
+		usleep_range(50, 200);
+		combined_mask |= masks[i];
+	}
+
+	tmp = readl(base + PCIE_DVT_PMU_PCIE_PHY_CTRL);
+	val = start ? combined_mask : 0;
+
+	return (tmp & combined_mask) == val ? 0 : -EIO;
+}
+
+static inline int brcm_phy_start(struct brcm_pcie *pcie)
+{
+	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
+}
+
+static inline int brcm_phy_stop(struct brcm_pcie *pcie)
+{
+	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
+}
+
 static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 {
 	void __iomem *base = pcie->base;
@@ -993,11 +1046,15 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
 
 	brcm_pcie_turn_off(pcie);
+	ret = brcm_phy_stop(pcie);
+	if (ret)
+		dev_err(pcie->dev, "failed to stop phy\n");
 	clk_disable_unprepare(pcie->clk);
 
-	return 0;
+	return ret;
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1010,6 +1067,12 @@ static int brcm_pcie_resume(struct device *dev)
 	base = pcie->base;
 	clk_prepare_enable(pcie->clk);
 
+	ret = brcm_phy_start(pcie);
+	if (ret) {
+		dev_err(pcie->dev, "failed to start phy\n");
+		return ret;
+	}
+
 	/* Take bridge out of reset so we can access the SERDES reg */
 	brcm_pcie_bridge_sw_init_set(pcie, 0);
 
@@ -1035,6 +1098,9 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 {
 	brcm_msi_remove(pcie);
 	brcm_pcie_turn_off(pcie);
+	if (brcm_phy_stop(pcie))
+		dev_err(pcie->dev, "failed to stop phy\n");
+	reset_control_assert(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 }
 
@@ -1120,6 +1186,19 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "could not enable clock\n");
 		return ret;
 	}
+	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
+	if (IS_ERR(pcie->rescal))
+		return PTR_ERR(pcie->rescal);
+
+	ret = reset_control_deassert(pcie->rescal);
+	if (ret)
+		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
+
+	ret = brcm_phy_start(pcie);
+	if (ret) {
+		dev_err(pcie->dev, "failed to start phy\n");
+		return ret;
+	}
 
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
-- 
2.17.1

