Return-Path: <linux-pci+bounces-6092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CE8A0306
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99AE287B6C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AB194C7B;
	Wed, 10 Apr 2024 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHPI+RsH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B36184107;
	Wed, 10 Apr 2024 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787202; cv=none; b=HwLjjA49XtgLfDXxNh7nEgyW8mkS8BlWaHCfJ2PHBnLGpAhxuTeqqzeLX/ygq+K0E6OH6MgUjJFXleoaNlJK0ktfUVSr6kJUE1bJiVGKMBYIGuF3wSo3Dn2H9wRswvCzaOoKbbFIe3LNO0RBbYFgY8uILO0qO9WEMMbRn3pVA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787202; c=relaxed/simple;
	bh=1PLUZkZ+UYcL+67Y6uWNqq+qHl2vJs0y02TfeBgV6cE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGhm8CDi/zccEpqyjuZvof4BIKCkaDS20GgR9hLaKI6FZwZY9c4daWvBawo4JzMXxCY66qiumhZ9NJwhaSzCGUwAX9rKsEVzHwD86UaU4Sxu9TurL4001k7kEiWFWMEQbDXR3ut4Yuvfq4Is6mgwyRRg+5UMX76VHWrwWGVp1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHPI+RsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84075C433C7;
	Wed, 10 Apr 2024 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712787201;
	bh=1PLUZkZ+UYcL+67Y6uWNqq+qHl2vJs0y02TfeBgV6cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHPI+RsHTpEi1qrodoFGb1o5Ggg99/asKny9tfjlY22MTAgS9+KByTkPrp6Uvr3JE
	 hX2eqGUT3o9FlAOL1+Z07G9TvbfizTQLMfqsWltq4r09dFbqeQidRkhaBY114JbaBn
	 tnAQFqWnSExMCNtiQuINCo4c/CYs/q2EGk/1DdJJMpjQGWrHpboX4Ic5vbj7OcpD6H
	 u+/9PJG1OXG0f0OxpiySauOKCui9cxWfX84qxJCfhBEnUYhL75rKleNh8VRntp+4EJ
	 LkUpb4PvjLrg6nr8NGbxtD+YvAcr/l+MioWae+viroGlFL6yUzKQJ7bmZVhAvWkHG/
	 xt7SVF8CVzOrg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/7] Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"
Date: Wed, 10 Apr 2024 17:13:03 -0500
Message-Id: <20240410221307.2162676-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410221307.2162676-1-helgaas@kernel.org>
References: <20240410221307.2162676-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 0194425af0c87acaad457989a2c6d90dba58e776.

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.  If this is
re-added later, the relevant part of 41efa431244f ("PCI/MSI: Provide stubs
for IMS functions") should be squashed into it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/pci/msi/irqdomain.c | 59 -------------------------------------
 include/linux/pci.h         |  5 ----
 2 files changed, 64 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index cfd84a899c82..03d2dd25790d 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -355,65 +355,6 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 	return (supported & feature_mask) == feature_mask;
 }
 
-/**
- * pci_create_ims_domain - Create a secondary IMS domain for a PCI device
- * @pdev:	The PCI device to operate on
- * @template:	The MSI info template which describes the domain
- * @hwsize:	The size of the hardware entry table or 0 if the domain
- *		is purely software managed
- * @data:	Optional pointer to domain specific data to be stored
- *		in msi_domain_info::data
- *
- * Return: True on success, false otherwise
- *
- * An IMS domain is expected to have the following constraints:
- *	- The index space is managed by the core code
- *
- *	- There is no requirement for consecutive index ranges
- *
- *	- The interrupt chip must provide the following callbacks:
- *		- irq_mask()
- *		- irq_unmask()
- *		- irq_write_msi_msg()
- *
- *	- The interrupt chip must provide the following optional callbacks
- *	  when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
- *	  cannot operate directly on hardware, e.g. in the case that the
- *	  interrupt message store is in queue memory:
- *		- irq_bus_lock()
- *		- irq_bus_unlock()
- *
- *	  These callbacks are invoked from preemptible task context and are
- *	  allowed to sleep. In this case the mandatory callbacks above just
- *	  store the information. The irq_bus_unlock() callback is supposed
- *	  to make the change effective before returning.
- *
- *	- Interrupt affinity setting is handled by the underlying parent
- *	  interrupt domain and communicated to the IMS domain via
- *	  irq_write_msi_msg().
- *
- * The domain is automatically destroyed when the PCI device is removed.
- */
-bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
-			   unsigned int hwsize, void *data)
-{
-	struct irq_domain *domain = dev_get_msi_domain(&pdev->dev);
-
-	if (!domain || !irq_domain_is_msi_parent(domain))
-		return false;
-
-	if (template->info.bus_token != DOMAIN_BUS_PCI_DEVICE_IMS ||
-	    !(template->info.flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS) ||
-	    !(template->info.flags & MSI_FLAG_FREE_MSI_DESCS) ||
-	    !template->chip.irq_mask || !template->chip.irq_unmask ||
-	    !template->chip.irq_write_msi_msg || template->chip.irq_set_affinity)
-		return false;
-
-	return msi_create_device_irq_domain(&pdev->dev, MSI_SECONDARY_DOMAIN, template,
-					    hwsize, data, NULL);
-}
-EXPORT_SYMBOL_GPL(pci_create_ims_domain);
-
 /*
  * Users of the generic MSI infrastructure expect a device to have a single ID,
  * so with DMA aliases we have to pick the least-worst compromise. Devices with
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3deb3e42d990..98fb20bcd054 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2664,11 +2664,6 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
-struct msi_domain_template;
-
-bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
-			   unsigned int hwsize, void *data);
-
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \
-- 
2.34.1


