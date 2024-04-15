Return-Path: <linux-pci+bounces-6263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63058A5871
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7FF282508
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B672985646;
	Mon, 15 Apr 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ER/WmwXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442CC83CA4
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200526; cv=none; b=egpEtLeXRhXJhkjX2+XG1i5A5dICzp+eh3T7dYl36Wn14T9oxeQEZB87f9/WvcScoEEkoL7MmkYc/vDKAUVkUEqHcAEgh46/viCNrrf5jZlKo2opwANGCXCpkPab9gVk+JhLhI25ipOQC4wjBpZ9rGNzP902+xzdDdEx7vV/nco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200526; c=relaxed/simple;
	bh=6c1KPNfbsnJq9DUvTTQzdZQPzyBy24eoF7S1WvCF6y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7R0GRZE9QX8jHk1Ifyg1r2bnew7Y77oBXG5cScck5jcRqDjoEPBSGN1A1ClUVnTcuWUoQ/QkSLAXWiIgqmkE0BIwOKeEYUhaByat+F2shOjZAwqjCb1NdHR1VC8z0qKmH8N4KqiTN1GRqzbijuGsJ+fJF4sl+zYZssbb49O9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ER/WmwXm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so1194280b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200523; x=1713805323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teU93TtwDbXbcibIb7AXZv+o/BW+BbmtaOdYSVoKyTI=;
        b=ER/WmwXmBdMEr36nrxErZvolaNMxrOahPL/iWV15IB0Mvo6yOhqVFB53zyUyTysuUT
         vcfwQjfAiE2sNMJmRiaZjt4SDPos4+Q3Jvy1/55xTJa4DgpkHQUm455gWew7WB9EJ1sW
         PnVvJ0sw5chzxr1jBbOizKzvm0ky9eHloxT0NiEPK6kSHBJfopGtPjNRUbb1XOR04dK5
         9+bWNgmgDpzwoTVmAf/AzBKSju777e4d6dRtjxEik1P48d4HPyzPgQT+LELrxKI9sTE1
         SDiviKEjnRntF7q8CwUVAuWS9IZCDvSDTnvb1H8TTl6vu8uJo/lRVqvPNPLggJQDjJE/
         dsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200523; x=1713805323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teU93TtwDbXbcibIb7AXZv+o/BW+BbmtaOdYSVoKyTI=;
        b=dBqjNtp062ulsi9czWhKLv9V1CRT4vkij4BuUTMpCvC6sZAgNzTeju7PVob7aLK7zv
         LmN3gCqqDbzbEDdEfHeTWNPXdgfr+gqaindxew6vUaFg0dqVPPR6GXKUTBypCFLLwBPL
         WkzM07q5W3bIqQmxXj/opEGEUs3DXSqqTHr6B2G8Bz0UV0dSb/8UvkRSQE4nxyIlcYEi
         iVijHgs9wAbQ4zaPH7OwDhOOIKcAhqC4qd/dslpJISsDosKjsj/WBkVrFcYFepCFUMzp
         +xKD/54FZHJYZeT654OAmv0recuTB/XKpEts4YnoqbYxvswMeILogmJr1DKGp+pyDb6r
         f9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwdV1w34Io+WmlNtdAVu5qXeI9mndtaA283OPMfO6rIAeuBDEUMNteGj6ydfymdRPUg+T2jn4Ou3+xKeeMolG5Cb1ILKYQjSCl
X-Gm-Message-State: AOJu0Yzdrh5idAUrVUjyPOvIbZL6zcbDNDO0a2kqReEScYr/xnIHT1f/
	lMzAQDOFeqdVVq+A/R0UopHp7dT0pqZDpg+acq7pfi2YIQhKmPwHMubjF5qLXQk=
X-Google-Smtp-Source: AGHT+IHIdjpEtA26gjeeDnuLKQpBt+rlByzg0zdHDQS2GYQedk9D3DuzAQNVqthcjh2+Xm9tW86rPQ==
X-Received: by 2002:a05:6a00:3985:b0:6ea:e31e:dc75 with SMTP id fi5-20020a056a00398500b006eae31edc75mr12713019pfb.5.1713200523442;
        Mon, 15 Apr 2024 10:02:03 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:03 -0700 (PDT)
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
Subject: [RFC PATCH v4 06/20] ACPI: bus: Add acpi_riscv_init function
Date: Mon, 15 Apr 2024 22:30:59 +0530
Message-Id: <20240415170113.662318-7-sunilvl@ventanamicro.com>
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
index dceec808cfab..42d351859aeb 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o irq.o
+obj-y					+= rhct.o irq.o init.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
new file mode 100644
index 000000000000..b5807bbdb171
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Ventana Micro Systems Inc
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
index 914ecd22ba64..f8f92aaf97ad 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1525,6 +1525,12 @@ void acpi_arm_init(void);
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


