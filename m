Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9363A0AC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 05:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiK1Epl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 23:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK1Epi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 23:45:38 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145F1FCF
        for <linux-pci@vger.kernel.org>; Sun, 27 Nov 2022 20:45:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id A06091002A061;
        Mon, 28 Nov 2022 05:39:33 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 597C8603E021;
        Mon, 28 Nov 2022 05:39:33 +0100 (CET)
X-Mailbox-Line: From 7ced46eaf68bed71b6414a93ac41f26cfd54a991 Mon Sep 17 00:00:00 2001
Message-Id: <7ced46eaf68bed71b6414a93ac41f26cfd54a991.1669608950.git.lukas@wunner.de>
In-Reply-To: <cover.1669608950.git.lukas@wunner.de>
References: <cover.1669608950.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 28 Nov 2022 05:25:52 +0100
Subject: [PATCH 2/2] PCI/DOE: Provide synchronous API
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, linux-cxl@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DOE API only allows asynchronous exchanges and forces callers to
provide a completion callback.  Yet all existing callers only perform
synchronous exchanges.  Upcoming patches for CMA (Component Measurement
and Authentication, PCIe r6.0.1 sec 6.31) likewise require only
synchronous DOE exchanges.  Asynchronous users are currently not
foreseeable.

Provide a synchronous pci_doe() API call which builds on the internal
asynchronous machinery.  Should asynchronous users appear, reintroducing
a pci_doe_async() API call will be trivial.

Convert all users to the new synchronous API and make the asynchronous
pci_doe_submit_task() as well as the pci_doe_task struct private.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/cxl/core/pci.c  |  58 +++++++--------------
 drivers/pci/doe.c       | 112 ++++++++++++++++++++++++++++++++++------
 include/linux/pci-doe.h |  47 ++---------------
 3 files changed, 116 insertions(+), 101 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..743105feb646 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -490,51 +490,26 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
 		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
 	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
 
-static void cxl_doe_task_complete(struct pci_doe_task *task)
-{
-	complete(task->private);
-}
-
-struct cdat_doe_task {
-	u32 request_pl;
-	u32 response_pl[32];
-	struct completion c;
-	struct pci_doe_task task;
-};
-
-#define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
-struct cdat_doe_task cdt = {                                  \
-	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
-	.request_pl = req,				      \
-	.task = {                                             \
-		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
-		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS, \
-		.request_pl = &cdt.request_pl,                \
-		.request_pl_sz = sizeof(cdt.request_pl),      \
-		.response_pl = cdt.response_pl,               \
-		.response_pl_sz = sizeof(cdt.response_pl),    \
-		.complete = cxl_doe_task_complete,            \
-		.private = &cdt.c,                            \
-	}                                                     \
-}
-
 static int cxl_cdat_get_length(struct device *dev,
 			       struct pci_doe_mb *cdat_doe,
 			       size_t *length)
 {
-	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
+	u32 request = CDAT_DOE_REQ(0);
+	u32 response[32];
 	int rc;
 
-	rc = pci_doe_submit_task(cdat_doe, &t.task);
+	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
+		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
+		     &request, sizeof(request),
+		     &response, sizeof(response));
 	if (rc < 0) {
 		dev_err(dev, "DOE submit failed: %d", rc);
 		return rc;
 	}
-	wait_for_completion(&t.c);
-	if (t.task.rv < sizeof(u32))
+	if (rc < sizeof(u32))
 		return -EIO;
 
-	*length = t.response_pl[1];
+	*length = response[1];
 	dev_dbg(dev, "CDAT length %zu\n", *length);
 
 	return 0;
@@ -549,26 +524,29 @@ static int cxl_cdat_read_table(struct device *dev,
 	int entry_handle = 0;
 
 	do {
-		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
+		u32 request = CDAT_DOE_REQ(entry_handle);
+		u32 response[32];
 		size_t entry_dw;
 		u32 *entry;
 		int rc;
 
-		rc = pci_doe_submit_task(cdat_doe, &t.task);
+		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
+			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
+			     &request, sizeof(request),
+			     &response, sizeof(response));
 		if (rc < 0) {
 			dev_err(dev, "DOE submit failed: %d", rc);
 			return rc;
 		}
-		wait_for_completion(&t.c);
 		/* 1 DW header + 1 DW data min */
-		if (t.task.rv < (2 * sizeof(u32)))
+		if (rc < (2 * sizeof(u32)))
 			return -EIO;
 
 		/* Get the CXL table access header entry handle */
 		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
-					 t.response_pl[0]);
-		entry = t.response_pl + 1;
-		entry_dw = t.task.rv / sizeof(u32);
+					 response[0]);
+		entry = response + 1;
+		entry_dw = rc / sizeof(u32);
 		/* Skip Header */
 		entry_dw -= 1;
 		entry_dw = min(length / sizeof(u32), entry_dw);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 52541eac17f1..7d1eb5bef4b5 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -56,6 +56,49 @@ struct pci_doe_mb {
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
+ *
+ * NOTE there is no need for the caller to initialize work or doe_mb.
+ */
+struct pci_doe_task {
+	struct pci_doe_protocol prot;
+	u32 *request_pl;
+	size_t request_pl_sz;
+	u32 *response_pl;
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
@@ -318,26 +361,15 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
 				    *index);
 	u32 response_pl;
-	DECLARE_COMPLETION_ONSTACK(c);
-	struct pci_doe_task task = {
-		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
-		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
-		.request_pl = &request_pl,
-		.request_pl_sz = sizeof(request_pl),
-		.response_pl = &response_pl,
-		.response_pl_sz = sizeof(response_pl),
-		.complete = pci_doe_task_complete,
-		.private = &c,
-	};
 	int rc;
 
-	rc = pci_doe_submit_task(doe_mb, &task);
+	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_PROTOCOL_DISCOVERY,
+		     &request_pl, sizeof(request_pl),
+		     &response_pl, sizeof(response_pl));
 	if (rc < 0)
 		return rc;
 
-	wait_for_completion(&c);
-
-	if (task.rv != sizeof(response_pl))
+	if (rc != sizeof(response_pl))
 		return -EIO;
 
 	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
@@ -524,7 +556,8 @@ EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
  *
  * RETURNS: 0 when task has been successfully queued, -ERRNO on error
  */
-int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
+static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
+			       struct pci_doe_task *task)
 {
 	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
 		return -EINVAL;
@@ -545,4 +578,49 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 	queue_work(doe_mb->work_queue, &task->work);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_doe_submit_task);
+
+/**
+ * pci_doe() - Perform Data Object Exchange
+ *
+ * @doe_mb: DOE Mailbox
+ * @vendor: Vendor ID
+ * @type: Data Object Type
+ * @request: Request payload
+ * @request_sz: Size of request payload (bytes)
+ * @response: Response payload
+ * @response_sz: Size of response payload (bytes)
+ *
+ * Submit @request to @doe_mb and store the @response.
+ * The DOE exchange is performed synchronously and may therefore sleep.
+ *
+ * RETURNS: Length of received response or negative errno.
+ * Received data in excess of @response_sz is discarded.
+ * The length may be smaller than @response_sz and the caller
+ * is responsible for checking that.
+ */
+int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
+	    void *request, size_t request_sz,
+	    void *response, size_t response_sz)
+{
+	DECLARE_COMPLETION_ONSTACK(c);
+	struct pci_doe_task task = {
+		.prot.vid = vendor,
+		.prot.type = type,
+		.request_pl = request,
+		.request_pl_sz = request_sz,
+		.response_pl = response,
+		.response_pl_sz = response_sz,
+		.complete = pci_doe_task_complete,
+		.private = &c,
+	};
+	int rc;
+
+	rc = pci_doe_submit_task(doe_mb, &task);
+	if (rc)
+		return rc;
+
+	wait_for_completion(&c);
+
+	return task.rv;
+}
+EXPORT_SYMBOL_GPL(pci_doe);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index ed9b4df792b8..d6a07c8fe0b2 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -13,51 +13,8 @@
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
-	u32 *request_pl;
-	size_t request_pl_sz;
-	u32 *response_pl;
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
@@ -72,6 +29,8 @@ struct pci_doe_task {
 
 struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
 bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
-int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
+int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
+	    void *request, size_t request_sz,
+	    void *response, size_t response_sz);
 
 #endif
-- 
2.36.1

