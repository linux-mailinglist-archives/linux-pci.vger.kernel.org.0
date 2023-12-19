Return-Path: <linux-pci+bounces-1182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA8D818E99
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195761C2484D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8F3C6A6;
	Tue, 19 Dec 2023 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nKgXOThj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07973A1BC
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d39afa1eecso29693175ad.2
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007991; x=1703612791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3fyfZ6Lr7w+r0MJIn4zdZonb9lVGi9+7cBScTQl4UI=;
        b=nKgXOThjT+Ob1ywOXasApoQx0l8u9nXQx/NG75vg2z6+DzrDNkQnfT+en8zsc6uCzn
         HHg/X/SrGQq0vsmx/AqZQR0JM7ppOeHb1wze+PpLg+yFV0cMRxKEIEh5N1hJ5HPuJ32C
         Et3hS2vCnNyJpDKdeS2WyV+/BvF2hq0sJyLRcUjqnICFPxMzwzw1I5YJqCX2wfQDNCnz
         l7I2sB9G7AbFF0gNtE9Z++jdYxPuTr5UY7kHXOZ4vhlJ7Vpmvg7dM9O0KMADnflZ/enI
         81avZscwYQaCb95zpouRYQrR5AL0p649FUCAZg9uoy3gzcOkfnyacNN3+GscYggSpMsy
         HZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007991; x=1703612791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3fyfZ6Lr7w+r0MJIn4zdZonb9lVGi9+7cBScTQl4UI=;
        b=A7szIYpYOQkAN+4KTdUIe0Ye+NrwyA3Ev5B8Go5sBpiL22b/VGoOhUCPmYLYlKxhoz
         G7EwyAAJxgAfDgdWfXkpphgyHAtScedmZSySXurbzdNpu/6od8BMdaNtAMxSzZbfS3lN
         1RI5gN2OZbv6OSaj8ucO0zxqAaFoWR74tztPx7e7DKvcJPxd9rR2uF44lAImHq9qRqKr
         FFhEQrBz3g2uckyv8N4MgcocYG7UD5FsiVpw8CG1VE/Khvy+A68WSDuPhlYWGejrgIVD
         RfIFcW2KiPng5U7dGF3T/3/25FWp+8+9aZStXk/VZq9DZQv1NeBcTy/YcVaNBtcpV06d
         BK1A==
X-Gm-Message-State: AOJu0YwCEp8Q5QldJy/PBnpZAoOSudlmw3gENITeJB0TFpkNc7x27elk
	lNc04a8XqJ599YIUbo6C+kJUnA==
X-Google-Smtp-Source: AGHT+IGvMgnXEDBDSoxKrnqEIHP2nZ5eywEEWz1Kq0rK1LvLd/V7z8NaX/xR7mnE5/nWPlUXPulrtg==
X-Received: by 2002:a17:902:820b:b0:1d0:8fad:f18d with SMTP id x11-20020a170902820b00b001d08fadf18dmr18213249pln.95.1703007991260;
        Tue, 19 Dec 2023 09:46:31 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:30 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 10/17] irqchip: riscv-imsic: Add ACPI support
Date: Tue, 19 Dec 2023 23:15:19 +0530
Message-Id: <20231219174526.2235150-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V IMSIC interrupt controller provides IPI and MSI support.
Currently, DT based drivers setup the IPI feature early during boot but
defer setting up the MSI functionality. However, in ACPI systems, PCI
scan happens early during boot and PCI subsystem expects MSI controller
is already setup. Hence, in case of ACPI, both IPI and MSI features
are initialized early itself.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c    |  52 ++++++++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  51 +++++---
 drivers/irqchip/irq-riscv-imsic-state.c    | 128 ++++++++++-----------
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 include/linux/irqchip/riscv-imsic.h        |  10 ++
 5 files changed, 160 insertions(+), 83 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 23f689ff5807..866e97559e4c 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -5,13 +5,16 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 
@@ -216,7 +219,7 @@ static int __init imsic_early_dt_init(struct device_node *node,
 	struct fwnode_handle *fwnode = &node->fwnode;
 
 	/* Setup IMSIC state */
-	rc = imsic_setup_state(fwnode);
+	rc = imsic_setup_state(fwnode, NULL);
 	if (rc) {
 		pr_err("%pfwP: failed to setup state (error %d)\n",
 			fwnode, rc);
@@ -233,3 +236,50 @@ static int __init imsic_early_dt_init(struct device_node *node,
 	return 0;
 }
 IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
+
+#ifdef CONFIG_ACPI
+
+static struct fwnode_handle *imsic_acpi_fwnode;
+
+struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
+{
+	return imsic_acpi_fwnode;
+}
+
+static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)header;
+	int rc;
+
+	imsic_acpi_fwnode = irq_domain_alloc_named_fwnode("imsic");
+	if (!imsic_acpi_fwnode) {
+		pr_err("unable to allocate IMSIC FW node\n");
+		return -ENOMEM;
+	}
+
+	/* Setup IMSIC state */
+	rc = imsic_setup_state(imsic_acpi_fwnode, (void *)imsic);
+	if (rc) {
+		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
+		return rc;
+	}
+
+	/* Do early setup of IMSIC state and IPIs */
+	rc = imsic_early_probe(imsic_acpi_fwnode);
+	if (rc)
+		return rc;
+
+	rc = imsic_platform_acpi_probe(imsic_acpi_fwnode);
+
+#ifdef CONFIG_PCI
+	if (!rc)
+		pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
+#endif
+
+	return rc;
+}
+
+IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
+		     1, imsic_early_acpi_init);
+#endif
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index cdb659401199..f905340d24e6 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -5,6 +5,7 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -308,43 +309,47 @@ static int imsic_irq_domains_init(struct fwnode_handle *fwnode)
 	return 0;
 }
 
-static int imsic_platform_probe(struct platform_device *pdev)
+static int imsic_platform_probe_common(struct fwnode_handle *fwnode)
 {
-	struct device *dev = &pdev->dev;
 	struct imsic_global_config *global;
 	int rc;
 
 	if (!imsic) {
-		dev_err(dev, "early driver not probed\n");
+		pr_err("%pfwP: early driver not probed\n", fwnode);
 		return -ENODEV;
 	}
 
 	if (imsic->base_domain) {
-		dev_err(dev, "irq domain already created\n");
+		pr_err("%pfwP: irq domain already created\n", fwnode);
 		return -ENODEV;
 	}
 
 	global = &imsic->global;
 
 	/* Initialize IRQ and MSI domains */
-	rc = imsic_irq_domains_init(dev->fwnode);
+	rc = imsic_irq_domains_init(fwnode);
 	if (rc) {
-		dev_err(dev, "failed to initialize IRQ and MSI domains\n");
+		pr_err("%pfwP: failed to initialize IRQ and MSI domains\n", fwnode);
 		return rc;
 	}
 
-	dev_info(dev, "  hart-index-bits: %d,  guest-index-bits: %d\n",
-		 global->hart_index_bits, global->guest_index_bits);
-	dev_info(dev, " group-index-bits: %d, group-index-shift: %d\n",
-		 global->group_index_bits, global->group_index_shift);
-	dev_info(dev, " per-CPU IDs %d at base PPN %pa\n",
-		 global->nr_ids, &global->base_addr);
-	dev_info(dev, " total %d interrupts available\n",
-		 imsic->nr_hwirqs);
+	pr_info("%pfwP: hart-index-bits: %d,  guest-index-bits: %d\n", fwnode,
+		global->hart_index_bits, global->guest_index_bits);
+	pr_info("%pfwP: group-index-bits: %d, group-index-shift: %d\n", fwnode,
+		global->group_index_bits, global->group_index_shift);
+	pr_info("%pfwP: per-CPU IDs %d at base PPN %pa\n", fwnode,
+		global->nr_ids, &global->base_addr);
+	pr_info("%pfwP: total %d interrupts available\n", fwnode,
+		imsic->nr_hwirqs);
 
 	return 0;
 }
 
+static int imsic_platform_dt_probe(struct platform_device *pdev)
+{
+	return imsic_platform_probe_common(pdev->dev.fwnode);
+}
+
 static const struct of_device_id imsic_platform_match[] = {
 	{ .compatible = "riscv,imsics" },
 	{}
@@ -355,6 +360,22 @@ static struct platform_driver imsic_platform_driver = {
 		.name		= "riscv-imsic",
 		.of_match_table	= imsic_platform_match,
 	},
-	.probe = imsic_platform_probe,
+	.probe = imsic_platform_dt_probe,
 };
 builtin_platform_driver(imsic_platform_driver);
+
+#ifdef CONFIG_ACPI
+
+/*
+ *  On ACPI based systems, PCI enumeration happens early during boot in
+ *  acpi_scan_init(). PCI enumeration expects MSI domain setup before
+ *  it calls pci_set_msi_domain(). Hence, unlike in DT where
+ *  imsic-platform drive probe happens late during boot, ACPI based
+ *  systems need to setup the MSI domain early.
+ */
+int imsic_platform_acpi_probe(struct fwnode_handle *fwnode)
+{
+	return imsic_platform_probe_common(fwnode);
+}
+
+#endif
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 54465e47851c..b842c499df0a 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -5,6 +5,7 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/bitmap.h>
 #include <linux/interrupt.h>
@@ -593,12 +594,8 @@ static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 	int rc;
 	struct of_phandle_args parent;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
 	if (!is_of_node(fwnode))
-		return -EINVAL;
+		return acpi_get_intc_index_hartid(index, hartid);
 
 	rc = of_irq_parse_one(to_of_node(fwnode), index, &parent);
 	if (rc)
@@ -617,12 +614,8 @@ static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 					  u32 index, struct resource *res)
 {
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
 	if (!is_of_node(fwnode))
-		return -EINVAL;
+		return acpi_get_imsic_mmio_info(index, res);
 
 	return of_address_to_resource(to_of_node(fwnode), index, res);
 }
@@ -630,20 +623,15 @@ static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 				     struct imsic_global_config *global,
 				     u32 *nr_parent_irqs,
-				     u32 *nr_mmios)
+				     u32 *nr_mmios,
+				     void *opaque)
 {
+	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)opaque;
 	unsigned long hartid;
 	struct resource res;
 	int rc;
 	u32 i;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(fwnode))
-		return -EINVAL;
-
 	*nr_parent_irqs = 0;
 	*nr_mmios = 0;
 
@@ -656,58 +644,66 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 		return -EINVAL;
 	}
 
-	/* Find number of guest index bits in MSI address */
-	rc = of_property_read_u32(to_of_node(fwnode),
-				  "riscv,guest-index-bits",
-				  &global->guest_index_bits);
-	if (rc)
-		global->guest_index_bits = 0;
+	if (is_of_node(fwnode)) {
+		/* Find number of guest index bits in MSI address */
+		rc = of_property_read_u32(to_of_node(fwnode),
+					  "riscv,guest-index-bits",
+					  &global->guest_index_bits);
+		if (rc)
+			global->guest_index_bits = 0;
 
-	/* Find number of HART index bits */
-	rc = of_property_read_u32(to_of_node(fwnode),
-				  "riscv,hart-index-bits",
-				  &global->hart_index_bits);
-	if (rc) {
-		/* Assume default value */
-		global->hart_index_bits = __fls(*nr_parent_irqs);
-		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
-			global->hart_index_bits++;
-	}
+		/* Find number of HART index bits */
+		rc = of_property_read_u32(to_of_node(fwnode),
+					  "riscv,hart-index-bits",
+					  &global->hart_index_bits);
+		if (rc) {
+			/* Assume default value */
+			global->hart_index_bits = __fls(*nr_parent_irqs);
+			if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+				global->hart_index_bits++;
+		}
 
-	/* Find number of group index bits */
-	rc = of_property_read_u32(to_of_node(fwnode),
-				  "riscv,group-index-bits",
-				  &global->group_index_bits);
-	if (rc)
-		global->group_index_bits = 0;
+		/* Find number of group index bits */
+		rc = of_property_read_u32(to_of_node(fwnode),
+					  "riscv,group-index-bits",
+					  &global->group_index_bits);
+		if (rc)
+			global->group_index_bits = 0;
 
-	/*
-	 * Find first bit position of group index.
-	 * If not specified assumed the default APLIC-IMSIC configuration.
-	 */
-	rc = of_property_read_u32(to_of_node(fwnode),
-				  "riscv,group-index-shift",
-				  &global->group_index_shift);
-	if (rc)
-		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
+		/*
+		 * Find first bit position of group index.
+		 * If not specified assumed the default APLIC-IMSIC configuration.
+		 */
+		rc = of_property_read_u32(to_of_node(fwnode),
+					  "riscv,group-index-shift",
+					  &global->group_index_shift);
+		if (rc)
+			global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
+
+		/* Find number of interrupt identities */
+		rc = of_property_read_u32(to_of_node(fwnode),
+					  "riscv,num-ids",
+					  &global->nr_ids);
+		if (rc) {
+			pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
+			return rc;
+		}
 
-	/* Find number of interrupt identities */
-	rc = of_property_read_u32(to_of_node(fwnode),
-				  "riscv,num-ids",
-				  &global->nr_ids);
-	if (rc) {
-		pr_err("%pfwP: number of interrupt identities not found\n",
-			fwnode);
-		return rc;
+		/* Find number of guest interrupt identities */
+		rc = of_property_read_u32(to_of_node(fwnode),
+					  "riscv,num-guest-ids",
+					  &global->nr_guest_ids);
+		if (rc)
+			global->nr_guest_ids = global->nr_ids;
+	} else {
+		global->guest_index_bits = imsic->guest_index_bits;
+		global->hart_index_bits = imsic->hart_index_bits;
+		global->group_index_bits = imsic->group_index_bits;
+		global->group_index_shift = imsic->group_index_shift;
+		global->nr_ids = imsic->num_ids;
+		global->nr_guest_ids = imsic->num_guest_ids;
 	}
 
-	/* Find number of guest interrupt identities */
-	rc = of_property_read_u32(to_of_node(fwnode),
-				  "riscv,num-guest-ids",
-				  &global->nr_guest_ids);
-	if (rc)
-		global->nr_guest_ids = global->nr_ids;
-
 	/* Sanity check guest index bits */
 	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
 	if (i < global->guest_index_bits) {
@@ -775,7 +771,7 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 	return 0;
 }
 
-int __init imsic_setup_state(struct fwnode_handle *fwnode)
+int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 {
 	int rc, cpu;
 	phys_addr_t base_addr;
@@ -817,7 +813,7 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode)
 	}
 
 	/* Parse IMSIC fwnode */
-	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
+	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios, opaque);
 	if (rc)
 		goto out_free_local;
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 8d209e77432e..ee1f52891e89 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -105,6 +105,6 @@ void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
 int imsic_hwirqs_alloc(unsigned int order);
 void imsic_hwirqs_free(unsigned int base_hwirq, unsigned int order);
 
-int imsic_setup_state(struct fwnode_handle *fwnode);
+int imsic_setup_state(struct fwnode_handle *fwnode, void *opaque);
 
 #endif
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index cbb7bcd0e4dd..c112e5559d88 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -84,4 +84,14 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
 
 #endif
 
+#ifdef CONFIG_ACPI
+int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
+struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
+#else
+static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 #endif
-- 
2.39.2


