Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23167500FA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 07:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfFXF0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 01:26:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18507 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXF0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 01:26:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d105f040000>; Sun, 23 Jun 2019 22:26:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 23 Jun 2019 22:26:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 23 Jun 2019 22:26:28 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 05:26:28 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 05:26:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Jun 2019 05:26:27 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d105f010000>; Sun, 23 Jun 2019 22:26:27 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>,
        <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V8 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
Date:   Mon, 24 Jun 2019 10:56:10 +0530
Message-ID: <20190624052611.11279-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624052611.11279-1-vidyas@nvidia.com>
References: <20190624052611.11279-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561353988; bh=Q5KtHhjmCT+FXbhbad830ukA49mvxxZ/sqsTCmXtdkU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WtNLZyqZTGurW7uQ/9X0hbZbF1LcAyF3yP63+uil4HsKqfkUP/0XGYLmCbTuuYP0X
         MgHxiSJyEIcQAak9pcyvqlFNx6DtMopbJwoM36F0oLoF8dZ5humPYs0ZxzkRYuxcTy
         nGSGs/izkB0IsP9Yv9Hom2UijgK5aW46UKLSQpreojq9hlsC3z6VZtGg2TUaYfcx0g
         9he++60te795lkidV90fuQ13D6RoA4eGEwfSEF2DCheVw+80xxc4VakV6W7IH62cnJ
         PS699dX47XYD8ljLyMMcmwBom2Z/7ZegWlNNpLOznsxAEos7KwYKW91Ahyp9mGc8P2
         pHD8aDd/6r4mw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cleanup DBI read and write APIs by removing "__" (underscore) from their
names as there are no no-underscore versions and the underscore versions
are already doing what no-underscore versions typically do. It also removes
passing dbi/dbi2 base address as one of the arguments as the same can be
derived with in read and write APIs. Since dw_pcie_{readl/writel}_dbi()
APIs can't be used for ATU read/write as ATU base address could be
different from DBI base address, this patch attempts to implement
ATU read/write APIs using ATU base address without using
dw_pcie_{readl/writel}_dbi() APIs.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes from v7:
* Based on suggestion from Jingoo Han, moved implementation of readl, writel for ATU
  region to separate APIs dw_pcie_{read/write}_atu() in pcie-designware.c file and
  calling them from pcie-designware.h file.

Changes from v6:
* Modified ATU read/write APIs to use implementation specific DBI read/write
  APIs if present.

Changes from v5:
* Removed passing base address as one of the arguments as the same can be derived within
  the API itself.
* Modified ATU read/write APIs to call dw_pcie_{write/read}() API

Changes from v4:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-designware.c | 28 +++++------
 drivers/pci/controller/dwc/pcie-designware.h | 51 +++++++++++++-------
 2 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d7c51c32b3b..665a76f11318 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -52,68 +52,95 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-		       size_t size)
+u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
 {
 	int ret;
 	u32 val;
 
 	if (pci->ops->read_dbi)
-		return pci->ops->read_dbi(pci, base, reg, size);
+		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
 
-	ret = dw_pcie_read(base + reg, size, &val);
+	ret = dw_pcie_read(pci->dbi_base + reg, size, &val);
 	if (ret)
 		dev_err(pci->dev, "Read DBI address failed\n");
 
 	return val;
 }
 
-void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			 size_t size, u32 val)
+void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
 	if (pci->ops->write_dbi) {
-		pci->ops->write_dbi(pci, base, reg, size, val);
+		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
 		return;
 	}
 
-	ret = dw_pcie_write(base + reg, size, val);
+	ret = dw_pcie_write(pci->dbi_base + reg, size, val);
 	if (ret)
 		dev_err(pci->dev, "Write DBI address failed\n");
 }
 
-u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			size_t size)
+u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size)
 {
 	int ret;
 	u32 val;
 
 	if (pci->ops->read_dbi2)
-		return pci->ops->read_dbi2(pci, base, reg, size);
+		return pci->ops->read_dbi2(pci, pci->dbi_base2, reg, size);
 
-	ret = dw_pcie_read(base + reg, size, &val);
+	ret = dw_pcie_read(pci->dbi_base2 + reg, size, &val);
 	if (ret)
 		dev_err(pci->dev, "read DBI address failed\n");
 
 	return val;
 }
 
-void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			  size_t size, u32 val)
+void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
 	if (pci->ops->write_dbi2) {
-		pci->ops->write_dbi2(pci, base, reg, size, val);
+		pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
 		return;
 	}
 
-	ret = dw_pcie_write(base + reg, size, val);
+	ret = dw_pcie_write(pci->dbi_base2 + reg, size, val);
 	if (ret)
 		dev_err(pci->dev, "write DBI address failed\n");
 }
 
+u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size)
+{
+	int ret;
+	u32 val;
+
+	if (pci->ops->read_dbi)
+		return pci->ops->read_dbi(pci, pci->atu_base, reg, size);
+
+	ret = dw_pcie_read(pci->atu_base + reg, size, &val);
+	if (ret)
+		dev_err(pci->dev, "Read ATU address failed\n");
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_read_atu);
+
+void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
+{
+	int ret;
+
+	if (pci->ops->write_dbi) {
+		pci->ops->write_dbi(pci, pci->atu_base, reg, size, val);
+		return;
+	}
+
+	ret = dw_pcie_write(pci->atu_base + reg, size, val);
+	if (ret)
+		dev_err(pci->dev, "Write ATU address failed\n");
+}
+EXPORT_SYMBOL_GPL(dw_pcie_write_atu);
+
 static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 14762e262758..ffed084a0b4f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -254,14 +254,12 @@ struct dw_pcie {
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 
-u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-		       size_t size);
-void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			 size_t size, u32 val);
-u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			size_t size);
-void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			  size_t size, u32 val);
+u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
+void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
+u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size);
+void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
+u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
+void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
@@ -275,52 +273,52 @@ void dw_pcie_setup(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
+	dw_pcie_write_dbi(pci, reg, 0x4, val);
 }
 
 static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
+	return dw_pcie_read_dbi(pci, reg, 0x4);
 }
 
 static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
 {
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
+	dw_pcie_write_dbi(pci, reg, 0x2, val);
 }
 
 static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
+	return dw_pcie_read_dbi(pci, reg, 0x2);
 }
 
 static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
 {
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
+	dw_pcie_write_dbi(pci, reg, 0x1, val);
 }
 
 static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
+	return dw_pcie_read_dbi(pci, reg, 0x1);
 }
 
 static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	__dw_pcie_write_dbi2(pci, pci->dbi_base2, reg, 0x4, val);
+	dw_pcie_write_dbi2(pci, reg, 0x4, val);
 }
 
 static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi2(pci, pci->dbi_base2, reg, 0x4);
+	return dw_pcie_read_dbi2(pci, reg, 0x4);
 }
 
 static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
+	dw_pcie_write_atu(pci, reg, 0x4, val);
 }
 
 static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
+	return dw_pcie_read_atu(pci, reg, 0x4);
 }
 
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
-- 
2.17.1

