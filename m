Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC5546F44A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 20:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhLIT4D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 14:56:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:34608 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhLIT4D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 14:56:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238137962"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="238137962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="680470514"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 11:52:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A11B329; Thu,  9 Dec 2021 21:52:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pci_ids: Keep Intel PCI IDs sorted by value
Date:   Thu,  9 Dec 2021 21:52:31 +0200
Message-Id: <20211209195231.2785-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Keep Intel PCI IDs sorted by value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pci_ids.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 86678588d191..306201cb9aff 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2738,12 +2738,6 @@
 #define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
 #define PCI_DEVICE_ID_INTEL_82801EB_12	0x24dc
 #define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
-#define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
-#define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
-#define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
-#define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
-#define PCI_DEVICE_ID_INTEL_ESB_9	0x25ab
-#define PCI_DEVICE_ID_INTEL_ESB_10	0x25ac
 #define PCI_DEVICE_ID_INTEL_82820_HB	0x2500
 #define PCI_DEVICE_ID_INTEL_82820_UP_HB	0x2501
 #define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
@@ -2758,14 +2752,15 @@
 #define PCI_DEVICE_ID_INTEL_82915G_IG	0x2582
 #define PCI_DEVICE_ID_INTEL_82915GM_HB	0x2590
 #define PCI_DEVICE_ID_INTEL_82915GM_IG	0x2592
+#define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
+#define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
+#define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
+#define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
+#define PCI_DEVICE_ID_INTEL_ESB_9	0x25ab
+#define PCI_DEVICE_ID_INTEL_ESB_10	0x25ac
 #define PCI_DEVICE_ID_INTEL_5000_ERR	0x25F0
 #define PCI_DEVICE_ID_INTEL_5000_FBD0	0x25F5
 #define PCI_DEVICE_ID_INTEL_5000_FBD1	0x25F6
-#define PCI_DEVICE_ID_INTEL_82945G_HB	0x2770
-#define PCI_DEVICE_ID_INTEL_82945G_IG	0x2772
-#define PCI_DEVICE_ID_INTEL_3000_HB	0x2778
-#define PCI_DEVICE_ID_INTEL_82945GM_HB	0x27A0
-#define PCI_DEVICE_ID_INTEL_82945GM_IG	0x27A2
 #define PCI_DEVICE_ID_INTEL_ICH6_0	0x2640
 #define PCI_DEVICE_ID_INTEL_ICH6_1	0x2641
 #define PCI_DEVICE_ID_INTEL_ICH6_2	0x2642
@@ -2777,6 +2772,11 @@
 #define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
 #define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
 #define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
+#define PCI_DEVICE_ID_INTEL_82945G_HB	0x2770
+#define PCI_DEVICE_ID_INTEL_82945G_IG	0x2772
+#define PCI_DEVICE_ID_INTEL_3000_HB	0x2778
+#define PCI_DEVICE_ID_INTEL_82945GM_HB	0x27A0
+#define PCI_DEVICE_ID_INTEL_82945GM_IG	0x27A2
 #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
 #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
 #define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
@@ -2941,16 +2941,16 @@
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
-#define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
-#define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
-#define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
-#define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
 #define PCI_DEVICE_ID_INTEL_5400_ERR	0x4030
 #define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
 #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
-#define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
 #define PCI_DEVICE_ID_INTEL_EP80579_0	0x5031
 #define PCI_DEVICE_ID_INTEL_EP80579_1	0x5032
+#define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
+#define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
+#define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
+#define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
+#define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
 #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
-- 
2.33.0

