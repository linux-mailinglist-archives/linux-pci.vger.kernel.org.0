Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF06B5D4A
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCKPTX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 10:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCKPTW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 10:19:22 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733D5F6FD;
        Sat, 11 Mar 2023 07:19:20 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 8FB3710190FD0;
        Sat, 11 Mar 2023 16:19:18 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 6A9DC601663B;
        Sat, 11 Mar 2023 16:19:18 +0100 (CET)
X-Mailbox-Line: From 7a5c7104fb6a3016dbaec1c5d0ed34619ea11a0c Mon Sep 17 00:00:00 2001
Message-Id: <7a5c7104fb6a3016dbaec1c5d0ed34619ea11a0c.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:16 +0100
Subject: [PATCH v4 16/17] cxl/pci: Simplify CDAT retrieval error path
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

From: Dave Jiang <dave.jiang@intel.com>

The cdat.table and cdat.length fields in struct cxl_port are set before
CDAT retrieval and must therefore be unset on failure.

Simplify by setting only on success.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: https://lore.kernel.org/linux-cxl/20230209113422.00007017@Huawei.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[lukas: rebase and rephrase commit message]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
Changes v3 -> v4:
 * Newly added patch in v4 on popular request (Jonathan, Dave)

 drivers/cxl/core/pci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c868f4a2f1de..0609bd629073 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -475,10 +475,10 @@ static int cxl_cdat_get_length(struct device *dev,
 
 static int cxl_cdat_read_table(struct device *dev,
 			       struct pci_doe_mb *cdat_doe,
-			       struct cxl_cdat *cdat)
+			       void *cdat_table, size_t *cdat_length)
 {
-	size_t length = cdat->length;
-	__le32 *data = cdat->table;
+	size_t length = *cdat_length;
+	__le32 *data = cdat_table;
 	int entry_handle = 0;
 
 	do {
@@ -522,7 +522,7 @@ static int cxl_cdat_read_table(struct device *dev,
 	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
 
 	/* Length in CDAT header may exceed concatenation of CDAT entries */
-	cdat->length -= length;
+	*cdat_length -= length;
 
 	return 0;
 }
@@ -542,6 +542,7 @@ void read_cdat_data(struct cxl_port *port)
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	size_t cdat_length;
+	void *cdat_table;
 	int rc;
 
 	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
@@ -558,19 +559,19 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 	}
 
-	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
-	if (!port->cdat.table)
+	cdat_table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	if (!cdat_table)
 		return;
 
-	port->cdat.length = cdat_length;
-	rc = cxl_cdat_read_table(dev, cdat_doe, &port->cdat);
+	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_table, &cdat_length);
 	if (rc) {
 		/* Don't leave table data allocated on error */
-		devm_kfree(dev, port->cdat.table);
-		port->cdat.table = NULL;
-		port->cdat.length = 0;
+		devm_kfree(dev, cdat_table);
 		dev_err(dev, "CDAT data read error\n");
 	}
+
+	port->cdat.table = cdat_table;
+	port->cdat.length = cdat_length;
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-- 
2.39.1

