Return-Path: <linux-pci+bounces-336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B656A800AA4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 13:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62AB1C20BF9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5DE24B34;
	Fri,  1 Dec 2023 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCRHXEQJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5EC103
	for <linux-pci@vger.kernel.org>; Fri,  1 Dec 2023 04:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701433014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b29/c8il4IwH3mmZXi9Lko6mOop1IfhpXMh6iHVA43k=;
	b=gCRHXEQJ3tqRsmOP+jz+hkkiDndDKWvlot1LubcaRBbt8LG9PaDL1avu6dA6eZpvRk+1y8
	UFooqaKCAcmJt7K9+oK7QH8MgM6f4F1MV6ji8hXH5WxCKAJ97zfrY8TAEXkX35MF326Iw5
	q3klQmLbXslAHZ57cn9WxzjEgDhqOPo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-Q1OoWPMlMQyo6wEGIX9wYg-1; Fri, 01 Dec 2023 07:16:53 -0500
X-MC-Unique: Q1OoWPMlMQyo6wEGIX9wYg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a1f7b4a0fso4452626d6.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Dec 2023 04:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433013; x=1702037813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b29/c8il4IwH3mmZXi9Lko6mOop1IfhpXMh6iHVA43k=;
        b=ut4pQZXi0IuXE4QkHVhHvlfNk4YfjW+iuWRZ+KqKHi5fW98EP+oRyMoM5iT6Hu5tkv
         dg7PR1O+ULS+DZzIa+iQNLorKFtVeoyqfN8mhXTer95sD/3XrLmVaJ/gWIbTHqZyPWD5
         nVvjjflNWtLARymHKJp4GmwiN3L8TmC8eVDUmgLtwIuObBGIv3FVWl+QbliLZUxG/bZu
         pqeeQFeGhpDfo56kVGyjTLTAfunnbG6NyjPB3vzCRz4+gVpHyt60BsDzmk2C4w+Q9ySl
         4YQBpsoCxwiu2oPtoKsLnZop64QzdoB4hBiLpp1MkamwOo53x8vv2zQO7dXGkFXWgGFP
         kOzw==
X-Gm-Message-State: AOJu0YyKMbzErx1oxzJbBv8U8wftj74zsPlx5OHfP8jP9hRz8lGqoX6Q
	pAKgAXt6HbD+YHtHUYqC9OT5uEPjHmSaDzllDnR3a3WWv4WFuDD7t8PaTbi5i2+A02rE4cSuAqD
	cijMNsPtaoTLLk1FuUF70
X-Received: by 2002:a05:6214:94b:b0:67a:94bd:f7ee with SMTP id dn11-20020a056214094b00b0067a94bdf7eemr1924504qvb.2.1701433012794;
        Fri, 01 Dec 2023 04:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgUY4BSPRWVUPKwtDbEVuFrDGCCa51av9V5itSH44J3lXA2d6YMliye6elq/GTnMqmREYwyw==
X-Received: by 2002:a05:6214:94b:b0:67a:94bd:f7ee with SMTP id dn11-20020a056214094b00b0067a94bdf7eemr1924479qvb.2.1701433012534;
        Fri, 01 Dec 2023 04:16:52 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id b19-20020ac87553000000b00423b8a53641sm1426528qtr.29.2023.12.01.04.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:16:52 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	NeilBrown <neilb@suse.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	David Gow <davidgow@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Jason Baron <jbaron@akamai.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 1/4] lib: move pci_iomap.c to drivers/pci/
Date: Fri,  1 Dec 2023 13:16:19 +0100
Message-ID: <20231201121622.16343-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201121622.16343-1-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
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
2.43.0


