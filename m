Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1D839C024
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhFDTHf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:48564 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFDTHe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:34 -0400
IronPort-SDR: TBm+cOJ2CQTwmo70tSaeg0e11CdrKhcfYAnPtaQV7db6EfdanYR7+ejaj3nxUnNRRsAWVOb102
 CNyq8HVOZv6g==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513938"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
IronPort-SDR: p1PkmxdBYLN3vyHqEGLtUxc3PESxF8rlav3rvyNExycASYPcqW4nH6y8B/K0T0X+4eUhfS+3Ec
 j+oAKMYU+Dgg==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049119"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 5/9] cxl: Rename caps to be device caps
Date:   Fri,  4 Jun 2021 12:05:37 -0700
Message-Id: <20210604190541.175602-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604190541.175602-1-ben.widawsky@intel.com>
References: <20210604190541.175602-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 lib/header.h | 36 ++++++++++++++++++------------------
 ls-ecaps.c   | 18 +++++++++---------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 170e5c1..3ff514a 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1067,24 +1067,24 @@
 #define PCI_DVSEC_VENDOR_ID_CXL	0x1e98	/* Designated Vendor-Specific Vendor ID for CXL */
 #define PCI_DVSEC_ID_CXL	0	/* Designated Vendor-Specific ID for Intel CXL */
 
-/* PCIe CXL Designated Vendor-Specific Capabilities, Control, Status */
-#define PCI_CXL_CAP		0x0a	/* CXL Capability Register */
-#define  PCI_CXL_CAP_CACHE	0x0001	/* CXL.cache Protocol Support */
-#define  PCI_CXL_CAP_IO		0x0002	/* CXL.io Protocol Support */
-#define  PCI_CXL_CAP_MEM	0x0004	/* CXL.mem Protocol Support */
-#define  PCI_CXL_CAP_MEM_HWINIT	0x0008	/* CXL.mem Initializes with HW/FW Support */
-#define  PCI_CXL_CAP_HDM_CNT(x)	(((x) & (3 << 4)) >> 4)	/* CXL Number of HDM ranges */
-#define  PCI_CXL_CAP_VIRAL	0x4000	/* CXL Viral Handling Support */
-#define PCI_CXL_CTRL		0x0c	/* CXL Control Register */
-#define  PCI_CXL_CTRL_CACHE	0x0001	/* CXL.cache Protocol Enable */
-#define  PCI_CXL_CTRL_IO	0x0002	/* CXL.io Protocol Enable */
-#define  PCI_CXL_CTRL_MEM	0x0004	/* CXL.mem Protocol Enable */
-#define  PCI_CXL_CTRL_CACHE_SF_COV(x)	(((x) & (0x1f << 3)) >> 3) /* Snoop Filter Coverage */
-#define  PCI_CXL_CTRL_CACHE_SF_GRAN(x)	(((x) & (0x7 << 8)) >> 8) /* Snoop Filter Granularity */
-#define  PCI_CXL_CTRL_CACHE_CLN	0x0800	/* CXL.cache Performance Hint on Clean Evictions */
-#define  PCI_CXL_CTRL_VIRAL	0x4000	/* CXL Viral Handling Enable */
-#define PCI_CXL_STATUS		0x0e	/* CXL Status Register */
-#define  PCI_CXL_STATUS_VIRAL	0x4000	/* CXL Viral Handling Status */
+/* PCIe CXL Designated Vendor-Specific Capabilities for Devices: Control, Status */
+#define PCI_CXL_DEV_CAP			0x0a	/* CXL Capability Register */
+#define  PCI_CXL_DEV_CAP_CACHE		0x0001	/* CXL.cache Protocol Support */
+#define  PCI_CXL_DEV_CAP_IO		0x0002	/* CXL.io Protocol Support */
+#define  PCI_CXL_DEV_CAP_MEM		0x0004	/* CXL.mem Protocol Support */
+#define  PCI_CXL_DEV_CAP_MEM_HWINIT	0x0008	/* CXL.mem Initializes with HW/FW Support */
+#define  PCI_CXL_DEV_CAP_HDM_CNT(x)	(((x) & (3 << 4)) >> 4)	/* CXL Number of HDM ranges */
+#define  PCI_CXL_DEV_CAP_VIRAL		0x4000	/* CXL Viral Handling Support */
+#define PCI_CXL_DEV_CTRL		0x0c	/* CXL Control Register */
+#define  PCI_CXL_DEV_CTRL_CACHE		0x0001	/* CXL.cache Protocol Enable */
+#define  PCI_CXL_DEV_CTRL_IO		0x0002	/* CXL.io Protocol Enable */
+#define  PCI_CXL_DEV_CTRL_MEM		0x0004	/* CXL.mem Protocol Enable */
+#define  PCI_CXL_DEV_CTRL_CACHE_SF_COV(x) (((x) & (0x1f << 3)) >> 3) /* Snoop Filter Coverage */
+#define  PCI_CXL_DEV_CTRL_CACHE_SF_GRAN(x) (((x) & (0x7 << 8)) >> 8) /* Snoop Filter Granularity */
+#define  PCI_CXL_DEV_CTRL_CACHE_CLN	0x0800	/* CXL.cache Performance Hint on Clean Evictions */
+#define  PCI_CXL_DEV_CTRL_VIRAL		0x4000	/* CXL Viral Handling Enable */
+#define PCI_CXL_DEV_STATUS		0x0e	/* CXL Status Register */
+#define  PCI_CXL_DEV_STATUS_VIRAL	0x4000	/* CXL Viral Handling Status */
 
 /* Access Control Services */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index c2a13d5..443d11d 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -698,19 +698,19 @@ dvsec_cxl_device(uint8_t *data, int rev)
   if (rev != 1)
     return;
 
-  w = *(u16 *)(data + PCI_CXL_CAP);
+  w = *(u16 *)(data + PCI_CXL_DEV_CAP);
   printf("\t\tCXLCap:\tCache%c IO%c Mem%c Mem HW Init%c HDMCount %d Viral%c\n",
-    FLAG(w, PCI_CXL_CAP_CACHE), FLAG(w, PCI_CXL_CAP_IO), FLAG(w, PCI_CXL_CAP_MEM),
-    FLAG(w, PCI_CXL_CAP_MEM_HWINIT), PCI_CXL_CAP_HDM_CNT(w), FLAG(w, PCI_CXL_CAP_VIRAL));
+    FLAG(w, PCI_CXL_DEV_CAP_CACHE), FLAG(w, PCI_CXL_DEV_CAP_IO), FLAG(w, PCI_CXL_DEV_CAP_MEM),
+    FLAG(w, PCI_CXL_DEV_CAP_MEM_HWINIT), PCI_CXL_DEV_CAP_HDM_CNT(w), FLAG(w, PCI_CXL_DEV_CAP_VIRAL));
 
-  w = *(u16 *)(data + PCI_CXL_CTRL);
+  w = *(u16 *)(data + PCI_CXL_DEV_CTRL);
   printf("\t\tCXLCtl:\tCache%c IO%c Mem%c Cache SF Cov %d Cache SF Gran %d Cache Clean%c Viral%c\n",
-    FLAG(w, PCI_CXL_CTRL_CACHE), FLAG(w, PCI_CXL_CTRL_IO), FLAG(w, PCI_CXL_CTRL_MEM),
-    PCI_CXL_CTRL_CACHE_SF_COV(w), PCI_CXL_CTRL_CACHE_SF_GRAN(w), FLAG(w, PCI_CXL_CTRL_CACHE_CLN),
-    FLAG(w, PCI_CXL_CTRL_VIRAL));
+    FLAG(w, PCI_CXL_DEV_CTRL_CACHE), FLAG(w, PCI_CXL_DEV_CTRL_IO), FLAG(w, PCI_CXL_DEV_CTRL_MEM),
+    PCI_CXL_DEV_CTRL_CACHE_SF_COV(w), PCI_CXL_DEV_CTRL_CACHE_SF_GRAN(w), FLAG(w, PCI_CXL_DEV_CTRL_CACHE_CLN),
+    FLAG(w, PCI_CXL_DEV_CTRL_VIRAL));
 
-  w = *(u16 *)(data + PCI_CXL_STATUS);
-  printf("\t\tCXLSta:\tViral%c\n", FLAG(w, PCI_CXL_STATUS_VIRAL));
+  w = *(u16 *)(data + PCI_CXL_DEV_STATUS);
+  printf("\t\tCXLSta:\tViral%c\n", FLAG(w, PCI_CXL_DEV_STATUS_VIRAL));
 }
 
 static void
-- 
2.31.1

