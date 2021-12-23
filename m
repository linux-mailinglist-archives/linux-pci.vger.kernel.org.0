Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AEA47DCBC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbhLWBM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbhLWBLv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE5AC061756;
        Wed, 22 Dec 2021 17:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B1CA3CE1F05;
        Thu, 23 Dec 2021 01:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7BEC36AEA;
        Thu, 23 Dec 2021 01:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221908;
        bh=nS4jZXintt2/E8Abk/nP0Fk/9b5PD0tHeYSlLq6cHOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUvff4NOpoMHiKn9owcavbgXndI9pASWDCl9B285UyXHqdoSbo6qPW4Z9MsyvTiDQ
         bd9kL/nfDFHosHieTg58wCePz9FGJLioHc7HEq2GWSAH8fYV51dTu7hottYqZwN8KT
         R/kzDUomx0ZPFiYpYN7Gl4tKrYbcGYnwMU8YbkN9usgJVgXzDvC6SpGEfkQMtzfQJJ
         okMa7epMeY2E3jrtkKcQkZyCPwEBhu4/GK3S5Xcbvv420dz90ctsy6rM0s8D5cp8SQ
         PHWM6+wGzZXKdBzA37/t+AGbsI/qYA/1h96nSJRP/pl/kwrcoS2DD4Ed9m43/9RkJW
         v3c7WSEl6j2CA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Toan Le <toan@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 21/23] PCI: xgene: Rename xgene_pcie_port to xgene_pcie
Date:   Wed, 22 Dec 2021 19:10:52 -0600
Message-Id: <20211223011054.1227810-22-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

Rename struct xgene_pcie_port to xgene_pcie to match the convention of
<driver>_pcie. No functional change intended.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Toan Le <toan@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pci-xgene.c | 46 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 56d0d50338c8..ba11f369a1c9 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -60,7 +60,7 @@
 #define XGENE_PCIE_IP_VER_2		2
 
 #if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
-struct xgene_pcie_port {
+struct xgene_pcie {
 	struct device_node	*node;
 	struct device		*dev;
 	struct clk		*clk;
@@ -71,12 +71,12 @@ struct xgene_pcie_port {
 	u32			version;
 };
 
-static u32 xgene_pcie_readl(struct xgene_pcie_port *port, u32 reg)
+static u32 xgene_pcie_readl(struct xgene_pcie *port, u32 reg)
 {
 	return readl(port->csr_base + reg);
 }
 
-static void xgene_pcie_writel(struct xgene_pcie_port *port, u32 reg, u32 val)
+static void xgene_pcie_writel(struct xgene_pcie *port, u32 reg, u32 val)
 {
 	writel(val, port->csr_base + reg);
 }
@@ -86,15 +86,15 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
 	return (addr & PCI_BASE_ADDRESS_MEM_MASK) | flags;
 }
 
-static inline struct xgene_pcie_port *pcie_bus_to_port(struct pci_bus *bus)
+static inline struct xgene_pcie *pcie_bus_to_port(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
 
 	if (acpi_disabled)
-		return (struct xgene_pcie_port *)(bus->sysdata);
+		return (struct xgene_pcie *)(bus->sysdata);
 
 	cfg = bus->sysdata;
-	return (struct xgene_pcie_port *)(cfg->priv);
+	return (struct xgene_pcie *)(cfg->priv);
 }
 
 /*
@@ -103,7 +103,7 @@ static inline struct xgene_pcie_port *pcie_bus_to_port(struct pci_bus *bus)
  */
 static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 
 	if (bus->number >= (bus->primary + 1))
 		return port->cfg_base + AXI_EP_CFG_ACCESS;
@@ -117,7 +117,7 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
  */
 static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 	unsigned int b, d, f;
 	u32 rtdid_val = 0;
 
@@ -164,7 +164,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 
 	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
 	    PCIBIOS_SUCCESSFUL)
@@ -227,7 +227,7 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 {
 	struct device *dev = cfg->parent;
 	struct acpi_device *adev = to_acpi_device(dev);
-	struct xgene_pcie_port *port;
+	struct xgene_pcie *port;
 	struct resource csr;
 	int ret;
 
@@ -281,7 +281,7 @@ const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
 #endif
 
 #if defined(CONFIG_PCI_XGENE)
-static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
+static u64 xgene_pcie_set_ib_mask(struct xgene_pcie *port, u32 addr,
 				  u32 flags, u64 size)
 {
 	u64 mask = (~(size - 1) & PCI_BASE_ADDRESS_MEM_MASK) | flags;
@@ -307,7 +307,7 @@ static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
 	return mask;
 }
 
-static void xgene_pcie_linkup(struct xgene_pcie_port *port,
+static void xgene_pcie_linkup(struct xgene_pcie *port,
 			      u32 *lanes, u32 *speed)
 {
 	u32 val32;
@@ -322,7 +322,7 @@ static void xgene_pcie_linkup(struct xgene_pcie_port *port,
 	}
 }
 
-static int xgene_pcie_init_port(struct xgene_pcie_port *port)
+static int xgene_pcie_init_port(struct xgene_pcie *port)
 {
 	struct device *dev = port->dev;
 	int rc;
@@ -342,7 +342,7 @@ static int xgene_pcie_init_port(struct xgene_pcie_port *port)
 	return 0;
 }
 
-static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
+static int xgene_pcie_map_reg(struct xgene_pcie *port,
 			      struct platform_device *pdev)
 {
 	struct device *dev = port->dev;
@@ -362,7 +362,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
 	return 0;
 }
 
-static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
+static void xgene_pcie_setup_ob_reg(struct xgene_pcie *port,
 				    struct resource *res, u32 offset,
 				    u64 cpu_addr, u64 pci_addr)
 {
@@ -394,7 +394,7 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
 	xgene_pcie_writel(port, offset + 0x14, upper_32_bits(pci_addr));
 }
 
-static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
+static void xgene_pcie_setup_cfg_reg(struct xgene_pcie *port)
 {
 	u64 addr = port->cfg_addr;
 
@@ -403,7 +403,7 @@ static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
 	xgene_pcie_writel(port, CFGCTL, EN_REG);
 }
 
-static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
+static int xgene_pcie_map_ranges(struct xgene_pcie *port)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
 	struct resource_entry *window;
@@ -444,7 +444,7 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
 	return 0;
 }
 
-static void xgene_pcie_setup_pims(struct xgene_pcie_port *port, u32 pim_reg,
+static void xgene_pcie_setup_pims(struct xgene_pcie *port, u32 pim_reg,
 				  u64 pim, u64 size)
 {
 	xgene_pcie_writel(port, pim_reg, lower_32_bits(pim));
@@ -478,7 +478,7 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 	return -EINVAL;
 }
 
-static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
+static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
 				    struct resource_entry *entry,
 				    u8 *ib_reg_mask)
 {
@@ -529,7 +529,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
 }
 
-static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
+static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *port)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
 	struct resource_entry *entry;
@@ -542,7 +542,7 @@ static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 }
 
 /* clear BAR configuration which was done by firmware */
-static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
+static void xgene_pcie_clear_config(struct xgene_pcie *port)
 {
 	int i;
 
@@ -550,7 +550,7 @@ static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
 		xgene_pcie_writel(port, i, 0);
 }
 
-static int xgene_pcie_setup(struct xgene_pcie_port *port)
+static int xgene_pcie_setup(struct xgene_pcie *port)
 {
 	struct device *dev = port->dev;
 	u32 val, lanes = 0, speed = 0;
@@ -588,7 +588,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
-	struct xgene_pcie_port *port;
+	struct xgene_pcie *port;
 	struct pci_host_bridge *bridge;
 	int ret;
 
-- 
2.25.1

