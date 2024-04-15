Return-Path: <linux-pci+bounces-6259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299A58A585E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D35B1C20B7B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 17:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A2282C6C;
	Mon, 15 Apr 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ibq4yvZ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37E83CB9
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200499; cv=none; b=jf51o/yFY5+2uADxeLxElIHpEbgKN+sqeFMHsoP/7reJoJfMc3u9LWngtFHlh8tVTmai+eDHTJ3mI03lJbxsFbzv4NwTRfW1szeEsijGJpHsrSktZVhFMhAzA6XkXtVivfJkTL3rT4r8DkhWdm4qdiL85GlAeDv4A1p0/AOY/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200499; c=relaxed/simple;
	bh=d//fcv46H4LzOYIR8kFfFqlYP6RASRxKKzQCgxhHvNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/G+0/gDj7KUZ3rWJ7fu4s6nt2uU4ryzYBiTUCMXJwBwxj/C8BKOUuz97ZANzn1V1BRtYwB8Jr1wdSTvakvKh1AFUMWtuRmNE3mVa9PncTXm+nAE9dRJ51SCNiXIisCxPr2avO5OVjdiOjHPz/Ou3UYKpMQ4q8kDAQ2d465uuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ibq4yvZ8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so1193498b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200497; x=1713805297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFAtcNyUPfmOo+WuzK4Rac+GFz0TbHOwinmWYmcFrxc=;
        b=Ibq4yvZ87GnCiGAJGBbAJR9dv9TRo9Rs12iETGjNcPzQimPMrc5TlCaQ7lB+7BSAT2
         59mR0vmElr3Ia3cVyJmE5qExu3hurKvsCfUpWNitAQzsJw++lmOsDWE9pVriuN94FXv7
         fqfGS74DHSI/7izzpM3KGQ1/gtQBqnErbC2OiIM0kymWAaspNrIUHxTDYOxzbpf5Y54H
         w6tp7f5DW0/UOSNWL8/vz/dhjCsMgwIcD7OpTvdfghNzTash//dXxcocXthNDyTMzvzy
         sLCjsxufKwSp/m25mRYjEI4/pUUSWZX5rXvJM/Kc8ljjWNt6yaevgG8QWabAZl5gx1zi
         Vy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200497; x=1713805297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFAtcNyUPfmOo+WuzK4Rac+GFz0TbHOwinmWYmcFrxc=;
        b=ui9hJ50NmrXO2c6oSx95lxgyk1niWMXuovqRY7/fyIs86jBf7GandA0Gfpcuc4ycdm
         FyGw12b9TzVnc913EMFIHjPpXp6HOHOzT7isQQDPcXyHLudvQH6cb+MtoX+3qFVY+A1u
         b5gWhS/X15QnJtpzGRb8950mwpFHQdqiIgrGJudKaBxQI+20ZCOMCF9MPBJ4JHrM94ME
         dsYe0ts7Eet9mjqPZCpwEGbhzH+Hh4YNJ6vVhU7z4VO/UNCWXGB1n6cvpA9pOiT9bNr4
         HfviXKFchi7R4SA1Ggdt2ugVfIJrb7ycrR7NpbFykgOQz+JWFQOqOSia9DpqHd2BeSW7
         ha8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEWgOStC5NsohvuLrK7AGpDrnu0HBeFtkiNe3HSl6qEonVG5JlhpTphVT+8vmWz71EFpW1xlkq2C3zsVzm4W6NtAdHfuFU+Mmi
X-Gm-Message-State: AOJu0YwexzHC2rFFfAKabX+kaajwOG0Sg52ixyuUU7lvc2AEAX/hMnWb
	DwoORVhwPPjZhaY8f8MRxOyrgUqNcO4P4sNAGpE9KWCdyCReV0mAsziUr8XU5cA=
X-Google-Smtp-Source: AGHT+IGqYjIa76YfWohzDrF4RGeNhNZq2I7mTi99zpcmd5VEKjXE94y5JlYL9p7qJRGZUYYL3web8A==
X-Received: by 2002:a05:6a00:22cf:b0:6eb:2b:43b4 with SMTP id f15-20020a056a0022cf00b006eb002b43b4mr11021959pfj.27.1713200496609;
        Mon, 15 Apr 2024 10:01:36 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:36 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 02/20] RISC-V: ACPI: Implement PCI related functionality
Date: Mon, 15 Apr 2024 22:30:55 +0530
Message-Id: <20240415170113.662318-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
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
index 6d64888134ba..69cc0509a19a 100644
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
@@ -173,6 +174,7 @@ config RISCV
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
index e8d84fa435da..b5892d0fa68c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1521,7 +1521,7 @@ static int __init acpi_pci_init(void)
 }
 arch_initcall(acpi_pci_init);
 
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 
 /*
  * Try to assign the IRQ number when probing a new device
-- 
2.40.1


