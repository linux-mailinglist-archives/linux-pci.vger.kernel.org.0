Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A465118B82
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEIOQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfEIOPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:13 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8626F2173C;
        Thu,  9 May 2019 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411311;
        bh=4nwEVs4HpuVLEW1H4P+gCJQ+1ahy8T18SlcqTYAoWCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZdD4UIYnD6o9Sirz5PyUvkIA8NXrvBTCSDcy5QOKPBYh8Q3s2jyBGTir8WnCJhKF
         eYLZajPH3OSzDDq+XqjQwMHAaI9X91lvqm8aZzd7BpoCSkpXHRUXlEBOk6YchvJGcP
         X0DMHjLJ9Isvk3fgtZl9kS52eWXHcchCiiKYHGg8=
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
Subject: [PATCH 04/10] PCI/AER: Log messages with pci_dev, not pcie_device
Date:   Thu,  9 May 2019 09:14:50 -0500
Message-Id: <20190509141456.223614-5-helgaas@kernel.org>
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

Log messages with pci_dev, not pcie_device.  Factor out common message
prefixes with dev_fmt().

Example output change:

  - aer 0000:00:00.0:pci002: AER enabled with IRQ ...
  + pcieport 0000:00:00.0: AER: enabled with IRQ ...

Link: https://lore.kernel.org/lkml/20190503035946.23608-6-fred@fredlawl.com
Signed-off-by: Frederick Lawler <fred@fredlawl.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c        | 19 ++++++++++++-------
 drivers/pci/pcie/aer_inject.c | 22 ++++++++++++----------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 74f872e4e0cc..20a68e8546cc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -12,6 +12,9 @@
  *    Andrew Patterson <andrew.patterson@hp.com>
  */
 
+#define pr_fmt(fmt) "AER: " fmt
+#define dev_fmt pr_fmt
+
 #include <linux/cper.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
@@ -779,10 +782,11 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "AER: %s%s error received: %04x:%02x:%02x.%d\n",
-		info->multi_error_valid ? "Multiple " : "",
-		aer_error_severity_string[info->severity],
-		pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+		 info->multi_error_valid ? "Multiple " : "",
+		 aer_error_severity_string[info->severity],
+		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+		 PCI_FUNC(devfn));
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -1377,24 +1381,25 @@ static int aer_probe(struct pcie_device *dev)
 	int status;
 	struct aer_rpc *rpc;
 	struct device *device = &dev->device;
+	struct pci_dev *port = dev->port;
 
 	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc)
 		return -ENOMEM;
 
-	rpc->rpd = dev->port;
+	rpc->rpd = port;
 	set_service_data(dev, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
 					   IRQF_SHARED, "aerdrv", dev);
 	if (status) {
-		dev_err(device, "request AER IRQ %d failed\n",
+		pci_err(port, "request AER IRQ %d failed\n",
 			dev->irq);
 		return status;
 	}
 
 	aer_enable_rootport(rpc);
-	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
+	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
 }
 
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 95d4759664b3..b05f0d728be8 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -12,6 +12,8 @@
  *     Huang Ying <ying.huang@intel.com>
  */
 
+#define dev_fmt(fmt) "aer_inject: " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -332,14 +334,14 @@ static int aer_inject(struct aer_error_inj *einj)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev) {
-		pci_err(dev, "aer_inject: Root port not found\n");
+		pci_err(dev, "Root port not found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
 
 	pos_cap_err = dev->aer_cap;
 	if (!pos_cap_err) {
-		pci_err(dev, "aer_inject: Device doesn't support AER\n");
+		pci_err(dev, "Device doesn't support AER\n");
 		ret = -EPROTONOSUPPORT;
 		goto out_put;
 	}
@@ -350,7 +352,7 @@ static int aer_inject(struct aer_error_inj *einj)
 
 	rp_pos_cap_err = rpdev->aer_cap;
 	if (!rp_pos_cap_err) {
-		pci_err(rpdev, "aer_inject: Root port doesn't support AER\n");
+		pci_err(rpdev, "Root port doesn't support AER\n");
 		ret = -EPROTONOSUPPORT;
 		goto out_put;
 	}
@@ -398,14 +400,14 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!aer_mask_override && einj->cor_status &&
 	    !(einj->cor_status & ~cor_mask)) {
 		ret = -EINVAL;
-		pci_warn(dev, "aer_inject: The correctable error(s) is masked by device\n");
+		pci_warn(dev, "The correctable error(s) is masked by device\n");
 		spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 	if (!aer_mask_override && einj->uncor_status &&
 	    !(einj->uncor_status & ~uncor_mask)) {
 		ret = -EINVAL;
-		pci_warn(dev, "aer_inject: The uncorrectable error(s) is masked by device\n");
+		pci_warn(dev, "The uncorrectable error(s) is masked by device\n");
 		spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
@@ -460,19 +462,19 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (device) {
 		edev = to_pcie_device(device);
 		if (!get_service_data(edev)) {
-			dev_warn(&edev->device,
-				 "aer_inject: AER service is not initialized\n");
+			pci_warn(edev->port,
+				 "AER service is not initialized\n");
 			ret = -EPROTONOSUPPORT;
 			goto out_put;
 		}
-		dev_info(&edev->device,
-			 "aer_inject: Injecting errors %08x/%08x into device %s\n",
+		pci_info(edev->port,
+			 "Injecting errors %08x/%08x into device %s\n",
 			 einj->cor_status, einj->uncor_status, pci_name(dev));
 		local_irq_disable();
 		generic_handle_irq(edev->irq);
 		local_irq_enable();
 	} else {
-		pci_err(rpdev, "aer_inject: AER device not found\n");
+		pci_err(rpdev, "AER device not found\n");
 		ret = -ENODEV;
 	}
 out_put:
-- 
2.21.0.1020.gf2820cf01a-goog

