Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028C776F137
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjHCSCj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjHCSCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:02:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4068F44BA
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:01:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f38692b3so1120594b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085663; x=1691690463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqi3iZnSO0pCz4r86HvzjXAIoq/LUkNm+cOCoheLdcU=;
        b=RGBk6rx5Hg20bOXt+KLaRA26VcrOyNOoG/eZ7AxmlMnjFLn1DtSewmy8B6izdUW0E9
         GsvBNf8e3jLCLs9h3DTaOaEA4Km0R9H4SNrQ9+L743IjhhgsHfGIylndzoIQZ265aQGL
         n3u5HhJfofcxpdy320nz2rQ2QoD01GiNeIZKOW51Fa3p9Z3xFqseEFfup54Xbr4HF94E
         1EWqxSsfqSg9VtpcDRRRk5I1Neux3XeF5LvtGw6Xi2P1PAQzmkcPwAZHb9qGJ5o3kBoC
         gZ6YooLlmoRGD/mmS9270tnx8asDRFY2Qh6PHJuGg7a6wwcl70gJWrfxbZ1zW3Bv9Blq
         Sc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085663; x=1691690463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqi3iZnSO0pCz4r86HvzjXAIoq/LUkNm+cOCoheLdcU=;
        b=PF7uKoNwCPR6zjIMA13DVfXB944WyzfaHC1tFZ96lEz6sE4vFnkOUu/vfHjF7MPwbP
         HXAUwL9N24LleaIZh/HN/p7MMdAsztvj2MwrfRxH8zfBhgazOsQWKOfARh2k2zFEwZLh
         PkCmWAtrIOBvmyBTt3iqFF9FN183uEHTX0GNKyEU5Dq33rfYiNaFF54uCM5aXMH+QsVI
         J0YSo5o94cTAF3mxXbg1jiH/GTYKgKiKZuoYP9/zGUEiZmRLhhihgJfTmCwldfbZkiXf
         c0FS091pl8h7r+0aYmmhWHgyvClsbQTuw3LShdcsM5TdqFrk3/PFoH6aOsyu4ots/JQb
         Qk+A==
X-Gm-Message-State: ABy/qLbbqpSKfZOYeEnrnPWMFtpky/Brs4S0SeP1CEMHYOT1+Qt3BYC/
        64/+VMIm2oD8nQ9q7/RpOX0LUg==
X-Google-Smtp-Source: APBJJlFqOcYVb1YmYRN4MTpyz32muTvUlVIwXMvqlj269qOtTWbHmeKplda1rvUua7TwvFx4MZypxQ==
X-Received: by 2002:a05:6a00:2351:b0:687:5c3f:d834 with SMTP id j17-20020a056a00235100b006875c3fd834mr8861510pfj.11.1691085663545;
        Thu, 03 Aug 2023 11:01:03 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:01:03 -0700 (PDT)
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
Subject: [RFC PATCH v1 12/21] irqchip/riscv-intc: Use swnode framework to create fwnode
Date:   Thu,  3 Aug 2023 23:29:07 +0530
Message-Id: <20230803175916.3174453-13-sunilvl@ventanamicro.com>
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

By using swnode framework, all data from ACPI tables can
be populated as properties of the swnode. This simplifies
the driver code and removes the need for ACPI vs DT checks.
Use this framework for RISC-V INTC driver.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 Documentation/riscv/acpi.rst     | 21 +++++++++++++++
 arch/riscv/include/asm/acpi.h    |  1 +
 drivers/acpi/riscv/Makefile      |  2 +-
 drivers/acpi/riscv/irqchip.c     | 46 ++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-intc.c | 12 ++++-----
 5 files changed, 75 insertions(+), 7 deletions(-)
 create mode 100644 drivers/acpi/riscv/irqchip.c

diff --git a/Documentation/riscv/acpi.rst b/Documentation/riscv/acpi.rst
index 9870a282815b..e2406546bc16 100644
--- a/Documentation/riscv/acpi.rst
+++ b/Documentation/riscv/acpi.rst
@@ -8,3 +8,24 @@ The ISA string parsing rules for ACPI are defined by `Version ASCIIDOC
 Conversion, 12/2022 of the RISC-V specifications, as defined by tag
 "riscv-isa-release-1239329-2023-05-23" (commit 1239329
 ) <https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-1239329-2023-05-23>`_
+
+Interrupt Controller Drivers
+=======
+
+ACPI drivers for RISC-V interrupt controllers use software node framework to
+create the fwnode for the interrupt controllers. Below properties are
+additionally required for some firmware nodes apart from the properties
+defined by the device tree bindings for these interrupt controllers. The
+properties are created using the data in MADT table.
+
+1) RISC-V Interrupt Controller (INTC)
+-----------
+``hartid`` - Hart ID of the hart this interrupt controller belongs to.
+
+``riscv,imsic-addr`` - Physical base address of the Incoming MSI Controller
+(IMSIC) MMIO region of this hart.
+
+``riscv,imsic-size`` - Size in bytes of the IMSIC MMIO region of this hart.
+
+``riscv,ext-intc-id`` - The unique ID of the external interrupts connected
+to this hart.
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 0c4e8b35103e..0ac2df2dd194 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -68,6 +68,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu, u32 *cbom_size,
 			    u32 *cboz_size, u32 *cbop_size);
+struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_rintc *rintc);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 8b3b126e0b94..8b664190d172 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y 	+= rhct.o
+obj-y 	+= rhct.o irqchip.o
diff --git a/drivers/acpi/riscv/irqchip.c b/drivers/acpi/riscv/irqchip.c
new file mode 100644
index 000000000000..36f066a2cad5
--- /dev/null
+++ b/drivers/acpi/riscv/irqchip.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/fwnode.h>
+#include <linux/irqdomain.h>
+#include <linux/list.h>
+#include <linux/property.h>
+
+struct riscv_irqchip_list {
+	struct fwnode_handle *fwnode;
+	struct list_head list;
+};
+
+LIST_HEAD(rintc_list);
+
+struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_rintc *rintc)
+{
+	struct property_entry props[6] = {};
+	struct fwnode_handle *fwnode;
+	struct riscv_irqchip_list *rintc_element;
+
+	props[0] = PROPERTY_ENTRY_U64("hartid", rintc->hart_id);
+	props[1] = PROPERTY_ENTRY_U32("riscv,ext-intc-id", rintc->ext_intc_id);
+	props[2] = PROPERTY_ENTRY_U64("riscv,imsic-addr", rintc->imsic_addr);
+	props[3] = PROPERTY_ENTRY_U32("riscv,imsic-size", rintc->imsic_size);
+	props[4] = PROPERTY_ENTRY_U32("#interrupt-cells", 1);
+
+	fwnode = fwnode_create_software_node_early(props, NULL);
+	if (fwnode) {
+		rintc_element = kzalloc(sizeof(*rintc_element), GFP_KERNEL);
+		if (!rintc_element) {
+			fwnode_remove_software_node(fwnode);
+			return NULL;
+		}
+
+		rintc_element->fwnode = fwnode;
+		list_add_tail(&rintc_element->list, &rintc_list);
+	}
+
+	return fwnode;
+}
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 1a0fc87152c5..1ef9cada1ed3 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -203,6 +203,12 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 
 	rintc = (struct acpi_madt_rintc *)header;
 
+	fn = acpi_rintc_create_irqchip_fwnode(rintc);
+	if (!fn) {
+		pr_err("unable to create INTC FW node\n");
+		return -ENOMEM;
+	}
+
 	/*
 	 * The ACPI MADT will have one INTC for each CPU (or HART)
 	 * so riscv_intc_acpi_init() function will be called once
@@ -212,12 +218,6 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id())
 		return 0;
 
-	fn = irq_domain_alloc_named_fwnode("RISCV-INTC");
-	if (!fn) {
-		pr_err("unable to allocate INTC FW node\n");
-		return -ENOMEM;
-	}
-
 	return riscv_intc_init_common(fn);
 }
 
-- 
2.39.2

