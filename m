Return-Path: <linux-pci+bounces-6095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0A08A030E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBCB2829FE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC85199EB8;
	Wed, 10 Apr 2024 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed20BydI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E360184130;
	Wed, 10 Apr 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787208; cv=none; b=vB03qICrCUws7a8JcOBL/OIETT8d+eKF7zL9EWu/kQshE6vYcz3I9tk9jK4/m12zwRFCyUv43v0wRhZ7O/MpoxmZb6S13ZIqisfTwWEn+rVRQ2Y6opAlnfsOXf0GK1b7IQEKrGtUn5DO7wLFcfs2BR8QwE+miF2551V7P64Hau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787208; c=relaxed/simple;
	bh=PaJ019h4kLduZMdsA1yUINP29qV1vFhm6+0bkH9w0pI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfCUrybNV++KeaiUjHjyECGa+3YmtLvhVF2YUjv7k9ZnL2MLJ5QL3tdslFPEDIqgWx0PIXVTkHJ+XtOdoztOcoofazz4DvbJIB2Fp9e+2pxiuX1tjE0e6QWdyLnwDbXDwvKcOizpSiWkAxckA/usBWZ75xYVokVPdRzV/2OA2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed20BydI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6125CC433F1;
	Wed, 10 Apr 2024 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712787207;
	bh=PaJ019h4kLduZMdsA1yUINP29qV1vFhm6+0bkH9w0pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ed20BydIxx38g/cIo+MGjoGCqql8sqZm4qVzRsi8Kr5WY5lmU0cE75nwwXm2lvqM/
	 16BPc85fKKgM1OmJAJf+bw/vyTAkTmOGKoCm5xClPpiIoAndpSDjBUGONDJsC2cyg/
	 H8AfoZQ5SUbuJIgwC9Io1pr8KFWQGmscre2+xslKatP+Fv9+7dKqMkO+R6dH4ZPSVD
	 KZGfkbWYVRR9xQEj7fs86KIpNbAjJPlRc00soqeM+eOdQs+mxvcjqdqgazvGLu1VVo
	 uJGkQNLuBLp/cxFtwV52bgOrierXSEXwef1ke+e+kyTVCF3735uk7+XSirSWi1rLNh
	 jpkZpxzKaM4Lg==
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
Subject: [PATCH v2 6/7] Revert "x86/apic/msi: Enable PCI/IMS"
Date: Wed, 10 Apr 2024 17:13:06 -0500
Message-Id: <20240410221307.2162676-7-helgaas@kernel.org>
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

This reverts commit 6e24c887732901140f4e82ba2315c2e15f06f1d6.

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/kernel/apic/msi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index d9651f15ae4f..340769242dea 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -184,7 +184,6 @@ static int x86_msi_prepare(struct irq_domain *domain, struct device *dev,
 		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 		return 0;
 	case DOMAIN_BUS_PCI_DEVICE_MSIX:
-	case DOMAIN_BUS_PCI_DEVICE_IMS:
 		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 		return 0;
 	default:
@@ -229,10 +228,6 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	case DOMAIN_BUS_PCI_DEVICE_MSI:
 	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 		break;
-	case DOMAIN_BUS_PCI_DEVICE_IMS:
-		if (!(pops->supported_flags & MSI_FLAG_PCI_IMS))
-			return false;
-		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;
-- 
2.34.1


