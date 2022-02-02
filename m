Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959524A76B1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiBBRUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 12:20:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:46564 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbiBBRUK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Feb 2022 12:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643822410; x=1675358410;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CSIWMpATQKuZGE6ztX9CrPfI3vwpQY5c3J35kGaK8p4=;
  b=YRnBBolcOCIoCYhWTQXUowbwYvyYT952Fpme1HjBLxXCLjlgzI2JkZ4r
   nItov2p2UQgDXProytOfAD86NLSqAhKZl5uyn8G1RB0yHb7Hca/j7ZEIE
   4BGtnYRTTticrAWEs4Vu7w1d6uuKIYd9huJbms4W6HZdfkcwFmsFRjq6S
   kvLrdBb2ryx/utudnu84luXi5/xVanlwPSJnCG/b2U5u19VL5SEiyg4OD
   M+pycZfpnjsc0eL6triZhrYnPxDrewXkdgDWQdHNnlVxYiAGxQaA1evPo
   NWAU/D0v0u5yq50BrlrTtYPRyBSO6kl167kXlG84BS5v+tLTCVl4SwOii
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247743077"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="247743077"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 09:07:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="523570662"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 09:07:55 -0800
Subject: [PATCH v4 32/40] cxl/core/port: Add switch port enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Wed, 02 Feb 2022 09:07:55 -0800
Message-ID: <164382166570.690900.541361103681784580.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298428940.3018233.18042207990919432824.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298428940.3018233.18042207990919432824.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So far the platorm level CXL resources have been enumerated by the
cxl_acpi driver, and cxl_pci has gathered all the pre-requisite
information it needs to fire up a cxl_mem driver. However, the first
thing the cxl_mem driver will be tasked to do is validate that all the
PCIe Switches in its ancestry also have CXL capabilities and an CXL.mem
link established.

Provide a common mechanism for a CXL.mem endpoint driver to enumerate
all the ancestor CXL ports in the topology and validate CXL.mem
connectivity.

Multiple endpoints may end up racing to establish a shared port in the
topology. This race is resolved via taking the device-lock on a parent
CXL Port before establishing a new child. The winner of the race
establishes the port, the loser simply registers its interest in the
port via 'struct cxl_ep' place-holder reference.

At endpoint teardown the same parent port lock is taken as 'struct
cxl_ep' references are deleted. Last endpoint to drop its reference
unregisters the port.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3:
- s/cxl_remove_ep/cxl_detach_ep/ to disclaim symmetry with 'add_ep'
  (Jonathan)
- Clarify the theory of operation of the manual devm_release_action()
  calls in delete_switch_port() (Jonathan)
- Clarify the switch topology walking assumptions of the grandparent()
  helper (Ben)
- Clarify the role of the "root_child" in port enumeration by sharing a
  common dev_is_cxl_root_child() helper with find_cxl_root() (Jonathan)
- Clarify the races that can be happening in cxl_detach_ep() (Ben)
- Move dev_dbg() out of delete_switch_port() to the caller (Ben)
- Simplify the "root port not yet available" case in
  add_port_attach_ep() (Jonathan)
- Fix use but not set bug in add_port_attach_ep() error exit case
  (Jonathan)
- Reorder dev_warn() vs dev_dbg() in devm_cxl_enumerate_ports()
  (Jonathan)
- Clarify loop termination condition in devm_cxl_enumerate_ports()
  (Jonathan)

 drivers/cxl/acpi.c      |   17 --
 drivers/cxl/core/port.c |  433 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |   20 ++
 3 files changed, 445 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 683f2ca32c97..7bd53dc691ec 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -130,21 +130,6 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
-static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
-{
-	struct cxl_dport *dport;
-
-	cxl_device_lock(&port->dev);
-	list_for_each_entry(dport, &port->dports, list)
-		if (dport->dport == dev) {
-			cxl_device_unlock(&port->dev);
-			return dport;
-		}
-
-	cxl_device_unlock(&port->dev);
-	return NULL;
-}
-
 __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 					      struct device *dev)
 {
@@ -175,7 +160,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (!bridge)
 		return 0;
 
-	dport = find_dport_by_dev(root_port, match);
+	dport = cxl_find_dport_by_dev(root_port, match);
 	if (!dport) {
 		dev_dbg(host, "host bridge expected and not found\n");
 		return 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 62b9f5dc64b5..4a52d5596243 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include <cxl.h>
 #include "core.h"
 
@@ -265,10 +266,24 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
 
+static void cxl_ep_release(struct cxl_ep *ep)
+{
+	if (!ep)
+		return;
+	list_del(&ep->list);
+	put_device(ep->ep);
+	kfree(ep);
+}
+
 static void cxl_port_release(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
+	struct cxl_ep *ep, *_e;
 
+	cxl_device_lock(dev);
+	list_for_each_entry_safe(ep, _e, &port->endpoints, list)
+		cxl_ep_release(ep);
+	cxl_device_unlock(dev);
 	ida_free(&cxl_port_ida, port->id);
 	kfree(port);
 }
@@ -359,6 +374,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	INIT_LIST_HEAD(&port->dports);
+	INIT_LIST_HEAD(&port->endpoints);
 
 	device_initialize(dev);
 	device_set_pm_not_required(dev);
@@ -457,25 +473,36 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, CXL);
 
-/* Find a 2nd level CXL port that has a dport that is an ancestor of @match */
-static int match_root_child(struct device *dev, const void *match)
+static bool dev_is_cxl_root_child(struct device *dev)
 {
-	const struct device *iter = NULL;
 	struct cxl_port *port, *parent;
-	struct cxl_dport *dport;
 
 	if (!is_cxl_port(dev))
-		return 0;
+		return false;
 
 	port = to_cxl_port(dev);
 	if (is_cxl_root(port))
-		return 0;
+		return false;
 
 	parent = to_cxl_port(port->dev.parent);
-	if (!is_cxl_root(parent))
+	if (is_cxl_root(parent))
+		return true;
+
+	return false;
+}
+
+/* Find a 2nd level CXL port that has a dport that is an ancestor of @match */
+static int match_root_child(struct device *dev, const void *match)
+{
+	const struct device *iter = NULL;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	if (!dev_is_cxl_root_child(dev))
 		return 0;
 
-	cxl_device_lock(&port->dev);
+	port = to_cxl_port(dev);
+	cxl_device_lock(dev);
 	list_for_each_entry(dport, &port->dports, list) {
 		iter = match;
 		while (iter) {
@@ -485,7 +512,7 @@ static int match_root_child(struct device *dev, const void *match)
 		}
 	}
 out:
-	cxl_device_unlock(&port->dev);
+	cxl_device_unlock(dev);
 
 	return !!iter;
 }
@@ -642,6 +669,394 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
 
+static struct cxl_ep *find_ep(struct cxl_port *port, struct device *ep_dev)
+{
+	struct cxl_ep *ep;
+
+	device_lock_assert(&port->dev);
+	list_for_each_entry(ep, &port->endpoints, list)
+		if (ep->ep == ep_dev)
+			return ep;
+	return NULL;
+}
+
+static int add_ep(struct cxl_port *port, struct cxl_ep *new)
+{
+	struct cxl_ep *dup;
+
+	cxl_device_lock(&port->dev);
+	if (port->dead) {
+		cxl_device_unlock(&port->dev);
+		return -ENXIO;
+	}
+	dup = find_ep(port, new->ep);
+	if (!dup)
+		list_add_tail(&new->list, &port->endpoints);
+	cxl_device_unlock(&port->dev);
+
+	return dup ? -EEXIST : 0;
+}
+
+/**
+ * cxl_add_ep - register an endpoint's interest in a port
+ * @port: a port in the endpoint's topology ancestry
+ * @ep_dev: device representing the endpoint
+ *
+ * Intermediate CXL ports are scanned based on the arrival of endpoints.
+ * When those endpoints depart the port can be destroyed once all
+ * endpoints that care about that port have been removed.
+ */
+static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
+{
+	struct cxl_ep *ep;
+	int rc;
+
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ep->list);
+	ep->ep = get_device(ep_dev);
+
+	rc = add_ep(port, ep);
+	if (rc)
+		cxl_ep_release(ep);
+	return rc;
+}
+
+struct cxl_find_port_ctx {
+	const struct device *dport_dev;
+	const struct cxl_port *parent_port;
+};
+
+static int match_port_by_dport(struct device *dev, const void *data)
+{
+	const struct cxl_find_port_ctx *ctx = data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+	if (ctx->parent_port && dev->parent != &ctx->parent_port->dev)
+		return 0;
+
+	port = to_cxl_port(dev);
+	return cxl_find_dport_by_dev(port, ctx->dport_dev) != NULL;
+}
+
+static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
+{
+	struct device *dev;
+
+	if (!ctx->dport_dev)
+		return NULL;
+
+	dev = bus_find_device(&cxl_bus_type, NULL, ctx, match_port_by_dport);
+	if (dev)
+		return to_cxl_port(dev);
+	return NULL;
+}
+
+static struct cxl_port *find_cxl_port(struct device *dport_dev)
+{
+	struct cxl_find_port_ctx ctx = {
+		.dport_dev = dport_dev,
+	};
+
+	return __find_cxl_port(&ctx);
+}
+
+static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
+					 struct device *dport_dev)
+{
+	struct cxl_find_port_ctx ctx = {
+		.dport_dev = dport_dev,
+		.parent_port = parent_port,
+	};
+
+	return __find_cxl_port(&ctx);
+}
+
+/*
+ * All users of grandparent() are using it to walk PCIe-like swich port
+ * hierarchy. A PCIe switch is comprised of a bridge device representing the
+ * upstream switch port and N bridges representing downstream switch ports. When
+ * bridges stack the grand-parent of a downstream switch port is another
+ * downstream switch port in the immediate ancestor switch.
+ */
+static struct device *grandparent(struct device *dev)
+{
+	if (dev && dev->parent)
+		return dev->parent->parent;
+	return NULL;
+}
+
+/*
+ * The natural end of life of a non-root 'cxl_port' is when its parent port goes
+ * through a ->remove() event ("top-down" unregistration). The unnatural trigger
+ * for a port to be unregistered is when all memdevs beneath that port have gone
+ * through ->remove(). This "bottom-up" removal selectively removes individual
+ * child ports manually. This depends on devm_cxl_add_port() to not change is
+ * devm action registration order.
+ */
+static void delete_switch_port(struct cxl_port *port, struct list_head *dports)
+{
+	struct cxl_dport *dport, *_d;
+
+	list_for_each_entry_safe(dport, _d, dports, list) {
+		devm_release_action(&port->dev, cxl_dport_unlink, dport);
+		devm_release_action(&port->dev, cxl_dport_remove, dport);
+		devm_kfree(&port->dev, dport);
+	}
+	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
+	devm_release_action(port->dev.parent, unregister_port, port);
+}
+
+static void cxl_detach_ep(void *data)
+{
+	struct cxl_memdev *cxlmd = data;
+	struct device *iter;
+
+	for (iter = &cxlmd->dev; iter; iter = grandparent(iter)) {
+		struct device *dport_dev = grandparent(iter);
+		struct cxl_port *port, *parent_port;
+		LIST_HEAD(reap_dports);
+		struct cxl_ep *ep;
+
+		if (!dport_dev)
+			break;
+
+		port = find_cxl_port(dport_dev);
+		if (!port || is_cxl_root(port)) {
+			put_device(&port->dev);
+			continue;
+		}
+
+		parent_port = to_cxl_port(port->dev.parent);
+		cxl_device_lock(&parent_port->dev);
+		if (!parent_port->dev.driver) {
+			/*
+			 * The bottom-up race to delete the port lost to a
+			 * top-down port disable, give up here, because the
+			 * parent_port ->remove() will have cleaned up all
+			 * descendants.
+			 */
+			cxl_device_unlock(&parent_port->dev);
+			put_device(&port->dev);
+			continue;
+		}
+
+		cxl_device_lock(&port->dev);
+		ep = find_ep(port, &cxlmd->dev);
+		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
+			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
+		cxl_ep_release(ep);
+		if (ep && !port->dead && list_empty(&port->endpoints) &&
+		    !is_cxl_root(parent_port)) {
+			/*
+			 * This was the last ep attached to a dynamically
+			 * enumerated port. Block new cxl_add_ep() and garbage
+			 * collect the port.
+			 */
+			port->dead = true;
+			list_splice_init(&port->dports, &reap_dports);
+		}
+		cxl_device_unlock(&port->dev);
+
+		if (!list_empty(&reap_dports)) {
+			dev_dbg(&cxlmd->dev, "delete %s\n",
+				dev_name(&port->dev));
+			delete_switch_port(port, &reap_dports);
+		}
+		put_device(&port->dev);
+		cxl_device_unlock(&parent_port->dev);
+	}
+}
+
+static resource_size_t find_component_registers(struct device *dev)
+{
+	struct cxl_register_map map;
+	struct pci_dev *pdev;
+
+	/*
+	 * Theoretically, CXL component registers can be hosted on a
+	 * non-PCI device, in practice, only cxl_test hits this case.
+	 */
+	if (!dev_is_pci(dev))
+		return CXL_RESOURCE_NONE;
+
+	pdev = to_pci_dev(dev);
+
+	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	return cxl_regmap_to_base(pdev, &map);
+}
+
+static int add_port_attach_ep(struct cxl_memdev *cxlmd,
+			      struct device *uport_dev,
+			      struct device *dport_dev)
+{
+	struct device *dparent = grandparent(dport_dev);
+	struct cxl_port *port, *parent_port = NULL;
+	resource_size_t component_reg_phys;
+	int rc;
+
+	if (!dparent) {
+		/*
+		 * The iteration reached the topology root without finding the
+		 * CXL-root 'cxl_port' on a previous iteration, fail for now to
+		 * be re-probed after platform driver attaches.
+		 */
+		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
+			dev_name(dport_dev));
+		return -ENXIO;
+	}
+
+	parent_port = find_cxl_port(dparent);
+	if (!parent_port) {
+		/* iterate to create this parent_port */
+		return -EAGAIN;
+	}
+
+	cxl_device_lock(&parent_port->dev);
+	if (!parent_port->dev.driver) {
+		dev_warn(&cxlmd->dev,
+			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
+			 dev_name(&parent_port->dev), dev_name(uport_dev));
+		port = ERR_PTR(-ENXIO);
+		goto out;
+	}
+
+	port = find_cxl_port_at(parent_port, dport_dev);
+	if (!port) {
+		component_reg_phys = find_component_registers(uport_dev);
+		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
+					 component_reg_phys, parent_port);
+		if (!IS_ERR(port))
+			get_device(&port->dev);
+	}
+out:
+	cxl_device_unlock(&parent_port->dev);
+
+	if (IS_ERR(port))
+		rc = PTR_ERR(port);
+	else {
+		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
+			dev_name(&port->dev), dev_name(port->uport));
+		rc = cxl_add_ep(port, &cxlmd->dev);
+		if (rc == -EEXIST) {
+			/*
+			 * "can't" happen, but this error code means
+			 * something to the caller, so translate it.
+			 */
+			rc = -ENXIO;
+		}
+		put_device(&port->dev);
+	}
+
+	put_device(&parent_port->dev);
+	return rc;
+}
+
+int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
+{
+	struct device *dev = &cxlmd->dev;
+	struct device *iter;
+	int rc;
+
+	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
+	if (rc)
+		return rc;
+
+	/*
+	 * Scan for and add all cxl_ports in this device's ancestry.
+	 * Repeat until no more ports are added. Abort if a port add
+	 * attempt fails.
+	 */
+retry:
+	for (iter = dev; iter; iter = grandparent(iter)) {
+		struct device *dport_dev = grandparent(iter);
+		struct device *uport_dev;
+		struct cxl_port *port;
+
+		if (!dport_dev)
+			return 0;
+
+		uport_dev = dport_dev->parent;
+		if (!uport_dev) {
+			dev_warn(dev, "at %s no parent for dport: %s\n",
+				 dev_name(iter), dev_name(dport_dev));
+			return -ENXIO;
+		}
+
+		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
+			dev_name(iter), dev_name(dport_dev),
+			dev_name(uport_dev));
+		port = find_cxl_port(dport_dev);
+		if (port) {
+			dev_dbg(&cxlmd->dev,
+				"found already registered port %s:%s\n",
+				dev_name(&port->dev), dev_name(port->uport));
+			rc = cxl_add_ep(port, &cxlmd->dev);
+
+			/*
+			 * If the endpoint already exists in the port's list,
+			 * that's ok, it was added on a previous pass.
+			 * Otherwise, retry in add_port_attach_ep() after taking
+			 * the parent_port lock as the current port may be being
+			 * reaped.
+			 */
+			if (rc && rc != -EEXIST) {
+				put_device(&port->dev);
+				return rc;
+			}
+
+			/* Any more ports to add between this one and the root? */
+			if (!dev_is_cxl_root_child(&port->dev)) {
+				put_device(&port->dev);
+				continue;
+			}
+
+			put_device(&port->dev);
+			return 0;
+		}
+
+		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
+		/* port missing, try to add parent */
+		if (rc == -EAGAIN)
+			continue;
+		/* failed to add ep or port */
+		if (rc)
+			return rc;
+		/* port added, new descendants possible, start over */
+		goto retry;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
+
+struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
+{
+	return find_cxl_port(grandparent(&cxlmd->dev));
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
+
+struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
+					const struct device *dev)
+{
+	struct cxl_dport *dport;
+
+	cxl_device_lock(&port->dev);
+	list_for_each_entry(dport, &port->dports, list)
+		if (dport->dport == dev) {
+			cxl_device_unlock(&port->dev);
+			return dport;
+		}
+
+	cxl_device_unlock(&port->dev);
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
+
 static int decoder_populate_targets(struct cxl_decoder *cxld,
 				    struct cxl_port *port, int *target_map)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 89fbf49ebf98..1501d9388e83 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -262,8 +262,10 @@ struct cxl_nvdimm {
  * @uport: PCI or platform device implementing the upstream port capability
  * @id: id for port device-name
  * @dports: cxl_dport instances referenced by decoders
+ * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
  * @decoder_ida: allocator for decoder ids
  * @component_reg_phys: component register capability base address (optional)
+ * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  */
 struct cxl_port {
@@ -271,8 +273,10 @@ struct cxl_port {
 	struct device *uport;
 	int id;
 	struct list_head dports;
+	struct list_head endpoints;
 	struct ida decoder_ida;
 	resource_size_t component_reg_phys;
+	bool dead;
 	unsigned int depth;
 };
 
@@ -292,6 +296,16 @@ struct cxl_dport {
 	struct list_head list;
 };
 
+/**
+ * struct cxl_ep - track an endpoint's interest in a port
+ * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
+ * @list: node on port->endpoints list
+ */
+struct cxl_ep {
+	struct device *ep;
+	struct list_head list;
+};
+
 /*
  * The platform firmware device hosting the root is also the top of the
  * CXL port topology. All other CXL ports have another CXL port as their
@@ -313,9 +327,15 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
 struct cxl_port *find_cxl_root(struct device *dev);
+int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
+int cxl_bus_rescan(void);
+
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     struct device *dport, int port_id,
 				     resource_size_t component_reg_phys);
+struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
+					const struct device *dev);
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_cxl_decoder(struct device *dev);

