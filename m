Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07A3519085
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbiECVvP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243241AbiECVux (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:50:53 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F0D541F93;
        Tue,  3 May 2022 14:47:14 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EE33C16D6;
        Wed,  4 May 2022 00:47:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru EE33C16D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651614467;
        bh=DE07tde5EIYdsFG7YTpf4YolgyrqiTMh/YtdqPmWpgw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QK8g8i8MN3UK7s3ux/31qZgRw56IQDC6AUnxbyt/klWtQdaSQ8kYhQ7yANW/z4EBr
         drnBT9UOmPnflsxyMsj4TkIHxjWGVbVqas4W5Cm2+IlbPpKaXtJBNxy8C+jqWI5+Xc
         L0xpOzb9GhjUPkYJX/5RmLoU1AWIg9YvOEX9kvZY=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:47:13 +0300
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
Subject: [PATCH v2 13/17] PCI: dwc: Verify in/out regions against iATU constraints
Date:   Wed, 4 May 2022 00:46:34 +0300
Message-ID: <20220503214638.1895-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
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

Since the DWC PCIe driver private data now contains the iATU inbound and
outbound regions constraints info like alignment, minimum and maximum
limits, we can use them to make the in- and outbound iATU regions setup
methods more strict to the ranges a callee tries to specify.  That will
give us the safer dw_pcie_prog_outbound_atu(),
dw_pcie_prog_ep_outbound_atu() and dw_pcie_prog_inbound_atu() functions.

First of all let's update the outbound ATU entries setup methods to
returning the operation status. The methods will fail either in case if
the range is failed to be activated or the passed region doesn't fulfill
iATU constraints. Secondly the passed to the
dw_pcie_prog_{ep_}outbound_atu() methods region-related parameters are
verified against the detected iATU regions constraints. In particular the
region limit address must not overflow the lower/upper limit CSR RW-fields
otherwise the specified range will be just silently clamped. That
verification will also protect the code from having u64 type overflow.
Secondly let's make sure base address (CPU-address), target address
(PCI-address) and size are properly aligned. Unaligned ranges will be
silently aligned down (addresses) and up (limit) on writing the values to
the corresponding registers, which in it turn may lead to unpredictable
results like ranges virtual overlap. Finally the CPU-address alignment
needs to be verified in the dw_pcie_prog_inbound_atu() method too as the
DWC PCIe RC/EP registers manual demands seeing the lower bits of the in-
and outbound iATU base address are always zeros.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-designware.c | 39 +++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h | 10 ++---
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 1cc5e3b2fa6d..747e252c09e6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -8,6 +8,7 @@
  * Author: Jingoo Han <jg1.han@samsung.com>
  */
 
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/of.h>
@@ -308,9 +309,9 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
-					int index, int type, u64 cpu_addr,
-					u64 pci_addr, u64 size)
+static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
+				       int index, int type, u64 cpu_addr,
+				       u64 pci_addr, u64 size)
 {
 	u32 retries, val;
 	u64 limit_addr;
@@ -320,6 +321,13 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 
 	limit_addr = cpu_addr + size - 1;
 
+	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(pci_addr, pci->region_align) ||
+	    !IS_ALIGNED(size, pci->region_align) || !size) {
+		return -EINVAL;
+	}
+
 	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
 			      lower_32_bits(cpu_addr));
 	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
@@ -353,27 +361,29 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
 		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
-			return;
+			return 0;
 
 		mdelay(LINK_WAIT_IATU);
 	}
 
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
+
+	return -ETIMEDOUT;
 }
 
-void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			       u64 cpu_addr, u64 pci_addr, u64 size)
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
+			      u64 cpu_addr, u64 pci_addr, u64 size)
 {
-	__dw_pcie_prog_outbound_atu(pci, 0, index, type,
-				    cpu_addr, pci_addr, size);
+	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
+					   cpu_addr, pci_addr, size);
 }
 
-void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				  int type, u64 cpu_addr, u64 pci_addr,
-				  u64 size)
+int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
+				 int type, u64 cpu_addr, u64 pci_addr,
+				 u64 size)
 {
-	__dw_pcie_prog_outbound_atu(pci, func_no, index, type,
-				    cpu_addr, pci_addr, size);
+	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
+					   cpu_addr, pci_addr, size);
 }
 
 static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
@@ -392,6 +402,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 {
 	u32 retries, val;
 
+	if (!IS_ALIGNED(cpu_addr, pci->region_align))
+		return -EINVAL;
+
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
 			      lower_32_bits(cpu_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index faf42f2b2ff3..f0aa2c823b5d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -304,12 +304,10 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
-			       int type, u64 cpu_addr, u64 pci_addr,
-			       u64 size);
-void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				  int type, u64 cpu_addr, u64 pci_addr,
-				  u64 size);
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
+			      u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
+				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 			     int type, u64 cpu_addr, u8 bar);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
-- 
2.35.1

