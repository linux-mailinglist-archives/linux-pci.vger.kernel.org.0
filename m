Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC736489D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhDSQ5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 12:57:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2883 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSQ5E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 12:57:04 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FPCPn3PbXz6xj25;
        Tue, 20 Apr 2021 00:46:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 18:56:29 +0200
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 17:56:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Date:   Tue, 20 Apr 2021 00:54:49 +0800
Message-ID: <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduced in a PCI ECN [1], DOE provides a config space
based mailbox with standard protocol discovery.  Each mailbox
is accessed through a DOE Extended Capability.

A device may have 1 or more DOE mailboxes, each of which is allowed
to support any number of protocols (some DOE protocol
specifications apply additional restrictions).  A given protocol
may be supported on more than one DOE mailbox on a given function.

If a driver wishes to access any number of DOE instances / protocols
it makes a single call to pcie_doe_register_all() which will find
available DOEs, create the required infrastructure and cache the
protocols they support.  pcie_doe_find() can then retrieve a
pointer to an appropriate DOE instance.

A synchronous interface is provided in pcie_doe_exchange_sync() to
perform a single query / response exchange.

Testing conducted against QEMU using:

https://lore.kernel.org/qemu-devel/1612900760-7361-1-git-send-email-cbrowy@avery-design.com/
+ fix for interrupt flag mentioned in that thread and a whole load
of hacks to exercise error paths etc.

[1] https://members.pcisig.com/wg/PCI-SIG/document/14143
    Data Object Exchange (DOE) - Approved 12 March 2020

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Thanks to Bjorn Helgaas for reviewing v2.

Changes since v2:
* Move files and rename so as not to make them PCIe specific.
* Rename pretty much everything from pcie* to pci*.
* Editorial changes in patch description.
* Rename pcie_doe_sync() to pci_doe_exchange_sync() to add a verb.
  Note that I'm not happy with this naming, but have not come up
  with anything better. Suggestions welcome!
* Various white space, punctuation and similar changes as suggested
  by Bjorn.
* Consistent reporting of return values in kernel-doc.
* Use bitfields for Boolean elements of struct pci_doe.
* Change some labels so we don't have both a local variable and label
  abort.
* Add missing EXPORT_SYMBOL_GPL(pci_doe_exchange_sync) to allow use
  from modules.
* Consistenty use sizeof(u32) for DW size.

Thanks to Dan Williams for reviewing v1.
Note code has changed a lot, so I may well have missed stuff in this
log

Changes since v1:
Major stuff:
* Rework the registration of DOE. DOE instances are added to a list in
  the struct pci_dev. A single call to pcie_doe_register_all() finds
  all DOEs present on a device and caches which protocols they support.
  The lifetime of these can then all be managed alongside the
  struct pci_dev avoiding need for reference counting etc whilst allowing
  a driver not to care if different protocols are using the same DOE
  instance, or different ones. The driver issues a call to
  pcie_doe_find() to get a pointer to the first appropriate DOE.
  Note, a side effect of minimizing impact of this on struct pci_dev
  is that we can't build DOE support as a module.
* Instead of serializing on a mutex, move to a more complex state machine
  based scheme in which the DOE config space registers are only
  accessed from a single delayed work item. The state machine uses
  two states for normal operation, IDLE and WAITING. Two states also
  exist for ABORT to indicate if it was called in response to error,
  or at startup. Interrupts result in mod_delayed_work()
  to force an immediate check on the status register.
  Message queuing is implemented with a list of tasks and kicking
  the state machine work item as needed.
* Decide, inside the core DOE code, whether to poll based
  on if the MSI/MSIX interrupts are enabled and the DOE
  instance advertises an interrupt.
* Define a struct pcie_doe_exchange to encapsulate header info
  with payloads etc. Specific fields used for VID and protocol +
  lengths so the DOE header can be constructed inside the DOE
  functions rather than relying on callers to do that.
* Don't hide away devm_ stuff in calls that don't make it obvious.

Minor stuff:
* pcie_doe_init() and pcie_doe_register separation to cover the
  bits that can fail in register() and the bits that can't in init()
* Many typos
* Rename cap_offset field to cap
* Use new PCI_VENDOR_ID_PCI_SIG define to avoid open coding the
  value
* Add defines for timeouts etc.
* Missing EXPORT_SYMBOL_GPL() added to allow DOE access from
  modules.

 drivers/pci/Kconfig           |   8 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/doe.c             | 601 ++++++++++++++++++++++++++++++++++
 include/linux/pci-doe.h       |  85 +++++
 include/linux/pci.h           |   3 +
 include/uapi/linux/pci_regs.h |  29 +-
 6 files changed, 726 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..6dd48a1ad2a4 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -190,6 +190,14 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_DOE
+	bool
+	help
+	  This enables library support for the PCI Data Object Exchange
+	  capability. DOE provides a simple mailbox in PCI config space that is
+	  used by a number of different protocols.
+	  DOE is defined in the Data Object Exchange ECN to PCI 5.0.
+
 choice
 	prompt "PCI Express hierarchy optimization setting"
 	default PCIE_BUS_DEFAULT
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index d62c4ac4ae1b..1b61c1a1c232 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PCI_STUB)		+= pci-stub.o
 obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
+obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
 # Endpoint library must be initialized before its users
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
new file mode 100644
index 000000000000..fce16c78ff45
--- /dev/null
+++ b/drivers/pci/doe.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Object Exchange ECN
+ * https://members.pcisig.com/wg/PCI-SIG/document/14143
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/workqueue.h>
+
+#define PCI_DOE_PROTOCOL_DISCOVERY 0
+
+#define PCI_DOE_BUSY_MAX_RETRIES 16
+#define PCI_DOE_POLL_INTERVAL (HZ / 128)
+
+/* Timeout of 1 second from 6.xx.1 (Operation), ECN - Data Object Exchange */
+#define PCI_DOE_TIMEOUT HZ
+
+static irqreturn_t pci_doe_irq(int irq, void *data)
+{
+	struct pci_doe *doe = data;
+	struct pci_dev *pdev = doe->pdev;
+	u32 val;
+
+	pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
+		pci_write_config_dword(pdev, doe->cap + PCI_DOE_STATUS, val);
+		mod_delayed_work(system_wq, &doe->statemachine, 0);
+		return IRQ_HANDLED;
+	}
+	/* Leave the error case to be handled outside IRQ */
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+		mod_delayed_work(system_wq, &doe->statemachine, 0);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/*
+ * Only call when safe to directly access the DOE, either because no tasks yet
+ * queued, or called from doe_statemachine_work() which has exclusive access to
+ * the DOE config space.
+ */
+static void pci_doe_abort_start(struct pci_doe *doe)
+{
+	struct pci_dev *pdev = doe->pdev;
+
+	pci_write_config_dword(pdev, doe->cap + PCI_DOE_CTRL,
+			       PCI_DOE_CTRL_ABORT);
+
+	doe->timeout_jiffies = jiffies + HZ;
+	schedule_delayed_work(&doe->statemachine, HZ);
+}
+
+static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
+{
+	struct pci_dev *pdev = doe->pdev;
+	u32 val;
+	int i;
+
+	/*
+	 * Check the DOE busy bit is not set. If it is set, this could indicate
+	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
+	 * it is expected that firmware and OS will negotiate access rights via
+	 * an, as yet to be defined method.
+	 */
+	pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
+		return -EBUSY;
+
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
+		return -EIO;
+
+	/* Write DOE Header */
+	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, ex->vid) |
+		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, ex->protocol);
+	pci_write_config_dword(pdev, doe->cap + PCI_DOE_WRITE, val);
+	/* Length is 2 DW of header + length of payload in DW */
+	pci_write_config_dword(pdev, doe->cap + PCI_DOE_WRITE,
+			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
+					  2 + ex->request_pl_sz / sizeof(u32)));
+	for (i = 0; i < ex->request_pl_sz / sizeof(u32); i++)
+		pci_write_config_dword(pdev, doe->cap + PCI_DOE_WRITE,
+				       ex->request_pl[i]);
+
+	pci_write_config_dword(pdev, doe->cap + PCI_DOE_CTRL, PCI_DOE_CTRL_GO);
+	/* Request is sent - now wait for poll or IRQ */
+	return 0;
+}
+
+static int pci_doe_recv_resp(struct pci_doe *doe, struct pci_doe_exchange *ex)
+{
+	struct pci_dev *pdev = doe->pdev;
+	size_t length;
+	u32 val;
+	int i;
+
+	/* Read the first two dwords to get the length and protocol */
+	pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ, &val);
+	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != ex->vid) ||
+	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != ex->protocol)) {
+		pci_err(pdev,
+			"Expected [VID, Protocol] = [%x, %x], got [%x, %x]\n",
+			ex->vid, ex->protocol,
+			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
+			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
+		return -EIO;
+	}
+
+	pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);
+	pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ, &val);
+	pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);
+
+	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
+	if (length > SZ_1M)
+		return -EIO;
+
+	/* Read the rest of the response payload */
+	for (i = 0; i < min(length, ex->response_pl_sz / sizeof(u32)); i++) {
+		pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ,
+				      &ex->response_pl[i]);
+		pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);
+	}
+
+	/* Flush excess length */
+	for (; i < length; i++) {
+		pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ, &val);
+		pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);
+	}
+	/* Final error check to pick up on any since Data Object Ready */
+	pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
+		return -EIO;
+
+	return min(length, ex->response_pl_sz / sizeof(u32)) * sizeof(u32);
+}
+
+static void pci_doe_task_complete(void *private)
+{
+	complete(private);
+}
+
+/**
+ * struct pci_doe_task - description of a query / response task.
+ * @h: Head to add it to the list of outstanding tasks.
+ * @ex: The details of the task to be done.
+ * @rv: Return value.  Length of received response or error.
+ * @cb: Callback for completion of task.
+ * @private: Private data passed to callback on completion.
+ */
+struct pci_doe_task {
+	struct list_head h;
+	struct pci_doe_exchange *ex;
+	int rv;
+	void (*cb)(void *private);
+	void *private;
+};
+
+/**
+ * pci_doe_exchange_sync() - Send a request, then wait for and receive response.
+ * @doe: DOE mailbox state structure.
+ * @ex: Description of the buffers and Vendor ID + type used in this
+ *      request/response pair,
+ *
+ * Excess data will be discarded.
+ *
+ * RETURNS: payload in bytes on success, < 0 on error.
+ */
+int pci_doe_exchange_sync(struct pci_doe *doe, struct pci_doe_exchange *ex)
+{
+	struct pci_doe_task task;
+	DECLARE_COMPLETION_ONSTACK(c);
+	int only_task;
+
+	/* DOE requests must be a whole number of DW */
+	if (ex->request_pl_sz % sizeof(u32))
+		return -EINVAL;
+
+	task.ex = ex;
+	task.cb = pci_doe_task_complete;
+	task.private = &c;
+
+	mutex_lock(&doe->tasks_lock);
+	if (doe->dead) {
+		mutex_unlock(&doe->tasks_lock);
+		return -EIO;
+	}
+	only_task = list_empty(&doe->tasks);
+	list_add_tail(&task.h, &doe->tasks);
+	if (only_task)
+		schedule_delayed_work(&doe->statemachine, 0);
+	mutex_unlock(&doe->tasks_lock);
+	wait_for_completion(&c);
+
+	return task.rv;
+}
+EXPORT_SYMBOL_GPL(pci_doe_exchange_sync);
+
+static void doe_statemachine_work(struct work_struct *work)
+{
+	struct delayed_work *w = to_delayed_work(work);
+	struct pci_doe *doe = container_of(w, struct pci_doe, statemachine);
+	struct pci_dev *pdev = doe->pdev;
+	struct pci_doe_task *task;
+	bool abort;
+	u32 val;
+	int rc;
+
+	mutex_lock(&doe->tasks_lock);
+	task = list_first_entry_or_null(&doe->tasks, struct pci_doe_task, h);
+	abort = doe->abort;
+	doe->abort = false;
+	mutex_unlock(&doe->tasks_lock);
+
+	if (abort) {
+		/*
+		 * Currently only used during init - care needed if we want to
+		 * generally expose pci_doe_abort() as it would impact queries
+		 * in flight.
+		 */
+		WARN_ON(task);
+		doe->state = DOE_WAIT_ABORT;
+		pci_doe_abort_start(doe);
+		return;
+	}
+
+	switch (doe->state) {
+	case DOE_IDLE:
+		if (task == NULL)
+			return;
+
+		/* Nothing currently in flight so queue a task */
+		rc = pci_doe_send_req(doe, task->ex);
+		/*
+		 * The specification does not provide any guidance on how long
+		 * some other entity could keep the DOE busy, so try for 1
+		 * second then fail. Busy handling is best effort only, because
+		 * there is no way of avoiding racing against another user of
+		 * the DOE.
+		 */
+		if (rc == -EBUSY) {
+			doe->busy_retries++;
+			if (doe->busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
+				/* Long enough, fail this request */
+				doe->busy_retries = 0;
+				goto err_busy;
+			}
+			schedule_delayed_work(w, HZ / PCI_DOE_BUSY_MAX_RETRIES);
+			return;
+		}
+		if (rc)
+			goto err_abort;
+		doe->busy_retries = 0;
+
+		doe->state = DOE_WAIT_RESP;
+		doe->timeout_jiffies = jiffies + HZ;
+		/* Now poll or wait for IRQ with timeout */
+		if (doe->irq > 0)
+			schedule_delayed_work(w, PCI_DOE_TIMEOUT);
+		else
+			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
+		return;
+
+	case DOE_WAIT_RESP:
+		/* Not possible to get here with NULL task */
+		pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
+		if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+			rc = -EIO;
+			goto err_abort;
+		}
+
+		if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
+			/* If not yet at timeout reschedule otherwise abort */
+			if (time_after(jiffies, doe->timeout_jiffies)) {
+				rc = -ETIMEDOUT;
+				goto err_abort;
+			}
+			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
+			return;
+		}
+
+		rc  = pci_doe_recv_resp(doe, task->ex);
+		if (rc < 0)
+			goto err_abort;
+
+		doe->state = DOE_IDLE;
+
+		mutex_lock(&doe->tasks_lock);
+		list_del(&task->h);
+		if (!list_empty(&doe->tasks))
+			schedule_delayed_work(w, 0);
+		mutex_unlock(&doe->tasks_lock);
+
+		/* Set the return value to the length of received payload */
+		task->rv = rc;
+		task->cb(task->private);
+		return;
+
+	case DOE_WAIT_ABORT:
+	case DOE_WAIT_ABORT_ON_ERR:
+		pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
+
+		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
+		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
+			/* Back to normal state - carry on */
+			mutex_lock(&doe->tasks_lock);
+			if (!list_empty(&doe->tasks))
+				schedule_delayed_work(w, 0);
+			mutex_unlock(&doe->tasks_lock);
+
+			/*
+			 * For deliberately triggered abort, someone is
+			 * waiting.
+			 */
+			if (doe->state == DOE_WAIT_ABORT)
+				complete(&doe->abort_c);
+			doe->state = DOE_IDLE;
+
+			return;
+		}
+		if (time_after(jiffies, doe->timeout_jiffies)) {
+			struct pci_doe_task *t, *n;
+
+			/* We are dead - abort all queued tasks */
+			pci_err(pdev, "DOE ABORT timed out\n");
+			mutex_lock(&doe->tasks_lock);
+			doe->dead = true;
+			list_for_each_entry_safe(t, n, &doe->tasks, h) {
+				t->rv = -EIO;
+				t->cb(t->private);
+				list_del(&t->h);
+			}
+
+			mutex_unlock(&doe->tasks_lock);
+			if (doe->state == DOE_WAIT_ABORT)
+				complete(&doe->abort_c);
+		}
+		return;
+	}
+
+err_abort:
+	pci_doe_abort_start(doe);
+	doe->state = DOE_WAIT_ABORT_ON_ERR;
+err_busy:
+	mutex_lock(&doe->tasks_lock);
+	list_del(&task->h);
+	mutex_unlock(&doe->tasks_lock);
+
+	task->rv = rc;
+	task->cb(task->private);
+	/*
+	 * If we got here via err_busy, and the queue isn't empty then we need
+	 * to go again.
+	 */
+	if (doe->state == DOE_IDLE) {
+		mutex_lock(&doe->tasks_lock);
+		if (!list_empty(&doe->tasks))
+			schedule_delayed_work(w, 0);
+		mutex_unlock(&doe->tasks_lock);
+	}
+}
+
+static int pci_doe_discovery(struct pci_doe *doe, u8 *index, u16 *vid,
+			     u8 *protocol)
+{
+	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, *index);
+	u32 response_pl;
+	struct pci_doe_exchange ex = {
+		.vid = PCI_VENDOR_ID_PCI_SIG,
+		.protocol = PCI_DOE_PROTOCOL_DISCOVERY,
+		.request_pl = &request_pl,
+		.request_pl_sz = sizeof(request_pl),
+		.response_pl = &response_pl,
+		.response_pl_sz = sizeof(response_pl),
+	};
+	int ret;
+
+	ret = pci_doe_exchange_sync(doe, &ex);
+	if (ret < 0)
+		return ret;
+
+	if (ret != sizeof(response_pl))
+		return -EIO;
+
+	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
+	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL, response_pl);
+	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, response_pl);
+
+	return 0;
+}
+
+static int pci_doe_cache_protocols(struct pci_doe *doe)
+{
+	u8 index = 0;
+	int rc;
+
+	/* Discovery protocol must always be supported and must report itself */
+	doe->num_prots = 1;
+	doe->prots = kzalloc(sizeof(*doe->prots) * doe->num_prots, GFP_KERNEL);
+	if (doe->prots == NULL)
+		return -ENOMEM;
+
+	do {
+		struct pci_doe_prot *prot, *prot_new;
+
+		prot = &doe->prots[doe->num_prots - 1];
+		rc = pci_doe_discovery(doe, &index, &prot->vid, &prot->type);
+		if (rc)
+			goto err_free_prots;
+
+		if (index) {
+			prot_new = krealloc(doe->prots,
+					    sizeof(*doe->prots) * doe->num_prots,
+					    GFP_KERNEL);
+			if (prot_new == NULL) {
+				rc = -ENOMEM;
+				goto err_free_prots;
+			}
+			doe->prots = prot_new;
+			doe->num_prots++;
+		}
+	} while (index);
+
+	return 0;
+
+err_free_prots:
+	kfree(doe->prots);
+	return rc;
+}
+
+static void pci_doe_init(struct pci_doe *doe, struct pci_dev *pdev, int doe_offset)
+{
+	mutex_init(&doe->tasks_lock);
+	init_completion(&doe->abort_c);
+	doe->cap = doe_offset;
+	doe->pdev = pdev;
+	INIT_LIST_HEAD(&doe->tasks);
+	INIT_DELAYED_WORK(&doe->statemachine, doe_statemachine_work);
+}
+
+static int pci_doe_abort(struct pci_doe *doe)
+{
+	reinit_completion(&doe->abort_c);
+	mutex_lock(&doe->tasks_lock);
+	doe->abort = true;
+	mutex_unlock(&doe->tasks_lock);
+	schedule_delayed_work(&doe->statemachine, 0);
+	wait_for_completion(&doe->abort_c);
+
+	if (doe->dead)
+		return -EIO;
+
+	return 0;
+}
+
+static int pci_doe_register(struct pci_doe *doe)
+{
+	struct pci_dev *pdev = doe->pdev;
+	bool poll = !pci_dev_msi_enabled(pdev);
+	int rc, irq;
+	u32 val;
+
+	pci_read_config_dword(pdev, doe->cap + PCI_DOE_CAP, &val);
+
+	if (!poll && FIELD_GET(PCI_DOE_CAP_INT, val)) {
+		irq = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
+		if (irq < 0)
+			return irq;
+
+		rc = request_irq(irq, pci_doe_irq, 0, "DOE", doe);
+		if (rc)
+			return rc;
+
+		doe->irq = irq;
+		pci_write_config_dword(pdev, doe->cap + PCI_DOE_CTRL,
+				       FIELD_PREP(PCI_DOE_CTRL_INT_EN, 1));
+	}
+
+	/* Reset the mailbox by issuing an abort */
+	rc = pci_doe_abort(doe);
+	if (rc)
+		goto err_free_irqs;
+
+	return 0;
+
+err_free_irqs:
+	if (doe->irq > 0)
+		free_irq(doe->irq, doe);
+
+	return rc;
+}
+
+static void pci_doe_unregister(struct pci_doe *doe)
+{
+	if (doe->irq > 0)
+		free_irq(doe->irq, doe);
+}
+
+void pci_doe_unregister_all(struct pci_dev *pdev)
+{
+	struct pci_doe *doe, *next;
+
+	list_for_each_entry_safe(doe, next, &pdev->doe_list, h) {
+		/* First halt the state machine */
+		cancel_delayed_work_sync(&doe->statemachine);
+		kfree(doe->prots);
+		pci_doe_unregister(doe);
+		kfree(doe);
+	}
+}
+EXPORT_SYMBOL_GPL(pci_doe_unregister_all);
+
+/**
+ * pci_doe_register_all() - Find and register all DOE mailboxes.
+ * @pdev: PCI device whose DOE mailboxes we are finding.
+ *
+ * Will locate any DOE mailboxes present on the device and cache the protocols
+ * so that pci_doe_find() can be used to retrieve a suitable DOE instance.
+ *
+ * DOE mailboxes are available until pci_doe_unregister_all() is called.
+ *
+ * RETURNS: 0 on success, < 0 on error.
+ */
+int pci_doe_register_all(struct pci_dev *pdev)
+{
+	struct pci_doe *doe;
+	int pos = 0;
+	int rc;
+
+	INIT_LIST_HEAD(&pdev->doe_list);
+
+	/* Walk the DOE extended capabilities and add to per pci_dev list */
+	while (true) {
+		pos = pci_find_next_ext_capability(pdev, pos,
+						   PCI_EXT_CAP_ID_DOE);
+		if (!pos)
+			return 0;
+
+		doe = kzalloc(sizeof(*doe), GFP_KERNEL);
+		if (!doe) {
+			rc = -ENOMEM;
+			goto err_free_does;
+		}
+
+		pci_doe_init(doe, pdev, pos);
+		rc = pci_doe_register(doe);
+		if (rc) {
+			kfree(doe);
+			goto err_free_does;
+		}
+
+		rc = pci_doe_cache_protocols(doe);
+		if (rc) {
+			pci_doe_unregister(doe);
+			kfree(doe);
+			goto err_free_does;
+		}
+
+		list_add(&doe->h, &pdev->doe_list);
+	}
+
+err_free_does:
+	pci_doe_unregister_all(pdev);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pci_doe_register_all);
+
+/**
+ * pci_doe_find() - Find the first DOE instance that supports a given protocol.
+ * @pdev: Device on which to find the DOE instance.
+ * @vid: Vendor ID.
+ * @type: Specific protocol for this vendor.
+ *
+ * RETURNS: Pointer to DOE instance on success, NULL on no suitable instance
+ * available.
+ */
+struct pci_doe *pci_doe_find(struct pci_dev *pdev, u16 vid, u8 type)
+{
+	struct pci_doe *doe;
+	int i;
+
+	list_for_each_entry(doe, &pdev->doe_list, h) {
+		for (i = 0; i < doe->num_prots; i++)
+			if ((doe->prots[i].vid == vid) &&
+			    (doe->prots[i].type == type))
+				return doe;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pci_doe_find);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
new file mode 100644
index 000000000000..0307ed17d3ab
--- /dev/null
+++ b/include/linux/pci-doe.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Object Exchange was added to the PCI spec as an ECN to 5.0.
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#include <linux/completion.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+#ifndef LINUX_PCI_DOE_H
+#define LINUX_PCI_DOE_H
+
+struct pci_doe_prot {
+	u16 vid;
+	u8 type;
+};
+
+struct workqueue_struct;
+
+enum pci_doe_state {
+	DOE_IDLE,
+	DOE_WAIT_RESP,
+	DOE_WAIT_ABORT,
+	DOE_WAIT_ABORT_ON_ERR,
+};
+
+struct pci_doe_exchange {
+	u16 vid;
+	u8 protocol;
+	u32 *request_pl;
+	size_t request_pl_sz;
+	u32 *response_pl;
+	size_t response_pl_sz;
+};
+
+/**
+ * struct pci_doe - State to support use of DOE mailbox
+ * @cap: Config space offset to base of DOE capability.
+ * @pdev: PCI device that hosts this DOE.
+ * @abort_c: Completion used for initial abort handling.
+ * @irq: Interrupt used for signaling DOE ready or abort.
+ * @prots: Cache of identifiers for protocols supported.
+ * @num_prots: Size of prots cache.
+ * @h: Used for DOE instance lifetime management.
+ * @wq: Workqueue used to handle state machine and polling / timeouts.
+ * @tasks: List of task in flight + pending.
+ * @tasks_lock: Protect the tasks list.
+ * @statemachine: Work item for the DOE state machine.
+ * @state: Current state of this DOE.
+ * @timeout_jiffies: 1 second after GO set.
+ * @busy_retries: Count of retry attempts.
+ * @abort: Request a manual abort (e.g. on init).
+ * @dead: Used to mark a DOE for which an ABORT has timed out. Further messages
+ *        will immediately be aborted with error.
+ */
+struct pci_doe {
+	int cap;
+	struct pci_dev *pdev;
+	struct completion abort_c;
+	int irq;
+	struct pci_doe_prot *prots;
+	int num_prots;
+	struct list_head h;
+
+	struct workqueue_struct *wq;
+	struct list_head tasks;
+	struct mutex tasks_lock;
+	struct delayed_work statemachine;
+	enum pci_doe_state state;
+	unsigned long timeout_jiffies;
+	unsigned int busy_retries;
+	unsigned int abort:1;
+	unsigned int dead:1;
+};
+
+int pci_doe_register_all(struct pci_dev *pdev);
+void pci_doe_unregister_all(struct pci_dev *pdev);
+struct pci_doe *pci_doe_find(struct pci_dev *pdev, u16 vid, u8 type);
+
+int pci_doe_exchange_sync(struct pci_doe *doe, struct pci_doe_exchange *ex);
+
+#endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..ac7a18826096 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -332,6 +332,9 @@ struct pci_dev {
 #ifdef CONFIG_PCIEPORTBUS
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
 	struct pci_dev  *rcec;          /* Associated RCEC device */
+#endif
+#ifdef CONFIG_PCI_DOE
+	struct list_head doe_list;	/* Data Object Exchange mailboxes */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8235e7..b97df1d8bd19 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -730,7 +730,8 @@
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
+#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1092,4 +1093,30 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Data Object Exchange */
+#define PCI_DOE_CAP		0x04	/* DOE Capabilities Register */
+#define  PCI_DOE_CAP_INT			0x00000001  /* Interrupt Support */
+#define  PCI_DOE_CAP_IRQ			0x00000ffe  /* Interrupt Message Number */
+#define PCI_DOE_CTRL		0x08	/* DOE Control Register */
+#define  PCI_DOE_CTRL_ABORT			0x00000001  /* DOE Abort */
+#define  PCI_DOE_CTRL_INT_EN			0x00000002  /* DOE Interrupt Enable */
+#define  PCI_DOE_CTRL_GO			0x80000000  /* DOE Go */
+#define PCI_DOE_STATUS		0x0c	/* DOE Status Register */
+#define  PCI_DOE_STATUS_BUSY			0x00000001  /* DOE Busy */
+#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
+#define  PCI_DOE_STATUS_ERROR			0x00000004  /* DOE Error */
+#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
+#define PCI_DOE_WRITE		0x10	/* DOE Write Data Mailbox Register */
+#define PCI_DOE_READ		0x14	/* DOE Read Data Mailbox Register */
+
+/* DOE Data Object - note not actually registers */
+#define PCI_DOE_DATA_OBJECT_HEADER_1_VID	0x0000ffff
+#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE	0x00ff0000
+#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH	0x0003ffff
+
+#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX	0x000000ff
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID	0x0000ffff
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL	0x00ff0000
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX 0xff000000
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.27.0

