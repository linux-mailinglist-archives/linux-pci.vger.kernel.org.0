Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C372A85AE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgKESGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 13:06:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:30197 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKESGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 13:06:50 -0500
IronPort-SDR: wbovFjzNNH+WyBZA7LQAAl122rRwzLh6P5ddc7kxRopL/tvc5JufX8ZUF8caZZYP/1ZDcLUF2N
 gKoVpOVwt3Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="168651704"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="168651704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 10:06:49 -0800
IronPort-SDR: TxdvLmJb7meR0XeBoC5g+PgJkpn6AENMe8P8XtSkC7QucRO6WSClaj/uTj/87kjzXHkIbLziye
 sd5cKdhlZr3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="326111687"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2020 10:06:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9EE0929A; Thu,  5 Nov 2020 20:06:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alberto.vignani@fastwebnet.it
Subject: [PATCH v1 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Date:   Thu,  5 Nov 2020 20:06:43 +0200
Message-Id: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pericom PCIe-USB adapter ambiguously advertises MSI, but documentation says
"The MSI Function is not implemented on this device." in the chapters 7.3.27,
7.3.29-7.3.31.

Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
Reported-by: alberto.vignani@fastwebnet.it
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/quirks.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f70692ac79c5..7df7ae50618c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5567,17 +5567,25 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
 
 /*
- * Device [12d8:0x400e] and [12d8:0x400f]
+ * Device 12d8:0x400e [OHCI] and 12d8:0x400f [EHCI]
+ *
  * These devices advertise PME# support in all power states but don't
  * reliably assert it.
+ *
+ * These devices ambiguously advertise MSI, but documentation (PI7C9X440SL.pdf)
+ * says "The MSI Function is not implemented on this device." in the chapters
+ * 7.3.27, 7.3.29-7.3.31.
  */
-static void pci_fixup_no_pme(struct pci_dev *dev)
+static void pci_fixup_no_msi_no_pme(struct pci_dev *dev)
 {
+	pci_info(dev, "The MSI Function is not implemented on this device, disabling it\n");
+	dev->no_msi = 1;
+
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

