Return-Path: <linux-pci+bounces-44928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FF4D23BBC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 805A230E9B34
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB235FF41;
	Thu, 15 Jan 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8XBnMfv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF735F8D6;
	Thu, 15 Jan 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470692; cv=none; b=WD6qaRYSO72QtKPwImaXh40gyKUFmxa2IMx6Oh+088slKbfZfn6ubk7oFp+ST9XaScSlTuLVBWsB7GFqIiPC2nVq71NyweHC4xp9JwqAow3Lp+DujbumgF85Qw5f/QJUkiszMJKJ+DX0ZMUjg+vwJnuHPSb0QjFjZLjILAn2bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470692; c=relaxed/simple;
	bh=w/EtsqaZJ4DVWRdqOwQiLr5EDjpnoPNOQ5mW3z9Rnpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JqtxrHhRLva7ACPbiJcvAirWD3hS/aMvZd+29BudPgCOTt9KyL7oE7jazlZkCQBMqu5B9zxVyBQ6xfaW6C6Ups6ARc1Z4l5ro/8DVelUczFChnxLmCo3qqnBltH7/u9N8g6Ej6G+VTa289rZQqrbdyRuDRtcDCLTCS70+aJW5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8XBnMfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D0BC19423;
	Thu, 15 Jan 2026 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470691;
	bh=w/EtsqaZJ4DVWRdqOwQiLr5EDjpnoPNOQ5mW3z9Rnpk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H8XBnMfv4iG1vmKk7gVrjnSpgDiIwzX80k+Yrn+I7G6Hgc0ZgrMwtrP3p2cdANRZ6
	 z9xVn/u1Z+LgZbgS+zUW3dkLcGnuFsogdttZmrYkdwEKCYF8XRAS4vXutYbYZJvG3H
	 BDGVwkrP6GU5TZirixjWRgU8nKVVT6NZZhJ0R5iMXOwhMO23TAIBfiw6CxmW+JWRux
	 RRb+PI5HFwEB679/MaNLeQx/7w0wfCSPF+WTt8IcWdagTcs5ckbW0rwMttINdIICLq
	 oqX9qgIQgxyaYUkMI0b3CfuLFpo3hoKmg5Uqn4FhEwuHH2L/fpPB0euJg4xMZbA2Hj
	 aCj2Jca4FIl9Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 15 Jan 2026 10:50:52 +0100
Subject: [PATCH v3 6/6] irqchip/gic-v5: Add ACPI IWB probing
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-gicv5-host-acpi-v3-6-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
In-Reply-To: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.14.3

To probe an IWB in an ACPI based system it is required:

- to implement the IORT functions handling the IWB IORT node and create
  functions to retrieve IWB firmware information
- to augment the driver to match the DSDT ACPI "ARMH0003" device and
  retrieve the IWB wire and trigger mask from the GSI interrupt descriptor
  in the IWB msi_domain_ops.msi_translate() function

Make the required driver changes to enable IWB probing in ACPI systems.

The GICv5 GSI format requires special handling for IWB routed IRQs.

Add IWB GSI detection to the top level driver gic_v5_get_gsi_domain_id()
function so that the correct IRQ domain for a GSI can be detected by
parsing the GSI and check whether it is an IWB-backed IRQ or not.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/iort.c          | 95 ++++++++++++++++++++++++++++++++------
 drivers/irqchip/irq-gic-v5-iwb.c   | 42 +++++++++++++----
 drivers/irqchip/irq-gic-v5.c       |  4 ++
 include/linux/acpi_iort.h          |  1 +
 include/linux/irqchip/arm-gic-v5.h |  6 +++
 5 files changed, 123 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ddd857f05f46..ed827b2fc437 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -264,39 +264,47 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 	struct device *dev = context;
 	acpi_status status = AE_NOT_FOUND;
 
-	if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT) {
+	if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
+	    node->type == ACPI_IORT_NODE_IWB) {
 		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
-		struct acpi_device *adev;
 		struct acpi_iort_named_component *ncomp;
-		struct device *nc_dev = dev;
+		struct acpi_iort_iwb *iwb;
+		struct device *cdev = dev;
+		struct acpi_device *adev;
+		const char *device_name;
 
 		/*
 		 * Walk the device tree to find a device with an
 		 * ACPI companion; there is no point in scanning
-		 * IORT for a device matching a named component if
+		 * IORT for a device matching a named component or IWB if
 		 * the device does not have an ACPI companion to
 		 * start with.
 		 */
 		do {
-			adev = ACPI_COMPANION(nc_dev);
+			adev = ACPI_COMPANION(cdev);
 			if (adev)
 				break;
 
-			nc_dev = nc_dev->parent;
-		} while (nc_dev);
+			cdev = cdev->parent;
+		} while (cdev);
 
 		if (!adev)
 			goto out;
 
 		status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
 		if (ACPI_FAILURE(status)) {
-			dev_warn(nc_dev, "Can't get device full path name\n");
+			dev_warn(cdev, "Can't get device full path name\n");
 			goto out;
 		}
 
-		ncomp = (struct acpi_iort_named_component *)node->node_data;
-		status = !strcmp(ncomp->device_name, buf.pointer) ?
-							AE_OK : AE_NOT_FOUND;
+		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT) {
+			ncomp = (struct acpi_iort_named_component *)node->node_data;
+			device_name = ncomp->device_name;
+		} else {
+			iwb = (struct acpi_iort_iwb *)node->node_data;
+			device_name = iwb->device_name;
+		}
+		status = !strcmp(device_name, buf.pointer) ?  AE_OK : AE_NOT_FOUND;
 		acpi_os_free(buf.pointer);
 	} else if (node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 		struct acpi_iort_root_complex *pci_rc;
@@ -317,12 +325,28 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 	return status;
 }
 
+static acpi_status iort_match_iwb_callback(struct acpi_iort_node *node, void *context)
+{
+	struct acpi_iort_iwb *iwb;
+	u32 *id = context;
+
+	if (node->type != ACPI_IORT_NODE_IWB)
+		return AE_NOT_FOUND;
+
+	iwb = (struct acpi_iort_iwb *)node->node_data;
+	if (iwb->iwb_index != *id)
+		return AE_NOT_FOUND;
+
+	return AE_OK;
+}
+
 static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		       u32 *rid_out, bool check_overlap)
 {
 	/* Single mapping does not care for input id */
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
+		    type == ACPI_IORT_NODE_IWB		   ||
 		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 			*rid_out = map->output_base;
 			return 0;
@@ -392,6 +416,7 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
+		    node->type == ACPI_IORT_NODE_IWB ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
 		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
 		    node->type == ACPI_IORT_NODE_PMCG) {
@@ -562,9 +587,14 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 			return node;
 		/*
 		 * if not, then it should be a platform device defined in
-		 * DSDT/SSDT (with Named Component node in IORT)
+		 * DSDT/SSDT (with Named Component node in IORT) or an
+		 * IWB device in the DSDT/SSDT.
 		 */
-		return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+				      iort_match_node_callback, dev);
+		if (node)
+			return node;
+		return iort_scan_node(ACPI_IORT_NODE_IWB,
 				      iort_match_node_callback, dev);
 	}
 
@@ -759,6 +789,35 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 	return irq_find_matching_fwnode(handle, bus_token);
 }
 
+struct fwnode_handle *iort_iwb_handle(u32 iwb_id)
+{
+	struct fwnode_handle *fwnode;
+	struct acpi_iort_node *node;
+	struct acpi_device *device;
+	struct acpi_iort_iwb *iwb;
+	acpi_status status;
+	acpi_handle handle;
+
+	/* find its associated IWB node */
+	node = iort_scan_node(ACPI_IORT_NODE_IWB, iort_match_iwb_callback, &iwb_id);
+	if (!node)
+		return NULL;
+
+	iwb = (struct acpi_iort_iwb *)node->node_data;
+	status = acpi_get_handle(NULL, iwb->device_name, &handle);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	device = acpi_get_acpi_dev(handle);
+	if (!device)
+		return NULL;
+
+	fwnode = acpi_fwnode_handle(device);
+	acpi_put_acpi_dev(device);
+
+	return fwnode;
+}
+
 static void iort_set_device_domain(struct device *dev,
 				   struct acpi_iort_node *node)
 {
@@ -819,8 +878,14 @@ static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
 	/* find its associated iort node */
 	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
 			      iort_match_node_callback, dev);
-	if (!node)
-		return NULL;
+	if (!node) {
+		/* find its associated iort node */
+		node = iort_scan_node(ACPI_IORT_NODE_IWB,
+				      iort_match_node_callback, dev);
+
+		if (!node)
+			return NULL;
+	}
 
 	/* then find its msi parent node */
 	for (i = 0; i < node->mapping_count; i++) {
diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
index ad9fdc14d1c6..c7d5fd34d053 100644
--- a/drivers/irqchip/irq-gic-v5-iwb.c
+++ b/drivers/irqchip/irq-gic-v5-iwb.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt)	"GICv5 IWB: " fmt
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
@@ -136,18 +137,31 @@ static int gicv5_iwb_irq_domain_translate(struct irq_domain *d, struct irq_fwspe
 					  irq_hw_number_t *hwirq,
 					  unsigned int *type)
 {
-	if (!is_of_node(fwspec->fwnode))
-		return -EINVAL;
+	if (is_of_node(fwspec->fwnode)) {
 
-	if (fwspec->param_count < 2)
-		return -EINVAL;
+		if (fwspec->param_count < 2)
+			return -EINVAL;
 
-	/*
-	 * param[0] is be the wire
-	 * param[1] is the interrupt type
-	 */
-	*hwirq = fwspec->param[0];
-	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		/*
+		 * param[0] is be the wire
+		 * param[1] is the interrupt type
+		 */
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	}
+
+	if (is_acpi_device_node(fwspec->fwnode)) {
+
+		if (fwspec->param_count < 2)
+			return -EINVAL;
+
+		/*
+		 * Extract the wire from param[0]
+		 * param[1] is the interrupt type
+		 */
+		*hwirq = FIELD_GET(GICV5_GSI_IWB_WIRE, fwspec->param[0]);
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	}
 
 	return 0;
 }
@@ -265,10 +279,18 @@ static const struct of_device_id gicv5_iwb_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, gicv5_iwb_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id iwb_acpi_match[] = {
+	{ "ARMH0003", 0 },
+	{}
+};
+#endif
+
 static struct platform_driver gicv5_iwb_platform_driver = {
 	.driver = {
 		.name			= "GICv5 IWB",
 		.of_match_table		= gicv5_iwb_of_match,
+		.acpi_match_table	= ACPI_PTR(iwb_acpi_match),
 		.suppress_bind_attrs	= true,
 	},
 	.probe				= gicv5_iwb_device_probe,
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 23fd551c4347..da867dd2e77d 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)	"GICv5: " fmt
 
+#include <linux/acpi_iort.h>
 #include <linux/cpuhotplug.h>
 #include <linux/idr.h>
 #include <linux/irqdomain.h>
@@ -1187,6 +1188,9 @@ static struct fwnode_handle *gsi_domain_handle;
 
 static struct fwnode_handle *gic_v5_get_gsi_domain_id(u32 gsi)
 {
+	if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) == GICV5_GSI_IWB_TYPE)
+		return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
+
 	return gsi_domain_handle;
 }
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 2d22268677a9..17bb3374f4ca 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -27,6 +27,7 @@ int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
+struct fwnode_handle *iort_iwb_handle(u32 iwb_id);
 
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-gic-v5.h
index 334b6986435c..3da1ad80fc9d 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -265,6 +265,12 @@
 
 #define GICV5_IWB_WENABLE_STATUSR_IDLE		BIT(0)
 
+#define GICV5_GSI_IC_TYPE			GENMASK(31, 29)
+#define GICV5_GSI_IWB_TYPE			0x7
+
+#define GICV5_GSI_IWB_FRAME_ID			GENMASK(28, 16)
+#define GICV5_GSI_IWB_WIRE			GENMASK(15, 0)
+
 /*
  * Global Data structures and functions
  */

-- 
2.50.1


