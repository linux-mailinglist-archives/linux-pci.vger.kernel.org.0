Return-Path: <linux-pci+bounces-44929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B5D23BBF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B612630EB0B4
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748F35FF55;
	Thu, 15 Jan 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imhjIHig"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8735F8DA;
	Thu, 15 Jan 2026 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470692; cv=none; b=WPdD8whkYBtDOUBAMyChyhGf+pLSTc6otwWPpp8Ix++UDh9YzsyUF6mZSk3GHuhv1S1rSSQ5L6UJKDun/MLZ04eUyAMVzjVtr+LwNzAr8Pc/1o0SeSiR94gHEygnR63UEXpzaKQiE/h9EpzCmBj/CzKna6cwhbKmDX5A6tYlyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470692; c=relaxed/simple;
	bh=SivqKgXw7pxzLdkxoHg1alNOYwKdrnDTSYrk0OF0ZaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ch+R5FgBKqEiHq3L4SVYVHSL6Xc2DKBU1HvbrGYGP6Xq97T61q0PtNRdEMlsyGRXT5tiHaVjqxuHPkxx4n21zhYvrUjTnOU4nOlUTG6zRZYd8B/jNfPNpaUCs3Z8SldHgZ1ZDBpela1k+X7JUlA7mt9/yCJSzfS3X1yLYiMyP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imhjIHig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C167BC116D0;
	Thu, 15 Jan 2026 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470688;
	bh=SivqKgXw7pxzLdkxoHg1alNOYwKdrnDTSYrk0OF0ZaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=imhjIHig+KihtVH76ExVagwxmSs1aA5Z6eunysMTGy66Ew/SrCJ8cs+P/PdnusvZn
	 KEGq2GLR3MpDrCzoVOi7jBVkhWhh/3dcB40kf4JTlmFPtzUzyqOduTaNcZKqcuXGrb
	 LDVEaCQ6wKsz8uIKEg078WfZTtYeUvTAv5HOKzuP4ssF8MIJKZHB+dk8h40UpCKPTa
	 7XkKK5zANQMIkVtg+JYkYpQ/x8PCB2bx8t/GwdH2p0S4uZhov9co1vr6VGOphTq6xH
	 Q+xX00iBAM4kocFQWeYZNW8R7kggEnn+mIwdM7r3KNFBffWeaY9MJV1rkas1HGve7B
	 Y0z4/84irD2HQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 15 Jan 2026 10:50:51 +0100
Subject: [PATCH v3 5/6] irqchip/gic-v5: Add ACPI ITS probing
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-gicv5-host-acpi-v3-5-c13a9a150388@kernel.org>
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

On ACPI ARM64 systems the GICv5 ITS configuration and translate frames
are described in the MADT table.

Refactor the current GICv5 ITS driver code to share common functions
between ACPI and OF and implement ACPI probing in the GICv5 ITS driver.

Add iort_msi_xlate() to map a device ID and retrieve an MSI controller
fwnode node for ACPI systems and update pci_msi_map_rid_ctlr_node() to
use it in its ACPI code path.

Add the required functions to IORT code for deviceID retrieval and IRQ
domain registration and look-up so that the GICv5 ITS driver in an
ACPI based system can be successfully probed.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/iort.c                |  98 ++++++++++++++++++-----
 drivers/irqchip/irq-gic-its-msi-parent.c |  39 ++++-----
 drivers/irqchip/irq-gic-v5-irs.c         |   7 +-
 drivers/irqchip/irq-gic-v5-its.c         | 132 ++++++++++++++++++++++++++++++-
 drivers/pci/msi/irqdomain.c              |   2 +
 include/linux/acpi_iort.h                |  10 ++-
 include/linux/irqchip/arm-gic-v5.h       |   1 +
 7 files changed, 244 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 65f0f56ad753..ddd857f05f46 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -595,45 +595,45 @@ u32 iort_msi_map_id(struct device *dev, u32 input_id)
 }
 
 /**
- * iort_pmsi_get_dev_id() - Get the device id for a device
+ * iort_msi_xlate() - Map a MSI input ID for a device
  * @dev: The device for which the mapping is to be done.
- * @dev_id: The device ID found.
+ * @input_id: The device input ID.
+ * @fwnode: Pointer to store the fwnode.
  *
- * Returns: 0 for successful find a dev id, -ENODEV on error
+ * Returns: mapped MSI ID on success, input ID otherwise
+ *	    On success, the fwnode pointer is initialized to the MSI
+ *	    controller fwnode handle.
  */
-int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+u32 iort_msi_xlate(struct device *dev, u32 input_id, struct fwnode_handle **fwnode)
 {
-	int i, index;
+	struct acpi_iort_its_group *its;
 	struct acpi_iort_node *node;
+	u32 dev_id;
 
 	node = iort_find_dev_node(dev);
 	if (!node)
-		return -ENODEV;
+		return input_id;
 
-	index = iort_get_id_mapping_index(node);
-	/* if there is a valid index, go get the dev_id directly */
-	if (index >= 0) {
-		if (iort_node_get_id(node, dev_id, index))
-			return 0;
-	} else {
-		for (i = 0; i < node->mapping_count; i++) {
-			if (iort_node_map_platform_id(node, dev_id,
-						      IORT_MSI_TYPE, i))
-				return 0;
-		}
-	}
+	node = iort_node_map_id(node, input_id, &dev_id, IORT_MSI_TYPE);
+	if (!node)
+		return input_id;
 
-	return -ENODEV;
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)node->node_data;
+
+	*fwnode = iort_find_domain_token(its->identifiers[0]);
+
+	return dev_id;
 }
 
-static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
+int iort_its_translate_pa(struct fwnode_handle *node, phys_addr_t *base)
 {
 	struct iort_its_msi_chip *its_msi_chip;
 	int ret = -ENODEV;
 
 	spin_lock(&iort_msi_chip_lock);
 	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
-		if (its_msi_chip->translation_id == its_id) {
+		if (its_msi_chip->fw_node == node) {
 			*base = its_msi_chip->base_addr;
 			ret = 0;
 			break;
@@ -644,6 +644,62 @@ static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
 	return ret;
 }
 
+static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
+{
+	struct fwnode_handle *fwnode = iort_find_domain_token(its_id);
+
+	if (!fwnode)
+		return -ENODEV;
+
+	return iort_its_translate_pa(fwnode, base);
+}
+
+/**
+ * iort_pmsi_get_msi_info() - Get the device id and translate frame PA for a device
+ * @dev: The device for which the mapping is to be done.
+ * @dev_id: The device ID found.
+ * @pa: optional pointer to store translate frame address.
+ *
+ * Returns: 0 for successful devid and pa retrieval, -ENODEV on error
+ */
+int iort_pmsi_get_msi_info(struct device *dev, u32 *dev_id, phys_addr_t *pa)
+{
+	struct acpi_iort_node *node, *parent = NULL;
+	struct acpi_iort_its_group *its;
+	int i, index;
+
+	node = iort_find_dev_node(dev);
+	if (!node)
+		return -ENODEV;
+
+	index = iort_get_id_mapping_index(node);
+	/* if there is a valid index, go get the dev_id directly */
+	if (index >= 0) {
+		parent = iort_node_get_id(node, dev_id, index);
+	} else {
+		for (i = 0; i < node->mapping_count; i++) {
+			parent = iort_node_map_platform_id(node, dev_id,
+						      IORT_MSI_TYPE, i);
+			if (parent)
+				break;
+		}
+	}
+
+	if (!parent)
+		return -ENODEV;
+
+	if (pa) {
+		int ret;
+
+		its = (struct acpi_iort_its_group *)node->node_data;
+		ret = iort_find_its_base(its->identifiers[0], pa);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index 4d1ad1ee005d..a832cdb2e697 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -19,18 +19,24 @@
 				 MSI_FLAG_PCI_MSIX      |	\
 				 MSI_FLAG_MULTI_PCI_MSI)
 
-static int its_translate_frame_address(struct device_node *msi_node, phys_addr_t *pa)
+static int its_translate_frame_address(struct fwnode_handle *msi_node, phys_addr_t *pa)
 {
 	struct resource res;
 	int ret;
 
-	ret = of_property_match_string(msi_node, "reg-names", "ns-translate");
-	if (ret < 0)
-		return ret;
+	if (is_of_node(msi_node)) {
+		struct device_node *msi_np = to_of_node(msi_node);
 
-	ret = of_address_to_resource(msi_node, ret, &res);
-	if (ret)
-		return ret;
+		ret = of_property_match_string(msi_np, "reg-names", "ns-translate");
+		if (ret < 0)
+			return ret;
+
+		ret = of_address_to_resource(msi_np, ret, &res);
+		if (ret)
+			return ret;
+	} else {
+		ret = iort_its_translate_pa(msi_node, &res.start);
+	}
 
 	*pa = res.start;
 	return 0;
@@ -120,7 +126,7 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	if (!msi_node)
 		return -ENODEV;
 
-	ret = its_translate_frame_address(to_of_node(msi_node), &pa);
+	ret = its_translate_frame_address(msi_node, &pa);
 	if (ret)
 		return -ENODEV;
 
@@ -161,7 +167,7 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
 				ret = -EINVAL;
 
 			if (!ret && pa)
-				ret = its_translate_frame_address(it.node, pa);
+				ret = its_translate_frame_address(of_fwnode_handle(it.node), pa);
 
 			if (!ret)
 				*dev_id = args;
@@ -176,11 +182,6 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
 	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
 }
 
-int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
-{
-	return -1;
-}
-
 static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *info)
 {
@@ -191,7 +192,7 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	if (dev->of_node)
 		ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, NULL);
 	else
-		ret = iort_pmsi_get_dev_id(dev, &dev_id);
+		ret = iort_pmsi_get_msi_info(dev, &dev_id, NULL);
 	if (ret)
 		return ret;
 
@@ -214,10 +215,10 @@ static int its_v5_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	u32 dev_id;
 	int ret;
 
-	if (!dev->of_node)
-		return -ENODEV;
-
-	ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
+	if (dev->of_node)
+		ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
+	else
+		ret = iort_pmsi_get_msi_info(dev, &dev_id, &pa);
 	if (ret)
 		return ret;
 
diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index a27a01f9e7a2..fcd032b5e2fa 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -814,8 +814,11 @@ void __init gicv5_irs_its_probe(void)
 {
 	struct gicv5_irs_chip_data *irs_data;
 
-	list_for_each_entry(irs_data, &irs_nodes, entry)
-		gicv5_its_of_probe(to_of_node(irs_data->fwnode));
+	if (acpi_disabled)
+		list_for_each_entry(irs_data, &irs_nodes, entry)
+			gicv5_its_of_probe(to_of_node(irs_data->fwnode));
+	else
+		gicv5_its_acpi_probe();
 }
 
 int __init gicv5_irs_of_probe(struct device_node *parent)
diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 8e22134b9f48..e24ce3d9fb62 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -5,6 +5,8 @@
 
 #define pr_fmt(fmt)	"GICv5 ITS: " fmt
 
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
 #include <linux/iommu.h>
 #include <linux/init.h>
@@ -1115,7 +1117,7 @@ static int gicv5_its_init_domain(struct gicv5_its_chip_data *its, struct irq_dom
 }
 
 static int __init gicv5_its_init_bases(void __iomem *its_base, struct fwnode_handle *handle,
-				       struct irq_domain *parent_domain)
+				       struct irq_domain *parent_domain, bool noncoherent)
 {
 	struct device_node *np = to_of_node(handle);
 	struct gicv5_its_chip_data *its_node;
@@ -1208,7 +1210,8 @@ static int __init gicv5_its_init(struct device_node *node)
 	}
 
 	ret = gicv5_its_init_bases(its_base, of_fwnode_handle(node),
-				   gicv5_global_data.lpi_domain);
+				   gicv5_global_data.lpi_domain,
+				   of_property_read_bool(node, "dma-noncoherent"));
 	if (ret)
 		goto out_unmap;
 
@@ -1231,3 +1234,128 @@ void __init gicv5_its_of_probe(struct device_node *parent)
 			pr_err("Failed to init ITS %s\n", np->full_name);
 	}
 }
+
+#ifdef CONFIG_ACPI
+
+#define ACPI_GICV5_ITS_MEM_SIZE (SZ_64K)
+
+static struct acpi_madt_gicv5_translator *current_its_entry __initdata;
+static struct fwnode_handle *current_its_fwnode __initdata;
+
+static int __init gic_acpi_parse_madt_its_translate(union acpi_subtable_headers *header,
+						    const unsigned long end)
+{
+	struct acpi_madt_gicv5_translate_frame *its_frame;
+	struct fwnode_handle *msi_dom_handle;
+	struct resource res = {};
+	int err;
+
+	its_frame = (struct acpi_madt_gicv5_translate_frame *)header;
+	if (its_frame->linked_translator_id != current_its_entry->translator_id)
+		return 0;
+
+	res.start = its_frame->base_address;
+	res.end = its_frame->base_address + ACPI_GICV5_ITS_MEM_SIZE - 1;
+	res.flags = IORESOURCE_MEM;
+
+	msi_dom_handle = irq_domain_alloc_parented_fwnode(&res.start, current_its_fwnode);
+	if (!msi_dom_handle) {
+		pr_err("ITS@%pa: Unable to allocate GICv5 ITS translate domain token\n",
+		       &res.start);
+		return -ENOMEM;
+	}
+
+	err = iort_register_domain_token(its_frame->translate_frame_id, res.start,
+					 msi_dom_handle);
+	if (err) {
+		pr_err("ITS@%pa: Unable to register GICv5 ITS domain token (ITS TRANSLATE FRAME ID %d) to IORT\n",
+		       &res.start, its_frame->translate_frame_id);
+		irq_domain_free_fwnode(msi_dom_handle);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __init gic_acpi_free_madt_its_translate(union acpi_subtable_headers *header,
+						   const unsigned long end)
+{
+	struct acpi_madt_gicv5_translate_frame *its_frame;
+	struct fwnode_handle *msi_dom_handle;
+
+	its_frame = (struct acpi_madt_gicv5_translate_frame *)header;
+	if (its_frame->linked_translator_id != current_its_entry->translator_id)
+		return 0;
+
+	msi_dom_handle = iort_find_domain_token(its_frame->translate_frame_id);
+	if (!msi_dom_handle)
+		return 0;
+
+	iort_deregister_domain_token(its_frame->translate_frame_id);
+	irq_domain_free_fwnode(msi_dom_handle);
+
+	return 0;
+}
+
+static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
+					  const unsigned long end)
+{
+	struct acpi_madt_gicv5_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	struct resource res = {};
+	void __iomem *its_base;
+	int err;
+
+	its_entry = (struct acpi_madt_gicv5_translator *)header;
+	res.start = its_entry->base_address;
+	res.end = its_entry->base_address + ACPI_GICV5_ITS_MEM_SIZE - 1;
+	res.flags = IORESOURCE_MEM;
+
+	if (!request_mem_region(res.start, resource_size(&res), "GICv5 ITS"))
+		return -EBUSY;
+
+	dom_handle = irq_domain_alloc_fwnode(&res.start);
+	if (!dom_handle) {
+		pr_err("ITS@%pa: Unable to allocate GICv5 ITS domain token\n",
+		       &res.start);
+		err = -ENOMEM;
+		goto out_rel_res;
+	}
+
+	current_its_entry = its_entry;
+	current_its_fwnode = dom_handle;
+
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GICV5_ITS_TRANSLATE,
+			      gic_acpi_parse_madt_its_translate, 0);
+
+	its_base = ioremap(res.start, ACPI_GICV5_ITS_MEM_SIZE);
+	if (!its_base) {
+		err = -ENOMEM;
+		goto out_unregister;
+	}
+
+	err = gicv5_its_init_bases(its_base, dom_handle, gicv5_global_data.lpi_domain,
+				   its_entry->flags & ACPI_MADT_GICV5_ITS_NON_COHERENT);
+	if (err)
+		goto out_unmap;
+
+	return 0;
+
+out_unmap:
+	iounmap(its_base);
+out_unregister:
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GICV5_ITS_TRANSLATE,
+			      gic_acpi_free_madt_its_translate, 0);
+	irq_domain_free_fwnode(dom_handle);
+out_rel_res:
+	release_mem_region(res.start, resource_size(&res));
+	return err;
+}
+
+void __init gicv5_its_acpi_probe(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GICV5_ITS, gic_acpi_parse_madt_its, 0);
+}
+#else
+void __init gicv5_its_acpi_probe(void) { }
+#endif
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 3a4038640fda..6e65f0f44112 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -401,6 +401,8 @@ u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pdev,
 		rid = of_msi_xlate(&pdev->dev, &msi_ctlr_node, rid);
 		if (msi_ctlr_node)
 			*node = of_fwnode_handle(msi_ctlr_node);
+	} else {
+		rid = iort_msi_xlate(&pdev->dev, rid, node);
 	}
 
 	return rid;
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index d4ed5622cf2b..2d22268677a9 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -27,12 +27,14 @@ int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
-int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);
+u32 iort_msi_xlate(struct device *dev, u32 id, struct fwnode_handle **node);
+int iort_its_translate_pa(struct fwnode_handle *node, phys_addr_t *base);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
+int iort_pmsi_get_msi_info(struct device *dev, u32 *dev_id, phys_addr_t *pa);
 void acpi_configure_pmsi_domain(struct device *dev);
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
@@ -46,9 +48,15 @@ phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
 { return id; }
+static inline u32 iort_msi_xlate(struct device *dev, u32 id, struct fwnode_handle **node)
+{ return id; }
+static inline int iort_its_translate_pa(struct fwnode_handle *node, phys_addr_t *base)
+{ return -ENODEV; }
 static inline struct irq_domain *iort_get_device_domain(
 	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
 { return NULL; }
+static inline int iort_pmsi_get_msi_info(struct device *dev, u32 *dev_id, phys_addr_t *pa)
+{ return -ENODEV; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 static inline
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-gic-v5.h
index ff5b1a4931d7..334b6986435c 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -392,4 +392,5 @@ int gicv5_alloc_lpi(void);
 void gicv5_free_lpi(u32 lpi);
 
 void __init gicv5_its_of_probe(struct device_node *parent);
+void __init gicv5_its_acpi_probe(void);
 #endif

-- 
2.50.1


