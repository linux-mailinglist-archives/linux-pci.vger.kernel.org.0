Return-Path: <linux-pci+bounces-1419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BEE81EDDC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F23E2837FD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54B1095A;
	Wed, 27 Dec 2023 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="veDZcvx6";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Ut4CAezZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB828E2D
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3940BC000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670367; bh=CTJjAjTpq/uv59gXUUxIWe/fKK/pQbwK97FgZzzA+Mw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=veDZcvx67IRqjiGn+RPkuFqlgaV1sEc4jFK8rHJPRK7dldGTxDve1/TGtSezL7lZ+
	 eICatC7++RtGrWVkEt22VgODTELpHxXM4We+LTNGlxWGDaaaiRx6UnuSQl8bCggppl
	 QJycu6BgtXEnhlyyyFyvx1IKEbyMWBpSDlv3BUAgxkoQ/UlMVcyNpOOI0zm1C6kGKZ
	 4cWj0VoltHmHvtFFQ6wQP3vay5FD6O7CmvAl2sN4Eocopj8HdKg7rrvzR6BVtGsEX4
	 n9pQfxT1Q6wA5x1dAknni1kv3ZKRV6wDgHTsJVA/KAnXphCrVvFDqYk7YFd/CcUKi0
	 Hi5ugBCuemyWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670367; bh=CTJjAjTpq/uv59gXUUxIWe/fKK/pQbwK97FgZzzA+Mw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Ut4CAezZjNbrwp7FyO4u7+m+N3epOnry5KtfQt1txf6uH+SzmJb0RTTZAoY4edTpj
	 pM5Cfmy2S+Jwj5ZVBcnkyW59DdvWO6YhpH2ZGmyjuroeHtRZQEFm/JG8o7aaQKYzJs
	 JkqFW3w7KMwEud77qDdZBVpLZNaRr5ajP4wW1M7RFt5E0ftQo4kdTzb2dnB4i1Uydh
	 Jr0y89RkIZboej0cuMp+0Btv3IZ558jfqhFY2BRVtKq6DJxuweMamovFMdWSMXtOU1
	 ajgAfi9Ew7gMeMhfTAr+KFN9Mv0vSZ22Rr1NhAwJ2Ff8CP1/KOtTYj9Vu8+HHayqNW
	 LJzUA8cn61tUw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 04/15] pciutils-pcilib: Add separate file for bit manipulation functions
Date: Wed, 27 Dec 2023 14:44:53 +0500
Message-ID: <20231227094504.32257-5-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Move several macros from lspci and add some more for operations with
bit masks.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 Makefile     |  2 +-
 lib/bitops.h | 39 +++++++++++++++++++++++++++++++++++++++
 lib/pci.h    |  1 +
 lspci.h      |  6 ------
 4 files changed, 41 insertions(+), 7 deletions(-)
 create mode 100644 lib/bitops.h

diff --git a/Makefile b/Makefile
index 228cb56..52538e8 100644
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,7 @@ LIBNAME=libpci
 
 -include lib/config.mk
 
-PCIINC=lib/config.h lib/header.h lib/pci.h lib/types.h lib/sysdep.h
+PCIINC=lib/config.h lib/header.h lib/pci.h lib/types.h lib/sysdep.h lib/bitops.h
 PCIINC_INS=lib/config.h lib/header.h lib/pci.h lib/types.h
 
 export
diff --git a/lib/bitops.h b/lib/bitops.h
new file mode 100644
index 0000000..029741e
--- /dev/null
+++ b/lib/bitops.h
@@ -0,0 +1,39 @@
+/*
+ *	The PCI Utilities -- Decode bits and bit fields
+ *
+ *	Copyright (c) 2023 Martin Mares <mj@ucw.cz>
+ *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL v2+.
+ *
+ *	SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _BITOPS_H
+#define _BITOPS_H
+
+#ifndef _PCI_LIB_H
+#error Import only from pci.h
+#endif
+
+/* Useful macros for decoding of bits and bit fields */
+
+#define FLAG(x, y) ((x & y) ? '+' : '-')
+
+// Generate mask
+
+#define BIT(at) ((u64)1 << (at))
+// Boundaries inclusive
+#define MASK(h, l)   ((((u64)1 << ((h) + 1)) - 1) & ~(((u64)1 << (l)) - 1))
+
+// Get/set from register
+
+#define BITS(x, at, width)      (((x) >> (at)) & ((1 << (width)) - 1))
+#define GET_REG_MASK(reg, mask) (((reg) & (mask)) / ((mask) & ~((mask) << 1)))
+#define SET_REG_MASK(reg, mask, val)                                                               \
+  (((reg) & ~(mask)) | (((val) * ((mask) & ~((mask) << 1))) & (mask)))
+
+#define TABLE(tab, x, buf)                                                                         \
+  ((x) < sizeof(tab) / sizeof((tab)[0]) ? (tab)[x] : (sprintf((buf), "??%d", (x)), (buf)))
+
+#endif
diff --git a/lib/pci.h b/lib/pci.h
index 2322bf7..6cc46b3 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -17,6 +17,7 @@
 
 #include "header.h"
 #include "types.h"
+#include "bitops.h"
 
 #define PCI_LIB_VERSION 0x030a00
 
diff --git a/lspci.h b/lspci.h
index c5a9ec7..4d711a5 100644
--- a/lspci.h
+++ b/lspci.h
@@ -58,12 +58,6 @@ u32 get_conf_long(struct device *d, unsigned int pos);
 word get_conf_word(struct device *d, unsigned int pos);
 byte get_conf_byte(struct device *d, unsigned int pos);
 
-/* Useful macros for decoding of bits and bit fields */
-
-#define FLAG(x,y) ((x & y) ? '+' : '-')
-#define BITS(x,at,width) (((x) >> (at)) & ((1 << (width)) - 1))
-#define TABLE(tab,x,buf) ((x) < sizeof(tab)/sizeof((tab)[0]) ? (tab)[x] : (sprintf((buf), "??%d", (x)), (buf)))
-
 /* ls-vpd.c */
 
 void cap_vpd(struct device *d);
-- 
2.34.1


