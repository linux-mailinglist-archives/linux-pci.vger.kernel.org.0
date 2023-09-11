Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2051979B590
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbjIKViz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjIKKcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 06:32:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4232120;
        Mon, 11 Sep 2023 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694428367; x=1725964367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DmVsQV3zOT9DX7Yw/gra0oxWL2x43W4fLVBXzfwaRcc=;
  b=kAVbRW0ySMZcckN7/b++bvW0Duip5r04psYC9w9FIXx+bLrXK57t4A9c
   hw/D+Bw/hStOn41H7rif4Sc56C0I3/DL7CHsGSkARVVyACiOzw2d79sa/
   FtNetwGThmScsQovUh+plLfvBvywO2UcpckFhQT6kB+lwbAijUe/QvkDp
   yyShaorAWR0cteRaEL/7FANfPqRNG90Ay+71kjQ4rlD8SFQzxME+7mw/P
   uW8MGw2+AKhaO0e96k5NtXdJS3hsjkgQ6nzDdnMURkrpaDTPamWS1mjFj
   DwccJ8mrAqCyD0692ybe15NkIIxRWAoXjFAay1A1S6klIMjBy/DYUf4FA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="376960758"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="376960758"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="990052842"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="990052842"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2023 03:32:43 -0700
From:   sharath.kumar.d.m@intel.com
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, dinguyen@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org, sharath.kumar.d.m@intel.com
Subject: [PATCH 1/2] PCI: altera: refactor driver for supporting new platforms
Date:   Mon, 11 Sep 2023 16:03:19 +0530
Message-Id: <20230911103319.1770292-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908195242.GA304243@bhelgaas>
References: <20230908195242.GA304243@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

added the below callbacks that eases is supporting newer platforms
for read/write to root port configuration space registers
for read/write to non root port (endpoint, switch) cfg space regs
root port interrupt handler

Signed-off-by: D M Sharath Kumar <sharath.kumar.d.m@intel.com>
---
 drivers/pci/controller/pcie-altera.c | 100 +++++++++++++++++++--------
 1 file changed, 70 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index a9536dc4bf96..878f86b1cc6b 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -3,6 +3,7 @@
  * Copyright Altera Corporation (C) 2013-2015. All rights reserved
  *
  * Author: Ley Foon Tan <lftan@altera.com>
+ * Author: sharath <sharath.kumar.d.m@intel.com>
  * Description: Altera PCIe host controller driver
  */
 
@@ -99,10 +100,15 @@ struct altera_pcie_ops {
 	void (*tlp_write_pkt)(struct altera_pcie *pcie, u32 *headers,
 			      u32 data, bool align);
 	bool (*get_link_status)(struct altera_pcie *pcie);
-	int (*rp_read_cfg)(struct altera_pcie *pcie, int where,
-			   int size, u32 *value);
+	int (*rp_read_cfg)(struct altera_pcie *pcie, u8 busno,
+			unsigned int devfn, int where, int size, u32 *value);
 	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 busno,
-			    int where, int size, u32 value);
+			unsigned int devfn, int where, int size, u32 value);
+	int (*nonrp_read_cfg)(struct altera_pcie *pcie, u8 busno,
+			unsigned int devfn, int where, int size, u32 *value);
+	int (*nonrp_write_cfg)(struct altera_pcie *pcie, u8 busno,
+			unsigned int devfn, int where, int size, u32 value);
+	void (*rp_isr)(struct irq_desc *desc);
 };
 
 struct altera_pcie_data {
@@ -379,8 +385,8 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int s10_rp_read_cfg(struct altera_pcie *pcie, int where,
-			   int size, u32 *value)
+static int s10_rp_read_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
+		int where, int size, u32 *value)
 {
 	void __iomem *addr = S10_RP_CFG_ADDR(pcie, where);
 
@@ -399,7 +405,7 @@ static int s10_rp_read_cfg(struct altera_pcie *pcie, int where,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
+static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
 			    int where, int size, u32 value)
 {
 	void __iomem *addr = S10_RP_CFG_ADDR(pcie, where);
@@ -426,18 +432,13 @@ static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
-				 unsigned int devfn, int where, int size,
-				 u32 *value)
+static int arr_read_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
+		int where, int size, u32 *value)
 {
 	int ret;
 	u32 data;
 	u8 byte_en;
 
-	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops->rp_read_cfg)
-		return pcie->pcie_data->ops->rp_read_cfg(pcie, where,
-							 size, value);
-
 	switch (size) {
 	case 1:
 		byte_en = 1 << (where & 3);
@@ -470,18 +471,13 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
-				  unsigned int devfn, int where, int size,
-				  u32 value)
+static int arr_write_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
+			    int where, int size, u32 value)
 {
 	u32 data32;
 	u32 shift = 8 * (where & 3);
 	u8 byte_en;
 
-	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops->rp_write_cfg)
-		return pcie->pcie_data->ops->rp_write_cfg(pcie, busno,
-						     where, size, value);
-
 	switch (size) {
 	case 1:
 		data32 = (value & 0xff) << shift;
@@ -499,6 +495,35 @@ static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
 
 	return tlp_cfg_dword_write(pcie, busno, devfn, (where & ~DWORD_MASK),
 				   byte_en, data32);
+
+}
+
+static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
+				 unsigned int devfn, int where, int size,
+				 u32 *value)
+{
+	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops->rp_read_cfg)
+		return pcie->pcie_data->ops->rp_read_cfg(pcie, busno, devfn,
+							where, size, value);
+
+	if (pcie->pcie_data->ops->nonrp_read_cfg)
+		return pcie->pcie_data->ops->nonrp_read_cfg(pcie, busno, devfn,
+							where, size, value);
+	return PCIBIOS_FUNC_NOT_SUPPORTED;
+}
+
+static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
+				  unsigned int devfn, int where, int size,
+				  u32 value)
+{
+	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops->rp_write_cfg)
+		return pcie->pcie_data->ops->rp_write_cfg(pcie, busno, devfn,
+						     where, size, value);
+
+	if (pcie->pcie_data->ops->nonrp_write_cfg)
+		return pcie->pcie_data->ops->nonrp_write_cfg(pcie, busno, devfn,
+						     where, size, value);
+	return PCIBIOS_FUNC_NOT_SUPPORTED;
 }
 
 static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
@@ -660,7 +685,6 @@ static void altera_pcie_isr(struct irq_desc *desc)
 				dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n", bit);
 		}
 	}
-
 	chained_irq_exit(chip, desc);
 }
 
@@ -691,9 +715,13 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 {
 	struct platform_device *pdev = pcie->pdev;
 
-	pcie->cra_base = devm_platform_ioremap_resource_byname(pdev, "Cra");
-	if (IS_ERR(pcie->cra_base))
-		return PTR_ERR(pcie->cra_base);
+	if ((pcie->pcie_data->version == ALTERA_PCIE_V1) ||
+		(pcie->pcie_data->version == ALTERA_PCIE_V2)) {
+		pcie->cra_base =
+			devm_platform_ioremap_resource_byname(pdev, "Cra");
+		if (IS_ERR(pcie->cra_base))
+			return PTR_ERR(pcie->cra_base);
+	}
 
 	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
 		pcie->hip_base =
@@ -707,7 +735,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
+	irq_set_chained_handler_and_data(pcie->irq,
+		pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -720,6 +749,11 @@ static const struct altera_pcie_ops altera_pcie_ops_1_0 = {
 	.tlp_read_pkt = tlp_read_packet,
 	.tlp_write_pkt = tlp_write_packet,
 	.get_link_status = altera_pcie_link_up,
+	.rp_read_cfg = arr_read_cfg,
+	.rp_write_cfg = arr_write_cfg,
+	.nonrp_read_cfg = arr_read_cfg,
+	.nonrp_write_cfg = arr_write_cfg,
+	.rp_isr = altera_pcie_isr,
 };
 
 static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
@@ -728,6 +762,9 @@ static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
 	.get_link_status = s10_altera_pcie_link_up,
 	.rp_read_cfg = s10_rp_read_cfg,
 	.rp_write_cfg = s10_rp_write_cfg,
+	.nonrp_read_cfg = arr_read_cfg,
+	.nonrp_write_cfg = arr_write_cfg,
+	.rp_isr = altera_pcie_isr,
 };
 
 static const struct altera_pcie_data altera_pcie_1_0_data = {
@@ -792,11 +829,14 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* clear all interrupts */
-	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
-	/* enable all interrupts */
-	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
-	altera_pcie_host_init(pcie);
+	if ((pcie->pcie_data->version == ALTERA_PCIE_V1) ||
+		(pcie->pcie_data->version == ALTERA_PCIE_V2)) {
+		/* clear all interrupts */
+		cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
+		/* enable all interrupts */
+		cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
+		altera_pcie_host_init(pcie);
+	}
 
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_bus_nr;
-- 
2.34.1

