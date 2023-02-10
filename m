Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2AE69284F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjBJUae (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjBJUad (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:30:33 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31D3C13;
        Fri, 10 Feb 2023 12:30:32 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 3FCEC10333019;
        Fri, 10 Feb 2023 21:30:30 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E6AA9600CA83;
        Fri, 10 Feb 2023 21:30:29 +0100 (CET)
X-Mailbox-Line: From bbbe1c4f3788052865941572565aeb2be67a6770 Mon Sep 17 00:00:00 2001
Message-Id: <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:01 +0100
Subject: [PATCH v3 01/16] cxl/pci: Fix CDAT retrieval on big endian
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

The CDAT exposed in sysfs differs between little endian and big endian
arches:  On big endian, every 4 bytes are byte-swapped.

PCI Configuration Space is little endian (PCI r3.0 sec 6.1).  Accessors
such as pci_read_config_dword() implicitly swap bytes on big endian.
That way, the macros in include/uapi/linux/pci_regs.h work regardless of
the arch's endianness.  For an example of implicit byte-swapping, see
ppc4xx_pciex_read_config(), which calls in_le32(), which uses lwbrx
(Load Word Byte-Reverse Indexed).

DOE Read/Write Data Mailbox Registers are unlike other registers in
Configuration Space in that they contain or receive a 4 byte portion of
an opaque byte stream (a "Data Object" per PCIe r6.0 sec 7.9.24.5f).
They need to be copied to or from the request/response buffer verbatim.
So amend pci_doe_send_req() and pci_doe_recv_resp() to undo the implicit
byte-swapping.

The CXL_DOE_TABLE_ACCESS_* and PCI_DOE_DATA_OBJECT_DISC_* macros assume
implicit byte-swapping.  Byte-swap requests after constructing them with
those macros and byte-swap responses before parsing them.

Change the request and response type to __le32 to avoid sparse warnings.

Fixes: c97006046c79 ("cxl/port: Read CDAT table")
Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.0+
---
 Changes v2 -> v3:
 * Newly added patch in v3

 drivers/cxl/core/pci.c  | 12 ++++++------
 drivers/pci/doe.c       | 13 ++++++++-----
 include/linux/pci-doe.h |  8 ++++++--
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 57764e9cd19d..d3cf1d9d67d4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -480,7 +480,7 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
 	return NULL;
 }
 
-#define CDAT_DOE_REQ(entry_handle)					\
+#define CDAT_DOE_REQ(entry_handle) cpu_to_le32				\
 	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
 		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
 	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
@@ -493,8 +493,8 @@ static void cxl_doe_task_complete(struct pci_doe_task *task)
 }
 
 struct cdat_doe_task {
-	u32 request_pl;
-	u32 response_pl[32];
+	__le32 request_pl;
+	__le32 response_pl[32];
 	struct completion c;
 	struct pci_doe_task task;
 };
@@ -531,7 +531,7 @@ static int cxl_cdat_get_length(struct device *dev,
 	if (t.task.rv < sizeof(u32))
 		return -EIO;
 
-	*length = t.response_pl[1];
+	*length = le32_to_cpu(t.response_pl[1]);
 	dev_dbg(dev, "CDAT length %zu\n", *length);
 
 	return 0;
@@ -548,7 +548,7 @@ static int cxl_cdat_read_table(struct device *dev,
 	do {
 		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
 		size_t entry_dw;
-		u32 *entry;
+		__le32 *entry;
 		int rc;
 
 		rc = pci_doe_submit_task(cdat_doe, &t.task);
@@ -563,7 +563,7 @@ static int cxl_cdat_read_table(struct device *dev,
 
 		/* Get the CXL table access header entry handle */
 		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
-					 t.response_pl[0]);
+					 le32_to_cpu(t.response_pl[0]));
 		entry = t.response_pl + 1;
 		entry_dw = t.task.rv / sizeof(u32);
 		/* Skip Header */
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 66d9ab288646..69efa9a250b9 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -143,7 +143,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 					  length));
 	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
 		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
-				       task->request_pl[i]);
+				       le32_to_cpu(task->request_pl[i]));
 
 	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
 
@@ -198,8 +198,8 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	payload_length = min(length, task->response_pl_sz / sizeof(u32));
 	/* Read the rest of the response payload */
 	for (i = 0; i < payload_length; i++) {
-		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
-				      &task->response_pl[i]);
+		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
+		task->response_pl[i] = cpu_to_le32(val);
 		/* Prior to the last ack, ensure Data Object Ready */
 		if (i == (payload_length - 1) && !pci_doe_data_obj_ready(doe_mb))
 			return -EIO;
@@ -322,15 +322,17 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 	struct pci_doe_task task = {
 		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
 		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
-		.request_pl = &request_pl,
+		.request_pl = (__le32 *)&request_pl,
 		.request_pl_sz = sizeof(request_pl),
-		.response_pl = &response_pl,
+		.response_pl = (__le32 *)&response_pl,
 		.response_pl_sz = sizeof(response_pl),
 		.complete = pci_doe_task_complete,
 		.private = &c,
 	};
 	int rc;
 
+	cpu_to_le32s(&request_pl);
+
 	rc = pci_doe_submit_task(doe_mb, &task);
 	if (rc < 0)
 		return rc;
@@ -340,6 +342,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
 	if (task.rv != sizeof(response_pl))
 		return -EIO;
 
+	le32_to_cpus(&response_pl);
 	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
 	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
 			      response_pl);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index ed9b4df792b8..43765eaf2342 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -34,6 +34,10 @@ struct pci_doe_mb;
  * @work: Used internally by the mailbox
  * @doe_mb: Used internally by the mailbox
  *
+ * Payloads are treated as opaque byte streams which are transmitted verbatim,
+ * without byte-swapping.  If payloads contain little-endian register values,
+ * the caller is responsible for conversion with cpu_to_le32() / le32_to_cpu().
+ *
  * The payload sizes and rv are specified in bytes with the following
  * restrictions concerning the protocol.
  *
@@ -45,9 +49,9 @@ struct pci_doe_mb;
  */
 struct pci_doe_task {
 	struct pci_doe_protocol prot;
-	u32 *request_pl;
+	__le32 *request_pl;
 	size_t request_pl_sz;
-	u32 *response_pl;
+	__le32 *response_pl;
 	size_t response_pl_sz;
 	int rv;
 	void (*complete)(struct pci_doe_task *task);
-- 
2.39.1

