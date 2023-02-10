Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752756928D4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjBJU6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjBJU6O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:58:14 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7BC1C5B4;
        Fri, 10 Feb 2023 12:58:07 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 3FEE010189E11;
        Fri, 10 Feb 2023 21:58:06 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 109CF600CA83;
        Fri, 10 Feb 2023 21:58:06 +0100 (CET)
X-Mailbox-Line: From 99d93ba784fc8b0cc4f484ea00b812f8b0efcada Mon Sep 17 00:00:00 2001
Message-Id: <99d93ba784fc8b0cc4f484ea00b812f8b0efcada.1676043318.git.lukas@wunner.de>
In-Reply-To: <cover.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:13 +0100
Subject: [PATCH v3 13/16] cxl/pci: Use CDAT DOE mailbox created by PCI core
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI core has just been amended to create a pci_doe_mb struct for
every DOE instance on device enumeration.

Drop creation of a (duplicate) CDAT DOE mailbox on cxl probing in favor
of the one already created by the PCI core.

Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 27 +++++------------------
 drivers/cxl/cxlmem.h   |  3 ---
 drivers/cxl/pci.c      | 49 ------------------------------------------
 3 files changed, 5 insertions(+), 74 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 09a9fa67d12a..1b954783b516 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -459,27 +459,6 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
 #define CXL_DOE_TABLE_ACCESS_LAST_ENTRY		0xffff
 #define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
 
-static struct pci_doe_mb *find_cdat_doe(struct device *uport)
-{
-	struct cxl_memdev *cxlmd;
-	struct cxl_dev_state *cxlds;
-	unsigned long index;
-	void *entry;
-
-	cxlmd = to_cxl_memdev(uport);
-	cxlds = cxlmd->cxlds;
-
-	xa_for_each(&cxlds->doe_mbs, index, entry) {
-		struct pci_doe_mb *cur = entry;
-
-		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
-					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
-			return cur;
-	}
-
-	return NULL;
-}
-
 #define CDAT_DOE_REQ(entry_handle) cpu_to_le32				\
 	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
 		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
@@ -577,10 +556,14 @@ void read_cdat_data(struct cxl_port *port)
 	struct pci_doe_mb *cdat_doe;
 	struct device *dev = &port->dev;
 	struct device *uport = port->uport;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	size_t cdat_length;
 	int rc;
 
-	cdat_doe = find_cdat_doe(uport);
+	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!cdat_doe) {
 		dev_dbg(dev, "No CDAT mailbox\n");
 		return;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..e1a1b23cf56c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -227,7 +227,6 @@ struct cxl_endpoint_dvsec_info {
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
- * @doe_mbs: PCI DOE mailbox array
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -264,8 +263,6 @@ struct cxl_dev_state {
 	resource_size_t component_reg_phys;
 	u64 serial;
 
-	struct xarray doe_mbs;
-
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 33083a522fd1..f8b8e514a3c6 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -8,7 +8,6 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/pci.h>
-#include <linux/pci-doe.h>
 #include <linux/aer.h>
 #include <linux/io.h>
 #include "cxlmem.h"
@@ -359,52 +358,6 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
-static void cxl_pci_destroy_doe(void *mbs)
-{
-	xa_destroy(mbs);
-}
-
-static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
-{
-	struct device *dev = cxlds->dev;
-	struct pci_dev *pdev = to_pci_dev(dev);
-	u16 off = 0;
-
-	xa_init(&cxlds->doe_mbs);
-	if (devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs)) {
-		dev_err(dev, "Failed to create XArray for DOE's\n");
-		return;
-	}
-
-	/*
-	 * Mailbox creation is best effort.  Higher layers must determine if
-	 * the lack of a mailbox for their protocol is a device failure or not.
-	 */
-	pci_doe_for_each_off(pdev, off) {
-		struct pci_doe_mb *doe_mb;
-
-		doe_mb = pcim_doe_create_mb(pdev, off);
-		if (IS_ERR(doe_mb)) {
-			dev_err(dev, "Failed to create MB object for MB @ %x\n",
-				off);
-			continue;
-		}
-
-		if (!pci_request_config_region_exclusive(pdev, off,
-							 PCI_DOE_CAP_SIZEOF,
-							 dev_name(dev)))
-			pci_err(pdev, "Failed to exclude DOE registers\n");
-
-		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
-			dev_err(dev, "xa_insert failed to insert MB @ %x\n",
-				off);
-			continue;
-		}
-
-		dev_dbg(dev, "Created DOE mailbox @%x\n", off);
-	}
-}
-
 /*
  * Assume that any RCIEP that emits the CXL memory expander class code
  * is an RCD
@@ -469,8 +422,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = map.resource;
 
-	devm_cxl_pci_create_doe(cxlds);
-
 	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
 				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
-- 
2.39.1

