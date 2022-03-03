Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A524CBF56
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 15:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiCCOBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 09:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiCCOBr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 09:01:47 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29710DB48B;
        Thu,  3 Mar 2022 06:00:59 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8Xfl3sdCz67xgR;
        Thu,  3 Mar 2022 21:59:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 15:00:58 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:00:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 04/14] PCI/DOE: Introduce pci_doe_create_doe_devices
Date:   Thu, 3 Mar 2022 13:58:55 +0000
Message-ID: <20220303135905.10420-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
References: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL and/or PCI devices can define DOE mailboxes.  Normally the kernel
will want to maintain control of all of these mailboxes.  However, under
a limited number of use cases users may want to allow user space access
to some of these mailboxes while the kernel retains control of the rest.
An example of this is for CXL Compliance Testing (see CXL 2.0 14.16.4
Compliance Mode DOE) which offers a mechanism to set different test
modes for a device.

Rather than re-invent the wheel the architecture creates auxiliary
devices for each DOE mailbox which can then be driven by a generic DOE
mailbox driver.  If access to an individual mailbox is required by user
space the driver for that mailbox can be unloaded and access handed to
user space.

Create the helper pci_doe_create_doe_devices() which iterates each DOE
mailbox found in the device and creates a DOE auxiliary device on the
auxiliary bus.  While doing so ensure that the auxiliary DOE driver
loads to drive that device.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/doe.c       | 123 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-doe.h |   3 +
 2 files changed, 126 insertions(+)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 4ff54bade8ec..1b2e69774ccf 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -383,6 +383,128 @@ static void pci_doe_task_complete(void *private)
 	complete(private);
 }
 
+static void pci_doe_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static DEFINE_IDA(pci_doe_adev_ida);
+
+static void pci_doe_dev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = container_of(dev,
+						struct auxiliary_device,
+						dev);
+	struct pci_doe_dev *doe_dev = container_of(adev, struct pci_doe_dev,
+						   adev);
+
+	ida_free(&pci_doe_adev_ida, adev->id);
+	kfree(doe_dev);
+}
+
+static void pci_doe_destroy_device(void *ad)
+{
+	auxiliary_device_delete(ad);
+	auxiliary_device_uninit(ad);
+}
+
+/**
+ * pci_doe_create_doe_devices - Create auxiliary DOE devices for all DOE
+ *                              mailboxes found
+ * @pci_dev: The PCI device to scan for DOE mailboxes
+ *
+ * There is no coresponding destroy of these devices.  This function associates
+ * the DOE auxiliary devices created with the pci_dev passed in.  That
+ * association is device managed (devm_*) such that the DOE auxiliary device
+ * lifetime is always greater than or equal to the lifetime of the pci_dev.
+ *
+ * RETURNS: 0 on success -ERRNO on failure.
+ */
+int pci_doe_create_doe_devices(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int irqs, rc;
+	u16 pos = 0;
+
+	/*
+	 * An implementation may support an unknown number of interrupts.
+	 * Assume that number is not that large and request them all.
+	 */
+	irqs = pci_msix_vec_count(pdev);
+	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
+	if (rc != irqs) {
+		/* No interrupt available - carry on */
+		pci_dbg(pdev, "No interrupts available for DOE\n");
+	} else {
+		/*
+		 * Enabling bus mastering is require for MSI/MSIx.  It could be
+		 * done later within the DOE initialization, but as it
+		 * potentially has other impacts keep it here when setting up
+		 * the IRQ's.
+		 */
+		pci_set_master(pdev);
+		rc = devm_add_action_or_reset(dev,
+					      pci_doe_free_irq_vectors,
+					      pdev);
+		if (rc)
+			return rc;
+	}
+
+	pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
+
+	while (pos > 0) {
+		struct auxiliary_device *adev;
+		struct pci_doe_dev *new_dev;
+		int id;
+
+		new_dev = kzalloc(sizeof(*new_dev), GFP_KERNEL);
+		if (!new_dev)
+			return -ENOMEM;
+
+		new_dev->pdev = pdev;
+		new_dev->cap_offset = pos;
+
+		/* Set up struct auxiliary_device */
+		adev = &new_dev->adev;
+		id = ida_alloc(&pci_doe_adev_ida, GFP_KERNEL);
+		if (id < 0) {
+			kfree(new_dev);
+			return -ENOMEM;
+		}
+
+		adev->id = id;
+		adev->name = DOE_DEV_NAME;
+		adev->dev.release = pci_doe_dev_release;
+		adev->dev.parent = dev;
+
+		if (auxiliary_device_init(adev)) {
+			pci_doe_dev_release(&adev->dev);
+			return -EIO;
+		}
+
+		if (auxiliary_device_add(adev)) {
+			auxiliary_device_uninit(adev);
+			return -EIO;
+		}
+
+		rc = devm_add_action_or_reset(dev, pci_doe_destroy_device, adev);
+		if (rc)
+			return rc;
+
+		if (device_attach(&adev->dev) != 1) {
+			dev_err(&adev->dev,
+				"Failed to attach a driver to DOE device %d\n",
+				adev->id);
+			return -ENODEV;
+		}
+
+		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_doe_create_doe_devices);
+
 /**
  * pci_doe_exchange_sync() - Send a request, then wait for and receive a
  *			     response
@@ -639,6 +761,7 @@ static void pci_doe_remove(struct auxiliary_device *aux_dev)
 }
 
 static const struct auxiliary_device_id pci_doe_auxiliary_id_table[] = {
+	{.name = "pci_doe.doe", },
 	{},
 };
 
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 2f52b31c6f32..9ae2e96a0211 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -13,6 +13,8 @@
 #ifndef LINUX_PCI_DOE_H
 #define LINUX_PCI_DOE_H
 
+#define DOE_DEV_NAME "doe"
+
 struct pci_doe_protocol {
 	u16 vid;
 	u8 type;
@@ -53,6 +55,7 @@ struct pci_doe_dev {
 };
 
 /* Library operations */
+int pci_doe_create_doe_devices(struct pci_dev *pdev);
 int pci_doe_exchange_sync(struct pci_doe_dev *doe_dev,
 				 struct pci_doe_exchange *ex);
 bool pci_doe_supports_prot(struct pci_doe_dev *doe_dev, u16 vid, u8 type);
-- 
2.32.0

