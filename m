Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0FB57A8A2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 22:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbiGSUxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbiGSUxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 16:53:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA67361131;
        Tue, 19 Jul 2022 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658263985; x=1689799985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6uBx2ZieTs+jCNIdkhWz5iFe7ex2M4T7V1hMcy6ev6w=;
  b=J4nYPKTwhJbaoaYtqvcOg+o1qAOaMmwFFBcs+dBq9alVrp9Ilg+YJCtb
   /i6aEweES46F8mPDSO4MDq4AS4vWmO2OSmb5VfBmbgV8KMoPpCORuueWi
   IFiIfpTnhI2KSLuZDaVkCLoewzhOusGKBk4lJqf4qi4lU0AgoW+Apfbhe
   pycUknGgA/fm7B3RPsv8zC5PiwWt4aXYmFDgZHH+I5r1JC79JUVV3ZI9+
   ElcRFHb56ZJgisgW9FnjlP1v7lDnw3dWQOec15yEbOUy1IY1I3VQ/LNqQ
   bqM0z5xn3eKhX77XqDdTKQBTAE2pVqiV0vsS370ewsII0t7KObsJVDf3s
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="287751553"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="287751553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:53:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="630492647"
Received: from kscamus-mobl1.amr.corp.intel.com (HELO localhost) ([10.255.6.221])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:53:03 -0700
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
Subject: [PATCH V16 4/6] cxl/pci: Create PCI DOE mailbox's for memory devices
Date:   Tue, 19 Jul 2022 13:52:47 -0700
Message-Id: <20220719205249.566684-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220719205249.566684-1-ira.weiny@intel.com>
References: <20220719205249.566684-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V13:
	Dan:
		s/pci_err/dev_err
		s/pci_dbg/dev_dbg
		Move xa_init() into devm_cxl_pci_create_doe()

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
index c6d6f57856cc..bfa2eaf649a9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -192,6 +192,7 @@ struct cxl_endpoint_dvsec_info {
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
+ * @doe_mbs: PCI DOE mailbox array
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -226,6 +227,8 @@ struct cxl_dev_state {
 	resource_size_t component_reg_phys;
 	u64 serial;
 
+	struct xarray doe_mbs;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index eeff9599acda..faeb5d9d7a7a 100644
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
@@ -386,6 +387,47 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
+	xa_init(&cxlds->doe_mbs);
+	if (devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs)) {
+		dev_err(dev, "Failed to create XArray for DOE's\n");
+		return;
+	}
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
+			dev_err(dev, "Failed to create MB object for MB @ %x\n",
+				off);
+			continue;
+		}
+
+		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
+			dev_err(dev, "xa_insert failed to insert MB @ %x\n",
+				off);
+			continue;
+		}
+
+		dev_dbg(dev, "Created DOE mailbox @%x\n", off);
+	}
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -434,6 +476,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
 
+	devm_cxl_pci_create_doe(cxlds);
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
-- 
2.35.3

