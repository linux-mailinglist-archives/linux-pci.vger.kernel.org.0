Return-Path: <linux-pci+bounces-8166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF998D70AB
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 17:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32A61C21415
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045A153506;
	Sat,  1 Jun 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cLQiEm8O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229A154433
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254327; cv=none; b=YbFp8rxJKA4jllKcOSfds8yIsqE5lXIbBn7OQcu7oJ2q/PJ7VAlqARSI65phkWPVJUBTmWhvgaMju2C4rcCL4sRGGnQLFrS/kuQBuOKP9OwEOnSz/OFQDSqyQVTf77BihaGyCYAsSef0FQbEToUPXt6RuZyCAix7imFBJ+UMkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254327; c=relaxed/simple;
	bh=+0+8uWNJ2E+sjIHYLQXKU2enWqx4IjoPosf2UhC3Spk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hITzwUSiNRvDh8Hohsrpf/9pbbhWx0wZxjfQqJy5xgPhgZ9HBH81W6TSU2QqDs4JvBjac8hd/A0dDNZAh4uGhp6ZE3TnF/NMERBpONhxS8oK2vf3Ggot2RDj9/jr4KdiwWITlS0PgdcfgsB1NEElXtLQsOj1zyJWiv5RZ7294DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cLQiEm8O; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3748d68b7b8so6700095ab.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2024 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254325; x=1717859125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFsOtJr39QOitF1KwZRd+YQFJB+PCc/GRrrdZlZj/hE=;
        b=cLQiEm8OEAHxfVTilg5ESUxqmJF7bYDnUuYX8ogTc75pi+gEemHahyNcV7YJVoJ/+d
         TtnHft/IfOl8GvBDJwV4trEAcGfl1oW85isIdjcO21ZeBGn9UsOvtEHTRxLp9I4fhpDi
         /aenex4FaNFTp4YPNTPHhGahFUx2HGgAqBVRsRs7xwPnKlHe5Thekz8npHuHZYSZfXuz
         oPGyWBCpJEusuA4FgDgMoNI7V3i7hWfMgea3QhZZ5XY19NkwxZzqUf5amVjmq0K/mrTT
         fD1kImnb23MTRluax5DkdzSwuhufAmocO362AymHAFyhRqFHk8oESPzfnQvLK0Y/WMJI
         t4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254325; x=1717859125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFsOtJr39QOitF1KwZRd+YQFJB+PCc/GRrrdZlZj/hE=;
        b=VHoaX4S5FfwVqWOthy4LjtvWyyYc+ar8zapz6ojtIu2/PWRuLp1Ho6/qcnnnxKKPPK
         Yoxk4/W7dLKltZUp8gpSwvfVOT+Arro2dpZLluase7kVxWVAxPTdve185GhZXpYMUqhr
         O4FB43d/fPrmTrtimv0dubwhR0b0IwUUx7cJHzNJ2jhyGgS0tMThZFODEYnrJiTM1XXo
         eLkx5300tgO9bLVoSTcLrUIs9YhyyEMvnDo8BIo+Wthhli4+FVj8UMb7C9Sx1GuPJbCB
         WDAD+mHuIFb5J53057s0Rtz1P/zYYDVxPimkbg8XXJRIblx3Lee9X+chpoq+RDhs60rH
         QmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYSr61qNLa66/Ul2ZLsm9Pg/q10g5r/Ak/OKmavF6zA40yVl6IM3jLrhleBtLDIQwBsPLnu3skPhlwAIHNBAbLAx0+7Y9oeg9Z
X-Gm-Message-State: AOJu0Yw+hZivqNXpGZYuELezpWojDQQa1T+p+ItBmvrfuVqtCxTYBuU+
	bfLmPG3G0Y1p4qAVcwbzufgAXM53BD5dyXPn0l51qUpH3JOCwj5YHnl5rg/4tTg=
X-Google-Smtp-Source: AGHT+IEJRIuFWfACl4C/2OdIIJGx8aK6TxTUuoEk2JLfaDxuwQLQymMr8D5iU52VLgMZ5cmUpvU7ag==
X-Received: by 2002:a05:6e02:1d0b:b0:374:593f:913e with SMTP id e9e14a558f8ab-3748b98e53dmr55865925ab.14.1717254325230;
        Sat, 01 Jun 2024 08:05:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:24 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 09/17] ACPI: RISC-V: Implement PCI related functionality
Date: Sat,  1 Jun 2024 20:34:03 +0530
Message-Id: <20240601150411.1929783-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
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
 arch/riscv/kernel/acpi.c | 33 +++++++++++++++------------------
 drivers/pci/pci-acpi.c   |  2 +-
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b94176e25be1..f143fbeea572 100644
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
@@ -181,6 +182,7 @@ config RISCV
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
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val)
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
 {
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->write(b, devfn, reg, len, val);
 }
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
-{
-	return -1;
-}
-
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	return NULL;
-}
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


