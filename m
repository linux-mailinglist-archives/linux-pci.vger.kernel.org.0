Return-Path: <linux-pci+bounces-6262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66698A586D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AEF1F21F70
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4B83A18;
	Mon, 15 Apr 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L5iRR3Qi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABED839FD
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200518; cv=none; b=B54booBwJ4EDQsmWVM1tyc7uM3iMnu79cwATC7YcMQ4bwGh2imE44GwugSE4ay2qMw8liMjFmmCsy8psRMb1ceTwWMBWlhFb6AKahfYJ8Kdooy07MpOAPwQXN2EbO3rlPEUaGxo1KmNTx1BSw6yxmNN8DX54qBJql7960n24UI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200518; c=relaxed/simple;
	bh=nvDPc3L6oEQANMqW6TwMQT+97dhGLiqDQqjjsq7m6Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TEAdhy6T/lt8wWhmwwcXB2GFyYM2gzWheT9Ih2i6tBLyQ117lttozW24kFblCc7mAt9aSLLtRAh4H9Szah7v3TskpKQHLFOLtL91Wkc+7erTqYx2P5ELJFys7iggyEHx21jinX0epzTQYRewZpy1KPPTkDc52aIpLdswEkRhRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L5iRR3Qi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f00f24f761so659118b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200517; x=1713805317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z52/1ZZYR1CvGL0V5chwJsk+UfCztWDiXCAoT+2GZNk=;
        b=L5iRR3QiiU+6sb+LRsiGnwZl3gaT4EJfpuTqOak2N+oz304KL8S796qofU/wokpmAY
         20+aZkZMzgnLnDns3R4xxR43dIc8sxadQCUUkwDEcJiy/YfMwYpwpSjy473phrvL+pAC
         Keq59DdmdBeCl2kQijYNUDWrf7zQeBxtBpj914Ct0B1A6j9zjZi0owd3pzKT+XrF6Jcq
         tcqlzKqaY35Fxn7vfWhqW/QjsbCkTt4prWfJaqng0N6Jrzg6qEy+dZlJ0EhYeneCNm1D
         0b6LU9ctLvjplDsu2Xk9bk/R0EOHUSE2q1u4LPyTR9YMfN3PHo6Z/cLeY9qK84k/hG2u
         Rj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200517; x=1713805317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z52/1ZZYR1CvGL0V5chwJsk+UfCztWDiXCAoT+2GZNk=;
        b=aSGgqFJ1ggtKel/SNgngGduoL3S+k0xANkeh+9QAxwzrIQ403mRrAGcjL1l73H6G29
         hPTg2TEYFwYG67kCyC/NxSJRL1dp83rCPHXCBJTM6tj3sLpn1X5F1txKfwL2n4OtrWhS
         bhVfwpuOQPZcQcLvl4TLYoFSxY5XiJMscykbE1+IP1TK/fpApOvXUSTH0wJ8Vl0k0CZA
         wZgk5VqUcB3jPVPXIfGX9BY0e93tuWILMAaIw9JDyeQ3cFrMiQCQiA9TLaY8vbgZpsYI
         2q5F3NFawkupWc3V69G05Y+rl6RYOn9+44QCtGj1iFhGer4aS0v7Kfc3K0IVOjqDG3LN
         9SmA==
X-Forwarded-Encrypted: i=1; AJvYcCW68sBA4J8vrIE5Qiaf/nL+wOiQfcGXrslFwgzwq09vTBwQ5g719uhzw8kphjjpezX5h5WWRoeS2ypSH+RPSHbQZLdcsUsnnP9k
X-Gm-Message-State: AOJu0YyJ0MuGSR/XblmgHpWKt3kYr0PlFvbBZJEFs7ssdU3nVuzCf9p9
	+rdqwN1nieEL2S3VixO5P1nIlfaLbREtHYfgsG8H8C/KgFDAOe5E79bAmaD9sFAltGpKomAMSoX
	5UOM=
X-Google-Smtp-Source: AGHT+IF3pZ5kgHd0L+s0ETBbrzTu2eQzZocJwTnnUWv3+XrCVjsqR27b/As/nt3u7TcsRgOfwdwSGQ==
X-Received: by 2002:a05:6a00:986:b0:6ed:1c7:8c6b with SMTP id u6-20020a056a00098600b006ed01c78c6bmr10123074pfg.1.1713200516899;
        Mon, 15 Apr 2024 10:01:56 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:56 -0700 (PDT)
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
Subject: [RFC PATCH v4 05/20] ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
Date: Mon, 15 Apr 2024 22:30:58 +0530
Message-Id: <20240415170113.662318-6-sunilvl@ventanamicro.com>
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

ACPI MADT entries for interrupt controllers don't have a way to describe
the hierarchy. However, the hierarchy is known to the architecture and
on RISC-V platforms, the MADT sub table types are ordered in the
incremental order from the root controller which is RINTC. So, add
architecture function for RISC-V to reorder the interrupt controller
probing as per the hierarchy as below.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/irq.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/irq.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 86b0925f612d..dceec808cfab 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o
+obj-y					+= rhct.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
new file mode 100644
index 000000000000..36e0525b3235
--- /dev/null
+++ b/drivers/acpi/riscv/irq.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/sort.h>
+
+static int irqchip_cmp_func(const void *in0, const void *in1)
+{
+	struct acpi_probe_entry *elem0 = (struct acpi_probe_entry *)in0;
+	struct acpi_probe_entry *elem1 = (struct acpi_probe_entry *)in1;
+
+	return (elem0->type > elem1->type) - (elem0->type < elem1->type);
+}
+
+/*
+ * RISC-V irqchips in MADT of ACPI spec are defined in the same order how
+ * they should be probed. Since IRQCHIP_ACPI_DECLARE doesn't define any
+ * order, this arch function will reorder the probe functions as per the
+ * required order for the architecture.
+ */
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
+{
+	struct acpi_probe_entry *ape = ap_head;
+
+	if (nr == 1 || !ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id))
+		return;
+	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
+}
-- 
2.40.1


