Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615D5497690
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiAXAaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:30:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:35966 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235274AbiAXAaJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984209; x=1674520209;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3yfBWHBbQKhIxdjZwLsAgAxwbEhyIeQ4v9kzQzXdSCs=;
  b=NuuaAVlw/H7WRykZQGlUgaOdg8To5IR/IxnFNnvKolop977PE/LETB+v
   H628h/Ham7fWf3tTOuKlMaCFeOiJVP+1vlvyxR0MF6FFUK1mxwYCEc2Hw
   6lWTaqAASHF0164Rcm6Z9/FRbdNQBy2Ku0b+/QiOHrmDy2OjAmFms5xB/
   0JelLRIywzPVHLLRP+d/I/TtC1VGMDU5rj51M/jy1R34M16Vxt5WVj0Es
   XNEIpadwAVBwoWhoWqp0ESOqeS5s8ZhGlXzoiANUGQhQyqXjFHKBSyu6T
   rAllWOm1BtnMSnhfy60d4culrzRxhpwejipqyNnF0CzcbM01Ji9Nq0IHR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233292390"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233292390"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476536859"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:09 -0800
Subject: [PATCH v3 17/40] cxl/port: Introduce cxl_port_to_pci_bus()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:30:09 -0800
Message-ID: <164298420951.3018233.1498794101372312682.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a helper for converting a PCI enumerated cxl_port into the pci_bus
that hosts its dports. For switch ports this is trivial, but for root
ports there is no generic way to go from a platform defined host bridge
device, like ACPI0016 to its corresponding pci_bus. Rather than spill
ACPI goop outside of the cxl_acpi driver, just arrange for it to
register an xarray translation from the uport device to the
corresponding pci_bus.

This is in preparation for centralizing dport enumeration in the core.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |   14 +++++++++-----
 drivers/cxl/core/port.c |   37 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    3 +++
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 93d1dc56892a..ab2b76532272 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -225,17 +225,21 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return 0;
 	}
 
+	/*
+	 * Note that this lookup already succeeded in
+	 * to_cxl_host_bridge(), so no need to check for failure here
+	 */
+	pci_root = acpi_pci_find_root(bridge->handle);
+	rc = devm_cxl_register_pci_bus(host, match, pci_root->bus);
+	if (rc)
+		return rc;
+
 	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
 				 root_port);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
 
-	/*
-	 * Note that this lookup already succeeded in
-	 * to_cxl_host_bridge(), so no need to check for failure here
-	 */
-	pci_root = acpi_pci_find_root(bridge->handle);
 	ctx = (struct cxl_walk_context){
 		.dev = host,
 		.root = pci_root->bus,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 58089ea09aa3..e1372fe13a11 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -25,6 +25,7 @@
  */
 
 static DEFINE_IDA(cxl_port_ida);
+static DEFINE_XARRAY(cxl_root_buses);
 
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -420,6 +421,42 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
 
+struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
+{
+	/* There is no pci_bus associated with a CXL platform-root port */
+	if (is_cxl_root(port))
+		return NULL;
+
+	if (dev_is_pci(port->uport)) {
+		struct pci_dev *pdev = to_pci_dev(port->uport);
+
+		return pdev->subordinate;
+	}
+
+	return xa_load(&cxl_root_buses, (unsigned long)port->uport);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_to_pci_bus, CXL);
+
+static void unregister_pci_bus(void *uport)
+{
+	xa_erase(&cxl_root_buses, (unsigned long) uport);
+}
+
+int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
+			      struct pci_bus *bus)
+{
+	int rc;
+
+	if (dev_is_pci(uport))
+		return -EINVAL;
+
+	rc = xa_insert(&cxl_root_buses, (unsigned long)uport, bus, GFP_KERNEL);
+	if (rc)
+		return rc;
+	return devm_add_action_or_reset(host, unregister_pci_bus, uport);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, CXL);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 47c256ad105f..4e8d504546c5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -289,6 +289,9 @@ static inline bool is_cxl_root(struct cxl_port *port)
 
 bool is_cxl_port(struct device *dev);
 struct cxl_port *to_cxl_port(struct device *dev);
+int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
+			      struct pci_bus *bus);
+struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);

