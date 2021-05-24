Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF838E7EA
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhEXNoM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 09:44:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5684 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhEXNoJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 09:44:09 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpdcP4RpKz1BQb1;
        Mon, 24 May 2021 21:39:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 21:42:39 +0800
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 14:42:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, Fangjian <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 4/5] DONOTMERGE: PCI/DOE: Add per DOE chrdev for ioctl based access
Date:   Mon, 24 May 2021 21:39:37 +0800
Message-ID: <20210524133938.2815206-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is not safe to access DOE mailboxes directly from userspace at the same
time as the kernel may be accessing them. An implementation note in the
ECN suggest use of a lock for this purpose, but in general, mediation is
needed.  Here we provide that mediation by providing a simple IOCTL
interface allowing userspace to issue requests to the DOE and in a
synchronous fashion receive the response.

There is no sanity checking of the messages sent so this is not an
appropriate interface to expose to userspace, but may be of use to others.

Current discussions suggstion that we will instead implement protocol
specific interfaces where needed.  The first of these is the CDAT
interface.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/doe.c            | 188 +++++++++++++++++++++++++++++++++--
 drivers/pci/pci-driver.c     |   3 +-
 include/linux/pci-doe.h      |  13 +++
 include/uapi/linux/pci_doe.h |  32 ++++++
 4 files changed, 225 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 27514313ed6a..2d20f59e42c6 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -15,6 +15,10 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/pci_doe.h>
+
+/* Maximum number of DOE instances in the system */
+#define PCI_DOE_MAX_CNT 65536
 
 #define PCI_DOE_PROTOCOL_DISCOVERY 0
 
@@ -24,6 +28,10 @@
 /* Timeout of 1 second from 6.xx.1 (Operation), ECN - Data Object Exchange */
 #define PCI_DOE_TIMEOUT HZ
 
+static int pci_doe_major;
+static DEFINE_IDA(pci_doe_ida);
+static DECLARE_RWSEM(pci_doe_rwsem);
+
 static irqreturn_t pci_doe_irq(int irq, void *data)
 {
 	struct pci_doe *doe = data;
@@ -479,6 +487,126 @@ static int pci_doe_abort(struct pci_doe *doe)
 	return 0;
 }
 
+static void pci_doe_release(struct device *dev)
+{
+	struct pci_doe *doe = container_of(dev, struct pci_doe, dev);
+
+	ida_free(&pci_doe_ida, MINOR(doe->dev.devt));
+	kfree(doe);
+}
+
+static char *pci_doe_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
+			     kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "pcidoe/%s", dev_name(dev));
+}
+
+static const struct device_type pci_doe_type = {
+	.name = "pci_doe",
+	.release = pci_doe_release,
+	.devnode = pci_doe_devnode,
+};
+
+static long __pci_doe_ioctl(struct pci_doe *doe, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct pci_doe_uexchange __user *uex;
+	struct pci_doe_uexchange ex;
+	struct pci_doe_exchange exchange;
+	u32 *request_pl;
+	u32 *response_pl;
+	int ret;
+
+	if (cmd != PCI_DOE_EXCHANGE)
+		return -ENOTTY;
+
+	uex = (void __user *)arg;
+	if (copy_from_user(&ex, uex, sizeof(ex)))
+		return -EFAULT;
+
+	/* Cap size at something sensible */
+	request_pl = vmemdup_user(u64_to_user_ptr(ex.in.payload), ex.in.size);
+	if (!request_pl)
+		return -ENOMEM;
+
+	response_pl = kvzalloc(ex.out.size, GFP_KERNEL);
+	if (!response_pl) {
+		ret = -ENOMEM;
+		goto free_request;
+	}
+
+	exchange.vid = ex.vid;
+	exchange.protocol = ex.protocol;
+	exchange.request_pl = request_pl;
+	exchange.request_pl_sz = ex.in.size;
+	exchange.response_pl = response_pl;
+	exchange.response_pl_sz = ex.out.size;
+	ret = pci_doe_exchange_sync(doe, &exchange);
+	if (ret < 0)
+		goto free_response;
+	ret = 0;
+
+	if (copy_to_user(u64_to_user_ptr(ex.out.payload), response_pl, ex.out.size)) {
+		ret = -EFAULT;
+		goto free_response;
+	}
+
+	/* No useful value to return currently */
+	ex.retval = 0;
+	if (copy_to_user(uex, &ex, sizeof(ex))) {
+		ret = -EFAULT;
+		goto free_response;
+	}
+
+free_response:
+	kvfree(response_pl);
+free_request:
+	kvfree(request_pl);
+
+	return ret;
+}
+
+static long pci_doe_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct pci_doe *doe = file->private_data;
+	int rc = -ENXIO;
+
+	down_read(&pci_doe_rwsem);
+	if (!doe->going_down)
+		rc = __pci_doe_ioctl(doe, cmd, arg);
+	up_read(&pci_doe_rwsem);
+
+	return rc;
+}
+
+static int pci_doe_open(struct inode *inode, struct file *file)
+{
+	struct pci_doe *doe = container_of(inode->i_cdev, typeof(*doe), cdev);
+
+	get_device(&doe->dev);
+	file->private_data = doe;
+
+	return 0;
+}
+
+static int pci_doe_file_release(struct inode *inode, struct file *file)
+{
+	struct pci_doe *doe = container_of(inode->i_cdev, typeof(*doe), cdev);
+
+	put_device(&doe->dev);
+
+	return 0;
+}
+static const struct file_operations pci_doe_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = pci_doe_ioctl,
+	.open = pci_doe_open,
+	.release = pci_doe_file_release,
+	.compat_ioctl = compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
 static int pci_doe_register(struct pci_doe *doe)
 {
 	struct pci_dev *pdev = doe->pdev;
@@ -486,17 +614,35 @@ static int pci_doe_register(struct pci_doe *doe)
 	int rc, irq;
 	u32 val;
 
+	rc = ida_alloc_range(&pci_doe_ida, 0, PCI_DOE_MAX_CNT - 1, GFP_KERNEL);
+	if (rc < 0)
+		return rc;
+
+	device_initialize(&doe->dev);
+	doe->dev.parent = &pdev->dev;
+	doe->dev.devt = MKDEV(pci_doe_major, rc);
+	doe->dev.type = &pci_doe_type;
+	device_set_pm_not_required(&doe->dev);
+	rc = dev_set_name(&doe->dev, "doe[%s]_%x", dev_name(&pdev->dev), doe->cap);
+	if (rc)
+		goto err_put_device;
+
+	cdev_init(&doe->cdev, &pci_doe_fops);
+
 	pci_read_config_dword(pdev, doe->cap + PCI_DOE_CAP, &val);
 
 	if (!poll && FIELD_GET(PCI_DOE_CAP_INT, val)) {
-		irq = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
-		if (irq < 0)
-			return irq;
+		rc = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
+		if (rc < 0)
+			goto err_put_device;
+		irq = rc;
 
 		doe->irq_name = kasprintf(GFP_KERNEL, "DOE[%s]_%x",
 					  dev_name(&pdev->dev), doe->cap);
-		if (!doe->irq_name)
-			return -ENOMEM;
+		if (!doe->irq_name) {
+			rc = -ENOMEM;
+			goto err_put_device;
+		}
 
 		rc = request_irq(irq, pci_doe_irq, 0, doe->irq_name, doe);
 		if (rc)
@@ -512,6 +658,10 @@ static int pci_doe_register(struct pci_doe *doe)
 	if (rc)
 		goto err_free_irqs;
 
+	rc = cdev_device_add(&doe->cdev, &doe->dev);
+	if (rc)
+		goto err_free_irqs;
+
 	return 0;
 
 err_free_irqs:
@@ -519,15 +669,22 @@ static int pci_doe_register(struct pci_doe *doe)
 		free_irq(doe->irq, doe);
 err_free_name:
 	kfree(doe->irq_name);
+err_put_device:
+	put_device(&doe->dev);
 
 	return rc;
 }
 
 static void pci_doe_unregister(struct pci_doe *doe)
 {
+	cdev_device_del(&doe->cdev, &doe->dev);
+	down_write(&pci_doe_rwsem);
+	doe->going_down = 1;
+	up_write(&pci_doe_rwsem);
 	if (doe->irq > 0)
 		free_irq(doe->irq, doe);
 	kfree(doe->irq_name);
+	put_device(&doe->dev);
 }
 
 void pci_doe_unregister_all(struct pci_dev *pdev)
@@ -539,7 +696,6 @@ void pci_doe_unregister_all(struct pci_dev *pdev)
 		cancel_delayed_work_sync(&doe->statemachine);
 		kfree(doe->prots);
 		pci_doe_unregister(doe);
-		kfree(doe);
 	}
 }
 EXPORT_SYMBOL_GPL(pci_doe_unregister_all);
@@ -559,6 +715,7 @@ int pci_doe_register_all(struct pci_dev *pdev)
 {
 	struct pci_doe *doe;
 	int pos = 0;
+
 	int rc;
 
 	INIT_LIST_HEAD(&pdev->doe_list);
@@ -578,15 +735,12 @@ int pci_doe_register_all(struct pci_dev *pdev)
 
 		pci_doe_init(doe, pdev, pos);
 		rc = pci_doe_register(doe);
-		if (rc) {
-			kfree(doe);
+		if (rc)
 			goto err_free_does;
-		}
 
 		rc = pci_doe_cache_protocols(doe);
 		if (rc) {
 			pci_doe_unregister(doe);
-			kfree(doe);
 			goto err_free_does;
 		}
 
@@ -624,3 +778,17 @@ struct pci_doe *pci_doe_find(struct pci_dev *pdev, u16 vid, u8 type)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(pci_doe_find);
+
+int pci_doe_sys_init(void)
+{
+	dev_t devt;
+	int rc;
+
+	rc = alloc_chrdev_region(&devt, 0, PCI_DOE_MAX_CNT, "pcidoe");
+	if (rc)
+		return rc;
+	pci_doe_major = MAJOR(devt);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_doe_sys_init);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ec44a79e951a..e2077a2b866f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
+#include <linux/pci-doe.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -1655,6 +1656,6 @@ static int __init pci_driver_init(void)
 		return ret;
 #endif
 	dma_debug_add_bus(&pci_bus_type);
-	return 0;
+	return pci_doe_sys_init();
 }
 postcore_initcall(pci_driver_init);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index b2624e505458..bdc5f15f14ab 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -6,6 +6,7 @@
  *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
  */
 
+#include <linux/cdev.h>
 #include <linux/completion.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -56,8 +57,11 @@ struct pci_doe_exchange {
  * @abort: Request a manual abort (e.g. on init)
  * @dead: Used to mark a DOE for which an ABORT has timed out. Further messages
  *        will immediately be aborted with error
+ * @going_down: Mark DOE as removed
  */
 struct pci_doe {
+	struct device dev;
+	struct cdev cdev;
 	int cap;
 	struct pci_dev *pdev;
 	struct completion abort_c;
@@ -76,6 +80,7 @@ struct pci_doe {
 	unsigned int busy_retries;
 	unsigned int abort:1;
 	unsigned int dead:1;
+	unsigned int going_down:1;
 };
 
 int pci_doe_register_all(struct pci_dev *pdev);
@@ -84,4 +89,12 @@ struct pci_doe *pci_doe_find(struct pci_dev *pdev, u16 vid, u8 type);
 
 int pci_doe_exchange_sync(struct pci_doe *doe, struct pci_doe_exchange *ex);
 
+#ifdef CONFIG_PCI_DOE
+int pci_doe_sys_init(void);
+#else
+static inline int pci_doe_sys_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_PCI_DOE */
 #endif
diff --git a/include/uapi/linux/pci_doe.h b/include/uapi/linux/pci_doe.h
new file mode 100644
index 000000000000..d01a27561df7
--- /dev/null
+++ b/include/uapi/linux/pci_doe.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Userspace interface for safely accessing a PCI Data Exchange Object
+ * mailbox that has been registered by a driver.
+ */
+
+#ifndef LINUX_PCI_DOE_UAPI_H
+#define LINUX_PCI_DOE_UAPI_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct pci_doe_uexchange {
+	__u16 vid;
+	__u8 protocol;
+	__u8 rsvd;
+	__u32 retval;
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} in;
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} out;
+};
+
+#define PCI_DOE_EXCHANGE _IOWR(0xDA, 1, struct pci_doe_uexchange)
+
+#endif /* LINUX_PCI_DOE_UAPI_H */
-- 
2.19.1

