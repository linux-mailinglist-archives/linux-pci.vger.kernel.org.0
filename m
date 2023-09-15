Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3EF7A230F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbjIOP6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjIOP6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 11:58:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C610D9;
        Fri, 15 Sep 2023 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694793492; x=1726329492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oC+J51tGvN01jsQNJsaVvoKnBvB9vBS5Yv0KL0IOWys=;
  b=B3kJOAr3XSyI4Wieru29LTbHaM12uI63wHR1NMFu3gOb6jJiP8jvgi5M
   8ZvYSbjaH/LDOgcXXXz3z16/MAO6z+mOzwjQotduM+mum9HVh5LH2Zzzn
   nmVXj8BSSqqT3N9piWadqxMEVfyjY+G24apnubCgO75XINLZ+0DIXyZRz
   B2UyURsHYYG9EZCaKbQBDx0xqXnA1YCH2gW19kMM9lam1g85PUcfkqVZM
   860emiZZ1YjHJ0U+Pooktw55x0EHPdiCTGuf6u/x1KYzGJEzx1jAU0cri
   UylFAH54TitS37FaM61ljGr7VsDdEAUczlXPCr9yDMfRs8J0tmWB1Lxyy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369594629"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369594629"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745036695"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="745036695"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/7] PCI/ASPM: Return U32_MAX instead of bit magic construct
Date:   Fri, 15 Sep 2023 18:57:48 +0300
Message-Id: <20230915155752.84640-4-ilpo.jarvinen@linux.intel.com>
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

Instead of returning a bit obscure -1U, make code's intent of returning
the maximum representable value more obvious by returning U32_MAX.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 06f175d8dee5..4cd11ab27233 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -279,7 +280,7 @@ static u32 calc_l0s_latency(u32 lnkcap)
 static u32 calc_l0s_acceptable(u32 encoding)
 {
 	if (encoding == 0x7)
-		return -1U;
+		return U32_MAX;
 	return (64 << encoding);
 }
 
@@ -297,7 +298,7 @@ static u32 calc_l1_latency(u32 lnkcap)
 static u32 calc_l1_acceptable(u32 encoding)
 {
 	if (encoding == 0x7)
-		return -1U;
+		return U32_MAX;
 	return (1000 << encoding);
 }
 
-- 
2.30.2

