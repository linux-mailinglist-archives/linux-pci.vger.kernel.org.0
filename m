Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42731DCD97
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgEUNA5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 09:00:57 -0400
Received: from foss.arm.com ([217.140.110.172]:46296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgEUNAu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 09:00:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A64D6E;
        Thu, 21 May 2020 06:00:49 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.29.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9313F305;
        Thu, 21 May 2020 06:00:47 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Diana Craciun <diana.craciun@oss.nxp.com>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
Date:   Thu, 21 May 2020 14:00:08 +0100
Message-Id: <20200521130008.8266-13-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table to
extract memory and other resources.

Interrupt (GIC ITS) information is extracted from the MADT table
by drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.

IORT table is parsed to configure DMA.

Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 +++++++++++++++-----
 drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++-----
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 75 ++++++++++++++++++++-
 3 files changed, 150 insertions(+), 35 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 824ff77bbe86..324d49d6df89 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -18,6 +18,8 @@
 #include <linux/bitops.h>
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
+#include <linux/acpi.h>
+#include <linux/iommu.h>
 
 #include "fsl-mc-private.h"
 
@@ -38,6 +40,7 @@ struct fsl_mc {
 	struct fsl_mc_device *root_mc_bus_dev;
 	u8 num_translation_ranges;
 	struct fsl_mc_addr_translation_range *translation_ranges;
+	void *fsl_mc_regs;
 };
 
 /**
@@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
 	phys_addr_t start_phys_addr;
 };
 
+#define FSL_MC_FAPR	0x28
+#define MC_FAPR_PL	BIT(18)
+#define MC_FAPR_BMT	BIT(17)
+
 /**
  * fsl_mc_bus_match - device to driver matching callback
  * @dev: the fsl-mc device to match against
@@ -124,7 +131,10 @@ static int fsl_mc_dma_configure(struct device *dev)
 	while (dev_is_fsl_mc(dma_dev))
 		dma_dev = dma_dev->parent;
 
-	return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
+	if (dev_of_node(dma_dev))
+		return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
+
+	return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
@@ -865,8 +875,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	struct fsl_mc_io *mc_io = NULL;
 	int container_id;
 	phys_addr_t mc_portal_phys_addr;
-	u32 mc_portal_size;
-	struct resource res;
+	u32 mc_portal_size, mc_stream_id;
+	struct resource *plat_res;
+
+	if (!iommu_present(&fsl_mc_bus_type))
+		return -EPROBE_DEFER;
 
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
@@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mc);
 
+	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
+	if (IS_ERR(mc->fsl_mc_regs))
+		return PTR_ERR(mc->fsl_mc_regs);
+
+	if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
+		mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
+		/*
+		 * HW ORs the PL and BMT bit, places the result in bit 15 of
+		 * the StreamID and ORs in the ICID. Calculate it accordingly.
+		 */
+		mc_stream_id = (mc_stream_id & 0xffff) |
+				((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
+					0x4000 : 0);
+		error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
+					      &mc_stream_id);
+		if (error)
+			dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
+				 error);
+	}
+
 	/*
 	 * Get physical address of MC portal for the root DPRC:
 	 */
-	error = of_address_to_resource(pdev->dev.of_node, 0, &res);
-	if (error < 0) {
-		dev_err(&pdev->dev,
-			"of_address_to_resource() failed for %pOF\n",
-			pdev->dev.of_node);
-		return error;
-	}
-
-	mc_portal_phys_addr = res.start;
-	mc_portal_size = resource_size(&res);
+	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mc_portal_phys_addr = plat_res->start;
+	mc_portal_size = resource_size(plat_res);
 	error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
 				 mc_portal_size, NULL,
 				 FSL_MC_IO_ATOMIC_CONTEXT_PORTAL, &mc_io);
@@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
 		 mc_version.major, mc_version.minor, mc_version.revision);
 
-	error = get_mc_addr_translation_ranges(&pdev->dev,
-					       &mc->translation_ranges,
-					       &mc->num_translation_ranges);
-	if (error < 0)
-		goto error_cleanup_mc_io;
+	if (dev_of_node(&pdev->dev)) {
+		error = get_mc_addr_translation_ranges(&pdev->dev,
+						&mc->translation_ranges,
+						&mc->num_translation_ranges);
+		if (error < 0)
+			goto error_cleanup_mc_io;
+	}
 
 	error = dprc_get_container_id(mc_io, 0, &container_id);
 	if (error < 0) {
@@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 		goto error_cleanup_mc_io;
 
 	mc->root_mc_bus_dev = mc_bus_dev;
+	mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
 	return 0;
 
 error_cleanup_mc_io:
@@ -967,11 +997,18 @@ static const struct of_device_id fsl_mc_bus_match_table[] = {
 
 MODULE_DEVICE_TABLE(of, fsl_mc_bus_match_table);
 
+static const struct acpi_device_id fsl_mc_bus_acpi_match_table[] = {
+	{"NXP0008", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, fsl_mc_bus_acpi_match_table);
+
 static struct platform_driver fsl_mc_bus_driver = {
 	.driver = {
 		   .name = "fsl_mc_bus",
 		   .pm = NULL,
 		   .of_match_table = fsl_mc_bus_match_table,
+		   .acpi_match_table = fsl_mc_bus_acpi_match_table,
 		   },
 	.probe = fsl_mc_bus_probe,
 	.remove = fsl_mc_bus_remove,
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index e7bbff445a83..8edadf05cbb7 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/acpi_iort.h>
 
 #include "fsl-mc-private.h"
 
@@ -179,25 +180,31 @@ struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
 
 struct irq_domain *fsl_mc_find_msi_domain(struct device *dev)
 {
-	struct irq_domain *msi_domain = NULL;
+	struct device *root_dprc_dev;
+	struct device *bus_dev;
+	struct irq_domain *msi_domain;
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	msi_domain = of_msi_map_get_device_domain(dev, mc_dev->icid,
+	fsl_mc_get_root_dprc(dev, &root_dprc_dev);
+	bus_dev = root_dprc_dev->parent;
+
+	if (bus_dev->of_node) {
+		msi_domain = of_msi_map_get_device_domain(dev,
+						  mc_dev->icid,
 						  DOMAIN_BUS_FSL_MC_MSI);
 
-	/*
-	 * if the msi-map property is missing assume that all the
-	 * child containers inherit the domain from the parent
-	 */
-	if (!msi_domain) {
-		struct device *root_dprc_dev;
-		struct device *bus_dev;
-
-		fsl_mc_get_root_dprc(dev, &root_dprc_dev);
-		bus_dev = root_dprc_dev->parent;
-		msi_domain = of_msi_get_domain(bus_dev,
-					       bus_dev->of_node,
-					       DOMAIN_BUS_FSL_MC_MSI);
+		/*
+		 * if the msi-map property is missing assume that all the
+		 * child containers inherit the domain from the parent
+		 */
+		if (!msi_domain)
+
+			msi_domain = of_msi_get_domain(bus_dev,
+						bus_dev->of_node,
+						DOMAIN_BUS_FSL_MC_MSI);
+	} else {
+		msi_domain = iort_get_device_domain(dev, mc_dev->icid,
+						    DOMAIN_BUS_FSL_MC_MSI);
 	}
 
 	return msi_domain;
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index a5c8d577e424..b8b948fb6b2d 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -7,6 +7,8 @@
  *
  */
 
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/irq.h>
@@ -30,7 +32,8 @@ static u32 fsl_mc_msi_domain_get_msi_id(struct irq_domain *domain,
 	u32 out_id;
 
 	of_node = irq_domain_get_of_node(domain);
-	out_id = of_msi_map_id(&mc_dev->dev, of_node, mc_dev->icid);
+	out_id = of_node ? of_msi_map_id(&mc_dev->dev, of_node, mc_dev->icid) :
+			iort_msi_map_id(&mc_dev->dev, mc_dev->icid);
 
 	return out_id;
 }
@@ -79,7 +82,67 @@ static const struct of_device_id its_device_id[] = {
 	{},
 };
 
-static int __init its_fsl_mc_msi_init(void)
+static int __init its_fsl_mc_msi_init_one(struct fwnode_handle *handle,
+					  const char *name)
+{
+	struct irq_domain *parent;
+	struct irq_domain *mc_msi_domain;
+
+	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		pr_err("%s: Unable to locate ITS domain\n", name);
+		return -ENXIO;
+	}
+
+	mc_msi_domain = fsl_mc_msi_create_irq_domain(handle,
+						&its_fsl_mc_msi_domain_info,
+						parent);
+	if (!mc_msi_domain)
+		pr_err("ACPIF: unable to create fsl-mc domain\n");
+
+	pr_info("fsl-mc MSI: domain created\n");
+
+	return 0;
+}
+
+static int __init
+its_fsl_mc_msi_parse_madt(union acpi_subtable_headers *header,
+			  const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	const char *node_name;
+	int err = -ENXIO;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
+			      (long)its_entry->base_address);
+
+	dom_handle = iort_find_domain_token(its_entry->translation_id);
+	if (!dom_handle) {
+		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
+		goto out;
+	}
+
+	err = its_fsl_mc_msi_init_one(dom_handle, node_name);
+	if (!err)
+		pr_info("fsl-mc MSI: %s domain created\n", node_name);
+
+out:
+	kfree(node_name);
+	return err;
+}
+
+
+static int __init its_fsl_mc_acpi_msi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      its_fsl_mc_msi_parse_madt, 0);
+
+	return 0;
+}
+
+static int __init its_fsl_mc_of_msi_init(void)
 {
 	struct device_node *np;
 	struct irq_domain *parent;
@@ -113,4 +176,12 @@ static int __init its_fsl_mc_msi_init(void)
 	return 0;
 }
 
+static int __init its_fsl_mc_msi_init(void)
+{
+	its_fsl_mc_of_msi_init();
+	its_fsl_mc_acpi_msi_init();
+
+	return 0;
+}
+
 early_initcall(its_fsl_mc_msi_init);
-- 
2.26.1

