Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2839C029
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhFDTHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:48569 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhFDTHg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:36 -0400
IronPort-SDR: VBpEk4uaTSam57/hvLj1qu3oA8aR9sdmRRnKfc55jV7tNHnewQNnYeohDQKCWguqI1auJ/rGHE
 Hd5QW4vqaBwg==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513942"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513942"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:47 -0700
IronPort-SDR: HN8zOg0M6sGZxSydzu8dI/DALkGCL1bfOx6QrFCyG6gLr9iuEN3OF4KZ7h6l7cX0Z1fHkztY6L
 kXg+iEodHBRQ==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049127"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 7/9] cxl: Add support for DVSEC port cap
Date:   Fri,  4 Jun 2021 12:05:39 -0700
Message-Id: <20210604190541.175602-8-ben.widawsky@intel.com>
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
 lib/header.h | 11 +++++++++++
 ls-ecaps.c   | 43 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index c346548..8141e13 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1109,6 +1109,17 @@
 #define PCI_CXL_DEV_RANGE2_BASE_HI	0x30
 #define PCI_CXL_DEV_RANGE2_BASE_LO	0x34
 
+/* PCIe CXL 2.0 Designated Vendor-Specific Capabilities for Ports */
+#define PCI_CXL_PORT_EXT_STATUS 0x0a		/* Port Extension Status */
+#define  PCI_CXL_PORT_PM_INIT_COMPLETE 0x1	/* Port Power Management Initialization Complete */
+#define PCI_CXL_PORT_CTRL 0x0c			/* Port Control Override */
+#define  PCI_CXL_PORT_UNMASK_SBR 0x0001		/* Unmask SBR */
+#define  PCI_CXL_PORT_UNMASK_LINK 0x0002	/* Unmask Link Disable */
+#define  PCI_CXL_PORT_ALT_MEMORY 0x0004		/* Alt Memory and ID Space Enable */
+#define  PCI_CXL_PORT_ALT_BME 0x0008		/* Alt BME */
+#define PCI_CXL_PORT_ALT_BUS_BASE 0xe
+#define PCI_CXL_PORT_ALT_BUS_LIMIT 0xf
+
 /* Access Control Services */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
 #define PCI_ACS_CAP_VALID	0x0001	/* ACS Source Validation */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 8072bbe..b11d5a9 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -778,6 +778,28 @@ dvsec_cxl_device(uint8_t *data, int rev)
   cxl_range(range_base, range_size, 2);
 }
 
+static void
+dvsec_cxl_port(uint8_t* data, int rev)
+{
+  u16 w;
+  u8 b1, b2;
+
+  if (rev != 0)
+    return;
+
+  w = *(u16 *)(data + PCI_CXL_PORT_EXT_STATUS);
+  printf("\t\tCXLPortSta:\tPMComplete%c\n", FLAG(w, PCI_CXL_PORT_EXT_STATUS));
+
+  w = *(u16 *)(data + PCI_CXL_PORT_CTRL);
+  printf("\t\tCXLPortCtl:\tUnmaskSBR%c UnmaskLinkDisable%c AltMem%c AltBME%c\n",
+    FLAG(w, PCI_CXL_PORT_UNMASK_SBR), FLAG(w, PCI_CXL_PORT_UNMASK_LINK),
+    FLAG(w, PCI_CXL_PORT_ALT_MEMORY), FLAG(w, PCI_CXL_PORT_ALT_BME));
+
+  b1 = *(u8 *)(data + PCI_CXL_PORT_ALT_BUS_BASE);
+  b2 = *(u8 *)(data + PCI_CXL_PORT_ALT_BUS_LIMIT);
+  printf("\t\tAlternateBus: %02x-%02x\n", b1, b2);
+}
+
 static void
 cap_dvsec_cxl(struct device *d, int id, int where)
 {
@@ -787,15 +809,24 @@ cap_dvsec_cxl(struct device *d, int id, int where)
   if (verbose < 2)
     return;
 
-  if (id != 0)
-    return;
-
   rev = BITS(get_conf_byte(d, where + 0x6), 0, 4);
 
-  if (!config_fetch(d, where, 0x38))
-    return;
+  switch (id) {
+    case 0:
+      if (!config_fetch(d, where, 0x38))
+        return;
+
+      dvsec_cxl_device(d->config + where, rev);
+      break;
+    case 3:
+      if (!config_fetch(d, where, 0x28))
+        return;
 
-  dvsec_cxl_device(d->config + where, rev);
+      dvsec_cxl_port(d->config + where, rev);
+      break;
+    default:
+      break;
+  }
 }
 
 static void
-- 
2.31.1

