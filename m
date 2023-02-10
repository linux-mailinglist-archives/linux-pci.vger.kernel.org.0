Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B16928A0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjBJUrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjBJUrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:47:14 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E2C7DD31;
        Fri, 10 Feb 2023 12:47:12 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 46B6710330AD1;
        Fri, 10 Feb 2023 21:47:11 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E6A7C600CA83;
        Fri, 10 Feb 2023 21:47:10 +0100 (CET)
X-Mailbox-Line: From 00c86bd08682a61a1f210b7fb08bbc59ee1a0fe4 Mon Sep 17 00:00:00 2001
Message-Id: <00c86bd08682a61a1f210b7fb08bbc59ee1a0fe4.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:08 +0100
Subject: [PATCH v3 08/16] cxl/pci: Use synchronous API for DOE
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c | 66 ++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c37c41d7acb6..09a9fa67d12a 100644
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
-	__le32 request_pl;
-	__le32 response_pl[32];
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
+	__le32 request = CDAT_DOE_REQ(0);
+	__le32 response[32];
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
-	if (t.task.rv < 2 * sizeof(u32))
+	if (rc < 2 * sizeof(u32))
 		return -EIO;
 
-	*length = le32_to_cpu(t.response_pl[1]);
+	*length = le32_to_cpu(response[1]);
 	dev_dbg(dev, "CDAT length %zu\n", *length);
 
 	return 0;
@@ -546,31 +521,34 @@ static int cxl_cdat_read_table(struct device *dev,
 	int entry_handle = 0;
 
 	do {
-		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
+		__le32 request = CDAT_DOE_REQ(entry_handle);
 		struct cdat_entry_header *entry;
+		__le32 response[32];
 		size_t entry_dw;
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
 
 		/* 1 DW Table Access Response Header + CDAT entry */
-		entry = (struct cdat_entry_header *)(t.response_pl + 1);
+		entry = (struct cdat_entry_header *)(response + 1);
 		if ((entry_handle == 0 &&
-		     t.task.rv != sizeof(u32) + sizeof(struct cdat_header)) ||
+		     rc != sizeof(u32) + sizeof(struct cdat_header)) ||
 		    (entry_handle > 0 &&
-		     (t.task.rv < sizeof(u32) + sizeof(struct cdat_entry_header) ||
-		      t.task.rv != sizeof(u32) + le16_to_cpu(entry->length))))
+		     (rc < sizeof(u32) + sizeof(struct cdat_entry_header) ||
+		      rc != sizeof(u32) + le16_to_cpu(entry->length))))
 			return -EIO;
 
 		/* Get the CXL table access header entry handle */
 		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
-					 le32_to_cpu(t.response_pl[0]));
-		entry_dw = t.task.rv / sizeof(u32);
+					 le32_to_cpu(response[0]));
+		entry_dw = rc / sizeof(u32);
 		/* Skip Header */
 		entry_dw -= 1;
 		entry_dw = min(length / sizeof(u32), entry_dw);
-- 
2.39.1

