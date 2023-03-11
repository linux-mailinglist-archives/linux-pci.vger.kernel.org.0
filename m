Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287256B5D28
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjCKPGr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 10:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKPGp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 10:06:45 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A511E6D1;
        Sat, 11 Mar 2023 07:06:33 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id EEFFD10333009;
        Sat, 11 Mar 2023 16:06:31 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id AA384600C543;
        Sat, 11 Mar 2023 16:06:31 +0100 (CET)
X-Mailbox-Line: From cc19544068483681e91dfe27545c2180cd09f931 Mon Sep 17 00:00:00 2001
Message-Id: <cc19544068483681e91dfe27545c2180cd09f931.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:09 +0100
Subject: [PATCH v4 09/17] PCI/DOE: Make asynchronous API private
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A synchronous API for DOE has just been introduced.  CXL (the only
in-tree DOE user so far) was converted to use it instead of the
asynchronous API.

Consequently, pci_doe_submit_task() as well as the pci_doe_task struct
are only used internally, so make them private.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ming Li <ming4.li@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/doe.c       | 45 ++++++++++++++++++++++++++++++++++++--
 include/linux/pci-doe.h | 48 -----------------------------------------
 2 files changed, 43 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index adde8c66499c..dfdec73f6abc 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -56,6 +56,47 @@ struct pci_doe_mb {
 	unsigned long flags;
 };
 
+struct pci_doe_protocol {
+	u16 vid;
+	u8 type;
+};
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
+ */
+struct pci_doe_task {
+	struct pci_doe_protocol prot;
+	const __le32 *request_pl;
+	size_t request_pl_sz;
+	__le32 *response_pl;
+	size_t response_pl_sz;
+	int rv;
+	void (*complete)(struct pci_doe_task *task);
+	void *private;
+
+	/* initialized by pci_doe_submit_task() */
+	struct work_struct work;
+	struct pci_doe_mb *doe_mb;
+};
+
 static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
 {
 	if (wait_event_timeout(doe_mb->wq,
@@ -519,7 +560,8 @@ EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
  *
  * RETURNS: 0 when task has been successfully queued, -ERRNO on error
  */
-int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
+static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
+			       struct pci_doe_task *task)
 {
 	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
 		return -EINVAL;
@@ -540,7 +582,6 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 	queue_work(doe_mb->work_queue, &task->work);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_doe_submit_task);
 
 /**
  * pci_doe() - Perform Data Object Exchange
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 5dcd54f892e5..7f16749c6aa3 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -13,55 +13,8 @@
 #ifndef LINUX_PCI_DOE_H
 #define LINUX_PCI_DOE_H
 
-struct pci_doe_protocol {
-	u16 vid;
-	u8 type;
-};
-
 struct pci_doe_mb;
 
-/**
- * struct pci_doe_task - represents a single query/response
- *
- * @prot: DOE Protocol
- * @request_pl: The request payload
- * @request_pl_sz: Size of the request payload (bytes)
- * @response_pl: The response payload
- * @response_pl_sz: Size of the response payload (bytes)
- * @rv: Return value.  Length of received response or error (bytes)
- * @complete: Called when task is complete
- * @private: Private data for the consumer
- * @work: Used internally by the mailbox
- * @doe_mb: Used internally by the mailbox
- *
- * Payloads are treated as opaque byte streams which are transmitted verbatim,
- * without byte-swapping.  If payloads contain little-endian register values,
- * the caller is responsible for conversion with cpu_to_le32() / le32_to_cpu().
- *
- * The payload sizes and rv are specified in bytes with the following
- * restrictions concerning the protocol.
- *
- *	1) The request_pl_sz must be a multiple of double words (4 bytes)
- *	2) The response_pl_sz must be >= a single double word (4 bytes)
- *	3) rv is returned as bytes but it will be a multiple of double words
- *
- * NOTE there is no need for the caller to initialize work or doe_mb.
- */
-struct pci_doe_task {
-	struct pci_doe_protocol prot;
-	const __le32 *request_pl;
-	size_t request_pl_sz;
-	__le32 *response_pl;
-	size_t response_pl_sz;
-	int rv;
-	void (*complete)(struct pci_doe_task *task);
-	void *private;
-
-	/* No need for the user to initialize these fields */
-	struct work_struct work;
-	struct pci_doe_mb *doe_mb;
-};
-
 /**
  * pci_doe_for_each_off - Iterate each DOE capability
  * @pdev: struct pci_dev to iterate
@@ -76,7 +29,6 @@ struct pci_doe_task {
 
 struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
 bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
-int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
 
 int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 	    const void *request, size_t request_sz,
-- 
2.39.1

