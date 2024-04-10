Return-Path: <linux-pci+bounces-6094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9E8A030B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1281F23DAA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14B199E91;
	Wed, 10 Apr 2024 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6ZHdvF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7906184107;
	Wed, 10 Apr 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787206; cv=none; b=eSYWK7PNUcAtgnEnCrRnz4jmTIhtNas8RZdTpv2H2aaa6LhcsWwZgIPcMStsAD69fYM/wWfNeeuc6JtNJxJN9j3jh5w/ub2b/9iPykvs/4rrc/Z2CvTmEdUuoBAJ1C3DdcOeJ6aNkPjOlMuZMoK5oTrKARN4JxVAu/ZJqadD5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787206; c=relaxed/simple;
	bh=RJiKxlcyGCegqaQL+HqE7i5K68Hg3ohqyMufg3omy84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/1opwhoBR6ct/ptXaB25ucfejDo66hB4/GRyrPvOpw0IVE9atdFx81ntrdZ+FByLAwLqowM4kdA/yFLpqKo/EV34TLsCOQgn8OYbllynvtBrMh+hsc5OvR2KIvlcwwKGHLNmCGCDX7AEzrOBN8eNcnJlWieGNCwGvsYXByxMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6ZHdvF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84334C43394;
	Wed, 10 Apr 2024 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712787205;
	bh=RJiKxlcyGCegqaQL+HqE7i5K68Hg3ohqyMufg3omy84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6ZHdvF7JeFLdHTQ1zMWQqYza3Nb4LURnzbLxAIp2wE1d0OibGmumt6HBKqmtyEn/
	 P47MQOzi+20VOWXGqpgvYuYump7b8wFabknlsXMEar6PhNiLKAi2jScCfVw/JfNQRh
	 IydS61CS6TQ7vnQ5B83xr2zThJq6hyfERIeSNCHoQi027foC7D/wr4PiSIap5sVoS+
	 hxTaD6qZxsCd1CoaLDhnbNZv42uKJOWv/QmJLKyzBfbPhKPHaNJ2FTwUQYZ/N95ib8
	 BuKFZVfcozq1Nlh2hrccuYd0MuJeorXzAxHtzNEyPK3UicpI/qDjlIxyQE4kOcR8gD
	 0/CUX7QV/0flQ==
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
Subject: [PATCH v2 5/7] Revert "iommu/vt-d: Enable PCI/IMS"
Date: Wed, 10 Apr 2024 17:13:05 -0500
Message-Id: <20240410221307.2162676-6-helgaas@kernel.org>
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

This reverts commit 810531a1af5393f010d6508b1cb48e6650fc5e8f.

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel/irq_remapping.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 566297bc87dd..0f64fa72ac4f 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -82,7 +82,7 @@ static const struct irq_domain_ops intel_ir_domain_ops;
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
-static const struct msi_parent_ops dmar_msi_parent_ops, virt_dmar_msi_parent_ops;
+static const struct msi_parent_ops dmar_msi_parent_ops;
 
 static bool ir_pre_enabled(struct intel_iommu *iommu)
 {
@@ -567,11 +567,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
 	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT |
 				   IRQ_DOMAIN_FLAG_ISOLATED_MSI;
-
-	if (cap_caching_mode(iommu->cap))
-		iommu->ir_domain->msi_parent_ops = &virt_dmar_msi_parent_ops;
-	else
-		iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
+	iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
 
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
@@ -1421,20 +1417,11 @@ static const struct irq_domain_ops intel_ir_domain_ops = {
 };
 
 static const struct msi_parent_ops dmar_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
-				  MSI_FLAG_MULTI_PCI_MSI |
-				  MSI_FLAG_PCI_IMS,
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
 	.prefix			= "IR-",
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
-static const struct msi_parent_ops virt_dmar_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
-				  MSI_FLAG_MULTI_PCI_MSI,
-	.prefix			= "vIR-",
-	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
-};
-
 /*
  * Support of Interrupt Remapping Unit Hotplug
  */
-- 
2.34.1


