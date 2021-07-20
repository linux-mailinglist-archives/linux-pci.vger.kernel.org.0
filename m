Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE43CF5C7
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhGTH34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 03:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbhGTH2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 03:28:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7971461186;
        Tue, 20 Jul 2021 08:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626768559;
        bh=kNbCX3ZQtE4AszIqnoyRhvaZXS0KstwrELn3IaKqlAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AanHggTMuINl6Hr9SPdpNGqphoPazvOEIrJAZ3h8joFa8qkrIE00mF3iCNhZJOlux
         W5OKDMrIxKWdnTq3SlbnIxOUJZEoQHO2fCR55R/++9J4O6wX/3cTp8SetZfljfZMpE
         pwUpnMIhdaas87C2SXcab445JnloMump8+zuad2rCcOQqTVvgCERLG5SZOsRBEQ6mC
         yGKsK4wMd2jS/Gx88c9GsLIolOvozw9QmT9sNa8KaiOTV6ya8lgOz2xKyC4I2rLqrR
         tDR5LG8+5XwgVXcVDBG5zxr7fF/rwlvxIR106KfEWHs5l4clStzXqhNPCX7VTg+uig
         a5XEXO7jUTBiA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m5koX-000eTJ-IH; Tue, 20 Jul 2021 10:09:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v6 3/9] PCI: kirin: Use regmap for APB registers
Date:   Tue, 20 Jul 2021 10:09:05 +0200
Message-Id: <1a96d568fa83f9569683f8bd3f61ebd97e67486f.1626768323.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626768323.git.mchehab+huawei@kernel.org>
References: <cover.1626768323.git.mchehab+huawei@kernel.org>
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
 drivers/pci/controller/dwc/pcie-kirin.c | 39 +++++++++++++++++--------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 558188476372..d21c332abc06 100644
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
 
@@ -340,6 +340,13 @@ static int hi3660_pcie_phy_init(struct platform_device *pdev,
  * The non-PHY part starts here
  */
 
+static const struct regmap_config pcie_kirin_regmap_conf = {
+	.name = "kirin_pcie_apb",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 /* Registers in PCIeCTRL */
 static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
 					 u32 val, u32 reg)
@@ -355,10 +362,17 @@ static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
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
@@ -368,13 +382,13 @@ static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
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
@@ -382,13 +396,13 @@ static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
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
@@ -448,8 +462,9 @@ static void kirin_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 static int kirin_pcie_link_up(struct dw_pcie *pci)
 {
 	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
-	u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_APB_PHY_STATUS0);
+	u32 val;
 
+	regmap_read(kirin_pcie->apb, PCIE_APB_PHY_STATUS0, &val);
 	if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
 		return 1;
 
@@ -461,8 +476,8 @@ static int kirin_pcie_start_link(struct dw_pcie *pci)
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

