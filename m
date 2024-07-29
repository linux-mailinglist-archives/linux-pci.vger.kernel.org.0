Return-Path: <linux-pci+bounces-10958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDBE93F809
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D22282B4C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797615ECD0;
	Mon, 29 Jul 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nU7dBGKy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55E15ECC5
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263011; cv=none; b=ZpuMuhS3HHoj4bQzwKchTbtxU4NKRN2mTPCKxhIRqnDANcVv45Ye9vVAHdTGezMM9dI7Cc6igsRlzRUZ0vXcYg/NDyRUBQAuOAW6mqdfoSocz+GzfPXv6dUXsAlQ6+3703vA6IQFJgB7IybKKvCxD4VFe6EMC+DAmDmRrTG5szc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263011; c=relaxed/simple;
	bh=RhFi/JwaWzrMm0sTOK6QJBNwoySQ3CPNvlWykemrPCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8a533A1TcQBO3sXd31I/jtP7NtG9xu1IkhB05YyXIqafvXZzs+ElRSZ4I93aXm9wyhQv5PSs5UPL8TfC2A6CH25WnGyJYZSZDMus2xAch+VWjCgfxIDZ7Dz6vXDr4Bu6L13y/iA0fEj9cMba1lUZ+yEk6mHLshhbG2kdz9j5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nU7dBGKy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fee6435a34so18386395ad.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263009; x=1722867809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivFx7Eb2KNlJll+d2W+eJ7NSuljATLtswxxJxue4OO4=;
        b=nU7dBGKyqerN4l4YAtdJtppiWdsYee/nj2Cqxc3C+o33ZRPadxLThBbCblo0wBJF2s
         A7zhhpg795jjXZAHHmhVtSlO8Ev2BHV2EvoGDvPw6MxH0TtdcoWYQ/Mhq4VT0eR8fvfL
         1Dr8r/YRLJ+kXTX3jKKouSUt7b1agc12JnuNXOH1j1Hs6yKzCS9oqVth0ur2JXDqIkxT
         aPERfBdCy+HzSQGi0WQfpHivQHh8qDOQ8gXrEpBQiH+vijtwp0SJZNIU225ItdAvNlfh
         kMLXNc5rxAXd2Qhkaz/kQ6f9fmqTuRM16M+hZlphwVANjpsc+NKTtzCIzZJ8qXWkCA6i
         jM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263009; x=1722867809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivFx7Eb2KNlJll+d2W+eJ7NSuljATLtswxxJxue4OO4=;
        b=ondMmOwFWqLHnZh9lozciX/nd8wC6R0BekADPGZ8FgwihYNovT9uPlmnmgNPGxuzdf
         u14UYEWufuy/z26wZ521JVegO9vilj6cFQUM09CrNQZPkF2KYrMLjsZFtdwJUXVSPdAb
         DWOCByhgL3t9cjDxp0ypzlJPu33wfLKklBefmA6oQIeqPd1PL6Tgg9TGn51Fug+sjAvW
         t/6hyQsSggohP+oa7aidAqIcCfuVreLjErk7dh0TyPvgR35vmgA1gkM5Pj2zANLnFlgn
         1esbW6/ZJqO463D5n1BZtvQ2j7rZkSF8jxZPEjws5EIhnR41fIOeTvdTyOT0B6x/sknb
         hPSw==
X-Forwarded-Encrypted: i=1; AJvYcCWy06/5kIMoTjtMJEfaZP1wh6xIKIjb2bUqJbeMAOcz8zbHNJcNg21d6sSfm4nCTOlH4seA/WXr/xoHxisTrHvy6bceLDB6tyw2
X-Gm-Message-State: AOJu0Yyp0vkkRCITubjgwE9Uvp7rQxSzLqtT2mxDQJYqejecoKNp+go+
	gTPBLqPCctlGd1Nz6xHHJ33Q5JUEIwJn6O0MY8rmbTkqsUzFAUwsKewTFzBokis=
X-Google-Smtp-Source: AGHT+IE8RqsmNLGZwn4UKGI9HbMHE+3KC0OV1lt+Ckv1MptlwMQ/WvrHjQX+XujtO97bjUDIb+rzyA==
X-Received: by 2002:a17:903:234a:b0:1fc:369b:c1de with SMTP id d9443c01a7336-1ff04805ab4mr61618075ad.5.1722263009198;
        Mon, 29 Jul 2024 07:23:29 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:28 -0700 (PDT)
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
Subject: [PATCH v7 06/17] ACPI: scan: Define weak function to populate dependencies
Date: Mon, 29 Jul 2024 19:52:28 +0530
Message-ID: <20240729142241.733357-7-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V need to add dependencies without explicit
_DEP. Define a weak function which can be implemented by the architecture.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 39b3ccae9f79..28a221f956d7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2077,11 +2077,22 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 	}
 }
 
+u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
+
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	u32 count = 0;
 
+	/*
+	 * Some architectures like RISC-V need to add dependencies for
+	 * all devices which use GSI to the interrupt controller so that
+	 * interrupt controller is probed before any of those devices.
+	 * Instead of mandating _DEP on all the devices, detect the
+	 * dependency and add automatically.
+	 */
+	count += arch_acpi_add_auto_dep(handle);
+
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
 	 * 1. PCI devices.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d6a4dd58e36f..af72a5d9de99 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -994,6 +994,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 int acpi_wait_for_acpi_ipmi(void);
 
 int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
+u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.43.0


