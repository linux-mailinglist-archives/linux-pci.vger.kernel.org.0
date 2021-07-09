Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F03C225A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 12:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhGIKoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 06:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhGIKoe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 06:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3039B613CF;
        Fri,  9 Jul 2021 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625827311;
        bh=myJOBw0Qp5XaQjPzlyLNLDqOfG7j4IJ/JolTRs3S2tY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VeZCaZ7qEGzJFmdXmhVCSGcVjShqYNehadFFfRUP6nWcapnkmmWi/vjK4JLSXUcDO
         XCPHt5br62DqzZ2ZEnskT6BFn3M6nAaeNBiztigUUEfdmtHkMdV9u6t6kQFm0rnmcc
         SM2pcdsJQYdsZ1Cuu29cikVRb6wUBCf71CgGsbY8oMEsSJ8qJdtEEoD5X5lDOg2EwD
         x9mPOZVyRtJgovKlzpolIxxMKH4xkQR048xCQYHE+ZjNnVeAtGp/cBetDGBTnzw379
         GIJUVvJ8q2AdrWV1eGz1pYkXU2BRr/Fr2AXUur12bwqmPFG20nlTvmNrLcRzgbMWAy
         6a9C7mqXCXR3w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1nx7-00B5Fs-Fm; Fri, 09 Jul 2021 12:41:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 7/9] PCI: kirin: use regmap for APB registers
Date:   Fri,  9 Jul 2021 12:41:43 +0200
Message-Id: <f6e980b8de11fca921e876c9facbd996abf6c06b.1625826353.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625826353.git.mchehab+huawei@kernel.org>
References: <cover.1625826353.git.mchehab+huawei@kernel.org>
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
index a77bbecbf11f..78271dddf2e8 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -54,28 +54,30 @@
 struct kirin_pcie {
 	struct dw_pcie	*pci;
 	struct phy	*phy;
-	void __iomem	*apb_base;
+	struct regmap	*apb;
 };
 
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
@@ -96,13 +98,13 @@ static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
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
@@ -110,13 +112,13 @@ static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
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
@@ -176,8 +178,9 @@ static void kirin_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 static int kirin_pcie_link_up(struct dw_pcie *pci)
 {
 	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
-	u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
+	u32 val;
 
+	regmap_read(kirin_pcie->apb, PCIE_APB_PHY_STATUS0, &val);
 	if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
 		return 1;
 
@@ -189,8 +192,8 @@ static int kirin_pcie_start_link(struct dw_pcie *pci)
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

