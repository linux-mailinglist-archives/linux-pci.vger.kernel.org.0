Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BBC55DF40
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbiF1EPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 00:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243950AbiF1EPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 00:15:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE827FFB;
        Mon, 27 Jun 2022 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656389751; x=1687925751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFK2kpBoroq8ALVfEhAY3YKOOkMAJwjSRvseRajc0hI=;
  b=XAWNKq11NXxC6+dAKJxTtcm9hR3pvmY7qJifQwoHEVFB8Mxh1+b/a6Nm
   nEOHTtef0ArmGf7GqnpnvK22KVHNSi3dq9YgJzTozNb7iqC/Y5eQA2Hja
   KAIMTpi2a1XLweLff2yMKTV3y6QL+YhCq+dyzLTTc04FHSMleudHKiPv6
   HWpykytksvjMurxehZV52wGSYKSmy0NBMvNUQGNMwzcE8TUaLkufEL/yd
   0jsP2trCgXycK4YM1rYv753cO4Uzv9MbdoR0KcGmCxZWBNSBVGjsydyOy
   4UbXjY2G3j+5kYRSkfBvAo3o26Fjme374HdjuMbB58CYBIR6l979xY0KI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343317546"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343317546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:15:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="564929744"
Received: from nakedgex-mobl.amr.corp.intel.com (HELO localhost) ([10.255.3.161])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:15:46 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V12 3/9] PCI: Create PCIe library functions in support of DOE mailboxes.
Date:   Mon, 27 Jun 2022 21:15:21 -0700
Message-Id: <20220628041527.742333-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628041527.742333-1-ira.weiny@intel.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
mailbox with standard protocol discovery.  Each mailbox is accessed
through a DOE Extended Capability.

Each DOE mailbox must support the DOE discovery protocol in addition to
any number of additional protocols.

Define core PCIe functionality to manage a single PCIe DOE mailbox at a
defined config space offset.  Functionality includes iterating,
creating, query of supported protocol, and task submission.  Destruction
of the mailboxes is device managed.

If interrupts are desired, the interrupt number can be queried and
passed to the create function.  Passing a negative value disables
interrupts for that mailbox.  It is the caller's responsibility to ensure
enough interrupt vectors are allocated.

Cc: "Li, Ming" <ming4.li@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V11
	Bjorn: s/PCI/PCIe
		use dev_fmt
		move cap_offset in struct pci_doe_mb
		use break and return from a central place
		fix interrupt prints
		s/PCI_DOE_CAP_IRQ/PCI_DOE_CAP_INT_MSG_NUM
		s/irq_msg_num/int_msg_num
			when the value is not an irq but rather the
			interrupt message number for the DOE
		s/irq/IRQ in comments
		Clarify request and response payload size units
			In addition clarify the rv units Check for
			invalid response payload size (must be at least
			1 DW)
	Dan: s/EOPNOTSUPP/ENXIO/
		Add pci_doe_for_each_off to .clang-format
		use xarray for supported protocols
		s/pci_doe_create_mb/pcim_doe_create_mb/
			Remove pci_doe_destroy_mb

	Dan: Convert the statemachine to process tasks as work items
		Define pci_doe_write_ctrl()
		Introduce pci_doe_irq_enabled()
		issue a stand alone abort
			Don't go through the state machine for the abort.  Just
			poll/irq until the response comes back.
		Remove Wait Abort state
			A wait abort can just be triggered from outside and stop
			the state machine from whatever loop it may be in.
			Let the state machine issue the abort itself and wait
			for it to return or not.
		Remove Wait abort on error
			Issue the abort directly before returning.  Abort
			failure will flag the MB dead.
		Remove workqueue processing from state machine
		clean up function locations in the file
		Move abort flag/document it
			React to an abort while aborting and bail.  This will
			mark the mailbox dead.
		Convert task to a work item
			Create a workqueue in the mailbox.  Remove cur_task and
			locking.  Set DEAD when taking mailbox down.
		print error on marking mailbox dead
		Introduce signal_task_abort
		flatten out the state machine

Changes from V9
	Lukas Wunner
		Update comments
		Move private doe structures and defines from pci-doe.h to doe.c
		check Data Obj Ready prior to last ack
	Davidlohr
		make task_lock a spinlock
	Lukas/Jonathan
		Remove special case of error in irq handler
	Fix potential race with the scheduling of a task when one is ending.
		The current task can't be retired until the state
		machine is idle.  Otherwise a new task work item may run
		and the state machine would be out of sync.

Changes from V8
	Remove Bjorn's ack
	Expose a function to find the irq number for a mailbox based on
	offset.  This is the code Jonathan proposed for finding the irq
	number here:
	https://lore.kernel.org/linux-cxl/20220503153449.4088-2-Jonathan.Cameron@huawei.com/
		This removes funky bool parameter to create.
	Move pci_set_master() within the pci_doe_enable_irq()
	Per Bjorn
		Clean up commit messages
		move pci-doe.c to doe.c
		Clean up PCI spec references
		Ensure all messages use pci_*()
		Add offset to error messages to distinguish mailboxes
			use hex for DOE offsets
		Print 4 nibbles for Vendor ID and 2 for type.
		s/irq/IRQ in comments
		Fix long lines
		Fix typos

Changes from V7
	Add a Kconfig for this functionality
	Fix bug in pci_doe_supports_prot()
	Rebased on cxl-pending

Changes from V6
	Clean up signed off by lines
	Make this functionality all PCI library functions
	Clean up header files
	s/pci_doe_irq/pci_doe_irq_handler
	Use pci_{request,free}_irq
		Remove irq_name (maintained by pci_request_irq)
	Fix checks to use an irq
	Consistently use u16 for cap_offset
	Cleanup kdocs and comments
	Create a helper retire_cur_task() to handle locking of the
		current task pointer.
	Remove devm_ calls from PCI layer.
		The devm_ calls do not allow for the pci_doe_mb objects
		to be tied to an auxiliary device.  Leave it to the
		caller to use devm_ if desired.
	From Dan Williams
		s/cb/end_task/; Pass pci_doe_task to end_task
		Clarify exchange/task/request/response.
			Merge pci_doe_task and pci_doe_exchange into
			pci_doe_task which represents a single
			request/response task for the state machine to
			process.
		Simplify submitting work to the mailbox
			Replace pci_doe_exchange_sync() with
			pci_doe_submit_task() Consumers of the mailbox
			are now responsible for setting up callbacks
			within a task object and submitting them to the
			mailbox to be processed.
		Remove WARN_ON when task != NULL and be sure to abort that task.
		Convert abort/dead to atomic flags
		s/state_lock/task_lock to better define what the lock is
			protecting
		Remove all the auxiliary bus code from the PCI layer
			The PCI layer provides helpers to use the DOE
			Mailboxes.  Each subsystem can then use the
			helpers as they see fit.  The CXL layer in this
			series uses aux devices to manage the new
			pci_doe_mb objects.

	From Bjorn
		Clarify the fact that DOE mailboxes are capabilities of
			the device.
		Code clean ups
		Cleanup Makefile
		Update references to PCI SIG spec v6.0
		Move this attribution here:
		This code is based on Jonathan's V4 series here:
		https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com/

Changes from V5
	From Bjorn
		s/pci_WARN/pci_warn
			Add timeout period to print
		Trim to 80 chars
		Use Tabs for DOE define spacing
		Use %#x for clarity
	From Jonathan
		Addresses concerns about the order of unwinding stuff
		s/doe/doe_dev in pci_doe_exhcnage_sync
		Correct kernel Doc comment
		Move pci_doe_task_complete() down in the file.
		Rework pci_doe_irq()
			process STATUS_ERROR first
			Return IRQ_NONE if the irq is not processed
			Use PCI_DOE_STATUS_INT_STATUS explicitly to
				clear the irq
	Clean up goto label s/err_free_irqs/err_free_irq
	use devm_kzalloc for doe struct
	clean up error paths in pci_doe_probe
	s/pci_doe_drv/pci_doe
	remove include mutex.h
	remove device name and define, move it in the next patch which uses it
	use devm_kasprintf() for irq_name
	use devm_request_irq()
	remove pci_doe_unregister()
		[get/put]_device() were unneeded and with the use of
		devm_* this function can be removed completely.
	refactor pci_doe_register and s/pci_doe_register/pci_doe_reg_irq
		make this function just a registration of the irq and
		move pci_doe_abort() into pci_doe_probe()
	use devm_* to allocate the protocol array

Changes from Jonathan's V4
	Move the DOE MB code into the DOE auxiliary driver
	Remove Task List in favor of a wait queue

Changes from Ben
	remove CXL references
	propagate rc from pci functions on error
---
 .clang-format                 |   1 +
 drivers/pci/Kconfig           |   3 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/doe.c             | 689 ++++++++++++++++++++++++++++++++++
 include/linux/pci-doe.h       |  81 ++++
 include/uapi/linux/pci_regs.h |  29 +-
 6 files changed, 803 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-doe.h

diff --git a/.clang-format b/.clang-format
index fa959436bcfd..7bebb066f2a2 100644
--- a/.clang-format
+++ b/.clang-format
@@ -420,6 +420,7 @@ ForEachMacros:
   - 'of_property_for_each_string'
   - 'of_property_for_each_u32'
   - 'pci_bus_for_each_resource'
+  - 'pci_doe_for_each_off'
   - 'pcl_for_each_chunk'
   - 'pcl_for_each_segment'
   - 'pcm_for_each_format'
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 133c73207782..b2f2e588a817 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_DOE
+	bool
+
 config PCI_ECAM
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 0da6b1ebc694..2680e4c92f0a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
+obj-$(CONFIG_PCI_DOE)		+= doe.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
new file mode 100644
index 000000000000..4a7a1e988124
--- /dev/null
+++ b/drivers/pci/doe.c
@@ -0,0 +1,689 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Object Exchange
+ *	PCIe r6.0, sec 6.30 DOE
+ *
+ * Copyright (C) 2021 Huawei
+ *	Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022 Intel Corporation
+ *	Ira Weiny <ira.weiny@intel.com>
+ */
+
+#define dev_fmt(fmt) "DOE: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
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
+/* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
+#define PCI_DOE_TIMEOUT HZ
+
+#define PCI_DOE_FLAG_ABORT	0
+#define PCI_DOE_FLAG_IRQ	1
+#define PCI_DOE_FLAG_DEAD	2
+
+/**
+ * struct pci_doe_mb - State for a single DOE mailbox
+ *
+ * This state is used to manage a single DOE mailbox capability.  All fields
+ * should be considered opaque to the consumers and the structure passed into
+ * the helpers below after being created by devm_pci_doe_create()
+ *
+ * @pdev: PCI device this mailbox belongs to
+ * @cap_offset: Capability offset
+ * @int_msg_num: DOE Interrupt Message Number; negative if irqs are not used
+ * @prots: Array of protocols supported (encoded as long values)
+ * @wq: Wait queue for work items awaiting irq/abort
+ * @work_queue: Queue of pci_doe_work items
+ * @flags: Bit array of PCI_DOE_FLAG_* flags
+ *
+ * Note: @prots can't be allocated with struct size because the number of
+ * protocols is not known until after this structure is in use.  However, the
+ * single discovery protocol is always required to query for the number of
+ * protocols.
+ */
+struct pci_doe_mb {
+	struct pci_dev *pdev;
+	u16 cap_offset;
+	int int_msg_num;
+	struct xarray prots;
+
+	wait_queue_head_t wq;
+	struct workqueue_struct *work_queue;
+	unsigned long flags;
+};
+
+static irqreturn_t pci_doe_irq_handler(int irq, void *data)
+{
+	struct pci_doe_mb *doe_mb = data;
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	u32 val;
+
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
+		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
+					PCI_DOE_STATUS_INT_STATUS);
+		set_bit(PCI_DOE_FLAG_IRQ, &doe_mb->flags);
+		wake_up(&doe_mb->wq);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static bool pci_doe_irq_enabled(struct pci_doe_mb *doe_mb)
+{
+	return doe_mb->int_msg_num >= 0;
+}
+
+static void pci_doe_abort(struct pci_doe_mb *doe_mb)
+{
+	set_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags);
+	wake_up(&doe_mb->wq);
+}
+
+/*
+ * Returned from the wait functions to indicate that an abort has been issued
+ */
+#define DOE_WAIT_ABORT 1
+
+static int pci_doe_arm_wait(struct pci_doe_mb *doe_mb)
+{
+	if (test_and_clear_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags))
+		return DOE_WAIT_ABORT;
+	clear_bit(PCI_DOE_FLAG_IRQ, &doe_mb->flags);
+	return 0;
+}
+
+static int pci_doe_wait_poll(struct pci_doe_mb *doe_mb, unsigned long timeout)
+{
+	if (wait_event_timeout(doe_mb->wq,
+			       test_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags),
+			       timeout))
+		return DOE_WAIT_ABORT;
+	return 0;
+}
+
+static int pci_doe_wait_irq_or_poll(struct pci_doe_mb *doe_mb)
+{
+	if (pci_doe_irq_enabled(doe_mb)) {
+		wait_event_timeout(doe_mb->wq,
+				   test_bit(PCI_DOE_FLAG_IRQ, &doe_mb->flags) ||
+				   test_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags),
+				   PCI_DOE_TIMEOUT);
+		if (test_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags))
+			return DOE_WAIT_ABORT;
+		return 0;
+	}
+
+	return pci_doe_wait_poll(doe_mb, PCI_DOE_POLL_INTERVAL);
+}
+
+static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+
+	if (pci_doe_irq_enabled(doe_mb))
+		val |= PCI_DOE_CTRL_INT_EN;
+	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
+}
+
+static int pci_doe_issue_abort(struct pci_doe_mb *doe_mb)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	unsigned long timeout_jiffies;
+
+	pci_dbg(pdev, "[%x] Issuing Abort\n", offset);
+
+	/*
+	 * Abort detected while aborting; something is really broken or the
+	 * mailbox is being destroyed.
+	 */
+	if (pci_doe_arm_wait(doe_mb))
+		return -EIO;
+
+	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
+	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
+
+	do {
+		u32 val;
+
+		/*
+		 * Abort detected while aborting; something is really broken or
+		 * the mailbox is being destroyed.
+		 */
+		if (pci_doe_wait_irq_or_poll(doe_mb))
+			return -EIO;
+		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+
+		/* Abort success! */
+		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
+		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
+			return 0;
+
+	} while (!time_after(jiffies, timeout_jiffies));
+
+	/* Abort has timed out and the MB is dead */
+	pci_err(pdev, "[%x] ABORT timed out\n", offset);
+	return -EIO;
+}
+
+static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
+			    struct pci_doe_task *task)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	u32 val;
+	int i;
+
+	/*
+	 * Check the DOE busy bit is not set. If it is set, this could indicate
+	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
+	 * it is expected that firmware and OS will negotiate access rights via
+	 * an, as yet to be defined method.
+	 */
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
+		return -EBUSY;
+
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
+		return -EIO;
+
+	/* Write DOE Header */
+	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
+		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
+	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
+	/* Length is 2 DW of header + length of payload in DW */
+	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
+			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
+					  2 + task->request_pl_sz /
+						sizeof(u32)));
+	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
+		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
+				       task->request_pl[i]);
+
+	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
+
+	/* Request is sent - now wait for poll or IRQ */
+	return 0;
+}
+
+static bool pci_doe_data_obj_ready(struct pci_doe_mb *doe_mb)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	u32 val;
+
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
+		return true;
+	return false;
+}
+
+static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	size_t length, payload_length;
+	u32 val;
+	int i;
+
+	/* Read the first dword to get the protocol */
+	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
+	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
+	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
+		pci_err(pdev,
+			"[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
+			doe_mb->cap_offset,
+			task->prot.vid, task->prot.type,
+			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
+			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
+		return -EIO;
+	}
+
+	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+	/* Read the second dword to get the length */
+	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
+	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+
+	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
+	if (length > SZ_1M || length < 2)
+		return -EIO;
+
+	/* First 2 dwords have already been read */
+	length -= 2;
+	payload_length = min(length, task->response_pl_sz / sizeof(u32));
+	/* Read the rest of the response payload */
+	for (i = 0; i < payload_length; i++) {
+		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
+				      &task->response_pl[i]);
+		/* Prior to the last ack, ensure Data Object Ready */
+		if (i == (payload_length-1) && !pci_doe_data_obj_ready(doe_mb))
+			return -EIO;
+		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+	}
+
+	/* Flush excess length */
+	for (; i < length; i++) {
+		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
+		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+	}
+
+	/* Final error check to pick up on any since Data Object Ready */
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
+		return -EIO;
+
+	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
+}
+
+static void signal_task_complete(struct pci_doe_task *task, int rv)
+{
+	task->rv = rv;
+	task->complete(task);
+}
+
+static void signal_task_abort(struct pci_doe_task *task, int rv)
+{
+	struct pci_doe_mb *doe_mb = task->doe_mb;
+	struct pci_dev *pdev = doe_mb->pdev;
+
+	if (pci_doe_issue_abort(doe_mb)) {
+		/* On failure set the MB dead - no more submissions */
+		pci_err(pdev, "[%x] Abort failed marking mailbox dead\n",
+			doe_mb->cap_offset);
+		set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
+	}
+	signal_task_complete(task, rv);
+}
+
+static void doe_statemachine_work(struct work_struct *work)
+{
+	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
+						 work);
+	struct pci_doe_mb *doe_mb = task->doe_mb;
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	unsigned int busy_retries = 0;
+	unsigned long timeout_jiffies;
+	u32 val;
+	int rc;
+
+	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
+		signal_task_complete(task, -EIO);
+		return;
+	}
+
+	/* Send request */
+retry_req:
+	if (pci_doe_arm_wait(doe_mb)) {
+		signal_task_abort(task, -EIO);
+		return;
+	}
+
+	rc = pci_doe_send_req(doe_mb, task);
+
+	/*
+	 * The specification does not provide any guidance on how long
+	 * some other entity could keep the DOE busy, so try for 1
+	 * second then fail. Busy handling is best effort only, because
+	 * there is no way of avoiding racing against another user of
+	 * the DOE.
+	 */
+	if (rc == -EBUSY) {
+		busy_retries++;
+		if (busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
+			pci_warn(pdev,
+				"[%x] busy for too long (> 1 sec)\n",
+				offset);
+			signal_task_complete(task, rc);
+			return;
+		}
+		if (pci_doe_wait_poll(doe_mb, HZ / PCI_DOE_BUSY_MAX_RETRIES)) {
+			signal_task_abort(task, rc);
+			return;
+		}
+		goto retry_req;
+	} else if (rc) {
+		signal_task_abort(task, rc);
+		return;
+	}
+
+	timeout_jiffies = jiffies + HZ;
+	if (pci_doe_wait_irq_or_poll(doe_mb)) {
+		signal_task_abort(task, -EIO);
+		return;
+	}
+
+	/* Poll for response */
+retry_resp:
+	if (pci_doe_arm_wait(doe_mb)) {
+		signal_task_abort(task, -EIO);
+		return;
+	}
+
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+		signal_task_abort(task, -EIO);
+		return;
+	}
+
+	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
+		if (time_after(jiffies, timeout_jiffies)) {
+			signal_task_abort(task, -ETIMEDOUT);
+			return;
+		}
+		if (pci_doe_wait_poll(doe_mb, PCI_DOE_POLL_INTERVAL)) {
+			signal_task_abort(task, -EIO);
+			return;
+		}
+		goto retry_resp;
+	}
+
+	rc  = pci_doe_recv_resp(doe_mb, task);
+	if (rc < 0) {
+		signal_task_abort(task, rc);
+		return;
+	}
+
+	signal_task_complete(task, rc);
+}
+
+static void pci_doe_task_complete(struct pci_doe_task *task)
+{
+	complete(task->private);
+}
+
+static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
+			     u8 *protocol)
+{
+	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
+				    *index);
+	u32 response_pl;
+	DECLARE_COMPLETION_ONSTACK(c);
+	struct pci_doe_task task = {
+		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
+		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
+		.request_pl = &request_pl,
+		.request_pl_sz = sizeof(request_pl),
+		.response_pl = &response_pl,
+		.response_pl_sz = sizeof(response_pl),
+		.complete = pci_doe_task_complete,
+		.private = &c,
+	};
+	int ret;
+
+	ret = pci_doe_submit_task(doe_mb, &task);
+	if (ret < 0)
+		return ret;
+
+	wait_for_completion(&c);
+
+	if (task.rv != sizeof(response_pl))
+		return -EIO;
+
+	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
+	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+			      response_pl);
+	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
+			   response_pl);
+
+	return 0;
+}
+
+static void *pci_doe_xa_entry(u16 vid, u8 prot)
+{
+	return (void *)(((unsigned long)vid << 16) | prot);
+}
+
+static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
+{
+	u8 index = 0;
+	u8 xa_idx = 0;
+
+	do {
+		int rc;
+		u16 vid;
+		u8 prot;
+
+		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
+		if (rc)
+			return rc;
+
+		pci_dbg(doe_mb->pdev,
+			"[%x] Found protocol %d vid: %x prot: %x\n",
+			doe_mb->cap_offset, xa_idx, vid, prot);
+
+		rc = xa_insert(&doe_mb->prots, xa_idx++,
+			       pci_doe_xa_entry(vid, prot), GFP_KERNEL);
+		if (rc)
+			return -ENOMEM;
+	} while (index);
+
+	return 0;
+}
+
+static int pci_doe_enable_irq(struct pci_doe_mb *doe_mb,
+			      unsigned int int_msg_num)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	int rc;
+
+	/*
+	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call
+	 * this multiple times and thus is called here to ensure that mastering
+	 * is enabled even if the driver has done so.
+	 */
+	pci_set_master(pdev);
+	rc = pci_request_irq(pdev, int_msg_num, pci_doe_irq_handler, NULL,
+			     doe_mb, "DOE[%x %s]", offset, pci_name(pdev));
+	if (rc)
+		return rc;
+
+	doe_mb->int_msg_num = int_msg_num;
+	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_INT_EN);
+
+	return 0;
+}
+
+static void pci_doe_free_mb(struct pci_doe_mb *doe_mb)
+{
+	if (doe_mb->work_queue)
+		destroy_workqueue(doe_mb->work_queue);
+	if (pci_doe_irq_enabled(doe_mb))
+		pci_free_irq(doe_mb->pdev, doe_mb->int_msg_num, doe_mb);
+	xa_destroy(&doe_mb->prots);
+	kfree(doe_mb);
+}
+
+/**
+ * pci_doe_get_int_msg_num() - Return the interrupt message number for the
+ *			       mailbox at offset
+ *
+ * @pdev: The PCI device
+ * @offset: Offset of the DOE mailbox
+ *
+ * Returns: IRQ number on success
+ *	    -errno if IRQs are not supported on this mailbox
+ */
+int pci_doe_get_int_msg_num(struct pci_dev *pdev, int offset)
+{
+	u32 val;
+
+	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
+	if (!FIELD_GET(PCI_DOE_CAP_INT_SUP, val))
+		return -ENXIO;
+
+	return FIELD_GET(PCI_DOE_CAP_INT_MSG_NUM, val);
+}
+EXPORT_SYMBOL_GPL(pci_doe_get_int_msg_num);
+
+static void pci_doe_destroy_mb(void *mb)
+{
+	struct pci_doe_mb *doe_mb = mb;
+
+	/* Mark going down */
+	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
+
+	/* Abort any in progress work items */
+	pci_doe_abort(doe_mb);
+
+	/* Flush remaining work items */
+	flush_workqueue(doe_mb->work_queue);
+
+	pci_doe_free_mb(doe_mb);
+}
+
+/**
+ * pcim_doe_create_mb() - Create a DOE mailbox object
+ *
+ * @pdev: PCI device to create the DOE mailbox for
+ * @cap_offset: Offset of the DOE mailbox
+ * @int_msg_num: Interrupt message number to use; a negative value means don't
+ *		 use interrupts
+ *
+ * Create a single mailbox object to manage the mailbox protocol at the
+ * cap_offset specified.
+ *
+ * Caller should allocate PCI IRQ vectors before passing a possitive value for
+ * int_msg_num.
+ *
+ * RETURNS: created mailbox object on success
+ *	    ERR_PTR(-errno) on failure
+ */
+struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
+				      int int_msg_num)
+{
+	struct pci_doe_mb *doe_mb;
+	int rc;
+
+	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
+	if (!doe_mb)
+		return ERR_PTR(-ENOMEM);
+
+	doe_mb->pdev = pdev;
+	doe_mb->int_msg_num = -1;
+	doe_mb->cap_offset = cap_offset;
+
+	xa_init(&doe_mb->prots);
+	init_waitqueue_head(&doe_mb->wq);
+
+	if (int_msg_num >= 0) {
+		rc = pci_doe_enable_irq(doe_mb, int_msg_num);
+		if (rc)
+			pci_err(pdev,
+				"[%x] enable requested IRQ (%d) failed : %d\n",
+				doe_mb->cap_offset, int_msg_num, rc);
+	}
+
+	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
+						     doe_mb->cap_offset);
+	if (!doe_mb->work_queue) {
+		pci_err(pdev, "[%x] failed to allocate work queue\n",
+			doe_mb->cap_offset);
+		pci_doe_free_mb(doe_mb);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Reset the mailbox by issuing an abort */
+	rc = pci_doe_issue_abort(doe_mb);
+	if (rc) {
+		pci_err(pdev, "[%x] failed to reset : %d\n",
+			doe_mb->cap_offset, rc);
+		pci_doe_free_mb(doe_mb);
+		return ERR_PTR(rc);
+	}
+
+	if (devm_add_action_or_reset(&pdev->dev, pci_doe_destroy_mb, doe_mb))
+		return ERR_PTR(-EIO);
+
+	rc = pci_doe_cache_protocols(doe_mb);
+	if (rc) {
+		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
+			doe_mb->cap_offset, rc);
+		return ERR_PTR(rc);
+	}
+
+	return doe_mb;
+}
+EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
+
+/**
+ * pci_doe_supports_prot() - Return if the DOE instance supports the given
+ *			     protocol
+ * @doe_mb: DOE mailbox capability to query
+ * @vid: Protocol Vendor ID
+ * @type: Protocol type
+ *
+ * RETURNS: True if the DOE mailbox supports the protocol specified
+ */
+bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
+{
+	unsigned long index;
+	void *entry;
+
+	/* The discovery protocol must always be supported */
+	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
+		return true;
+
+	xa_for_each(&doe_mb->prots, index, entry)
+		if (entry == pci_doe_xa_entry(vid, type))
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
+
+/**
+ * pci_doe_submit_task() - Submit a task to be processed by the state machine
+ *
+ * @doe_mb: DOE mailbox capability to submit to
+ * @task: task to be queued
+ *
+ * Submit a DOE task (request/response) to the DOE mailbox to be processed.
+ * Returns upon queueing the task object.  If the queue is full this function
+ * will sleep until there is room in the queue.
+ *
+ * task->complete will be called when the state machine is done processing this
+ * task.
+ *
+ * Excess data will be discarded.
+ *
+ * RETURNS: 0 when task has been successful queued, -ERRNO on error
+ */
+int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
+{
+	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
+		return -EINVAL;
+
+	/*
+	 * DOE requests must be a whole number of DW
+	 * and the response needs to be big enough for at least 1 DW
+	 */
+	if (task->request_pl_sz % sizeof(u32) ||
+	    task->response_pl_sz < sizeof(u32))
+		return -EINVAL;
+
+	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
+		return -EIO;
+
+	task->doe_mb = doe_mb;
+	INIT_WORK(&task->work, doe_statemachine_work);
+	queue_work(doe_mb->work_queue, &task->work);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_doe_submit_task);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
new file mode 100644
index 000000000000..805b58ff4016
--- /dev/null
+++ b/include/linux/pci-doe.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Object Exchange
+ *	PCIe r6.0, sec 6.30 DOE
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022 Intel Corporation
+ *	Ira Weiny <ira.weiny@intel.com>
+ */
+
+#ifndef LINUX_PCI_DOE_H
+#define LINUX_PCI_DOE_H
+
+#include <linux/completion.h>
+
+struct pci_doe_protocol {
+	u16 vid;
+	u8 type;
+};
+
+struct pci_doe_mb;
+
+/**
+ * struct pci_doe_task - represents a single query/response
+ *
+ * @prot: DOE Protocol
+ * @request_pl: The request payload
+ * @request_pl_sz: Size of the request payload (bytes)
+ * @response_pl: The response payload
+ * @response_pl_sz: Size of the response payload (bytes)
+ * @rv: Return value.  Length of received response or error (bytes)
+ * @complete: Called when task is complete
+ * @private: Private data for the consumer
+ * @work: Used internally by the mailbox
+ * @doe_mb: Used internally by the mailbox
+ *
+ * The payload sizes and rv are specified in bytes with the following
+ * restrictions concerning the protocol.
+ *
+ *	1) The request_pl_sz must be a multiple of double words (4 bytes)
+ *	2) The response_pl_sz must be >= a single double word (4 bytes)
+ *	3) rv is returned as bytes but it will be a multiple of double words
+ *
+ * NOTE there is no need for the caller to initialize work or doe_mb.
+ */
+struct pci_doe_task {
+	struct pci_doe_protocol prot;
+	u32 *request_pl;
+	size_t request_pl_sz;
+	u32 *response_pl;
+	size_t response_pl_sz;
+	int rv;
+	void (*complete)(struct pci_doe_task *task);
+	void *private;
+
+	/* No need for the user to initialize these fields */
+	struct work_struct work;
+	struct pci_doe_mb *doe_mb;
+};
+
+/**
+ * pci_doe_for_each_off - Iterate each DOE capability
+ * @pdev: struct pci_dev to iterate
+ * @off: u16 of config space offset of each mailbox capability found
+ */
+#define pci_doe_for_each_off(pdev, off) \
+	for (off = pci_find_next_ext_capability(pdev, off, \
+					PCI_EXT_CAP_ID_DOE); \
+		off > 0; \
+		off = pci_find_next_ext_capability(pdev, off, \
+					PCI_EXT_CAP_ID_DOE))
+
+int pci_doe_get_int_msg_num(struct pci_dev *pdev, int offset);
+struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
+				      int irq);
+bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
+int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
+
+#endif
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index bee1a9ed6e66..9d50678f3f62 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -736,7 +736,8 @@
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
+#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1102,4 +1103,30 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Data Object Exchange */
+#define PCI_DOE_CAP		0x04    /* DOE Capabilities Register */
+#define  PCI_DOE_CAP_INT_SUP			0x00000001  /* Interrupt Support */
+#define  PCI_DOE_CAP_INT_MSG_NUM		0x00000ffe  /* Interrupt Message Number */
+#define PCI_DOE_CTRL		0x08    /* DOE Control Register */
+#define  PCI_DOE_CTRL_ABORT			0x00000001  /* DOE Abort */
+#define  PCI_DOE_CTRL_INT_EN			0x00000002  /* DOE Interrupt Enable */
+#define  PCI_DOE_CTRL_GO			0x80000000  /* DOE Go */
+#define PCI_DOE_STATUS		0x0c    /* DOE Status Register */
+#define  PCI_DOE_STATUS_BUSY			0x00000001  /* DOE Busy */
+#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
+#define  PCI_DOE_STATUS_ERROR			0x00000004  /* DOE Error */
+#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
+#define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
+#define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
+
+/* DOE Data Object - note not actually registers */
+#define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
+#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE		0x00ff0000
+#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
+
+#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.35.3

