Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3EA76F110
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjHCSAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjHCSAC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:00:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58309423F
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 10:59:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68783004143so890233b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085589; x=1691690389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZnV0ewqSpbZRhAC/LQ4a5BRuhAMm0ngpEEdA3S7vUc=;
        b=bnUHrvcB3yN6JHMYj1LgPtgbaxVQ2/kWyipu/UeXRJ2tHBpusAvGqpA2JpZ8jeIH3g
         SyS215bD2yhR3UKyi9XvIbGviVfviNKGBhGo/Mk/B9uovNyjuY/6JKLvXsCys19DKBzy
         PK3XjqkewPWtoHp1j2jTNsCLUY34QkGN+CYnMoiiMFGecT18d+z52RAzbiSaOEmldABl
         hBbRGcvCyS2IdMb43pHQK5fXbIjZesRZXZl+zaNJ8ai+DEh2SCarIlkd0XwjKBowE4e7
         pIqmYk0rHQaaJOnTsyBYVT8t+V9YHSEPUdcUxTvVigAA3BrS9RhiMJna4uMbinUca3Rm
         +79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085589; x=1691690389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZnV0ewqSpbZRhAC/LQ4a5BRuhAMm0ngpEEdA3S7vUc=;
        b=a/Q3iKm9s6YSj4pEZYRO/HfsYT2YEXPbozGR9L4qMMQRLBLTN+8u8B2lEzV3NbqtBK
         0Ap0e0VJmtulP1qzEFWbShwHTcYae0Kk+1Qx0EL6s+aZ64RxEkxtj3rwnPFe352SpZ7C
         w/+BuvOdVM6YJGNXD1eL0B/bNfBpozBPBLJ7cyMB0MW7q7ktZpf5obLwQdc6g05hesfi
         jWBOTHEyy3YRa7DE2kau8R79Z1B6+pp26c7VPR263lfYVDAV0tjHA2h3K0zNe/3PIAw1
         6Mx7wbA/nZNJx9mB+0/QHWmENLDcKPDA9Xn/3njS2/lBdmrAhOWnB5ERUF87/y0JIzme
         oNZA==
X-Gm-Message-State: ABy/qLbzqn9gogLI/lMmaD8mFSl0zUyhaeM+6g2WKK4pmJKAIkwqAesL
        JJNYRdFBT04f1FdIjcDycVUalg==
X-Google-Smtp-Source: APBJJlE1b+j2IWH4TbwV8C6fjO+Svt90/nwRmWf6oRPC//NYJR0B8gyqBDu4bXvcfIVaY5ldDXWYCg==
X-Received: by 2002:aa7:88c3:0:b0:687:20d6:faea with SMTP id k3-20020aa788c3000000b0068720d6faeamr17580448pff.15.1691085589326;
        Thu, 03 Aug 2023 10:59:49 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.10.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:59:49 -0700 (PDT)
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
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC PATCH v1 02/21] ACPICA: RHCT: Add flags, CMO and MMU nodes
Date:   Thu,  3 Aug 2023 23:28:57 +0530
Message-Id: <20230803175916.3174453-3-sunilvl@ventanamicro.com>
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

ACPICA commit 2eded5a6a13d892b7dc3be6096e7b1e8d4407600

Update RHCT table with below details.

 1) Add additional structure to describe the Cache Management
    Operation (CMO) related information.

 2) Add structure to describe MMU type.

 3) Convert the current reserved field to flags and define
    a flag to indicate timer capability.

This codefirst ECR is approved by UEFI forum and will
be part of next ACPI spec version.

Link: https://github.com/acpica/acpica/commit/2eded5a6
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 280ab4c7f77a..3751ae69432f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2778,12 +2778,15 @@ enum acpi_rgrt_image_type {
 
 struct acpi_table_rhct {
 	struct acpi_table_header header;	/* Common ACPI table header */
-	u32 reserved;
+	u32 flags;		/* RHCT flags */
 	u64 time_base_freq;
 	u32 node_count;
 	u32 node_offset;
 };
 
+/* RHCT Flags */
+
+#define ACPI_RHCT_TIMER_CANNOT_WAKEUP_CPU       (1)
 /*
  * RHCT subtables
  */
@@ -2797,6 +2800,9 @@ struct acpi_rhct_node_header {
 
 enum acpi_rhct_node_type {
 	ACPI_RHCT_NODE_TYPE_ISA_STRING = 0x0000,
+	ACPI_RHCT_NODE_TYPE_CMO = 0x0001,
+	ACPI_RHCT_NODE_TYPE_MMU = 0x0002,
+	ACPI_RHCT_NODE_TYPE_RESERVED = 0x0003,
 	ACPI_RHCT_NODE_TYPE_HART_INFO = 0xFFFF,
 };
 
@@ -2810,6 +2816,24 @@ struct acpi_rhct_isa_string {
 	char isa[];
 };
 
+struct acpi_rhct_cmo_node {
+	u8 reserved;		/* Must be zero */
+	u8 cbom_size;		/* CBOM size in powerof 2 */
+	u8 cbop_size;		/* CBOP size in powerof 2 */
+	u8 cboz_size;		/* CBOZ size in powerof 2 */
+};
+
+struct acpi_rhct_mmu_node {
+	u8 reserved;		/* Must be zero */
+	u8 mmu_type;		/* Virtual Address Scheme */
+};
+
+enum acpi_rhct_mmu_type {
+	ACPI_RHCT_MMU_TYPE_SV39 = 0,
+	ACPI_RHCT_MMU_TYPE_SV48 = 1,
+	ACPI_RHCT_MMU_TYPE_SV57 = 2
+};
+
 /* Hart Info node structure */
 struct acpi_rhct_hart_info {
 	u16 num_offsets;
-- 
2.39.2

