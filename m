Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD40163113C
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 23:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiKSWZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 17:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiKSWZd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 17:25:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E61902D;
        Sat, 19 Nov 2022 14:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668896732; x=1700432732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8+8tWx5SF1oRnmfDK4qmCbUdGOEFIiUQgjpGa71x7XY=;
  b=iNq+CW/ga393gxuRYJiSWuncRm/XG/skASd4I/tLbyTMzf3hxKn0aGMl
   p1v/Co2UcxVBIAfkj3MtSuMZLrajOcXTSxjuom4aSDnkTK9BgUQJifE3i
   MXh48QmCqJkCgg3iIGBsyBBpTZJgBBVkfnW2nwL9Xyceu5/PmxOb/YnQ1
   7C1TTmrJffga6/MaySDFFiftc4WNfrwOgI56xXWOC+IBvNnlq/xolCzgD
   eW0hxp63SJbI9DcDyNDGM8YNF59l7fwULa7fSpuzHArQ4RgBUTuybcYRA
   rekdPeNepsqVCH7H8CaQvuJY4z9UXsnaUgq9hJcb0xtCCqZZVo0N9PZ0b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10536"; a="293061481"
X-IronPort-AV: E=Sophos;i="5.96,178,1665471600"; 
   d="scan'208";a="293061481"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 14:25:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10536"; a="746427542"
X-IronPort-AV: E=Sophos;i="5.96,178,1665471600"; 
   d="scan'208";a="746427542"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.164.154])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 14:25:30 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/DOE: Remove asynchronous task support
Date:   Sat, 19 Nov 2022 14:25:27 -0800
Message-Id: <20221119222527.1799836-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Gregory Price and Jonathan Cameron reported a bug within
pci_doe_submit_task().[1]  The issue was that work item initialization
needs to be done with either INIT_WORK_ONSTACK() or INIT_WORK()
depending on how the work item is allocated.

Initially, it was anticipated that DOE tasks were going to need to be
submitted asynchronously and the code was designed thusly.  Many
alternatives were discussed to fix the work initialization issue.[2]

However, all current users submit tasks synchronously and this has
therefore become an unneeded maintenance burden.  Remove the extra
maintenance burden by replacing asynchronous task submission with
a synchronous wait function.[3]

[1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
[2] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m0f057773d9c75432fcfcc54a2604483fe82abe92
[3] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m32d3f9b208ef7486bc148d94a326b26b2d3e69ff

Reported-by: Gregory Price <gregory.price@memverge.com>
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: "Li, Ming" <ming4.li@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Thanks to Dan for the bulk of the patch.
Thanks to Ming for pointing out the need for a lock to prevent more
than 1 task from being processed at a time.
---
 drivers/cxl/core/pci.c  | 16 ++------
 drivers/pci/doe.c       | 83 ++++++++++++++---------------------------
 include/linux/pci-doe.h | 10 +----
 3 files changed, 32 insertions(+), 77 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..58977e0712b6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -490,21 +490,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
 		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
 	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
 
-static void cxl_doe_task_complete(struct pci_doe_task *task)
-{
-	complete(task->private);
-}
-
 struct cdat_doe_task {
 	u32 request_pl;
 	u32 response_pl[32];
-	struct completion c;
 	struct pci_doe_task task;
 };
 
 #define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
 struct cdat_doe_task cdt = {                                  \
-	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
 	.request_pl = req,				      \
 	.task = {                                             \
 		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
@@ -513,8 +506,6 @@ struct cdat_doe_task cdt = {                                  \
 		.request_pl_sz = sizeof(cdt.request_pl),      \
 		.response_pl = cdt.response_pl,               \
 		.response_pl_sz = sizeof(cdt.response_pl),    \
-		.complete = cxl_doe_task_complete,            \
-		.private = &cdt.c,                            \
 	}                                                     \
 }
 
@@ -525,12 +516,12 @@ static int cxl_cdat_get_length(struct device *dev,
 	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
 	int rc;
 
-	rc = pci_doe_submit_task(cdat_doe, &t.task);
+	rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
 	if (rc < 0) {
 		dev_err(dev, "DOE submit failed: %d", rc);
 		return rc;
 	}
-	wait_for_completion(&t.c);
+
 	if (t.task.rv < sizeof(u32))
 		return -EIO;
 
@@ -554,12 +545,11 @@ static int cxl_cdat_read_table(struct device *dev,
 		u32 *entry;
 		int rc;
 
-		rc = pci_doe_submit_task(cdat_doe, &t.task);
+		rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
 		if (rc < 0) {
 			dev_err(dev, "DOE submit failed: %d", rc);
 			return rc;
 		}
-		wait_for_completion(&t.c);
 		/* 1 DW header + 1 DW data min */
 		if (t.task.rv < (2 * sizeof(u32)))
 			return -EIO;
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..41a75112b39b 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -18,7 +18,6 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
-#include <linux/workqueue.h>
 
 #define PCI_DOE_PROTOCOL_DISCOVERY 0
 
@@ -40,7 +39,7 @@
  * @cap_offset: Capability offset
  * @prots: Array of protocols supported (encoded as long values)
  * @wq: Wait queue for work item
- * @work_queue: Queue of pci_doe_work items
+ * @exec_lock: Lock to ensure 1 task is processed at a time
  * @flags: Bit array of PCI_DOE_FLAG_* flags
  */
 struct pci_doe_mb {
@@ -49,7 +48,7 @@ struct pci_doe_mb {
 	struct xarray prots;
 
 	wait_queue_head_t wq;
-	struct workqueue_struct *work_queue;
+	struct mutex exec_lock;
 	unsigned long flags;
 };
 
@@ -211,7 +210,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 static void signal_task_complete(struct pci_doe_task *task, int rv)
 {
 	task->rv = rv;
-	task->complete(task);
 }
 
 static void signal_task_abort(struct pci_doe_task *task, int rv)
@@ -231,10 +229,8 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
 	signal_task_complete(task, rv);
 }
 
-static void doe_statemachine_work(struct work_struct *work)
+static void exec_task(struct pci_doe_task *task)
 {
-	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
-						 work);
 	struct pci_doe_mb *doe_mb = task->doe_mb;
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
@@ -295,18 +291,12 @@ static void doe_statemachine_work(struct work_struct *work)
 	signal_task_complete(task, rc);
 }
 
-static void pci_doe_task_complete(struct pci_doe_task *task)
-{
-	complete(task->private);
-}
-
 static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 			     u8 *protocol)
 {
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
 				    *index);
 	u32 response_pl;
-	DECLARE_COMPLETION_ONSTACK(c);
 	struct pci_doe_task task = {
 		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
 		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
@@ -314,17 +304,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 		.request_pl_sz = sizeof(request_pl),
 		.response_pl = &response_pl,
 		.response_pl_sz = sizeof(response_pl),
-		.complete = pci_doe_task_complete,
-		.private = &c,
 	};
 	int rc;
 
-	rc = pci_doe_submit_task(doe_mb, &task);
+	rc = pci_doe_submit_task_wait(doe_mb, &task);
 	if (rc < 0)
 		return rc;
 
-	wait_for_completion(&c);
-
 	if (task.rv != sizeof(response_pl))
 		return -EIO;
 
@@ -376,13 +362,6 @@ static void pci_doe_xa_destroy(void *mb)
 	xa_destroy(&doe_mb->prots);
 }
 
-static void pci_doe_destroy_workqueue(void *mb)
-{
-	struct pci_doe_mb *doe_mb = mb;
-
-	destroy_workqueue(doe_mb->work_queue);
-}
-
 static void pci_doe_flush_mb(void *mb)
 {
 	struct pci_doe_mb *doe_mb = mb;
@@ -390,12 +369,9 @@ static void pci_doe_flush_mb(void *mb)
 	/* Stop all pending work items from starting */
 	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
 
-	/* Cancel an in progress work item, if necessary */
+	/* Cancel the in progress task and waiting tasks, if necessary */
 	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
 	wake_up(&doe_mb->wq);
-
-	/* Flush all work items */
-	flush_workqueue(doe_mb->work_queue);
 }
 
 /**
@@ -423,25 +399,13 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
 	doe_mb->pdev = pdev;
 	doe_mb->cap_offset = cap_offset;
 	init_waitqueue_head(&doe_mb->wq);
+	mutex_init(&doe_mb->exec_lock);
 
 	xa_init(&doe_mb->prots);
 	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
 	if (rc)
 		return ERR_PTR(rc);
 
-	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
-						dev_driver_string(&pdev->dev),
-						pci_name(pdev),
-						doe_mb->cap_offset);
-	if (!doe_mb->work_queue) {
-		pci_err(pdev, "[%x] failed to allocate work queue\n",
-			doe_mb->cap_offset);
-		return ERR_PTR(-ENOMEM);
-	}
-	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
-
 	/* Reset the mailbox by issuing an abort */
 	rc = pci_doe_abort(doe_mb);
 	if (rc) {
@@ -496,23 +460,22 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
 
 /**
- * pci_doe_submit_task() - Submit a task to be processed by the state machine
+ * pci_doe_submit_task_wait() - Submit and execute a task
  *
  * @doe_mb: DOE mailbox capability to submit to
- * @task: task to be queued
- *
- * Submit a DOE task (request/response) to the DOE mailbox to be processed.
- * Returns upon queueing the task object.  If the queue is full this function
- * will sleep until there is room in the queue.
+ * @task: task to be run
  *
- * task->complete will be called when the state machine is done processing this
- * task.
+ * Submit and run DOE task (request/response) to the DOE mailbox to be
+ * processed.
  *
  * Excess data will be discarded.
  *
- * RETURNS: 0 when task has been successfully queued, -ERRNO on error
+ * Context: non-interrupt
+ *
+ * RETURNS: 0 when task was executed, the @task->rv holds the status
+ * result of the executed opertion, -ERRNO on failure to submit.
  */
-int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
+int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 {
 	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
 		return -EINVAL;
@@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 		return -EIO;
 
 	task->doe_mb = doe_mb;
-	INIT_WORK(&task->work, doe_statemachine_work);
-	queue_work(doe_mb->work_queue, &task->work);
+
+again:
+	if (!mutex_trylock(&doe_mb->exec_lock)) {
+		if (wait_event_timeout(task->doe_mb->wq,
+				test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
+				PCI_DOE_POLL_INTERVAL))
+			return -EIO;
+		goto again;
+	}
+	exec_task(task);
+	mutex_unlock(&doe_mb->exec_lock);
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_doe_submit_task);
+EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index ed9b4df792b8..c94122a66221 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -30,8 +30,6 @@ struct pci_doe_mb;
  * @response_pl_sz: Size of the response payload (bytes)
  * @rv: Return value.  Length of received response or error (bytes)
  * @complete: Called when task is complete
- * @private: Private data for the consumer
- * @work: Used internally by the mailbox
  * @doe_mb: Used internally by the mailbox
  *
  * The payload sizes and rv are specified in bytes with the following
@@ -50,11 +48,6 @@ struct pci_doe_task {
 	u32 *response_pl;
 	size_t response_pl_sz;
 	int rv;
-	void (*complete)(struct pci_doe_task *task);
-	void *private;
-
-	/* No need for the user to initialize these fields */
-	struct work_struct work;
 	struct pci_doe_mb *doe_mb;
 };
 
@@ -72,6 +65,5 @@ struct pci_doe_task {
 
 struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
 bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
-int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
-
+int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
 #endif

base-commit: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25
-- 
2.37.2

