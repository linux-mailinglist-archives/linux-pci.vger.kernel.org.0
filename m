Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63D055CA35
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbiF1EQB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 00:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiF1EP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 00:15:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2DA286DE;
        Mon, 27 Jun 2022 21:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656389757; x=1687925757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iT9oCNWhVBkC++ANIZD3oXJTZgxsUQxGTUhkGyHXJA0=;
  b=asgHkeFggCGV8b/ueFzMI519pV8rGN5NCRro2XAOggVhWvDGT04oBwJF
   10DtST5svJsDK9fqPGUso1VqpMXRHl6NAGOsUcFKwVuTvy3P0CudOt/iz
   xwUnHEu0fZ+lVyVGADiFpal3CVrnONTBr3PXMUGWY4v1I4CfB/3zfvLjT
   sJuj/2S3uUyPl1bv2oCLsFlwnE/++MVpXm/SozT7rBenF/PIlzTPvBnWQ
   SVI8oqdjiYV6uHC9fn2dNJL3QZODFf31klep6Cw3rQkAzq0hojcwhjhto
   pCJxI8joHWDS8rdvS5+qEYBdIf+xaHfg2Qld/gN5HqcXQvOX9CYNuYLWy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345627066"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345627066"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:15:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="679865154"
Received: from nakedgex-mobl.amr.corp.intel.com (HELO localhost) ([10.255.3.161])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:15:53 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V12 4/9] cxl/pci: Create PCI DOE mailbox's for memory devices
Date:   Mon, 27 Jun 2022 21:15:22 -0700
Message-Id: <20220628041527.742333-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628041527.742333-1-ira.weiny@intel.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

DOE mailbox objects will be needed for various mailbox communications
with each memory device.

Iterate each DOE mailbox capability and create PCI DOE mailbox objects
as found.

It is not anticipated that this is the final resting place for the
iteration of the DOE devices.  The support of switch ports will drive
this code into the PCIe side.  In this imagined architecture the CXL
port driver would then query into the PCI device for the DOE mailbox
array.

For now creating the mailboxes in the CXL port is good enough for the
endpoints.  Later PCIe ports will need to support this to support switch
ports more generically.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V11:
	Drop review from: Ben Widawsky <bwidawsk@kernel.org>
	Remove irq code for now
	Adjust for pci_doe_get_int_msg_num()
	Adjust for pcim_doe_create_mb()
		(No longer need to handle the destroy.)
	Use xarray for DOE mailbox array

Changes from V9:
	Bug fix: ensure DOE mailboxes are iterated before memdev add
	Ben Widawsky
		Set use_irq to false and just return on error.
		Don't return a value from devm_cxl_pci_create_doe()
		Skip allocating doe_mb array if there are no mailboxes
		Skip requesting irqs if none found.
	Ben/Jonathan Cameron
		s/num_irqs/max_irqs

Changes from V8:
	Move PCI_DOE selection to CXL_BUS to support future patches
	which move queries into the port code.
	Remove Auxiliary device arch
	Squash the functionality of the auxiliary driver into this
	patch.
	Split out the irq handling a bit.

Changes from V7:
	Minor code clean ups
	Rebased on cxl-pending

Changes from V6:
	Move all the auxiliary device stuff to the CXL layer

Changes from V5:
	Split the CXL specific stuff off from the PCI DOE create
	auxiliary device code.
---
 drivers/cxl/Kconfig  |  1 +
 drivers/cxl/cxlmem.h |  3 +++
 drivers/cxl/pci.c    | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index f64e3984689f..7adaaf80b302 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -2,6 +2,7 @@
 menuconfig CXL_BUS
 	tristate "CXL (Compute Express Link) Devices Support"
 	depends on PCI
+	select PCI_DOE
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
 	  layers three protocols on that signalling (CXL.io, CXL.cache, and
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 60d10ee1e7fc..360f282ef80c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -191,6 +191,7 @@ struct cxl_endpoint_dvsec_info {
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
+ * @doe_mbs: PCI DOE mailbox array
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -224,6 +225,8 @@ struct cxl_dev_state {
 	resource_size_t component_reg_phys;
 	u64 serial;
 
+	struct xarray doe_mbs;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5a0ae46d4989..5821e6c1253b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -386,6 +387,37 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
+static void cxl_pci_destroy_doe(void *mbs)
+{
+	struct xarray *xa = mbs;
+
+	xa_destroy(xa);
+}
+
+static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 off = 0;
+
+	pci_doe_for_each_off(pdev, off) {
+		struct pci_doe_mb *doe_mb;
+
+		doe_mb = pcim_doe_create_mb(pdev, off, -1);
+		if (IS_ERR(doe_mb)) {
+			pci_err(pdev,
+				"Failed to create MB object for MB @ %x\n",
+				off);
+			doe_mb = NULL;
+		}
+
+		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL))
+			break;
+
+		pci_dbg(pdev, "Created DOE mailbox @%x\n", off);
+	}
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -408,6 +440,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
 
+	xa_init(&cxlds->doe_mbs);
+	devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs);
+
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
 		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
@@ -434,6 +469,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
 
+	devm_cxl_pci_create_doe(cxlds);
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
-- 
2.35.3

