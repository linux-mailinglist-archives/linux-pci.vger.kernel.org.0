Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6799628F25
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 02:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiKOBT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 20:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKOBTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 20:19:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9FB13DCC;
        Mon, 14 Nov 2022 17:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668475187; x=1700011187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9i9GneyN5wzD0q5QGpre3W00YKsgyhnQ1SvEvL9knhc=;
  b=FCrCuSzJMbBBE2i2v8aUFEGqLSiGzPlbuBgrxqAENVCMSpaSkUf6WVeR
   qzLrYdiVmO3gov5Sv1ugRdHj7gHwQnbCu6S9UJNwpE9Ltbiuj7/e8ivsH
   iBqSQq+RwPG2BdfL+3w9Mtok09XqIBvGhA+SiKNZgIuEFVVtD5JSdntAi
   XjGsieZTcccDtGOW3VXAYP/KGDFJfZg8CZxt147NLvAzYCGk2qCs0xphL
   IeGhXfMNaAlpX/I5IgOgDjWYLxRKSZfJrG4OfGxyjUJvr1j16DRHjekBH
   M0VTaO9CR7U02S5W8/U2ZuaE84NXY+wFH8TLTq4Q+c8//C4XKYorMrJ7w
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374258102"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="374258102"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:19:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="744378892"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="744378892"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.91.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:19:45 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI/doe: Fix work struct declaration
Date:   Mon, 14 Nov 2022 17:19:43 -0800
Message-Id: <20221115011943.1051039-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The callers of pci_doe_submit_task() allocate the pci_doe_task on the
stack.  This causes the work structure to be allocated on the stack
without pci_doe_submit_task() knowing.  Work item initialization needs
to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
how the work item is allocated.

Jonathan suggested creating doe task allocation macros such as
DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
function is not known to the callers and must be initialized correctly.

A follow up suggestion was to have an internal 'pci_doe_work' item
allocated by pci_doe_submit_task().[2]  This requires an allocation which
could restrict the context where tasks are used.

Compromise with an intermediate step to initialize the task struct with
a new call pci_doe_init_task() which must be called prior to submit
task.

[1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
[2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667

Cc: Bjorn Helgaas <helgaas@kernel.org>
Reported-by: Gregory Price <gregory.price@memverge.com>
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/pci.c  |  2 ++
 drivers/pci/doe.c       | 14 ++++++++++++--
 include/linux/pci-doe.h |  8 +++++---
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..a19c1fa0e2f4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -525,6 +525,7 @@ static int cxl_cdat_get_length(struct device *dev,
 	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
 	int rc;
 
+	pci_doe_init_task(cdat_doe, &t.task, true);
 	rc = pci_doe_submit_task(cdat_doe, &t.task);
 	if (rc < 0) {
 		dev_err(dev, "DOE submit failed: %d", rc);
@@ -554,6 +555,7 @@ static int cxl_cdat_read_table(struct device *dev,
 		u32 *entry;
 		int rc;
 
+		pci_doe_init_task(cdat_doe, &t.task, true);
 		rc = pci_doe_submit_task(cdat_doe, &t.task);
 		if (rc < 0) {
 			dev_err(dev, "DOE submit failed: %d", rc);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..cabeae4ae955 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -319,6 +319,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 	};
 	int rc;
 
+	pci_doe_init_task(doe_mb, &task, true);
 	rc = pci_doe_submit_task(doe_mb, &task);
 	if (rc < 0)
 		return rc;
@@ -495,6 +496,14 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 }
 EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
 
+void pci_doe_init_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
+		       bool onstack)
+{
+	task->doe_mb = doe_mb;
+	__INIT_WORK(&task->work, doe_statemachine_work, onstack);
+}
+EXPORT_SYMBOL_GPL(pci_doe_init_task);
+
 /**
  * pci_doe_submit_task() - Submit a task to be processed by the state machine
  *
@@ -517,6 +526,9 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(task->work.func != doe_statemachine_work))
+		return -EINVAL;
+
 	/*
 	 * DOE requests must be a whole number of DW and the response needs to
 	 * be big enough for at least 1 DW
@@ -528,8 +540,6 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
 		return -EIO;
 
-	task->doe_mb = doe_mb;
-	INIT_WORK(&task->work, doe_statemachine_work);
 	queue_work(doe_mb->work_queue, &task->work);
 	return 0;
 }
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index ed9b4df792b8..457fc0e53d64 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -31,8 +31,8 @@ struct pci_doe_mb;
  * @rv: Return value.  Length of received response or error (bytes)
  * @complete: Called when task is complete
  * @private: Private data for the consumer
- * @work: Used internally by the mailbox
- * @doe_mb: Used internally by the mailbox
+ * @work: Used internally by the mailbox [see pci_doe_init_task()]
+ * @doe_mb: Used internally by the mailbox [see pci_doe_init_task()]
  *
  * The payload sizes and rv are specified in bytes with the following
  * restrictions concerning the protocol.
@@ -53,7 +53,7 @@ struct pci_doe_task {
 	void (*complete)(struct pci_doe_task *task);
 	void *private;
 
-	/* No need for the user to initialize these fields */
+	/* Call pci_doe_init_task() for these */
 	struct work_struct work;
 	struct pci_doe_mb *doe_mb;
 };
@@ -72,6 +72,8 @@ struct pci_doe_task {
 
 struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
 bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
+void pci_doe_init_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
+		       bool onstack);
 int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
 
 #endif

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.37.2

