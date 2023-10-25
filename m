Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C777D75AA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjJYU1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjJYU1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:27:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894221FCE
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:26:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso150870a12.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265565; x=1698870365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyAbjmaR4eN/4ltFJMCVbHeHJN24CQKSdc3guUQ+sXY=;
        b=lYxzdUsuOneYhoIV+rYgVVKZNSp0/KjI1w4hVj4ZjBNi+d684vIjZpU3C5bvKho2ua
         T2HrWtolaPG2TtCyFcRW3Xxn5fhO+hrUq0ptTInqJZpUTl6SEfVKEY0lCWGHetvIItds
         a1q4/Rd9BDYEV60OZ/wnKfgr2DV0HhRXr7hQWLRB7a4JI6UCSb1IEnbVRoCK6N5+zJQ0
         E0xjWFarsTv4yN7dEsRjvdFs32Fj+9KZwuRWlZfe+pfoND04lmh6m1gf2zVvL+qSKrgH
         Al57+cknEsACPvo1q0XjaTcQjPfchYsjS+zI9JL+wL2NK2BykB3W+pb5SlOr+1hLhTKX
         nSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265565; x=1698870365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyAbjmaR4eN/4ltFJMCVbHeHJN24CQKSdc3guUQ+sXY=;
        b=MesG5EotlbIkyqdprYc3lPZ9qhFP83yJ/5IRXrveZtOnaamnOgo44lxeFfudR/M0Fh
         wMzNC8xfYIzQTSBawhFqaXF7gNtKHyQvWgPXwZcnydJ3zIqi6GH8hQbhUgGPpQUYSnha
         zvhRfbJZXrUEvBCw+JVqtC4L00tOof580x/nbO8RyihKL6QQHWvkkZrt9+HFYO2ytt5k
         V17JLPTVxddSbedc8Rv6+MN6cwdc+0QYhojaHZlSHRD1cm3/mHNMKBSsM6tfPrlr00N8
         xeRXxqShBa6pjkNXLjmuDI6r5qMNbzegIPhSv2TUvXMyEX0wmJ8cXyme8qOT487zSVn3
         hvGw==
X-Gm-Message-State: AOJu0YyZwu8nbQfN04QktgDLealOn3LCg9SE/WZ2l4ZfW2b2BJscXvr8
        tocwewyh8nAbUXObPdwNb36xTg==
X-Google-Smtp-Source: AGHT+IF7LV+DTM8Xp2zCb8vMCjjf9RgtWialAHShVkTza7omnaz58BwRnPvcOqBLoChX7glmevCqxQ==
X-Received: by 2002:a05:6a20:3d13:b0:16b:8132:b547 with SMTP id y19-20020a056a203d1300b0016b8132b547mr8489178pzi.4.1698265564985;
        Wed, 25 Oct 2023 13:26:04 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:26:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 20/21] ACPI: RISC-V: Create APLIC platform device
Date:   Thu, 26 Oct 2023 01:53:43 +0530
Message-Id: <20231025202344.581132-21-sunilvl@ventanamicro.com>
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

Since APLIC needs to be a platform device, probe the MADT and create
platform devices for each APLIC in the system.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/init.c |  2 ++
 drivers/acpi/riscv/init.h |  5 +++
 drivers/acpi/riscv/irq.c  | 74 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/acpi/riscv/init.h

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index b5807bbdb171..e7eff7ab1474 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/acpi.h>
+#include "init.h"
 
 void __init acpi_riscv_init(void)
 {
+	riscv_acpi_aplic_platform_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
new file mode 100644
index 000000000000..17bcf0baaadb
--- /dev/null
+++ b/drivers/acpi/riscv/init.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/init.h>
+
+void __init riscv_acpi_imsic_platform_init(void);
+void __init riscv_acpi_aplic_platform_init(void);
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 36e0525b3235..fbccecdcbf8b 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/irqdomain.h>
+#include <linux/platform_device.h>
 #include <linux/sort.h>
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
@@ -30,3 +32,75 @@ void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
 		return;
 	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
 }
+
+static int __init irqchip_add_platform_device(char *irqchip_name, u32 irqchip_id,
+					      resource_size_t iomem_res_start,
+					      resource_size_t iomem_res_size,
+					      union acpi_subtable_headers *header)
+{
+	struct platform_device *pdev;
+	struct fwnode_handle *fn;
+	struct resource *res;
+	int ret;
+
+	fn = irq_domain_alloc_named_id_fwnode(irqchip_name, irqchip_id);
+	if (!fn)
+		return -ENOMEM;
+
+	pdev = platform_device_alloc(irqchip_name, irqchip_id);
+	if (!pdev) {
+		irq_domain_free_fwnode(fn);
+		return -ENOMEM;
+	}
+
+	res = kcalloc(1, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		irq_domain_free_fwnode(fn);
+		platform_device_put(pdev);
+		return -ENOMEM;
+	}
+
+	res->start = iomem_res_start;
+	res->end = res->start + iomem_res_size - 1;
+	res->flags = IORESOURCE_MEM;
+	ret = platform_device_add_resources(pdev, res, 1);
+	/*
+	 * Resources are duplicated in platform_device_add_resources,
+	 * free their allocated memory
+	 */
+	kfree(res);
+
+	/*
+	 * Add copy of aplic pointer so that platform driver get aplic details.
+	 */
+	ret = platform_device_add_data(pdev, &header, sizeof(header));
+	if (ret) {
+		irq_domain_free_fwnode(fn);
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	pdev->dev.fwnode = fn;
+	ret = platform_device_add(pdev);
+	if (ret) {
+		irq_domain_free_fwnode(fn);
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init aplic_parse_madt(union acpi_subtable_headers *header,
+				   const unsigned long end)
+{
+	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
+
+	return irqchip_add_platform_device("riscv-aplic", aplic->id, aplic->base_addr,
+					   aplic->size, header);
+}
+
+void __init riscv_acpi_aplic_platform_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0);
+}
-- 
2.39.2

