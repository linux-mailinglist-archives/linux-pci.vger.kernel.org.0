Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369D27A640A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjISM5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjISM5l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 08:57:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B1F4;
        Tue, 19 Sep 2023 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695128253; x=1726664253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGsBT0uuTDOMajlNgJ3siJtE8uolW3uxhY8d88dRxik=;
  b=T1G0/CXcHctM6ppj4iVgezGygY5YnnZMMdckACs8lpILcAzU0uDGoj/H
   TFeI41KPn48SLBal6NNUct5EvOrVoKQE16PWr/q19uZBX0FAaiZgSKJr1
   Ai4P2Y//wSJDWuVnlOepNovH2AUDICmUnrn8IXxdBVh6Iw++g3i2A2Gw6
   GqES6DG367XdVJknpg1LrLicnN00R6/b2+C4rusXfY7Ig9EQP3JGSLrO2
   2dXhGj+8uBjTxEzCJBF1IKbkWBEIG1tb8rR+upy0f9+h8rOx2YIyJ1Hyc
   tCUUrBQ/2FBfS0SmsZl+2+xwfcnjAqZEAqCS3r5BhkSCOlg+uLrZdKcUh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359324709"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="359324709"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746228856"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="746228856"
Received: from vdesserx-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.32.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 6/8] PCI: Use FIELD_GET() to extract Link Width
Date:   Tue, 19 Sep 2023 15:56:46 +0300
Message-Id: <20230919125648.1920-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
References: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
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

Use FIELD_GET() to extract PCIe Negotiated and Maximum Link Width fields
instead of custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

