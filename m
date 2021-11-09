Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6459244B02C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 16:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbhKIPSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:18:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:21109 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236189AbhKIPSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 10:18:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="229923435"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="229923435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 07:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="545346270"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2021 07:16:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2B8CF18E; Tue,  9 Nov 2021 17:16:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI: probe: Use pci_find_vsec_capability() when looking for TBT devices
Date:   Tue,  9 Nov 2021 17:16:04 +0200
Message-Id: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the set_pcie_thunderbolt() opens code pci_find_vsec_capability().
Refactor the former to use the latter. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/probe.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 087d3658f75c..db5a0762da03 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1579,20 +1579,11 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 
 static void set_pcie_thunderbolt(struct pci_dev *dev)
 {
-	int vsec = 0;
-	u32 header;
+	u16 vsec;
 
-	while ((vsec = pci_find_next_ext_capability(dev, vsec,
-						    PCI_EXT_CAP_ID_VNDR))) {
-		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
-
-		/* Is the device part of a Thunderbolt controller? */
-		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
-		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT) {
-			dev->is_thunderbolt = 1;
-			return;
-		}
-	}
+	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
+	if (vsec)
+		dev->is_thunderbolt = 1;
 }
 
 static void set_pcie_untrusted(struct pci_dev *dev)
-- 
2.33.0

