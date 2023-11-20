Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F947F1FDC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 23:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjKTWAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 17:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjKTWAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 17:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227C4CA
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 14:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700517611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YknJrzt+mUcfRZD9fsxvrl+TzKmo/BIC31FKbthLKE=;
        b=eEezHqEGUYkpcsBVK75kyqGafPuJw0b45soB1YP92N9smzG1HymHCR99VJII8M6nSt53nW
        yEjalgSEVpNcXDPiqTUPmH25SRyVKq81sC6XQygWVT43nQwA0xGcO+QSj9YuIgzYzxkscV
        HhmQYWeDYr4fSA3YoJbFjerzwnPIzzQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-MA5oAFeDPQ2C8l6qslW5Mw-1; Mon, 20 Nov 2023 17:00:09 -0500
X-MC-Unique: MA5oAFeDPQ2C8l6qslW5Mw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1ef393787e8so1017247fac.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 14:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700517608; x=1701122408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YknJrzt+mUcfRZD9fsxvrl+TzKmo/BIC31FKbthLKE=;
        b=pX2JFkKasnEYXgxD2a7yXw+QSBTV+GwmSud2asDF8WU/F4niLltgXx8LgGIlIWBL3I
         +JdP0XVR07UNZ6rOJCLuScGD2EZM/u0LdeqxJbNLmpw6dSDb4aXqpepCTf+5rZ7Froqf
         XifR9ngcfrJkAZTmceWTmDfwkypwaSG5sB4Tg14n8G4LMu4Y2EUkYHpfy4ZYUa74R8ZD
         mcYcA7IwswaobUwTbuEwWtBAb1bc8k5fJwQAijbCRUlcXDFKzYf+yZIZTTxDLOaj0X+O
         wGoTPORLjH5FD1vz3RnuVCFuUtWjfGHZtndux4MONc1LgxN2hUNJACqOai3m7zAMHuOb
         I2gg==
X-Gm-Message-State: AOJu0Yy9uOIVPT5AnKW8bw/ikNQk2w6NLmB7rbbi6pg36v12FL3razX6
        2YoUnHsnBZlmIiO6KJEA5zgwMijT9b1QH4yLINpDxSSHKg3i58+V68epqRFjshXYuDTaTH+xlWJ
        Qn4V5D3sD/ntxsklar+rD
X-Received: by 2002:a05:6358:199b:b0:16d:abd9:f29e with SMTP id v27-20020a056358199b00b0016dabd9f29emr6547695rwn.2.1700517608420;
        Mon, 20 Nov 2023 14:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCIi4ZtnWPYH5Nbuh+PP3GwGRiVhr5nrSG3asXMxcfimwvOxj/XDAQGiRIbPn9EQ4+9RYwPg==
X-Received: by 2002:a05:6358:199b:b0:16d:abd9:f29e with SMTP id v27-20020a056358199b00b0016dabd9f29emr6547661rwn.2.1700517608043;
        Mon, 20 Nov 2023 14:00:08 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32dd:2700:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id 3-20020ad45ba3000000b00677fb918337sm2762398qvq.53.2023.11.20.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:00:07 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        NeilBrown <neilb@suse.de>, Philipp Stanner <pstanner@redhat.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Date:   Mon, 20 Nov 2023 22:59:43 +0100
Message-ID: <20231120215945.52027-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120215945.52027-2-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This file is guarded by an #ifdef CONFIG_PCI. It, consequently, does not
belong to lib/ because it is not generic infrastructure.

Move the file to drivers/pci/ and implement the necessary changes to
Makefiles and Kconfigs.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/Kconfig                    | 3 +++
 drivers/pci/Makefile                   | 1 +
 lib/pci_iomap.c => drivers/pci/iomap.c | 3 ---
 lib/Kconfig                            | 3 ---
 lib/Makefile                           | 1 -
 5 files changed, 4 insertions(+), 7 deletions(-)
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 74147262625b..b54cacbc1160 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -34,6 +34,9 @@ config PCI_DOMAINS_GENERIC
 config PCI_SYSCALL
 	bool
 
+config GENERIC_PCI_IOMAP
+	bool
+
 source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index cc8b4e01e29d..d6d0abfe59e2 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/lib/pci_iomap.c b/drivers/pci/iomap.c
similarity index 99%
rename from lib/pci_iomap.c
rename to drivers/pci/iomap.c
index ce39ce9f3526..0a9d503ba533 100644
--- a/lib/pci_iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,7 +9,6 @@
 
 #include <linux/export.h>
 
-#ifdef CONFIG_PCI
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -176,5 +175,3 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 EXPORT_SYMBOL(pci_iounmap);
 
 #endif /* ARCH_WANTS_GENERIC_PCI_IOUNMAP */
-
-#endif /* CONFIG_PCI */
diff --git a/lib/Kconfig b/lib/Kconfig
index 3ea1c830efab..1bf859166ac7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -70,9 +70,6 @@ source "lib/math/Kconfig"
 config NO_GENERIC_PCI_IOPORT_MAP
 	bool
 
-config GENERIC_PCI_IOMAP
-	bool
-
 config GENERIC_IOMAP
 	bool
 	select GENERIC_PCI_IOMAP
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..0800289ec6c5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -153,7 +153,6 @@ CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 obj-y += math/ crypto/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
-obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
-- 
2.41.0

