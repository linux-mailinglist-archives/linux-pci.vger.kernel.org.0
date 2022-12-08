Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26428646878
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 06:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLHFVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 00:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLHFV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 00:21:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC379AE0D;
        Wed,  7 Dec 2022 21:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670476884; x=1702012884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nE8DPf2BvAatWR9zgUH5lrJcjEdL8oJm9HVxIs5vDfA=;
  b=MwJfFt1rw1pQ7OPvZVKdmWYMF3vXAfXF7OZ4aSD33eYSzBx4QSL2rRil
   Uh8iyRKaVwMrxJWpF9qxfrn8sk1h/5ifZXVmZ2QMwnXUqAN4UCsmtKouj
   K+A1wNMkum/LbqgKqWAyo0v9Os6V6QkeecRbb8CHDJURRNS6ZEmxQdf9t
   lYPcP+j9kAo2tybnBIcHifiA5bU0gptfE/I39sg4yco0NvGL7CgFNGZUu
   yKG4/2bRWQds00Dfr7EHqnySzswiwSHevwTzPMjqauZDKVvOd/e4KuQfB
   L0ZV6DUKYy5/rH0nooBPkgb4Jlwnkrp/g1fNO8DmVzLowvbIdM9WxCkY8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381367236"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="381367236"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:21:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="710324461"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="710324461"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.25.22])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:21:21 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V3 2/8] cxl/mem: Wire up event interrupts
Date:   Wed,  7 Dec 2022 21:21:08 -0800
Message-Id: <20221208052115.800170-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208052115.800170-1-ira.weiny@intel.com>
References: <20221208052115.800170-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

---
Changes from V2:
	General clean up
	Use cxl_log_id to ensure each irq is unique even if the message numbers are not
	Jonathan/Dan
		Only set up irq vector when OSC indicates OS control
	Dan
		Loop reading while status indicates there are more
			events.
		Use new cxl_internal_send_cmd()
		Squash MSI/MSIx base patch from Davidlohr
		Remove uapi defines altogether
		Remove use of msi_enabled
	Remove the use of cxl_event_log_type_str()
	Pick up tag

Changes from V1:
	Remove unneeded evt_int_policy from struct cxl_dev_state
	defer Dynamic Capacity support
	Dave Jiang
		s/irq/rc
		use IRQ_NONE to signal the irq was not for us.
	Jonathan
		use msi_enabled rather than nr_irq_vec
		On failure explicitly set CXL_INT_NONE
		Add comment for Get Event Interrupt Policy
		use devm_request_threaded_irq()
		Use individual handler/thread functions for each of the
		logs rather than struct cxl_event_irq_id.

Changes from RFC v2
	Adjust to new irq 16 vector allocation
	Jonathan
		Remove CXL_INT_RES
	Use irq threads to ensure mailbox commands are executed outside irq context
	Adjust for optional Dynamic Capacity log
---
 drivers/cxl/core/mbox.c | 42 +++++++++++++++++++
 drivers/cxl/cxlmem.h    | 28 +++++++++++++
 drivers/cxl/cxlpci.h    |  6 +++
 drivers/cxl/pci.c       | 90 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 815da3aac081..2b25691a9b09 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -854,6 +854,48 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
 
+int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
+			     struct cxl_event_interrupt_policy *policy)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	policy->info_settings = CXL_INT_MSI_MSIX;
+	policy->warn_settings = CXL_INT_MSI_MSIX;
+	policy->failure_settings = CXL_INT_MSI_MSIX;
+	policy->fatal_settings = CXL_INT_MSI_MSIX;
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
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
+		.payload_out = policy,
+		.size_out = sizeof(*policy),
+	};
+
+	/* Retrieve interrupt message numbers */
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
+			rc);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_event_config_msgnums, CXL);
+
 /**
  * cxl_mem_get_partition_info - Get partition info
  * @cxlds: The device data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index dd9aa3dd738e..350cb460e7fc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -194,6 +194,30 @@ struct cxl_endpoint_dvsec_info {
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
+#define CXL_EVENT_INT_MODE_MASK 0x3
+#define CXL_EVENT_INT_MSGNUM(setting) (((setting) & 0xf0) >> 4)
+struct cxl_event_interrupt_policy {
+	u8 info_settings;
+	u8 warn_settings;
+	u8 failure_settings;
+	u8 fatal_settings;
+} __packed;
+
+static inline bool cxl_evt_int_is_msi(u8 setting)
+{
+	return CXL_INT_MSI_MSIX == (setting & CXL_EVENT_INT_MODE_MASK);
+}
+
 /**
  * struct cxl_event_state - Event log driver state
  *
@@ -288,6 +312,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
+	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
+	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
@@ -525,6 +551,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
+int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
+			     struct cxl_event_interrupt_policy *policy);
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 77dbdb980b12..4aaadf17a985 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -53,6 +53,12 @@
 #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
 #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
 
+/*
+ * NOTE: Currently all the functions which are enabled for CXL require their
+ * vectors to be in the first 16.  Use this as the max.
+ */
+#define CXL_PCI_REQUIRED_VECTORS 16
+
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
 	CXL_REGLOC_RBI_EMPTY = 0,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 86c84611a168..c84922a287ec 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -452,6 +452,90 @@ static void cxl_clear_event_logs(struct cxl_dev_state *cxlds)
 	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
 }
 
+static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int nvecs;
+
+	/*
+	 * pci_alloc_irq_vectors() handles calling pci_free_irq_vectors()
+	 * automatically despite not being called pcim_*.  See
+	 * pci_setup_msi_context().
+	 */
+	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
+				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (nvecs < 1)
+		dev_dbg(dev, "Failed to alloc irq vectors: %d\n", nvecs);
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
+	/*
+	 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
+	 * ignore the reserved upper 32 bits
+	 */
+	status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+	while (status) {
+		cxl_mem_get_event_records(cxlds, status);
+		cond_resched();
+		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+	}
+	return IRQ_HANDLED;
+}
+
+static int cxl_req_event_irq(struct cxl_dev_state *cxlds, u8 setting)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_dev_id *dev_id;
+	int irq;
+
+	if (!cxl_evt_int_is_msi(setting))
+		return -ENXIO;
+
+	/* dev_id must be globally unique and must contain the cxlds */
+	dev_id = devm_kmalloc(dev, sizeof(*dev_id), GFP_KERNEL);
+	if (!dev_id)
+		return -ENOMEM;
+	dev_id->cxlds = cxlds;
+
+	irq =  pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting));
+	if (irq < 0)
+		return irq;
+
+	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
+					 IRQF_SHARED, NULL, dev_id);
+}
+
+static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
+{
+	struct cxl_event_interrupt_policy policy;
+
+	if (cxl_event_config_msgnums(cxlds, &policy))
+		return;
+
+	if (cxl_req_event_irq(cxlds, policy.info_settings))
+		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
+
+	if (cxl_req_event_irq(cxlds, policy.warn_settings))
+		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
+
+	if (cxl_req_event_irq(cxlds, policy.failure_settings))
+		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
+
+	if (cxl_req_event_irq(cxlds, policy.fatal_settings))
+		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -526,14 +610,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	cxl_alloc_irq_vectors(cxlds);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
 	if (host_bridge->native_cxl_error) {
 		cxl_mem_alloc_event_buf(cxlds);
-		if (cxlds->event.buf)
+		if (cxlds->event.buf) {
+			cxl_event_irqsetup(cxlds);
 			cxl_clear_event_logs(cxlds);
+		}
 	}
 
 	if (cxlds->regs.ras) {
-- 
2.37.2

