Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724C07A2313
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjIOP6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbjIOP6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 11:58:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45210CC;
        Fri, 15 Sep 2023 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694793494; x=1726329494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NhlkmvqwXXZH4QHEWc0JDmQFQmEU6+At1abVX2qhUbE=;
  b=gRXL6fm54nh32aZdL1QubRiPWDkaOQ+hqi23yuTTsdf8xzExkPdsDApz
   zuRINN5802a764vd+xnsv50kfXX61a0BMCRgUZlNXBuzizNYIQUp7ijux
   A/pHzpawDaYXxOr7dqvRKlrPY8WaoyR/dUuKMnTw5YENEuQMTF9WG+GTr
   mMN+qK5EIyBWw2fVyEzUx5F2BhUCbPws9S4P4SFx5YYNu1dCcOV86ahtV
   QJsI0564OpwlBxEF0JusAY2u8M95mtut48mJgWtc1IX2xmZOXq2lmG96r
   Sl7RlvqVwzG8ol7DrCcn7u5hIzz6kDnMBRpnTG7wMyt+jqC095umbH5Jo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369594644"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369594644"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745036699"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="745036699"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/7] PCI/ASPM: Use time constants
Date:   Fri, 15 Sep 2023 18:57:49 +0300
Message-Id: <20230915155752.84640-5-ilpo.jarvinen@linux.intel.com>
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

Use defined constants to convert between time units.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4cd11ab27233..60135fc7281a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -21,6 +21,8 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
+#include <linux/time.h>
+
 #include "../pci.h"
 
 #ifdef MODULE_PARAM_PREFIX
@@ -272,7 +274,7 @@ static u32 calc_l0s_latency(u32 lnkcap)
 	u32 encoding = FIELD_GET(PCI_EXP_LNKCAP_L0SEL, lnkcap);
 
 	if (encoding == 0x7)
-		return (5 * 1000);	/* > 4us */
+		return 5 * NSEC_PER_USEC;	/* > 4us */
 	return (64 << encoding);
 }
 
@@ -290,8 +292,8 @@ static u32 calc_l1_latency(u32 lnkcap)
 	u32 encoding = FIELD_GET(PCI_EXP_LNKCAP_L1EL, lnkcap);
 
 	if (encoding == 0x7)
-		return (65 * 1000);	/* > 64us */
-	return (1000 << encoding);
+		return 65 * NSEC_PER_USEC;	/* > 64us */
+	return NSEC_PER_USEC << encoding;
 }
 
 /* Convert L1 acceptable latency encoding to ns */
@@ -299,7 +301,7 @@ static u32 calc_l1_acceptable(u32 encoding)
 {
 	if (encoding == 0x7)
 		return U32_MAX;
-	return (1000 << encoding);
+	return NSEC_PER_USEC << encoding;
 }
 
 /* Convert L1SS T_pwr encoding to usec */
@@ -327,7 +329,7 @@ static u32 calc_l12_pwron(struct pci_dev *pdev, u32 scale, u32 val)
  */
 static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 {
-	u64 threshold_ns = (u64) threshold_us * 1000;
+	u64 threshold_ns = (u64)threshold_us * NSEC_PER_USEC;
 
 	/*
 	 * LTR_L1.2_THRESHOLD_Value ("value") is a 10-bit field with max
@@ -419,7 +421,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		if ((link->aspm_capable & ASPM_STATE_L1) &&
 		    (latency + l1_switch_latency > acceptable_l1))
 			link->aspm_capable &= ~ASPM_STATE_L1;
-		l1_switch_latency += 1000;
+		l1_switch_latency += NSEC_PER_USEC;
 
 		link = link->parent;
 	}
-- 
2.30.2

