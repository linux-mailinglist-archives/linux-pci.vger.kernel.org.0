Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875A7D75B3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjJYU1v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjJYU1S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:27:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540B61FD7
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:26:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so131647b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265571; x=1698870371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0XhMD4JA6OaCaDrqm344212wQ/hTWt0yHku4ySQPd8=;
        b=K64MiWefCeoGQ1P8qOxTxGSFT0lmoUcJ06G1MQheX3InL5mn/4fWWpX19CuxodTYr2
         qWCpLhlBwh1WbTvEN2DCus3ODseYqEmj2nrej7TJsAvBh8c5Bi2v1hOcy6UdGgl6Z20U
         g5DD6o/qENYB3IRiqyRfgR30ezfVwGN366kYRXhZ4iAgXhEwTcMSHMfSfSX2Crwsc22q
         3ZnODgoafThBIzwVycYU6ZqZVmFRNg6WLSot7bsT1a+twHgzZSO205htuDFm/RsskpMM
         Gwn739A/ay4axzan9QfWDgjkClDS3t92XQiKdkBDlLb2mvlv2jywW81SRZ2DZTnrPwTa
         Ohsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265571; x=1698870371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0XhMD4JA6OaCaDrqm344212wQ/hTWt0yHku4ySQPd8=;
        b=fmEgV6XdtNJaoKiK1AAqPB9ru62qQ1yNz58sTwc4l9v7N+mbA8f+Us0bqUWnPBB1cI
         FGDX9oDxGFKGUjysBAAB4QQRZZh63YmD+QfxyZsZjv0EKjCtqwZ8C1PxAWwT/9VjawhR
         +iL3fn9c5k/rAaSoPFxCTEzZLvZBJ8oC8XaRwqQPgYZVUioKawPu7fj7RpAg6BHyuYE+
         8lr5nKHr/lNvMUJ3uSg/hNNJvPb9H1MYM+V8RfBygeufoPUCUcO/wtMXTTy/Fgpe6yLK
         8tQrJ7NCzNxEAyJn4idsdXWLC58zIL1vJz1oeIUN2sgaC690PP04vZau/tQn3Bj1KQRF
         vV0A==
X-Gm-Message-State: AOJu0YwwK0ejD7KvOCSJaKRv7o1Uy/lH6jE2cCCQwpQougkuafZTFBo4
        U/LpGc3SQdAE65ITK9Ea2V+vLw==
X-Google-Smtp-Source: AGHT+IFjlmAHmkBC51cPzJaQWPRY6g5oe+6V9CmrTCMV9Y5zgvaJjhr+jA6O8yL6wxa5uTMIhaBuRw==
X-Received: by 2002:a05:6a00:15cf:b0:6b1:b5c4:a8b0 with SMTP id o15-20020a056a0015cf00b006b1b5c4a8b0mr19858459pfu.23.1698265570741;
        Wed, 25 Oct 2023 13:26:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:26:10 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 21/21] ACPI: RISC-V: Create PLIC platform device
Date:   Thu, 26 Oct 2023 01:53:44 +0530
Message-Id: <20231025202344.581132-22-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since PLIC needs to be a platform device, probe the MADT and create
platform devices for each PLIC in the system.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/init.c |  1 +
 drivers/acpi/riscv/init.h |  1 +
 drivers/acpi/riscv/irq.c  | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index e7eff7ab1474..c6fd4097e8ae 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -11,4 +11,5 @@
 void __init acpi_riscv_init(void)
 {
 	riscv_acpi_aplic_platform_init();
+	riscv_acpi_plic_platform_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
index 17bcf0baaadb..b4b305d83b3a 100644
--- a/drivers/acpi/riscv/init.h
+++ b/drivers/acpi/riscv/init.h
@@ -3,3 +3,4 @@
 
 void __init riscv_acpi_imsic_platform_init(void);
 void __init riscv_acpi_aplic_platform_init(void);
+void __init riscv_acpi_plic_platform_init(void);
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index fbccecdcbf8b..90b0738e2b9f 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -104,3 +104,17 @@ void __init riscv_acpi_aplic_platform_init(void)
 {
 	acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0);
 }
+
+static int __init plic_parse_madt(union acpi_subtable_headers *header,
+				  const unsigned long end)
+{
+	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
+
+	return irqchip_add_platform_device("riscv-plic", plic->id, plic->base_addr,
+					   plic->size, header);
+}
+
+void __init riscv_acpi_plic_platform_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, plic_parse_madt, 0);
+}
-- 
2.39.2

