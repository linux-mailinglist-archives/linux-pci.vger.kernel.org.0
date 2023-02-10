Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751626928E7
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 22:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjBJVFl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 16:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 16:05:40 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637FF6C7DC;
        Fri, 10 Feb 2023 13:05:39 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id A461710333601;
        Fri, 10 Feb 2023 22:05:37 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 571BA600CA83;
        Fri, 10 Feb 2023 22:05:37 +0100 (CET)
X-Mailbox-Line: From 49c5299afc660ac33fee9a116ea37df0de938432 Mon Sep 17 00:00:00 2001
Message-Id: <49c5299afc660ac33fee9a116ea37df0de938432.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:16 +0100
Subject: [PATCH v3 16/16] cxl/pci: Rightsize CDAT response allocation
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

Jonathan notes that cxl_cdat_get_length() and cxl_cdat_read_table()
allocate 32 dwords for the DOE response even though it may be smaller.

In the case of cxl_cdat_get_length(), only the second dword of the
response is of interest (it contains the length).  So reduce the
allocation to 2 dwords and let DOE discard the remainder.

In the case of cxl_cdat_read_table(), a correctly sized allocation for
the full CDAT already exists.  Let DOE write each table entry directly
into that allocation.  There's a snag in that the table entry is
preceded by a Table Access Response Header (1 dword).  Save the last
dword of the previous table entry, let DOE overwrite it with the
header of the next entry and restore it afterwards.

The resulting CDAT is preceded by 4 unavoidable useless bytes.  Increase
the allocation size accordingly and skip these bytes when exposing CDAT
in sysfs.

The buffer overflow check in cxl_cdat_read_table() becomes unnecessary
because the remaining bytes in the allocation are tracked in "length",
which is passed to DOE and limits how many bytes it writes to the
allocation.  Additionally, cxl_cdat_read_table() bails out if the DOE
response is truncated due to insufficient space.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
---
 Changes v2 -> v3:
 * Newly added patch in v3 on popular request (Jonathan)

 drivers/cxl/core/pci.c | 34 ++++++++++++++++++----------------
 drivers/cxl/cxl.h      |  3 ++-
 drivers/cxl/port.c     |  2 +-
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1b954783b516..70097cc75302 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -471,7 +471,7 @@ static int cxl_cdat_get_length(struct device *dev,
 			       size_t *length)
 {
 	__le32 request = CDAT_DOE_REQ(0);
-	__le32 response[32];
+	__le32 response[2];
 	int rc;
 
 	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
@@ -495,28 +495,28 @@ static int cxl_cdat_read_table(struct device *dev,
 			       struct pci_doe_mb *cdat_doe,
 			       struct cxl_cdat *cdat)
 {
-	size_t length = cdat->length;
-	u32 *data = cdat->table;
+	size_t length = cdat->length + sizeof(u32);
+	__le32 *data = cdat->table;
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
 		     rc != sizeof(u32) + sizeof(struct cdat_header)) ||
 		    (entry_handle > 0 &&
@@ -526,21 +526,22 @@ static int cxl_cdat_read_table(struct device *dev,
 
 		/* Get the CXL table access header entry handle */
 		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
-					 le32_to_cpu(response[0]));
+					 le32_to_cpu(data[0]));
 		entry_dw = rc / sizeof(u32);
 		/* Skip Header */
 		entry_dw -= 1;
-		entry_dw = min(length / sizeof(u32), entry_dw);
-		/* Prevent length < 1 DW from causing a buffer overflow */
-		if (entry_dw) {
-			memcpy(data, entry, entry_dw * sizeof(u32));
-			length -= entry_dw * sizeof(u32);
-			data += entry_dw;
-		}
+		/*
+		 * Table Access Response Header overwrote the last DW of
+		 * previous entry, so restore that DW
+		 */
+		*data = saved_dw;
+		length -= entry_dw * sizeof(u32);
+		data += entry_dw;
+		saved_dw = *data;
 	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
 
 	/* Length in CDAT header may exceed concatenation of CDAT entries */
-	cdat->length -= length;
+	cdat->length -= length - sizeof(u32);
 
 	return 0;
 }
@@ -576,7 +577,8 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 	}
 
-	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	port->cdat.table = devm_kzalloc(dev, cdat_length + sizeof(u32),
+					GFP_KERNEL);
 	if (!port->cdat.table)
 		return;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1b1cf459ac77..78f5cae5134c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -494,7 +494,8 @@ struct cxl_pmem_region {
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
- * @cdat: Cached CDAT data
+ * @cdat: Cached CDAT data (@table is preceded by 4 null bytes, these are not
+ *	  included in @length)
  * @cdat_available: Should a CDAT attribute be available in sysfs
  */
 struct cxl_port {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..0705343ac5ca 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -95,7 +95,7 @@ static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
 		return 0;
 
 	return memory_read_from_buffer(buf, count, &offset,
-				       port->cdat.table,
+				       port->cdat.table + sizeof(u32),
 				       port->cdat.length);
 }
 
-- 
2.39.1

