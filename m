Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCE96B5D20
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCKPCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 10:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCKPCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 10:02:53 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8132FCE1;
        Sat, 11 Mar 2023 07:02:51 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 196AF100FBD1B;
        Sat, 11 Mar 2023 16:02:50 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C70AC600C543;
        Sat, 11 Mar 2023 16:02:49 +0100 (CET)
X-Mailbox-Line: From 0f444206da9615c56301fbaff459c0f45d27f122 Mon Sep 17 00:00:00 2001
Message-Id: <0f444206da9615c56301fbaff459c0f45d27f122.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:07 +0100
Subject: [PATCH v4 07/17] PCI/DOE: Provide synchronous API and use it
 internally
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

The DOE API only allows asynchronous exchanges and forces callers to
provide a completion callback.  Yet all existing callers only perform
synchronous exchanges.  Upcoming commits for CMA (Component Measurement
and Authentication, PCIe r6.0 sec 6.31) likewise require only
synchronous DOE exchanges.

Provide a synchronous pci_doe() API call which builds on the internal
asynchronous machinery.

Convert the internal pci_doe_discovery() to the new call.

The new API allows submission of const-declared requests, necessitating
the addition of a const qualifier in struct pci_doe_task.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ming Li <ming4.li@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/doe.c       | 69 ++++++++++++++++++++++++++++++++---------
 include/linux/pci-doe.h |  6 +++-
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e5e9b287b976..adde8c66499c 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -321,26 +321,15 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 	__le32 request_pl_le = cpu_to_le32(request_pl);
 	__le32 response_pl_le;
 	u32 response_pl;
-	DECLARE_COMPLETION_ONSTACK(c);
-	struct pci_doe_task task = {
-		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
-		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
-		.request_pl = &request_pl_le,
-		.request_pl_sz = sizeof(request_pl),
-		.response_pl = &response_pl_le,
-		.response_pl_sz = sizeof(response_pl),
-		.complete = pci_doe_task_complete,
-		.private = &c,
-	};
 	int rc;
 
-	rc = pci_doe_submit_task(doe_mb, &task);
+	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_PROTOCOL_DISCOVERY,
+		     &request_pl_le, sizeof(request_pl_le),
+		     &response_pl_le, sizeof(response_pl_le));
 	if (rc < 0)
 		return rc;
 
-	wait_for_completion(&c);
-
-	if (task.rv != sizeof(response_pl))
+	if (rc != sizeof(response_pl_le))
 		return -EIO;
 
 	response_pl = le32_to_cpu(response_pl_le);
@@ -552,3 +541,53 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_doe_submit_task);
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
+ * Payloads are treated as opaque byte streams which are transmitted verbatim,
+ * without byte-swapping.  If payloads contain little-endian register values,
+ * the caller is responsible for conversion with cpu_to_le32() / le32_to_cpu().
+ *
+ * RETURNS: Length of received response or negative errno.
+ * Received data in excess of @response_sz is discarded.
+ * The length may be smaller than @response_sz and the caller
+ * is responsible for checking that.
+ */
+int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
+	    const void *request, size_t request_sz,
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
index 43765eaf2342..5dcd54f892e5 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -49,7 +49,7 @@ struct pci_doe_mb;
  */
 struct pci_doe_task {
 	struct pci_doe_protocol prot;
-	__le32 *request_pl;
+	const __le32 *request_pl;
 	size_t request_pl_sz;
 	__le32 *response_pl;
 	size_t response_pl_sz;
@@ -78,4 +78,8 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
 bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
 int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
 
+int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
+	    const void *request, size_t request_sz,
+	    void *response, size_t response_sz);
+
 #endif
-- 
2.39.1

