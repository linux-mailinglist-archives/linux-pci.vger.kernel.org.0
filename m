Return-Path: <linux-pci+bounces-6939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170388B89AC
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A671C21420
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE08592B;
	Wed,  1 May 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UMnHiSPd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC185927
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565910; cv=none; b=L0XeKn9kU2XmAw3asUs3oy+NqWOygroiA18uiEXp+VE56ZfsxDN+BcgOwGg6cVlfr8Z8+Y1uIIKn+AA5rce/XuEeDpS7PxN9gza5mxLe66IdPaD7ATyJDK1u+zHFPG+Uhy/svBxwV6MnxaSn3u+z+3B8huzxL0jiv8G0ouCKNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565910; c=relaxed/simple;
	bh=I/lQ3VyE5XbmB+cjOeRhBGW304XFfO2eyWXw80G6ZKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7sYHU+uRTmZJ4xkOKoeobVsZ4V9lvk7PabhglXuJfkPmXHZUi41sWIQ2hAhl5aS1ftSEkvbqN02zn8C3Uyau9vsN4vT/5VaAJGV/zAOX1MUQ6TchgMpfDwCyCT6mrJ7JmnWXGsaVh0W8jLB5SOHe4h3Ir8q+YC7g26B8EYjtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UMnHiSPd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4f341330fso61916475ad.0
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2024 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565907; x=1715170707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcwxR1GQk9U2hRbWPBz3q9MYCED3shcxZKp1VHv0hAo=;
        b=UMnHiSPddU2owumg6IwimKUfOMydVMc7sAL++gsGJXTjBb2/jWMAjnltM/BYYb4ZQJ
         tj0Xi41zKgMhQCxaHB/duAWyy81R1VziCquT9uf6U1c6kLTPbajx1sgt76pfrvA47+IC
         RK6/90N3aO1grpeZPyo8fezv84nq42rp1OshI4aMy2MS1a2ofQBJbwqcm7TxLJJbXTIQ
         Fj4+ImBMtjsh8ZJ6Um3o8h03HmpW3yGCIGnpEEYUVcfxq5zDJOv5fa0lzYh2u+tQmEMF
         aa6rANC5VPd8wUw3vqzAqn2nYQpfK90Y8WKUSri5HJQTU2m9Z8VS1nBQcW6gmyzmCAks
         kaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565907; x=1715170707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcwxR1GQk9U2hRbWPBz3q9MYCED3shcxZKp1VHv0hAo=;
        b=sxY/wRFBVWVdOY5NQLVgDMGEsGxb6I5YwiSnbJdc0tqFEBLSyG1qVG8ajoYjARJ94/
         UUqUGP3rWJysI/l8JJxxCLgfxwluVvNzG44idTcM+tv/s0MRe8LxC3OCa0LOq5gjfC+3
         p7W5Jq6zKrcz01Wo4PX78w7rhyRybE6SdN82ZwIrXCODzFSGJy/qpBLjRB23lbjguf8S
         cHdbuHU+5Rg3VgH0KrxNs/o2tZFYHhK7AEKvwVljMyXgMRHQqT33Rk6KFhM8SvSNEVaK
         OawpmJWVLkUrNfcCNW43ljLBWHZ6yGpQ8QCezZiNhPubtQbo66Fg/2qQoqmYnb7JpzIR
         IHvg==
X-Forwarded-Encrypted: i=1; AJvYcCXObDZ4JoWKQBLYatt2F5yJyy05a+w6aRYzPxt1bV/avCIDwavylqdORYmv/5RIkOQ0D9wDQ0rm2W5qePeBY/7ebY4OZu+iugQJ
X-Gm-Message-State: AOJu0YzurmBMNC+QcXllbyTWUtvRmd2xRVtudqTPxJ36pgiBt3ml5lJh
	bkd4xAmIMb6l55yrEp/TV3CMQ8NenAHS0Qq7FAixepnoZRdRZfGmH6OEjItXZvw=
X-Google-Smtp-Source: AGHT+IEeK1bdY+NiF6yJem6nH8XOZPBP0PcZb/eHB80G50De8R+NdOj9l68iFqCiSXYmU0FqhQ9LGA==
X-Received: by 2002:a17:903:188:b0:1e5:5bd7:87a4 with SMTP id z8-20020a170903018800b001e55bd787a4mr2316455plg.16.1714565907491;
        Wed, 01 May 2024 05:18:27 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:26 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 03/17] ACPI: bus: Add acpi_riscv_init function
Date: Wed,  1 May 2024 17:47:28 +0530
Message-Id: <20240501121742.1215792-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new function for RISC-V to do any architecture specific
initialization. This function will be used to create platform devices
like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 12 ++++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 844c46447914..17ee483c3bf4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1446,6 +1446,7 @@ static int __init acpi_init(void)
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_arm_init();
+	acpi_riscv_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 86b0925f612d..877de00d1b50 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o
+obj-y					+= rhct.o init.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
new file mode 100644
index 000000000000..5f7571143245
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+
+void __init acpi_riscv_init(void)
+{
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1afa289f1f4e..846a4001b5e0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1527,6 +1527,12 @@ void acpi_arm_init(void);
 static inline void acpi_arm_init(void) { }
 #endif
 
+#ifdef CONFIG_RISCV
+void acpi_riscv_init(void);
+#else
+static inline void acpi_riscv_init(void) { }
+#endif
+
 #ifdef CONFIG_ACPI_PCC
 void acpi_init_pcc(void);
 #else
-- 
2.40.1


