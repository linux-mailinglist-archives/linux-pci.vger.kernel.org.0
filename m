Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A05298723
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 08:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770804AbgJZGzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 02:55:18 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12598 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768361AbgJZGzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 02:55:18 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9672dd0000>; Sun, 25 Oct 2020 23:55:26 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:55:17 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:55:13 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 2/4] PCI: tegra: Map configuration space as strongly ordered
Date:   Mon, 26 Oct 2020 12:24:57 +0530
Message-ID: <20201026065459.28509-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026065459.28509-1-vidyas@nvidia.com>
References: <20201026065459.28509-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603695326; bh=Z/hMbqdt0AIcQEkXcN6GBgOo7FXu0Cx8OGl4g1fRQt4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=sQhFAsNW/heuKE1HBgNmY48ZKkdPkmLzZsXDA4rutOwh9DKs0D9p8CUsHBnq6Soa9
         /oVZC76nF1POmiW2ZcpoNA2xCKYA7fi4pzqMyZxaM3UcNMskX9kis64WUu+hSu+7Ji
         9cCdI62uE7FY2Q2vRW2VwU84M/DxWn4CDC0Nhd9fU0x1skfK43FsGr9bwmgEWnbFDz
         3T68nZhJ8hMkoAGITwf8r3m0R/fkw9pX2/rfBnPqqJrF7sg22Jw7hy3e9O/Y4AVwM2
         uZqL1oAWMBVuF9mCL7IAqkJFH+1u6YolRzvFgkgT5f02HHR/ho1+t8CK7+SNlhtQw5
         oxhBxh6zWFXUA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As specified in the comment for pci_remap_cfgspace() define in
arch/arm64/include/asm/io.h file, PCIe configuration space should be
mapped as strongly ordered. Hence changing to dev_pci_remap_cfgspace()
from devm_ioremap_resource() for mapping DBI space as that is nothing
but the root port's own configuration space.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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

