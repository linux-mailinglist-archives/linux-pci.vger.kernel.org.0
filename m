Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A53A29E689
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 09:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgJ2IjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 04:39:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11563 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgJ2IjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 04:39:09 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9a50b00000>; Wed, 28 Oct 2020 22:18:40 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 05:18:57 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 05:18:53 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 2/4] PCI: tegra: Map configuration space as nGnRnE
Date:   Thu, 29 Oct 2020 10:48:37 +0530
Message-ID: <20201029051839.11245-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029051839.11245-1-vidyas@nvidia.com>
References: <20201029051839.11245-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603948720; bh=Z8voXAw6EbjwLVqEHgC9ep3B8F2TRloMTeKeWZiHZOY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=lbji3myHofempJg4PpP6JxTk2IJUX+VfbBEe5+h5cLW2LV58+2o9k/zHDAcdkxPU8
         zP52gWcf7AEntxB+a7PE+Nemqr/axvraN27vYehuowG6apDMze216kS9rgsXpzIQja
         V2Bu1pOrW3WB9SjP9MheozI8k0/nMItG7Q13WRt/intnLrFwPkDmijBQaR39ULFjHY
         R8Vl4dfQo4S/SwJHrpPDxnMkF3QPW8GdrwaHkdTJ7nSMhDSq0gg5sWz4sYA0aitMRW
         HpQzl0fUj4PJhfTmsCV2UAbI74dv+a62aKaCO8bFFEiGRxQCvs0gNcAzCsD9jgMDti
         bkdnqiQkEL9ew==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As specified in the comment for pci_remap_cfgspace() define in
arch/arm64/include/asm/io.h file, PCIe configuration space should be
mapped as nGnRnE. Hence changing to dev_pci_remap_cfgspace() from
devm_ioremap_resource() for mapping DBI space as that is nothing but
the root port's own configuration space.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Changed 'Strongly Ordered' to 'nGnRnE'

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b172b1d49713..7a0c64436861 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2108,7 +2108,9 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	}
 	pcie->dbi_res = dbi_res;
 
-	pci->dbi_base = devm_ioremap_resource(dev, dbi_res);
+	pci->dbi_base = devm_pci_remap_cfgspace(dev,
+						dbi_res->start,
+						resource_size(dbi_res));
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-- 
2.17.1

