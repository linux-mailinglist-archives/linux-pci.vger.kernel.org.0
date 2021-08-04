Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B9B3E051E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhHDQDY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHDQDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 12:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68E4461004;
        Wed,  4 Aug 2021 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628092990;
        bh=66pZf2o/BZ9yYQkTCPHEOmZBX2W7nSIdCxqcbr2roWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gH+gp0tHKb95KTVM8eVGNEnJOrp393fC9IYy1dYGm8wZF10KoEolL+XDDlmZG8xgp
         66BR8/+sd6pR+lh+qAKUib6Pt+AAUV+uNfQDRvq3Oi6C8qO1JoU7ffIDFiaAh4hA3d
         Zbezall36QWGVu/PnmuvjaIl3Izxh4ECq0yXZMOeUkdA3wFGBiW6bPAql9ftARAsjf
         C6wa/Bq37RgOvdW4TyfS/1D+zvE1q3HZ/u9XeaOWErrYD/nalHQGlndRtvho85Qgin
         590LsPZX17jR14tbGFVetrwva1pd7f64nWOWxvefRvuWkpU9848UjWV3fYvyOLvawz
         n+rtnXu7KKxtg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBJMK-000PzX-Gk; Wed, 04 Aug 2021 18:03:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v9 04/11] PCI: kirin: Use regmap for APB registers
Date:   Wed,  4 Aug 2021 18:03:00 +0200
Message-Id: <5367172faed3dbd29987db733998fded2a307297.1628092716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628092716.git.mchehab+huawei@kernel.org>
References: <cover.1628092716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PHY layer need to access APB registers too, for Kirin 970.
So, place them into a named regmap.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 49 +++++++++++++------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 31514a5d4bb4..0ea92a521e1c 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -61,8 +61,8 @@ struct kirin_pcie {
 	enum pcie_kirin_phy_type	type;
 
 	struct dw_pcie	*pci;
+	struct regmap   *apb;
 	struct phy	*phy;
-	void __iomem	*apb_base;
 	void		*phy_priv;	/* only for PCIE_KIRIN_INTERNAL_PHY */
 };
 
@@ -340,25 +340,27 @@ static int hi3660_pcie_phy_init(struct platform_device *pdev,
  * The non-PHY part starts here
  */
 
-/* Registers in PCIeCTRL */
-static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
-					 u32 val, u32 reg)
-{
-	writel(val, kirin_pcie->apb_base + reg);
-}
-
-static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
-{
-	return readl(kirin_pcie->apb_base + reg);
-}
+static const struct regmap_config pcie_kirin_regmap_conf = {
+	.name = "kirin_pcie_apb",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
 
 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				    struct platform_device *pdev)
 {
-	kirin_pcie->apb_base =
-		devm_platform_ioremap_resource_byname(pdev, "apb");
-	if (IS_ERR(kirin_pcie->apb_base))
-		return PTR_ERR(kirin_pcie->apb_base);
+	struct device *dev = &pdev->dev;
+	void __iomem *apb_base;
+
+	apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
+	if (IS_ERR(apb_base))
+		return PTR_ERR(apb_base);
+
+	kirin_pcie->apb = devm_regmap_init_mmio(dev, apb_base,
+						&pcie_kirin_regmap_conf);
+	if (IS_ERR(kirin_pcie->apb))
+		return PTR_ERR(kirin_pcie->apb);
 
 	return 0;
 }
@@ -368,13 +370,13 @@ static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
 {
 	u32 val;
 
-	val = kirin_apb_ctrl_readl(kirin_pcie, SOC_PCIECTRL_CTRL0_ADDR);
+	regmap_read(kirin_pcie->apb, SOC_PCIECTRL_CTRL0_ADDR, &val);
 	if (on)
 		val = val | PCIE_ELBI_SLV_DBI_ENABLE;
 	else
 		val = val & ~PCIE_ELBI_SLV_DBI_ENABLE;
 
-	kirin_apb_ctrl_writel(kirin_pcie, val, SOC_PCIECTRL_CTRL0_ADDR);
+	regmap_write(kirin_pcie->apb, SOC_PCIECTRL_CTRL0_ADDR, val);
 }
 
 static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
@@ -382,13 +384,13 @@ static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
 {
 	u32 val;
 
-	val = kirin_apb_ctrl_readl(kirin_pcie, SOC_PCIECTRL_CTRL1_ADDR);
+	regmap_read(kirin_pcie->apb, SOC_PCIECTRL_CTRL1_ADDR, &val);
 	if (on)
 		val = val | PCIE_ELBI_SLV_DBI_ENABLE;
 	else
 		val = val & ~PCIE_ELBI_SLV_DBI_ENABLE;
 
-	kirin_apb_ctrl_writel(kirin_pcie, val, SOC_PCIECTRL_CTRL1_ADDR);
+	regmap_write(kirin_pcie->apb, SOC_PCIECTRL_CTRL1_ADDR, val);
 }
 
 static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
@@ -448,8 +450,9 @@ static void kirin_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 static int kirin_pcie_link_up(struct dw_pcie *pci)
 {
 	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
-	u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
+	u32 val;
 
+	regmap_read(kirin_pcie->apb, PCIE_APB_PHY_STATUS0, &val);
 	if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
 		return 1;
 
@@ -461,8 +464,8 @@ static int kirin_pcie_start_link(struct dw_pcie *pci)
 	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
 
 	/* assert LTSSM enable */
-	kirin_apb_ctrl_writel(kirin_pcie, PCIE_LTSSM_ENABLE_BIT,
-			      PCIE_APP_LTSSM_ENABLE);
+	regmap_write(kirin_pcie->apb, PCIE_APP_LTSSM_ENABLE,
+		     PCIE_LTSSM_ENABLE_BIT);
 
 	return 0;
 }
-- 
2.31.1

