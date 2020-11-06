Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE752A93A0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 11:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKFKFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 05:05:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:9736 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFKFc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Nov 2020 05:05:32 -0500
IronPort-SDR: fJdjecHC8ANb13nG5ofLgXK+Dxvk+gXWQQMPk+fJFbTNKwcTFatuOXZFSWZr4O8nBhMN8bdHUf
 Ff7sVi/CXQOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="231155217"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="231155217"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 02:05:30 -0800
IronPort-SDR: HFA0Cx8Es6DEHA30ai0ln6LSYSTD4rx3dg9selNMwmVYVbfQBBwa2bi1F6ti1rEQhPoXisN+W9
 yWdZH5oFOQwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="306816676"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Nov 2020 02:05:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7C9E252; Fri,  6 Nov 2020 12:05:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alberto.vignani@fastwebnet.it
Subject: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Date:   Fri,  6 Nov 2020 12:05:25 +0200
Message-Id: <20201106100526.17726-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pericom PCIe-USB adapter advertises MSI, but documentation says
"The MSI Function is not implemented on this device." in the chapters
7.3.27, 7.3.29-7.3.31.

Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
Reported-by: alberto.vignani@fastwebnet.it
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped confusing word (David), added ifdeffery (Ben)
 drivers/pci/quirks.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f70692ac79c5..e66e0cc8f99b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5567,17 +5567,26 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
 
 /*
- * Device [12d8:0x400e] and [12d8:0x400f]
+ * Device 12d8:0x400e [OHCI] and 12d8:0x400f [EHCI]
+ *
  * These devices advertise PME# support in all power states but don't
  * reliably assert it.
+ *
+ * These devices advertise MSI, but documentation (PI7C9X440SL.pdf) says
+ * "The MSI Function is not implemented on this device." in the chapters
+ * 7.3.27, 7.3.29-7.3.31.
  */
-static void pci_fixup_no_pme(struct pci_dev *dev)
+static void pci_fixup_no_msi_no_pme(struct pci_dev *dev)
 {
+#ifdef CONFIG_PCI_MSI
+	pci_info(dev, "The MSI is not implemented on this device, disabling it\n");
+	dev->no_msi = 1;
+#endif
 	pci_info(dev, "PME# is unreliable, disabling it\n");
 	dev->pme_support = 0;
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_msi_no_pme);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_msi_no_pme);
 
 static void apex_pci_fixup_class(struct pci_dev *pdev)
 {
-- 
2.28.0

