Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45356B5D3B
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 16:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCKPOD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 10:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCKPOC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 10:14:02 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D49BDD34E;
        Sat, 11 Mar 2023 07:14:00 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id D399A10189CE0;
        Sat, 11 Mar 2023 16:13:58 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id A2CAE601663B;
        Sat, 11 Mar 2023 16:13:58 +0100 (CET)
X-Mailbox-Line: From becaf70e8faf9681d474200117d62d7eaac46cca Mon Sep 17 00:00:00 2001
Message-Id: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
In-Reply-To: <cover.1678543498.git.lukas@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:13 +0100
Subject: [PATCH v4 13/17] cxl/pci: Use CDAT DOE mailbox created by PCI core
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
index 8575eaadd522..c868f4a2f1de 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -441,27 +441,6 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
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
@@ -559,10 +538,14 @@ void read_cdat_data(struct cxl_port *port)
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
index 090acebba4fa..001dabf0231b 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -249,7 +249,6 @@ struct cxl_event_state {
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
- * @doe_mbs: PCI DOE mailbox array
  * @event: event log driver state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
@@ -287,8 +286,6 @@ struct cxl_dev_state {
 	resource_size_t component_reg_phys;
 	u64 serial;
 
-	struct xarray doe_mbs;
-
 	struct cxl_event_state event;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 60b23624d167..ea38bd49b0cf 100644
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
@@ -357,52 +356,6 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
@@ -750,8 +703,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = map.resource;
 
-	devm_cxl_pci_create_doe(cxlds);
-
 	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
 				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
-- 
2.39.1

