Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6731567353
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiGEPvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 11:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiGEPu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 11:50:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA26C1F2F1;
        Tue,  5 Jul 2022 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657036196; x=1688572196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kHLcIsuBozjjLDwc6imj2QYrFzq0KpcvJkcw4Y1qDoI=;
  b=DMoImNn0GBtf8x8i5b2/zet5aacnMq5o/hZZrmlmylWK7/YkcAdmzZeg
   i6SQdJTpQgxIS55DsPKGQLM8SwkZu0F6Ifv3DeuItliLlsU7SalwJY5zt
   QWIVB6iahL+qIhk5m2TFysRC8wxWcYY6rYBuCrQYrXzrWoMrmSkH7+Tzp
   3TBpp9h5/9MHax2+kSQwDUgbcKoLfC0Lul4mF4qzhiU/2qulZOdu8SAyj
   sh7837j1WJU6eVqUnppHTbO2n9BArkLTCLKBID/MHK3FK8iPRlGHcxsxF
   W0oWlKA14gjCNDjVFAsT26wRZ81LemKHawN2zkLMMynJ4ozyI6HQK12aQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263810300"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="263810300"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:49:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="625497126"
Received: from amangla-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:49:53 -0700
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
Subject: [PATCH V13 4/9] cxl/pci: Create PCI DOE mailbox's for memory devices
Date:   Tue,  5 Jul 2022 08:49:27 -0700
Message-Id: <20220705154932.2141021-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705154932.2141021-1-ira.weiny@intel.com>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Changes from V12:
	remove irq param from CXL
	Jonathan:
		remove xa local variable
		clarify MB creation as best effort
			But ensure pci_err() if they fail
			Check devm_add_action() return for failure
	Davidlohr and Jonathan:
		Return error ...

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
 drivers/cxl/pci.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

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
index 5a0ae46d4989..6228c95fd142 100644
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
@@ -386,6 +387,43 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
+static void cxl_pci_destroy_doe(void *mbs)
+{
+	xa_destroy(mbs);
+}
+
+static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 off = 0;
+
+	/*
+	 * Mailbox creation is best effort.  Higher layers must determine if
+	 * the lack of a mailbox for their protocol is a device failure or not.
+	 */
+	pci_doe_for_each_off(pdev, off) {
+		struct pci_doe_mb *doe_mb;
+
+		doe_mb = pcim_doe_create_mb(pdev, off);
+		if (IS_ERR(doe_mb)) {
+			pci_err(pdev,
+				"Failed to create MB object for MB @ %x\n",
+				off);
+			continue;
+		}
+
+		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
+			pci_err(pdev,
+				"xa_insert failed to insert MB @ %x\n",
+				off);
+			continue;
+		}
+
+		pci_dbg(pdev, "Created DOE mailbox @%x\n", off);
+	}
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -408,6 +446,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
 
+	xa_init(&cxlds->doe_mbs);
+	if (devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs))
+		return -ENOMEM;
+
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
 		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
@@ -434,6 +476,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
 
+	devm_cxl_pci_create_doe(cxlds);
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
-- 
2.35.3

