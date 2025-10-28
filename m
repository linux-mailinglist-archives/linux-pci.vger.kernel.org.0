Return-Path: <linux-pci+bounces-39512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB386C140EC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 11:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE98B1980764
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A82C305E1B;
	Tue, 28 Oct 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn24dFg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE352C3770;
	Tue, 28 Oct 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646771; cv=none; b=CrOiREDGCen7yYf+YC6mt+qYzvyyrMtLSm5y3NtzSTHLJzOfxjHlTbuB7LDtKnkaHH/FmJluPVUahSnzQZO43oigk7ct7xEP9MX4ejtMV/RcMrIjoo/r4gydD0kVe3jUaN4FeVVY3n7Ew5JiuAlJoJauzvkvnhCUUPX16QdmTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646771; c=relaxed/simple;
	bh=rD3Szlqc7Z0x3k0SP/scHjSXL5BaHqvTEadpp6jc/pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qf09tkOUjQZ2KL4xfGa69Us/WzB7JH2S5r9WmxJy4zhJCS+ztVEjyJWm1Vuu8IFvTA9AeVBqYC0WvX/KXJJrcc7hIr5otx/7H1FbFZznrPpcAdIibdOzoAcU90Do15i0u4QwcqHKwIy/KvCR6ypACuogbj35VyTu4lLoet98OQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn24dFg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C70BC116B1;
	Tue, 28 Oct 2025 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761646770;
	bh=rD3Szlqc7Z0x3k0SP/scHjSXL5BaHqvTEadpp6jc/pU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xn24dFg5oBUGL/jI1D0BK6jlkG/Lqkt3g4h92UIzYCervftU3CSzfm+GCkE3iF65g
	 dCn5C3Uq4e52R+5j64h8QkpOU6R2+ZSmbzNwBMidibn9ww8RPAh/Dnh05S1nAgTlJD
	 iGCA0bK5nhsfNdwhews0PVvyYrJgg+o4lTlJfG/QwGYu9NZNOxGEmE12VFVtDpQvSW
	 1zPXKl16InDuVofp4mzb4i5GtUjcCWv0XnQJYSpYOtWz+IDdgaxZ3xDCE/UHTEZIN5
	 EscM72yqQdV1qWLO1dSkrbyipmC78Gl4QzbIkmaaxmGOOPq2I95M3qxVy7AROo+LH6
	 1srdGbPCgBLoQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Tue, 28 Oct 2025 11:19:02 +0100
Subject: [PATCH not for merging 4/7] PCI/MSI: Make the
 pci_msi_map_rid_ctlr_node() interface firmware agnostic
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-gicv5-host-acpi-v1-4-01a862feb5ca@kernel.org>
References: <20251028-gicv5-host-acpi-v1-0-01a862feb5ca@kernel.org>
In-Reply-To: <20251028-gicv5-host-acpi-v1-0-01a862feb5ca@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-its-msi-parent.c |  8 ++++----
 drivers/pci/msi/irqdomain.c              | 22 +++++++++++++++++-----
 include/linux/msi.h                      |  3 ++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index eb1473f1448a..87b0e33870da 100644
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
index ce741ed9dc3f..d10b72aff1ee 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -466,23 +466,35 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
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
+	struct device_node *of_node;
 	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
-	return of_msi_xlate(&pdev->dev, node, rid);
+	of_node = irq_domain_get_of_node(domain);
+	if (of_node) {
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
index d415dd15a0a9..7513db929cbc 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -705,7 +705,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
-u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node);
+u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pdev,
+			      struct fwnode_handle **node);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
 			   struct msi_desc *desc);

-- 
2.50.1


