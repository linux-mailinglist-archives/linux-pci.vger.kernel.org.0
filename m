Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1763A04F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 05:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiK1ED5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 23:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiK1EDz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 23:03:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043426421;
        Sun, 27 Nov 2022 20:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669608235; x=1701144235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dvH7Krk/MsjHLt2m8a/mJYPW9RzFFKDIlpzx+VbWTgA=;
  b=Eqkmmb3fCGeE/v56ybNpjuwt5GxUhNX63RyPu232+9Wg2yQTSfyyGNQO
   bmVdG/axFFf9d3K+My+Ur9gIOzetfodCivKNaXUEVpkWMJMJNElIJQEt5
   BS1RoPR4NQ5OfxuZx1sWKj5ZyBAfbSmvWdSO/rEzJeD+7fhtSmd9XhaKC
   CBKeRvDRz2MVWc4UFvqmrFlx0tws4QQ/p4Q/1vzNlm4HIoZEOqGrNwGor
   o1ZGT8MIjuP0PNlPKAIv9e+2mM0XFbXpobqeLSC8TnNyeSMu60drUvee1
   OxbzZb8AiO77yHnEH6ZTxIU2xwrg2gkezUMJPwO9ProTgv8gg8GsIbbhR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="295127114"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="295127114"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 20:03:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="593733585"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="593733585"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.2.33])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 20:03:42 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V3 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Date:   Sun, 27 Nov 2022 20:03:37 -0800
Message-Id: <20221128040338.1936529-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221128040338.1936529-1-ira.weiny@intel.com>
References: <20221128040338.1936529-1-ira.weiny@intel.com>
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

pci_doe_flush_mb() does not work and is currently unused.

It does not work because each struct doe_mb is managed as part of the
PCI device.  They can't go away as long as the PCI device exists.
pci_doe_flush_mb() was set up to flush the workqueue and prevent any
further submissions to the mailboxes when the PCI device goes away.
Unfortunately, this was fundamentally flawed.  There was no guarantee
that a struct doe_mb remained after pci_doe_flush_mb() returned.
Therefore, the doe_mb state could be invalid when those threads waiting
on the workqueue were flushed.

Fortunately the current code is safe because all callers make a
synchronous call to pci_doe_submit_task() and maintain a reference on
the PCI device.  Therefore pci_doe_flush_mb() is effectively unused.

Rather than attempt to fix pci_doe_flush_mb() just remove the dead code
around pci_doe_flush_mb().

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	Lukas
		Clarify commit message.
	Jonathan
		Add comment for changed poll interval.
---
 drivers/pci/doe.c | 49 +++++------------------------------------------
 1 file changed, 5 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..685e7d26c7eb 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -24,10 +24,10 @@
 
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
-#define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
+/* Interval to poll mailbox status */
+#define PCI_DOE_POLL_INTERVAL_MSECS	8
 
-#define PCI_DOE_FLAG_CANCEL	0
-#define PCI_DOE_FLAG_DEAD	1
+#define PCI_DOE_FLAG_DEAD	0
 
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
@@ -53,15 +53,6 @@ struct pci_doe_mb {
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
@@ -82,12 +73,9 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
 	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
 
 	do {
-		int rc;
 		u32 val;
 
-		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
-		if (rc)
-			return rc;
+		msleep_interruptible(PCI_DOE_POLL_INTERVAL_MSECS);
 		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
 
 		/* Abort success! */
@@ -278,11 +266,7 @@ static void doe_statemachine_work(struct work_struct *work)
 			signal_task_abort(task, -EIO);
 			return;
 		}
-		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
-		if (rc) {
-			signal_task_abort(task, rc);
-			return;
-		}
+		msleep_interruptible(PCI_DOE_POLL_INTERVAL_MSECS);
 		goto retry_resp;
 	}
 
@@ -383,21 +367,6 @@ static void pci_doe_destroy_workqueue(void *mb)
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
@@ -450,14 +419,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
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

