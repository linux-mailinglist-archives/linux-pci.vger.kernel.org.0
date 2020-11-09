Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6702AC1F8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgKIRT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 12:19:58 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1298 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731055AbgKIRT6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:19:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa97a390000>; Mon, 09 Nov 2020 09:19:53 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 17:19:56 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 9 Nov 2020 17:19:52 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 2/6] PCI: tegra: Map configuration space as nGnRnE
Date:   Mon, 9 Nov 2020 22:49:33 +0530
Message-ID: <20201109171937.28326-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109171937.28326-1-vidyas@nvidia.com>
References: <20201109171937.28326-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604942393; bh=Clx46F4u8hOWqYpY3ymeHhJVmnhiU7uZtOTGztDuxk4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=rZPXUZBXztsTbc8LlDrIF09C9U3Ln8NryK9Dfd8fEHMqNE73bze8mwzyekjFN0aE3
         DoJdibXO5DMg4EJ5pnT8TzIZrvjIM/CSajDA916z4NOCFi1GKjvw6cnv50O6r5/ssZ
         wt88bv57PzOL/4wWBv9RSkDhzBjA5GFdazNOnrZ0x2/L7iWjCQgXv6CDXg6dL5GhSa
         tTEnNHg3yxqgBxcPTS+FKmVgtDInyKekMRcvmmvOQ/ChugqPrnnbC59g0+K7E+ImMa
         X+EhPMUz3sYUwYjOZw88re3/Ezb4eSVeP4BNw68Op54/Hwl7x6ghF3RLMG1NtM1k4z
         yKGl3k/uu+msg==
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
V4:
* None

V3:
* None

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

