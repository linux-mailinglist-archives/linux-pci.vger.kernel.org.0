Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE716381B6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKXXaw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKXXaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:30:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717826EB76;
        Thu, 24 Nov 2022 15:28:02 -0800 (PST)
Message-ID: <20221124232327.081482253@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CU97iv84FfmZ1eouToiGvE/Nlj455v2TtgsBEv4GPyg=;
        b=mEH6I24/5JaHzfSu02ohUthSvjaDa/eetOKY9B4TW+htv7TjKS4Zxjnmte2TsmKSs+TgqB
        Sauyw/ycHxhL8211OkQpJT53dInJ2dJT0iy8mot93OBiaBw+AG6oXfNqK3hO8FVsLLHhPS
        UXnzHiHZd1r/de8cF/8mcJbNkdVdEqcUYBpAM/P5PObJbS0jnnw+CCqZDfBBPOq+BjpyI0
        EKQJGWXSVfdPq7NmEFp0XFit/EQj9MS7n+G8BDZeuVrhs8jR/v3NKZZOjzebaDrDSYGjny
        +a0VTwOEyGmy0/D9ee3SLPe7fSWP8UqNklpA7rSgIxgeU2KeauCm7iogfLDVkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CU97iv84FfmZ1eouToiGvE/Nlj455v2TtgsBEv4GPyg=;
        b=4AG3rmFrHnCbABF7YKqqCd5OwwW3P6xrVWc0sBk8qufCuR+dAayM9fy/4QFQcJa2jK0FOi
        iguQdNqPP2+mJaBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V3 31/33] iommu/vt-d: Enable PCI/IMS
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:34 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI/IMS works like PCI/MSI-X in the remapping. Just add the feature flag,
but only when on real hardware.

Virtualized IOMMUs need additional support, e.g. for PASID.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Only enable on real hardware (Kevin)
---
 drivers/iommu/intel/irq_remapping.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -82,7 +82,7 @@ static const struct irq_domain_ops intel
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
-static const struct msi_parent_ops dmar_msi_parent_ops;
+static const struct msi_parent_ops dmar_msi_parent_ops, virt_dmar_msi_parent_ops;
 
 static bool ir_pre_enabled(struct intel_iommu *iommu)
 {
@@ -577,7 +577,11 @@ static int intel_setup_irq_remapping(str
 
 	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
 	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
+
+	if (cap_caching_mode(iommu->cap))
+		iommu->ir_domain->msi_parent_ops = &virt_dmar_msi_parent_ops;
+	else
+		iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
 
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
@@ -1429,11 +1433,20 @@ static const struct irq_domain_ops intel
 };
 
 static const struct msi_parent_ops dmar_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI |
+				  MSI_FLAG_PCI_IMS,
 	.prefix			= "IR-",
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
+static const struct msi_parent_ops virt_dmar_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "vIR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 /*
  * Support of Interrupt Remapping Unit Hotplug
  */

