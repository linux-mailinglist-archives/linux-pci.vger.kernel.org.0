Return-Path: <linux-pci+bounces-10955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F356893F801
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D8D1F228F7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5E15CD41;
	Mon, 29 Jul 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S96h38p5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624E18E77B
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262993; cv=none; b=YP+gzAB2hTOQuhYGWTANZ+jwt0d/wsBQ7cjOKEWR/Y0IznE3nu2Yvs8n3NyQumgFeUpbt78oRN8UReJsu08BCoNoEQVtPUKVuLPQB2oGI30MyOvEGDzdlc8BO8eJwfU2Pu3YZSl6dMAXqdAy/j9wrRhT9VoeRe53mr0jGPnJpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262993; c=relaxed/simple;
	bh=My3CH+lxqRC1ZfX93NQY26GkZQdIRwImIJElB/31blU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li0WeUXsulk9d9HwLBVI+HUAUweupH8juVL7Wpz2WeJkyoclCh+S3l/W/Z0fLGYUo4gUvJYenW9R9fWve/quseC49PY7Fw5D3e/qbnZiR8xRjR5vNffY42P/wctQcnMsDmukCv+uK42XvgblVu+db5HrTc/vGSrTVE0Sj6D2Tfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S96h38p5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fec34f94abso20410435ad.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722262992; x=1722867792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpUpzTn31uAv59eRsYCCTGHf2UwttQw3/INKSz7Rgp0=;
        b=S96h38p5rNgdz2Z5AxqkZ6Ai5K2pBUiRuuNHo0IejcAZCJbFDuYHUybLcuySTdCMyC
         LSvUny/wRnu2aImVGnDfDN6I0O7s6CfcOpEdTHbn1usfneS9mi5UxaOqpsOqV/dnfCy8
         HQllK+QMtxHbXytWCpKJY9cBJ5V+zUyVanGFXwyd/WoG1EF30q/x/Iv3mgk5dKf5rFcU
         VsN4/S9XLrxgn9I3u4IvPflMZpKhWQaaWpRiTQ9fYyFavFf/QRRS3Q6YmqcUIRUBJQA6
         pgsEScJA9DaSyF6fqWzcCvpZfwDHd96wLqlEADZC9MlCw8H3NHkS+pgVcRG3ZNp1bbZy
         Zolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262992; x=1722867792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpUpzTn31uAv59eRsYCCTGHf2UwttQw3/INKSz7Rgp0=;
        b=oPQx0BpWPd79YtTRut9ZjqLspDn3HSQvGe4mMiO5tvJ/IaIy4RwWKmBRuBNsVv8XQl
         ZuYcMSpv/GU5gyTPjhKfzkljSJQbMG6zKvH9/cVJOLaWkfJYULTwThN1iOTBMVfk9VTv
         gP04JaLJXzc/IrVKjL8vE1+cM01Q3bBeA0KGIB5Nk5pR5fYOPbGgU57mTE1F8fsHMmhI
         THtvkyNj16rrSVE02O7vjJdukdrcOGNMt6ocJIIgI05FFdHi2C9nKbTrguIhdpJGIdtP
         NLu9Fzvttxj3mF90aiAufUvG1YRXz2sJFleTMQihyWonLMp33IpOFAqZ2D7v3MmTxOJH
         fD3A==
X-Forwarded-Encrypted: i=1; AJvYcCU8OgenpQCxqUSEcCyI3Wlc/kkMoJ3dYt+W5X+VDhfsoqd5G6F4M32rJ9d5wbW0mzoyrLeAyByi/LDeCUvh54w3qFtWX+HrkLU8
X-Gm-Message-State: AOJu0Yx9Sn3ZiSx5JbfE/71aN7WarDxqKzUx7S+Dft1lWBm3TZMsWYEy
	eXCiMPoj42hJxEaqhVtByv50vlGAvAdu9TQXnlW4GBOeBq2l4F6Xi1StiNbjftI=
X-Google-Smtp-Source: AGHT+IH8iPMjHAqTJtzMrAyY/pfHaeY/boKXW8uZbGvPFkTDNr09tJ3EGqjomR/myMHI4FJBrBAsNQ==
X-Received: by 2002:a17:903:1c4:b0:1fd:668b:ac4b with SMTP id d9443c01a7336-1ff0481ada8mr54039975ad.15.1722262991841;
        Mon, 29 Jul 2024 07:23:11 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:11 -0700 (PDT)
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
Subject: [PATCH v7 03/17] ACPI: bus: Add acpi_riscv_init function
Date: Mon, 29 Jul 2024 19:52:25 +0530
Message-ID: <20240729142241.733357-4-sunilvl@ventanamicro.com>
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

Add a new function for RISC-V to do architecture specific initialization
similar to acpi_arm_init(). Some of the ACPI tables are architecture
specific and there is no reason trying to find them on other
architectures.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 12 ++++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 284bc2e03580..48d277657203 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1459,6 +1459,7 @@ static int __init acpi_init(void)
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
index 3fff86f95c2f..892025d873f0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1531,6 +1531,12 @@ void acpi_arm_init(void);
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
2.43.0


