Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B1311A48
	for <lists+linux-pci@lfdr.de>; Sat,  6 Feb 2021 04:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBFDiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 22:38:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:16483 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhBFDfy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 22:35:54 -0500
IronPort-SDR: gQdNPXlTGALyevfEKaMRI3EwSJeBcm6ZH0xFTGFcXqkSoDpGa1rDE1mOxOhZJ+Ghk7IAyZHwxM
 zYGbMjV3MWJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181581383"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181581383"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 19:35:11 -0800
IronPort-SDR: 0qE1iklm5499/PHoudltYrlZb4ao/ad9XsB/5jIWStBtflQTvNvopNwjnl5WaWaU4aiwohds40
 8DfAksmlpIfg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="576921853"
Received: from rgrover1-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.209.102.94])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 19:35:12 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v3 1/2] iommu/vt-d: Use Real PCI DMA device for IRTE
Date:   Fri,  5 Feb 2021 20:35:01 -0700
Message-Id: <20210206033502.103964-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206033502.103964-1-jonathan.derrick@intel.com>
References: <20210206033502.103964-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD retransmits child device MSI-X with the VMD endpoint's requester-id.
In order to support direct interrupt remapping of VMD child devices,
ensure that the IRTE is programmed with the VMD endpoint's requester-id
using pci_real_dma_dev().

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 685200a5cff0..1939e070eec8 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1276,7 +1276,8 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 		break;
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
+		set_msi_sid(irte,
+			    pci_real_dma_dev(msi_desc_to_pci_dev(info->desc)));
 		break;
 	default:
 		BUG_ON(1);
-- 
2.27.0

