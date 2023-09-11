Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1E79ACD7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbjIKVig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbjIKMPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:15:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D618CEB;
        Mon, 11 Sep 2023 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694434533; x=1725970533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUhBzeQfkRSLlRegZBQsKn8efuvEYSiJqgGwvHl8g+s=;
  b=NXTRS7zyG2DM3E6oFFvDou2aEXuYHHwhzwAcWj4aU5sExJcmxc7sH4k0
   nOLsNV+wjTuJFtYOoguM9AoiseAqvN059MOfijQCWnf3pt3Ug0aXpBwIV
   mqG3RoUMH+uvH09PLZa/V7KFgG23i45+IZVAttayKpR+SYkNi4pj7PRLx
   fnqRRpNqsnTLBbAnwkGoeoyS5xFD6YXOsJVZgmFOjGc4hhB2/asqrUluf
   gQUf2lNsmUGY1X1kQA+BcERzKYkvOhHYJRJ9XOQBh8aHePbzmQytuIFU2
   pOAc8DuMj5WXLo++mDrKk1ggaFbClDB4ktknUrZ0IfjnJoicoU66/vQ6W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381863570"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="381863570"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746383348"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="746383348"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/8] PCI: Use FIELD_GET() to extract Link Width
Date:   Mon, 11 Sep 2023 15:14:59 +0300
Message-Id: <20230911121501.21910-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use FIELD_GET() to extract PCIe Negotiated and Maximum Link Width fields
instead of custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 5 ++---
 drivers/pci/pci.c       | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d9eede2dbc0e..5a6241044c3c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -12,7 +12,7 @@
  * Modeled after usb's driverfs.c
  */
 
-
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -230,8 +230,7 @@ static ssize_t current_link_width_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sysfs_emit(buf, "%u\n",
-		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
+	return sysfs_emit(buf, "%u\n", FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat));
 }
 static DEVICE_ATTR_RO(current_link_width);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..a8adc34dc86f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -6257,8 +6258,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
-		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
-			PCI_EXP_LNKSTA_NLW_SHIFT;
+		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 
 		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
 
@@ -6330,7 +6330,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if (lnkcap)
-		return (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+		return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
 
 	return PCIE_LNK_WIDTH_UNKNOWN;
 }
-- 
2.30.2

