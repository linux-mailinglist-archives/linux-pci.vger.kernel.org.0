Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F60F4579F4
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhKTAGX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:5724 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236343AbhKTAGN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542419"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542419"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088411"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:00 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 21/23] cxl: Unify port enumeration for decoders
Date:   Fri, 19 Nov 2021 16:02:48 -0800
Message-Id: <20211120000250.1663391-22-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The port driver exists to do proper enumeration of the component
registers for ports, including HDM decoder resources. Any port which
follows the CXL specification to implement HDM decoder registers should
be handled by the port driver. This includes host bridge registers that
are currently handled within the cxl_acpi driver.

In moving the responsibility from cxl_acpi to cxl_port, three primary
things are accomplished here:
1. Multi-port host bridges are now handled by the port driver
2. Single port host bridges are handled by the port driver
3. Single port switches without component registers will be handled by
   the port driver.

While it's tempting to remove decoder APIs from cxl_core entirely, it is
still required that platform specific drivers are able to add decoders
which aren't specified in CXL 2.0+. An example of this is the CFMWS
parsing which is implementing in cxl_acpi.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since RFCv2:
- Renamed subject
- Reworded commit message
- Handle *all* host bridge port enumeration in cxl_port (Dan)
  - Handle passthrough decoding in cxl_port
---
 drivers/cxl/acpi.c     | 41 +++-----------------------------
 drivers/cxl/core/bus.c |  6 +++--
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/port.c     | 54 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index c12e4fed7941..c85a04ecbf7f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -210,8 +210,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
 	struct acpi_pci_root *pci_root;
 	struct cxl_walk_context ctx;
-	int single_port_map[1], rc;
-	struct cxl_decoder *cxld;
 	struct cxl_dport *dport;
 	struct cxl_port *port;
 
@@ -245,43 +243,9 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return -ENODEV;
 	if (ctx.error)
 		return ctx.error;
-	if (ctx.count > 1)
-		return 0;
 
-	/* TODO: Scan CHBCR for HDM Decoder resources */
-
-	/*
-	 * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
-	 * Structure) single ported host-bridges need not publish a decoder
-	 * capability when a passthrough decode can be assumed, i.e. all
-	 * transactions that the uport sees are claimed and passed to the single
-	 * dport. Disable the range until the first CXL region is enumerated /
-	 * activated.
-	 */
-	cxld = cxl_decoder_alloc(port, 1);
-	if (IS_ERR(cxld))
-		return PTR_ERR(cxld);
-
-	cxld->interleave_ways = 1;
-	cxld->interleave_granularity = PAGE_SIZE;
-	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
-
-	device_lock(&port->dev);
-	dport = list_first_entry(&port->dports, typeof(*dport), list);
-	device_unlock(&port->dev);
-
-	single_port_map[0] = dport->port_id;
-
-	rc = cxl_decoder_add(cxld, single_port_map);
-	if (rc)
-		put_device(&cxld->dev);
-	else
-		rc = cxl_decoder_autoremove(host, cxld);
-
-	if (rc == 0)
-		dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
-	return rc;
+	/* Host bridge ports are enumerated by the port driver. */
+	return 0;
 }
 
 struct cxl_chbs_context {
@@ -448,3 +412,4 @@ module_platform_driver(cxl_acpi_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_IMPORT_NS(ACPI);
+MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 46a06cfe79bd..acfa212eea21 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -62,7 +62,7 @@ void cxl_unregister_topology_host(struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_unregister_topology_host, CXL);
 
-static struct device *get_cxl_topology_host(void)
+struct device *get_cxl_topology_host(void)
 {
 	down_read(&topology_host_sem);
 	if (cxl_topology_host)
@@ -70,12 +70,14 @@ static struct device *get_cxl_topology_host(void)
 	up_read(&topology_host_sem);
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(get_cxl_topology_host, CXL);
 
-static void put_cxl_topology_host(struct device *dev)
+void put_cxl_topology_host(struct device *dev)
 {
 	WARN_ON(dev != cxl_topology_host);
 	up_read(&topology_host_sem);
 }
+EXPORT_SYMBOL_NS_GPL(put_cxl_topology_host, CXL);
 
 static int decoder_match(struct device *dev, void *data)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 24fa16157d5e..f8354241c5a3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -170,6 +170,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 int cxl_register_topology_host(struct device *host);
 void cxl_unregister_topology_host(struct device *host);
+struct device *get_cxl_topology_host(void);
+void put_cxl_topology_host(struct device *dev);
 
 /*
  * cxl_decoder flags that define the type of memory / devices this
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 3c03131517af..7a1fc726fe9f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -233,12 +233,64 @@ static int enumerate_hdm_decoders(struct cxl_port *port,
 	return 0;
 }
 
+/*
+ * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
+ * single ported host-bridges need not publish a decoder capability when a
+ * passthrough decode can be assumed, i.e. all transactions that the uport sees
+ * are claimed and passed to the single dport. Disable the range until the first
+ * CXL region is enumerated / activated.
+ */
+static int add_passthrough_decoder(struct cxl_port *port)
+{
+	int single_port_map[1], rc;
+	struct cxl_decoder *cxld;
+	struct cxl_dport *dport;
+
+	device_lock_assert(&port->dev);
+
+	cxld = cxl_decoder_alloc(port, 1);
+	if (IS_ERR(cxld))
+		return PTR_ERR(cxld);
+
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = PAGE_SIZE;
+	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
+
+	dport = list_first_entry(&port->dports, typeof(*dport), list);
+	single_port_map[0] = dport->port_id;
+
+	rc = cxl_decoder_add_locked(cxld, single_port_map);
+	if (rc)
+		put_device(&cxld->dev);
+	else
+		rc = cxl_decoder_autoremove(&port->dev, cxld);
+
+	if (rc == 0)
+		dev_dbg(&port->dev, "add: %s\n", dev_name(&cxld->dev));
+
+	return rc;
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
 	struct cxl_port_data *portdata;
 	void __iomem *crb;
-	int rc;
+	int rc = 0;
+
+	if (list_is_singular(&port->dports)) {
+		struct device *host_dev = get_cxl_topology_host();
+
+		/*
+		 * Root ports (single host bridge downstream) are handled by
+		 * platform driver
+		 */
+		if (port->uport != host_dev)
+			rc = add_passthrough_decoder(port);
+		put_cxl_topology_host(host_dev);
+		return rc;
+	}
 
 	if (port->component_reg_phys == CXL_RESOURCE_NONE)
 		return 0;
-- 
2.34.0

