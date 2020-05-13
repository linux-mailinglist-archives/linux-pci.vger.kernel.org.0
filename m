Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05691D1E91
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 21:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbgEMTJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 15:09:07 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7607 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgEMTJH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 15:09:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebc45c10009>; Wed, 13 May 2020 12:08:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 May 2020 12:09:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 May 2020 12:09:02 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 May
 2020 19:09:01 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 May 2020 19:09:01 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ebc45ca0002>; Wed, 13 May 2020 12:09:01 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource size >4GB
Date:   Thu, 14 May 2020 00:38:55 +0530
Message-ID: <20200513190855.23318-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589396929; bh=399a5N89CJHgwM3w35E5bD204YjQ0+eeAF2xbWM2Itk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=F70NVotlbQGXRqpqlmCtMSDoX+GucEYT1EUDrz5e9nE/F4FWmV2OAfuh+k+Iab5b3
         mIasujMtRp633dGkD7IfjCNs/TlzV68x0MUUynbrth8wIteXUKArE9DIAH/lc0pE8T
         w4CXJYaAEmWH+zbEuAYjID8B7QMnEaom2me239cfW7i8uz54Ue/oGj4fJ8LfhqjoTC
         4MnBDZOcaZrPrnq861xhHRHidEJtYgrvYSCT0mRPyqn6gSNXlwED1PUp/JZkVQogLd
         R2m3JET7CkuytE8kTpL46isbDY9tsu0lgY/aS9SmFesoqQuvNxJ3G536mxUVb1icXZ
         WkEvG+WXQXRAQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceeds max for
32-bits") enables warning for MEM resources of size >4GB but prefetchable
 memory resources also come under this category where sizes can go beyond
4GB. Avoid logging a warning for prefetchable memory resources.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 42fbfe2a1b8f..a29396529ea4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->mem = win->res;
 			pp->mem->name = "MEM";
 			mem_size = resource_size(pp->mem);
-			if (upper_32_bits(mem_size))
+			if (upper_32_bits(mem_size) &&
+			    !(win->res->flags & IORESOURCE_PREFETCH))
 				dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
 			pp->mem_size = mem_size;
 			pp->mem_bus_addr = pp->mem->start - win->offset;
-- 
2.17.1

