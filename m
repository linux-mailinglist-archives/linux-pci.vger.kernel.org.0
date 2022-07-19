Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ADA57A8A1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 22:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbiGSUx3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 16:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiGSUxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 16:53:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06A661131;
        Tue, 19 Jul 2022 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658263991; x=1689799991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETCOY+/KSy8r6JH8/r52Zon2sw/E+VH4yG2NFCL2QkY=;
  b=LEvNlKHlMdY6SSZ/9EN3iXhWcBiwJpVqSK95AXjt3FRAWZdjhMJzdWSR
   cWXmd5PFlE/ZI1kuccCqqj9u7etbfir/83vW25Vi27z/T+RAQmOKRekY2
   rpJAPOvtPLUFWghL+OIuADLcEu2yNoYcmdgj8qAtezZD0lmX1257VE3K9
   HUKowyIK1EyIx09enCqggdo+qi8WLvi5MuAUhudWJE1+uxsC5Y5VNXIcx
   QTpPOctQ7kzVtCaYzSQF0zwFZ7qVmD1dNQuUyHjZqh2ENY70kGHXiUMYg
   xGhfZOvwet77GvzPEPpvgIote0MgiX6+thlVBOtPep//v+6pI6Q6aeaN5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="350580141"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="350580141"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:53:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="724396793"
Received: from kscamus-mobl1.amr.corp.intel.com (HELO localhost) ([10.255.6.221])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:53:09 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V16 6/6] cxl/port: Read CDAT table
Date:   Tue, 19 Jul 2022 13:52:49 -0700
Message-Id: <20220719205249.566684-7-ira.weiny@intel.com>
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

The per-device CDAT data provides performance data that is relevant for
mapping which CXL devices can participate in which CXL ranges by QTG
(QoS Throttling Group) (per ECN: CXL 2.0 CEDT CFMWS & QTG_DSM) [1]. The
QTG association specified in the ECN is advisory. Until the
cxl_acpi driver grows support for invoking the QTG _DSM method the CDAT
data is only of interest to userspace that may need it for debug
purposes.

Search the DOE mailboxes available, query CDAT data, cache the data and
make it available via a sysfs binary attribute per endpoint at:

/sys/bus/cxl/devices/endpointX/CDAT

...similar to other ACPI-structured table data in
/sys/firmware/ACPI/tables. The CDAT is relative to 'struct cxl_port'
objects since switches in addition to endpoints can host a CDAT
instance. Switch CDAT support is not implemented.

This does not support table updates at runtime. It will always provide
whatever was there when first cached. It is also the case that table
updates are not expected outside of explicit DPA address map affecting
commands like Set Partition with the immediate flag set. Given that the
driver does not support Set Partition with the immediate flag set there
is no current need for update support.

Link: https://www.computeexpresslink.org/spec-landing [1]
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
[djbw: drop in-kernel parsing infra for now, and other minor fixups]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  10 ++
 drivers/cxl/core/pci.c                  | 173 ++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   7 +
 drivers/cxl/cxlpci.h                    |   1 +
 drivers/cxl/port.c                      |  53 ++++++++
 5 files changed, 244 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 1fd5984b6158..e94c5aebc368 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -164,3 +164,13 @@ Description:
 		expander memory (type-3). The 'target_type' attribute indicates
 		the current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+What:		/sys/bus/cxl/devices/endpointX/CDAT
+Date:		July, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) If this sysfs entry is not present no DOE mailbox was
+		found to support CDAT data.  If it is present and the length of
+		the data is 0 reading the CDAT data failed.  Otherwise the CDAT
+		data is reported.
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7672789c3225..9240df53ed87 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -452,3 +453,175 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
+
+#define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
+#define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
+#define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
+#define   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA	0
+#define CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE	0xffff0000
+#define CXL_DOE_TABLE_ACCESS_LAST_ENTRY		0xffff
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
+static struct pci_doe_mb *find_cdat_doe(struct device *uport)
+{
+	struct cxl_memdev *cxlmd;
+	struct cxl_dev_state *cxlds;
+	unsigned long index;
+	void *entry;
+
+	cxlmd = to_cxl_memdev(uport);
+	cxlds = cxlmd->cxlds;
+
+	xa_for_each(&cxlds->doe_mbs, index, entry) {
+		struct pci_doe_mb *cur = entry;
+
+		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
+					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
+			return cur;
+	}
+
+	return NULL;
+}
+
+#define CDAT_DOE_REQ(entry_handle)					\
+	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
+		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
+		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
+
+static void cxl_doe_task_complete(struct pci_doe_task *task)
+{
+	complete(task->private);
+}
+
+struct cdat_doe_task {
+	u32 request_pl;
+	u32 response_pl[32];
+	struct completion c;
+	struct pci_doe_task task;
+};
+
+#define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
+struct cdat_doe_task cdt = {                                  \
+	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
+	.request_pl = req,				      \
+	.task = {                                             \
+		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
+		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS, \
+		.request_pl = &cdt.request_pl,                \
+		.request_pl_sz = sizeof(cdt.request_pl),      \
+		.response_pl = cdt.response_pl,               \
+		.response_pl_sz = sizeof(cdt.response_pl),    \
+		.complete = cxl_doe_task_complete,            \
+		.private = &cdt.c,                            \
+	}                                                     \
+}
+
+static int cxl_cdat_get_length(struct device *dev,
+			       struct pci_doe_mb *cdat_doe,
+			       size_t *length)
+{
+	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
+	int rc;
+
+	rc = pci_doe_submit_task(cdat_doe, &t.task);
+	if (rc < 0) {
+		dev_err(dev, "DOE submit failed: %d", rc);
+		return rc;
+	}
+	wait_for_completion(&t.c);
+	if (t.task.rv < sizeof(u32))
+		return -EIO;
+
+	*length = t.response_pl[1];
+	dev_dbg(dev, "CDAT length %zu\n", *length);
+
+	return 0;
+}
+
+static int cxl_cdat_read_table(struct device *dev,
+			       struct pci_doe_mb *cdat_doe,
+			       struct cxl_cdat *cdat)
+{
+	size_t length = cdat->length;
+	u32 *data = cdat->table;
+	int entry_handle = 0;
+
+	do {
+		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
+		size_t entry_dw;
+		u32 *entry;
+		int rc;
+
+		rc = pci_doe_submit_task(cdat_doe, &t.task);
+		if (rc < 0) {
+			dev_err(dev, "DOE submit failed: %d", rc);
+			return rc;
+		}
+		wait_for_completion(&t.c);
+		/* 1 DW header + 1 DW data min */
+		if (t.task.rv < (2 * sizeof(u32)))
+			return -EIO;
+
+		/* Get the CXL table access header entry handle */
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
+					 t.response_pl[0]);
+		entry = t.response_pl + 1;
+		entry_dw = t.task.rv / sizeof(u32);
+		/* Skip Header */
+		entry_dw -= 1;
+		entry_dw = min(length / sizeof(u32), entry_dw);
+		/* Prevent length < 1 DW from causing a buffer overflow */
+		if (entry_dw) {
+			memcpy(data, entry, entry_dw * sizeof(u32));
+			length -= entry_dw * sizeof(u32);
+			data += entry_dw;
+		}
+	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
+
+	return 0;
+}
+
+/**
+ * read_cdat_data - Read the CDAT data on this port
+ * @port: Port to read data from
+ *
+ * This call will sleep waiting for responses from the DOE mailbox.
+ */
+void read_cdat_data(struct cxl_port *port)
+{
+	struct pci_doe_mb *cdat_doe;
+	struct device *dev = &port->dev;
+	struct device *uport = port->uport;
+	size_t cdat_length;
+	int rc;
+
+	cdat_doe = find_cdat_doe(uport);
+	if (!cdat_doe) {
+		dev_dbg(dev, "No CDAT mailbox\n");
+		return;
+	}
+
+	port->cdat_available = true;
+
+	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
+		dev_dbg(dev, "No CDAT length\n");
+		return;
+	}
+
+	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
+	if (!port->cdat.table)
+		return;
+
+	port->cdat.length = cdat_length;
+	rc = cxl_cdat_read_table(dev, cdat_doe, &port->cdat);
+	if (rc) {
+		/* Don't leave table data allocated on error */
+		devm_kfree(dev, port->cdat.table);
+		port->cdat.table = NULL;
+		port->cdat.length = 0;
+		dev_err(dev, "CDAT data read error\n");
+	}
+}
+EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 570bd9f8141b..21a9d6fcc61e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -289,6 +289,8 @@ struct cxl_nvdimm {
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
+ * @cdat: Cached CDAT data
+ * @cdat_available: Should a CDAT attribute be available in sysfs
  */
 struct cxl_port {
 	struct device dev;
@@ -301,6 +303,11 @@ struct cxl_port {
 	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
+	struct cxl_cdat {
+		void *table;
+		size_t length;
+	} cdat;
+	bool cdat_available;
 };
 
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index fce1c11729c2..eec597dbe763 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
+void read_cdat_data(struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 3cf308f114c4..5453771bf330 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -53,6 +53,9 @@ static int cxl_port_probe(struct device *dev)
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
 		struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
+		/* Cache the data early to ensure is_visible() works */
+		read_cdat_data(port);
+
 		get_device(&cxlmd->dev);
 		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
 		if (rc)
@@ -78,10 +81,60 @@ static int cxl_port_probe(struct device *dev)
 	return 0;
 }
 
+static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if (!port->cdat_available)
+		return -ENXIO;
+
+	if (!port->cdat.table)
+		return 0;
+
+	return memory_read_from_buffer(buf, count, &offset,
+				       port->cdat.table,
+				       port->cdat.length);
+}
+
+static BIN_ATTR_ADMIN_RO(CDAT, 0);
+
+static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
+					    struct bin_attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if ((attr == &bin_attr_CDAT) && port->cdat_available)
+		return attr->attr.mode;
+
+	return 0;
+}
+
+static struct bin_attribute *cxl_cdat_bin_attributes[] = {
+	&bin_attr_CDAT,
+	NULL,
+};
+
+static struct attribute_group cxl_cdat_attribute_group = {
+	.bin_attrs = cxl_cdat_bin_attributes,
+	.is_bin_visible = cxl_port_bin_attr_is_visible,
+};
+
+static const struct attribute_group *cxl_port_attribute_groups[] = {
+	&cxl_cdat_attribute_group,
+	NULL,
+};
+
 static struct cxl_driver cxl_port_driver = {
 	.name = "cxl_port",
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
+	.drv = {
+		.dev_groups = cxl_port_attribute_groups,
+	},
 };
 
 module_cxl_driver(cxl_port_driver);
-- 
2.35.3

