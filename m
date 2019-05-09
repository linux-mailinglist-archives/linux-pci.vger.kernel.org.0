Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3050518B81
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfEIOPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfEIOPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:09 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD262173B;
        Thu,  9 May 2019 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411308;
        bh=WIKCzbiln2ryVc0ZJl9EtTNS6DNS8zJk67eaHWlgcpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vds5aSwvcHZAlbJqICKIpaiqiXkLVscokxxFAlQ2x/U7+UD6nkoiG9MvQLFAXOBRL
         ddD3rHN0LkaI4QzcMNldxTMBzOcMyPmHIUne/9+uE9CscsPktDBTBYD12N7Jqyc430
         xqrRyZLlyUHk81vn7hwXgttC7slsBLrgsdZ+BiuA=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 02/10] PCI/PME: Replace dev_printk(KERN_DEBUG) with dev_info()
Date:   Thu,  9 May 2019 09:14:48 -0500
Message-Id: <20190509141456.223614-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
References: <20190509141456.223614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

Replace dev_printk(KERN_DEBUG) with dev_info() or dev_err() to be more
consistent with other logging.

These could be converted to dev_dbg(), but that depends on
CONFIG_DYNAMIC_DEBUG and DEBUG, and we want most of these messages to
*always* be in the dmesg log.

Also, use dev_fmt() to add the service name.  Example output change:

  - pcieport 0000:80:10.0: Signaling PME with IRQ ...
  + pcieport 0000:80:10.0: PME: Signaling with IRQ ...

Link: https://lore.kernel.org/lkml/20190503035946.23608-4-fred@fredlawl.com
Signed-off-by: Frederick Lawler <fred@fredlawl.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pme.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 54d593d10396..f38e6c19dd50 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  */
 
+#define dev_fmt(fmt) "PME: " fmt
+
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -194,14 +196,14 @@ static void pcie_pme_handle_request(struct pci_dev *port, u16 req_id)
 		 * assuming that the PME was reported by a PCIe-PCI bridge that
 		 * used devfn different from zero.
 		 */
-		pci_dbg(port, "PME interrupt generated for non-existent device %02x:%02x.%d\n",
-			busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		pci_info(port, "interrupt generated for non-existent device %02x:%02x.%d\n",
+			 busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
 		found = pcie_pme_from_pci_bridge(bus, 0);
 	}
 
  out:
 	if (!found)
-		pci_dbg(port, "Spurious native PME interrupt!\n");
+		pci_info(port, "Spurious native interrupt!\n");
 }
 
 /**
@@ -341,7 +343,7 @@ static int pcie_pme_probe(struct pcie_device *srv)
 		return ret;
 	}
 
-	pci_info(port, "Signaling PME with IRQ %d\n", srv->irq);
+	pci_info(port, "Signaling with IRQ %d\n", srv->irq);
 
 	pcie_pme_mark_devices(port);
 	pcie_pme_interrupt_enable(port, true);
-- 
2.21.0.1020.gf2820cf01a-goog

