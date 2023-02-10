Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3906928E6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 22:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjBJVC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 16:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVC2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 16:02:28 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97F818B26;
        Fri, 10 Feb 2023 13:02:26 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 5F38D1019263E;
        Fri, 10 Feb 2023 22:02:25 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 2F089600CA83;
        Fri, 10 Feb 2023 22:02:25 +0100 (CET)
X-Mailbox-Line: From fdb52e091b62b34c2036a61ae9ab8087dba4e4db Mon Sep 17 00:00:00 2001
Message-Id: <fdb52e091b62b34c2036a61ae9ab8087dba4e4db.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:15 +0100
Subject: [PATCH v3 15/16] PCI/DOE: Relax restrictions on request and response
 size
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

An upcoming user of DOE is CMA (Component Measurement and Authentication,
PCIe r6.0 sec 6.31).

It builds on SPDM (Security Protocol and Data Model):
https://www.dmtf.org/dsp/DSP0274

SPDM message sizes are not always a multiple of dwords.  To transport
them over DOE without using bounce buffers, allow sending requests and
receiving responses whose final dword is only partially populated.

To be clear, PCIe r6.0 sec 6.30.1 specifies the Data Object Header 2
"Length" in dwords and pci_doe_send_req() and pci_doe_recv_resp()
read/write dwords.  So from a spec point of view, DOE is still specified
in dwords and allowing non-dword request/response buffers is merely for
the convenience of callers.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Changes v2 -> v3:
 * Fix byte order of last dword on big endian arches (Ira)
 * Explain in commit message and kerneldoc that arbitrary-sized
   payloads are not stipulated by the spec, but merely for
   convenience of the caller (Bjorn, Jonathan)
 * Add code comment that "remainder" in pci_doe_recv_resp() signifies
   the number of data bytes in the last payload dword (Ira)

 drivers/pci/doe.c | 74 +++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 15e5f9df1bba..14252f2fa955 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -76,13 +76,6 @@ struct pci_doe_protocol {
  * @private: Private data for the consumer
  * @work: Used internally by the mailbox
  * @doe_mb: Used internally by the mailbox
- *
- * The payload sizes and rv are specified in bytes with the following
- * restrictions concerning the protocol.
- *
- *	1) The request_pl_sz must be a multiple of double words (4 bytes)
- *	2) The response_pl_sz must be >= a single double word (4 bytes)
- *	3) rv is returned as bytes but it will be a multiple of double words
  */
 struct pci_doe_task {
 	struct pci_doe_protocol prot;
@@ -153,7 +146,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 {
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
-	size_t length;
+	size_t length, remainder;
 	u32 val;
 	int i;
 
@@ -171,7 +164,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 		return -EIO;
 
 	/* Length is 2 DW of header + length of payload in DW */
-	length = 2 + task->request_pl_sz / sizeof(u32);
+	length = 2 + DIV_ROUND_UP(task->request_pl_sz, sizeof(u32));
 	if (length > PCI_DOE_MAX_LENGTH)
 		return -EIO;
 	if (length == PCI_DOE_MAX_LENGTH)
@@ -184,10 +177,21 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
 					  length));
+
+	/* Write payload */
 	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
 		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 				       le32_to_cpu(task->request_pl[i]));
 
+	/* Write last payload dword */
+	remainder = task->request_pl_sz % sizeof(u32);
+	if (remainder) {
+		val = 0;
+		memcpy(&val, &task->request_pl[i], remainder);
+		le32_to_cpus(&val);
+		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
+	}
+
 	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
 
 	return 0;
@@ -207,11 +211,11 @@ static bool pci_doe_data_obj_ready(struct pci_doe_mb *doe_mb)
 
 static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 {
+	size_t length, payload_length, remainder, received;
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
-	size_t length, payload_length;
+	int i = 0;
 	u32 val;
-	int i;
 
 	/* Read the first dword to get the protocol */
 	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
@@ -238,15 +242,38 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 
 	/* First 2 dwords have already been read */
 	length -= 2;
-	payload_length = min(length, task->response_pl_sz / sizeof(u32));
-	/* Read the rest of the response payload */
-	for (i = 0; i < payload_length; i++) {
+	received = task->response_pl_sz;
+	payload_length = DIV_ROUND_UP(task->response_pl_sz, sizeof(u32));
+	remainder = task->response_pl_sz % sizeof(u32);
+
+	/* remainder signifies number of data bytes in last payload dword */
+	if (!remainder)
+		remainder = sizeof(u32);
+
+	if (length < payload_length) {
+		received = length * sizeof(u32);
+		payload_length = length;
+		remainder = sizeof(u32);
+	}
+
+	if (payload_length) {
+		/* Read all payload dwords except the last */
+		for (; i < payload_length - 1; i++) {
+			pci_read_config_dword(pdev, offset + PCI_DOE_READ,
+					      &val);
+			task->response_pl[i] = cpu_to_le32(val);
+			pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+		}
+
+		/* Read last payload dword */
 		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
-		task->response_pl[i] = cpu_to_le32(val);
+		cpu_to_le32s(&val);
+		memcpy(&task->response_pl[i], &val, remainder);
 		/* Prior to the last ack, ensure Data Object Ready */
-		if (i == (payload_length - 1) && !pci_doe_data_obj_ready(doe_mb))
+		if (!pci_doe_data_obj_ready(doe_mb))
 			return -EIO;
 		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+		i++;
 	}
 
 	/* Flush excess length */
@@ -260,7 +287,7 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
 		return -EIO;
 
-	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
+	return received;
 }
 
 static void signal_task_complete(struct pci_doe_task *task, int rv)
@@ -561,14 +588,6 @@ static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
 	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
 		return -EINVAL;
 
-	/*
-	 * DOE requests must be a whole number of DW and the response needs to
-	 * be big enough for at least 1 DW
-	 */
-	if (task->request_pl_sz % sizeof(u32) ||
-	    task->response_pl_sz < sizeof(u32))
-		return -EINVAL;
-
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
 		return -EIO;
 
@@ -596,6 +615,11 @@ static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
  * without byte-swapping.  If payloads contain little-endian register values,
  * the caller is responsible for conversion with cpu_to_le32() / le32_to_cpu().
  *
+ * For convenience, arbitrary payload sizes are allowed even though PCIe r6.0
+ * sec 6.30.1 specifies the Data Object Header 2 "Length" in dwords.  The last
+ * (partial) dword is copied with byte granularity and padded with zeroes if
+ * necessary.  Callers are thus relieved from using dword-sized bounce buffers.
+ *
  * RETURNS: Length of received response or negative errno.
  * Received data in excess of @response_sz is discarded.
  * The length may be smaller than @response_sz and the caller
-- 
2.39.1

