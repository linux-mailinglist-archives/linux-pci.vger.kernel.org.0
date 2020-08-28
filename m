Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEB255493
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgH1Gez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 02:34:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgH1Gey (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 02:34:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9AC45A4D203992BB1321;
        Fri, 28 Aug 2020 14:34:51 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 28 Aug 2020
 14:34:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH 2/2] pci: fix memleak when calling pci_iomap/unmap()
Date:   Fri, 28 Aug 2020 14:34:03 +0800
Message-ID: <20200828063403.3995421-3-yangyingliang@huawei.com>
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

config GENERIC_IOMAP is disabled on some archs(e.g. arm64),
so pci_iounmap() does nothing, when we using pci_iomap/pci_iounmap(),
it will lead to memory leak. Move pci_iounmap() to lib/pci_map.c
to fix this.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/asm-generic/pci_iomap.h |  2 ++
 lib/iomap.c                     | 10 ----------
 lib/pci_iomap.c                 |  8 ++++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index d4f16dcc2ed79..d6a04d2462238 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -18,6 +18,8 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
+#define pci_iounmap pci_iounmap
+extern void pci_iounmap(struct pci_dev *dev, void __iomem * addr);
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
diff --git a/lib/iomap.c b/lib/iomap.c
index d40bc6f662540..df0b3c5fa2065 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -337,13 +337,3 @@ void ioport_unmap(void __iomem *addr)
 EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT_MAP */
-
-#ifdef CONFIG_PCI
-/* Hide the details if this is a MMIO or PIO address space and just do what
- * you expect in the correct way. */
-void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
-{
-	IO_COND(addr, /* nothing */, iounmap(addr));
-}
-EXPORT_SYMBOL(pci_iounmap);
-#endif /* CONFIG_PCI */
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index 2d3eb1cb73b8f..833b702771ecd 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -134,4 +134,12 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 	return pci_iomap_wc_range(dev, bar, 0, maxlen);
 }
 EXPORT_SYMBOL_GPL(pci_iomap_wc);
+
+/* Hide the details if this is a MMIO or PIO address space and just do what
+ * you expect in the correct way. */
+void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
+{
+	IO_COND(addr, /* nothing */, iounmap(addr));
+}
+EXPORT_SYMBOL(pci_iounmap);
 #endif /* CONFIG_PCI */
-- 
2.25.1

