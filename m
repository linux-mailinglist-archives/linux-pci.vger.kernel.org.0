Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1886467795C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjAWKlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjAWKln (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:41:43 -0500
X-Greylist: delayed 726 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 02:41:41 PST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6383418A8E;
        Mon, 23 Jan 2023 02:41:41 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 16BE510189E10;
        Mon, 23 Jan 2023 11:41:40 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E68F9600D2E1;
        Mon, 23 Jan 2023 11:41:39 +0100 (CET)
X-Mailbox-Line: From b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2 Mon Sep 17 00:00:00 2001
Message-Id: <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
In-Reply-To: <cover.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 23 Jan 2023 11:14:00 +0100
Subject: [PATCH v2 04/10] cxl/pci: Use synchronous API for DOE
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

A synchronous API for DOE has just been introduced.  Convert CXL CDAT
retrieval over to it.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
---
 drivers/cxl/core/pci.c | 62 ++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 57764e9cd19d..a02a2b005e6a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -487,51 +487,26 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
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
-		dev_err(dev, "DOE submit failed: %d", rc);
+		dev_err(dev, "DOE failed: %d", rc);
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
@@ -546,26 +521,29 @@ static int cxl_cdat_read_table(struct device *dev,
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
-			dev_err(dev, "DOE submit failed: %d", rc);
+			dev_err(dev, "DOE failed: %d", rc);
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
-- 
2.39.1

