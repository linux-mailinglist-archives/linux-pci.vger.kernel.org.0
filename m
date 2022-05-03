Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75A5519088
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiECVvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243244AbiECVuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:50:54 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FDC64248E;
        Tue,  3 May 2022 14:47:16 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5EC7716D8;
        Wed,  4 May 2022 00:47:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5EC7716D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651614469;
        bh=m53g+8ajTrFSc0CrpMLFgWTOnowufy4KqbWQUuipL3M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bEqv64Ubr5dEnSdEPMujx4k4X/ePrsfsYGitl05fEw8lr7FT4raCSf1Wdi1A2bM59
         i/p8gGJ5cDRa4LM0glInnwX3fbMeuStQFSXz4IBQpUGcZw7z67vUV2tzK7fvgx1anw
         NzSy7Sy1fq8ADpoSA0pl4KCP+7n8QGld1OL/e0x8=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:47:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/17] PCI: dwc: Check iATU in/outbound ranges setup methods status
Date:   Wed, 4 May 2022 00:46:35 +0300
Message-ID: <20220503214638.1895-15-Sergey.Semin@baikalelectronics.ru>
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

Let's make the DWC PCIe RC/EP safer and more verbose for the invalid or
failed inbound and outbound iATU windows setups. Needless to say that
silently ignoring iATU regions setup errors may cause unpredictable
errors. For instance if for some reason a cfg or IO window fails to be
activated, then any CFG/IO requested won't reach target PCIe devices and
the corresponding accessors will return platform-specific random values.

First of all we need to convert dw_pcie_ep_outbound_atu() method to check
whether the specified outbound iATU range is successfully setup. That
method is called by the pci_epc_ops.map_addr callback. Thus we'll make the
EP-specific CPU->PCIe memory mappings saver.

Secondly since the iATU outbound range programming method now returns the
operation status, it will be handy to take that status into account in the
pci_ops.{map_bus,read,write} methods. Thus any failed mapping will be
immediately noticeable by the PCIe CFG operations requesters.

Finally we need to convert the dw_pcie_setup_rc() method to returning the
operation status, since the iATU outbound ranges setup procedure may now
fail. It will be especially handy in case if the DW PCIe RC DT-node has
invalid/unsupported (dma-)ranges property. Note since the suggested
modification causes having too wide code indentation, it is reasonable
from maintainability and readability points of view to move the outbound
ranges setup procedure in the separate function.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |   9 +-
 .../pci/controller/dwc/pcie-designware-host.c | 149 ++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |   5 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |   6 +-
 4 files changed, 112 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 68ad3d250450..c62640201246 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -184,8 +184,9 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 				   phys_addr_t phys_addr,
 				   u64 pci_addr, size_t size)
 {
-	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	u32 free_win;
+	int ret;
 
 	free_win = find_first_zero_bit(ep->ob_window_map, pci->num_ob_windows);
 	if (free_win >= pci->num_ob_windows) {
@@ -193,8 +194,10 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
-				     phys_addr, pci_addr, size);
+	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
+					   phys_addr, pci_addr, size);
+	if (ret)
+		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
 	ep->outbound_addr[free_win] = phys_addr;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ade31a04f9df..7caca6c575a5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -411,7 +411,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_iatu_detect(pci);
 
-	dw_pcie_setup_rc(pp);
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto err_free_msi;
 
 	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
@@ -467,10 +469,10 @@ EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 						unsigned int devfn, int where)
 {
-	int type;
-	u32 busdev;
 	struct pcie_port *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	int type, ret;
+	u32 busdev;
 
 	/*
 	 * Checking whether the link is up here is a last line of defense
@@ -491,8 +493,10 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 	else
 		type = PCIE_ATU_TYPE_CFG1;
 
-
-	dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev, pp->cfg0_size);
+	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
+					pp->cfg0_size);
+	if (ret)
+		return NULL;
 
 	return pp->va_cfg0_base + where;
 }
@@ -505,12 +509,18 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
 
-	if (!ret && pci->io_cfg_atu_shared)
-		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
-					  pp->io_bus_addr, pp->io_size);
+	if (pci->io_cfg_atu_shared) {
+		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
+						pp->io_base, pp->io_bus_addr,
+						pp->io_size);
+		if (ret)
+			return PCIBIOS_SET_FAILED;
+	}
 
-	return ret;
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
@@ -521,12 +531,18 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
 
-	if (!ret && pci->io_cfg_atu_shared)
-		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
-					  pp->io_bus_addr, pp->io_size);
+	if (pci->io_cfg_atu_shared) {
+		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
+						pp->io_base, pp->io_bus_addr,
+						pp->io_size);
+		if (ret)
+			return PCIBIOS_SET_FAILED;
+	}
 
-	return ret;
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops dw_child_pcie_ops = {
@@ -583,10 +599,72 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_own_conf,
 };
 
-void dw_pcie_setup_rc(struct pcie_port *pp)
+static int dw_pcie_iatu_setup(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct resource_entry *entry;
+	int i, ret;
+
+	/* Note the very first outbound ATU is used for CFG IOs */
+	if (!pci->num_ob_windows) {
+		dev_err(pci->dev, "No outbound iATU found\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Ensure all outbound windows are disabled before proceeding with
+	 * the MEM/IO ranges setups.
+	 */
+	for (i = 0; i < pci->num_ob_windows; i++)
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
+
+	i = 0;
+	resource_list_for_each_entry(entry, &pp->bridge->windows) {
+		if (resource_type(entry->res) != IORESOURCE_MEM)
+			continue;
+
+		if (pci->num_ob_windows <= ++i)
+			break;
+
+		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
+						entry->res->start,
+						entry->res->start - entry->offset,
+						resource_size(entry->res));
+		if (ret) {
+			dev_err(pci->dev, "Failed to set MEM range %pr\n",
+				entry->res);
+			return ret;
+		}
+	}
+
+	if (pp->io_size) {
+		if (pci->num_ob_windows > ++i) {
+			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
+							pp->io_base,
+							pp->io_bus_addr,
+							pp->io_size);
+			if (ret) {
+				dev_err(pci->dev, "Failed to set IO range %pr\n",
+					entry->res);
+				return ret;
+			}
+		} else {
+			pci->io_cfg_atu_shared = true;
+		}
+	}
+
+	if (pci->num_ob_windows <= i)
+		dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
+			 pci->num_ob_windows);
+
+	return 0;
+}
+
+int dw_pcie_setup_rc(struct pcie_port *pp)
 {
-	u32 val, ctrl, num_ctrls;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u32 val, ctrl, num_ctrls;
+	int ret;
 
 	/*
 	 * Enable DBI read-only registers for writing/updating configuration.
@@ -641,42 +719,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * ATU, so we should not program the ATU here.
 	 */
 	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
-		int i, atu_idx = 0;
-		struct resource_entry *entry;
-
-		/*
-		 * Ensure all outbound windows are disabled so there are
-		 * multiple matches
-		 */
-		for (i = 0; i < pci->num_ob_windows; i++)
-			dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
-
-		/* Get last memory resource entry */
-		resource_list_for_each_entry(entry, &pp->bridge->windows) {
-			if (resource_type(entry->res) != IORESOURCE_MEM)
-				continue;
-
-			if (pci->num_ob_windows <= ++atu_idx)
-				break;
-
-			dw_pcie_prog_outbound_atu(pci, atu_idx,
-						  PCIE_ATU_TYPE_MEM, entry->res->start,
-						  entry->res->start - entry->offset,
-						  resource_size(entry->res));
-		}
-
-		if (pp->io_size) {
-			if (pci->num_ob_windows > ++atu_idx)
-				dw_pcie_prog_outbound_atu(pci, atu_idx,
-							  PCIE_ATU_TYPE_IO, pp->io_base,
-							  pp->io_bus_addr, pp->io_size);
-			else
-				pci->io_cfg_atu_shared = true;
-		}
-
-		if (pci->num_ob_windows <= atu_idx)
-			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
-				 pci->num_ob_windows);
+		ret = dw_pcie_iatu_setup(pp);
+		if (ret)
+			return ret;
 	}
 
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
@@ -689,5 +734,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f0aa2c823b5d..3f9527537403 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -373,7 +373,7 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
-void dw_pcie_setup_rc(struct pcie_port *pp);
+int dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 void dw_pcie_host_deinit(struct pcie_port *pp);
 int dw_pcie_allocate_domains(struct pcie_port *pp);
@@ -385,8 +385,9 @@ static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	return IRQ_NONE;
 }
 
-static inline void dw_pcie_setup_rc(struct pcie_port *pp)
+static inline int dw_pcie_setup_rc(struct pcie_port *pp)
 {
+	return 0;
 }
 
 static inline int dw_pcie_host_init(struct pcie_port *pp)
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 786af2ba379f..c3bafaa803de 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -306,7 +306,11 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 	intel_pcie_ltssm_disable(pcie);
 	intel_pcie_link_setup(pcie);
 	intel_pcie_init_n_fts(pci);
-	dw_pcie_setup_rc(&pci->pp);
+
+	ret = dw_pcie_setup_rc(&pci->pp);
+	if (ret)
+		goto app_init_err;
+
 	dw_pcie_upconfig_setup(pci);
 
 	intel_pcie_device_rst_deassert(pcie);
-- 
2.35.1

