Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721E22A5FE9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 09:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgKDIwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 03:52:23 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5993 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgKDIwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 03:52:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa26bc60000>; Wed, 04 Nov 2020 00:52:22 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 08:52:22 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Nov 2020 08:52:18 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 2/5] PCI: tegra: Map configuration space as nGnRnE
Date:   Wed, 4 Nov 2020 14:20:15 +0530
Message-ID: <20201104085018.13021-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104085018.13021-1-vidyas@nvidia.com>
References: <20201104085018.13021-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604479942; bh=iPvrvcjkmUg2V+eK69c4S38RPbTDBf/mrJL3XR/YNOw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=pljk4JTcxqstuGwgb41fF7V5SpD+760cLPwp6NT7T9fHva87gIjLHHhlZ+iJu9oBD
         aXDL7D8GtMj/BBK45zRnlinym4ycJ9bH+VtJz7uoGHgsck9/nYyuJ/qHWstHCIKXjH
         nJV7TG/T1Aap+TKzlE4BqQ3OpS9jjl+tCvuO8gtP0Z8TccRtFAimlXjqrLyXRg81xu
         gzBLogEAeLB2DJDIEDxU/pAdUbosfbwGiG/6rLNUtgl482QT7jwzBJMz0hqg0u07DU
         u8nHgprObbsMgqaXhWRod66HcnjF8XgDQNfrneGRqlpbgV8xm5tTm/LK35aqGjzCrx
         poU8JNycMV3Sw==
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

