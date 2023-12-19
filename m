Return-Path: <linux-pci+bounces-1174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC5818E7B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA12287569
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A588E32C9B;
	Tue, 19 Dec 2023 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="guIa3of5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF337D2B
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso2931245ad.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007947; x=1703612747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2my/S8LtCsC0GLqIKOd4U0OgSfb/RvK23itt/cKu94=;
        b=guIa3of5y0E0QnLpFeQUUhNT7PQOs7KpjPkOkJFZKw32+thRMo7Jmd20mYjxsBf1L1
         9goc1/0whT/LW2unmi7St2c5fk1+/oTjR1dY17fWmxeKMCXK9wG6brulOJWIZbRPCZ1s
         BdnDRLdchL3eXHpKm30BM8HX1C2BaxXj+5abyJiptidu9zSSSXdOm1XOg2FDm6e3pkJ3
         uQehfcw5GqtpgKMMOkGdgAuISuj54sGCJnCz1Bt68sdYS3Xe/jZ07FRgX1gh5UrO0nDl
         QQL/luI+bcXQC5f5g0OAEWhUD7nKRBWQQRt/y0ki+za7obgb4+DBU2u8Pi1oaH6tUKyK
         jvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007947; x=1703612747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2my/S8LtCsC0GLqIKOd4U0OgSfb/RvK23itt/cKu94=;
        b=WSP9Ft+yiwPPBfBk+nTQ/KcuZVBaLv/bqxOTjhIr+KZrbQ2s+EBJ35WCFJf731IdM8
         PBSoBTw1K2n0ai4dkMtYSOAh58lCf1spxeukAv2xAsGgnHKCY6HoxuES4lnwGhKb26ZO
         NYmLp9anbPUduoXW89JiGSVDiI5Ohic9u7qcYfm+xopmGQEA13IEC/GCB1NSZn0PlDpE
         ZhK3cBlVDy/bVWqMwZVeHRTP4RKyB0ccnQII5xOy/PDFMPr4NmBaV15RVob84qRyeBpc
         9VP4o6Dyh2sNWGaTEsJBA9chp07DV09b9czzby1AEsHiEh8VcfhL/un+EJH5Um9RCpKR
         Q3ig==
X-Gm-Message-State: AOJu0Yxnlv3Nor3T3PKWa04sDS6Cd5Ds2iKtDjNQ7WnieqxkggFFSHb4
	jXE2m3tW4RK1doRRbpKH/0wPQA==
X-Google-Smtp-Source: AGHT+IFDCMqXKe3sr6t+NRPle0lI18fn2yS4WEUvyrpP85oA70voh4ftGShJGXf8FNnSuam1RUEIzw==
X-Received: by 2002:a17:902:6bc4:b0:1d0:6ffd:9e2c with SMTP id m4-20020a1709026bc400b001d06ffd9e2cmr17679545plt.126.1703007946725;
        Tue, 19 Dec 2023 09:45:46 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:45:46 -0800 (PST)
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
Subject: [RFC PATCH v3 02/17] RISC-V: ACPI: Implement PCI related functionality
Date: Tue, 19 Dec 2023 23:15:11 +0530
Message-Id: <20231219174526.2235150-3-sunilvl@ventanamicro.com>
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
index 45c660f1219d..d939fff5b5b1 100644
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
@@ -151,6 +152,7 @@ config RISCV
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 56cb2c986c48..b7bf1678241a 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -223,29 +223,26 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
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


