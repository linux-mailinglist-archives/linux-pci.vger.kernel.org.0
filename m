Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1697D756C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjJYUYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJYUYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:24:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B712A
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:24:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso126592b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265460; x=1698870260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il/rbbBih8ETNOL/0gi7mQnwMr9PQruIC4HVqlbsTs0=;
        b=cpHqw6Ko3XBXaXjWZ2O0xRulHJ+115MQRPzNMFsfrt14xH96seITodu0Y+SWsiWCST
         6pWhR+UxbgdBdR/SOzQK8vOATWnQNus0CEKcmfVGjM7OxS6eUc0z89y9fk6cvTTkd1Tn
         K7V1x8mXwsramj8XqH18q1J7VNYAtiXbZyuUmYXDQaQqGCay9MNIosNf7VHAQvKxNa0H
         4JN0iJKu/M1CM4BSURbHiCnxs4wbvNeNy2gikGl8PNMtUTh5tdCtEqYGKp/O8Nimm/7A
         T2SGIeS8++loU1mgwGUdu+A8eGtwf+zITm7nOeYPxn5Oyhhyzaf09opZ+ry0h+t3rumK
         uVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265460; x=1698870260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il/rbbBih8ETNOL/0gi7mQnwMr9PQruIC4HVqlbsTs0=;
        b=KZWpZklxCh1yOh0/K9VZPRu3MAO0B+VsesVghm4mpVxrk+2MHNtVLq301qmD6U/brt
         6ZQmyWPo0lPesqvjhoFxyLwZ8tV0qEtsj47szN9mlJvWt3kH6/waHyARCwgpmpGwK05w
         w1Qh79jndOt9l99wTvyRwjJ1u6JzG8aQ99vvKGFKn6sacAJsjObYyhArJkoRapWfi+49
         wo1P7nJsR7YOgNkXkcXnjZAoqtVRh0OhgbjpIzPt2/Nm87T9ygybB6uEGb7JqBrXDaXA
         49agrcp5v+M8ABtqnUDCxN6LzqY7LO6LeXoVPu5zXFU1iZXT4WbTvsY0WxDY2K9O24Zm
         3Rig==
X-Gm-Message-State: AOJu0YxB2nIZjZ+P+1xNPuWF6SH3DF/EQYrs/FH7IiFcnqZ1kOZ5iz2A
        IGhuW4g95znMT4Py/Y0Efw2Ecg==
X-Google-Smtp-Source: AGHT+IHAnCPM/Z122/pk/4UjZRlnQX59HcM6kQVsLk17lGf/hhEOulm69KFX9/lCmDwSpdfrn7JfVw==
X-Received: by 2002:a05:6a00:9392:b0:693:4143:5145 with SMTP id ka18-20020a056a00939200b0069341435145mr15121152pfb.31.1698265460080;
        Wed, 25 Oct 2023 13:24:20 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:19 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/21] RISC-V: ACPI: Implement PCI related functionality
Date:   Thu, 26 Oct 2023 01:53:25 +0530
Message-Id: <20231025202344.581132-3-sunilvl@ventanamicro.com>
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

Replace the dummy implementation for PCI related functions with actual
implementation. This needs ECAM and MCFG CONFIG options to be enabled
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig       |  2 ++
 arch/riscv/kernel/acpi.c | 31 ++++++++++++++-----------------
 drivers/pci/pci-acpi.c   |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c3c3f3562082..8c105a151e12 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
@@ -152,6 +153,7 @@ config RISCV
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index e619edc8b0cc..41aa77c8484b 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -306,29 +306,26 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 #ifdef CONFIG_PCI
 
 /*
- * These interfaces are defined just to enable building ACPI core.
- * TODO: Update it with actual implementation when external interrupt
- * controller support is added in RISC-V ACPI.
+ * raw_pci_read/write - Platform-specific PCI config space access.
  */
-int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
-		 int reg, int len, u32 *val)
+int raw_pci_read(unsigned int domain, unsigned int bus,
+		 unsigned int devfn, int reg, int len, u32 *val)
 {
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
+	struct pci_bus *b = pci_find_bus(domain, bus);
 
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
 {
-	return -1;
-}
+	struct pci_bus *b = pci_find_bus(domain, bus);
 
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	return NULL;
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->write(b, devfn, reg, len, val);
 }
+
 #endif	/* CONFIG_PCI */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 58497b25d2ab..c8c3369fd69f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1520,7 +1520,7 @@ static int __init acpi_pci_init(void)
 }
 arch_initcall(acpi_pci_init);
 
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 
 /*
  * Try to assign the IRQ number when probing a new device
-- 
2.39.2

