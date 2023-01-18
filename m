Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07B6671364
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 06:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjARF4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 00:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjARFyQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 00:54:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294FA577FC;
        Tue, 17 Jan 2023 21:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674021234; x=1705557234;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EAMBg85KrKQalkxPOf/xlvUVsAy6pNQIs/aIu9osXZ8=;
  b=NFz8q8EA7MJbW2hdT7/igQ06CiTmkAN3JHNs9kkAv3xFzuCpTrh5HSxt
   e4LS8diFIVWmegFRvncc/m+6CJ51HwQeKSQcsDQ6ZgnfT3vDz8CR72TLJ
   AVBB/2qfYet8ZbqF5vEyKsFJH2ijgJz1PZ6JV8YtjW46e+ARp+O/omBR3
   i4vwHlmpygk2zMPKnExG9gHe6aBJFY1zgY++rdfQeahsnV/tnwBsDWBRu
   xHmyxW8tOzo4huKz48oGxDBlFyhX2avemycGzytWzUxzYk6/YBRlG26AV
   1bX+nOMpj5BvP5kQTmSgkOHv7hVd1KxJ9cey4b8atqC7nDSSXTBOndypL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304586783"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304586783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:53:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="802043176"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="802043176"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.10.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:53:51 -0800
From:   ira.weiny@intel.com
Date:   Tue, 17 Jan 2023 21:53:37 -0800
Subject: [PATCH v7 2/8] cxl/mem: Wire up event interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221216-cxl-ev-log-v7-2-2316a5c8f7d8@intel.com>
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674021228; l=10838;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=bcTk75q4xcJxW0GPEV/SIkJJUbNxLsvKadxlnk+kwlQ=;
 b=UmC83T76IFAc28C+hldp2zl7xC5celYKzgNwzwtaEKZchel2Q8t5c61wExGZR5zxfNgbSvFYdBW7
 zvK6XThBBKOX7XcCgI251Mcb77EZx/UBqh1sDGCE077KjMyYSeQQ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Currently the only CXL features targeted for irq support require their
message numbers to be within the first 16 entries.  The device may
however support less than 16 entries depending on the support it
provides.

Attempt to allocate these 16 irq vectors.  If the device supports less
then the PCI infrastructure will allocate that number.  Upon successful
allocation, users can plug in their respective isr at any point
thereafter.

CXL device events are signaled via interrupts.  Each event log may have
a different interrupt message number.  These message numbers are
reported in the Get Event Interrupt Policy mailbox command.

Add interrupt support for event logs.  Interrupts are allocated as
shared interrupts.  Therefore, all or some event logs can share the same
message number.

In addition all logs are queried on any interrupt in order of the most
to least severe based on the status register.

Finally place all event configuration logic into cxl_event_config().
Previously the logic was a simple 'read all' on start up.  But
interrupts must be configured prior to any reads to ensure no events are
missed.  A single event configuration function results in a cleaner over
all implementation.

Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v7:
	<no change>
---
 drivers/cxl/cxl.h    |   4 +
 drivers/cxl/cxlmem.h |  19 +++++
 drivers/cxl/cxlpci.h |   6 ++
 drivers/cxl/pci.c    | 221 ++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 240 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5974d1082210..b3964149c77b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -168,6 +168,10 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 				 CXLDEV_EVENT_STATUS_FAIL |	\
 				 CXLDEV_EVENT_STATUS_FATAL)
 
+/* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
+#define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
+#define CXLDEV_EVENT_INT_MSGNUM_MASK	GENMASK(7, 4)
+
 /* CXL 2.0 8.2.8.4 Mailbox Registers */
 #define CXLDEV_MBOX_CAPS_OFFSET 0x00
 #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0f272206e294..5bef485cd8d9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -194,6 +194,23 @@ struct cxl_endpoint_dvsec_info {
 	struct range dvsec_range[2];
 };
 
+/**
+ * Event Interrupt Policy
+ *
+ * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
+ */
+enum cxl_event_int_mode {
+	CXL_INT_NONE		= 0x00,
+	CXL_INT_MSI_MSIX	= 0x01,
+	CXL_INT_FW		= 0x02
+};
+struct cxl_event_interrupt_policy {
+	u8 info_settings;
+	u8 warn_settings;
+	u8 failure_settings;
+	u8 fatal_settings;
+} __packed;
+
 /**
  * struct cxl_event_state - Event log driver state
  *
@@ -288,6 +305,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
+	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
+	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 77dbdb980b12..a8ea04f536ab 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -53,6 +53,12 @@
 #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
 #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
 
+/*
+ * NOTE: Currently all the functions which are enabled for CXL require their
+ * vectors to be in the first 16.  Use this as the default max.
+ */
+#define CXL_PCI_DEFAULT_MAX_VECTORS 16
+
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
 	CXL_REGLOC_RBI_EMPTY = 0,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0fd7742ee70c..a4ee073fd16d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -447,6 +447,209 @@ static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
+{
+	int nvecs;
+
+	/*
+	 * Per CXL 3.0 3.1.1 CXL.io Endpoint a function on a CXL device must
+	 * not generate INTx messages if that function participates in
+	 * CXL.cache or CXL.mem.
+	 *
+	 * Additionally pci_alloc_irq_vectors() handles calling
+	 * pci_free_irq_vectors() automatically despite not being called
+	 * pcim_*.  See pci_setup_msi_context().
+	 */
+	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
+				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (nvecs < 1) {
+		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
+		return -ENXIO;
+	}
+	return 0;
+}
+
+struct cxl_dev_id {
+	struct cxl_dev_state *cxlds;
+};
+
+static irqreturn_t cxl_event_thread(int irq, void *id)
+{
+	struct cxl_dev_id *dev_id = id;
+	struct cxl_dev_state *cxlds = dev_id->cxlds;
+	u32 status;
+
+	do {
+		/*
+		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
+		 * ignore the reserved upper 32 bits
+		 */
+		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+		/* Ignore logs unknown to the driver */
+		status &= CXLDEV_EVENT_STATUS_ALL;
+		if (!status)
+			break;
+		cxl_mem_get_event_records(cxlds, status);
+		cond_resched();
+	} while (status);
+
+	return IRQ_HANDLED;
+}
+
+static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_dev_id *dev_id;
+	int irq;
+
+	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
+		return -ENXIO;
+
+	/* dev_id must be globally unique and must contain the cxlds */
+	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
+	if (!dev_id)
+		return -ENOMEM;
+	dev_id->cxlds = cxlds;
+
+	irq =  pci_irq_vector(pdev,
+			      FIELD_GET(CXLDEV_EVENT_INT_MSGNUM_MASK, setting));
+	if (irq < 0)
+		return irq;
+
+	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
+					 IRQF_SHARED, NULL, dev_id);
+}
+
+static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
+				    struct cxl_event_interrupt_policy *policy)
+{
+	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
+		.payload_out = policy,
+		.size_out = sizeof(*policy),
+	};
+	int rc;
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc < 0)
+		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
+			rc);
+
+	return rc;
+}
+
+static int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
+				    struct cxl_event_interrupt_policy *policy)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	*policy = (struct cxl_event_interrupt_policy) {
+		.info_settings = CXL_INT_MSI_MSIX,
+		.warn_settings = CXL_INT_MSI_MSIX,
+		.failure_settings = CXL_INT_MSI_MSIX,
+		.fatal_settings = CXL_INT_MSI_MSIX,
+	};
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
+		.payload_in = policy,
+		.size_in = sizeof(*policy),
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
+			rc);
+		return rc;
+	}
+
+	/* Retrieve final interrupt settings */
+	return cxl_event_get_int_policy(cxlds, policy);
+}
+
+static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
+{
+	struct cxl_event_interrupt_policy policy;
+	int rc;
+
+	rc = cxl_event_config_msgnums(cxlds, &policy);
+	if (rc)
+		return rc;
+
+	rc = cxl_event_req_irq(cxlds, policy.info_settings);
+	if (rc) {
+		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
+		return rc;
+	}
+
+	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
+	if (rc) {
+		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
+		return rc;
+	}
+
+	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
+	if (rc) {
+		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
+		return rc;
+	}
+
+	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
+	if (rc) {
+		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+static bool cxl_event_int_is_fw(u8 setting)
+{
+	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
+
+	return mode == CXL_INT_FW;
+}
+
+static int cxl_event_config(struct pci_host_bridge *host_bridge,
+			    struct cxl_dev_state *cxlds)
+{
+	struct cxl_event_interrupt_policy policy;
+	int rc;
+
+	/*
+	 * When BIOS maintains CXL error reporting control, it will process
+	 * event records.  Only one agent can do so.
+	 */
+	if (!host_bridge->native_cxl_error)
+		return 0;
+
+	rc = cxl_mem_alloc_event_buf(cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_event_get_int_policy(cxlds, &policy);
+	if (rc)
+		return rc;
+
+	if (cxl_event_int_is_fw(policy.info_settings) ||
+	    cxl_event_int_is_fw(policy.warn_settings) ||
+	    cxl_event_int_is_fw(policy.failure_settings) ||
+	    cxl_event_int_is_fw(policy.fatal_settings)) {
+		dev_err(cxlds->dev, "FW still in control of Event Logs despite _OSC settings\n");
+		return -EBUSY;
+	}
+
+	rc = cxl_event_irqsetup(cxlds);
+	if (rc)
+		return rc;
+
+	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
+
+	return 0;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -465,6 +668,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
+	pci_set_master(pdev);
 
 	cxlds = cxl_dev_state_create(&pdev->dev);
 	if (IS_ERR(cxlds))
@@ -521,20 +725,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_alloc_irq_vectors(pdev);
+	if (rc)
+		return rc;
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-	/*
-	 * When BIOS maintains CXL error reporting control, it will process
-	 * event records.  Only one agent can do so.
-	 */
-	if (host_bridge->native_cxl_error) {
-		rc = cxl_mem_alloc_event_buf(cxlds);
-		if (rc)
-			return rc;
-		cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
-	}
+	rc = cxl_event_config(host_bridge, cxlds);
+	if (rc)
+		return rc;
 
 	if (cxlds->regs.ras) {
 		pci_enable_pcie_error_reporting(pdev);

-- 
2.39.0
