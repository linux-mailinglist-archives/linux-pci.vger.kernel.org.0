Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD694A57A3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiBAHUD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:20:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:26799 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbiBAHUA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643700000; x=1675236000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OVmLcvEvJfUeQzl0QQr1mtN2fgctxoFHFNhr9vQg56E=;
  b=g1TCGYnSHH+5q0hQprW/HFg7QpUASzhyk3S+U2bF6/mKHzCRAtR34cnu
   6qD3ZaI917oGHBBAKc+53DBrJwWXNjkoXtdhj6rQSy5URUq6PRxNoU25N
   CcYqbcr4hFO4yAWZXVhxq3nSAr4wCBnbdr3xNUByuPD01RpUmlDiTlzH0
   IPeVqVzauTitdEzafSX1CxoKZtIrt+tRce2xuHHEm5TGqOOPsbPpAsv78
   Ou20JJ5OB4a+17UCBNSCO8sMf+FQwv1z8b9W7Brjio/Pep7OvODi4KArG
   dWoEofjewv7VGsHyuw9Ezjy/XbDqWhVd+UNA7CmfKFpL+xZGSye70/Mti
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310942243"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="310942243"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676000452"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:58 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 04/10] PCI/DOE: Introduce pci_doe_create_doe_devices
Date:   Mon, 31 Jan 2022 23:19:46 -0800
Message-Id: <20220201071952.900068-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201071952.900068-1-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Changes from V5:
	Rebased to latest
	Split this off from the CXL specific patch.  This introduces the
	support in PCI and the CXL code can call it in a future patch.
	Remove soft dep from the cxl_pci code because use of the helper
		function ensures that the pci_doe driver is already
		loaded.
	From Jonathan and Bjorn
		Move DOE device creation to the PCI core via
			pci_doe_create_doe_devices() helper
		document need for pci_set_master()
	From Bjorn
		Reword commit message for clarity
		put DOE_DEV_NAME in this patch from the previous
		Remove '__' prefix
	From Jonathan
		remove CXL_ADDRSPACE_* defines

Changes from V4:
	Make this an Auxiliary Driver rather than library functions
	Split this out into it's own patch
	Base on the new cxl_dev_state structure

Changes from Ben
	s/CXL_DOE_DEV_NAME/DOE_DEV_NAME/
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
2.31.1

