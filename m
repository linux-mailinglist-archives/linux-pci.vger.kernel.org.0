Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F4839C023
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFDTHf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:48564 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhFDTHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:33 -0400
IronPort-SDR: 9u38mVsjHPuAjHm6nafBo8QIfl+CkupI93rp4XGpXQit/pp5DFl/BI4AxT6zyShcTD95UsXSNy
 al71yLRIn33Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513931"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513931"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:45 -0700
IronPort-SDR: 7yIl4I0bHiaT4siA51rao5h+U0gnmmtvQ3xiLjB49ECa9dL0CcJDEnoQTBdtiiUH10oncfTRCd
 sYudfQoggMBg==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049101"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:45 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 1/9] cxl: Rename variable to match other code
Date:   Fri,  4 Jun 2021 12:05:33 -0700
Message-Id: <20210604190541.175602-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604190541.175602-1-ben.widawsky@intel.com>
References: <20210604190541.175602-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current variable is word sized, and so this makes the CXL code match
the rest of the code.
---
 ls-ecaps.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index 99c55ff..edb4401 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -692,7 +692,7 @@ cap_rcec(struct device *d, int where)
 static void
 cap_dvsec_cxl(struct device *d, int where)
 {
-  u16 l;
+  u16 w;
 
   printf(": CXL\n");
   if (verbose < 2)
@@ -701,19 +701,19 @@ cap_dvsec_cxl(struct device *d, int where)
   if (!config_fetch(d, where + PCI_CXL_CAP, 12))
     return;
 
-  l = get_conf_word(d, where + PCI_CXL_CAP);
+  w = get_conf_word(d, where + PCI_CXL_CAP);
   printf("\t\tCXLCap:\tCache%c IO%c Mem%c Mem HW Init%c HDMCount %d Viral%c\n",
-    FLAG(l, PCI_CXL_CAP_CACHE), FLAG(l, PCI_CXL_CAP_IO), FLAG(l, PCI_CXL_CAP_MEM),
-    FLAG(l, PCI_CXL_CAP_MEM_HWINIT), PCI_CXL_CAP_HDM_CNT(l), FLAG(l, PCI_CXL_CAP_VIRAL));
+    FLAG(w, PCI_CXL_CAP_CACHE), FLAG(w, PCI_CXL_CAP_IO), FLAG(w, PCI_CXL_CAP_MEM),
+    FLAG(w, PCI_CXL_CAP_MEM_HWINIT), PCI_CXL_CAP_HDM_CNT(w), FLAG(w, PCI_CXL_CAP_VIRAL));
 
-  l = get_conf_word(d, where + PCI_CXL_CTRL);
+  w = get_conf_word(d, where + PCI_CXL_CTRL);
   printf("\t\tCXLCtl:\tCache%c IO%c Mem%c Cache SF Cov %d Cache SF Gran %d Cache Clean%c Viral%c\n",
-    FLAG(l, PCI_CXL_CTRL_CACHE), FLAG(l, PCI_CXL_CTRL_IO), FLAG(l, PCI_CXL_CTRL_MEM),
-    PCI_CXL_CTRL_CACHE_SF_COV(l), PCI_CXL_CTRL_CACHE_SF_GRAN(l), FLAG(l, PCI_CXL_CTRL_CACHE_CLN),
-    FLAG(l, PCI_CXL_CTRL_VIRAL));
+    FLAG(w, PCI_CXL_CTRL_CACHE), FLAG(w, PCI_CXL_CTRL_IO), FLAG(w, PCI_CXL_CTRL_MEM),
+    PCI_CXL_CTRL_CACHE_SF_COV(w), PCI_CXL_CTRL_CACHE_SF_GRAN(w), FLAG(w, PCI_CXL_CTRL_CACHE_CLN),
+    FLAG(w, PCI_CXL_CTRL_VIRAL));
 
-  l = get_conf_word(d, where + PCI_CXL_STATUS);
-  printf("\t\tCXLSta:\tViral%c\n", FLAG(l, PCI_CXL_STATUS_VIRAL));
+  w = get_conf_word(d, where + PCI_CXL_STATUS);
+  printf("\t\tCXLSta:\tViral%c\n", FLAG(w, PCI_CXL_STATUS_VIRAL));
 }
 
 static void
-- 
2.31.1

