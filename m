Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2DA255490
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 08:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgH1Gey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 02:34:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbgH1Gew (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 02:34:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9122B3DE697E466C2F45;
        Fri, 28 Aug 2020 14:34:46 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 28 Aug 2020
 14:34:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH 1/2] iomap: move some definitions to include/linux/io.h
Date:   Fri, 28 Aug 2020 14:34:02 +0800
Message-ID: <20200828063403.3995421-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828063403.3995421-1-yangyingliang@huawei.com>
References: <20200828063403.3995421-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move some IO macros and bad_io_access() to include/linux/io.h
This prepares for moving pci_iounmap() to lib/pci_iomap.c.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/linux/io.h | 36 ++++++++++++++++++++++++++++++++++++
 lib/iomap.c        | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 8394c56babc26..fa040f8114eaa 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -13,6 +13,42 @@
 #include <asm/io.h>
 #include <asm/page.h>
 
+#ifndef HAVE_ARCH_PIO_SIZE
+/*
+ * We encode the physical PIO addresses (0-0xffff) into the
+ * pointer by offsetting them with a constant (0x10000) and
+ * assuming that all the low addresses are always PIO. That means
+ * we can do some sanity checks on the low bits, and don't
+ * need to just take things for granted.
+ */
+#define PIO_OFFSET	0x10000UL
+#define PIO_MASK	0x0ffffUL
+#define PIO_RESERVED	0x40000UL
+#endif
+
+static inline void bad_io_access(unsigned long port, const char *access)
+{
+	static int count = 10;
+	if (count) {
+		count--;
+		WARN(1, KERN_ERR "Bad IO access at port %#lx (%s)\n", port, access);
+	}
+}
+
+/*
+ * Ugly macros are a way of life.
+ */
+#define IO_COND(addr, is_pio, is_mmio) do {			\
+	unsigned long port = (unsigned long __force)addr;	\
+	if (port >= PIO_RESERVED) {				\
+		is_mmio;					\
+	} else if (port > PIO_OFFSET) {				\
+		port &= PIO_MASK;				\
+		is_pio;						\
+	} else							\
+		bad_io_access(port, #is_pio);			\
+} while (0)
+
 struct device;
 struct resource;
 
diff --git a/lib/iomap.c b/lib/iomap.c
index fbaa3e8f19d6c..d40bc6f662540 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -23,42 +23,6 @@
  * implementation and should do their own copy.
  */
 
-#ifndef HAVE_ARCH_PIO_SIZE
-/*
- * We encode the physical PIO addresses (0-0xffff) into the
- * pointer by offsetting them with a constant (0x10000) and
- * assuming that all the low addresses are always PIO. That means
- * we can do some sanity checks on the low bits, and don't
- * need to just take things for granted.
- */
-#define PIO_OFFSET	0x10000UL
-#define PIO_MASK	0x0ffffUL
-#define PIO_RESERVED	0x40000UL
-#endif
-
-static void bad_io_access(unsigned long port, const char *access)
-{
-	static int count = 10;
-	if (count) {
-		count--;
-		WARN(1, KERN_ERR "Bad IO access at port %#lx (%s)\n", port, access);
-	}
-}
-
-/*
- * Ugly macros are a way of life.
- */
-#define IO_COND(addr, is_pio, is_mmio) do {			\
-	unsigned long port = (unsigned long __force)addr;	\
-	if (port >= PIO_RESERVED) {				\
-		is_mmio;					\
-	} else if (port > PIO_OFFSET) {				\
-		port &= PIO_MASK;				\
-		is_pio;						\
-	} else							\
-		bad_io_access(port, #is_pio );			\
-} while (0)
-
 #ifndef pio_read16be
 #define pio_read16be(port) swab16(inw(port))
 #define pio_read32be(port) swab32(inl(port))
-- 
2.25.1

