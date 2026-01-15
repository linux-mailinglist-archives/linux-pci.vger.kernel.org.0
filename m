Return-Path: <linux-pci+bounces-44925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C6D23B80
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 765EC303933E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3175735F8C6;
	Thu, 15 Jan 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuVCJ74v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADF334695;
	Thu, 15 Jan 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470677; cv=none; b=iouuvCvi5bSBe8S4WmfXiB5SDT7EmT5nXebBPghliH79ZJHsY1nypWj9OD8NEU4BNrhSCQWfXUK8tJiKDj6B3Qh39CSHkvjoOXxX4sZaZ+qmnvxi9/UWumGD42SCe84nK/ZYNCwyADfd76KUZ1383V7M9g+maDrhL2qEvihTH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470677; c=relaxed/simple;
	bh=aTM+15MuMBWcKYpMkd2t27DnfiaoGuCnRx72X7ugcxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7izuDHBMNrGCgGDWPnxUxFOxqe6fgl+sT8450czmsySnBE2RmDKS0j5O1esdoAK5AKX3iWtPEFPUNMQJp8HLc91XS6O/OViujC8coYZUWS/WisyZz+rQrSK1NFSmKRSCAv/kgfH/5Bk0Xs8a1OuJf3Ac0sYRQqpmPZ7u5LZT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuVCJ74v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B51C116D0;
	Thu, 15 Jan 2026 09:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470676;
	bh=aTM+15MuMBWcKYpMkd2t27DnfiaoGuCnRx72X7ugcxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EuVCJ74vrP6Po2rDh46/ZydRo60pFY8Gpd13cGcWTBD2XMDvrqIkdbZzt1V7L26LN
	 BNC2WOLZxdEBp1kaG7vDtS9+ha+T4iaL4SwN+jPWz9bFP7n5WEuhLoqdykUfQiilxG
	 bDf8ihLDNuJ5vDrKEiLbQE+KIe4s8dwDNZ4lK2wrKbBkdwhsP0JZ8Y2Wo5bjoQFr0D
	 yRULNNzWN55GiW214LnBVTcTqmO51xV1YHeD9KftUqy0B6aUZ3JZ4bsj8q8ZGDbgRM
	 /F2xH7sIGV1JPK5BxiFPnOpNunl+Lot7IM+H863EC5Ea2FYx9qrhIgxrRJQPzMj9xN
	 Eb5GnJdvPWUrg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 15 Jan 2026 10:50:48 +0100
Subject: [PATCH v3 2/6] PCI/MSI: Make the pci_msi_map_rid_ctlr_node()
 interface firmware agnostic
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-gicv5-host-acpi-v3-2-c13a9a150388@kernel.org>
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

To support booting with OF and ACPI seamlessly, GIC ITS parent code
requires the PCI/MSI irqdomain layer to implement a function to retrieve
an MSI controller fwnode and map an RID in a firmware agnostic way
(ie pci_msi_map_rid_ctlr_node()).

Convert pci_msi_map_rid_ctlr_node() to an OF agnostic interface
(fwnode_handle based) and update the GIC ITS MSI parent code to reflect
the pci_msi_map_rid_ctlr_node() change.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-its-msi-parent.c |  8 ++++----
 drivers/pci/msi/irqdomain.c              | 21 ++++++++++++++++-----
 include/linux/msi.h                      |  3 ++-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index 12f45228c867..4d1ad1ee005d 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -104,7 +104,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 				  int nvec, msi_alloc_info_t *info)
 {
-	struct device_node *msi_node = NULL;
+	struct fwnode_handle *msi_node = NULL;
 	struct msi_domain_info *msi_info;
 	struct pci_dev *pdev;
 	phys_addr_t pa;
@@ -116,15 +116,15 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 
 	pdev = to_pci_dev(dev);
 
-	rid = pci_msi_map_rid_ctlr_node(pdev, &msi_node);
+	rid = pci_msi_map_rid_ctlr_node(domain->parent, pdev, &msi_node);
 	if (!msi_node)
 		return -ENODEV;
 
-	ret = its_translate_frame_address(msi_node, &pa);
+	ret = its_translate_frame_address(to_of_node(msi_node), &pa);
 	if (ret)
 		return -ENODEV;
 
-	of_node_put(msi_node);
+	fwnode_handle_put(msi_node);
 
 	/* ITS specific DeviceID */
 	info->scratchpad[0].ul = rid;
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index a329060287b5..3a4038640fda 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -376,23 +376,34 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 }
 
 /**
- * pci_msi_map_rid_ctlr_node - Get the MSI controller node and MSI requester id (RID)
+ * pci_msi_map_rid_ctlr_node - Get the MSI controller fwnode_handle and MSI requester id (RID)
+ * @domain:	The interrupt domain
  * @pdev:	The PCI device
- * @node:	Pointer to store the MSI controller device node
+ * @node:	Pointer to store the MSI controller fwnode_handle
  *
- * Use the firmware data to find the MSI controller node for @pdev.
+ * Use the firmware data to find the MSI controller fwnode_handle for @pdev.
  * If found map the RID and initialize @node with it. @node value must
  * be set to NULL on entry.
  *
  * Returns: The RID.
  */
-u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node)
+u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pdev,
+			      struct fwnode_handle **node)
 {
 	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
-	return of_msi_xlate(&pdev->dev, node, rid);
+	/* Check whether the domain fwnode is an OF node */
+	if (irq_domain_get_of_node(domain)) {
+		struct device_node *msi_ctlr_node = NULL;
+
+		rid = of_msi_xlate(&pdev->dev, &msi_ctlr_node, rid);
+		if (msi_ctlr_node)
+			*node = of_fwnode_handle(msi_ctlr_node);
+	}
+
+	return rid;
 }
 
 /**
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8003e3218c46..8ddb05d5c96a 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -702,7 +702,8 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
-u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node);
+u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pdev,
+			      struct fwnode_handle **node);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
 			   struct msi_desc *desc);

-- 
2.50.1


