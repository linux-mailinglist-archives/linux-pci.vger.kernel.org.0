Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A64D4E361
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 11:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFUJVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 05:21:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14721 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJVs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 05:21:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0ca1aa0001>; Fri, 21 Jun 2019 02:21:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Jun 2019 02:21:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Jun 2019 02:21:47 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 09:21:47 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 21 Jun 2019 09:21:47 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0ca1a80000>; Fri, 21 Jun 2019 02:21:46 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <Jisheng.Zhang@synaptics.com>, <thierry.reding@gmail.com>,
        <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V5 2/3] PCI: dwc: Cleanup DBI read and write APIs
Date:   Fri, 21 Jun 2019 14:51:26 +0530
Message-ID: <20190621092127.17930-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621092127.17930-1-vidyas@nvidia.com>
References: <20190621092127.17930-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561108906; bh=gUSSSIrVqrmoGoE/GpE6TwYgyp2qpDNo/uHMFwCOUbc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=R4Fg8mu0G9f6lne7V97M57cwZp9dMnHyOs1P/4iqT5Tn0XhjIDa7wpuuf6vsk0lIf
         I/i88vlmsBZ9Z18KsRaLd64yzT82yb5TqT7kB2CcPfpiob8y1aKFptDGX4gVcNtOc5
         Rq260Hhx/k+1nQQI3wGxeodlhCpFIm/D6HFZwfKV6h5vk38FseJyVdtC+5xqvAUa1O
         PvL5EXtNSI/fRJ1bQ3dPGbBK7L8LNWrrnSbwOPlkazoPqqNbe694G96FHY05yRvRZT
         dW0TM2lHC6h3csNxuQK/0zqYi1Cm7eon2Pfj3io23U4TldpInyhLdccY9xPyFBeynx
         0YTRPWFkOQKbw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cleanup DBI read and write APIs by removing "__" (underscore) from their
names as there are no no-underscore versions and the underscore versions
are already doing what no-underscore versions typically do.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes from v4:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-designware.c | 16 ++++-----
 drivers/pci/controller/dwc/pcie-designware.h | 36 ++++++++++----------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d7c51c32b3b..5d22028d854e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -52,8 +52,8 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-		       size_t size)
+u32 dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		     size_t size)
 {
 	int ret;
 	u32 val;
@@ -68,8 +68,8 @@ u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 	return val;
 }
 
-void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			 size_t size, u32 val)
+void dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		       size_t size, u32 val)
 {
 	int ret;
 
@@ -83,8 +83,8 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		dev_err(pci->dev, "Write DBI address failed\n");
 }
 
-u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			size_t size)
+u32 dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		      size_t size)
 {
 	int ret;
 	u32 val;
@@ -99,8 +99,8 @@ u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
 	return val;
 }
 
-void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			  size_t size, u32 val)
+void dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			size_t size, u32 val)
 {
 	int ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 14762e262758..1f6858385602 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -254,14 +254,14 @@ struct dw_pcie {
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
+u32 dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		     size_t size);
+void dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		       size_t size, u32 val);
+u32 dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		      size_t size);
+void dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
@@ -275,52 +275,52 @@ void dw_pcie_setup(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
+	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
 }
 
 static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
+	return dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
 }
 
 static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
 {
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
+	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
 }
 
 static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
+	return dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
 }
 
 static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
 {
-	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
+	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
 }
 
 static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
+	return dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
 }
 
 static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	__dw_pcie_write_dbi2(pci, pci->dbi_base2, reg, 0x4, val);
+	dw_pcie_write_dbi2(pci, pci->dbi_base2, reg, 0x4, val);
 }
 
 static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi2(pci, pci->dbi_base2, reg, 0x4);
+	return dw_pcie_read_dbi2(pci, pci->dbi_base2, reg, 0x4);
 }
 
 static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
+	dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
 }
 
 static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
+	return dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
 }
 
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
-- 
2.17.1

