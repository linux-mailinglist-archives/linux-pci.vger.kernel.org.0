Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97AF76F12C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjHCSCE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHCSB2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:01:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2356D49C6
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:00:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso893196b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085641; x=1691690441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVaxSLrcyWrDv537p1b6trWUWlm89roci1AhpEn7YYs=;
        b=fYo/3hatpzRNQHoHD581iWzQIHlOzusgQsa6qibNN0GLNn1R7S4p/XTrzg4lClBc1p
         lJKgy1mbJhBtdMSWvCGh9zo1ep2Gb3uA2P3XQbn7aI/LMI4bTDshu3hqT/1QFrqsfu7m
         TIdcKLkqWqqkK/tNhUcjdcoUPhpOgQm7R1QCCvGw5YQNWhSTvYAfTTAX+lJGELc3ARqy
         uX+JaTHismEAtWt+icKb9NzCOg5nBT52EbnylGIEAzjm2gWGkCHux7TB4Bi59RFPoIqH
         3R5ZRXHZLPpTl5R/PsHSm82EmxC7TCybtefpHDuU1MaqhlgUMegZvF1tMLSTrgHDefTg
         PaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085641; x=1691690441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVaxSLrcyWrDv537p1b6trWUWlm89roci1AhpEn7YYs=;
        b=jk08rlUtVIBERUo8JjfI2OiWl7RJSR6s9eoXHwLLFij4fDIcw3H3BbjFkt4Ql32R7U
         sl5eruIEvk1xK0n27V27L7c0B6WnoXMwdUH43e+MZir3qzRBGfZ3Lcxcpj2zGc5xJwMA
         0s7GODPvI14/+Twd7/Ubgl3IirjsEqiU9sAhDLwLhwJ/ebihvMomL61hC7wd31hmyEGV
         cNe9YBFFod799sCViO47vJ3OvttINih9t0f1jL/h1WGPiQH5nCslwcNF1zEzktYT5ZSk
         HgTgZ5+iMe5njpBsdNZa5dxuaRnSJcktWyYrV1AOUhnsECXT8PzA48Plq61UImZNwrNU
         g4zw==
X-Gm-Message-State: ABy/qLYngY+/AA7vtYd+a3hCulvJng+RZEId7t1BIauWeQfg5OiesvYV
        uxi3w8a2x9mF7CEEsSzcebHGrQ==
X-Google-Smtp-Source: APBJJlHyvV2fJJK5WcdXx6lc335tSDfrb26H7EK1vwao55qh/vVoaQmFBsBegHbsIEKiaSY6OFT3ZQ==
X-Received: by 2002:a05:6a21:6da1:b0:13d:82eb:795a with SMTP id wl33-20020a056a216da100b0013d82eb795amr13802350pzb.56.1691085641397;
        Thu, 03 Aug 2023 11:00:41 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:00:41 -0700 (PDT)
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
Subject: [RFC PATCH v1 09/21] RISC-V: cacheflush: Initialize CBO variables on ACPI systems
Date:   Thu,  3 Aug 2023 23:29:04 +0530
Message-Id: <20230803175916.3174453-10-sunilvl@ventanamicro.com>
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

Using new interface to get the CBO block size information in
RHCT, initialize the variables on ACPI platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index fbc59b3f69f2..63bb56819b37 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/of.h>
+#include <linux/acpi.h>
+#include <asm/acpi.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_SMP
@@ -131,15 +133,38 @@ void __init riscv_init_cbo_blocksizes(void)
 	unsigned long cbom_hartid, cboz_hartid;
 	u32 cbom_block_size = 0, cboz_block_size = 0;
 	struct device_node *node;
+	struct acpi_table_header *rhct;
+	acpi_status status;
+	unsigned int cpu;
+
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
+		if (ACPI_FAILURE(status))
+			return;
+	}
 
-	for_each_of_cpu_node(node) {
-		/* set block-size for cbom and/or cboz extension if available */
-		cbo_get_block_size(node, "riscv,cbom-block-size",
-				   &cbom_block_size, &cbom_hartid);
-		cbo_get_block_size(node, "riscv,cboz-block-size",
-				   &cboz_block_size, &cboz_hartid);
+	for_each_possible_cpu(cpu) {
+		if (acpi_disabled) {
+			node = of_cpu_device_node_get(cpu);
+			if (!node) {
+				pr_warn("Unable to find cpu node\n");
+				continue;
+			}
+
+			/* set block-size for cbom and/or cboz extension if available */
+			cbo_get_block_size(node, "riscv,cbom-block-size",
+					   &cbom_block_size, &cbom_hartid);
+			cbo_get_block_size(node, "riscv,cboz-block-size",
+					   &cboz_block_size, &cboz_hartid);
+		} else {
+			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
+						&cboz_block_size, NULL);
+		}
 	}
 
+	if (!acpi_disabled && rhct)
+		acpi_put_table((struct acpi_table_header *)rhct);
+
 	if (cbom_block_size)
 		riscv_cbom_block_size = cbom_block_size;
 
-- 
2.39.2

