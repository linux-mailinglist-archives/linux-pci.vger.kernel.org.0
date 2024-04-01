Return-Path: <linux-pci+bounces-5504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7538947A7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A26B21438
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AE857894;
	Mon,  1 Apr 2024 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOkgMSR8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49557889;
	Mon,  1 Apr 2024 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013816; cv=none; b=d5HQYRT3+K16Y4a7VrZNYmVpF7uYKuMNqz0OQGh7MUVgIFDT2GR2KLagdjZbvIKD5LknZw3Vhs6uPQJKhGoATIGqWuBJFjL+cmayoPyfryQcxPP0JfSspNIQPyQ+wKe+JYhf7ENQS+G4VTqiceUbt0TsosgGzZuvaE8XMutMVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013816; c=relaxed/simple;
	bh=A+CcAhB4rTS9GAHPv0pApMxCg0yBq6QM78933yzkFTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MI4oqilgrJShICxogeDvdUeL4cDT47K4X/wSwBge15xJ1LPqnDeuMVtMOSNQMnPWza0Z2NcZPqQThVG8zeXBuNPc0us1EdkDxde8rW4qi3lSifIr6pXBB5qcLxRJc7sHXUBI0mjgwrn5CI/DDohPE0VDoFrOY5sAvG0zpI+vObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOkgMSR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1D2C433C7;
	Mon,  1 Apr 2024 23:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712013816;
	bh=A+CcAhB4rTS9GAHPv0pApMxCg0yBq6QM78933yzkFTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOkgMSR8HHtC0JUtH5wPxvgF4XlHksAQvpjkDimQkfEmmTrLCRwGG3eSM8Otc+PMC
	 tJncqYjhTcAGLKCCdeKm6MA2txPxmMpWww3tj01CG+pw7rrqstFv4EmDM+0nIpOUCN
	 rZDtavMNrWB1G387H4zR+vt5+Zhtv3ApH2O0jVluKLA3dsvHgSD4PkIt+i4UcJa8eU
	 7Lk0G9un7+DwR/AAxEEQuVbjp6+5vp1T0VrqYFf8c4YI/GLp68TkcTGv3oYkmRo8HO
	 6H4QPNV/qifVeAzhVrqfAsVHehiLlAzHaznJFEjVp+Oqg7qs6xsXGGmeWtP19z/9h5
	 dZSssRn6/Zw4Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
Date: Mon,  1 Apr 2024 18:23:25 -0500
Message-Id: <20240401232326.1794707-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401232326.1794707-1-helgaas@kernel.org>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
 <20240401232326.1794707-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit c9e5bea273834a63b5e9ba90ad94b305ba50704e.

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.  If this is
re-added later, the relevant part of 41efa431244f ("PCI/MSI: Provide stubs
for IMS functions") should be squashed into it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/api.c | 50 -------------------------------------------
 include/linux/pci.h   |  3 ---
 2 files changed, 53 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index be679aa5db64..3c1cd29c5cf2 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -365,56 +365,6 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 }
 EXPORT_SYMBOL(pci_irq_get_affinity);
 
-/**
- * pci_ims_alloc_irq - Allocate an interrupt on a PCI/IMS interrupt domain
- * @dev:	The PCI device to operate on
- * @icookie:	Pointer to an IMS implementation specific cookie for this
- *		IMS instance (PASID, queue ID, pointer...).
- *		The cookie content is copied into the MSI descriptor for the
- *		interrupt chip callbacks or domain specific setup functions.
- * @affdesc:	Optional pointer to an interrupt affinity descriptor
- *
- * There is no index for IMS allocations as IMS is an implementation
- * specific storage and does not have any direct associations between
- * index, which might be a pure software construct, and device
- * functionality. This association is established by the driver either via
- * the index - if there is a hardware table - or in case of purely software
- * managed IMS implementation the association happens via the
- * irq_write_msi_msg() callback of the implementation specific interrupt
- * chip, which utilizes the provided @icookie to store the MSI message in
- * the appropriate place.
- *
- * Return: A struct msi_map
- *
- *	On success msi_map::index contains the allocated index (>= 0) and
- *	msi_map::virq the allocated Linux interrupt number (> 0).
- *
- *	On fail msi_map::index contains the error code and msi_map::virq
- *	is set to 0.
- */
-struct msi_map pci_ims_alloc_irq(struct pci_dev *dev, union msi_instance_cookie *icookie,
-				 const struct irq_affinity_desc *affdesc)
-{
-	return msi_domain_alloc_irq_at(&dev->dev, MSI_SECONDARY_DOMAIN, MSI_ANY_INDEX,
-				       affdesc, icookie);
-}
-EXPORT_SYMBOL_GPL(pci_ims_alloc_irq);
-
-/**
- * pci_ims_free_irq - Allocate an interrupt on a PCI/IMS interrupt domain
- *		      which was allocated via pci_ims_alloc_irq()
- * @dev:	The PCI device to operate on
- * @map:	A struct msi_map describing the interrupt to free as
- *		returned from pci_ims_alloc_irq()
- */
-void pci_ims_free_irq(struct pci_dev *dev, struct msi_map map)
-{
-	if (WARN_ON_ONCE(map.index < 0 || map.virq <= 0))
-		return;
-	msi_domain_free_irqs_range(&dev->dev, MSI_SECONDARY_DOMAIN, map.index, map.index);
-}
-EXPORT_SYMBOL_GPL(pci_ims_free_irq);
-
 /**
  * pci_free_irq_vectors() - Free previously allocated IRQs for a device
  * @dev: the PCI device to operate on
diff --git a/include/linux/pci.h b/include/linux/pci.h
index abbef75b2b92..3deb3e42d990 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2668,9 +2668,6 @@ struct msi_domain_template;
 
 bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
 			   unsigned int hwsize, void *data);
-struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
-				 const struct irq_affinity_desc *affdesc);
-void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
 
 #include <linux/dma-mapping.h>
 
-- 
2.34.1


