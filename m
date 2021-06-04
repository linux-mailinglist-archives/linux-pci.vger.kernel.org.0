Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94FB39C022
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFDTHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:48564 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFDTHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:33 -0400
IronPort-SDR: CmsX79GpxVSyeMlYCK/sCr3EDu0FjoUXLqIUf+u1Bol0ZFcH7UGbWOK4/f39WokFrPWT/01Nj2
 ZsOTo9dG7sXw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513934"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
IronPort-SDR: ZU+5V4L68kbEnP2eDF0yqzS/neR0B0TCPFoQf1eYuDWJYHskWV87S12iQSpL10WqcTuEpHAG+9
 VPNrq52Wg8kg==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049108"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:45 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 2/9] cxl: Make id check more explicit
Date:   Fri,  4 Jun 2021 12:05:34 -0700
Message-Id: <20210604190541.175602-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604190541.175602-1-ben.widawsky@intel.com>
References: <20210604190541.175602-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently only type 0 DVSEC caps are handled. Moving this check will
allow more robust type handling in the future.

Should be no functional change.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 ls-ecaps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index edb4401..83ca93e 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -690,7 +690,7 @@ cap_rcec(struct device *d, int where)
 }
 
 static void
-cap_dvsec_cxl(struct device *d, int where)
+cap_dvsec_cxl(struct device *d, int id, int where)
 {
   u16 w;
 
@@ -698,6 +698,9 @@ cap_dvsec_cxl(struct device *d, int where)
   if (verbose < 2)
     return;
 
+  if (id != 0)
+    return;
+
   if (!config_fetch(d, where + PCI_CXL_CAP, 12))
     return;
 
@@ -734,8 +737,8 @@ cap_dvsec(struct device *d, int where)
   u16 id = get_conf_long(d, where + PCI_DVSEC_HEADER2);
 
   printf("Vendor=%04x ID=%04x Rev=%d Len=%d", vendor, id, rev, len);
-  if (vendor == PCI_DVSEC_VENDOR_ID_CXL && id == PCI_DVSEC_ID_CXL && len >= 16)
-    cap_dvsec_cxl(d, where);
+  if (vendor == PCI_DVSEC_VENDOR_ID_CXL && len >= 16)
+    cap_dvsec_cxl(d, id, where);
   else
     printf(" <?>\n");
 }
-- 
2.31.1

