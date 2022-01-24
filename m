Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B549769E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiAXAaw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:30:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:36003 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235253AbiAXAaw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984252; x=1674520252;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fh0O1oVu8QGXDt/khbYAAXgl9zEzqHYgvP3dMmmMNpI=;
  b=MWtPB0UATmrswmERoa2Ppy/geNOGVT71tPVSSFCeVorBejQ94gei7Ffm
   H1BS/Yc/ACQ6kFpK+PA5mzDTVAgf9sqkJ36TDp58mZgZGycDFCdklxDWp
   oxUmJJIqvy8BXq+f7mL7fbq1lHdYNsdl0JVA+iYm6CLDpwpadLxR+fs7D
   qadXiscYIqR1cDbZkwXdmnG7FS5YIDnl2S10K5tBtjMf8GwU7d6/WqROf
   58646NiG0UreU/HNC5KA/OMqnIfiPzLIzBQASJmW7e3XkefHPTNklpJIn
   MG4SFQvXj4ln90Um3CIrjFnZY5luxjQGgOAroiVLs+txvd7UF8bP/jnZj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233292454"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233292454"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="519731164"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:52 -0800
Subject: [PATCH v3 25/40] cxl/core/port: Remove @host argument for dport +
 decoder enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:30:52 -0800
Message-ID: <164298425201.3018233.647136583483232467.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that dport and decoder enumeration is centralized in the port
driver, the @host argument for these helpers can be made implicit. For
the root port the host is the port's uport device (ACPI0017 for
cxl_acpi), and for all other descendant ports the devm context is the
parent of @port.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c            |    2 +-
 drivers/cxl/core/hdm.c        |   10 +++++-----
 drivers/cxl/core/pci.c        |    8 ++------
 drivers/cxl/core/port.c       |    9 +++++++--
 drivers/cxl/cxl.h             |    8 ++++----
 drivers/cxl/cxlpci.h          |    2 +-
 drivers/cxl/port.c            |    8 ++++----
 tools/testing/cxl/test/cxl.c  |   14 +++++---------
 tools/testing/cxl/test/mock.c |   28 ++++++++++++----------------
 tools/testing/cxl/test/mock.h |    9 ++++-----
 10 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 82591642ea90..683f2ca32c97 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -256,7 +256,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		return 0;
 	}
 
-	dport = devm_cxl_add_dport(host, root_port, match, uid, ctx.chbcr);
+	dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
 	if (IS_ERR(dport)) {
 		dev_err(host, "failed to add downstream port: %s\n",
 			dev_name(match));
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 802048dc2046..701b510c76d2 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -44,7 +44,7 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
  * are claimed and passed to the single dport. Disable the range until the first
  * CXL region is enumerated / activated.
  */
-int devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
+int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	struct cxl_decoder *cxld;
 	struct cxl_dport *dport;
@@ -96,18 +96,18 @@ static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
  */
-struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port)
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 {
 	void __iomem *crb, __iomem *hdm;
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
 
-	cxlhdm = devm_kzalloc(host, sizeof(*cxlhdm), GFP_KERNEL);
+	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
 	if (!cxlhdm)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
-	crb = devm_cxl_iomap_block(host, port->component_reg_phys,
+	crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
 				   CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb) {
 		dev_err(dev, "No component registers mapped\n");
@@ -197,7 +197,7 @@ static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
  * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
  * @port: cxl_port HDM capability to scan
  */
-int devm_cxl_enumerate_decoders(struct device *host, struct cxl_hdm *cxlhdm)
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a04220ebc03f..420296abc57a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -15,7 +15,6 @@
 
 struct cxl_walk_context {
 	struct pci_bus *bus;
-	struct device *host;
 	struct cxl_port *port;
 	int type;
 	int error;
@@ -26,7 +25,6 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 {
 	struct cxl_walk_context *ctx = data;
 	struct cxl_port *port = ctx->port;
-	struct device *host = ctx->host;
 	struct pci_bus *bus = ctx->bus;
 	int type = pci_pcie_type(pdev);
 	struct cxl_register_map map;
@@ -50,7 +48,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(host, port, &pdev->dev, port_num,
+	dport = devm_cxl_add_dport(port, &pdev->dev, port_num,
 				   cxl_regmap_to_base(pdev, &map));
 	if (IS_ERR(dport)) {
 		ctx->error = PTR_ERR(dport);
@@ -65,13 +63,12 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 
 /**
  * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
- * @host: devm context
  * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
  *
  * Returns a positive number of dports enumerated or a negative error
  * code.
  */
-int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port)
+int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 {
 	struct pci_bus *bus = cxl_port_to_pci_bus(port);
 	struct cxl_walk_context ctx;
@@ -86,7 +83,6 @@ int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port)
 		type = PCI_EXP_TYPE_DOWNSTREAM;
 
 	ctx = (struct cxl_walk_context) {
-		.host = host,
 		.port = port,
 		.bus = bus,
 		.type = type,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index efe66a8633a8..26c3eb9180cd 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -573,7 +573,6 @@ static void cxl_dport_unlink(void *data)
 
 /**
  * devm_cxl_add_dport - append downstream port data to a cxl_port
- * @host: devm context for allocations
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
  * @port_id: identifier for this dport in a decoder's target list
@@ -583,14 +582,20 @@ static void cxl_dport_unlink(void *data)
  * either the port's host (for root ports), or the port itself (for
  * switch ports)
  */
-struct cxl_dport *devm_cxl_add_dport(struct device *host, struct cxl_port *port,
+struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     struct device *dport_dev, int port_id,
 				     resource_size_t component_reg_phys)
 {
 	char link_name[CXL_TARGET_STRLEN];
 	struct cxl_dport *dport;
+	struct device *host;
 	int rc;
 
+	if (is_cxl_root(port))
+		host = port->uport;
+	else
+		host = &port->dev;
+
 	if (!host->driver) {
 		dev_WARN_ONCE(&port->dev, 1, "dport:%s bad devm context\n",
 			      dev_name(dport_dev));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cee71c6e2fed..7c714e559e95 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -307,7 +307,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
 struct cxl_port *find_cxl_root(struct device *dev);
-struct cxl_dport *devm_cxl_add_dport(struct device *host, struct cxl_port *port,
+struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     struct device *dport, int port_id,
 				     resource_size_t component_reg_phys);
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
@@ -321,9 +321,9 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 struct cxl_hdm;
-struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port);
-int devm_cxl_enumerate_decoders(struct device *host, struct cxl_hdm *cxlhdm);
-int devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port);
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
+int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
 
 extern struct bus_type cxl_bus_type;
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 47640f19e899..766de340c4ce 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -58,5 +58,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 	return pci_resource_start(pdev, map->barno) + map->block_offset;
 }
 
-int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port);
+int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 7b42f27c0c96..ae94a537eccc 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -31,18 +31,18 @@ static int cxl_port_probe(struct device *dev)
 	struct cxl_hdm *cxlhdm;
 	int rc;
 
-	rc = devm_cxl_port_enumerate_dports(dev, port);
+	rc = devm_cxl_port_enumerate_dports(port);
 	if (rc < 0)
 		return rc;
 
 	if (rc == 1)
-		return devm_cxl_add_passthrough_decoder(dev, port);
+		return devm_cxl_add_passthrough_decoder(port);
 
-	cxlhdm = devm_cxl_setup_hdm(dev, port);
+	cxlhdm = devm_cxl_setup_hdm(port);
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	rc = devm_cxl_enumerate_decoders(dev, cxlhdm);
+	rc = devm_cxl_enumerate_decoders(cxlhdm);
 	if (rc) {
 		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
 		return rc;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index ce6ace286fc7..40ed567952e6 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -399,8 +399,7 @@ static struct acpi_pci_root *mock_acpi_pci_find_root(acpi_handle handle)
 	return &mock_pci_root[host_bridge_index(adev)];
 }
 
-static struct cxl_hdm *mock_cxl_setup_hdm(struct device *host,
-					  struct cxl_port *port)
+static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
 
@@ -411,21 +410,18 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct device *host,
 	return cxlhdm;
 }
 
-static int mock_cxl_add_passthrough_decoder(struct device *host,
-					    struct cxl_port *port)
+static int mock_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	dev_err(&port->dev, "unexpected passthrough decoder for cxl_test\n");
 	return -EOPNOTSUPP;
 }
 
-static int mock_cxl_enumerate_decoders(struct device *host,
-				       struct cxl_hdm *cxlhdm)
+static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 {
 	return 0;
 }
 
-static int mock_cxl_port_enumerate_dports(struct device *host,
-					  struct cxl_port *port)
+static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 {
 	struct device *dev = &port->dev;
 	int i;
@@ -437,7 +433,7 @@ static int mock_cxl_port_enumerate_dports(struct device *host,
 		if (pdev->dev.parent != port->uport)
 			continue;
 
-		dport = devm_cxl_add_dport(host, port, &pdev->dev, pdev->id,
+		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
 					   CXL_RESOURCE_NONE);
 
 		if (IS_ERR(dport)) {
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 18d3b65e2a9b..6e8c9d63c92d 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -131,66 +131,62 @@ __wrap_nvdimm_bus_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
-struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct device *host,
-					  struct cxl_port *port)
+struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port)
 {
 	int index;
 	struct cxl_hdm *cxlhdm;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(port->uport))
-		cxlhdm = ops->devm_cxl_setup_hdm(host, port);
+		cxlhdm = ops->devm_cxl_setup_hdm(port);
 	else
-		cxlhdm = devm_cxl_setup_hdm(host, port);
+		cxlhdm = devm_cxl_setup_hdm(port);
 	put_cxl_mock_ops(index);
 
 	return cxlhdm;
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
 
-int __wrap_devm_cxl_add_passthrough_decoder(struct device *host,
-					    struct cxl_port *port)
+int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	int rc, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(port->uport))
-		rc = ops->devm_cxl_add_passthrough_decoder(host, port);
+		rc = ops->devm_cxl_add_passthrough_decoder(port);
 	else
-		rc = devm_cxl_add_passthrough_decoder(host, port);
+		rc = devm_cxl_add_passthrough_decoder(port);
 	put_cxl_mock_ops(index);
 
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_passthrough_decoder, CXL);
 
-int __wrap_devm_cxl_enumerate_decoders(struct device *host,
-				       struct cxl_hdm *cxlhdm)
+int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 {
 	int rc, index;
 	struct cxl_port *port = cxlhdm->port;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(port->uport))
-		rc = ops->devm_cxl_enumerate_decoders(host, cxlhdm);
+		rc = ops->devm_cxl_enumerate_decoders(cxlhdm);
 	else
-		rc = devm_cxl_enumerate_decoders(host, cxlhdm);
+		rc = devm_cxl_enumerate_decoders(cxlhdm);
 	put_cxl_mock_ops(index);
 
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enumerate_decoders, CXL);
 
-int __wrap_devm_cxl_port_enumerate_dports(struct device *host,
-					  struct cxl_port *port)
+int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
 {
 	int rc, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(port->uport))
-		rc = ops->devm_cxl_port_enumerate_dports(host, port);
+		rc = ops->devm_cxl_port_enumerate_dports(port);
 	else
-		rc = devm_cxl_port_enumerate_dports(host, port);
+		rc = devm_cxl_port_enumerate_dports(port);
 	put_cxl_mock_ops(index);
 
 	return rc;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 15e48063ea4b..738f24e3988a 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -19,11 +19,10 @@ struct cxl_mock_ops {
 	bool (*is_mock_bus)(struct pci_bus *bus);
 	bool (*is_mock_port)(struct device *dev);
 	bool (*is_mock_dev)(struct device *dev);
-	int (*devm_cxl_port_enumerate_dports)(struct device *host,
-					      struct cxl_port *port);
-	struct cxl_hdm *(*devm_cxl_setup_hdm)(struct device *host, struct cxl_port *port);
-	int (*devm_cxl_add_passthrough_decoder)(struct device *host, struct cxl_port *port);
-	int (*devm_cxl_enumerate_decoders)(struct device *host, struct cxl_hdm *hdm);
+	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
+	struct cxl_hdm *(*devm_cxl_setup_hdm)(struct cxl_port *port);
+	int (*devm_cxl_add_passthrough_decoder)(struct cxl_port *port);
+	int (*devm_cxl_enumerate_decoders)(struct cxl_hdm *hdm);
 };
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops);

