Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554092B6AB1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 17:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKQQxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 11:53:21 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9542 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKQQxV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 11:53:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb3fff80000>; Tue, 17 Nov 2020 08:53:12 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 16:53:18 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Nov 2020 16:53:15 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: dwc: Set 32-bit DMA mask for MSI target address allocation
Date:   Tue, 17 Nov 2020 22:23:12 +0530
Message-ID: <20201117165312.25847-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605631992; bh=y6GQXycgh+Z2dqDNkgy3czX9p4aDC7PVHnEjFtMGryM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=CRsFpVopn+0hALteMxwuECRqtiLtDbdmWOYD4hAcrZbKZzyq8yYio9Dun6pjhs0Zq
         bZ+UgAxLlC2YG3SdulHPCYhzgBkGAfR1PQ8wHG1d/DbckIZdHDM6g7UrwhS/ICtuNZ
         LG/Z4/ECFnEPHjlRwgE5Pu+2+bynVsEkpWFVe1o2RTOIuyA6VITsvBYTnPhFodTI/A
         rmj1LZ+Cvm4hfss7hYzmudbq4Re1xQpeRWZQuz9C0sRnhScNnJUveiRiJf3lBvYrk2
         b+OyJKDG2+lG0thbfK87/8lYuh8QW3SgH083ac6gH8+kD8WLpgI70AHoCd+o4bfa5+
         MARqaQKyfLLHA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set DMA mask to 32-bit while allocating the MSI target address so that
the address is usable for both 32-bit and 64-bit MSI capable devices.
Throw a warning if it fails to set the mask to 32-bit to alert that
devices that are only 32-bit MSI capable may not work properly.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Given the other patch that I've pushed to the MSI sub-system
http://patchwork.ozlabs.org/project/linux-pci/patch/20201117145728.4516-1-vidyas@nvidia.com/
which is going to catch any mismatch between MSI capability (32-bit) of the
device and system's inability to allocate the required MSI target address,
I'm not sure how much sense is this patch going to be make. But, I can
certainly say that if the memory allocation mechanism gives the addresses
from 64-bit pool by default, this patch at least makes sure that MSI target
address is allocated from 32-bit pool.

 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 44c2a6572199..e6a230eddf66 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -388,6 +388,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 							    dw_chained_msi_isr,
 							    pp);
 
+			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
+			if (!ret) {
+				dev_warn(pci->dev,
+					 "Failed to set DMA mask to 32-bit. "
+					 "Devices with only 32-bit MSI support"
+					 " may not work properly\n");
+			}
+
 			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
 						      sizeof(pp->msi_msg),
 						      DMA_FROM_DEVICE,
-- 
2.17.1

