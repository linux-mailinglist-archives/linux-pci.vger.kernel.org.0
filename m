Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42C23137F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgG1UHM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:07:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:63202 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgG1UHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:07:08 -0400
IronPort-SDR: lPHTDD/HWHsIxct83nthN577ev17ntMbojdJuCF5UeTMBWZqoUdhDaNM7oJ774mpw46hLZxXt8
 w5ZeZaD7RSSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151287342"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="151287342"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 13:07:05 -0700
IronPort-SDR: Fq4gMepYuWN6M0hm96kpzt8hMhQKMAh5cShDgNCNJINrLWJZArgcc2ohwC5TtMl3y8sK6Rh8qf
 Omi3lCixh21g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="312756390"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.124])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 13:07:05 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 5/6] x86/apic/msi: Use Real PCI DMA device when configuring IRTE
Date:   Tue, 28 Jul 2020 13:49:44 -0600
Message-Id: <20200728194945.14126-6-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728194945.14126-1-jonathan.derrick@intel.com>
References: <20200728194945.14126-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD retransmits child device MSI/X with the VMD endpoint's requester-id.
In order to support direct interrupt remapping of VMD child devices,
ensure that the IRTE is programmed with the VMD endpoint's requester-id
using pci_real_dma_dev().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/kernel/apic/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index c2b2911feeef..7ca271b8d891 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -189,7 +189,7 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_MSI;
-	info.msi_dev = dev;
+	info.msi_dev = pci_real_dma_dev(dev);
 
 	domain = irq_remapping_get_irq_domain(&info);
 	if (domain == NULL)
-- 
2.27.0

