Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03C418B80
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfEIOPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfEIOPH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:07 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A8521479;
        Thu,  9 May 2019 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411307;
        bh=PPIcD3rVSMrCxILX0QXCxh8mpXZl7+htbG5v2DOUouk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBuO2pWfE37aHz4k6BXlZTHC7TFgiqac06CBdtDdysbbSuGbAXgvYe3qErfrAYSjm
         QfAq7Y1TbbjmSOQClwJ21JcXTy+XYbr2ituIniayDYKfH6jAhQh5Kd17oTrpW6kbaC
         PzTqHcdI61NnwPTT/kRY5M2+EUCaPoTqGJ1t4WDo=
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
Subject: [PATCH 01/10] PCI/AER: Replace dev_printk(KERN_DEBUG) with dev_info()
Date:   Thu,  9 May 2019 09:14:47 -0500
Message-Id: <20190509141456.223614-2-helgaas@kernel.org>
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

Also remove a redundant kzalloc() failure message.

Link: https://lore.kernel.org/lkml/20190503035946.23608-2-fred@fredlawl.com
Signed-off-by: Frederick Lawler <fred@fredlawl.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f8fc2114ad39..74f872e4e0cc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -964,8 +964,8 @@ static bool find_source_device(struct pci_dev *parent,
 	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
-			   e_info->id);
+		pci_info(parent, "can't find device of ID%04x\n",
+			 e_info->id);
 		return false;
 	}
 	return true;
@@ -1379,18 +1379,17 @@ static int aer_probe(struct pcie_device *dev)
 	struct device *device = &dev->device;
 
 	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
-	if (!rpc) {
-		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
+	if (!rpc)
 		return -ENOMEM;
-	}
+
 	rpc->rpd = dev->port;
 	set_service_data(dev, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
 					   IRQF_SHARED, "aerdrv", dev);
 	if (status) {
-		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
-			   dev->irq);
+		dev_err(device, "request AER IRQ %d failed\n",
+			dev->irq);
 		return status;
 	}
 
@@ -1419,7 +1418,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
 	rc = pci_bus_error_reset(dev);
-	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
+	pci_info(dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-- 
2.21.0.1020.gf2820cf01a-goog

