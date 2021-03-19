Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD415341838
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 10:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCSJ2N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 05:28:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13642 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhCSJ1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 05:27:53 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1z5G1KCLzmZcM;
        Fri, 19 Mar 2021 17:25:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 17:27:41 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <kw@linux.com>, <linux-pci@vger.kernel.org>
CC:     <alex.williamson@redhat.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.dom>
Subject: [PATCH v2] PCI: Factor functions of PCI function reset
Date:   Fri, 19 Mar 2021 17:25:18 +0800
Message-ID: <1616145918-31356-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously we used pci_probe_reset_function() to probe whether a function
can be reset and use __pci_reset_function_locked() to perform a function
reset. These two functions have lots of common lines.

Factor the two functions and reduce the redundancy.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- reword the comments a bit(Krzysztof)
- fix typos in the commit(Bjorn)
Link: https://lore.kernel.org/linux-pci/1605090123-14243-1-git-send-email-yangyicong@hisilicon.com/

 drivers/pci/pci.c   | 62 ++++++++++++++++-------------------------------------
 drivers/pci/pci.h   |  2 +-
 drivers/pci/probe.c |  2 +-
 3 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a1721..254bbe9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5055,9 +5055,11 @@ static void pci_dev_restore(struct pci_dev *dev)
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
@@ -5071,10 +5073,11 @@ static void pci_dev_restore(struct pci_dev *dev)
  * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
  * etc.
  *
- * Returns 0 if the device function was successfully reset or negative if the
- * device doesn't support resetting a single function.
+ * Returns 0 if the device function can be reset or was successfully
+ * reset, otherwise negative if the device doesn't support resetting
+ * a single function.
  */
-int __pci_reset_function_locked(struct pci_dev *dev)
+int pci_probe_reset_function(struct pci_dev *dev, int probe)
 {
 	int rc;
 
@@ -5088,61 +5091,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
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
index ef7c466..f349d48 100644
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
index 953f15a..cc0c21d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2404,7 +2404,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 
-	if (pci_probe_reset_function(dev) == 0)
+	if (pci_probe_reset_function(dev, 1) == 0)
 		dev->reset_fn = 1;
 }
 
-- 
2.8.1

