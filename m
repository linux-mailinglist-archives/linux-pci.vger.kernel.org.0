Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7C6B5D39
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 16:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCKPMS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 10:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKPMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 10:12:14 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785878B30F;
        Sat, 11 Mar 2023 07:12:13 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 921D610189E10;
        Sat, 11 Mar 2023 16:12:11 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 66EFB601663B;
        Sat, 11 Mar 2023 16:12:11 +0100 (CET)
X-Mailbox-Line: From 40a6f973f72ef283d79dd55e7e6fddc7481199af Mon Sep 17 00:00:00 2001
Message-Id: <40a6f973f72ef283d79dd55e7e6fddc7481199af.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:12 +0100
Subject: [PATCH v4 12/17] PCI/DOE: Create mailboxes on device enumeration
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently a DOE instance cannot be shared by multiple drivers because
each driver creates its own pci_doe_mb struct for a given DOE instance.
For the same reason a DOE instance cannot be shared between the PCI core
and a driver.

Moreover, finding out which protocols a DOE instance supports requires
creating a pci_doe_mb for it.  If a device has multiple DOE instances,
a driver looking for a specific protocol may need to create a pci_doe_mb
for each of the device's DOE instances and then destroy those which
do not support the desired protocol.  That's obviously an inefficient
way to do things.

Overcome these issues by creating mailboxes in the PCI core on device
enumeration.

Provide a pci_find_doe_mailbox() API call to allow drivers to get a
pci_doe_mb for a given (pci_dev, vendor, protocol) triple.  This API is
modeled after pci_find_capability() and can later be amended with a
pci_find_next_doe_mailbox() call to iterate over all mailboxes of a
given pci_dev which support a specific protocol.

On removal, destroy the mailboxes in pci_destroy_dev(), after the driver
is unbound.  This allows drivers to use DOE in their ->remove() hook.

On surprise removal, cancel ongoing DOE exchanges and prevent new ones
from being scheduled.  Thereby ensure that a hot-removed device doesn't
needlessly wait for a running exchange to time out.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ming Li <ming4.li@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Changes v3 -> v4:
 * Amend commit message with additional justification for the commit
   (Alexey)

 drivers/pci/doe.c       | 73 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h       | 11 +++++++
 drivers/pci/probe.c     |  1 +
 drivers/pci/remove.c    |  1 +
 include/linux/pci-doe.h |  2 ++
 include/linux/pci.h     |  3 ++
 6 files changed, 91 insertions(+)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 7539e72db5cb..9c577f5b3878 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -20,6 +20,8 @@
 #include <linux/pci-doe.h>
 #include <linux/workqueue.h>
 
+#include "pci.h"
+
 #define PCI_DOE_PROTOCOL_DISCOVERY 0
 
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
@@ -658,3 +660,74 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 	return task.rv;
 }
 EXPORT_SYMBOL_GPL(pci_doe);
+
+/**
+ * pci_find_doe_mailbox() - Find Data Object Exchange mailbox
+ *
+ * @pdev: PCI device
+ * @vendor: Vendor ID
+ * @type: Data Object Type
+ *
+ * Find first DOE mailbox of a PCI device which supports the given protocol.
+ *
+ * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
+ */
+struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
+					u8 type)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb)
+		if (pci_doe_supports_prot(doe_mb, vendor, type))
+			return doe_mb;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pci_find_doe_mailbox);
+
+void pci_doe_init(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	u16 offset = 0;
+	int rc;
+
+	xa_init(&pdev->doe_mbs);
+
+	while ((offset = pci_find_next_ext_capability(pdev, offset,
+						      PCI_EXT_CAP_ID_DOE))) {
+		doe_mb = pci_doe_create_mb(pdev, offset);
+		if (IS_ERR(doe_mb)) {
+			pci_err(pdev, "[%x] failed to create mailbox: %ld\n",
+				offset, PTR_ERR(doe_mb));
+			continue;
+		}
+
+		rc = xa_insert(&pdev->doe_mbs, offset, doe_mb, GFP_KERNEL);
+		if (rc) {
+			pci_err(pdev, "[%x] failed to insert mailbox: %d\n",
+				offset, rc);
+			pci_doe_destroy_mb(doe_mb);
+		}
+	}
+}
+
+void pci_doe_destroy(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb)
+		pci_doe_destroy_mb(doe_mb);
+
+	xa_destroy(&pdev->doe_mbs);
+}
+
+void pci_doe_disconnected(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb)
+		pci_doe_cancel_tasks(doe_mb);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d2c08670a20e..815a4d2a41da 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -318,6 +318,16 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
+#ifdef CONFIG_PCI_DOE
+void pci_doe_init(struct pci_dev *pdev);
+void pci_doe_destroy(struct pci_dev *pdev);
+void pci_doe_disconnected(struct pci_dev *pdev);
+#else
+static inline void pci_doe_init(struct pci_dev *pdev) { }
+static inline void pci_doe_destroy(struct pci_dev *pdev) { }
+static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
@@ -354,6 +364,7 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
+	pci_doe_disconnected(dev);
 
 	return 0;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a3f68b6ba6ac..02d2bf80eedb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2479,6 +2479,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
+	pci_doe_init(dev);		/* Data Object Exchange */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 0145aef1b930..f25acf50879f 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -39,6 +39,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
 	pci_free_resources(dev);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 7f16749c6aa3..d6192ee0ac07 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -29,6 +29,8 @@ struct pci_doe_mb;
 
 struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
 bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
+struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
+					u8 type);
 
 int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 	    const void *request, size_t request_sz,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fafd8020c6d7..ddccff4fe97e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -511,6 +511,9 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_P2PDMA
 	struct pci_p2pdma __rcu *p2pdma;
+#endif
+#ifdef CONFIG_PCI_DOE
+	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
-- 
2.39.1

