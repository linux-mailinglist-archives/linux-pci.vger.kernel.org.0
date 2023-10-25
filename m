Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49697D759C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjJYU0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYU0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:26:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496119A6
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:25:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso163903a12.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265530; x=1698870330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59OuHyNaU3fGic7bU/ykRVEj1ISi+51hzxPyHqKgiHU=;
        b=WSI2LI3UouX3dGKglRC9cxWXwuqUkPEpmYoPiraER50IRbz4R4f4O5Y0mUDu7HgOdv
         8bB2ySYNLz5HOQlWjpdjnHMZT42JINSI6cI6mB/y1trSz+o5zezzc5X8ZHH0gbdudnXa
         FYiCckhkPrUqAGHIm2UVerq6ChCVJyH7D4P2+4kc6LpYBaFs8gapeufDYDDYmTo9WjUY
         /ETanl4aevBbCk8hxpzPltpZZY7jAVUfJyW4dIdeeI8NEp0zRb8kg4Ew1I7Pe9eACSI0
         PgXLUtPk+TuhwedPuuM1Ny9Pc4l9aRhUW5RqrlK6GP1IaEJY0AsM3JCwlL3hOtTkxu7P
         rL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265530; x=1698870330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59OuHyNaU3fGic7bU/ykRVEj1ISi+51hzxPyHqKgiHU=;
        b=Lm0KbqdqAPwj1APsw7FH/QVw3CxM/FhIzJT2WI4UXQ7ZYPW4mlkd9NdQlmjt4A4RPp
         zwO2dgEhj/k7x1dc2lRg5M4qIR4S1F0jpJ6Mw45KVcjY7+XF1q+9NePWmYqWp0yLpMLm
         ImCYOsrFBZsHXR2tAzSBkoH1gWAwkSkVHUlPZUZzL9VtqiMDw3lrCTPcOtNyWLW9SfRy
         x/ILyms+Qb09kDzaekWpupgbKK0nln8BKCruPfzLsQdxH6hwfaAGdQldrnAFuA+lxIx9
         UBYXZBtEWizvVaZDosz5GbjRhVXjkOchS9prGPLcTGVWh63/OI9O57U4fwBmrhEvxv36
         as8Q==
X-Gm-Message-State: AOJu0YwU2ONS81lwlbfuqtHHOegui0/cSijWLnlI7ZDTgQIVsKHcklT9
        Hx5hxZYck3U20avP/WA5bQw7/w==
X-Google-Smtp-Source: AGHT+IHWtyasGWBG2ncOVxTr7Ff9cRNuMnmYDG5JFQmxxsN156cqaz/hByE4OSnzTGpWfiTZSkxNMg==
X-Received: by 2002:a05:6a21:3b44:b0:169:7d6f:9f22 with SMTP id zy4-20020a056a213b4400b001697d6f9f22mr6291614pzb.54.1698265530438;
        Wed, 25 Oct 2023 13:25:30 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:29 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 14/21] irqchip: riscv-imsic: Add ACPI support
Date:   Thu, 26 Oct 2023 01:53:37 +0530
Message-Id: <20231025202344.581132-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RISC-V IMSIC interrupt controller provides IPI and MSI support.
Currently, DT based drivers setup the IPI feature early during boot but
defer setting up the MSI functionality. However, in ACPI systems, PCI
scan happens early during boot and PCI subsystem expects MSI controller
is already setup. Hence, in case of ACPI, both IPI and MSI features are
initialized early itself.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c    |  52 ++++++++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  51 +++++---
 drivers/irqchip/irq-riscv-imsic-state.c    | 128 ++++++++++-----------
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 include/linux/irqchip/riscv-imsic.h        |  10 ++
 5 files changed, 160 insertions(+), 83 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 23f689ff5807..8ce864a7e4dd 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -5,16 +5,20 @@
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
 
+#include "../pci/pci.h"
 #include "irq-riscv-imsic-state.h"
 
 static int imsic_parent_irq;
@@ -216,7 +220,7 @@ static int __init imsic_early_dt_init(struct device_node *node,
 	struct fwnode_handle *fwnode = &node->fwnode;
 
 	/* Setup IMSIC state */
-	rc = imsic_setup_state(fwnode);
+	rc = imsic_setup_state(fwnode, NULL);
 	if (rc) {
 		pr_err("%pfwP: failed to setup state (error %d)\n",
 			fwnode, rc);
@@ -233,3 +237,49 @@ static int __init imsic_early_dt_init(struct device_node *node,
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
+	if (!rc) {
+		pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
+		pci_set_msi();
+	}
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

