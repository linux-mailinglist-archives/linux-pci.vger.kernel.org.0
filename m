Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55739C027
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFDTHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:48569 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230353AbhFDTHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:35 -0400
IronPort-SDR: G/KW68iix+rajNgDxU9sOuYD81qKk8dnUvKj/n1UTiPnw49X3/hjGVM8QJ8mUwRIuJNiW9ZyVn
 dzG7qV4S02eA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513937"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513937"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
IronPort-SDR: 8EfE01evzaYKIUR4wp2QqheqqhQEkl1n2ju9EQDPdg/PPjlQXF6mGumft1kKRnzoeWN6GHV8iT
 Mwpzq8X8hoXA==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049116"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 4/9] cxl: Rework caps to new function
Date:   Fri,  4 Jun 2021 12:05:36 -0700
Message-Id: <20210604190541.175602-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604190541.175602-1-ben.widawsky@intel.com>
References: <20210604190541.175602-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This will help upcoming caps

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 ls-ecaps.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index 2b3f0f9..c2a13d5 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -690,35 +690,49 @@ cap_rcec(struct device *d, int where)
 }
 
 static void
-cap_dvsec_cxl(struct device *d, int id, int where)
+dvsec_cxl_device(uint8_t *data, int rev)
 {
   u16 w;
 
-  printf(": CXL\n");
-  if (verbose < 2)
-    return;
-
-  if (id != 0)
-    return;
-
-  if (!config_fetch(d, where + PCI_CXL_CAP, 0x38 - 0xa))
+  /* Legacy 1.1 revs aren't handled */
+  if (rev != 1)
     return;
 
-  w = get_conf_word(d, where + PCI_CXL_CAP);
+  w = *(u16 *)(data + PCI_CXL_CAP);
   printf("\t\tCXLCap:\tCache%c IO%c Mem%c Mem HW Init%c HDMCount %d Viral%c\n",
     FLAG(w, PCI_CXL_CAP_CACHE), FLAG(w, PCI_CXL_CAP_IO), FLAG(w, PCI_CXL_CAP_MEM),
     FLAG(w, PCI_CXL_CAP_MEM_HWINIT), PCI_CXL_CAP_HDM_CNT(w), FLAG(w, PCI_CXL_CAP_VIRAL));
 
-  w = get_conf_word(d, where + PCI_CXL_CTRL);
+  w = *(u16 *)(data + PCI_CXL_CTRL);
   printf("\t\tCXLCtl:\tCache%c IO%c Mem%c Cache SF Cov %d Cache SF Gran %d Cache Clean%c Viral%c\n",
     FLAG(w, PCI_CXL_CTRL_CACHE), FLAG(w, PCI_CXL_CTRL_IO), FLAG(w, PCI_CXL_CTRL_MEM),
     PCI_CXL_CTRL_CACHE_SF_COV(w), PCI_CXL_CTRL_CACHE_SF_GRAN(w), FLAG(w, PCI_CXL_CTRL_CACHE_CLN),
     FLAG(w, PCI_CXL_CTRL_VIRAL));
 
-  w = get_conf_word(d, where + PCI_CXL_STATUS);
+  w = *(u16 *)(data + PCI_CXL_STATUS);
   printf("\t\tCXLSta:\tViral%c\n", FLAG(w, PCI_CXL_STATUS_VIRAL));
 }
 
+static void
+cap_dvsec_cxl(struct device *d, int id, int where)
+{
+  u8 rev;
+
+  printf(": CXL\n");
+  if (verbose < 2)
+    return;
+
+  if (id != 0)
+    return;
+
+  rev = BITS(get_conf_byte(d, where + 0x6), 0, 4);
+
+  if (!config_fetch(d, where, 0x38))
+    return;
+
+  dvsec_cxl_device(d->config + where, rev);
+}
+
 static void
 cap_dvsec(struct device *d, int where)
 {
-- 
2.31.1

