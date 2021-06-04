Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9F39C025
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFDTHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:48569 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230254AbhFDTHe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:34 -0400
IronPort-SDR: ls52nCy6OONrFSvFDSX31hPPxZTMAR/HU8e+qkXbVNrt6FrdAYjJPXMsEciAbLxe2mHUC5yXOi
 gr/kZUFmKQTA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513943"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513943"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:47 -0700
IronPort-SDR: UqWI9jC1pGkJpvMXQ5dgiz9hF8Jl+mhfiITIbGLMNvjbGVoE03QCAGqWb5oFKFu5ySakm4mtbp
 ZgQFsAfaEyxA==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049131"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:47 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 8/9] cxl: Add DVSEC Register Locator
Date:   Fri,  4 Jun 2021 12:05:40 -0700
Message-Id: <20210604190541.175602-9-ben.widawsky@intel.com>
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
 lib/header.h |  8 ++++++++
 ls-ecaps.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 8141e13..b77a611 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1120,6 +1120,14 @@
 #define PCI_CXL_PORT_ALT_BUS_BASE 0xe
 #define PCI_CXL_PORT_ALT_BUS_LIMIT 0xf
 
+/* PCIe CXL 2.0 Designated Vendor-Specific Capabilities for Register Locator */
+#define PCI_CXL_RL_BASE0_LO 0x0c
+#define PCI_CXL_RL_BASE0_HI 0x10
+#define PCI_CXL_RL_BASE1_LO 0x14
+#define PCI_CXL_RL_BASE1_HI 0x18
+#define PCI_CXL_RL_BASE2_LO 0x1c
+#define PCI_CXL_RL_BASE2_HI 0x20
+
 /* Access Control Services */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
 #define PCI_ACS_CAP_VALID	0x0001	/* ACS Source Validation */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index b11d5a9..a0ef83d 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -800,9 +800,46 @@ dvsec_cxl_port(uint8_t* data, int rev)
   printf("\t\tAlternateBus: %02x-%02x\n", b1, b2);
 }
 
+static const char *id[] = {
+  "empty",
+  "component registers",
+  "BAR virtualization",
+  "CXL device registers"};
+
+static inline void
+dvsec_decode_block(uint32_t lo, uint32_t hi, char which)
+{
+  u64 base_hi = hi, base_lo;
+  u8 bir, block_id;
+
+  bir = BITS(lo, 0, 3);
+  block_id = BITS(lo, 8, 8);
+  base_lo = BITS(lo, 16, 16);
+
+  if (!block_id)
+    return;
+
+  printf("\t\tBlock%c\tBIR: bar%d\tID: %s\n", which, bir, id[block_id]);
+  printf("\t\t\tRegisterOffset: %016" PCI_U64_FMT_X "\n", (base_hi << 32ULL) | base_lo << 16);
+}
+
+static void
+dvsec_cxl_register_locator(uint8_t* data, int len, int rev)
+{
+  int i, j;
+
+  if (rev != 0)
+    return;
+
+  for (i = 0xc, j = 1; i < len; i += 8, j++) {
+    dvsec_decode_block(*(u32 *)(data + i), *(u32 *)(data + i + 4), j + 0x31);
+  }
+}
+
 static void
 cap_dvsec_cxl(struct device *d, int id, int where)
 {
+  u16 len;
   u8 rev;
 
   printf(": CXL\n");
@@ -824,6 +861,13 @@ cap_dvsec_cxl(struct device *d, int id, int where)
 
       dvsec_cxl_port(d->config + where, rev);
       break;
+    case 8:
+      len = BITS(get_conf_word(d, where + 0x6), 4, 12);
+      if (!config_fetch(d, where, len))
+        return;
+
+      dvsec_cxl_register_locator(d->config + where, len, rev);
+      break;
     default:
       break;
   }
-- 
2.31.1

