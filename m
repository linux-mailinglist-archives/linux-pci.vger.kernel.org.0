Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F1E316ADD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhBJQOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 11:14:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:47936 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231950AbhBJQOI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 11:14:08 -0500
IronPort-SDR: S5QfhXyLxX2e4awa4FORuiEQstWwaTNJbzwCnyc5GFLjxQoXnd01zCv6jeMfl6A/kp+6L8rVNb
 aYFC/PnLzfAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179543646"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="179543646"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:13:27 -0800
IronPort-SDR: XgVnhs5fdnTJX83avyKPOc4F7/T5wk5386OP+5Ao2+yUj/+dd9JFMfxg0R4fpTj56Wi4exlAWU
 bfgil4wA/pjQ==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380191376"
Received: from mjyalung-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.209.178.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:13:26 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 1/2] iommu/vt-d: Use Real PCI DMA device for IRTE
Date:   Wed, 10 Feb 2021 09:13:14 -0700
Message-Id: <20210210161315.316097-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210161315.316097-1-jonathan.derrick@intel.com>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
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

