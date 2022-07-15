Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2345057584E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiGOACQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbiGOACO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:02:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158F27CFF;
        Thu, 14 Jul 2022 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843333; x=1689379333;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hvrXDq/xttwXGrZboalvi3MvsAoY14tzi6rYe/HKduc=;
  b=Zj6FDfqFVYuKTtOXcWsBGoEjQ+tW94+kvb0iPd+ynCqp9NNGxuffDPR+
   bx6sWnbEYpuR8eL4qu/gcGYKHF/WAfscZz2a8inOaAQBQ0eH/Eh/iPJo+
   k0t9y5ZDMdPafEB64ANEyBYvNd1zxUheEFQv+e8E3bgmJbEgTSl2EEZ1K
   o4LKqvtmafNKdoWtgEwm5BTlYBMzCY0dQw1v7jrkuEiUEXbRWygdP+Hq0
   +2vhfRTtBQX+5zPmi5dd9iEr2GRy/TZMT111T+zBWA6pQH6VFnDqbAJYq
   Vjx5HpS5P6fH276Yb1V8A3zKkU7aVXI4b9bvD+/OdACrRCQ5LxEuiV8Aw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="311320496"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="311320496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="685766491"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:45 -0700
Subject: [PATCH v2 11/28] cxl/port: Record parent dport when adding ports
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:01:45 -0700
Message-ID: <165784330511.1758207.16540797912136148491.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the time that cxl_port instances are being created, cache the dport
from the parent port that points to this new child port. This will be
useful for region provisioning when walking the tree to calculate
decoder targets, and saves rewalking the dport list after the fact to
build this information.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20220624041950.559155-1-dan.j.williams@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |    3 +--
 drivers/cxl/core/port.c |   27 +++++++++++++++------------
 drivers/cxl/cxl.h       |    7 +++++--
 drivers/cxl/mem.c       |   10 ++++++----
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8f021241699f..64004eb672d0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -211,8 +211,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (rc)
 		return rc;
 
-	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
-				 root_port);
+	port = devm_cxl_add_port(host, match, dport->component_reg_phys, dport);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a8d350361548..6d2846404ab8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -526,7 +526,7 @@ static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport,
 				       resource_size_t component_reg_phys,
-				       struct cxl_port *parent_port)
+				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
 	struct device *dev;
@@ -549,11 +549,13 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	 * description.
 	 */
 	dev = &port->dev;
-	if (parent_port) {
+	if (parent_dport) {
+		struct cxl_port *parent_port = parent_dport->port;
 		struct cxl_port *iter;
 
 		dev->parent = &parent_port->dev;
 		port->depth = parent_port->depth + 1;
+		port->parent_dport = parent_dport;
 
 		/*
 		 * walk to the host bridge, or the first ancestor that knows
@@ -595,24 +597,24 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
  * @host: host device for devm operations
  * @uport: "physical" device implementing this upstream port
  * @component_reg_phys: (optional) for configurable cxl_port instances
- * @parent_port: next hop up in the CXL memory decode hierarchy
+ * @parent_dport: next hop up in the CXL memory decode hierarchy
  */
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
-				   struct cxl_port *parent_port)
+				   struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport, component_reg_phys, parent_port);
+	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
 	dev = &port->dev;
 	if (is_cxl_memdev(uport))
 		rc = dev_set_name(dev, "endpoint%d", port->id);
-	else if (parent_port)
+	else if (parent_dport)
 		rc = dev_set_name(dev, "port%d", port->id);
 	else
 		rc = dev_set_name(dev, "root%d", port->id);
@@ -1014,7 +1016,7 @@ static void delete_endpoint(void *data)
 	struct cxl_port *parent_port;
 	struct device *parent;
 
-	parent_port = cxl_mem_find_port(cxlmd);
+	parent_port = cxl_mem_find_port(cxlmd, NULL);
 	if (!parent_port)
 		goto out;
 	parent = &parent_port->dev;
@@ -1149,8 +1151,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 {
 	struct device *dparent = grandparent(dport_dev);
 	struct cxl_port *port, *parent_port = NULL;
+	struct cxl_dport *dport, *parent_dport;
 	resource_size_t component_reg_phys;
-	struct cxl_dport *dport;
 	int rc;
 
 	if (!dparent) {
@@ -1164,7 +1166,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	parent_port = find_cxl_port(dparent, NULL);
+	parent_port = find_cxl_port(dparent, &parent_dport);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
@@ -1183,7 +1185,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	if (!port) {
 		component_reg_phys = find_component_registers(uport_dev);
 		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
-					 component_reg_phys, parent_port);
+					 component_reg_phys, parent_dport);
 		/* retry find to pick up the new dport information */
 		if (!IS_ERR(port))
 			port = find_cxl_port_at(parent_port, dport_dev, &dport);
@@ -1290,9 +1292,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
 
-struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
+struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
+				   struct cxl_dport **dport)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev), NULL);
+	return find_cxl_port(grandparent(&cxlmd->dev), dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 31f33844279a..973e0efe4bd4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -332,6 +332,7 @@ struct cxl_nvdimm {
  * @id: id for port device-name
  * @dports: cxl_dport instances referenced by decoders
  * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
+ * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @component_reg_phys: component register capability base address (optional)
@@ -345,6 +346,7 @@ struct cxl_port {
 	int id;
 	struct list_head dports;
 	struct list_head endpoints;
+	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	int hdm_end;
 	resource_size_t component_reg_phys;
@@ -399,11 +401,12 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
 struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
-				   struct cxl_port *parent_port);
+				   struct cxl_dport *parent_dport);
 struct cxl_port *find_cxl_root(struct device *dev);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 int cxl_bus_rescan(void);
-struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd);
+struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
+				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7513bea55145..2786d3402c9e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -26,14 +26,15 @@
  */
 
 static int create_endpoint(struct cxl_memdev *cxlmd,
-			   struct cxl_port *parent_port)
+			   struct cxl_dport *parent_dport)
 {
+	struct cxl_port *parent_port = parent_dport->port;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint;
 	int rc;
 
 	endpoint = devm_cxl_add_port(&parent_port->dev, &cxlmd->dev,
-				     cxlds->component_reg_phys, parent_port);
+				     cxlds->component_reg_phys, parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
@@ -76,6 +77,7 @@ static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_port *parent_port;
+	struct cxl_dport *dport;
 	struct dentry *dentry;
 	int rc;
 
@@ -100,7 +102,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	parent_port = cxl_mem_find_port(cxlmd);
+	parent_port = cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
 		return -ENXIO;
@@ -114,7 +116,7 @@ static int cxl_mem_probe(struct device *dev)
 		goto unlock;
 	}
 
-	rc = create_endpoint(cxlmd, parent_port);
+	rc = create_endpoint(cxlmd, dport);
 unlock:
 	device_unlock(&parent_port->dev);
 	put_device(&parent_port->dev);

