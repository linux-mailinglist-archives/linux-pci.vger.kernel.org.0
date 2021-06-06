Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841A539CD9B
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFFGHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 02:07:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:65367 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhFFGHO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 02:07:14 -0400
IronPort-SDR: 7QXAiA/y2Gu2FRYJ+f/08tMELvkVbr4tXKEPPAq37xrszi9CrwSBVe3g1d9HhCXhSWFAZDFyUl
 BhwJ5fxFSl3g==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="204456559"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="204456559"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:05:25 -0700
IronPort-SDR: mXD91DzjKjQEQ4MU7FJI54jX2AM6QlqHjU7xbHiNCC9EXZsTMPnBKPYi701JWPWVka2tqW+y6l
 WMsqyuwWp42g==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="447133004"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:05:22 -0700
Subject: [PATCH v5 5/6] cxl/acpi: Enumerate host bridge root ports
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Sat, 05 Jun 2021 23:05:22 -0700
Message-ID: <162295952254.1109360.12071591891784594995.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While the resources enumerated by the CEDT.CFMWS identify a cxl_port
with host bridges as downstream ports, host bridges themselves are
upstream ports that decode to downstream ports represented by PCIe Root
Ports. Walk the PCIe Root Ports connected to a CXL Host Bridge,
identified by the ACPI0016 _HID, and add each one as a cxl_dport of the
host bridge cxl_port.

For now, component registers are not enumerated, only the first order
uport / dport relationships.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 0ae7464b603d..ec324bf063b8 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -8,6 +8,48 @@
 #include <linux/pci.h>
 #include "cxl.h"
 
+struct cxl_walk_context {
+	struct device *dev;
+	struct pci_bus *root;
+	struct cxl_port *port;
+	int error;
+	int count;
+};
+
+static int match_add_root_ports(struct pci_dev *pdev, void *data)
+{
+	struct cxl_walk_context *ctx = data;
+	struct pci_bus *root_bus = ctx->root;
+	struct cxl_port *port = ctx->port;
+	int type = pci_pcie_type(pdev);
+	struct device *dev = ctx->dev;
+	u32 lnkcap, port_num;
+	int rc;
+
+	if (pdev->bus != root_bus)
+		return 0;
+	if (!pci_is_pcie(pdev))
+		return 0;
+	if (type != PCI_EXP_TYPE_ROOT_PORT)
+		return 0;
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap) != PCIBIOS_SUCCESSFUL)
+		return 0;
+
+	/* TODO walk DVSEC to find component register base */
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
+	if (rc) {
+		ctx->error = rc;
+		return rc;
+	}
+	ctx->count++;
+
+	dev_dbg(dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
+
+	return 0;
+}
+
 static struct acpi_device *to_cxl_host_bridge(struct device *dev)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
@@ -17,6 +59,44 @@ static struct acpi_device *to_cxl_host_bridge(struct device *dev)
 	return NULL;
 }
 
+/*
+ * A host bridge is a dport to a CFMWS decode and it is a uport to the
+ * dport (PCIe Root Ports) in the host bridge.
+ */
+static int add_host_bridge_uport(struct device *match, void *arg)
+{
+	struct acpi_device *bridge = to_cxl_host_bridge(match);
+	struct cxl_port *root_port = arg;
+	struct device *host = root_port->dev.parent;
+	struct acpi_pci_root *pci_root;
+	struct cxl_walk_context ctx;
+	struct cxl_port *port;
+
+	if (!bridge)
+		return 0;
+
+	pci_root = acpi_pci_find_root(bridge->handle);
+	if (!pci_root)
+		return -ENXIO;
+
+	/* TODO: fold in CEDT.CHBS retrieval */
+	port = devm_cxl_add_port(host, match, CXL_RESOURCE_NONE, root_port);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
+
+	ctx = (struct cxl_walk_context){
+		.dev = host,
+		.root = pci_root->bus,
+		.port = port,
+	};
+	pci_walk_bus(pci_root->bus, match_add_root_ports, &ctx);
+
+	if (ctx.count == 0)
+		return -ENODEV;
+	return ctx.error;
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	int rc;
@@ -49,6 +129,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
+	int rc;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
@@ -58,8 +139,20 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(root_port);
 	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
 
-	return bus_for_each_dev(adev->dev.bus, NULL, root_port,
-				add_host_bridge_dport);
+	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
+			      add_host_bridge_dport);
+	if (rc)
+		return rc;
+
+	/*
+	 * Root level scanned with host-bridge as dports, now scan host-bridges
+	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
+	 */
+	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
+			      add_host_bridge_uport);
+	if (rc)
+		dev_err(host, "failed to scan host bridges\n");
+	return 0;
 }
 
 static const struct acpi_device_id cxl_acpi_ids[] = {

