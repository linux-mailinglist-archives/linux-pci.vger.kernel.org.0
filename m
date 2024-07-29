Return-Path: <linux-pci+bounces-10961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570CE93F810
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D621F1F22A61
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1815F40D;
	Mon, 29 Jul 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kQvFhvyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B115F3E2
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263028; cv=none; b=lPQ0qE9zkevxdg8/y3G1i8JCNDa38HeVa4rlVdZEadRf3gwKy9vaugFHVhS1IcwlC+FbwIREaiuRdUMdNpkwlI0IHkd13yWI68PHsv3FaihxwazZhmP0L1k/6krLmVCmxJuf8T8ZJUF4/fqQWJ7gQvzB48mOpe+ClIFYZz7I7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263028; c=relaxed/simple;
	bh=HxrXD0laEpvyBk3qLakEkJuteuJ7RxqyIWOvrRu2DTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8N2YKsAWjU0AXt9rD72FfWDYSvoFEFw9QIfL4b8fYjagMdYX6ibLpaYJdGsU1KbFUv3Iv2Frj8IDJBDHNMF3wEfmTdDREeO7oMHatcYGDMgUEPX03sSp/MOeSW7S8rZcLoNgn3Fz+uncvXGRvDrmKvy4IGEF/eoZIK/c79rSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kQvFhvyO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc65329979so25472395ad.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263026; x=1722867826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wik61eI9STwwE7HFXon2+/PZ3nVDVD4F5v9olaEmjiw=;
        b=kQvFhvyOE1SDoF3M6W0iYrXmyaZDaghljbJIKNn7FFKLR565bFdq5V4yVsR4mIvYU2
         ioPsZc+ziLy0OMmYSEVucyhNhNuskbtFgyBA1XkO0I0tfVGdiVLiqzlRfRf9sx2nVnmM
         U2SatZ31b1OlbTuVtA+MrCCSfk+wbu+zvlyHG6JryL/FSEfckLkTpMO24hupcOPGV4fo
         8lEYjUocUCqSViFKcG8nKpTA7FXHwCNU+zbj9rSTA9zxHTOSJ2cmHt62T0Hq/QVi0UQ7
         ztUX2TD9SvP4tlTk+lrKXQ3aBE5lmL0UvuhmS66U3jjuOTRwsp8zasHZjDWJnuZcVsqy
         3wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263026; x=1722867826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wik61eI9STwwE7HFXon2+/PZ3nVDVD4F5v9olaEmjiw=;
        b=g5x13HUQPmhQElUbHeQTROW+tUu4/KHWnLOjkM8IAGqAyP8fFNJHzzhkxTvFu7AKRh
         pwmrjgs/R2WU/S08LIJgmlYFbdiL7qc79WJXR3iAiy1CHWG+rWg6NbN6H9g6ihxBGxsj
         9sw4uzrQvKo+4dyE9fAc6FnF6f/kI6yRQECiZ+Cb+ixugnX7lUurCVVBG4GX8R4T53c9
         gr+4cR16Lu7OZKK95f5VKVvSqs3hy096yoqY+mJUYYSbgw3OH89D7lkg1KYUutXwksDq
         znjOXHZlNCV1R5vwS3sRhXi2OT+Cvj16VMXUExjvTY0FvJSO0aMIcYIMW4D45ZUG/ywT
         507Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY2A74tidb+dFeUzAL2Lx9vIpDevjCIAAYWghHI4npsNb++qWCf6bh86zXRFragN7Q0vM4FRpP/fmdq8eHfxkT5TC6KgGi6UPN
X-Gm-Message-State: AOJu0YwtMQT3sdYGtAdr3VLGuJfKCVZVj/iOkdxuQ+xIERwT6gBlCNpP
	Ilhs6wnrL8eZDGMEJfdRnH9K+e2y0lStd9zr0fFvLLQd86swsg5rnlZgi8xfb8E=
X-Google-Smtp-Source: AGHT+IE3ECdlWv0nwo/WvLQaYyG8zcevZP66vRc2T+ol778my9cQeDUxkiVxja9PHSoePX+A01NXaQ==
X-Received: by 2002:a17:902:dace:b0:1fa:b7ea:9f0f with SMTP id d9443c01a7336-1ff047fed8fmr110813265ad.7.1722263026091;
        Mon, 29 Jul 2024 07:23:46 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:45 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v7 09/17] ACPI: RISC-V: Implement PCI related functionality
Date: Mon, 29 Jul 2024 19:52:31 +0530
Message-ID: <20240729142241.733357-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729142241.733357-1-sunilvl@ventanamicro.com>
References: <20240729142241.733357-1-sunilvl@ventanamicro.com>
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
index 0f3cd7c3a436..a269e577284e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_PPTT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_SPCR_TABLE if ACPI
@@ -188,6 +189,7 @@ config RISCV
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index ba957aaca5cb..6e0d333f57e5 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -311,29 +311,26 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
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
index 8ed81a373bd7..af370628e583 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1543,7 +1543,7 @@ static int __init acpi_pci_init(void)
 }
 arch_initcall(acpi_pci_init);
 
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 
 /*
  * Try to assign the IRQ number when probing a new device
-- 
2.43.0


