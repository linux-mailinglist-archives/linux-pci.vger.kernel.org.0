Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4A2809D6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgJAWCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 18:02:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41982 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgJAWCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 18:02:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id y4so143572ljk.8
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2020 15:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+0iqnqR1+uN0pgQm+DWt3g7O2MdVYRWt5r0a7zSrgA=;
        b=kdK6oRXUsnqERuucg9YZVACPyAYXwyMjE+jBjIuWgrpRShvktodoasbz8rfPHbyNC9
         lRVo7/3bC59JgkStok52qHLhLdEYe2B2cUJlhjW94X326V1jYhU8AFCXqb3W/AG0fE03
         aEDmjE2dKsmiwyeKv5R99kXMS1VfksO99kkCx2rICXw0MfjBJCUGC8O24ywsVF7Hz5bR
         sSJq9SL3zoDYotwTMEt589rvih1FREXoCwD30O93/5l0Hcj175omODLwaL7uIQ6lQDKT
         f5CUYEW/vKrFPkT3TJTugL4k3xAKWFMQ50UuCSq/FhgObpBWv5A74PDo927Ucp+dUn5V
         cIrQ==
X-Gm-Message-State: AOAM530E3OFPS7WrrxGWgjbJgFJT2hTnyMju8RyId+eCY5THJ4TX1dua
        00o9BSxqSG4gJTm5gocYgVc=
X-Google-Smtp-Source: ABdhPJzxiz4ywkGK2++fFndUVni9+gOpIkzZCHiZNrN9W0+g0WvnhxG4vDFORBo9gt/sSS5qSz4cxw==
X-Received: by 2002:a2e:90c3:: with SMTP id o3mr2843247ljg.147.1601589765998;
        Thu, 01 Oct 2020 15:02:45 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f25sm582154ljn.29.2020.10.01.15.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 15:02:45 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3] PCI: Unify ECAM constants in native PCI Express drivers
Date:   Thu,  1 Oct 2020 22:02:44 +0000
Message-Id: <20201001220244.1271878-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unify ECAM-related constants into a single set of standard constants
defining memory address shift values for the byte-level address that can
be used when accessing the PCI Express Configuration Space, and then
move native PCI Express controller drivers to use newly introduced
definitions retiring any driver-specific ones.

The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
PCI Express specification (see PCI Express Base Specification, Revision
5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
implement it the same way.  Most of the native PCI Express controller
drivers define their ECAM-related constants, many of these could be
shared, or use open-coded values when setting the .bus_shift field of
the struct pci_ecam_ops.

All of the newly added constants should remove ambiguity and reduce the
number of open-coded values, and also correlate more strongly with the
descriptions in the aforementioned specification (see Table 7-1
"Enhanced Configuration Address Mapping", p. 677).

There is no change to functionality.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
Changes in v3:
  Updated commit message wording.
  Updated regarding custom ECAM bus shift values and concerning PCI base
  configuration space access for Type 1 access.
  Refactored rockchip_pcie_rd_other_conf() and rockchip_pcie_wr_other_conf()
  and removed the "busdev" variable.
  Removed surplus "relbus" variable from nwl_pcie_map_bus() and
  xilinx_pcie_map_bus().
  Renamed the PCIE_ECAM_ADDR() macro to PCIE_ECAM_OFFSET().

Changes in v2:
  Use PCIE_ECAM_ADDR macro when computing ECAM address offset, but drop
  PCI_SLOT and PCI_FUNC macros from the PCIE_ECAM_ADDR macro in favour
  of using a single value for the device/function.

 drivers/pci/controller/dwc/pcie-al.c        |  8 ++----
 drivers/pci/controller/dwc/pcie-hisi.c      |  4 +--
 drivers/pci/controller/pci-host-generic.c   |  4 +--
 drivers/pci/controller/pci-thunder-ecam.c   |  2 +-
 drivers/pci/controller/pci-thunder-pem.c    | 13 +++++++--
 drivers/pci/controller/pci-xgene.c          | 13 +++++++--
 drivers/pci/controller/pcie-rockchip-host.c | 27 +++++++++--------
 drivers/pci/controller/pcie-rockchip.h      |  8 +-----
 drivers/pci/controller/pcie-tango.c         |  2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c    |  9 ++----
 drivers/pci/controller/pcie-xilinx.c        | 11 ++-----
 drivers/pci/ecam.c                          |  4 +--
 include/linux/pci-ecam.h                    | 32 +++++++++++++++++++++
 13 files changed, 83 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index d57d4ee15848..7c2aa049113c 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -76,7 +76,7 @@ static int al_pcie_init(struct pci_config_window *cfg)
 }
 
 const struct pci_ecam_ops al_pcie_ops = {
-	.bus_shift    = 20,
+	.bus_shift    = PCIE_ECAM_BUS_SHIFT,
 	.init         =  al_pcie_init,
 	.pci_ops      = {
 		.map_bus    = al_pcie_map_bus,
@@ -138,8 +138,6 @@ struct al_pcie {
 	struct al_pcie_target_bus_cfg target_bus_cfg;
 };
 
-#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << 12)
-
 #define to_al_pcie(x)		dev_get_drvdata((x)->dev)
 
 static inline u32 al_pcie_controller_readl(struct al_pcie *pcie, u32 offset)
@@ -228,7 +226,7 @@ static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
 	void __iomem *pci_base_addr;
 
 	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
-					 (busnr_ecam << 20) +
+					 PCIE_ECAM_BUS(busnr_ecam) +
 					 PCIE_ECAM_DEVFN(devfn));
 
 	if (busnr_reg != target_bus_cfg->reg_val) {
@@ -300,7 +298,7 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 
 	target_bus_cfg = &pcie->target_bus_cfg;
 
-	ecam_bus_mask = (pcie->ecam_size >> 20) - 1;
+	ecam_bus_mask = (pcie->ecam_size >> PCIE_ECAM_BUS_SHIFT) - 1;
 	if (ecam_bus_mask > 255) {
 		dev_warn(pcie->dev, "ECAM window size is larger than 256MB. Cutting off at 256\n");
 		ecam_bus_mask = 255;
diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 5ca86796d43a..b7afbf1d4bd9 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -100,7 +100,7 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
 }
 
 const struct pci_ecam_ops hisi_pcie_ops = {
-	.bus_shift    = 20,
+	.bus_shift    = PCIE_ECAM_BUS_SHIFT,
 	.init         =  hisi_pcie_init,
 	.pci_ops      = {
 		.map_bus    = hisi_pcie_map_bus,
@@ -135,7 +135,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 }
 
 static const struct pci_ecam_ops hisi_pcie_platform_ops = {
-	.bus_shift    = 20,
+	.bus_shift    = PCIE_ECAM_BUS_SHIFT,
 	.init         =  hisi_pcie_platform_init,
 	.pci_ops      = {
 		.map_bus    = hisi_pcie_map_bus,
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index b51977abfdf1..593436aee7a0 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 
 static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
-	.bus_shift	= 16,
+	.bus_shift	= PCIE_CAM_BUS_SHIFT,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
 		.read		= pci_generic_config_read,
@@ -49,7 +49,7 @@ static void __iomem *pci_dw_ecam_map_bus(struct pci_bus *bus,
 }
 
 static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
-	.bus_shift	= 20,
+	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
 	.pci_ops	= {
 		.map_bus	= pci_dw_ecam_map_bus,
 		.read		= pci_generic_config_read,
diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index 7e8835fee5f7..22ed7e995b39 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -346,7 +346,7 @@ static int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
 }
 
 const struct pci_ecam_ops pci_thunder_ecam_ops = {
-	.bus_shift	= 20,
+	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
 	.pci_ops	= {
 		.map_bus        = pci_ecam_map_bus,
 		.read           = thunder_ecam_config_read,
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 3f847969143e..1a3f70ac61fc 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -19,6 +19,15 @@
 #define PEM_CFG_WR 0x28
 #define PEM_CFG_RD 0x30
 
+/*
+ * Enhanced Configuration Access Mechanism (ECAM)
+ *
+ * N.B. This is a non-standard platform-specific ECAM bus shift value.  For
+ * standard values defined in the PCI Express Base Specification see
+ * include/linux/pci-ecam.h.
+ */
+#define THUNDER_PCIE_ECAM_BUS_SHIFT	24
+
 struct thunder_pem_pci {
 	u32		ea_entry[3];
 	void __iomem	*pem_reg_base;
@@ -404,7 +413,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
 }
 
 const struct pci_ecam_ops thunder_pem_ecam_ops = {
-	.bus_shift	= 24,
+	.bus_shift	= THUNDER_PCIE_ECAM_BUS_SHIFT,
 	.init		= thunder_pem_acpi_init,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
@@ -441,7 +450,7 @@ static int thunder_pem_platform_init(struct pci_config_window *cfg)
 }
 
 static const struct pci_ecam_ops pci_thunder_pem_ops = {
-	.bus_shift	= 24,
+	.bus_shift	= THUNDER_PCIE_ECAM_BUS_SHIFT,
 	.init		= thunder_pem_platform_init,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 8e0db84f089d..e67e72818d24 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -60,6 +60,15 @@
 #define XGENE_PCIE_IP_VER_1		1
 #define XGENE_PCIE_IP_VER_2		2
 
+/*
+ * Enhanced Configuration Access Mechanism (ECAM)
+ *
+ * N.B. This is a non-standard platform-specific ECAM bus shift value.  For
+ * standard values defined in the PCI Express Base Specification see
+ * include/linux/pci-ecam.h.
+ */
+#define XGENE_PCIE_ECAM_BUS_SHIFT	16
+
 #if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 struct xgene_pcie_port {
 	struct device_node	*node;
@@ -257,7 +266,7 @@ static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
 }
 
 const struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
-	.bus_shift	= 16,
+	.bus_shift	= XGENE_PCIE_ECAM_BUS_SHIFT,
 	.init		= xgene_v1_pcie_ecam_init,
 	.pci_ops	= {
 		.map_bus	= xgene_pcie_map_bus,
@@ -272,7 +281,7 @@ static int xgene_v2_pcie_ecam_init(struct pci_config_window *cfg)
 }
 
 const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
-	.bus_shift	= 16,
+	.bus_shift	= XGENE_PCIE_ECAM_BUS_SHIFT,
 	.init		= xgene_v2_pcie_ecam_init,
 	.pci_ops	= {
 		.map_bus	= xgene_pcie_map_bus,
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 0bb2fb3e8a0b..4c069f8fa420 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -160,12 +160,11 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 *val)
 {
-	u32 busdev;
+	void __iomem *addr;
 
-	busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
-				PCI_FUNC(devfn), where);
+	addr = rockchip->reg_base + PCIE_ECAM_OFFSET(bus, devfn, where);
 
-	if (!IS_ALIGNED(busdev, size)) {
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
@@ -178,11 +177,11 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 						AXI_WRAPPER_TYPE1_CFG);
 
 	if (size == 4) {
-		*val = readl(rockchip->reg_base + busdev);
+		*val = readl(addr);
 	} else if (size == 2) {
-		*val = readw(rockchip->reg_base + busdev);
+		*val = readw(addr);
 	} else if (size == 1) {
-		*val = readb(rockchip->reg_base + busdev);
+		*val = readb(addr);
 	} else {
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
@@ -194,11 +193,11 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 val)
 {
-	u32 busdev;
+	void __iomem *addr;
 
-	busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
-				PCI_FUNC(devfn), where);
-	if (!IS_ALIGNED(busdev, size))
+	addr = rockchip->reg_base + PCIE_ECAM_OFFSET(bus, devfn, where);
+
+	if (!IS_ALIGNED((uintptr_t)addr, size))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pci_is_root_bus(bus->parent))
@@ -209,11 +208,11 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
 						AXI_WRAPPER_TYPE1_CFG);
 
 	if (size == 4)
-		writel(val, rockchip->reg_base + busdev);
+		writel(val, addr);
 	else if (size == 2)
-		writew(val, rockchip->reg_base + busdev);
+		writew(val, addr);
 	else if (size == 1)
-		writeb(val, rockchip->reg_base + busdev);
+		writeb(val, addr);
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index c7d0178fc8c2..1650a5087450 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
@@ -178,13 +179,6 @@
 #define MIN_AXI_ADDR_BITS_PASSED		8
 #define PCIE_RC_SEND_PME_OFF			0x11960
 #define ROCKCHIP_VENDOR_ID			0x1d87
-#define PCIE_ECAM_BUS(x)			(((x) & 0xff) << 20)
-#define PCIE_ECAM_DEV(x)			(((x) & 0x1f) << 15)
-#define PCIE_ECAM_FUNC(x)			(((x) & 0x7) << 12)
-#define PCIE_ECAM_REG(x)			(((x) & 0xfff) << 0)
-#define PCIE_ECAM_ADDR(bus, dev, func, reg) \
-	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
-	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
 #define PCIE_LINK_IS_L2(x) \
 	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
 #define PCIE_LINK_UP(x) \
diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
index d093a8ce4bb1..8f0d695afbde 100644
--- a/drivers/pci/controller/pcie-tango.c
+++ b/drivers/pci/controller/pcie-tango.c
@@ -208,7 +208,7 @@ static int smp8759_config_write(struct pci_bus *bus, unsigned int devfn,
 }
 
 static const struct pci_ecam_ops smp8759_ecam_ops = {
-	.bus_shift	= 20,
+	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
 		.read		= smp8759_config_read,
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index f3cf7d61924f..cfd12b75bacb 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -18,6 +18,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 #include <linux/irqchip/chained_irq.h>
 
@@ -124,8 +125,6 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define ECAM_BUS_LOC_SHIFT		20
-#define ECAM_DEV_LOC_SHIFT		12
 #define NWL_ECAM_VALUE_DEFAULT		12
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
@@ -240,15 +239,11 @@ static void __iomem *nwl_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 				      int where)
 {
 	struct nwl_pcie *pcie = bus->sysdata;
-	int relbus;
 
 	if (!nwl_pcie_valid_device(bus, devfn))
 		return NULL;
 
-	relbus = (bus->number << ECAM_BUS_LOC_SHIFT) |
-			(devfn << ECAM_DEV_LOC_SHIFT);
-
-	return pcie->ecam_base + relbus + where;
+	return pcie->ecam_base + PCIE_ECAM_OFFSET(bus, devfn, where);
 }
 
 /* PCIe operations */
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 8523be61bba5..49bde5266aa2 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -21,6 +21,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
 #include "../pci.h"
@@ -86,10 +87,6 @@
 /* Phy Status/Control Register definitions */
 #define XILINX_PCIE_REG_PSCR_LNKUP	BIT(11)
 
-/* ECAM definitions */
-#define ECAM_BUS_NUM_SHIFT		20
-#define ECAM_DEV_NUM_SHIFT		12
-
 /* Number of MSI IRQs */
 #define XILINX_NUM_MSI_IRQS		128
 
@@ -183,15 +180,11 @@ static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
 					 unsigned int devfn, int where)
 {
 	struct xilinx_pcie_port *port = bus->sysdata;
-	int relbus;
 
 	if (!xilinx_pcie_valid_device(bus, devfn))
 		return NULL;
 
-	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
-		 (devfn << ECAM_DEV_NUM_SHIFT);
-
-	return port->reg_base + relbus + where;
+	return port->reg_base + PCIE_ECAM_OFFSET(bus, devfn, where);
 }
 
 /* PCIe operations */
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 8f065a42fc1a..ffd010290084 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(pci_ecam_map_bus);
 
 /* ECAM ops */
 const struct pci_ecam_ops pci_generic_ecam_ops = {
-	.bus_shift	= 20,
+	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
 		.read		= pci_generic_config_read,
@@ -161,7 +161,7 @@ EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 /* ECAM ops for 32-bit access only (non-compliant) */
 const struct pci_ecam_ops pci_32b_ops = {
-	.bus_shift	= 20,
+	.bus_shift	= PCIE_ECAM_BUS_SHIFT,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
 		.read		= pci_generic_config_read32,
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 1af5cb02ef7f..2c22da6bf818 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -9,6 +9,38 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
+/*
+ * Memory address shift values for the byte-level address that
+ * can be used when accessing the PCI/PCI Express Configuration Space.
+ */
+
+/*
+ * Configuration Access Mechanism (CAM)
+ *
+ * See PCI Local Bus Specification, Revision 3.0, Section 3.2.2.3,
+ * p. 48 and Section 6.1, p. 213.
+ */
+#define PCIE_CAM_BUS_SHIFT	16 /* Bus Number */
+
+/*
+ * Enhanced Configuration Access Mechanism (ECAM)
+ *
+ * See PCI Express Base Specification, Revision 5.0, Version 1.0,
+ * Section 7.2.2, Table 7-1, p. 677.
+ */
+#define PCIE_ECAM_BUS_SHIFT	20 /* Bus Number */
+#define PCIE_ECAM_DEV_SHIFT	15 /* Device Number */
+#define PCIE_ECAM_FUN_SHIFT	12 /* Function Number */
+
+#define PCIE_ECAM_BUS(x)	(((x) & 0xff) << PCIE_ECAM_BUS_SHIFT)
+#define PCIE_ECAM_DEVFN(x)	(((x) & 0xff) << PCIE_ECAM_FUN_SHIFT)
+#define PCIE_ECAM_REG(x)	((x) & 0xfff)
+
+#define PCIE_ECAM_OFFSET(bus, devfn, where) \
+    (PCIE_ECAM_BUS(bus->number) | \
+     PCIE_ECAM_DEVFN(devfn) | \
+     PCIE_ECAM_REG(where))
+
 /*
  * struct to hold pci ops and bus shift of the config window
  * for a PCI controller.
-- 
2.28.0

