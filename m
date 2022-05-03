Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7105190A3
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbiECVuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbiECVuw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:50:52 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61D1E41F8F;
        Tue,  3 May 2022 14:47:10 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3A5A416D6;
        Wed,  4 May 2022 00:47:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 3A5A416D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651614463;
        bh=WT00ZbR+w6jwt4WBUJuJVvHf0aV4obNAwQHDxx9D8gY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=n+B2HXEtfN/FvbEqPYl31kjuuxx6VETmxz5hFzbvDNpQxaU4OxhBkazbMzp9UuNNt
         5g7nLKtzCG15Skqa4GIaL4drLCmyR3ZZE+2Y1ckQaYyuY/rZXKeFKiTQ2xBEdzVZvS
         AzbJtEZMaQo5m+Q+hpq7NxZRu44UTVqOl+HsGloA=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:47:09 +0300
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
Subject: [PATCH v2 09/17] PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
Date:   Wed, 4 May 2022 00:46:30 +0300
Message-ID: <20220503214638.1895-10-Sergey.Semin@baikalelectronics.ru>
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

There is no point in having an enumeration declared in the driver for the
PCIe end-point. First of all it's redundant since the driver already has a
set of macro declared which describe the available in/out iATU types, thus
having an addition abstraction just needlessly complicates the code.
Secondly checking the passed iATU type for validity within a single driver
is pointless since the driver is supposed to be consistent by its nature.
Finally the outbound iATU type isn't encoded by the denoted enumeration,
thus giving a false impression that the in and out iATU types are
unrelated while they are the same. So to speak let's drop the redundant
dw_pcie_as_type enumeration replacing it with the direct iATU type usage.

While at it, since we are touching the iATU inbound regions config methods
anyway, let's fix the arguments order so the type would be followed by the
address-related parameters. Thus the inbound and outbound iATU setup
methods will look alike. That shall improve the code readability a bit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++------
 drivers/pci/controller/dwc/pcie-designware.c  | 35 +++----------------
 drivers/pci/controller/dwc/pcie-designware.h  |  9 +----
 3 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1be8bbf35047..6ce44c12ea1c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -154,9 +154,8 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
-static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
-				  enum pci_barno bar, dma_addr_t cpu_addr,
-				  enum dw_pcie_as_type as_type)
+static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
+				  dma_addr_t cpu_addr, enum pci_barno bar)
 {
 	int ret;
 	u32 free_win;
@@ -168,8 +167,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, bar, cpu_addr,
-				       as_type);
+	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, type,
+				       cpu_addr, bar);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
@@ -221,27 +220,25 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epf_bar *epf_bar)
 {
-	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
 	int flags = epf_bar->flags;
-	enum dw_pcie_as_type as_type;
-	u32 reg;
 	unsigned int func_offset = 0;
+	int ret, type;
+	u32 reg;
 
 	func_offset = dw_pcie_ep_func_select(ep, func_no);
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
 
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
-		as_type = DW_PCIE_AS_MEM;
+		type = PCIE_ATU_TYPE_MEM;
 	else
-		as_type = DW_PCIE_AS_IO;
+		type = PCIE_ATU_TYPE_IO;
 
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, bar,
-				     epf_bar->phys_addr, as_type);
+	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index dd2e4335d85a..4edfc95e0213 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -421,10 +421,9 @@ static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 }
 
 static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
-					   int index, int bar, u64 cpu_addr,
-					   enum dw_pcie_as_type as_type)
+					   int index, int type,
+					   u64 cpu_addr, u8 bar)
 {
-	int type;
 	u32 retries, val;
 
 	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
@@ -432,17 +431,6 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(cpu_addr));
 
-	switch (as_type) {
-	case DW_PCIE_AS_MEM:
-		type = PCIE_ATU_TYPE_MEM;
-		break;
-	case DW_PCIE_AS_IO:
-		type = PCIE_ATU_TYPE_IO;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, type |
 				 PCIE_ATU_FUNC_NUM(func_no));
 	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
@@ -468,32 +456,19 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 }
 
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-			     int bar, u64 cpu_addr,
-			     enum dw_pcie_as_type as_type)
+			     int type, u64 cpu_addr, u8 bar)
 {
-	int type;
 	u32 retries, val;
 
 	if (pci->iatu_unroll_enabled)
-		return dw_pcie_prog_inbound_atu_unroll(pci, func_no, index, bar,
-						       cpu_addr, as_type);
+		return dw_pcie_prog_inbound_atu_unroll(pci, func_no, index, type,
+						       cpu_addr, bar);
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_INBOUND |
 			   index);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, lower_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET, upper_32_bits(cpu_addr));
 
-	switch (as_type) {
-	case DW_PCIE_AS_MEM:
-		type = PCIE_ATU_TYPE_MEM;
-		break;
-	case DW_PCIE_AS_IO:
-		type = PCIE_ATU_TYPE_IO;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
 			   PCIE_ATU_FUNC_NUM(func_no));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE |
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index bca1d3e83636..449c5ad92edc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -227,12 +227,6 @@ struct pcie_port {
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
-enum dw_pcie_as_type {
-	DW_PCIE_AS_UNKNOWN,
-	DW_PCIE_AS_MEM,
-	DW_PCIE_AS_IO,
-};
-
 struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
@@ -331,8 +325,7 @@ void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  int type, u64 cpu_addr, u64 pci_addr,
 				  u64 size);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-			     int bar, u64 cpu_addr,
-			     enum dw_pcie_as_type as_type);
+			     int type, u64 cpu_addr, u8 bar);
 void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 			 enum dw_pcie_region_type type);
 void dw_pcie_setup(struct dw_pcie *pci);
-- 
2.35.1

