Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C791D7A2311
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjIOP6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbjIOP6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 11:58:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A5E78;
        Fri, 15 Sep 2023 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694793497; x=1726329497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6GukoGfg7uQUsmDNdAKAVCGBUPXsn/55pQhVaFv5Paw=;
  b=TrMK4+re/ce3dDkas1x0ieHkesjZ7k8Zs1FSYVsF83s3KAhH/u3pcl2b
   zZHi2v+ETSMzal3vSI/OfJYMIN4pJVQcM30LUqdM5QFj2vXZPsmHUMDCG
   bTKjyifrzixociEwK1YtVswuL7aT1Ttnlh1679zJ+7kcEO+R8cJ+JrCAr
   5Ea/5J6KlEEX3FvQ6mGRKCX3hyGw3vAhNRWFvaX7F0nbYv/mH3qqFPGDe
   VlcrQ+N0/xygWIt0tovNtEi+R8Z1LnME+aO6k8vvu+U1kzT+vG/301V6a
   TQ0XLoioSiefJrjT1TWGZ/WGebSuDlL+iF2Rqz7VLoNQh610vdLyeUr3V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369594655"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369594655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745036702"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="745036702"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/7] PCI/ASPM: Use FIELD_MAX() instead of literals
Date:   Fri, 15 Sep 2023 18:57:50 +0300
Message-Id: <20230915155752.84640-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915155752.84640-1-ilpo.jarvinen@linux.intel.com>
References: <20230915155752.84640-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert 0x3ff literals in encode_l12_threshold() to
FIELD_MAX(PCI_L1SS_CTL1_LTR_L12_TH_VALUE) that explains the purpose of
the literal.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 60135fc7281a..fac6c5a0be26 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -335,27 +335,27 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 	 * LTR_L1.2_THRESHOLD_Value ("value") is a 10-bit field with max
 	 * value of 0x3ff.
 	 */
-	if (threshold_ns <= 0x3ff * 1) {
+	if (threshold_ns <= 1 * FIELD_MAX(PCI_L1SS_CTL1_LTR_L12_TH_VALUE)) {
 		*scale = 0;		/* Value times 1ns */
 		*value = threshold_ns;
-	} else if (threshold_ns <= 0x3ff * 32) {
+	} else if (threshold_ns <= 32 * FIELD_MAX(PCI_L1SS_CTL1_LTR_L12_TH_VALUE)) {
 		*scale = 1;		/* Value times 32ns */
 		*value = roundup(threshold_ns, 32) / 32;
-	} else if (threshold_ns <= 0x3ff * 1024) {
+	} else if (threshold_ns <= 1024 * FIELD_MAX(PCI_L1SS_CTL1_LTR_L12_TH_VALUE)) {
 		*scale = 2;		/* Value times 1024ns */
 		*value = roundup(threshold_ns, 1024) / 1024;
-	} else if (threshold_ns <= 0x3ff * 32768) {
+	} else if (threshold_ns <= 32768 * FIELD_MAX(PCI_L1SS_CTL1_LTR_L12_TH_VALUE)) {
 		*scale = 3;		/* Value times 32768ns */
 		*value = roundup(threshold_ns, 32768) / 32768;
-	} else if (threshold_ns <= 0x3ff * 1048576) {
+	} else if (threshold_ns <= 1048576 * FIELD_MAX(PCI_L1SS_CTL1_LTR_L12_TH_VALUE)) {
 		*scale = 4;		/* Value times 1048576ns */
 		*value = roundup(threshold_ns, 1048576) / 1048576;
-	} else if (threshold_ns <= 0x3ff * (u64) 33554432) {
+	} else if (threshold_ns <= (u64)33554432 * FIELD_MAX(PCI_L1SS_CTL1_LTR_L12_TH_VALUE)) {
 		*scale = 5;		/* Value times 33554432ns */
 		*value = roundup(threshold_ns, 33554432) / 33554432;
 	} else {
 		*scale = 5;
-		*value = 0x3ff;		/* Max representable value */
+		*value = FIELD_MAX(PCI_L1SS_CTL1_LTR_L12_TH_VALUE);
 	}
 }
 
-- 
2.30.2

