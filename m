Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA06B5D4E
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 16:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCKPVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 10:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCKPVs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 10:21:48 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7F30C1;
        Sat, 11 Mar 2023 07:21:46 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 341DA10190FC7;
        Sat, 11 Mar 2023 16:21:45 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 0974A601663B;
        Sat, 11 Mar 2023 16:21:45 +0100 (CET)
X-Mailbox-Line: From 7a4e1f86958a79a70f29b96a92199522f08f8322 Mon Sep 17 00:00:00 2001
Message-Id: <7a4e1f86958a79a70f29b96a92199522f08f8322.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:17 +0100
Subject: [PATCH v4 17/17] cxl/pci: Rightsize CDAT response allocation
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

Jonathan notes that cxl_cdat_get_length() and cxl_cdat_read_table()
allocate 32 dwords for the DOE response even though it may be smaller.

In the case of cxl_cdat_get_length(), only the second dword of the
response is of interest (it contains the length).  So reduce the
allocation to 2 dwords and let DOE discard the remainder.

In the case of cxl_cdat_read_table(), a correctly sized allocation for
the full CDAT already exists.  Let DOE write each table entry directly
into that allocation.  There's a snag in that the table entry is
preceded by a Table Access Response Header (1 dword, CXL 3.0 table 8-14).
Save the last dword of the previous table entry, let DOE overwrite it
with the header of the next entry and restore it afterwards.

The resulting CDAT is preceded by 4 unavoidable useless bytes.  Increase
the allocation size accordingly.

The buffer overflow check in cxl_cdat_read_table() becomes unnecessary
because the remaining bytes in the allocation are tracked in "length",
which is passed to DOE and limits how many bytes it writes to the
allocation.  Additionally, cxl_cdat_read_table() bails out if the DOE
response is truncated due to insufficient space.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
---
Changes v3 -> v4:
 * Amend commit message with spec reference to the Table Access
   Response Header (Ira)
 * In cxl_cdat_get_length(), check for sizeof(response) instead of
   2 * sizeof(u32) for clarity

 drivers/cxl/core/pci.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0609bd629073..25b7e8125d5d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -453,7 +453,7 @@ static int cxl_cdat_get_length(struct device *dev,
 			       size_t *length)
 {
 	__le32 request = CDAT_DOE_REQ(0);
-	__le32 response[32];
+	__le32 response[2];
 	int rc;
 
 	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
@@ -464,7 +464,7 @@ static int cxl_cdat_get_length(struct device *dev,
 		dev_err(dev, "DOE failed: %d", rc);
 		return rc;
 	}
-	if (rc < 2 * sizeof(__le32))
+	if (rc < sizeof(response))
 		return -EIO;
 
 	*length = le32_to_cpu(response[1]);
@@ -477,28 +477,28 @@ static int cxl_cdat_read_table(struct device *dev,
 			       struct pci_doe_mb *cdat_doe,
 			       void *cdat_table, size_t *cdat_length)
 {
-	size_t length = *cdat_length;
+	size_t length = *cdat_length + sizeof(__le32);
 	__le32 *data = cdat_table;
 	int entry_handle = 0;
+	__le32 saved_dw = 0;
 
 	do {
 		__le32 request = CDAT_DOE_REQ(entry_handle);
 		struct cdat_entry_header *entry;
-		__le32 response[32];
 		size_t entry_dw;
 		int rc;
 
 		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
 			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
 			     &request, sizeof(request),
-			     &response, sizeof(response));
+			     data, length);
 		if (rc < 0) {
 			dev_err(dev, "DOE failed: %d", rc);
 			return rc;
 		}
 
 		/* 1 DW Table Access Response Header + CDAT entry */
-		entry = (struct cdat_entry_header *)(response + 1);
+		entry = (struct cdat_entry_header *)(data + 1);
 		if ((entry_handle == 0 &&
 		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
 		    (entry_handle > 0 &&
@@ -508,21 +508,22 @@ static int cxl_cdat_read_table(struct device *dev,
 
 		/* Get the CXL table access header entry handle */
 		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
-					 le32_to_cpu(response[0]));
+					 le32_to_cpu(data[0]));
 		entry_dw = rc / sizeof(__le32);
 		/* Skip Header */
 		entry_dw -= 1;
-		entry_dw = min(length / sizeof(__le32), entry_dw);
-		/* Prevent length < 1 DW from causing a buffer overflow */
-		if (entry_dw) {
-			memcpy(data, entry, entry_dw * sizeof(__le32));
-			length -= entry_dw * sizeof(__le32);
-			data += entry_dw;
-		}
+		/*
+		 * Table Access Response Header overwrote the last DW of
+		 * previous entry, so restore that DW
+		 */
+		*data = saved_dw;
+		length -= entry_dw * sizeof(__le32);
+		data += entry_dw;
+		saved_dw = *data;
 	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
 
 	/* Length in CDAT header may exceed concatenation of CDAT entries */
-	*cdat_length -= length;
+	*cdat_length -= length - sizeof(__le32);
 
 	return 0;
 }
@@ -559,7 +560,8 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 	}
 
-	cdat_table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	cdat_table = devm_kzalloc(dev, cdat_length + sizeof(__le32),
+				  GFP_KERNEL);
 	if (!cdat_table)
 		return;
 
@@ -570,7 +572,7 @@ void read_cdat_data(struct cxl_port *port)
 		dev_err(dev, "CDAT data read error\n");
 	}
 
-	port->cdat.table = cdat_table;
+	port->cdat.table = cdat_table + sizeof(__le32);
 	port->cdat.length = cdat_length;
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
-- 
2.39.1

