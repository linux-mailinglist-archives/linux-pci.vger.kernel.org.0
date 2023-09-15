Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442E17A2316
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjIOP6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbjIOP61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 11:58:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646610D9;
        Fri, 15 Sep 2023 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694793502; x=1726329502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NbHznSzo9cAXWJrSxFdkec/xGu/0KxsGpf1kX0P/iv0=;
  b=NIDYjfdhtQjbYH7xdIniMywUKRIFlesNT+VfT2BCDMDTxUpTz0pc1uqJ
   vzntkmrRFTa+r/NCZn7tFbPE2qAMk+JLeMYg5GHzrT3sJzMHzSWNBAUxU
   qBiBXuGBXKvoC62Qm0Vz0OmAlUVkDHyOBFN1HeQCy1Ouy3xUNP4pwU9pn
   qLlvMW/gukJ47dzaplb3eqigfSsafCQ2hSd47PsRQ743AluGsP/eFwkc+
   keP/80xC33LXUH9zDhPc1Kh9r4Cu5zOujrsfod3UsWR2oGaqdKeW3zNGT
   8ipk2akUh+r8/fIAm6Y3Zb4U957vqVBKzIyV9wCCMDxyPSTjq3xnVQq5f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369594668"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369594668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745036707"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="745036707"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/7] PCI/ASPM: Convert printk() to pr_*() and add include
Date:   Fri, 15 Sep 2023 18:57:52 +0300
Message-Id: <20230915155752.84640-8-ilpo.jarvinen@linux.intel.com>
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

Convert printk(KERN_INFO ...) to pr_info() and add the correct include
for it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index fb25892d15b7..855feaefd7f4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 
@@ -1367,10 +1368,10 @@ static int __init pcie_aspm_disable(char *str)
 		aspm_policy = POLICY_DEFAULT;
 		aspm_disabled = 1;
 		aspm_support_enabled = false;
-		printk(KERN_INFO "PCIe ASPM is disabled\n");
+		pr_info("PCIe ASPM is disabled\n");
 	} else if (!strcmp(str, "force")) {
 		aspm_force = 1;
-		printk(KERN_INFO "PCIe ASPM is forcibly enabled\n");
+		pr_info("PCIe ASPM is forcibly enabled\n");
 	}
 	return 1;
 }
-- 
2.30.2

