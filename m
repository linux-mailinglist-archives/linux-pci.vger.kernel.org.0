Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF73255155
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 00:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0Wto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 18:49:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32879 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgH0Wto (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2020 18:49:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13so4871561ljm.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2020 15:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8guBDHGjG+NXSlHB3kHDy5xgM5YtuXUahDS/pmCCuk=;
        b=UxgGq5D9GN65oCrVbcfW3/csHlatLlvCMBYp3+DGzuZgBRuzZR0yPDTS6TikyWmbMi
         Vh78mr79v2fN9JxE+EL56VF9RxKQBvRKIvBSjarnWWuw9u4T9QNygIRu40w4HLAfLDuN
         GJXVNUyTCXs+MQgsH9D1veENmdFO40LN093n1XcyLOHO+YDPy1xHjr7BSAj3RYjo+SN9
         kJyS4CZxWvurWewk1pBp0DvYKnQ1QPe2i7G1Biq8VK6YUQrhLq29YP0+lseohwGBJTnv
         27QB0mbU46Z0AGrBYJJCAiYrJy6BFTmwD96p2Pxd453JiBU+tdjmlvQVLjlIAVhb4i1n
         LWqw==
X-Gm-Message-State: AOAM530X2IauSEx22gHQWqWN7AdT/z6FJz2JeHDFxdLCMEMbTJEeVoES
        HPsH8jKwPJJaMvpXwbqkRgM=
X-Google-Smtp-Source: ABdhPJxOC3xKvhgVIuof/riZ/pKkqoZd0UZtg0P/WSQCdJEpWYwWE/3gGCENoUL7Q2Y7MvAke3dfJA==
X-Received: by 2002:a2e:330e:: with SMTP id d14mr10506470ljc.407.1598568580262;
        Thu, 27 Aug 2020 15:49:40 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i20sm756489ljb.90.2020.08.27.15.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:49:39 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: Unify ECAM constants in native PCI Express drivers
Date:   Thu, 27 Aug 2020 22:49:38 +0000
Message-Id: <20200827224938.977757-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unify ECAM-related constants into a single set of standard constants
defining memory address shift values for the byte-level address that can
be used when accessing the PCI Express Configuration Space, and then
move native PCI Express controller drivers to use newly introduced
definitions retiring any driver-specific ones.

The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
PCI Express specification (see PCI Base Specification, Revision 5.0,
Version 1.0, Section 7.2.2, p. 676), thus most hardware should implement
it the same way.  Most of the native PCI Express controller drivers
define their ECAM-related constants, many of these could be shared, or
use open-coded values when setting the .bus_shift field of the struct
pci_ecam_ops.

All of the newly added constants should remove ambiguity and reduce the
number of open-coded values, and also correlate more strongly with the
descriptions in the aforementioned specification (see Table 7-1
"Enhanced Configuration Address Mapping", p. 677).

There is no change to functionality.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pcie-al.c      | 8 ++++----
 drivers/pci/controller/dwc/pcie-hisi.c    | 4 ++--
 drivers/pci/controller/pci-host-generic.c | 2 +-
 drivers/pci/controller/pci-thunder-ecam.c | 2 +-
 drivers/pci/controller/pcie-rockchip.h    | 7 ++++---
 drivers/pci/controller/pcie-tango.c       | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c  | 7 +++----
 drivers/pci/controller/pcie-xilinx.c      | 9 +++------
 drivers/pci/ecam.c                        | 4 ++--
 include/linux/pci-ecam.h                  | 8 ++++++++
 10 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index d57d4ee15848..57165cb0ef02 100644
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
@@ -138,7 +138,7 @@ struct al_pcie {
 	struct al_pcie_target_bus_cfg target_bus_cfg;
 };
 
-#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << 12)
+#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << PCIE_ECAM_FUN_SHIFT)
 
 #define to_al_pcie(x)		dev_get_drvdata((x)->dev)
 
@@ -228,7 +228,7 @@ static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
 	void __iomem *pci_base_addr;
 
 	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
-					 (busnr_ecam << 20) +
+					 (busnr_ecam << PCIE_ECAM_BUS_SHIFT) +
 					 PCIE_ECAM_DEVFN(devfn));
 
 	if (busnr_reg != target_bus_cfg->reg_val) {
@@ -300,7 +300,7 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 
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
index b51977abfdf1..c1c69b11615f 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
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
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index c7d0178fc8c2..50f425e03e8f 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
@@ -178,9 +179,9 @@
 #define MIN_AXI_ADDR_BITS_PASSED		8
 #define PCIE_RC_SEND_PME_OFF			0x11960
 #define ROCKCHIP_VENDOR_ID			0x1d87
-#define PCIE_ECAM_BUS(x)			(((x) & 0xff) << 20)
-#define PCIE_ECAM_DEV(x)			(((x) & 0x1f) << 15)
-#define PCIE_ECAM_FUNC(x)			(((x) & 0x7) << 12)
+#define PCIE_ECAM_BUS(x)			(((x) & 0xff) << PCIE_ECAM_BUS_SHIFT)
+#define PCIE_ECAM_DEV(x)			(((x) & 0x1f) << PCIE_ECAM_DEV_SHIFT)
+#define PCIE_ECAM_FUNC(x)			(((x) & 0x7) << PCIE_ECAM_FUN_SHIFT)
 #define PCIE_ECAM_REG(x)			(((x) & 0xfff) << 0)
 #define PCIE_ECAM_ADDR(bus, dev, func, reg) \
 	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
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
index f3cf7d61924f..8f628b66a0d7 100644
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
@@ -245,8 +244,8 @@ static void __iomem *nwl_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 	if (!nwl_pcie_valid_device(bus, devfn))
 		return NULL;
 
-	relbus = (bus->number << ECAM_BUS_LOC_SHIFT) |
-			(devfn << ECAM_DEV_LOC_SHIFT);
+	relbus = (bus->number << PCIE_ECAM_BUS_SHIFT) |
+			(devfn << PCIE_ECAM_FUN_SHIFT);
 
 	return pcie->ecam_base + relbus + where;
 }
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 8523be61bba5..7e9fdaccd132 100644
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
 
@@ -188,8 +185,8 @@ static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
 	if (!xilinx_pcie_valid_device(bus, devfn))
 		return NULL;
 
-	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
-		 (devfn << ECAM_DEV_NUM_SHIFT);
+	relbus = (bus->number << PCIE_ECAM_BUS_SHIFT) |
+		 (devfn << PCIE_ECAM_FUN_SHIFT);
 
 	return port->reg_base + relbus + where;
 }
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
index 1af5cb02ef7f..58a5d5e2e831 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -9,6 +9,14 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
+/*
+ * Memory address shift values for the byte-level address that
+ * can be used when accessing the PCI Express Configuration Space.
+ */
+#define PCIE_ECAM_FUN_SHIFT	12	/* Function Number */
+#define PCIE_ECAM_DEV_SHIFT	15	/* Device Number */
+#define PCIE_ECAM_BUS_SHIFT	20	/* Bus Number */
+
 /*
  * struct to hold pci ops and bus shift of the config window
  * for a PCI controller.
-- 
2.28.0

