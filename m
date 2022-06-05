Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA653D8F2
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jun 2022 02:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbiFEAv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbiFEAvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 20:51:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165B54EF5A;
        Sat,  4 Jun 2022 17:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654390273; x=1685926273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPyOO4AjW7w83+6egg9wTV4uB4hVx3YXS0ve5q4FAMk=;
  b=RWrXTTC5wzyCYEy3WhWsLwFcUylg3eBU6L3aUEc/ZoKC4UMYaRo6axtQ
   sv4lIf+0zzCST6EgZOw+4/g0W0sk5+rzWcAZ+ODxopZgqacKZEy2x08T/
   3TIw/JmcMQ2vuqjzsm0dBKMASuTJhdajSAINxqRbqnhhdA/zg4cqGnnPI
   ZitPQhCBtxOAOtY58GpM8QFRzFLJxH6g91ATAurULr6rYIwYrlTymJar0
   IUN8ulfcdjVs6d5wmikyaQmmNyZQNKk5CL0Cgtr00A7XxvyxtivfdponJ
   mlQLnXv/w999H/ttrrpyExqvYSFFJEDBe5kUO3xiCrvLQzLUW+4MsHIPp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276538630"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="276538630"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="708546216"
Received: from aftome-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.107.207])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:12 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V10 4/9] cxl/pci: Create PCI DOE mailbox's for memory devices
Date:   Sat,  4 Jun 2022 17:50:44 -0700
Message-Id: <20220605005049.2155874-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220605005049.2155874-1-ira.weiny@intel.com>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
iteration of the DOE devices.  The support of ports may drive this code
into the pcie side.  In this imagined architecture the CXL port driver
would then query into the PCI device for the DOE mailbox array.

For now this is good enough for the endpoints and the split is similar
to the envisioned architecture where getting the mailbox array is
separated from the various protocol needs.  For example, it is not
anticipated that the CDAT code will need to move because it is only
needed by the cxl_ports.

Likewise irq's are separated out in a similar design pattern to the
PCIe port driver.  But a much simpler irq enabling flag is used and only
DOE interrupts are supported.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
 drivers/cxl/Kconfig  |   1 +
 drivers/cxl/cxlmem.h |   6 +++
 drivers/cxl/pci.c    | 114 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

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
index 60d10ee1e7fc..4d2764b865ab 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -191,6 +191,8 @@ struct cxl_endpoint_dvsec_info {
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
+ * @doe_mbs: PCI DOE mailbox array
+ * @num_mbs: Number of DOE mailboxes
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -224,6 +226,10 @@ struct cxl_dev_state {
 	resource_size_t component_reg_phys;
 	u64 serial;
 
+	bool doe_use_irq;
+	struct pci_doe_mb **doe_mbs;
+	int num_mbs;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5a0ae46d4989..72c7b535f5df 100644
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
@@ -386,6 +387,116 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
+static void cxl_pci_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static void cxl_doe_destroy_mb(void *ds)
+{
+	struct cxl_dev_state *cxlds = ds;
+	int i;
+
+	for (i = 0; i < cxlds->num_mbs; i++) {
+		if (cxlds->doe_mbs[i])
+			pci_doe_destroy_mb(cxlds->doe_mbs[i]);
+	}
+}
+
+static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int max_irqs = 0;
+	int off = 0;
+	int rc;
+
+	/* Account for all the DOE vectors needed */
+	pci_doe_for_each_off(pdev, off) {
+		int irq = pci_doe_get_irq_num(pdev, off);
+
+		if (irq < 0)
+			continue;
+		max_irqs = max(max_irqs, irq + 1);
+	}
+
+	if (!max_irqs)
+		return;
+
+	cxlds->doe_use_irq = false;
+
+	/*
+	 * Allocate enough vectors for the DOE's
+	 */
+	rc = pci_alloc_irq_vectors(pdev, max_irqs, max_irqs, PCI_IRQ_MSI |
+							     PCI_IRQ_MSIX);
+	if (rc != max_irqs) {
+		pci_err(pdev, "Not enough interrupts; use polling\n");
+		/* Some got allocated; clean them up */
+		if (rc > 0)
+			cxl_pci_free_irq_vectors(pdev);
+		return;
+	}
+
+	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
+	if (rc)
+		return;
+
+	cxlds->doe_use_irq = true;
+}
+
+/**
+ * devm_cxl_pci_create_doe - Scan and set up DOE mailboxes
+ *
+ * @cxlds: The CXL device state
+ */
+static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 off = 0;
+	int num_mbs = 0;
+	int rc;
+
+	pci_doe_for_each_off(pdev, off)
+		num_mbs++;
+
+	if (!num_mbs) {
+		pci_dbg(pdev, "0 DOE mailbox's found\n");
+		return;
+	}
+
+	cxlds->doe_mbs = devm_kcalloc(dev, num_mbs, sizeof(*cxlds->doe_mbs),
+				      GFP_KERNEL);
+	if (!cxlds->doe_mbs)
+		return;
+
+	pci_doe_for_each_off(pdev, off) {
+		struct pci_doe_mb *doe_mb;
+		int irq = -1;
+
+		if (cxlds->doe_use_irq)
+			irq = pci_doe_get_irq_num(pdev, off);
+
+		doe_mb = pci_doe_create_mb(pdev, off, irq);
+		if (IS_ERR(doe_mb)) {
+			pci_err(pdev,
+				"Failed to create MB object for MB @ %x\n",
+				off);
+			doe_mb = NULL;
+		}
+
+		cxlds->doe_mbs[cxlds->num_mbs] = doe_mb;
+		cxlds->num_mbs++;
+	}
+
+	rc = devm_add_action_or_reset(dev, cxl_doe_destroy_mb, cxlds);
+	if (rc)
+		return;
+
+	pci_info(pdev, "Configured %d DOE mailbox's\n", cxlds->num_mbs);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -434,6 +545,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
 
+	cxl_alloc_irq_vectors(cxlds);
+	devm_cxl_pci_create_doe(cxlds);
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
-- 
2.35.1

