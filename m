Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE76779A0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjAWKyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjAWKym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:54:42 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7055CA10;
        Mon, 23 Jan 2023 02:54:40 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 4F0E7101E6AFE;
        Mon, 23 Jan 2023 11:54:39 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 0FB6B600D2E1;
        Mon, 23 Jan 2023 11:54:39 +0100 (CET)
X-Mailbox-Line: From 3dca6f956342707fb69cba94a771f3d4d2f5f3b4 Mon Sep 17 00:00:00 2001
Message-Id: <3dca6f956342707fb69cba94a771f3d4d2f5f3b4.1674468099.git.lukas@wunner.de>
In-Reply-To: <cover.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 23 Jan 2023 11:19:00 +0100
Subject: [PATCH v2 09/10] PCI/DOE: Make mailbox creation API private
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI core has just been amended to create a pci_doe_mb struct for
every DOE instance on device enumeration.  CXL (the only in-tree DOE
user so far) has been migrated to use those mailboxes instead of
creating its own.

That leaves pcim_doe_create_mb() and pci_doe_for_each_off() without any
callers, so drop them.

pci_doe_supports_prot() is now only used internally, so declare it
static.

pci_doe_flush_mb() and pci_doe_destroy_mb() are no longer used as
callbacks for devm_add_action(), so refactor them to accept a
struct pci_doe_mb pointer instead of a generic void pointer.

Because pci_doe_create_mb() is only called on device enumeration, i.e.
before driver binding, the workqueue name never contains a driver name.
So replace dev_driver_string() with dev_bus_name() when generating the
workqueue name.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 .clang-format           |  1 -
 drivers/pci/doe.c       | 52 ++++-------------------------------------
 include/linux/pci-doe.h | 14 -----------
 3 files changed, 5 insertions(+), 62 deletions(-)

diff --git a/.clang-format b/.clang-format
index b62836419ea3..cb1c17c7fcc9 100644
--- a/.clang-format
+++ b/.clang-format
@@ -520,7 +520,6 @@ ForEachMacros:
   - 'of_property_for_each_string'
   - 'of_property_for_each_u32'
   - 'pci_bus_for_each_resource'
-  - 'pci_doe_for_each_off'
   - 'pcl_for_each_chunk'
   - 'pcl_for_each_segment'
   - 'pcm_for_each_format'
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 06c57af05570..0263bcfdddd8 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -414,10 +414,8 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
 	return 0;
 }
 
-static void pci_doe_flush_mb(void *mb)
+static void pci_doe_flush_mb(struct pci_doe_mb *doe_mb)
 {
-	struct pci_doe_mb *doe_mb = mb;
-
 	/* Stop all pending work items from starting */
 	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
 
@@ -457,7 +455,7 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 	xa_init(&doe_mb->prots);
 
 	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
-						dev_driver_string(&pdev->dev),
+						dev_bus_name(&pdev->dev),
 						pci_name(pdev),
 						doe_mb->cap_offset);
 	if (!doe_mb->work_queue) {
@@ -501,56 +499,17 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 /**
  * pci_doe_destroy_mb() - Destroy a DOE mailbox object
  *
- * @ptr: Pointer to DOE mailbox
+ * @doe_mb: DOE mailbox
  *
  * Destroy all internal data structures created for the DOE mailbox.
  */
-static void pci_doe_destroy_mb(void *ptr)
+static void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
 {
-	struct pci_doe_mb *doe_mb = ptr;
-
 	xa_destroy(&doe_mb->prots);
 	destroy_workqueue(doe_mb->work_queue);
 	kfree(doe_mb);
 }
 
-/**
- * pcim_doe_create_mb() - Create a DOE mailbox object
- *
- * @pdev: PCI device to create the DOE mailbox for
- * @cap_offset: Offset of the DOE mailbox
- *
- * Create a single mailbox object to manage the mailbox protocol at the
- * cap_offset specified.  The mailbox will automatically be destroyed on
- * driver unbinding from @pdev.
- *
- * RETURNS: created mailbox object on success
- *	    ERR_PTR(-errno) on failure
- */
-struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
-{
-	struct pci_doe_mb *doe_mb;
-	int rc;
-
-	doe_mb = pci_doe_create_mb(pdev, cap_offset);
-	if (IS_ERR(doe_mb))
-		return doe_mb;
-
-	rc = devm_add_action(&pdev->dev, pci_doe_destroy_mb, doe_mb);
-	if (rc) {
-		pci_doe_flush_mb(doe_mb);
-		pci_doe_destroy_mb(doe_mb);
-		return ERR_PTR(rc);
-	}
-
-	rc = devm_add_action_or_reset(&pdev->dev, pci_doe_flush_mb, doe_mb);
-	if (rc)
-		return ERR_PTR(rc);
-
-	return doe_mb;
-}
-EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
-
 /**
  * pci_doe_supports_prot() - Return if the DOE instance supports the given
  *			     protocol
@@ -560,7 +519,7 @@ EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
  *
  * RETURNS: True if the DOE mailbox supports the protocol specified
  */
-bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
+static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 {
 	unsigned long index;
 	void *entry;
@@ -575,7 +534,6 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
 
 /**
  * pci_doe_submit_task() - Submit a task to be processed by the state machine
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index d6192ee0ac07..1f14aed4354b 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -15,20 +15,6 @@
 
 struct pci_doe_mb;
 
-/**
- * pci_doe_for_each_off - Iterate each DOE capability
- * @pdev: struct pci_dev to iterate
- * @off: u16 of config space offset of each mailbox capability found
- */
-#define pci_doe_for_each_off(pdev, off) \
-	for (off = pci_find_next_ext_capability(pdev, off, \
-					PCI_EXT_CAP_ID_DOE); \
-		off > 0; \
-		off = pci_find_next_ext_capability(pdev, off, \
-					PCI_EXT_CAP_ID_DOE))
-
-struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
-bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
-- 
2.39.1

