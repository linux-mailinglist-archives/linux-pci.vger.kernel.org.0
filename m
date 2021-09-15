Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49240BCB8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 02:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhIOAp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 20:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhIOAp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 20:45:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B77C061574;
        Tue, 14 Sep 2021 17:44:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g128so836507wma.5;
        Tue, 14 Sep 2021 17:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oda9yIUowZdNGMEotGdkv+DFh0qifNeEfT2k118ZMG8=;
        b=AHb/DSDMngli1ry3VlwEGZTGvXwDkex+jKyujZHqn7ad7dPUPlGdm/m6yIiom9X2qI
         XPnxk3LOclbz5azFQsJ1j4QnZFX+FhGkpul8nFbFkxyuU0drQPhxxkhAc7BwPsRKpg2F
         qTh53dS8pn0xLHq+EhzwoEVSmHIfIc7T+PU3Z/y7Hocfv870oqvzsFM+jMd382dLJtPE
         8Kkj+NiND1PrAmm1XNctQkPy/C1ZOeAz4EsJ+I5Iut+hkdIQiWzvAdWSFCVH0HBIULsp
         OFSV+zmb6jrDOTH49QdSyQwYg3YRwqTFEKIis2q1mmLS61OGOzF+l0gYP5M4672zUKYd
         z0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oda9yIUowZdNGMEotGdkv+DFh0qifNeEfT2k118ZMG8=;
        b=uhh9uS9xE5or4zoy/OOb/fx2QRfZQmB8u4wRKCLgiML+rzo4s60qhOrzKAwsW//E69
         mvY8wsu6aBT/XyMXkOnBSktxZtHsHoIrpaDiNsY5rDatrgyVg18fD50GFzge8HC7sSws
         4HEVQSYQfXiOkHZxzFEaedSeT0ZREjC9RForW1GsldY5mb9VGMKwQpdxlklfF7WifRqp
         v9Ng3rDngOHHreFBsbyQDvI/eoL8A8zwM/wS+DPrBTz520/Zreq3D+Vafn3vtUtXsxkK
         Q+MA+G8Tf3w3CRrTtJxnTQahJi5jDYRhd0Eh9TKyTNcybmKljw51k08ilX8od7v3TCzH
         xvLg==
X-Gm-Message-State: AOAM531odm6an+CGMJ+iBT53KBc0VQ3p6EvA/HGujrEqoUxrGrZFibnV
        EFeafIbCOjvxXY20UKFfx2I=
X-Google-Smtp-Source: ABdhPJyxhxBRTlNW8kx7TX3nh7jif5kMURIaShZXaPAaCmn09H0uXdUx/NUTEIex9JDlyJyKWcy0Ww==
X-Received: by 2002:a1c:2684:: with SMTP id m126mr1710030wmm.65.1631666679576;
        Tue, 14 Sep 2021 17:44:39 -0700 (PDT)
Received: from claire-ThinkPad-T470.mediaways.net (dynamic-2a01-0c23-bddc-6f00-623e-e407-1ad5-867f.c23.pool.telefonica.de. [2a01:c23:bddc:6f00:623e:e407:1ad5:867f])
        by smtp.gmail.com with ESMTPSA id j7sm14654198wrr.27.2021.09.14.17.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 17:44:39 -0700 (PDT)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn.helgaas@gmail.com, toan@os.amperecomputing.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: xgene: Adjust struct name to convention
Date:   Wed, 15 Sep 2021 02:44:32 +0200
Message-Id: <20210915004432.19788-1-ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

struct pci-xgene does not match the convention struct of other pci driver,
namely <dirver>_pcie. Adjust xgene_pcie_port to xgene_pcie.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 46 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index e64536047b65..e2b93ccab901 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -61,7 +61,7 @@
 #define XGENE_PCIE_IP_VER_2		2
 
 #if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
-struct xgene_pcie_port {
+struct xgene_pcie {
 	struct device_node	*node;
 	struct device		*dev;
 	struct clk		*clk;
@@ -72,12 +72,12 @@ struct xgene_pcie_port {
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
@@ -87,15 +87,15 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
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
@@ -104,7 +104,7 @@ static inline struct xgene_pcie_port *pcie_bus_to_port(struct pci_bus *bus)
  */
 static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 
 	if (bus->number >= (bus->primary + 1))
 		return port->cfg_base + AXI_EP_CFG_ACCESS;
@@ -118,7 +118,7 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
  */
 static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 	unsigned int b, d, f;
 	u32 rtdid_val = 0;
 
@@ -165,7 +165,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 
 	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
 	    PCIBIOS_SUCCESSFUL)
@@ -228,7 +228,7 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 {
 	struct device *dev = cfg->parent;
 	struct acpi_device *adev = to_acpi_device(dev);
-	struct xgene_pcie_port *port;
+	struct xgene_pcie *port;
 	struct resource csr;
 	int ret;
 
@@ -282,7 +282,7 @@ const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
 #endif
 
 #if defined(CONFIG_PCI_XGENE)
-static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
+static u64 xgene_pcie_set_ib_mask(struct xgene_pcie *port, u32 addr,
 				  u32 flags, u64 size)
 {
 	u64 mask = (~(size - 1) & PCI_BASE_ADDRESS_MEM_MASK) | flags;
@@ -308,7 +308,7 @@ static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
 	return mask;
 }
 
-static void xgene_pcie_linkup(struct xgene_pcie_port *port,
+static void xgene_pcie_linkup(struct xgene_pcie *port,
 			      u32 *lanes, u32 *speed)
 {
 	u32 val32;
@@ -323,7 +323,7 @@ static void xgene_pcie_linkup(struct xgene_pcie_port *port,
 	}
 }
 
-static int xgene_pcie_init_port(struct xgene_pcie_port *port)
+static int xgene_pcie_init_port(struct xgene_pcie *port)
 {
 	struct device *dev = port->dev;
 	int rc;
@@ -343,7 +343,7 @@ static int xgene_pcie_init_port(struct xgene_pcie_port *port)
 	return 0;
 }
 
-static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
+static int xgene_pcie_map_reg(struct xgene_pcie *port,
 			      struct platform_device *pdev)
 {
 	struct device *dev = port->dev;
@@ -363,7 +363,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
 	return 0;
 }
 
-static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
+static void xgene_pcie_setup_ob_reg(struct xgene_pcie *port,
 				    struct resource *res, u32 offset,
 				    u64 cpu_addr, u64 pci_addr)
 {
@@ -395,7 +395,7 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
 	xgene_pcie_writel(port, offset + 0x14, upper_32_bits(pci_addr));
 }
 
-static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
+static void xgene_pcie_setup_cfg_reg(struct xgene_pcie *port)
 {
 	u64 addr = port->cfg_addr;
 
@@ -404,7 +404,7 @@ static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
 	xgene_pcie_writel(port, CFGCTL, EN_REG);
 }
 
-static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
+static int xgene_pcie_map_ranges(struct xgene_pcie *port)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
 	struct resource_entry *window;
@@ -445,7 +445,7 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
 	return 0;
 }
 
-static void xgene_pcie_setup_pims(struct xgene_pcie_port *port, u32 pim_reg,
+static void xgene_pcie_setup_pims(struct xgene_pcie *port, u32 pim_reg,
 				  u64 pim, u64 size)
 {
 	xgene_pcie_writel(port, pim_reg, lower_32_bits(pim));
@@ -479,7 +479,7 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 	return -EINVAL;
 }
 
-static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
+static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
 				    struct resource_entry *entry,
 				    u8 *ib_reg_mask)
 {
@@ -530,7 +530,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
 }
 
-static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
+static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *port)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
 	struct resource_entry *entry;
@@ -543,7 +543,7 @@ static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 }
 
 /* clear BAR configuration which was done by firmware */
-static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
+static void xgene_pcie_clear_config(struct xgene_pcie *port)
 {
 	int i;
 
@@ -551,7 +551,7 @@ static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
 		xgene_pcie_writel(port, i, 0);
 }
 
-static int xgene_pcie_setup(struct xgene_pcie_port *port)
+static int xgene_pcie_setup(struct xgene_pcie *port)
 {
 	struct device *dev = port->dev;
 	u32 val, lanes = 0, speed = 0;
@@ -589,7 +589,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
-	struct xgene_pcie_port *port;
+	struct xgene_pcie *port;
 	struct pci_host_bridge *bridge;
 	int ret;
 
-- 
2.25.1

