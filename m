Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79A26B5D47
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 16:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCKPSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 10:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCKPSC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 10:18:02 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC69019;
        Sat, 11 Mar 2023 07:17:59 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id C6D7710190FD0;
        Sat, 11 Mar 2023 16:17:57 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 972FB601663B;
        Sat, 11 Mar 2023 16:17:57 +0100 (CET)
X-Mailbox-Line: From 151b1a6a1794afb65d941287ecbc032c5b8004b9 Mon Sep 17 00:00:00 2001
Message-Id: <151b1a6a1794afb65d941287ecbc032c5b8004b9.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:15 +0100
Subject: [PATCH v4 15/17] PCI/DOE: Relax restrictions on request and response
 size
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Ming Li <ming4.li@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/doe.c | 74 +++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index db9a6b0c33c7..1b97a5ab71a9 100644
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
-	length = 2 + task->request_pl_sz / sizeof(__le32);
+	length = 2 + DIV_ROUND_UP(task->request_pl_sz, sizeof(__le32));
 	if (length > PCI_DOE_MAX_LENGTH)
 		return -EIO;
 	if (length == PCI_DOE_MAX_LENGTH)
@@ -184,10 +177,21 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
 	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
 					  length));
+
+	/* Write payload */
 	for (i = 0; i < task->request_pl_sz / sizeof(__le32); i++)
 		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
 				       le32_to_cpu(task->request_pl[i]));
 
+	/* Write last payload dword */
+	remainder = task->request_pl_sz % sizeof(__le32);
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
-	payload_length = min(length, task->response_pl_sz / sizeof(__le32));
-	/* Read the rest of the response payload */
-	for (i = 0; i < payload_length; i++) {
+	received = task->response_pl_sz;
+	payload_length = DIV_ROUND_UP(task->response_pl_sz, sizeof(__le32));
+	remainder = task->response_pl_sz % sizeof(__le32);
+
+	/* remainder signifies number of data bytes in last payload dword */
+	if (!remainder)
+		remainder = sizeof(__le32);
+
+	if (length < payload_length) {
+		received = length * sizeof(__le32);
+		payload_length = length;
+		remainder = sizeof(__le32);
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
 
-	return min(length, task->response_pl_sz / sizeof(__le32)) * sizeof(__le32);
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
-	if (task->request_pl_sz % sizeof(__le32) ||
-	    task->response_pl_sz < sizeof(__le32))
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
+ * necessary.  Callers are thus relieved of using dword-sized bounce buffers.
+ *
  * RETURNS: Length of received response or negative errno.
  * Received data in excess of @response_sz is discarded.
  * The length may be smaller than @response_sz and the caller
-- 
2.39.1

