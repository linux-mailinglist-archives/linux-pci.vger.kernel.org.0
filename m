Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0382AEEAF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 11:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKKKXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 05:23:43 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7882 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgKKKXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 05:23:43 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CWLRR4qgWz75W4;
        Wed, 11 Nov 2020 18:23:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Nov 2020 18:23:34 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.dom>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [RESEND PATCH] PCI: Factor functions of PCI function reset
Date:   Wed, 11 Nov 2020 18:22:03 +0800
Message-ID: <1605090123-14243-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previosly we use pci_probe_reset_function() to probe whehter a function
can be reset and use __pci_reset_function_locked() to perform a function
reset. These two functions have lots of common lines.

Factor the two functions and reduce the redundancy.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.c   | 61 ++++++++++++++++-------------------------------------
 drivers/pci/pci.h   |  2 +-
 drivers/pci/probe.c |  2 +-
 3 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e39c549..e3e5f0f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5006,9 +5006,11 @@ static void pci_dev_restore(struct pci_dev *dev)
 }

 /**
- * __pci_reset_function_locked - reset a PCI device function while holding
- * the @dev mutex lock.
+ * pci_probe_reset_function - check whether the device can be safely reset
+ *                            or reset a PCI device function while holding
+ *                            the @dev mutex lock.
  * @dev: PCI device to reset
+ * @probe: Probe or not whether the device can be reset.
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
@@ -5022,10 +5024,10 @@ static void pci_dev_restore(struct pci_dev *dev)
  * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
  * etc.
  *
- * Returns 0 if the device function was successfully reset or negative if the
- * device doesn't support resetting a single function.
+ * Returns 0 if the device function can be reset or was successfully reset.
+ * negative if the device doesn't support resetting a single function.
  */
-int __pci_reset_function_locked(struct pci_dev *dev)
+int pci_probe_reset_function(struct pci_dev *dev, int probe)
 {
 	int rc;

@@ -5039,61 +5041,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	 * other error, we're also finished: this indicates that further
 	 * reset mechanisms might be broken on the device.
 	 */
-	rc = pci_dev_specific_reset(dev, 0);
+	rc = pci_dev_specific_reset(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
 	if (pcie_has_flr(dev)) {
+		if (probe)
+			return 0;
 		rc = pcie_flr(dev);
 		if (rc != -ENOTTY)
 			return rc;
 	}
-	rc = pci_af_flr(dev, 0);
+	rc = pci_af_flr(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
-	rc = pci_pm_reset(dev, 0);
+	rc = pci_pm_reset(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
-	rc = pci_dev_reset_slot_function(dev, 0);
+	rc = pci_dev_reset_slot_function(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
-	return pci_parent_bus_reset(dev, 0);
+
+	return pci_parent_bus_reset(dev, probe);
 }
-EXPORT_SYMBOL_GPL(__pci_reset_function_locked);

-/**
- * pci_probe_reset_function - check whether the device can be safely reset
- * @dev: PCI device to reset
- *
- * Some devices allow an individual function to be reset without affecting
- * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
- *
- * Returns 0 if the device function can be reset or negative if the
- * device doesn't support resetting a single function.
- */
-int pci_probe_reset_function(struct pci_dev *dev)
+int __pci_reset_function_locked(struct pci_dev *dev)
 {
-	int rc;
-
-	might_sleep();
-
-	rc = pci_dev_specific_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	if (pcie_has_flr(dev))
-		return 0;
-	rc = pci_af_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-
-	return pci_parent_bus_reset(dev, 1);
+	return pci_probe_reset_function(dev, 0);
 }
+EXPORT_SYMBOL_GPL(__pci_reset_function_locked);

 /**
  * pci_reset_function - quiesce and reset a PCI device function
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7c..73740dd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -39,7 +39,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);

-int pci_probe_reset_function(struct pci_dev *dev);
+int pci_probe_reset_function(struct pci_dev *dev, int probe);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d3712..793cc8a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2403,7 +2403,7 @@ static void pci_init_capabilities(struct pci_dev *dev)

 	pcie_report_downtraining(dev);

-	if (pci_probe_reset_function(dev) == 0)
+	if (pci_probe_reset_function(dev, 1) == 0)
 		dev->reset_fn = 1;
 }

--
2.8.1

