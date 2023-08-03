Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5511076F143
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHCSDQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjHCSCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:02:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D200E4686
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:01:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68783b2e40bso873689b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085679; x=1691690479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SWdbLlCMTnsfDgjj0hJXL2JTXfe1aLJEQPkrac/1+s=;
        b=D2G3HiLpmiaQgiit5Uw5A+KyEHMgDrbX4OUobJfTY5xZLp+QrgoNkT2MrhFFEyepif
         NGS8bIEgxHx46b2qZaLXX0Y0SmZd7FsXd1pRwMLzsoEhtQ8pcPTRJawrVIj/nWamed2p
         c8Ow5XHa5oDci6OFZ2uyC29mSIkYFExo2ugvnfWshx5bUl5bbLWflApdPwz7r/8MPdiM
         lWTXRBs2gyD03CeRJIWHuRF1YcIOZcbbXk5w4VPmjVHxhOze/aVypsDeH0+qQb104tHd
         EPWaTU8ZA96yj8ruCaOH+vJ45kbEIP06MY4/8eq+kYWiPKbchSKHc0XwVBcVevJ8/Xa6
         Exvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085679; x=1691690479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SWdbLlCMTnsfDgjj0hJXL2JTXfe1aLJEQPkrac/1+s=;
        b=WkCBC7kO3RyOvqoB1IsI8PdsNNibcfoDaPrq69O15FEJSdt5pZC/o0bIIPCLF8YkDA
         mGNqlAjcvuh/5xDTy/1R3xlTzzF3KXXAFnSkMImNjhY+AE9YjSVioJ5yUygKv5Rc8tiL
         UvtcIsjRVeWCDgzlV1a6lCDu9xtwuTqyzZB9mL5KeeydyeBZ99hPU2ySzmish3W5BLx3
         5qlVIkF4THsDG/EeKrq215OMgQMHgLg42+mUhlKAgLQDqVoBVTwK8zWLk9Vu7FakJ8Z2
         KBdDdAppc2Y+VHlh7sZFfSbnMf6VLe7UK/pjQ2/FOd9FW36SboeKikrcI0038x+qF5Vk
         piZw==
X-Gm-Message-State: AOJu0YyodXSQ5iyfZ0P72jHFRa9xZ1a3F7/l6Gdyl+gJ0APZzypFLJiW
        UESddugGMwyuzzq8LgLK8NcxfQ==
X-Google-Smtp-Source: AGHT+IFGyUpuHPIut+tVQuZEcz6NanuBhvrn3iSa68PTIe5J1FDlay1VOOe28UUCGaj1xOLlQOJYFA==
X-Received: by 2002:a05:6a20:72a0:b0:13f:8a5f:ad8e with SMTP id o32-20020a056a2072a000b0013f8a5fad8emr1930770pzk.58.1691085678868;
        Thu, 03 Aug 2023 11:01:18 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:01:18 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 14/21] ACPI: bus: Add acpi_riscv_init function
Date:   Thu,  3 Aug 2023 23:29:09 +0530
Message-Id: <20230803175916.3174453-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new function for RISC-V to do any architecture
specific initialization. This function will be used
to create platform devices like APLIC, IMSIC MSI controller,
RISC-V IOMMU etc.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 12 ++++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2fc2b43a4ed3..9a8c16170a4b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1388,6 +1388,7 @@ static int __init acpi_init(void)
 
 	pci_mmcfg_late_init();
 	acpi_arm_init();
+	acpi_riscv_init();
 	acpi_viot_early_init();
 	acpi_hest_init();
 	acpi_ghes_init();
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 8b664190d172..3433a19c421d 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y 	+= rhct.o irqchip.o
+obj-y 	+= rhct.o irqchip.o init.o
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
index 641dc4843987..d16739928888 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1511,6 +1511,12 @@ void acpi_arm_init(void);
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
2.39.2

