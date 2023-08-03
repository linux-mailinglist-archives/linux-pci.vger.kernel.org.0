Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0F076F13A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjHCSCp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjHCSCP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:02:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166F4684
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:01:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f1240a22so1104722b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085671; x=1691690471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8DeeC24vpY8HEzbjyI/7Rv+Hl3+YE3NoDQiC+QP7Dk=;
        b=N7pjlLqaqUS81mB7h6ZTDNs9hSguqXKdZ80nnwm+cjhE5CyUhSKPbW/O26zFvL8jJV
         fRVdbvFgOsVMRS3Iz7NdaeUu9EONmq9WAXSFCRGYEZzaTg1/ifLsx6RVNDwO+Wif19S+
         eA1IVkZowtY6UTLqlV+rWLm+7orK9S1qQUyAL/f+AV6DOQEiIUH9ui6P9m3t+VMZ2c3G
         nf/GIsu3qOyj/yQM3UAN+oHHwl7Pes88yfB2dpbPPTcfGg3PHyVIy1bL3rC0mgr0II7I
         HnwuRGavWg6/C0AD2Zois4/aEizVjaSIryyVcTiedAZ+Fh+d3MNuIT5gxonWVMzRuN1w
         bXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085671; x=1691690471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8DeeC24vpY8HEzbjyI/7Rv+Hl3+YE3NoDQiC+QP7Dk=;
        b=IovWMLWZ+Z22IGhGP8zGf2X3TPLHIfyJ+D/4fDtfO8ncQF2GfsmCILyp1Tpo2dWB95
         f/nx/utrRy1JbA1EDxW2JQyXCOUxTg3Z9ZIajJaJndTZ8UtdIsITCOUTvzhTfPWDBN5B
         8Tr8nvFoDIrGw64ar9XYXjX5QGln7eobkl1dHnhNct1/HnHMwShh9+lYk3kBl22Euia2
         TXlWm0wOO+nOns/h4MSfi8p54uT/LeMl2vsWEfYTa32+f6FebBXkdrKQ0gm3e6Rr2qKN
         i1iM2jW1IDTrST1AoN2yKQ4uAFd3JVdHImanWMHiD7ir8mebisF9oFr24BFEDyrJcC5K
         KQeA==
X-Gm-Message-State: ABy/qLbnM0+ceAdxCXuwNa7VHn+vJSM8qWl40zOY0mb2MjBu05haWeMN
        Hs9uqMH++lrI2IkzPSKsEiWabg==
X-Google-Smtp-Source: APBJJlHODxCiHsxX3VdzzkL4f0OtQqwnuurJJdGSKcSJa8ej/p8fDM2WEmx10nSHB/0YuWJf8HguRg==
X-Received: by 2002:a05:6a21:7889:b0:138:198f:6edf with SMTP id bf9-20020a056a21788900b00138198f6edfmr26331813pzc.46.1691085670849;
        Thu, 03 Aug 2023 11:01:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:01:10 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 13/21] irqchip/riscv-imsic-early: Add ACPI support
Date:   Thu,  3 Aug 2023 23:29:08 +0530
Message-Id: <20230803175916.3174453-14-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to probe the IMSIC early driver on ACPI
based RISC-V platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h           |  6 +++
 drivers/acpi/riscv/irqchip.c            | 57 +++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-early.c | 28 ++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.c | 33 +++++++++++---
 4 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 0ac2df2dd194..6dde3d63dc0e 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -69,6 +69,8 @@ static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu, u32 *cbom_size,
 			    u32 *cboz_size, u32 *cbop_size);
 struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_rintc *rintc);
+struct fwnode_handle *acpi_imsic_create_fwnode(struct acpi_madt_imsic *imsic);
+struct fwnode_handle *acpi_riscv_get_msi_fwnode(struct device *dev);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -89,6 +91,10 @@ static inline int acpi_get_cbo_block_size(struct acpi_table_header *table,
 	return -EINVAL;
 }
 
+static inline struct fwnode_handle *acpi_riscv_get_msi_fwnode(struct device *dev)
+{
+	return NULL;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/riscv/irqchip.c b/drivers/acpi/riscv/irqchip.c
index 36f066a2cad5..6e15d45cb229 100644
--- a/drivers/acpi/riscv/irqchip.c
+++ b/drivers/acpi/riscv/irqchip.c
@@ -18,6 +18,8 @@ struct riscv_irqchip_list {
 
 LIST_HEAD(rintc_list);
 
+static struct fwnode_handle *imsic_acpi_fwnode;
+
 struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_rintc *rintc)
 {
 	struct property_entry props[6] = {};
@@ -44,3 +46,58 @@ struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_rintc *r
 
 	return fwnode;
 }
+
+static struct fwnode_handle *acpi_imsic_get_rintc_fwnode(u32 idx)
+{
+	struct riscv_irqchip_list *rintc_element;
+	struct fwnode_handle *fwnode;
+	struct list_head *i, *tmp;
+	unsigned int j = 0;
+
+	list_for_each_safe(i, tmp, &rintc_list) {
+		rintc_element = list_entry(i, struct riscv_irqchip_list, list);
+		fwnode = rintc_element->fwnode;
+
+		if (j == idx)
+			return fwnode;
+
+		j++;
+	}
+
+	return NULL;
+}
+
+struct fwnode_handle *acpi_imsic_create_fwnode(struct acpi_madt_imsic *imsic)
+{
+	struct property_entry props[8] = {};
+	struct software_node_ref_args *refs;
+	struct fwnode_handle *parent_fwnode;
+	unsigned int nr_rintc, i;
+
+	props[0] = PROPERTY_ENTRY_U32("riscv,guest-index-bits", imsic->guest_index_bits);
+	props[1] = PROPERTY_ENTRY_U32("riscv,hart-index-bits", imsic->hart_index_bits);
+	props[2] = PROPERTY_ENTRY_U32("riscv,group-index-bits", imsic->group_index_bits);
+	props[3] = PROPERTY_ENTRY_U32("riscv,group-index-shift", imsic->group_index_shift);
+	props[4] = PROPERTY_ENTRY_U32("riscv,num-ids", imsic->num_ids);
+	props[5] = PROPERTY_ENTRY_U32("riscv,num-guest-ids", imsic->num_guest_ids);
+
+	nr_rintc = list_count_nodes(&rintc_list);
+	refs = kcalloc(nr_rintc, sizeof(*refs), GFP_KERNEL);
+	if (!refs)
+		return NULL;
+
+	for (i = 0; i < nr_rintc; i++) {
+		parent_fwnode = acpi_imsic_get_rintc_fwnode(i);
+		refs[i] = SOFTWARE_NODE_REFERENCE(to_software_node(parent_fwnode), RV_IRQ_EXT);
+	}
+	props[6] = PROPERTY_ENTRY_REF_ARRAY_LEN("interrupts-extended", refs, nr_rintc);
+
+	imsic_acpi_fwnode = fwnode_create_software_node_early(props, NULL);
+
+	return imsic_acpi_fwnode;
+}
+
+struct fwnode_handle *acpi_riscv_get_msi_fwnode(struct device *dev)
+{
+	return imsic_acpi_fwnode;
+}
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 1de89ce1ec2f..93f4d748ca6d 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -12,6 +12,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 
@@ -256,3 +257,30 @@ static int __init imsic_early_dt_init(struct device_node *node,
 	return 0;
 }
 IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
+
+#ifdef CONFIG_ACPI
+static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct fwnode_handle *fwnode;
+	int rc;
+
+	/*
+	 * There should be only one IMSIC node.
+	 */
+	fwnode = acpi_imsic_create_fwnode((struct acpi_madt_imsic *)header);
+	if (!fwnode) {
+		pr_err("unable to create IMSIC FW node\n");
+		return -ENOMEM;
+	}
+
+	rc = imsic_early_probe(fwnode);
+	if (!rc)
+		pci_msi_register_fwnode_provider(&acpi_riscv_get_msi_fwnode);
+
+	return rc;
+}
+
+IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC,
+		     NULL, 1, imsic_early_acpi_init);
+#endif
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 412b5b919dcc..d0e09e51e8ae 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -225,15 +225,38 @@ static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 	return riscv_get_intc_hartid(parent.fwnode, hartid);
 }
 
+static int __init imsic_acpi_get_mmio_resource(struct fwnode_handle *fwnode,
+					       u32 index, struct resource *res)
+{
+	int rc;
+	struct fwnode_reference_args parent;
+	u64 base;
+	u32 size;
+
+	rc = fwnode_property_get_reference_args(fwnode,
+						"interrupts-extended", NULL,
+						0, index, &parent);
+	if (rc)
+		return rc;
+
+	rc = fwnode_property_read_u64_array(parent.fwnode, "riscv,imsic-addr",
+					    &base, 1);
+	rc = fwnode_property_read_u32_array(parent.fwnode, "riscv,imsic-size",
+					    &size, 1);
+	if (!rc) {
+		res->start = base;
+		res->end = res->start + size - 1;
+	}
+
+	return 0;
+}
+
 static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 					  u32 index, struct resource *res)
 {
-	/*
-	 * Currently, only OF fwnode is support so extend this function
-	 * for other types of fwnode for ACPI support.
-	 */
 	if (!is_of_node(fwnode))
-		return -EINVAL;
+		return imsic_acpi_get_mmio_resource(fwnode, index, res);
+
 	return of_address_to_resource(to_of_node(fwnode), index, res);
 }
 
-- 
2.39.2

