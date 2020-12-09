Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093C62D37A8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgLIAZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:25:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:16954 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731894AbgLIAZk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:25:40 -0500
IronPort-SDR: 2RZKubwEJGu11UNXjNmLQDyd9wnUlyRw5yfh6KRZa48f0thBh04S7o5gKhDlzyiTKNMI31OGTe
 clrimgyQyBpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142082"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142082"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:26 -0800
IronPort-SDR: 66Q6+kN6RXtvqi90c/8wei85EY6GfU1Z9ddfnIHPwBlIrMlB8BLmN4Lf9ZWfTX2/MgloStBOC7
 nO9mViKL/H+A==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838494"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:25 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v2 07/14] cxl/mem: Implement polled mode mailbox
Date:   Tue,  8 Dec 2020 16:24:11 -0800
Message-Id: <20201209002418.1976362-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide enough functionality to utilize the mailbox of a memory device.
The mailbox is used to interact with the firmware running on the memory
device.

The CXL specification defines separate capabilities for the mailbox and
the memory device. While we can confirm the mailbox is ready, in order
to actually interact with the memory device, you must also confirm the
device's firmware is ready.

Create a function to handle sending a command, optionally with a
payload, to the memory device, polling on a result, and then optionally
copying out the payload. The algorithm for doing this comes straight out
of the CXL 2.0 specification.

Primary mailboxes are capable of generating an interrupt when submitting
a command in the background. That implementation is saved for a later
time.

Secondary mailboxes aren't implemented at this time.

The flow is proven with one implemented command, "identify".

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h |  75 +++++++++++++
 drivers/cxl/mem.c | 265 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 339 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 91bb40f73ddc..6d641309013d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -32,9 +32,38 @@
 #define   CXLDEV_MB_CAP_PAYLOAD_SIZE_MASK GENMASK(5, 0)
 #define   CXLDEV_MB_CAP_PAYLOAD_SIZE_SHIFT 0
 #define CXLDEV_MB_CTRL_OFFSET 0x04
+#define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
 #define CXLDEV_MB_CMD_OFFSET 0x08
+#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_SHIFT 16
+#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_MASK GENMASK(36, 16)
 #define CXLDEV_MB_STATUS_OFFSET 0x10
+#define   CXLDEV_MB_STATUS_RET_CODE_SHIFT 32
+#define   CXLDEV_MB_STATUS_RET_CODE_MASK GENMASK(47, 32)
 #define CXLDEV_MB_BG_CMD_STATUS_OFFSET 0x18
+#define CXLDEV_MB_PAYLOAD_OFFSET 0x20
+
+/* Memory Device (CXL 2.0 - 8.2.8.5.1.1) */
+#define CXLMDEV_STATUS_OFFSET 0x0
+#define   CXLMDEV_DEV_FATAL BIT(0)
+#define   CXLMDEV_FW_HALT BIT(1)
+#define   CXLMDEV_STATUS_MEDIA_STATUS_SHIFT 2
+#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
+#define     CXLMDEV_MS_NOT_READY 0
+#define     CXLMDEV_MS_READY 1
+#define     CXLMDEV_MS_ERROR 2
+#define     CXLMDEV_MS_DISABLED 3
+#define   CXLMDEV_READY(status) \
+		(CXL_GET_FIELD(status, CXLMDEV_STATUS_MEDIA_STATUS) == CXLMDEV_MS_READY)
+#define   CXLMDEV_MBOX_IF_READY BIT(4)
+#define   CXLMDEV_RESET_NEEDED_SHIFT 5
+#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
+#define     CXLMDEV_RESET_NEEDED_NOT 0
+#define     CXLMDEV_RESET_NEEDED_COLD 1
+#define     CXLMDEV_RESET_NEEDED_WARM 2
+#define     CXLMDEV_RESET_NEEDED_HOT 3
+#define     CXLMDEV_RESET_NEEDED_CXL 4
+#define   CXLMDEV_RESET_NEEDED(status) \
+		(CXL_GET_FIELD(status, CXLMDEV_RESET_NEEDED) != CXLMDEV_RESET_NEEDED_NOT)
 
 /**
  * struct cxl_mem - A CXL memory device
@@ -45,6 +74,18 @@ struct cxl_mem {
 	struct pci_dev *pdev;
 	void __iomem *regs;
 
+	spinlock_t mbox_lock; /* Protects device mailbox and firmware */
+
+	struct {
+		struct range range;
+	} pmem;
+
+	struct {
+		struct range range;
+	} ram;
+
+	char firmware_version[0x10];
+
 	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
 	struct {
 		void __iomem *regs;
@@ -90,6 +131,7 @@ struct cxl_mem {
 
 cxl_reg(status);
 cxl_reg(mbox);
+cxl_reg(mem);
 
 static inline u32 __cxl_read_reg32(struct cxl_mem *cxlm, u32 reg)
 {
@@ -104,4 +146,37 @@ static inline u64 __cxl_read_reg64(struct cxl_mem *cxlm, u32 reg)
 
 	return readq(reg_addr + reg);
 }
+
+static inline void cxl_mbox_payload_fill(struct cxl_mem *cxlm, u8 *input,
+					 unsigned int length)
+{
+	memcpy_toio(cxlm->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET, input, length);
+}
+
+static inline void cxl_mbox_payload_drain(struct cxl_mem *cxlm, u8 *output,
+					  unsigned int length)
+{
+	memcpy_fromio(output, cxlm->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET,
+		      length);
+}
+
+#define CXL_MBOX_IDENTIFY 0x4000
+
+struct cxl_mbox_identify {
+	char fw_revision[0x10];
+	__le64 total_capacity;
+	__le64 volatile_capacity;
+	__le64 persistent_capacity;
+	__le64 partition_align;
+	__le16 info_event_log_size;
+	__le16 warning_event_log_size;
+	__le16 failure_event_log_size;
+	__le16 fatal_event_log_size;
+	__le32 lsa_size;
+	u8 poison_list_max_mer[3];
+	__le16 inject_poison_limit;
+	u8 poison_caps;
+	u8 qos_telemetry_caps;
+} __packed;
+
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 8ea830ffdbba..82984bf58a8d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/sched/clock.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/io.h>
@@ -7,6 +8,211 @@
 #include "pci.h"
 #include "cxl.h"
 
+#define cxl_doorbell_busy(cxlm)                                                \
+	(cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
+	 CXLDEV_MB_CTRL_DOORBELL)
+
+/**
+ * struct mbox_cmd - A command to be submitted to hardware.
+ * @opcode: (input) The command set and command submitted to hardware.
+ * @payload: (input/output) Pointer to the input and output payload.
+ * @size_in: (input) Number of bytes to load from @payload.
+ * @size_out:
+ *  - (input) Number of bytes allocated to load into @payload.
+ *  - (output) Number of bytes loaded into @payload.
+ * @return_code: (output) Error code returned from hardware.
+ *
+ * This is the primary mechanism used to send commands to the hardware.
+ * All the fields except @payload correspond exactly to the fields described in
+ * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload
+ * corresponds to the Command Payload Registers (8.2.8.4.8).
+ */
+struct mbox_cmd {
+	u16 opcode;
+	u8 *payload;
+	size_t size_in;
+	size_t size_out;
+	u16 return_code;
+};
+
+static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
+{
+	const int timeout = msecs_to_jiffies(2000);
+	const unsigned long start = jiffies;
+
+	while (cxl_doorbell_busy(cxlm)) {
+		if (time_after(jiffies, start + timeout)) {
+			/* Check again in case preempted before timeout test */
+			if (!cxl_doorbell_busy(cxlm))
+				break;
+			return -ETIMEDOUT;
+		}
+		cpu_relax();
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
+ * @cxlm: The CXL memory device to communicate with.
+ * @mbox_cmd: Command to send to the memory device.
+ *
+ * Context: Any context. Expects mbox_lock to be held.
+ * Return: 0 if the doorbell transaction was successful from a protocol level.
+ * Caller should check the return code in @mbox_cmd to make sure it succeeded.
+ */
+static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
+				 struct mbox_cmd *mbox_cmd)
+{
+	u64 cmd, status;
+	size_t out_len;
+	int rc;
+
+	lockdep_assert_held(&cxlm->mbox_lock);
+
+	/*
+	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
+	 *   1. Caller reads MB Control Register to verify doorbell is clear
+	 *   2. Caller writes Command Register
+	 *   3. Caller writes Command Payload Registers if input payload is non-empty
+	 *   4. Caller writes MB Control Register to set doorbell
+	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
+	 *   6. Caller reads MB Status Register to fetch Return code
+	 *   7. If command successful, Caller reads Command Register to get Payload Length
+	 *   8. If output payload is non-empty, host reads Command Payload Registers
+	 */
+
+	/* #1 */
+	WARN_ON(cxl_doorbell_busy(cxlm));
+
+	/* #2 */
+	cxl_write_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET, mbox_cmd->opcode);
+
+	if (mbox_cmd->size_in) {
+		/* #3 */
+		CXL_SET_FIELD(mbox_cmd->size_in, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
+		cxl_mbox_payload_fill(cxlm, mbox_cmd->payload,
+				      mbox_cmd->size_in);
+	}
+
+	/* #4 */
+	cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
+			     CXLDEV_MB_CTRL_DOORBELL);
+
+	/* #5 */
+	rc = cxl_mem_wait_for_doorbell(cxlm);
+	if (rc == -ETIMEDOUT) {
+		dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
+		return rc;
+	}
+
+	/* #6 */
+	status = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_STATUS_OFFSET);
+	cmd = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET);
+
+	mbox_cmd->return_code =
+		CXL_GET_FIELD(status, CXLDEV_MB_STATUS_RET_CODE);
+
+	/* There was a problem, let the caller deal with it */
+	if (mbox_cmd->return_code != 0)
+		return 0;
+
+	/* #7 */
+	out_len = CXL_GET_FIELD(cmd, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
+	if (out_len > mbox_cmd->size_out)
+		return -EINVAL;
+
+	mbox_cmd->size_out = out_len;
+
+	/* #8 */
+	if (mbox_cmd->size_out)
+		cxl_mbox_payload_drain(cxlm, mbox_cmd->payload,
+				       mbox_cmd->size_out);
+
+	return 0;
+}
+
+/**
+ * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
+ * @cxlm: The memory device to gain access to.
+ *
+ * Context: Any context. Takes the mbox_lock.
+ * Return: 0 if exclusive access was acquired.
+ */
+static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
+{
+	u64 md_status;
+	int rc = -EBUSY;
+
+	spin_lock(&cxlm->mbox_lock);
+
+	/*
+	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
+	 * around the mailbox interface ready (8.2.8.5.1.1). The purpose of the
+	 * bit is to allow firmware running on the device to notify us that it's
+	 * ready to receive commands. It is unclear if the bit needs to be read
+	 * every time one tries to use the mailbox, ie. the firmware can switch
+	 * it on and off as needed. Second, there is no defined timeout for
+	 * mailbox ready, like there is for the doorbell interface.
+	 *
+	 * As such, we make the following assumptions:
+	 * 1. The firmware might toggle the Mailbox Interface Ready bit, and so
+	 *    we check it for every command.
+	 * 2. If the doorbell is clear, the firmware should have first set the
+	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
+	 *    to be ready is a sufficient amount of time.
+	 */
+	rc = cxl_mem_wait_for_doorbell(cxlm);
+	if (rc) {
+		dev_warn(&cxlm->pdev->dev, "Mailbox interface not ready\n");
+		goto out;
+	}
+
+	md_status = cxl_read_mem_reg64(cxlm, CXLMDEV_STATUS_OFFSET);
+	if (md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status)) {
+		/*
+		 * Hardware shouldn't allow a ready status but also have failure
+		 * bits set. Spit out an error, this should be a bug report
+		 */
+		if (md_status & CXLMDEV_DEV_FATAL) {
+			dev_err(&cxlm->pdev->dev,
+				"CXL device reporting ready and fatal\n");
+			rc = -EFAULT;
+			goto out;
+		}
+		if (md_status & CXLMDEV_FW_HALT) {
+			dev_err(&cxlm->pdev->dev,
+				"CXL device reporting ready and halted\n");
+			rc = -EFAULT;
+			goto out;
+		}
+		if (CXLMDEV_RESET_NEEDED(md_status)) {
+			dev_err(&cxlm->pdev->dev,
+				"CXL device reporting ready and reset needed\n");
+			rc = -EFAULT;
+			goto out;
+		}
+
+		return 0;
+	}
+
+out:
+	spin_unlock(&cxlm->mbox_lock);
+	return rc;
+}
+
+/**
+ * cxl_mem_mbox_put() - Release exclusive access to the mailbox.
+ * @cxlm: The CXL memory device to communicate with.
+ *
+ * Context: Any context. Expects mbox_lock to be held.
+ */
+static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
+{
+	spin_unlock(&cxlm->mbox_lock);
+}
+
 /**
  * cxl_mem_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
@@ -119,6 +325,8 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 		return NULL;
 	}
 
+	spin_lock_init(&cxlm->mbox_lock);
+
 	regs = pcim_iomap_table(pdev)[bar];
 	cxlm->pdev = pdev;
 	cxlm->regs = regs + offset;
@@ -151,6 +359,57 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+/**
+ * cxl_mem_identify() - Send the IDENTIFY command to the device.
+ * @cxlm: The device to identify.
+ *
+ * Return: 0 if identify was executed successfully.
+ *
+ * This will dispatch the identify command to the device and on success populate
+ * structures to be exported to sysfs.
+ */
+static int cxl_mem_identify(struct cxl_mem *cxlm)
+{
+	struct cxl_mbox_identify *id;
+	struct mbox_cmd mbox_cmd;
+	u8 pload[256];
+	int rc;
+
+	/* Retrieve initial device memory map */
+	rc = cxl_mem_mbox_get(cxlm);
+	if (rc)
+		return rc;
+
+	mbox_cmd = (struct mbox_cmd){
+		.opcode = CXL_MBOX_IDENTIFY,
+		.payload = pload,
+		.size_in = 0,
+		.size_out = sizeof(pload),
+	};
+	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+	if (rc)
+		goto out;
+
+	id = (struct cxl_mbox_identify *)mbox_cmd.payload;
+
+	/*
+	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
+	 * For now, only the capacity is exported in sysfs
+	 */
+	cxlm->ram.range.start = 0;
+	cxlm->ram.range.end = le64_to_cpu(id->volatile_capacity) - 1;
+
+	cxlm->pmem.range.start = 0;
+	cxlm->pmem.range.end = le64_to_cpu(id->persistent_capacity) - 1;
+
+	memcpy(cxlm->firmware_version, id->fw_revision,
+	       sizeof(id->fw_revision));
+out:
+	cxl_mem_mbox_put(cxlm);
+
+	return rc;
+}
+
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -198,7 +457,11 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	return cxl_mem_setup_regs(cxlm);
+	rc = cxl_mem_setup_regs(cxlm);
+	if (rc)
+		return rc;
+
+	return cxl_mem_identify(cxlm);
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
-- 
2.29.2

