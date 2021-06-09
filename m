Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749FA3A1A80
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhFIQIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 12:08:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:32597 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232900AbhFIQIP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 12:08:15 -0400
IronPort-SDR: JcqdW0pZvsCJ6pIwFKpK1tY/5SBEHI+dfH1IwiO9NNLBCtpMGgLJyvqHz0BHv4CBpZvzegURzq
 edFliC+uvsgg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202077381"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="202077381"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:01:52 -0700
IronPort-SDR: ZB2hQTWdy7tmPjGitAyO9AXL+e7XgsGbeLyh5Lg663WEvELMuKdYn6i3SH1XkrNFAuTLNhhlhB
 8olLOBQKXQAA==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="476999736"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:01:51 -0700
Subject: [PATCH v6 4/5] cxl/acpi: Enumerate host bridge root ports
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Wed, 09 Jun 2021 09:01:51 -0700
Message-ID: <162325451145.2293126.10149150938788969381.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162325448982.2293126.16916114289970424561.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162325448982.2293126.16916114289970424561.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 5eb9543c587a..1f075dffc042 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -5,8 +5,51 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
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
@@ -16,6 +59,44 @@ static struct acpi_device *to_cxl_host_bridge(struct device *dev)
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
@@ -48,6 +129,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
+	int rc;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
@@ -57,8 +139,17 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(root_port);
 	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
 
+	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
+			      add_host_bridge_dport);
+	if (rc)
+		return rc;
+
+	/*
+	 * Root level scanned with host-bridge as dports, now scan host-bridges
+	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
+	 */
 	return bus_for_each_dev(adev->dev.bus, NULL, root_port,
-				add_host_bridge_dport);
+				add_host_bridge_uport);
 }
 
 static const struct acpi_device_id cxl_acpi_ids[] = {

