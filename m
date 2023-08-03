Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70F76F15A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHCSEH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHCSDQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:03:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849A49C5
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:02:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so869752b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085724; x=1691690524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+Q8KfNrcpLCQ+Zm4Z9cXmSMTUQ/Cx2NE3GzYzgbHwU=;
        b=TWzDXrq5rkDXP54lt1KXIhB7yRYTfDMnjicYqveI1Fv/QGFp5xa1yM7dqucAsYbXYH
         htp+oGPiIC+rC4eCLBCyGmtdcF8p3+QFwFxMOgrtdUFz6o4LbGtNAZWGo0DpXwodLlTq
         ZKvGdwZtZf2BXqFokABG7lCPfApf0Y8vwZUy+Ee1WBFXJUNK5UGwZsuE5I2KobJ3fI8x
         4ByezcpRBxt/a5trnhAacwlm3z1zVcLLfLn4VmW4p4mQ7CmLjEqbX6UzsGsZGFCuov1G
         RnAKm5FwFaUNNZTLqCG57ZrMHp/PjpulrpD8pmQ6sDJDUl2BfiR0RJb7qyVpPYWSy8SY
         h7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085724; x=1691690524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+Q8KfNrcpLCQ+Zm4Z9cXmSMTUQ/Cx2NE3GzYzgbHwU=;
        b=l3c3gIa+RINACUl1JE92qV3SIm3Bm+E3fd56sYkGp5ZJfkFgBjSo5MkcZDsGsyXmdk
         IAXS5HZ0p5HShyvJGUfZRwrGQ80msjjQRU6R9QEhLA+WBd6oi7eoj4YOoGMSrAGCc3vM
         np8vnNGMwz/6jV7ikdQL21CWs9USlY/1V9hJbId3bJ38TEdBiXZ9HJFDbg0FCIDhofFr
         YFM7pN40EN3Vr+Izmx+ffsfrjJZUEAsvYLrkV6cTHXdp94NJQXzlVsWZypEsjWh/Be0/
         aMxS63tBzZ8WwlHtoc4eF9+2VP1ITQ3RBcOyAhqgteml12x3H+PWQlblxCetSx97xR1i
         W4ew==
X-Gm-Message-State: ABy/qLam6WXWAhRpRKMWsjwfl9FiOntcFGePabrhhT51Msi8DKeQYUt6
        ZCMdnv5VVLc2gutJR02Y+0oRxQ==
X-Google-Smtp-Source: APBJJlH/rurRin9y29M3aaOJtb8cTFXCf64b42mFfS4paTtxGXHirLrg+/10tPI3KDoH92gXeSNR0A==
X-Received: by 2002:a05:6a00:2286:b0:687:570c:da2d with SMTP id f6-20020a056a00228600b00687570cda2dmr10882734pfe.12.1691085723889;
        Thu, 03 Aug 2023 11:02:03 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:02:03 -0700 (PDT)
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
Subject: [RFC PATCH v1 20/21] RISC-V: ACPI: Create PLIC platform device
Date:   Thu,  3 Aug 2023 23:29:15 +0530
Message-Id: <20230803175916.3174453-21-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since PLIC needs to be a platform device, probe the
MADT and create platform devices for each PLIC in the
system. Use software node framework for the fwnode
which allows to create properties and hence the
actual irqchip driver doesn't need to do anything
different for ACPI vs DT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 Documentation/riscv/acpi.rst  |   6 ++
 arch/riscv/include/asm/acpi.h |   3 +
 drivers/acpi/riscv/init.c     |   1 +
 drivers/acpi/riscv/init.h     |   1 +
 drivers/acpi/riscv/irqchip.c  | 198 ++++++++++++++++++++++++++++++++++
 5 files changed, 209 insertions(+)

diff --git a/Documentation/riscv/acpi.rst b/Documentation/riscv/acpi.rst
index 9ea9008288ea..007483dfddc1 100644
--- a/Documentation/riscv/acpi.rst
+++ b/Documentation/riscv/acpi.rst
@@ -35,3 +35,9 @@ to this hart.
 
 ``riscv,gsi-base`` - The global system interrupt number where this APLIC’s
 interrupt inputs start.
+
+3) RISC-V Platform Level Interrupt Controller (PLIC)
+-----------
+
+``riscv,gsi-base`` - The global system interrupt number where this PLIC’s
+interrupt inputs start.
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6dde3d63dc0e..163b8eefa744 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -71,6 +71,7 @@ int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu, u
 struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_rintc *rintc);
 struct fwnode_handle *acpi_imsic_create_fwnode(struct acpi_madt_imsic *imsic);
 struct fwnode_handle *acpi_riscv_get_msi_fwnode(struct device *dev);
+int acpi_plic_get_context_id(u8 plic_id, u16 idx);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -95,6 +96,8 @@ static inline struct fwnode_handle *acpi_riscv_get_msi_fwnode(struct device *dev
 {
 	return NULL;
 }
+
+static inline int acpi_plic_get_context_id(u8 plic_id, u16 idx) { return idx; }
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index ee747211174f..cc733ea9ef1d 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -12,4 +12,5 @@ void __init acpi_riscv_init(void)
 {
 	riscv_acpi_imsic_platform_init();
 	riscv_acpi_aplic_platform_init();
+	riscv_acpi_plic_platform_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
index 17bcf0baaadb..b4b305d83b3a 100644
--- a/drivers/acpi/riscv/init.h
+++ b/drivers/acpi/riscv/init.h
@@ -3,3 +3,4 @@
 
 void __init riscv_acpi_imsic_platform_init(void);
 void __init riscv_acpi_aplic_platform_init(void);
+void __init riscv_acpi_plic_platform_init(void);
diff --git a/drivers/acpi/riscv/irqchip.c b/drivers/acpi/riscv/irqchip.c
index 7fb7befdb303..cb70f0f2294b 100644
--- a/drivers/acpi/riscv/irqchip.c
+++ b/drivers/acpi/riscv/irqchip.c
@@ -25,6 +25,8 @@ static struct fwnode_handle *imsic_acpi_fwnode;
 
 LIST_HEAD(aplic_list);
 
+LIST_HEAD(plic_list);
+
 struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_rintc *rintc)
 {
 	struct property_entry props[6] = {};
@@ -307,3 +309,199 @@ void __init riscv_acpi_aplic_platform_init(void)
 		acpi_set_gsi_to_irq_fallback(aplic_gsi_to_irq);
 	}
 }
+
+static int acpi_plic_get_nr_contexts(u8 plic_id)
+{
+	struct riscv_irqchip_list *rintc_element;
+	struct fwnode_handle *fwnode;
+	struct list_head *i, *tmp;
+	u32 id;
+	int rc, nr_contexts = 0;
+
+	list_for_each_safe(i, tmp, &rintc_list) {
+		rintc_element = list_entry(i, struct riscv_irqchip_list, list);
+		fwnode = rintc_element->fwnode;
+		rc = fwnode_property_read_u32_array(fwnode, "riscv,ext-intc-id", &id, 1);
+		if (rc)
+			continue;
+
+		if (APLIC_PLIC_ID(id) == plic_id)
+			nr_contexts++;
+	}
+
+	return nr_contexts * 2;
+}
+
+int acpi_plic_get_context_id(u8 plic_id, u16 idx)
+{
+	struct riscv_irqchip_list *rintc_element;
+	struct fwnode_handle *fwnode;
+	struct list_head *i, *tmp;
+	u32 id;
+	int rc, nr_contexts = -1;
+
+	list_for_each_safe(i, tmp, &rintc_list) {
+		rintc_element = list_entry(i, struct riscv_irqchip_list, list);
+		fwnode = rintc_element->fwnode;
+		rc = fwnode_property_read_u32_array(fwnode, "riscv,ext-intc-id", &id, 1);
+		if (rc)
+			continue;
+
+		if (APLIC_PLIC_ID(id) == plic_id)
+			nr_contexts++;
+		if (nr_contexts == idx)
+			return IDC_CONTEXT_ID(id);
+	}
+
+	return -1;
+}
+
+static struct fwnode_handle *acpi_plic_create_fwnode(struct acpi_madt_plic *plic)
+{
+	struct fwnode_handle *fwnode, *parent_fwnode;
+	struct riscv_irqchip_list *plic_element;
+	struct software_node_ref_args *refs;
+	struct property_entry props[8] = {};
+	int nr_contexts;
+
+	props[0] = PROPERTY_ENTRY_U32("riscv,gsi-base", plic->gsi_base);
+	props[1] = PROPERTY_ENTRY_U32("riscv,ndev", plic->num_irqs);
+	props[2] = PROPERTY_ENTRY_U32("riscv,max_prio", plic->max_prio);
+	props[3] = PROPERTY_ENTRY_U8("riscv,plic-id", plic->id);
+	props[4] = PROPERTY_ENTRY_U64("riscv,plic-base", plic->base_addr);
+	props[5] = PROPERTY_ENTRY_U32("riscv,plic-size", plic->size);
+
+	nr_contexts = acpi_plic_get_nr_contexts(plic->id);
+	if (nr_contexts) {
+		refs = kcalloc(nr_contexts, sizeof(*refs), GFP_KERNEL);
+		for (int i = 0; i < nr_contexts / 2; i++) {
+			int context_id = acpi_plic_get_context_id(plic->id, i);
+
+			parent_fwnode = acpi_ext_intc_get_rintc_fwnode(plic->id, context_id);
+			refs[2 * i] = SOFTWARE_NODE_REFERENCE(to_software_node(parent_fwnode), 0);
+			refs[2 * i + 1] = SOFTWARE_NODE_REFERENCE(to_software_node(parent_fwnode),
+								  RV_IRQ_EXT);
+		}
+		props[6] = PROPERTY_ENTRY_REF_ARRAY_LEN("interrupts-extended", refs, nr_contexts);
+	}
+
+	fwnode = fwnode_create_software_node_early(props, NULL);
+
+	if (fwnode) {
+		plic_element = kzalloc(sizeof(*plic_element), GFP_KERNEL);
+		if (!plic_element) {
+			fwnode_remove_software_node(fwnode);
+			return NULL;
+		}
+
+		plic_element->fwnode = fwnode;
+		list_add_tail(&plic_element->list, &plic_list);
+	}
+
+	return fwnode;
+}
+
+static struct fwnode_handle *plic_get_gsi_domain_id(u32 gsi)
+{
+	struct riscv_irqchip_list *plic_element;
+	struct fwnode_handle *fwnode;
+	struct list_head *i, *tmp;
+	u32 gsi_base;
+	u32 nr_irqs;
+	int rc;
+
+	list_for_each_safe(i, tmp, &plic_list) {
+		plic_element = list_entry(i, struct riscv_irqchip_list, list);
+		fwnode = plic_element->fwnode;
+		rc = fwnode_property_read_u32_array(fwnode, "riscv,gsi-base", &gsi_base, 1);
+		if (!rc) {
+			rc = fwnode_property_read_u32_array(fwnode, "riscv,ndev", &nr_irqs, 1);
+			if (!rc && (gsi >= gsi_base && gsi < gsi_base + nr_irqs))
+				return fwnode;
+		}
+	}
+
+	return NULL;
+}
+
+static u32 plic_gsi_to_irq(u32 gsi)
+{
+	return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+}
+
+static int __init plic_create_platform_device(struct fwnode_handle *fwnode)
+{
+	struct platform_device *pdev;
+	u32 plic_size;
+	u8  plic_id;
+	struct resource *res;
+	u64 plic_base;
+	int ret;
+
+	if (!fwnode)
+		return -ENODEV;
+
+	ret = fwnode_property_read_u64_array(fwnode, "riscv,plic-base", &plic_base, 1);
+	if (ret)
+		return -ENODEV;
+
+	ret = fwnode_property_read_u32_array(fwnode, "riscv,plic-size", &plic_size, 1);
+	if (ret)
+		return -ENODEV;
+
+	ret = fwnode_property_read_u8_array(fwnode, "riscv,plic-id", &plic_id, 1);
+	if (ret)
+		return -ENODEV;
+
+	pdev = platform_device_alloc("riscv-plic", plic_id);
+	if (!pdev)
+		return -ENOMEM;
+
+	res = kcalloc(1, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		ret = -ENOMEM;
+		goto dev_put;
+	}
+
+	res->start = plic_base;
+	res->end = res->start + plic_size - 1;
+	res->flags = IORESOURCE_MEM;
+	ret = platform_device_add_resources(pdev, res, 1);
+	/*
+	 * Resources are duplicated in platform_device_add_resources,
+	 * free their allocated memory
+	 */
+	kfree(res);
+
+	pdev->dev.fwnode = fwnode;
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto dev_put;
+
+	return 0;
+
+dev_put:
+	platform_device_put(pdev);
+	return ret;
+}
+
+static int __init plic_parse_madt(union acpi_subtable_headers *header,
+				  const unsigned long end)
+{
+	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
+	struct fwnode_handle *fwnode;
+
+	fwnode = acpi_plic_create_fwnode(plic);
+	if (fwnode)
+		plic_create_platform_device(fwnode);
+
+	return 0;
+}
+
+void __init riscv_acpi_plic_platform_init(void)
+{
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, plic_parse_madt, 0) > 0) {
+		acpi_set_irq_model(ACPI_IRQ_MODEL_PLIC, plic_get_gsi_domain_id);
+		acpi_set_gsi_to_irq_fallback(plic_gsi_to_irq);
+	}
+}
-- 
2.39.2

