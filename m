Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD38140D647
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhIPJfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 05:35:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37418 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235564AbhIPJfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 05:35:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18G9UWRD007640;
        Thu, 16 Sep 2021 05:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+6VRrgWvcDzoWIVMOU7FRi9UKUiv51pqBTQ3O4Zi9zo=;
 b=gx6b9NhxGISvhJUxYhjewp1kyI/QfsPH1ZvFHfnEJn4llU8HvX7FFbNRajWkQULywvSO
 rJ6mxCbSOfeS9YmEKvZar/qONuFiimnO3NcZZDcn5mMB5zORZGJPgu9yLmx8i2c0WynU
 GFMRZVWduGfEYnzEJRcVKFilCsHXL4rSZQ+Ycnp7lBlK9+azoR3iDxOd6202mgV3moNO
 jFmHJECBInkpBVHJvIph2cK8x3WJiHoiJpWyPSEjOpRcovnjqW6naQxdlL7AuqJG5pzM
 7brM2TLq4FPHxBcdGXeoA972jP/wwR/D7Xp3V9dJYBURKwtndippaoR6QMbXkZG/KWM+ wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b43bwg15y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:44 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18G9XhbH016323;
        Thu, 16 Sep 2021 05:33:43 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b43bwg15r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:43 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18G9WtTd031201;
        Thu, 16 Sep 2021 09:33:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3b0m3ag491-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 09:33:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18G9XcF637421520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 09:33:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F29E42049;
        Thu, 16 Sep 2021 09:33:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6CEA42047;
        Thu, 16 Sep 2021 09:33:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Sep 2021 09:33:37 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 2/4] s390/pci: implement reset_slot for hotplug slot
Date:   Thu, 16 Sep 2021 11:33:34 +0200
Message-Id: <20210916093336.2895602-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916093336.2895602-1-schnelle@linux.ibm.com>
References: <20210916093336.2895602-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: koGpHzvcZiN-Z49C1KVZa5AQaXEsCwnt
X-Proofpoint-ORIG-GUID: 590EiA5z8dX4jcdw7RArgq2Y2R07ENN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160050
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is done by adding a zpci_hot_reset_device() call which does a low
level reset of the PCI function without changing its higher level
function state. This way it can be used while the zPCI function is bound
to a driver and with DMA tables being controlled either through the
IOMMU or DMA APIs which is prohibited when using zpci_disable_device()
as that drop existing DMA translations.

As this reset, unlike a normal FLR, also calls zpci_clear_irq() we need
to implement arch_restore_msi_irqs() and make sure we re-enable IRQs for
the PCI function if they were previously disabled.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v1 -> v2:
- Adapted reset_slot() signature for upstream int to bool change

 arch/s390/include/asm/pci.h        |  1 +
 arch/s390/pci/pci.c                | 58 ++++++++++++++++++++++++++++++
 arch/s390/pci/pci_irq.c            |  9 +++++
 drivers/pci/hotplug/s390_pci_hpc.c | 24 +++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 5e6cba22a801..2a2ed165a270 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,6 +208,7 @@ int zpci_disable_device(struct zpci_dev *);
 int zpci_scan_configured_device(struct zpci_dev *zdev, u32 fh);
 int zpci_deconfigure_device(struct zpci_dev *zdev);
 
+int zpci_hot_reset_device(struct zpci_dev *zdev);
 int zpci_register_ioat(struct zpci_dev *, u8, u64, u64, u64);
 int zpci_unregister_ioat(struct zpci_dev *, u8);
 void zpci_remove_reserved_devices(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index af22778551c1..dce60f16e94a 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -723,6 +723,64 @@ int zpci_disable_device(struct zpci_dev *zdev)
 	return rc;
 }
 
+/**
+ * zpci_hot_reset_device - perform a reset of the given zPCI function
+ * @zdev: the slot which should be reset
+ *
+ * Performs a low level reset of the zPCI function. The reset is low level in
+ * the sense that the zPCI function can be reset without detaching it from the
+ * common PCI subsystem. The reset may be performed while under control of
+ * either DMA or IOMMU APIs in which case the existing DMA/IOMMU translation
+ * table is reinstated at the end of the reset.
+ *
+ * After the reset the functions internal state is reset to an initial state
+ * equivalent to its state during boot when first probing a driver.
+ * Consequently after reset the PCI function requires re-initialization via the
+ * common PCI code including re-enabling IRQs via pci_alloc_irq_vectors()
+ * and enabling the function via e.g.pci_enablde_device_flags().The caller
+ * must guard against concurrent reset attempts.
+ *
+ * In most cases this function should not be called directly but through
+ * pci_reset_function() or pci_reset_bus() which handle the save/restore and
+ * locking.
+ *
+ * Return: 0 on success and an error value otherwise
+ */
+int zpci_hot_reset_device(struct zpci_dev *zdev)
+{
+	int rc;
+
+	zpci_dbg(3, "rst fid:%x, fh:%x\n", zdev->fid, zdev->fh);
+	if (zdev_enabled(zdev)) {
+		/* Disables device access, DMAs and IRQs (reset state) */
+		rc = zpci_disable_device(zdev);
+		/*
+		 * Due to a z/VM vs LPAR inconsistency in the error state the
+		 * FH may indicate an enabled device but disable says the
+		 * device is already disabled don't treat it as an error here.
+		 */
+		if (rc == -EINVAL)
+			rc = 0;
+		if (rc)
+			return rc;
+	}
+
+	rc = zpci_enable_device(zdev);
+	if (rc)
+		return rc;
+
+	if (zdev->dma_table) {
+		rc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
+					(u64)zdev->dma_table);
+		if (rc)
+			return rc;
+	} else {
+		zpci_dma_init_device(zdev);
+	}
+
+	return 0;
+}
+
 /**
  * zpci_create_device() - Create a new zpci_dev and add it to the zbus
  * @fid: Function ID of the device to be created
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 3823e159bf74..954bb7a83124 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -387,6 +387,15 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
 }
 
+void arch_restore_msi_irqs(struct pci_dev *pdev)
+{
+	struct zpci_dev *zdev = to_zpci(pdev);
+
+	if (!zdev->irqs_registered)
+		zpci_set_irq(zdev);
+	default_restore_msi_irqs(pdev);
+}
+
 static struct airq_struct zpci_airq = {
 	.handler = zpci_floating_irq_handler,
 	.isc = PCI_ISC,
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index 014868752cd4..46a23180594c 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -57,6 +57,29 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 	return zpci_deconfigure_device(zdev);
 }
 
+static int reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
+{
+	struct zpci_dev *zdev = container_of(hotplug_slot, struct zpci_dev,
+					     hotplug_slot);
+
+	if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
+		return -EIO;
+	/*
+	 * We can't take the zdev->lock as reset_slot may be called during
+	 * probing and/or device removal which already happens under the
+	 * zdev->lock. Instead the user should use the higher level
+	 * pci_reset_function() or pci_bus_reset() which hold the PCI device
+	 * lock preventing concurrent removal. If not using these functions
+	 * holding the PCI device lock is required.
+	 */
+
+	/* As long as the function is configured we can reset */
+	if (probe)
+		return 0;
+
+	return zpci_hot_reset_device(zdev);
+}
+
 static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct zpci_dev *zdev = container_of(hotplug_slot, struct zpci_dev,
@@ -83,6 +106,7 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 static const struct hotplug_slot_ops s390_hotplug_slot_ops = {
 	.enable_slot =		enable_slot,
 	.disable_slot =		disable_slot,
+	.reset_slot =		reset_slot,
 	.get_power_status =	get_power_status,
 	.get_adapter_status =	get_adapter_status,
 };
-- 
2.25.1

