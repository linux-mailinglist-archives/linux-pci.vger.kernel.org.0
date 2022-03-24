Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F8D4E9AF3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiC1PZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiC1PZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 11:25:55 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3151F20F43;
        Mon, 28 Mar 2022 08:24:11 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9CDE71E4927;
        Thu, 24 Mar 2022 04:37:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 9CDE71E4927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085875;
        bh=YHDoXGqf6E8cNElJu1pzjTb4ae5gfASGH9rwV01LRwM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=cl9w4alUyc2X20wszG/pxiIY4jAayLXou+HZF+RNuR499PpAie5YMfmil2KlHkCIO
         HAcxcYg4l92KTVBkZ/SXuR5Qqd4375SVJ8FiL43H14d8qNs0o+ngUpxy0aHUepxHNn
         PiEmdFQDIFlqQnw4EiU/Da/Zi7dTsYkhOG3HdBI4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:37:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/16] PCI: dwc: Simplify in/outbound iATU setup methods
Date:   Thu, 24 Mar 2022 04:37:27 +0300
Message-ID: <20220324013734.18234-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From maintainability and scalability points of view it has been wrong to
use different iATU inbound and outbound regions accessors for the viewport
and unrolled versions of the iATU CSRs mapping. Seeing the particular iATU
region-wise registers layout is almost fully compatible for different
IP-core versions, there were no much points in splitting the code up that
way since it was possible to implement a common windows setup methods for
both viewport and unrolled iATU CSRs spaces. While what we can observe in
the current driver implementation of these methods, is a lot of code
duplication, which consequently worsen the code readability,
maintainability and scalability. Note the current implementation is a bit
more performant than the one suggested in this commit since it implies
having less MMIO accesses. But the gain just doesn't worth having the
denoted difficulties especially seeing the iATU setup methods are mainly
called on the DW PCIe controller and peripheral devices initialization
stage.

Here we suggest to move the iATU viewport and unrolled CSR access
specifics in the dw_pcie_readl_atu() and dw_pcie_writel_atu() method, and
convert the dw_pcie_prog_outbound_atu() and
dw_pcie_prog_{ep_}inbound_atu() functions to being generic instead of
having a different methods for each viewport and unrolled types of iATU
CSRs mapping. Nothing complex really. First of all the dw_pcie_readl_atu()
and dw_pcie_writel_atu() are converted to accept relative iATU CSRs
address together with the iATU region direction (inbound or outbound) and
region index. If DW PCIe controller doesn't have the unrolled iATU CSRs
space, then the accessors will need to activate a iATU viewport based on
the specified direction and index, otherwise a base address for the
corresponding region CSRs will be calculated by means of the
PCIE_ATU_UNROLL_BASE() macro. The CSRs macro have been modified in
accordance with that logic in the pcie-designware.h header file.

The rest of the changes in this commit just concern converting the iATU
in-/out-bound setup methods and iATU regions detection procedure to be
compatible with the new accessors semantics. As a result we've dropped the
no more required dw_pcie_prog_outbound_atu_unroll(),
dw_pcie_prog_inbound_atu_unroll() and dw_pcie_iatu_detect_regions_unroll()
methods.

Note aside with the denoted code improvements, there is an additional
positive side effect of this change. If at some point an atomic iATU
configs setup procedure is required, it will be possible to be done with
no much effort just by adding the synchronization into the
dw_pcie_readl_atu() and dw_pcie_writel_atu() accessors.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-designware.c | 301 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h |  50 ++-
 2 files changed, 112 insertions(+), 239 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index b983128584ff..f1aa6e2e85fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -205,48 +205,67 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 		dev_err(pci->dev, "write DBI address failed\n");
 }
 
-static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
+static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 dir, u32 region, u32 reg)
 {
+	void __iomem *base;
 	int ret;
 	u32 val;
 
+	if (pci->iatu_unroll_enabled) {
+		base = pci->atu_base;
+		reg = reg + PCIE_ATU_UNROLL_BASE(dir, region);
+	} else {
+		base = pci->dbi_base;
+		reg = reg + PCIE_ATU_VIEWPORT_BASE;
+
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | region);
+	}
+
 	if (pci->ops && pci->ops->read_dbi)
-		return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
+		return pci->ops->read_dbi(pci, base, reg, 4);
 
-	ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
+	ret = dw_pcie_read(base + reg, 4, &val);
 	if (ret)
 		dev_err(pci->dev, "Read ATU address failed\n");
 
 	return val;
 }
 
-static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
+static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 dir, u32 region,
+			       u32 reg, u32 val)
 {
+	void __iomem *base;
 	int ret;
 
+	if (pci->iatu_unroll_enabled) {
+		base = pci->atu_base;
+		reg = reg + PCIE_ATU_UNROLL_BASE(dir, region);
+	} else {
+		base = pci->dbi_base;
+		reg = reg + PCIE_ATU_VIEWPORT_BASE;
+
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | region);
+	}
+
 	if (pci->ops && pci->ops->write_dbi) {
-		pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
+		pci->ops->write_dbi(pci, base, reg, 4, val);
 		return;
 	}
 
-	ret = dw_pcie_write(pci->atu_base + reg, 4, val);
+	ret = dw_pcie_write(base + reg, 4, val);
 	if (ret)
 		dev_err(pci->dev, "Write ATU address failed\n");
 }
 
-static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
+static inline u32 dw_pcie_readl_atu_ob(struct dw_pcie *pci, u32 region, u32 reg)
 {
-	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
-
-	return dw_pcie_readl_atu(pci, offset + reg);
+	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_OB, region, reg);
 }
 
-static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
-				     u32 val)
+static inline void dw_pcie_writel_atu_ob(struct dw_pcie *pci, u32 region, u32 reg,
+					 u32 val)
 {
-	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
-
-	dw_pcie_writel_atu(pci, offset + reg, val);
+	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_OB, region, reg, val);
 }
 
 static inline u32 dw_pcie_enable_ecrc(u32 val)
@@ -290,50 +309,6 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
-					     int index, int type,
-					     u64 cpu_addr, u64 pci_addr,
-					     u64 size)
-{
-	u32 retries, val;
-	u64 limit_addr = cpu_addr + size - 1;
-
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
-				 lower_32_bits(cpu_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
-				 upper_32_bits(cpu_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_LIMIT,
-				 lower_32_bits(limit_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_LIMIT,
-				 upper_32_bits(limit_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
-				 lower_32_bits(pci_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
-				 upper_32_bits(pci_addr));
-	val = type | PCIE_ATU_FUNC_NUM(func_no);
-	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
-		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (dw_pcie_ver_is(pci, 490A))
-		val = dw_pcie_enable_ecrc(val);
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
-				 PCIE_ATU_ENABLE);
-
-	/*
-	 * Make sure ATU enable takes effect before any subsequent config
-	 * and I/O accesses.
-	 */
-	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_ob_unroll(pci, index,
-					      PCIE_ATU_UNR_REGION_CTRL2);
-		if (val & PCIE_ATU_ENABLE)
-			return;
-
-		mdelay(LINK_WAIT_IATU);
-	}
-	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
-}
-
 static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 					int index, int type, u64 cpu_addr,
 					u64 pci_addr, u64 size)
@@ -344,49 +319,46 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
-	if (pci->iatu_unroll_enabled) {
-		dw_pcie_prog_outbound_atu_unroll(pci, func_no, index, type,
-						 cpu_addr, pci_addr, size);
-		return;
-	}
-
 	limit_addr = cpu_addr + size - 1;
 
-	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
-			   PCIE_ATU_REGION_OUTBOUND | index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
-			   lower_32_bits(cpu_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
-			   upper_32_bits(cpu_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
-			   lower_32_bits(limit_addr));
+	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
+			      lower_32_bits(cpu_addr));
+	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
+			      upper_32_bits(cpu_addr));
+
+	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
+			      lower_32_bits(limit_addr));
 	if (dw_pcie_ver_is_ge(pci, 460A))
-		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
-				   upper_32_bits(limit_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
-			   lower_32_bits(pci_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
-			   upper_32_bits(pci_addr));
+		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
+				      upper_32_bits(limit_addr));
+
+	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(pci_addr));
+	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(pci_addr));
+
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
+	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
+
+	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
+		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
 		mdelay(LINK_WAIT_IATU);
 	}
+
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
 
@@ -405,54 +377,15 @@ void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				    cpu_addr, pci_addr, size);
 }
 
-static u32 dw_pcie_readl_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg)
-{
-	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
-
-	return dw_pcie_readl_atu(pci, offset + reg);
-}
-
-static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
-				     u32 val)
+static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 region, u32 reg)
 {
-	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
-
-	dw_pcie_writel_atu(pci, offset + reg, val);
+	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, region, reg);
 }
 
-static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
-					   int index, int type,
-					   u64 cpu_addr, u8 bar)
+static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 region, u32 reg,
+					 u32 val)
 {
-	u32 retries, val;
-
-	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
-				 lower_32_bits(cpu_addr));
-	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
-				 upper_32_bits(cpu_addr));
-
-	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, type |
-				 PCIE_ATU_FUNC_NUM(func_no));
-	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
-				 PCIE_ATU_FUNC_NUM_MATCH_EN |
-				 PCIE_ATU_ENABLE |
-				 PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
-
-	/*
-	 * Make sure ATU enable takes effect before any subsequent config
-	 * and I/O accesses.
-	 */
-	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_ib_unroll(pci, index,
-					      PCIE_ATU_UNR_REGION_CTRL2);
-		if (val & PCIE_ATU_ENABLE)
-			return 0;
-
-		mdelay(LINK_WAIT_IATU);
-	}
-	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
-
-	return -EBUSY;
+	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, region, reg, val);
 }
 
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
@@ -460,65 +393,51 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 {
 	u32 retries, val;
 
-	if (pci->iatu_unroll_enabled)
-		return dw_pcie_prog_inbound_atu_unroll(pci, func_no, index, type,
-						       cpu_addr, bar);
-
-	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_INBOUND |
-			   index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, lower_32_bits(cpu_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET, upper_32_bits(cpu_addr));
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(cpu_addr));
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(cpu_addr));
 
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
-			   PCIE_ATU_FUNC_NUM(func_no));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE |
-			   PCIE_ATU_FUNC_NUM_MATCH_EN |
-			   PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, type |
+			      PCIE_ATU_FUNC_NUM(func_no));
+	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2,
+			      PCIE_ATU_ENABLE | PCIE_ATU_FUNC_NUM_MATCH_EN |
+			      PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
+		val = dw_pcie_readl_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
 		mdelay(LINK_WAIT_IATU);
 	}
+
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
-	return -EBUSY;
+	return -ETIMEDOUT;
 }
 
 void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 			 enum dw_pcie_region_type type)
 {
-	int region;
+	u32 dir;
 
 	switch (type) {
 	case DW_PCIE_REGION_INBOUND:
-		region = PCIE_ATU_REGION_INBOUND;
+		dir = PCIE_ATU_REGION_DIR_IB;
 		break;
 	case DW_PCIE_REGION_OUTBOUND:
-		region = PCIE_ATU_REGION_OUTBOUND;
+		dir = PCIE_ATU_REGION_DIR_OB;
 		break;
 	default:
 		return;
 	}
 
-	if (pci->iatu_unroll_enabled) {
-		if (region == PCIE_ATU_REGION_INBOUND) {
-			dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
-						 ~(u32)PCIE_ATU_ENABLE);
-		} else {
-			dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
-						 ~(u32)PCIE_ATU_ENABLE);
-		}
-	} else {
-		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
-	}
+	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
@@ -622,63 +541,29 @@ static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 	return false;
 }
 
-static void dw_pcie_iatu_detect_regions_unroll(struct dw_pcie *pci)
-{
-	int max_region, i, ob = 0, ib = 0;
-	u32 val;
-
-	max_region = min((int)pci->atu_size / 512, 256);
-
-	for (i = 0; i < max_region; i++) {
-		dw_pcie_writel_ob_unroll(pci, i, PCIE_ATU_UNR_LOWER_TARGET,
-					0x11110000);
-
-		val = dw_pcie_readl_ob_unroll(pci, i, PCIE_ATU_UNR_LOWER_TARGET);
-		if (val == 0x11110000)
-			ob++;
-		else
-			break;
-	}
-
-	for (i = 0; i < max_region; i++) {
-		dw_pcie_writel_ib_unroll(pci, i, PCIE_ATU_UNR_LOWER_TARGET,
-					0x11110000);
-
-		val = dw_pcie_readl_ib_unroll(pci, i, PCIE_ATU_UNR_LOWER_TARGET);
-		if (val == 0x11110000)
-			ib++;
-		else
-			break;
-	}
-	pci->num_ib_windows = ib;
-	pci->num_ob_windows = ob;
-}
-
 static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 {
-	int max_region, i, ob = 0, ib = 0;
+	int max_region, ob, ib;
 	u32 val;
 
-	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
-	max_region = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT) + 1;
+	if (pci->iatu_unroll_enabled) {
+		max_region = min((int)pci->atu_size / 512, 256);
+	} else {
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
+		max_region = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT) + 1;
+	}
 
-	for (i = 0; i < max_region; i++) {
-		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_OUTBOUND | i);
-		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, 0x11110000);
-		val = dw_pcie_readl_dbi(pci, PCIE_ATU_LOWER_TARGET);
-		if (val == 0x11110000)
-			ob++;
-		else
+	for (ob = 0; ob < max_region; ob++) {
+		dw_pcie_writel_atu_ob(pci, ob, PCIE_ATU_LOWER_TARGET, 0x11110000);
+		val = dw_pcie_readl_atu_ob(pci, ob, PCIE_ATU_LOWER_TARGET);
+		if (val != 0x11110000)
 			break;
 	}
 
-	for (i = 0; i < max_region; i++) {
-		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_INBOUND | i);
-		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, 0x11110000);
-		val = dw_pcie_readl_dbi(pci, PCIE_ATU_LOWER_TARGET);
-		if (val == 0x11110000)
-			ib++;
-		else
+	for (ib = 0; ib < max_region; ib++) {
+		dw_pcie_writel_atu_ib(pci, ib, PCIE_ATU_LOWER_TARGET, 0x11110000);
+		val = dw_pcie_readl_atu_ib(pci, ib, PCIE_ATU_LOWER_TARGET);
+		if (val != 0x11110000)
 			break;
 	}
 
@@ -707,12 +592,10 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 		if (!pci->atu_size)
 			/* Pick a minimal default, enough for 8 in and 8 out windows */
 			pci->atu_size = SZ_4K;
-
-		dw_pcie_iatu_detect_regions_unroll(pci);
-	} else {
-		dw_pcie_iatu_detect_regions(pci);
 	}
 
+	dw_pcie_iatu_detect_regions(pci);
+
 	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
 		"enabled" : "disabled");
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 449c5ad92edc..6adf0c957c3b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -103,10 +103,20 @@
 #define PCIE_VERSION_NUMBER		0x8F8
 #define PCIE_VERSION_TYPE		0x8FC
 
+/*
+ * iATU inbound and outbound windows CSRs. Before the IP-core v4.80a each
+ * iATU region CSRs had been indirectly accessible by means of the dedicated
+ * viewport selector. The iATU/eDMA CSRs space was re-designed in DWC PCIe
+ * v4.80a in a way so the viewport was unrolled into the directly accessible
+ * iATU/eDMA CSRs space.
+ */
 #define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		BIT(31)
-#define PCIE_ATU_REGION_OUTBOUND	0
-#define PCIE_ATU_CR1			0x904
+#define PCIE_ATU_REGION_DIR_IB		BIT(31)
+#define PCIE_ATU_REGION_DIR_OB		0
+#define PCIE_ATU_VIEWPORT_BASE		0x904
+#define PCIE_ATU_UNROLL_BASE(dir, region) \
+	(((region) << 9) | ((dir == PCIE_ATU_REGION_DIR_IB) ? BIT(8) : 0))
+#define PCIE_ATU_REGION_CTRL1		0x000
 #define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
 #define PCIE_ATU_TYPE_MEM		0x0
 #define PCIE_ATU_TYPE_IO		0x2
@@ -114,19 +124,19 @@
 #define PCIE_ATU_TYPE_CFG1		0x5
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
-#define PCIE_ATU_CR2			0x908
+#define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
-#define PCIE_ATU_LOWER_BASE		0x90C
-#define PCIE_ATU_UPPER_BASE		0x910
-#define PCIE_ATU_LIMIT			0x914
-#define PCIE_ATU_LOWER_TARGET		0x918
+#define PCIE_ATU_LOWER_BASE		0x008
+#define PCIE_ATU_UPPER_BASE		0x00C
+#define PCIE_ATU_LIMIT			0x010
+#define PCIE_ATU_LOWER_TARGET		0x014
 #define PCIE_ATU_BUS(x)			FIELD_PREP(GENMASK(31, 24), x)
 #define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
 #define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
-#define PCIE_ATU_UPPER_TARGET		0x91C
-#define PCIE_ATU_UPPER_LIMIT		0x924
+#define PCIE_ATU_UPPER_TARGET		0x018
+#define PCIE_ATU_UPPER_LIMIT		0x020
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
 #define PCIE_DBI_RO_WR_EN		BIT(0)
@@ -143,19 +153,6 @@
 
 #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
 
-/*
- * iATU Unroll-specific register definitions
- * From 4.80 core version the address translation will be made by unroll
- */
-#define PCIE_ATU_UNR_REGION_CTRL1	0x00
-#define PCIE_ATU_UNR_REGION_CTRL2	0x04
-#define PCIE_ATU_UNR_LOWER_BASE		0x08
-#define PCIE_ATU_UNR_UPPER_BASE		0x0C
-#define PCIE_ATU_UNR_LOWER_LIMIT	0x10
-#define PCIE_ATU_UNR_LOWER_TARGET	0x14
-#define PCIE_ATU_UNR_UPPER_TARGET	0x18
-#define PCIE_ATU_UNR_UPPER_LIMIT	0x20
-
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
@@ -164,13 +161,6 @@
  */
 #define DEFAULT_DBI_ATU_OFFSET (0x3 << 20)
 
-/* Register address builder */
-#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region) \
-		((region) << 9)
-
-#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
-		(((region) << 9) | BIT(8))
-
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
-- 
2.35.1

