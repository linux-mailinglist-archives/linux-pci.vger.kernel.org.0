Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF18176F109
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 19:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjHCR7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjHCR7p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 13:59:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF83A85
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 10:59:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso1089784b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085582; x=1691690382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFiDx4yUD9M5LLDSVyQwmi0hMurmb+i35a+0GaoSwmM=;
        b=gzSCFSr/G3waueuE9A6zvWLt6I+my76zCgzC+Cixi6x1rcZmEeUXOSYMURhNyw6A6r
         J49EhGgoE3rXRkx6/8YpidVkV0MDlLQRzHN5khGbW0Z6Le7dX36yRwInwPOpY3NUol9K
         VFZda8kXmQd0g/+Bcy87pAQkGHttASe2PqLvfoe/rAFLFu56gnJi/ypQPQH0DfBUZLvh
         rumXtVJlEMOPyX69tNEq170gumWAvTBB487kSAKUPQbVWxjTEwxI1l6eSwdWgp1IXmU2
         EXNHu9wR+N4ak1DbuoMVvmyGwft7HubO+CSmircw3jRVDj5DBYF+Ylw9aBGU2GW71/6K
         aTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085582; x=1691690382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFiDx4yUD9M5LLDSVyQwmi0hMurmb+i35a+0GaoSwmM=;
        b=gCx3Tzj4EqUZvo5DkNUd5NHE85SWaDOnJYprtNE8z56LF3EVg4pWNd92DgeoxRqruI
         yPdWTBNJPzoWIJ41u/mwbnTU3EaNQRkdCKK6focMrLZxewf1IAU+t3EzBFvIiAn7vDng
         sxCtwOHKSP3H6sQxH8bAo8ZnmpfI4yCb/SuLrTTrgBVXss9T9nvSpbRAQ+nydov9rOK0
         2YLqLEpDIV/Ye6ZotglcrtMXHqYz5B0Rk5KeHNYVtWD60bmPw2yxHm0y+6kf5KJOZb3a
         DrdJJ40kbhfFKQDxi0U0XK0SRi8ujJcBDgrYfVxC5+t7Nq26GQMk4uCmcSKA1OuHmABv
         PZPA==
X-Gm-Message-State: ABy/qLaSwsAUgKVrZmgb9OYOEuL0MCdDkiS5t3VqC6+d4OsKPauLjRks
        MY2TJDCgyQkcLH3cS2N6qYwhaw==
X-Google-Smtp-Source: APBJJlEYFTsZLTq9I40pUpD7LIXiH3Cg29Qi6vfE5k5jpjtfQAYsVuB8uUL66kNJTqe85l1gopgFEA==
X-Received: by 2002:a05:6a20:7d9c:b0:13e:82ae:483 with SMTP id v28-20020a056a207d9c00b0013e82ae0483mr11419977pzj.31.1691085581732;
        Thu, 03 Aug 2023 10:59:41 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:59:41 -0700 (PDT)
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
Subject: [RFC PATCH v1 01/21] ACPICA: MADT: Add RISC-V external interrupt controllers
Date:   Thu,  3 Aug 2023 23:28:56 +0530
Message-Id: <20230803175916.3174453-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ACPICA commit 8c048cee4ea7b9ded8db3e1b3b9c14e21e084a2c

This adds 3 different external interrupt controller
definitions in MADT for RISC-V.

 1) RISC-V PLIC is a platform interrupt controller for
    handling wired interrupt in a RISC-V systems.

 2) RISC-V IMSIC is MSI interrupt controller to
    support MSI interrupts.

 3) RISC-V APLIC has dual functionality. First it can
    act like PLIC and direct all wired interrupts to
    the CPU which doesn't have MSI controller. Second,
    when the CPU has MSI controller (IMSIC), it will
    act as a converter from wired interrupts to MSI.

Update the existing RINTC structure also to support
these external interrupt controllers.

This codefirst ECR is approved by UEFI forum and will
be part of next ACPI spec version.

Link: https://github.com/acpica/acpica/commit/8c048cee
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 50 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 0029336775a9..280ab4c7f77a 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -893,7 +893,10 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_BIO_PIC = 22,
 	ACPI_MADT_TYPE_LPC_PIC = 23,
 	ACPI_MADT_TYPE_RINTC = 24,
-	ACPI_MADT_TYPE_RESERVED = 25,	/* 25 to 0x7F are reserved */
+	ACPI_MADT_TYPE_IMSIC = 25,
+	ACPI_MADT_TYPE_APLIC = 26,
+	ACPI_MADT_TYPE_PLIC = 27,
+	ACPI_MADT_TYPE_RESERVED = 28,	/* 28 to 0x7F are reserved */
 	ACPI_MADT_TYPE_OEM_RESERVED = 0x80	/* 0x80 to 0xFF are reserved for OEM use */
 };
 
@@ -1261,6 +1264,9 @@ struct acpi_madt_rintc {
 	u32 flags;
 	u64 hart_id;
 	u32 uid;		/* ACPI processor UID */
+	u32 ext_intc_id;	/* External INTC Id */
+	u64 imsic_addr;		/* IMSIC base address */
+	u32 imsic_size;		/* IMSIC size */
 };
 
 /* Values for RISC-V INTC Version field above */
@@ -1271,6 +1277,48 @@ enum acpi_madt_rintc_version {
 	ACPI_MADT_RINTC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
 };
 
+/* 25: RISC-V IMSIC */
+struct acpi_madt_imsic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 reserved;
+	u32 flags;
+	u16 num_ids;
+	u16 num_guest_ids;
+	u8 guest_index_bits;
+	u8 hart_index_bits;
+	u8 group_index_bits;
+	u8 group_index_shift;
+};
+
+/* 26: RISC-V APLIC */
+struct acpi_madt_aplic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 id;
+	u32 flags;
+	u8 hw_id[8];
+	u16 num_idcs;
+	u16 num_sources;
+	u32 gsi_base;
+	u64 base_addr;
+	u32 size;
+};
+
+/* 27: RISC-V PLIC */
+struct acpi_madt_plic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 id;
+	u8 hw_id[8];
+	u16 num_irqs;
+	u16 max_prio;
+	u32 flags;
+	u32 size;
+	u64 base_addr;
+	u32 gsi_base;
+};
+
 /* 80: OEM data */
 
 struct acpi_madt_oem_data {
-- 
2.39.2

