Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB26B5D03
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 15:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCKOuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 09:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCKOt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 09:49:56 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFE72ED55;
        Sat, 11 Mar 2023 06:49:55 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id D8E01102F5886;
        Sat, 11 Mar 2023 15:49:53 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 94DFC60049B2;
        Sat, 11 Mar 2023 15:49:53 +0100 (CET)
X-Mailbox-Line: From bce3aebc0e8e18a1173425a7a865b232c3912963 Mon Sep 17 00:00:00 2001
Message-Id: <bce3aebc0e8e18a1173425a7a865b232c3912963.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:03 +0100
Subject: [PATCH v4 03/17] cxl/pci: Handle truncated CDAT entries
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
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If truncated CDAT entries are received from a device, the concatenation
of those entries constitutes a corrupt CDAT, yet is happily exposed to
user space.

Avoid by verifying response lengths and erroring out if truncation is
detected.

The last CDAT entry may still be truncated despite the checks introduced
herein if the length in the CDAT header is too small.  However, that is
easily detectable by user space because it reaches EOF prematurely.
A subsequent commit which rightsizes the CDAT response allocation closes
that remaining loophole.

The two lines introduced here which exceed 80 chars are shortened to
less than 80 chars by a subsequent commit which migrates to a
synchronous DOE API and replaces "t.task.rv" by "rc".

The existing acpi_cdat_header and acpi_table_cdat struct definitions
provided by ACPICA cannot be used because they do not employ __le16 or
__le32 types.  I believe that cannot be changed because those types are
Linux-specific and ACPI is specified for little endian platforms only,
hence doesn't care about endianness.  So duplicate the structs.

Fixes: c97006046c79 ("cxl/port: Read CDAT table")
Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: stable@vger.kernel.org # v6.0+
---
Changes v3 -> v4:
 * Check for sizeof(*entry) instead of sizeof(struct cdat_entry_header)
   for clarity (Jonathan)

 drivers/cxl/core/pci.c | 13 +++++++++----
 drivers/cxl/cxlpci.h   | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 87da8c935185..fb600dfbf5a6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -529,8 +529,8 @@ static int cxl_cdat_read_table(struct device *dev,
 
 	do {
 		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
+		struct cdat_entry_header *entry;
 		size_t entry_dw;
-		__le32 *entry;
 		int rc;
 
 		rc = pci_doe_submit_task(cdat_doe, &t.task);
@@ -539,14 +539,19 @@ static int cxl_cdat_read_table(struct device *dev,
 			return rc;
 		}
 		wait_for_completion(&t.c);
-		/* 1 DW header + 1 DW data min */
-		if (t.task.rv < (2 * sizeof(__le32)))
+
+		/* 1 DW Table Access Response Header + CDAT entry */
+		entry = (struct cdat_entry_header *)(t.response_pl + 1);
+		if ((entry_handle == 0 &&
+		     t.task.rv != sizeof(__le32) + sizeof(struct cdat_header)) ||
+		    (entry_handle > 0 &&
+		     (t.task.rv < sizeof(__le32) + sizeof(*entry) ||
+		      t.task.rv != sizeof(__le32) + le16_to_cpu(entry->length))))
 			return -EIO;
 
 		/* Get the CXL table access header entry handle */
 		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
 					 le32_to_cpu(t.response_pl[0]));
-		entry = t.response_pl + 1;
 		entry_dw = t.task.rv / sizeof(__le32);
 		/* Skip Header */
 		entry_dw -= 1;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index be6a2ef3cce3..0465ef963cd6 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -68,6 +68,20 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
 
+struct cdat_header {
+	__le32 length;
+	u8 revision;
+	u8 checksum;
+	u8 reserved[6];
+	__le32 sequence;
+} __packed;
+
+struct cdat_entry_header {
+	u8 type;
+	u8 reserved;
+	__le16 length;
+} __packed;
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
-- 
2.39.1

