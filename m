Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2178708C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjHXNlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241399AbjHXNkr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:40:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBAC12C;
        Thu, 24 Aug 2023 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884445; x=1724420445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dhWVbX36GNW+hyT2stuqHURTJcwkPHy+42LeWoUySlo=;
  b=E3/uOuuAx6fR7Fet8QOJSQtjpphCeTSgNiE4dN6Sd3qNCh798NwGPfZx
   Ydh71tl9rGrV/WBI994u4W4dRWZF7jXx7uS00uiC9F5aITM/Tt+gVCLKT
   6xUUzF9eLfpR5NBYTjiuobI8Xr/TzYubh+VNztSmuWAeZ8cY1DUGpFR9i
   QsS6+YZdXdRQeNQbgQyfcrua9qwcY7x5bDgU5MzLBw+0EolCojO8rIAQv
   f972I1gPaMjPo+uLBayz+WKGdNt/OkRb/ueD38L88WZUD+fdWLFWc2sCU
   w4a38YZZ1jpJLirtX78Xp9MXtRxUgAY/aTunkEdDy0VgA7+iYQZ3j72d5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792161"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792161"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802539664"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802539664"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/14] MIPS: TXx9: Do PCI error checks on own line
Date:   Thu, 24 Aug 2023 16:28:20 +0300
Message-Id: <20230824132832.78705-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of if conditions with line splits, use the usual error handling
pattern with a separate variable to improve readability.

The second check can use reverse logic which reduces indentation level.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/txx9/generic/pci.c | 43 +++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index e98845543b77..5ae30b78d38d 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -51,6 +51,7 @@ int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
 	unsigned short vid;
 	int cap66 = -1;
 	u16 stat;
+	int ret;
 
 	/* It seems SLC90E66 needs some time after PCI reset... */
 	mdelay(80);
@@ -60,9 +61,9 @@ int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
 	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
 		if (PCI_FUNC(pci_devfn))
 			continue;
-		if (early_read_config_word(hose, top_bus, current_bus,
-					   pci_devfn, PCI_VENDOR_ID, &vid) !=
-		    PCIBIOS_SUCCESSFUL)
+		ret = early_read_config_word(hose, top_bus, current_bus,
+					     pci_devfn, PCI_VENDOR_ID, &vid);
+		if (ret != PCIBIOS_SUCCESSFUL)
 			continue;
 		if (vid == 0xffff)
 			continue;
@@ -343,26 +344,28 @@ static void tc35815_fixup(struct pci_dev *dev)
 
 static void final_fixup(struct pci_dev *dev)
 {
+	unsigned long timeout;
 	unsigned char bist;
+	int ret;
 
 	/* Do build-in self test */
-	if (pci_read_config_byte(dev, PCI_BIST, &bist) == PCIBIOS_SUCCESSFUL &&
-	    (bist & PCI_BIST_CAPABLE)) {
-		unsigned long timeout;
-		pci_set_power_state(dev, PCI_D0);
-		pr_info("PCI: %s BIST...", pci_name(dev));
-		pci_write_config_byte(dev, PCI_BIST, PCI_BIST_START);
-		timeout = jiffies + HZ * 2;	/* timeout after 2 sec */
-		do {
-			pci_read_config_byte(dev, PCI_BIST, &bist);
-			if (time_after(jiffies, timeout))
-				break;
-		} while (bist & PCI_BIST_START);
-		if (bist & (PCI_BIST_CODE_MASK | PCI_BIST_START))
-			pr_cont("failed. (0x%x)\n", bist);
-		else
-			pr_cont("OK.\n");
-	}
+	ret = pci_read_config_byte(dev, PCI_BIST, &bist);
+	if ((ret != PCIBIOS_SUCCESSFUL) || !(bist & PCI_BIST_CAPABLE))
+		return;
+
+	pci_set_power_state(dev, PCI_D0);
+	pr_info("PCI: %s BIST...", pci_name(dev));
+	pci_write_config_byte(dev, PCI_BIST, PCI_BIST_START);
+	timeout = jiffies + HZ * 2;	/* timeout after 2 sec */
+	do {
+		pci_read_config_byte(dev, PCI_BIST, &bist);
+		if (time_after(jiffies, timeout))
+			break;
+	} while (bist & PCI_BIST_START);
+	if (bist & (PCI_BIST_CODE_MASK | PCI_BIST_START))
+		pr_cont("failed. (0x%x)\n", bist);
+	else
+		pr_cont("OK.\n");
 }
 
 #ifdef CONFIG_TOSHIBA_FPCIB0
-- 
2.30.2

