Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E375667797E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAWKrm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjAWKrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:47:36 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E361F5C1
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:47:33 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 06A6D101920DC;
        Mon, 23 Jan 2023 11:47:29 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id D3C94600D2E1;
        Mon, 23 Jan 2023 11:47:28 +0100 (CET)
X-Mailbox-Line: From 291131574c9e625195e9c34591abf5fa75cd1279 Mon Sep 17 00:00:00 2001
Message-Id: <291131574c9e625195e9c34591abf5fa75cd1279.1674468099.git.lukas@wunner.de>
In-Reply-To: <cover.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 23 Jan 2023 11:16:00 +0100
Subject: [PATCH v2 06/10] PCI/DOE: Allow mailbox creation without devres
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
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/doe.c | 103 +++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 066400531d09..cc1fdd75ad2a 100644
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
@@ -412,20 +412,6 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 	return 0;
 }
 
-static void pci_doe_xa_destroy(void *mb)
-{
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
 static void pci_doe_flush_mb(void *mb)
 {
 	struct pci_doe_mb *doe_mb = mb;
@@ -442,7 +428,7 @@ static void pci_doe_flush_mb(void *mb)
 }
 
 /**
- * pcim_doe_create_mb() - Create a DOE mailbox object
+ * pci_doe_create_mb() - Create a DOE mailbox object
  *
  * @pdev: PCI device to create the DOE mailbox for
  * @cap_offset: Offset of the DOE mailbox
@@ -453,24 +439,20 @@ static void pci_doe_flush_mb(void *mb)
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
@@ -479,35 +461,90 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
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
-	 * Set up mailbox flush prior to using the mailbox to query protocols.
+	 * Use the mailbox to query protocols.
 	 */
-	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
-
 	rc = pci_doe_cache_protocols(doe_mb);
 	if (rc) {
 		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
 			doe_mb->cap_offset, rc);
+		goto err_flush;
+	}
+
+	return doe_mb;
+
+err_flush:
+	pci_doe_flush_mb(doe_mb);
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
+	rc = devm_add_action(&pdev->dev, pci_doe_destroy_mb, doe_mb);
+	if (rc) {
+		pci_doe_flush_mb(doe_mb);
+		pci_doe_destroy_mb(doe_mb);
 		return ERR_PTR(rc);
 	}
 
+	rc = devm_add_action_or_reset(&pdev->dev, pci_doe_flush_mb, doe_mb);
+	if (rc)
+		return ERR_PTR(rc);
+
 	return doe_mb;
 }
 EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
-- 
2.39.1

