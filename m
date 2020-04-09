Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876251A3D13
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 01:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDIXtc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 19:49:32 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37507 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIXtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 19:49:32 -0400
Received: by mail-il1-f195.google.com with SMTP id a6so440045ilr.4;
        Thu, 09 Apr 2020 16:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXbBeX3QU3lFHpwaRBTsYUqSYOWuchnQp81pwDYrcHw=;
        b=qCuqRT7xlelkA/HGvwJ7MKBSDGCS3iLHEKrXzJ09p4BXyjFnwz72tfRACqqdgqz4fC
         GUeey2f/fGvoGWsphhA1Xuin7mCid+m0K0ygxT2q+WMN2wJaoQzYyN2RJey1vrSZkF2p
         3dJrxmyYcgV5rtR5xMrMSdf5R8qS9tHcIqK1sWgm1i8eEFANVkQa++m5T4kiQrDsP05e
         hUQpp+WruQkKupjMERK4/iXy1nRj5isANwUJsvPplupzALBYI7rLwbrSbfOzvFVTP5jK
         J2xgvuZnDMFz/qPxfNbAqr6+dZjezcepLvl7GgCC3BfK8C8x0alxOTmClK0aXtl+qNLW
         TTDQ==
X-Gm-Message-State: AGi0PuYx7ggIR7sWj3vM2r7jvB1KzACP1K9r8z4fJ1MGdPBpac3ANRj6
        +YZHePCGYbdQOREdT4PrBQ==
X-Google-Smtp-Source: APiQypIB87AO1LAHcP0mucYNWkHVUS0IBC9qp7FGDcmyCxQ+2lbB81Hvx5L4oXbga7bbLBE6T9zQ5A==
X-Received: by 2002:a92:2c05:: with SMTP id t5mr2616650ile.132.1586476170061;
        Thu, 09 Apr 2020 16:49:30 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id w7sm93416ior.51.2020.04.09.16.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:49:29 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mans Rullgard <mans@mansr.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Robert Richter <rrichter@marvell.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: Constify struct pci_ecam_ops
Date:   Thu,  9 Apr 2020 17:49:21 -0600
Message-Id: <20200409234923.21598-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409234923.21598-1-robh@kernel.org>
References: <20200409234923.21598-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

struct pci_ecam_ops is typically DT match table data which is defined to
be const. It's also best practice for ops structs to be const. Ideally,
we'd make struct pci_ops const as well, but that becomes pretty
invasive, so for now we just cast it where needed.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Jonathan Chocron <jonnyc@amazon.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Toan Le <toan@os.amperecomputing.com>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/pci.c                   |  4 ++--
 drivers/acpi/pci_mcfg.c                   |  8 ++++----
 drivers/pci/controller/dwc/pcie-al.c      |  2 +-
 drivers/pci/controller/dwc/pcie-hisi.c    |  8 ++++----
 drivers/pci/controller/pci-host-common.c  |  6 +++---
 drivers/pci/controller/pci-host-generic.c |  4 ++--
 drivers/pci/controller/pci-thunder-ecam.c |  2 +-
 drivers/pci/controller/pci-thunder-pem.c  |  4 ++--
 drivers/pci/controller/pci-xgene.c        |  4 ++--
 drivers/pci/controller/pcie-tango.c       |  2 +-
 drivers/pci/ecam.c                        |  6 +++---
 include/linux/pci-acpi.h                  |  2 +-
 include/linux/pci-ecam.h                  | 22 +++++++++++-----------
 13 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 570988c7a7ff..1006ed2d7c60 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -117,7 +117,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 	struct device *dev = &root->device->dev;
 	struct resource *bus_res = &root->secondary;
 	u16 seg = root->segment;
-	struct pci_ecam_ops *ecam_ops;
+	const struct pci_ecam_ops *ecam_ops;
 	struct resource cfgres;
 	struct acpi_device *adev;
 	struct pci_config_window *cfg;
@@ -185,7 +185,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 	root_ops->release_info = pci_acpi_generic_release_info;
 	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
-	root_ops->pci_ops = &ri->cfg->ops->pci_ops;
+	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
 		return NULL;
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 6b347d9920cc..54b36b7ad47d 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -29,7 +29,7 @@ struct mcfg_fixup {
 	u32 oem_revision;
 	u16 segment;
 	struct resource bus_range;
-	struct pci_ecam_ops *ops;
+	const struct pci_ecam_ops *ops;
 	struct resource cfgres;
 };
 
@@ -165,7 +165,7 @@ static int pci_mcfg_quirk_matches(struct mcfg_fixup *f, u16 segment,
 
 static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
 				  struct resource *cfgres,
-				  struct pci_ecam_ops **ecam_ops)
+				  const struct pci_ecam_ops **ecam_ops)
 {
 #ifdef CONFIG_PCI_QUIRKS
 	u16 segment = root->segment;
@@ -191,9 +191,9 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
 static LIST_HEAD(pci_mcfg_list);
 
 int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
-		    struct pci_ecam_ops **ecam_ops)
+		    const struct pci_ecam_ops **ecam_ops)
 {
-	struct pci_ecam_ops *ops = &pci_generic_ecam_ops;
+	const struct pci_ecam_ops *ops = &pci_generic_ecam_ops;
 	struct resource *bus_res = &root->secondary;
 	u16 seg = root->segment;
 	struct mcfg_entry *e;
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 1eeda2f6371f..270868f3859a 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -80,7 +80,7 @@ static int al_pcie_init(struct pci_config_window *cfg)
 	return 0;
 }
 
-struct pci_ecam_ops al_pcie_ops = {
+const struct pci_ecam_ops al_pcie_ops = {
 	.bus_shift    = 20,
 	.init         =  al_pcie_init,
 	.pci_ops      = {
diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 6d9e1b2b8f7b..90017045334d 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -104,7 +104,7 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
 	return 0;
 }
 
-struct pci_ecam_ops hisi_pcie_ops = {
+const struct pci_ecam_ops hisi_pcie_ops = {
 	.bus_shift    = 20,
 	.init         =  hisi_pcie_init,
 	.pci_ops      = {
@@ -362,7 +362,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 	return 0;
 }
 
-struct pci_ecam_ops hisi_pcie_platform_ops = {
+const struct pci_ecam_ops hisi_pcie_platform_ops = {
 	.bus_shift    = 20,
 	.init         =  hisi_pcie_platform_init,
 	.pci_ops      = {
@@ -375,11 +375,11 @@ struct pci_ecam_ops hisi_pcie_platform_ops = {
 static const struct of_device_id hisi_pcie_almost_ecam_of_match[] = {
 	{
 		.compatible =  "hisilicon,hip06-pcie-ecam",
-		.data	    = (void *) &hisi_pcie_platform_ops,
+		.data	    =  &hisi_pcie_platform_ops,
 	},
 	{
 		.compatible =  "hisilicon,hip07-pcie-ecam",
-		.data       = (void *) &hisi_pcie_platform_ops,
+		.data       =  &hisi_pcie_platform_ops,
 	},
 	{},
 };
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 250a3fc80ec6..f6d5dc068488 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -19,7 +19,7 @@ static void gen_pci_unmap_cfg(void *ptr)
 }
 
 static struct pci_config_window *gen_pci_init(struct device *dev,
-		struct list_head *resources, struct pci_ecam_ops *ops)
+		struct list_head *resources, const struct pci_ecam_ops *ops)
 {
 	int err;
 	struct resource cfgres;
@@ -55,7 +55,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 }
 
 int pci_host_common_probe(struct platform_device *pdev,
-			  struct pci_ecam_ops *ops)
+			  const struct pci_ecam_ops *ops)
 {
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
@@ -82,7 +82,7 @@ int pci_host_common_probe(struct platform_device *pdev,
 	bridge->dev.parent = dev;
 	bridge->sysdata = cfg;
 	bridge->busnr = cfg->busr.start;
-	bridge->ops = &ops->pci_ops;
+	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 75a2fb930d4b..7e9a7c0833b1 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -15,7 +15,7 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
-static struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
+static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
 	.bus_shift	= 16,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
@@ -49,7 +49,7 @@ static void __iomem *pci_dw_ecam_map_bus(struct pci_bus *bus,
 	return pci_ecam_map_bus(bus, devfn, where);
 }
 
-static struct pci_ecam_ops pci_dw_ecam_bus_ops = {
+static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
 	.bus_shift	= 20,
 	.pci_ops	= {
 		.map_bus	= pci_dw_ecam_map_bus,
diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index 32d1d7b81ef4..c3fdd3e6b21c 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -345,7 +345,7 @@ static int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
-struct pci_ecam_ops pci_thunder_ecam_ops = {
+const struct pci_ecam_ops pci_thunder_ecam_ops = {
 	.bus_shift	= 20,
 	.pci_ops	= {
 		.map_bus        = pci_ecam_map_bus,
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 9491e266b1ea..2e792707ceab 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -403,7 +403,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
 	return thunder_pem_init(dev, cfg, res_pem);
 }
 
-struct pci_ecam_ops thunder_pem_ecam_ops = {
+const struct pci_ecam_ops thunder_pem_ecam_ops = {
 	.bus_shift	= 24,
 	.init		= thunder_pem_acpi_init,
 	.pci_ops	= {
@@ -440,7 +440,7 @@ static int thunder_pem_platform_init(struct pci_config_window *cfg)
 	return thunder_pem_init(dev, cfg, res_pem);
 }
 
-static struct pci_ecam_ops pci_thunder_pem_ops = {
+static const struct pci_ecam_ops pci_thunder_pem_ops = {
 	.bus_shift	= 24,
 	.init		= thunder_pem_platform_init,
 	.pci_ops	= {
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index de195fd430dc..d1efa8ffbae1 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -256,7 +256,7 @@ static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
 	return xgene_pcie_ecam_init(cfg, XGENE_PCIE_IP_VER_1);
 }
 
-struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
+const struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
 	.bus_shift	= 16,
 	.init		= xgene_v1_pcie_ecam_init,
 	.pci_ops	= {
@@ -271,7 +271,7 @@ static int xgene_v2_pcie_ecam_init(struct pci_config_window *cfg)
 	return xgene_pcie_ecam_init(cfg, XGENE_PCIE_IP_VER_2);
 }
 
-struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
+const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
 	.bus_shift	= 16,
 	.init		= xgene_v2_pcie_ecam_init,
 	.pci_ops	= {
diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
index 21a208da3f59..3b2b10906fdd 100644
--- a/drivers/pci/controller/pcie-tango.c
+++ b/drivers/pci/controller/pcie-tango.c
@@ -207,7 +207,7 @@ static int smp8759_config_write(struct pci_bus *bus, unsigned int devfn,
 	return ret;
 }
 
-static struct pci_ecam_ops smp8759_ecam_ops = {
+static const struct pci_ecam_ops smp8759_ecam_ops = {
 	.bus_shift	= 20,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 1a81af0ba961..1b05ff627859 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -26,7 +26,7 @@ static const bool per_bus_mapping = !IS_ENABLED(CONFIG_64BIT);
  */
 struct pci_config_window *pci_ecam_create(struct device *dev,
 		struct resource *cfgres, struct resource *busr,
-		struct pci_ecam_ops *ops)
+		const struct pci_ecam_ops *ops)
 {
 	struct pci_config_window *cfg;
 	unsigned int bus_range, bus_range_max, bsz;
@@ -145,7 +145,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 
 /* ECAM ops */
-struct pci_ecam_ops pci_generic_ecam_ops = {
+const struct pci_ecam_ops pci_generic_ecam_ops = {
 	.bus_shift	= 20,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
@@ -156,7 +156,7 @@ struct pci_ecam_ops pci_generic_ecam_ops = {
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 /* ECAM ops for 32-bit access only (non-compliant) */
-struct pci_ecam_ops pci_32b_ops = {
+const struct pci_ecam_ops pci_32b_ops = {
 	.bus_shift	= 20,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 2d155bfb8fbf..81f5535ca1b5 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -27,7 +27,7 @@ extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
 struct pci_ecam_ops;
 extern int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
-			   struct pci_ecam_ops **ecam_ops);
+			   const struct pci_ecam_ops **ecam_ops);
 
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index a73164c85e78..6c21dd0901ab 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -29,7 +29,7 @@ struct pci_config_window {
 	struct resource			res;
 	struct resource			busr;
 	void				*priv;
-	struct pci_ecam_ops		*ops;
+	const struct pci_ecam_ops	*ops;
 	union {
 		void __iomem		*win;	/* 64-bit single mapping */
 		void __iomem		**winp; /* 32-bit per-bus mapping */
@@ -40,29 +40,29 @@ struct pci_config_window {
 /* create and free pci_config_window */
 struct pci_config_window *pci_ecam_create(struct device *dev,
 		struct resource *cfgres, struct resource *busr,
-		struct pci_ecam_ops *ops);
+		const struct pci_ecam_ops *ops);
 void pci_ecam_free(struct pci_config_window *cfg);
 
 /* map_bus when ->sysdata is an instance of pci_config_window */
 void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
 /* default ECAM ops */
-extern struct pci_ecam_ops pci_generic_ecam_ops;
+extern const struct pci_ecam_ops pci_generic_ecam_ops;
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
-extern struct pci_ecam_ops pci_32b_ops;		/* 32-bit accesses only */
-extern struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
-extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
-extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
-extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
-extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
-extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe */
+extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
+extern const struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
+extern const struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
+extern const struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
+extern const struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
+extern const struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
+extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
 #endif
 
 #ifdef CONFIG_PCI_HOST_COMMON
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
-			  struct pci_ecam_ops *ops);
+			  const struct pci_ecam_ops *ops);
 int pci_host_common_remove(struct platform_device *pdev);
 #endif
 #endif
-- 
2.20.1

