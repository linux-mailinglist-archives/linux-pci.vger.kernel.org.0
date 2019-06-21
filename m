Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0BE4E6CC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 13:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFULKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 07:10:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18169 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFULKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 07:10:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0cbb1b0000>; Fri, 21 Jun 2019 04:10:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Jun 2019 04:10:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Jun 2019 04:10:18 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 11:10:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 21 Jun 2019 11:10:17 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0cbb160006>; Fri, 21 Jun 2019 04:10:17 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>,
        <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V6 2/3] PCI: dwc: Cleanup DBI read and write APIs
Date:   Fri, 21 Jun 2019 16:39:59 +0530
Message-ID: <20190621111000.23216-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621111000.23216-1-vidyas@nvidia.com>
References: <20190621111000.23216-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561115419; bh=lSZpqxENkfZm7Btf0tL75ssIGOD+mPsCNofvGh0MYps=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UgB/ZsYRrZYvpXtTdF0VGiZkQODMiLuROFAGnPwb/KXVvIbrAb+xgJHDs5YeYy1Kt
         eGohvleudkY/UAvi+oLNJ9U2lWWwHqwH6NWD2Nc0m07M9OCpQn9Znx50LQe0dpYMt4
         4nj1Vqm4Z1PShLBvIs9nIbRSTXHIuelyrnbQ1a6OrzSbYravgY+YKvRiRb2jYGNfx3
         xk/pmUcnqNROI1NmfabtXx0MfguThhmgdyEX8XaNMujcfeYwN2WhBRtP7k/t5F6bdP
         qk72NUMIT9HqPwfiKVat18rn9HVIEwXYlK+5kcW+65FxslpkUdsdp2i22qHe57My2R
         rjifgQfP3CCQQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cleanup DBI read and write APIs by removing "__" (underscore) from their
names as there are no no-underscore versions and the underscore versions
are already doing what no-underscore versions typically do. It also removes
passing dbi/dbi2 base address as one of the arguments as the same can be
derived with in read and write APIs.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes from v5:
* Removed passing base address as one of the arguments as the same can be derived within
  the API itself.
* Modified ATU read/write APIs to call dw_pcie_{write/read}() API

Changes from v4:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-designware.c | 28 ++++++-------
 drivers/pci/controller/dwc/pcie-designware.h | 43 ++++++++++++--------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d7c51c32b3b..0b383feb13de 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -52,64 +52,60 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
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
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 14762e262758..88300b445a4d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -254,14 +254,10 @@ struct dw_pcie {
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
 int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
@@ -275,52 +271,63 @@ void dw_pcie_setup(struct dw_pcie *pci);
 
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
+	int ret;
+
+	ret = dw_pcie_write(pci->atu_base + reg, 0x4, val);
+	if (ret)
+		dev_err(pci->dev, "write ATU address failed\n");
 }
 
 static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
+	int ret;
+	u32 val;
+
+	ret = dw_pcie_read(pci->atu_base + reg, 0x4, &val);
+	if (ret)
+		dev_err(pci->dev, "Read ATU address failed\n");
+
+	return val;
 }
 
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
-- 
2.17.1

