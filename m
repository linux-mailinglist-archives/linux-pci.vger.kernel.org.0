Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF639C028
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFDTHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:48564 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhFDTHg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:36 -0400
IronPort-SDR: u1x5Oizxre4tlA1GVc/NMo5gWvJ4eBjIonRWwSV8sIsY6pFb5uffKj6ol8VT277ECKgbMKgs9t
 9CtuRgj1r7bQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513939"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513939"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
IronPort-SDR: Vw1tDkwKdVfMAmLswefk2OoIqCffSshRfvrLZ+hpdDoQH9dLmGmaZlLWvGN0lkOz7cmMenMVS7
 ZzleAd5UxzTQ==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049122"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 6/9] cxl: Implement more device DVSEC decoding
Date:   Fri,  4 Jun 2021 12:05:38 -0700
Message-Id: <20210604190541.175602-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604190541.175602-1-ben.widawsky@intel.com>
References: <20210604190541.175602-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

---
 lib/header.h | 23 +++++++++++++++++++
 ls-ecaps.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 3ff514a..c346548 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1085,6 +1085,29 @@
 #define  PCI_CXL_DEV_CTRL_VIRAL		0x4000	/* CXL Viral Handling Enable */
 #define PCI_CXL_DEV_STATUS		0x0e	/* CXL Status Register */
 #define  PCI_CXL_DEV_STATUS_VIRAL	0x4000	/* CXL Viral Handling Status */
+#define PCI_CXL_DEV_STATUS2		0x12
+#define  PCI_CXL_DEV_STATUS_CACHE_INV	0x0001
+#define  PCI_CXL_DEV_STATUS_RC		0x0002  /* Device Reset Complete */
+#define  PCI_CXL_DEV_STATUS_RE		0x0004  /* Device Reset Error */
+#define  PCI_CXL_DEV_STATUS_PMC		0x8000  /* Power Management Init Complete */
+#define PCI_CXL_DEV_CAP2		0x16
+#define  PCI_CXL_DEV_CAP2_CACHE_UNK	0x0000	/* Cache Size Isn't Reported */
+#define  PCI_CXL_DEV_CAP2_CACHE_64K	0x0001  /* Unit Size 64K */
+#define  PCI_CXL_DEV_CAP2_CACHE_1M	0x0002  /* Unit Size 1M */
+#define PCI_CXL_DEV_RANGE1_SIZE_HI	0x18
+#define PCI_CXL_DEV_RANGE1_SIZE_LO	0x1c
+#define  PCI_CXL_RANGE_VALID		0x0001
+#define  PCI_CXL_RANGE_ACTIVE		0x0002
+#define  PCI_CXL_RANGE_TYPE(x)		(((x) >> 2) & 0x7)
+#define  PCI_CXL_RANGE_CLASS(x)		(((x) >> 5) & 0x7)
+#define  PCI_CXL_RANGE_INTERLEAVE(x)	(((x) >> 8) & 0x1f)
+#define  PCI_CXL_RANGE_TIMEOUT(x)	(((x) >> 13) & 0x7)
+#define PCI_CXL_DEV_RANGE1_BASE_HI	0x20
+#define PCI_CXL_DEV_RANGE1_BASE_LO	0x24
+#define PCI_CXL_DEV_RANGE2_SIZE_HI	0x28
+#define PCI_CXL_DEV_RANGE2_SIZE_LO	0x2c
+#define PCI_CXL_DEV_RANGE2_BASE_HI	0x30
+#define PCI_CXL_DEV_RANGE2_BASE_LO	0x34
 
 /* Access Control Services */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 443d11d..8072bbe 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -689,9 +689,31 @@ cap_rcec(struct device *d, int where)
     printf("\t\tAssociatedBusNumbers: %02x-%02x\n", nextbusn, lastbusn );
 }
 
+static void
+cxl_range(u64 size, u64 base, int n)
+{
+  u32 interleave[] = { 0, 256, 4096, 512, 1024, 2048, 8192, 16384 };
+  const char *type[] = { "Volatile", "Non-volatile", "CDAT" };
+  const char *class[] = { "DRAM", "Storage", "CDAT" };
+  u16 w;
+
+  w = (u16) base;
+
+  base &= ~0x0fffffffULL;
+
+  printf("\t\tRange%d: %"PRIx64"-%"PRIx64"\n", n, base, base + size - 1);
+  printf("\t\t\tValid%c Active%c Type=%s Class=%s interleave=%d timeout=%ds\n",
+    FLAG(w, PCI_CXL_RANGE_VALID), FLAG(w, PCI_CXL_RANGE_ACTIVE),
+    type[PCI_CXL_RANGE_TYPE(w)], class[PCI_CXL_RANGE_CLASS(w)],
+    interleave[PCI_CXL_RANGE_INTERLEAVE(w)],
+    1 << (PCI_CXL_RANGE_TIMEOUT(w) * 2));
+}
+
 static void
 dvsec_cxl_device(uint8_t *data, int rev)
 {
+  u32 cache_size, cache_unit_size, l;
+  u64 range_base, range_size;
   u16 w;
 
   /* Legacy 1.1 revs aren't handled */
@@ -711,6 +733,49 @@ dvsec_cxl_device(uint8_t *data, int rev)
 
   w = *(u16 *)(data + PCI_CXL_DEV_STATUS);
   printf("\t\tCXLSta:\tViral%c\n", FLAG(w, PCI_CXL_DEV_STATUS_VIRAL));
+
+  w = *(u16 *)(data + PCI_CXL_DEV_STATUS2);
+  printf("\t\tCXLSta2:\tResetComplete%c ResetError%c PMComplete%c\n",
+    FLAG(w, PCI_CXL_DEV_STATUS_RC), FLAG(w,PCI_CXL_DEV_STATUS_RE), FLAG(w, PCI_CXL_DEV_STATUS_PMC));
+
+  w = *(u16 *)(data + PCI_CXL_DEV_CAP2);
+  cache_unit_size = BITS(w, 0, 4);
+  cache_size = BITS(w, 8, 8);
+  switch (cache_unit_size)
+    {
+      case PCI_CXL_DEV_CAP2_CACHE_1M:
+        printf("\t\tCache Size: %08x\n", cache_size * (1<<20));
+	break;
+      case PCI_CXL_DEV_CAP2_CACHE_64K:
+        printf("\t\tCache Size: %08x\n", cache_size * (64<<10));
+	break;
+      case PCI_CXL_DEV_CAP2_CACHE_UNK:
+        printf("\t\tCache Size Not Reported\n");
+	break;
+      default:
+        printf("\t\tCache Size: %d of unknown unit size (%d)\n", cache_size, cache_unit_size);
+	break;
+    }
+
+  l = *(u32 *)(data + PCI_CXL_DEV_RANGE1_SIZE_HI);
+  range_size = (u64) l << 32;
+  l = *(u32 *)(data + PCI_CXL_DEV_RANGE1_SIZE_LO);
+  range_size |= l;
+  l = *(u32 *)(data + PCI_CXL_DEV_RANGE1_BASE_HI);
+  range_base = (u64) l << 32;
+  l = *(u32 *)(data + PCI_CXL_DEV_RANGE1_BASE_LO);
+  range_base |= l;
+  cxl_range(range_base, range_size, 1);
+
+  l = *(u32 *)(data + PCI_CXL_DEV_RANGE2_SIZE_HI);
+  range_size = (u64) l << 32;
+  l = *(u32 *)(data + PCI_CXL_DEV_RANGE2_SIZE_LO);
+  range_size |= l;
+  l = *(u32 *)(data + PCI_CXL_DEV_RANGE2_BASE_HI);
+  range_base = (u64) l << 32;
+  l = *(u32 *)(data + PCI_CXL_DEV_RANGE2_BASE_LO);
+  range_base |= l;
+  cxl_range(range_base, range_size, 2);
 }
 
 static void
-- 
2.31.1

