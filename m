Return-Path: <linux-pci+bounces-410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F2A803312
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 13:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CD91C20A61
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B4241FD;
	Mon,  4 Dec 2023 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEIh5Wuf"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A519D
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 04:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701693546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OoJJxtshe3eicbElJTkZJFUUMS0e59nV8kbi1j784oU=;
	b=eEIh5WufomzgC9N7+lAGwxPt5RapB23ukpvo/nU/NllnVlAnFanPHM66oXetQjfFcFIPok
	ES/aQThKXTltUk3wVFvXPsZPbNhwQZsdvTq86XCe/JnZsOyan6a4Z1HNoDlNZf53O4cGQK
	R5i7cQIhwlIanGdNIbuxd9m5JKm2YwY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-qBaf5s1vMe2FtRFjffcoeQ-1; Mon, 04 Dec 2023 07:39:05 -0500
X-MC-Unique: qBaf5s1vMe2FtRFjffcoeQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b4302eac2so7666305e9.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Dec 2023 04:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693544; x=1702298344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoJJxtshe3eicbElJTkZJFUUMS0e59nV8kbi1j784oU=;
        b=iV7IxlOaIoOR4HJa0aabW7qUKxpcLihabgBs7KbeXm/GoryKc5rsLXwhqVwLEQmYsr
         fyl5xe2V6XowHRgXSp9y+5so9UC5tOf2eFUeMAZII5KQFVJC14o4PKi7AzZ0YyuPxukB
         LoMtifNVvtbgjYFFpmbEHsMHfl2luab0QTLdo7SJzbrIAW1qXWjp3Oi9gHjcgvkHJUQO
         ujGL8vuVZ2K2nOIyc7qARG03bh0Vx7G0Xx3ZAsSqeSXuCU35yQbsBjjFGFiexnGidGyr
         J9wYfgvHkTtRRvMawWfwWwzO1CxgdkF2aLtLQGmM6/7z6fRMpD1SEqIRd5lQGxwrLGKU
         TIyA==
X-Gm-Message-State: AOJu0YyDIvIy7kFeOQ+T/Z1Fa5aTDP4DCwKyHaT5+C1vTsTo5utze65L
	mBwPT0Z4fSe5JKPMg/0wtssQJFEZfEu3SS6ThPLAmhAW4Xr53J9HPGJCwezeUvXVlHrxgXXJys3
	Wid88PmQ7RfC8kAlbUppo
X-Received: by 2002:a05:600c:45c6:b0:405:39bb:38a8 with SMTP id s6-20020a05600c45c600b0040539bb38a8mr22514040wmo.2.1701693544266;
        Mon, 04 Dec 2023 04:39:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv2uaCopDPejvYPPdyLu1AxwlsntLllw+iwWBDM5+bFKF+IJTkoJq0RU06wBSQ2NBJxKFAGg==
X-Received: by 2002:a05:600c:45c6:b0:405:39bb:38a8 with SMTP id s6-20020a05600c45c600b0040539bb38a8mr22514011wmo.2.1701693544004;
        Mon, 04 Dec 2023 04:39:04 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c8:b00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm18355935wms.3.2023.12.04.04.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:39:03 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	John Sanpe <sanpeqf@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	David Gow <davidgow@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] lib: move pci_iomap.c to drivers/pci/
Date: Mon,  4 Dec 2023 13:38:29 +0100
Message-ID: <20231204123834.29247-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204123834.29247-1-pstanner@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file is guarded by an #ifdef CONFIG_PCI. It, consequently, does not
belong to lib/ because it is not generic infrastructure.

Move the file to drivers/pci/ and implement the necessary changes to
Makefiles and Kconfigs.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/Kconfig                    | 5 +++++
 drivers/pci/Makefile                   | 1 +
 lib/pci_iomap.c => drivers/pci/iomap.c | 3 ---
 lib/Kconfig                            | 3 ---
 lib/Makefile                           | 1 -
 5 files changed, 6 insertions(+), 7 deletions(-)
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 74147262625b..d35001589d88 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -13,6 +13,11 @@ config FORCE_PCI
 	select HAVE_PCI
 	select PCI
 
+# select this to provide a generic PCI iomap,
+# without PCI itself having to be defined
+config GENERIC_PCI_IOMAP
+	bool
+
 menuconfig PCI
 	bool "PCI support"
 	depends on HAVE_PCI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index cc8b4e01e29d..64dcedccfc87 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -14,6 +14,7 @@ ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= slot.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
 endif
 
 obj-$(CONFIG_OF)		+= of.o
diff --git a/lib/pci_iomap.c b/drivers/pci/iomap.c
similarity index 99%
rename from lib/pci_iomap.c
rename to drivers/pci/iomap.c
index 6e144b017c48..91285fcff1ba 100644
--- a/lib/pci_iomap.c
+++ b/drivers/pci/iomap.c
@@ -9,7 +9,6 @@
 
 #include <linux/export.h>
 
-#ifdef CONFIG_PCI
 /**
  * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -178,5 +177,3 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
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
2.43.0


