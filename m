Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7961476F11F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjHCSA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjHCSAg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:00:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264AC4482
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:00:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686f0d66652so1090418b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085619; x=1691690419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mbYpJBEy7QtZn0rLm+Z46rszMOgig5KvbO250k7OII=;
        b=YfGQrWrqKxoHHrzv18a348oKjGYv1gGQ4cGmgyQBPY/sWq0LFcGm3LxWdqhhJX9N9s
         kBW3WG3VU+N9md0iX82nHkzuBp2q4t7soDxrCACNYYUFhcdhqpGhV2tZlHEQyVp7yC3I
         x3MZPiXRWfo/DCgcuqSvtbtyM5q1vXWl9zSat0C7GiPgfaHAdZmmf9DiiUkALXzC3yVv
         lSUTih5Yk/drJWTl6Lrv8KwxCFUZRYPN1Z/RXZ1bregl5jLq9/rXwM4R/ZO28pBL35/9
         Tkint7JkljbwD6bJlr3TRUg/dGfiJuJLTrbOaZxni/zO2Vd+5zxHdGnGLPVhestQq1s9
         FtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085619; x=1691690419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mbYpJBEy7QtZn0rLm+Z46rszMOgig5KvbO250k7OII=;
        b=Fv4d0d8YPozkRW72rG6EjIav8f7jsA4CelcgfZ0G/zBomDC9qvfVerOPRdMaNUdgll
         FobPxT55GupDABsW1Yye3j0R1azlNleSC05T9r+gZ2BwULSkqwmWc5yyhK6qKQRE6FPY
         jWWGDkBKZSnJHzbpNLw/+J6NsEewykxHyOW5vfMrS8oaoqvlUwB/f7r3Jg50RRVJS9nZ
         2Cf2ocjUcJc6KMn86hjSrs9qjDiCovqa+4+GYn3Zz97mE6Moy1kYBSoaoKF63cPT6uQD
         cC9+JMxK3ghyyUoi1nmby2Uh3oReKB+1xLcZTZb2jWaQQOotn6ueyVfC0fKt/qw0gs/v
         ANdQ==
X-Gm-Message-State: ABy/qLa3WebLiw/OGMmpvlC1LXNDouspL6HyW1la4eMvvvQ3eoOkqGgK
        tkKrU3YwsJg5QLvzLaWNhrM9RA==
X-Google-Smtp-Source: APBJJlEzbrnno8tMNvQ3OeUKWzuED/8IeQRaqcQag7dwUOCCbEcY3VwgrJDme+hmO3Kc0CFMYucNRA==
X-Received: by 2002:a05:6a21:718b:b0:134:b28f:b581 with SMTP id wq11-20020a056a21718b00b00134b28fb581mr20904425pzb.28.1691085619659;
        Thu, 03 Aug 2023 11:00:19 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:00:19 -0700 (PDT)
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
Subject: [RFC PATCH v1 06/21] RISC-V: ACPI: Implement PCI related functionality
Date:   Thu,  3 Aug 2023 23:29:01 +0530
Message-Id: <20230803175916.3174453-7-sunilvl@ventanamicro.com>
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

Replace the dummy implementation for PCI related functions
with actual implementation.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/acpi.c | 32 +++++++++++++++-----------------
 drivers/pci/pci-acpi.c   |  2 +-
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index aa4433bca6d9..01022c5802ec 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -307,29 +307,27 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
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
-}
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
-{
-	return -1;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
 {
-	return NULL;
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return b->ops->write(b, devfn, reg, len, val);
 }
 #endif	/* CONFIG_PCI */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d6b2d64b8237..5af6188cdbe0 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1521,7 +1521,7 @@ static int __init acpi_pci_init(void)
 
 arch_initcall(acpi_pci_init);
 
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 /*
  * Try to assign the IRQ number when probing a new device
  */
-- 
2.39.2

