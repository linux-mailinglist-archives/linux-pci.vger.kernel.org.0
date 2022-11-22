Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0AB63409C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 16:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiKVPxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiKVPx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 10:53:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB3E48779;
        Tue, 22 Nov 2022 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669132408; x=1700668408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YUJ7EdYfUOaMRwptVpLuSUm6x5AoT6ZUjcLdR6MstiY=;
  b=kvgOBGhVXFJVFRcBO54KKqM/RGEUdFFFFxBpezx7FOXgnyg0ew0q/Qp9
   2sV586QTDlHRV9xxYAgBIcnMWV5hAI3B1O+Y9wWzADOJzQTgnNhHDyA/u
   3lZNVZYDN9bhsI5u31pP64xXb82ypEgm/C+n/hwE9IJBtUv3uy1lYaDVy
   axBlJkSjNqoBGXFQ0HERl10eSrBlxhe+SYba8hmnUpf5XCEnuhKE1QBWd
   fm+QnllWbcCIoJjgIz1GUJJ8aMZdiVm3VzYj1P3hCRSQaxWVljYVJqpHm
   TczU7eBHyCAseqmM0kEamdoyUD4srK8omwMstoGgvIk+nrZetiqzf9jrx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="313877730"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="313877730"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:53:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816142053"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="816142053"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.130.75])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 07:53:27 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V2 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Date:   Tue, 22 Nov 2022 07:53:23 -0800
Message-Id: <20221122155324.1878416-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122155324.1878416-1-ira.weiny@intel.com>
References: <20221122155324.1878416-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Each struct doe_mb is managed as part of the PCI device.  They can't go
away as long as the PCI device exists.  pci_doe_flush_mb() was set up to
flush the workqueue and prevent any further submissions to the mailboxes
when the PCI device goes away.  Unfortunately, this was fundamentally
flawed.  There was no guarantee that a struct doe_mb remained after
pci_doe_flush_mb() returned.  Therefore, the doe_mb state could be
invalid when those threads waiting on the workqueue were flushed.

Fortunately the current code is safe because all callers make a
synchronous call to pci_doe_submit_task() and maintain a reference on the
PCI device.

For these reasons, pci_doe_flush_mb() will never be called while tasks
are being processed and there is no use for it.

Remove the dead code around pci_doe_flush_mb().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/doe.c | 48 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..260313e9052e 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -24,10 +24,9 @@
 
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
-#define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
+#define PCI_DOE_POLL_INTERVAL	8
 
-#define PCI_DOE_FLAG_CANCEL	0
-#define PCI_DOE_FLAG_DEAD	1
+#define PCI_DOE_FLAG_DEAD	0
 
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
@@ -53,15 +52,6 @@ struct pci_doe_mb {
 	unsigned long flags;
 };
 
-static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
-{
-	if (wait_event_timeout(doe_mb->wq,
-			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
-			       timeout))
-		return -EIO;
-	return 0;
-}
-
 static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
 {
 	struct pci_dev *pdev = doe_mb->pdev;
@@ -82,12 +72,9 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
 	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
 
 	do {
-		int rc;
 		u32 val;
 
-		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
-		if (rc)
-			return rc;
+		msleep_interruptible(PCI_DOE_POLL_INTERVAL);
 		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
 
 		/* Abort success! */
@@ -278,11 +265,7 @@ static void doe_statemachine_work(struct work_struct *work)
 			signal_task_abort(task, -EIO);
 			return;
 		}
-		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
-		if (rc) {
-			signal_task_abort(task, rc);
-			return;
-		}
+		msleep_interruptible(PCI_DOE_POLL_INTERVAL);
 		goto retry_resp;
 	}
 
@@ -383,21 +366,6 @@ static void pci_doe_destroy_workqueue(void *mb)
 	destroy_workqueue(doe_mb->work_queue);
 }
 
-static void pci_doe_flush_mb(void *mb)
-{
-	struct pci_doe_mb *doe_mb = mb;
-
-	/* Stop all pending work items from starting */
-	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
-
-	/* Cancel an in progress work item, if necessary */
-	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
-	wake_up(&doe_mb->wq);
-
-	/* Flush all work items */
-	flush_workqueue(doe_mb->work_queue);
-}
-
 /**
  * pcim_doe_create_mb() - Create a DOE mailbox object
  *
@@ -450,14 +418,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
 		return ERR_PTR(rc);
 	}
 
-	/*
-	 * The state machine and the mailbox should be in sync now;
-	 * Set up mailbox flush prior to using the mailbox to query protocols.
-	 */
-	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
-
 	rc = pci_doe_cache_protocols(doe_mb);
 	if (rc) {
 		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
-- 
2.37.2

