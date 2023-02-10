Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598596928C7
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjBJUxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjBJUxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:53:35 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52BF3AB0;
        Fri, 10 Feb 2023 12:53:34 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 23BDB10189E11;
        Fri, 10 Feb 2023 21:53:33 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 00EE5600CA83;
        Fri, 10 Feb 2023 21:53:32 +0100 (CET)
X-Mailbox-Line: From ad46bbc593d4b7f1c9c5cbafbb51d89533edd4a7 Mon Sep 17 00:00:00 2001
Message-Id: <ad46bbc593d4b7f1c9c5cbafbb51d89533edd4a7.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:11 +0100
Subject: [PATCH v3 11/16] PCI/DOE: Allow mailbox creation without devres
 management
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DOE mailbox creation is currently only possible through a devres-managed
API.  The lifetime of mailboxes thus ends with driver unbinding.

An upcoming commit will create DOE mailboxes upon device enumeration by
the PCI core.  Their lifetime shall not be limited by a driver.

Therefore rework pcim_doe_create_mb() into the non-devres-managed
pci_doe_create_mb().  Add pci_doe_destroy_mb() for mailbox destruction
on device removal.

Provide a devres-managed wrapper under the existing pcim_doe_create_mb()
name.

The error path of pcim_doe_create_mb() previously called xa_destroy() if
alloc_ordered_workqueue() failed.  That's unnecessary because the xarray
is still empty at that point.  It doesn't need to be destroyed until
it's been populated by pci_doe_cache_protocols().  Arrange the error
path of the new pci_doe_create_mb() accordingly.

pci_doe_cancel_tasks() is no longer used as callback for
devm_add_action(), so refactor it to accept a struct pci_doe_mb pointer
instead of a generic void pointer.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Changes v2 -> v3:
 * Call pci_doe_flush_mb() from pci_doe_destroy_mb() to simplify
   error paths (Jonathan)
 * Explain in commit message why xa_destroy() is reordered in
   error path of the new pci_doe_create_mb() (Jonathan)

 drivers/pci/doe.c | 103 +++++++++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 291cd7a46a39..2bc202b64b6a 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -37,7 +37,7 @@
  *
  * This state is used to manage a single DOE mailbox capability.  All fields
  * should be considered opaque to the consumers and the structure passed into
- * the helpers below after being created by devm_pci_doe_create()
+ * the helpers below after being created by pci_doe_create_mb().
  *
  * @pdev: PCI device this mailbox belongs to
  * @cap_offset: Capability offset
@@ -415,24 +415,8 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 	return 0;
 }
 
-static void pci_doe_xa_destroy(void *mb)
+static void pci_doe_cancel_tasks(struct pci_doe_mb *doe_mb)
 {
-	struct pci_doe_mb *doe_mb = mb;
-
-	xa_destroy(&doe_mb->prots);
-}
-
-static void pci_doe_destroy_workqueue(void *mb)
-{
-	struct pci_doe_mb *doe_mb = mb;
-
-	destroy_workqueue(doe_mb->work_queue);
-}
-
-static void pci_doe_cancel_tasks(void *mb)
-{
-	struct pci_doe_mb *doe_mb = mb;
-
 	/* Stop all pending work items from starting */
 	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
 
@@ -442,7 +426,7 @@ static void pci_doe_cancel_tasks(void *mb)
 }
 
 /**
- * pcim_doe_create_mb() - Create a DOE mailbox object
+ * pci_doe_create_mb() - Create a DOE mailbox object
  *
  * @pdev: PCI device to create the DOE mailbox for
  * @cap_offset: Offset of the DOE mailbox
@@ -453,24 +437,20 @@ static void pci_doe_cancel_tasks(void *mb)
  * RETURNS: created mailbox object on success
  *	    ERR_PTR(-errno) on failure
  */
-struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
+static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
+					    u16 cap_offset)
 {
 	struct pci_doe_mb *doe_mb;
-	struct device *dev = &pdev->dev;
 	int rc;
 
-	doe_mb = devm_kzalloc(dev, sizeof(*doe_mb), GFP_KERNEL);
+	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
 	if (!doe_mb)
 		return ERR_PTR(-ENOMEM);
 
 	doe_mb->pdev = pdev;
 	doe_mb->cap_offset = cap_offset;
 	init_waitqueue_head(&doe_mb->wq);
-
 	xa_init(&doe_mb->prots);
-	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
 
 	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
 						dev_driver_string(&pdev->dev),
@@ -479,36 +459,85 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
 	if (!doe_mb->work_queue) {
 		pci_err(pdev, "[%x] failed to allocate work queue\n",
 			doe_mb->cap_offset);
-		return ERR_PTR(-ENOMEM);
+		rc = -ENOMEM;
+		goto err_free;
 	}
-	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
 
 	/* Reset the mailbox by issuing an abort */
 	rc = pci_doe_abort(doe_mb);
 	if (rc) {
 		pci_err(pdev, "[%x] failed to reset mailbox with abort command : %d\n",
 			doe_mb->cap_offset, rc);
-		return ERR_PTR(rc);
+		goto err_destroy_wq;
 	}
 
 	/*
 	 * The state machine and the mailbox should be in sync now;
-	 * Set up cancel tasks prior to using the mailbox to query protocols.
+	 * Use the mailbox to query protocols.
 	 */
-	rc = devm_add_action_or_reset(dev, pci_doe_cancel_tasks, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
-
 	rc = pci_doe_cache_protocols(doe_mb);
 	if (rc) {
 		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
 			doe_mb->cap_offset, rc);
-		return ERR_PTR(rc);
+		goto err_cancel;
 	}
 
 	return doe_mb;
+
+err_cancel:
+	pci_doe_cancel_tasks(doe_mb);
+	xa_destroy(&doe_mb->prots);
+err_destroy_wq:
+	destroy_workqueue(doe_mb->work_queue);
+err_free:
+	kfree(doe_mb);
+	return ERR_PTR(rc);
+}
+
+/**
+ * pci_doe_destroy_mb() - Destroy a DOE mailbox object
+ *
+ * @ptr: Pointer to DOE mailbox
+ *
+ * Destroy all internal data structures created for the DOE mailbox.
+ */
+static void pci_doe_destroy_mb(void *ptr)
+{
+	struct pci_doe_mb *doe_mb = ptr;
+
+	pci_doe_cancel_tasks(doe_mb);
+	xa_destroy(&doe_mb->prots);
+	destroy_workqueue(doe_mb->work_queue);
+	kfree(doe_mb);
+}
+
+/**
+ * pcim_doe_create_mb() - Create a DOE mailbox object
+ *
+ * @pdev: PCI device to create the DOE mailbox for
+ * @cap_offset: Offset of the DOE mailbox
+ *
+ * Create a single mailbox object to manage the mailbox protocol at the
+ * cap_offset specified.  The mailbox will automatically be destroyed on
+ * driver unbinding from @pdev.
+ *
+ * RETURNS: created mailbox object on success
+ *	    ERR_PTR(-errno) on failure
+ */
+struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
+{
+	struct pci_doe_mb *doe_mb;
+	int rc;
+
+	doe_mb = pci_doe_create_mb(pdev, cap_offset);
+	if (IS_ERR(doe_mb))
+		return doe_mb;
+
+	rc = devm_add_action_or_reset(&pdev->dev, pci_doe_destroy_mb, doe_mb);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return doe_mb;
 }
 EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
 
-- 
2.39.1

