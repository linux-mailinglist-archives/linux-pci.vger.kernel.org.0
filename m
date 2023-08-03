Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA70276F14E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjHCSDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbjHCSDE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:03:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F64220
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:01:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so915107b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085702; x=1691690502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqlDPHKEWaBxTYs/0M8htriIKOWDT6nuJRMhsrHXzuE=;
        b=Mck7EqqRTTHdMEBXbHLoZwfOLdXJUnVodFv/es6odb8/Qq21nUhzlxmcrCQpHegUV1
         qKWa65jRjHgYqT8ANyBw+GVASKqCOwBtVtvNwTQ9NuaGjcZ06UVpzTbD4zoHTAFAiZAq
         bC+kKVzDGdpGns7pLFPMO4CYn2tXf14kK4mXYgydh1+8YK5+ZpXO+dgkvzgwmGncgRDC
         EBqiRVaPJMAiim+QopcXM5/33h+EYYtGMCn9nVz286lZO7qUY51KfF5NwHxIJsTOYCRL
         nNpgZRPcRYp3J92EJNQFHRsHz+vYpZwdP4h6z60CpUAwZ3rmeewQu9jN+Ugw4weQY+0J
         wUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085702; x=1691690502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqlDPHKEWaBxTYs/0M8htriIKOWDT6nuJRMhsrHXzuE=;
        b=SkNAXirfOdyeGfwtAjLRmIoPdb6OeIsWM7S48qvbgPb78kdO8aWd7f/N7Pptx8sdZY
         a/dMl8v7X9FyNpBjYyEUv7pEBW9w6g7oh8WIv/uP4CZtV+7sw3g3a+Bw8q0GT3oEF/Wh
         jRItCpWPAh/R8k2Q1o7zFdRbb6qch4UKNz4m2NYlWV8VpOL7ypadvYKQL5rYokhyee4g
         9G6H2klHmaSQV06FzQA1tRZl8QXNwewYtFmKyH7COZVgPjq9CJM7wsysku0L1p0X1qEf
         P2EjqUu6dejHoze7DtCu3psTCjs9QI9aqv7s5Hq05852k9CHgeIjrLjYCtkmMtBprcAM
         A2Yg==
X-Gm-Message-State: ABy/qLbyNXaHSzLDl6mT4s95KCmudL+PjnnKiKJmeEccHfsW6GwopLLP
        +qSon8Pfqg8u9A9Etk92P7j0wA==
X-Google-Smtp-Source: APBJJlEpOrcULPp+uHqf2SkiWQTzFmTJeS1yI+fASG26f/nZjZ0ASal13fAyFeapUfbB4CtpRCGyhA==
X-Received: by 2002:a05:6a21:3b44:b0:130:9638:36d4 with SMTP id zy4-20020a056a213b4400b00130963836d4mr15110479pzb.33.1691085701012;
        Thu, 03 Aug 2023 11:01:41 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:01:40 -0700 (PDT)
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
Subject: [RFC PATCH v1 17/21] ACPI: RISC-V: Create APLIC platform device
Date:   Thu,  3 Aug 2023 23:29:12 +0530
Message-Id: <20230803175916.3174453-18-sunilvl@ventanamicro.com>
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

Since APLIC needs to be a platform device, probe the
MADT and create platform devices for each APLIC in the
system. Use software node framework for the fwnode
which allows to create properties and hence the
actual irqchip driver doesn't need to do anything
different for ACPI vs DT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 Documentation/riscv/acpi.rst |   6 ++
 drivers/acpi/riscv/init.c    |   1 +
 drivers/acpi/riscv/init.h    |   1 +
 drivers/acpi/riscv/irqchip.c | 183 +++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+)

diff --git a/Documentation/riscv/acpi.rst b/Documentation/riscv/acpi.rst
index e2406546bc16..9ea9008288ea 100644
--- a/Documentation/riscv/acpi.rst
+++ b/Documentation/riscv/acpi.rst
@@ -29,3 +29,9 @@ properties are created using the data in MADT table.
 
 ``riscv,ext-intc-id`` - The unique ID of the external interrupts connected
 to this hart.
+
+2) RISC-V Advanced Platform Level Interrupt Controller (APLIC)
+-----------
+
+``riscv,gsi-base`` - The global system interrupt number where this APLIC’s
+interrupt inputs start.
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index be61c08ea385..ee747211174f 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -11,4 +11,5 @@
 void __init acpi_riscv_init(void)
 {
 	riscv_acpi_imsic_platform_init();
+	riscv_acpi_aplic_platform_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
index a2f72bb294d3..17bcf0baaadb 100644
--- a/drivers/acpi/riscv/init.h
+++ b/drivers/acpi/riscv/init.h
@@ -2,3 +2,4 @@
 #include <linux/init.h>
 
 void __init riscv_acpi_imsic_platform_init(void);
+void __init riscv_acpi_aplic_platform_init(void);
diff --git a/drivers/acpi/riscv/irqchip.c b/drivers/acpi/riscv/irqchip.c
index ca96bf109cf7..7fb7befdb303 100644
--- a/drivers/acpi/riscv/irqchip.c
+++ b/drivers/acpi/riscv/irqchip.c
@@ -23,6 +23,8 @@ LIST_HEAD(rintc_list);
 
 static struct fwnode_handle *imsic_acpi_fwnode;
 
+LIST_HEAD(aplic_list);
+
 struct fwnode_handle *acpi_rintc_create_irqchip_fwnode(struct acpi_madt_rintc *rintc)
 {
 	struct property_entry props[6] = {};
@@ -124,3 +126,184 @@ void __init riscv_acpi_imsic_platform_init(void)
 	if (ret)
 		platform_device_put(pdev);
 }
+
+/*
+ * The ext_intc_id format is as follows:
+ * Bits [31:24] APLIC/PLIC ID
+ * Bits [15:0] APLIC IDC ID / PLIC S-Mode Context ID for this hart
+ */
+#define APLIC_PLIC_ID(x) ((x) >> 24)
+#define IDC_CONTEXT_ID(x) ((x) & 0x0000ffff)
+
+static struct fwnode_handle *acpi_ext_intc_get_rintc_fwnode(u8 aplic_plic_id, u16 index)
+{
+	struct riscv_irqchip_list *rintc_element;
+	struct fwnode_handle *fwnode;
+	struct list_head *i, *tmp;
+	u32 id;
+	int rc;
+
+	list_for_each_safe(i, tmp, &rintc_list) {
+		rintc_element = list_entry(i, struct riscv_irqchip_list, list);
+		fwnode = rintc_element->fwnode;
+		rc = fwnode_property_read_u32_array(fwnode, "riscv,ext-intc-id", &id, 1);
+		if (rc)
+			continue;
+
+		if ((APLIC_PLIC_ID(id) == aplic_plic_id) && (IDC_CONTEXT_ID(id) == index))
+			return fwnode;
+	}
+
+	return NULL;
+}
+
+static struct fwnode_handle *acpi_aplic_create_fwnode(struct acpi_madt_aplic *aplic)
+{
+	struct fwnode_handle *fwnode, *parent_fwnode;
+	struct riscv_irqchip_list *aplic_element;
+	struct software_node_ref_args *refs;
+	struct property_entry props[8] = {};
+	unsigned int i;
+
+	props[0] = PROPERTY_ENTRY_U32("riscv,gsi-base", aplic->gsi_base);
+	props[1] = PROPERTY_ENTRY_U32("riscv,num-sources", aplic->num_sources);
+	props[2] = PROPERTY_ENTRY_U32("riscv,num-idcs", aplic->num_idcs);
+	props[3] = PROPERTY_ENTRY_U32("riscv,aplic-id", aplic->id);
+	props[4] = PROPERTY_ENTRY_U64("riscv,aplic-base", aplic->base_addr);
+	props[5] = PROPERTY_ENTRY_U32("riscv,aplic-size", aplic->size);
+	if (aplic->num_idcs) {
+		refs = kcalloc(aplic->num_idcs, sizeof(*refs), GFP_KERNEL);
+		if (!refs)
+			return NULL;
+
+		for (i = 0; i < aplic->num_idcs; i++) {
+			parent_fwnode = acpi_ext_intc_get_rintc_fwnode(aplic->id, i);
+			refs[i] = SOFTWARE_NODE_REFERENCE(to_software_node(parent_fwnode),
+							  RV_IRQ_EXT);
+		}
+		props[6] = PROPERTY_ENTRY_REF_ARRAY_LEN("interrupts-extended",
+							refs, aplic->num_idcs);
+	} else {
+		props[6] = PROPERTY_ENTRY_BOOL("msi-parent");
+	}
+
+	fwnode = fwnode_create_software_node_early(props, NULL);
+
+	if (fwnode) {
+		aplic_element = kzalloc(sizeof(*aplic_element), GFP_KERNEL);
+		if (!aplic_element) {
+			fwnode_remove_software_node(fwnode);
+			return NULL;
+		}
+
+		aplic_element->fwnode = fwnode;
+		list_add_tail(&aplic_element->list, &aplic_list);
+	}
+
+	return fwnode;
+}
+
+static struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi)
+{
+	struct riscv_irqchip_list *aplic_element;
+	struct fwnode_handle *fwnode;
+	struct list_head *i, *tmp;
+	u32 gsi_base;
+	u32 nr_irqs;
+	int rc;
+
+	list_for_each_safe(i, tmp, &aplic_list) {
+		aplic_element = list_entry(i, struct riscv_irqchip_list, list);
+		fwnode = aplic_element->fwnode;
+		rc = fwnode_property_read_u32_array(fwnode, "riscv,gsi-base", &gsi_base, 1);
+		if (!rc) {
+			rc = fwnode_property_read_u32_array(fwnode, "riscv,num-sources",
+							    &nr_irqs, 1);
+			if (!rc && (gsi >= gsi_base && gsi < gsi_base + nr_irqs))
+				return fwnode;
+		}
+	}
+
+	return NULL;
+}
+
+static u32 __init aplic_gsi_to_irq(u32 gsi)
+{
+	return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+}
+
+static int __init aplic_create_platform_device(struct fwnode_handle *fwnode)
+{
+	struct platform_device *pdev;
+	u32 aplic_size, aplic_id;
+	struct resource *res;
+	u64 aplic_base;
+	int ret;
+
+	if (!fwnode)
+		return -ENODEV;
+
+	ret = fwnode_property_read_u64_array(fwnode, "riscv,aplic-base", &aplic_base, 1);
+	if (ret)
+		return -ENODEV;
+
+	ret = fwnode_property_read_u32_array(fwnode, "riscv,aplic-size", &aplic_size, 1);
+	if (ret)
+		return -ENODEV;
+
+	ret = fwnode_property_read_u32_array(fwnode, "riscv,aplic-id", &aplic_id, 1);
+	if (ret)
+		return -ENODEV;
+
+	pdev = platform_device_alloc("riscv-aplic", aplic_id);
+	if (!pdev)
+		return -ENOMEM;
+
+	res = kcalloc(1, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		ret = -ENOMEM;
+		goto dev_put;
+	}
+
+	res->start = aplic_base;
+	res->end = res->start + aplic_size - 1;
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
+static int __init aplic_parse_madt(union acpi_subtable_headers *header,
+				   const unsigned long end)
+{
+	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
+	struct fwnode_handle *fwnode;
+
+	fwnode = acpi_aplic_create_fwnode(aplic);
+	if (fwnode)
+		aplic_create_platform_device(fwnode);
+
+	return 0;
+}
+
+void __init riscv_acpi_aplic_platform_init(void)
+{
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0) > 0) {
+		acpi_set_irq_model(ACPI_IRQ_MODEL_APLIC, aplic_get_gsi_domain_id);
+		acpi_set_gsi_to_irq_fallback(aplic_gsi_to_irq);
+	}
+}
-- 
2.39.2

