Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1145036F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 12:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhKOLcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 06:32:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:38921 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhKOLcC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 06:32:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="319633660"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="319633660"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:29:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="453992353"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2021 03:29:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 92FC722B; Mon, 15 Nov 2021 13:29:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v2 1/1] PCI: probe: Use pci_find_vsec_capability() when looking for TBT devices
Date:   Mon, 15 Nov 2021 13:29:02 +0200
Message-Id: <20211115112902.24033-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the set_pcie_thunderbolt() open codes pci_find_vsec_capability().
Refactor the former to use the latter. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
---
v2: preserved comment (Lukas), added tag (Krzysztof)
 drivers/pci/probe.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 087d3658f75c..496c8b8d903c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1579,20 +1579,12 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 
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
+	/* Is the device part of a Thunderbolt controller? */
+	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
+	if (vsec)
+		dev->is_thunderbolt = 1;
 }
 
 static void set_pcie_untrusted(struct pci_dev *dev)
-- 
2.33.0

