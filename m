Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43F3C1696
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhGHPxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 11:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhGHPxF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92EDB6161F;
        Thu,  8 Jul 2021 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625759423;
        bh=v+njw+iLClhJqIr4bz9UT3EHxvRNjyCk79O/UqH+15Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5XVFm6WISj0GeymmddPlVNAGK9M17c41bogEHsktiLggVxk+PVBwB8kJlF1emHfq
         pXz480wjt4W7W5gcyxgJedmXzYxA++4HNjKNRo9cpo05fKyoZAzoY4laR8pIv0koKT
         zp3EnCufg5To69AICtx6DA06/EKMpIqnk1a+Wqs3W0Zk97AP9tON5BOKkiSkI0BfIm
         tSNMAQP+lfgdJ2WF6/Y8DHi+a0SgXo54F3qqogRIX9m3hmFqR95H/WwPItq3XkDgaq
         4TN/CuSlzUw4WNvt2Po48fcdiy1uG6VB/J/j5WiHIKXqe8DwiUY7V74i0uFsxcNLsm
         55I/Jb1Xq2Fcg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1WI4-008VV6-En; Thu, 08 Jul 2021 17:50:16 +0200
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
Subject: [PATCH RFC 2/7] PCI: kirin: use regmap for APB registers
Date:   Thu,  8 Jul 2021 17:50:09 +0200
Message-Id: <d040a99531b8692a769d9f5c6bd2da6454f48ca2.1625758732.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625758732.git.mchehab+huawei@kernel.org>
References: <cover.1625758732.git.mchehab+huawei@kernel.org>
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
 drivers/pci/controller/dwc/pcie-kirin.c | 51 +++++++++++++------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 0b2415edea04..ffa622e68389 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -55,23 +55,11 @@
 struct kirin_pcie {
 	struct dw_pcie	*pci;
 	struct phy	*phy;
-	void __iomem	*apb_base;
+	struct regmap	*apb;
 	struct clk	*apb_sys_clk;
 	struct clk	*pcie_aux_clk;
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
-
 static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 			       struct platform_device *pdev)
 {
@@ -88,13 +76,27 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 	return 0;
 }
 
+static const struct regmap_config pcie_kirin_regmap_conf = {
+	.name = "kirin_pcie_apb",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
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
@@ -148,13 +150,13 @@ static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
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
@@ -162,13 +164,13 @@ static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
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
@@ -228,8 +230,9 @@ static void kirin_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 static int kirin_pcie_link_up(struct dw_pcie *pci)
 {
 	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
-	u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
+	u32 val;
 
+	regmap_read(kirin_pcie->apb, PCIE_APB_PHY_STATUS0, &val);
 	if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
 		return 1;
 
@@ -241,8 +244,8 @@ static int kirin_pcie_start_link(struct dw_pcie *pci)
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

