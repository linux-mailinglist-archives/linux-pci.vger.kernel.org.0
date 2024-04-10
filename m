Return-Path: <linux-pci+bounces-6093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1220D8A0309
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C025B287DB4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D84194C9C;
	Wed, 10 Apr 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIEAJoAo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DF194C97;
	Wed, 10 Apr 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787204; cv=none; b=QGFgnK8P4kMSQ4sOkq6rEcmrmXvayxdsvsE9U9NDJEGtrakM96TkuonMuqFYbxEsk5tPuI7WAuiGeEwilzlg0DwvoSzyQqK9hLe9aLLynHgPGNLUnxG2QGOMU/8wXvWWQsIK+OAnJo418TYW0oZj+6UApES4MfYC+NQp5gIWMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787204; c=relaxed/simple;
	bh=A1NHROTFtfhXnMCORE7OpRKwCzKPX7qMNstag/6FFBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4oE5eDKgz44+dwZhVF5iWTeDG326D+C17XMLxgflwrDS/yvC4rVdCk4KIb5zK4ZCHr6vGoR6TuQF4JSv6JeukdqQDZAIo9DFZTiBc2mi0zK+DL8nG4/pq6yzNRqUuPRgMSbdTYU2M/yIN8832mLwE2n2KKE/ILvHHmmo6S7bXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIEAJoAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D15C433F1;
	Wed, 10 Apr 2024 22:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712787203;
	bh=A1NHROTFtfhXnMCORE7OpRKwCzKPX7qMNstag/6FFBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIEAJoAoxtvTFxj3zSI8Tppw8LxMJthFez8Zb9wwNwjIP3CipVLrZF5QjMK91xpD8
	 3U0Nth+9ML4Azr1geRXNdeefP/Z3gY+YIzShr7rj60lKBR+SzG+1j6PzRM9FVVsrfC
	 QspO3du3P4BmyWOZtCYgBu3JIx6/OhF3QQ0rub+/UTSP3IDKnbgoOKDPg89O3HTGPj
	 JK4QvgejURNpBRuh9/k8Ov7nj58Lt28R6ypS+uNFAN6Id4sP2/YLUhk1SytNQs82F6
	 H5zAWOVYrbP5+v2J7UyCEM3IiR/JmOhOgA3CR30zt36xklo7LN5Zw3rpjmcJrOU4dL
	 cV3GaWDBzhVdQ==
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
Subject: [PATCH v2 4/7] Revert "iommu/amd: Enable PCI/IMS"
Date: Wed, 10 Apr 2024 17:13:04 -0500
Message-Id: <20240410221307.2162676-5-helgaas@kernel.org>
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

This reverts commit fa5745aca1dc819aee6463a2475b5c277f7cf8f6.

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/amd/iommu.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d35c1b8c8e65..31a1a6686329 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3701,20 +3701,11 @@ static struct irq_chip amd_ir_chip = {
 };
 
 static const struct msi_parent_ops amdvi_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
-				  MSI_FLAG_MULTI_PCI_MSI |
-				  MSI_FLAG_PCI_IMS,
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
 	.prefix			= "IR-",
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
-static const struct msi_parent_ops virt_amdvi_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
-				  MSI_FLAG_MULTI_PCI_MSI,
-	.prefix			= "vIR-",
-	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
-};
-
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
 	struct fwnode_handle *fn;
@@ -3732,11 +3723,7 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_AMDVI);
 	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT |
 				   IRQ_DOMAIN_FLAG_ISOLATED_MSI;
-
-	if (amd_iommu_np_cache)
-		iommu->ir_domain->msi_parent_ops = &virt_amdvi_msi_parent_ops;
-	else
-		iommu->ir_domain->msi_parent_ops = &amdvi_msi_parent_ops;
+	iommu->ir_domain->msi_parent_ops = &amdvi_msi_parent_ops;
 
 	return 0;
 }
-- 
2.34.1


