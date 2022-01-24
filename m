Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21126497675
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiAXA24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:28:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:10264 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240570AbiAXA24 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984136; x=1674520136;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d2O4ukco9yjeLP/4HRn4+ns9rQ8cBa23y7IswRdALMk=;
  b=Vfi/GBcgn2rmqvdCLYlMPy6KNC9oOFljMVWnS1xRMBvKSqJ3t7rCcioZ
   flNeqiYekorB5i9Sq4ZcpLckbArnYEX6N4VAqpnLszkMcsd+NhxLwqA1V
   FQGp39nyJMItUKv5gfVwT44vzdJol3W88gnp18G5jJwiuQSaP2NXRSVmL
   H8/ce9LdI1SvqhyXaWR+ZJOwCPC42EGfS95rOUugYnvCddPf13Um2PnAH
   Ey2GWl/tTmdgD2a0oMP5VuR2EvOxaQabdxeWV048pN3LSO5qt0fan8y5C
   w07VK/Vawo2QUKeyy8966A65XmZp0tCVPKmlYds405angQyUus740Dbo7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245715179"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245715179"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:28:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="580171941"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:28:55 -0800
Subject: [PATCH v3 03/40] cxl/pci: Defer mailbox status checks to command
 timeouts
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:28:54 -0800
Message-ID: <164298413480.3018233.9643395389297971819.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Device status can change without warning at any point in time. This
effectively means that no amount of status checking before a command is
submitted can guarantee that the device is not in an error condition
when the command is later submitted. The clearest signal that a device
is not able to process commands is if it fails to process commands.

With the above understanding in hand, update cxl_pci_setup_mailbox() to
validate the readiness of the mailbox once at the beginning of time, and
then use timeouts and busy sequencing errors as the only occasions to
report status.

Just as before, unless and until the driver gains a reset recovery path,
doorbell clearing failures by the device are fatal to mailbox
operations.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |  134 +++++++++++++----------------------------------------
 1 file changed, 33 insertions(+), 101 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ed8de9eac970..91de2e4aff6f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -73,14 +73,16 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
-static void cxl_pci_mbox_timeout(struct cxl_dev_state *cxlds,
-				 struct cxl_mbox_cmd *mbox_cmd)
-{
-	struct device *dev = cxlds->dev;
+#define cxl_err(dev, status, msg)                                        \
+	dev_err_ratelimited(dev, msg ", device state %s%s\n",                  \
+			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
+			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
 
-	dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
-		mbox_cmd->opcode, mbox_cmd->size_in);
-}
+#define cxl_cmd_err(dev, cmd, status, msg)                               \
+	dev_err_ratelimited(dev, msg " (opcode: %#x), device state %s%s\n",    \
+			    (cmd)->opcode,                                     \
+			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
+			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
 
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
@@ -134,7 +136,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 
 	/* #1 */
 	if (cxl_doorbell_busy(cxlds)) {
-		dev_err_ratelimited(dev, "Mailbox re-busy after acquiring\n");
+		u64 md_status =
+			readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
+			    "mailbox queue busy");
 		return -EBUSY;
 	}
 
@@ -160,7 +166,9 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	/* #5 */
 	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
 	if (rc == -ETIMEDOUT) {
-		cxl_pci_mbox_timeout(cxlds, mbox_cmd);
+		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status, "mailbox timeout");
 		return rc;
 	}
 
@@ -198,98 +206,13 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-/**
- * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
- * @cxlds: The device state to gain access to.
- *
- * Context: Any context. Takes the mbox_mutex.
- * Return: 0 if exclusive access was acquired.
- */
-static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
-{
-	struct device *dev = cxlds->dev;
-	u64 md_status;
-	int rc;
-
-	mutex_lock_io(&cxlds->mbox_mutex);
-
-	/*
-	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
-	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
-	 * bit is to allow firmware running on the device to notify the driver
-	 * that it's ready to receive commands. It is unclear if the bit needs
-	 * to be read for each transaction mailbox, ie. the firmware can switch
-	 * it on and off as needed. Second, there is no defined timeout for
-	 * mailbox ready, like there is for the doorbell interface.
-	 *
-	 * Assumptions:
-	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
-	 *    it for every command.
-	 *
-	 * 2. If the doorbell is clear, the firmware should have first set the
-	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
-	 *    to be ready is sufficient.
-	 */
-	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
-	if (rc) {
-		dev_warn(dev, "Mailbox interface not ready\n");
-		goto out;
-	}
-
-	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
-	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
-		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
-		rc = -EBUSY;
-		goto out;
-	}
-
-	/*
-	 * Hardware shouldn't allow a ready status but also have failure bits
-	 * set. Spit out an error, this should be a bug report
-	 */
-	rc = -EFAULT;
-	if (md_status & CXLMDEV_DEV_FATAL) {
-		dev_err(dev, "mbox: reported ready, but fatal\n");
-		goto out;
-	}
-	if (md_status & CXLMDEV_FW_HALT) {
-		dev_err(dev, "mbox: reported ready, but halted\n");
-		goto out;
-	}
-	if (CXLMDEV_RESET_NEEDED(md_status)) {
-		dev_err(dev, "mbox: reported ready, but reset needed\n");
-		goto out;
-	}
-
-	/* with lock held */
-	return 0;
-
-out:
-	mutex_unlock(&cxlds->mbox_mutex);
-	return rc;
-}
-
-/**
- * cxl_pci_mbox_put() - Release exclusive access to the mailbox.
- * @cxlds: The device state to communicate with.
- *
- * Context: Any context. Expects mbox_mutex to be held.
- */
-static void cxl_pci_mbox_put(struct cxl_dev_state *cxlds)
-{
-	mutex_unlock(&cxlds->mbox_mutex);
-}
-
 static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	int rc;
 
-	rc = cxl_pci_mbox_get(cxlds);
-	if (rc)
-		return rc;
-
+	mutex_lock_io(&cxlds->mbox_mutex);
 	rc = __cxl_pci_mbox_send_cmd(cxlds, cmd);
-	cxl_pci_mbox_put(cxlds);
+	mutex_unlock(&cxlds->mbox_mutex);
 
 	return rc;
 }
@@ -310,11 +233,20 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	} while (!time_after(jiffies, timeout));
 
 	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
-		dev_err(cxlds->dev,
-			"timeout awaiting mailbox ready, device state:%s%s\n",
-			md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
-			md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
-		return -EIO;
+		cxl_err(cxlds->dev, md_status,
+			"timeout awaiting mailbox ready");
+		return -ETIMEDOUT;
+	}
+
+	/*
+	 * A command may be in flight from a previous driver instance,
+	 * think kexec, do one doorbell wait so that
+	 * __cxl_pci_mbox_send_cmd() can assume that it is the only
+	 * source for future doorbell busy events.
+	 */
+	if (cxl_pci_mbox_wait_for_doorbell(cxlds) != 0) {
+		cxl_err(cxlds->dev, md_status, "timeout awaiting mailbox idle");
+		return -ETIMEDOUT;
 	}
 
 	cxlds->mbox_send = cxl_pci_mbox_send;

