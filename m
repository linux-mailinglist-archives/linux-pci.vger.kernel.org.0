Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF9527EB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 11:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfFYJWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 05:22:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10537 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfFYJWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 05:22:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d11e7f00000>; Tue, 25 Jun 2019 02:22:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Jun 2019 02:22:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Jun 2019 02:22:54 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Jun
 2019 09:22:53 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 25 Jun 2019 09:22:53 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d11e7e90001>; Tue, 25 Jun 2019 02:22:53 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>,
        <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V9 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
Date:   Tue, 25 Jun 2019 14:52:37 +0530
Message-ID: <20190625092238.13207-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625092238.13207-1-vidyas@nvidia.com>
References: <20190625092238.13207-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561454576; bh=4W87/rTvpn6JenPkyzuj9CngSv762Id5OLv2pVY7+Qg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=K9mv8oR9L+0broRGW1YkPBxZJs5bf7E9yG19ieX84rFHrCXG6jS4i43XTZaw54bBx
         qbNNhE/Mbxa1tPRyfotkrpAsRh4U8x7uaMS7lbaRjkZWTVyYcSPmkQhxZBO/TrSqnj
         4hTW2G77F9BL18u04RN6UfyvpnJVp8CwDz53bl5oEE9xDRWkdkHAfwhhoNv00KB3bd
         W79gv3CXnKWvTzLJ+2j87n7efNKIGLuCRUGlncHF8nQywAQ88eHheJgc9DISDFLCQC
         67NK6N7rQtEbz6A/fedOQ/DLcvBbwii80TGs00DyuAtJI6nTLjoVe6nnRnDpLQfQQb
         lIos3Re6kvTAw==
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
Changes from v8:
* Removed exporting dw_pcie_{read/write}_atu() APIs

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

 drivers/pci/controller/dwc/pcie-designware.c | 57 ++++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h | 34 ++++++------
 2 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d7c51c32b3b..c2843ea1d1e8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -52,68 +52,93 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
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

