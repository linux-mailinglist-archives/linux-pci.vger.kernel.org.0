Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86902CD7B9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 14:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436667AbgLCNgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 08:36:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1738 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437200AbgLCNgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 08:36:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8e9a50000>; Thu, 03 Dec 2020 05:35:33 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 13:35:30 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 3 Dec 2020 13:35:26 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 4/5] PCI: tegra: Check return value of tegra_pcie_init_controller()
Date:   Thu, 3 Dec 2020 19:04:50 +0530
Message-ID: <20201203133451.17716-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203133451.17716-1-vidyas@nvidia.com>
References: <20201203133451.17716-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607002533; bh=BTzR7woRzzvRS3LBZ31mu1SNUmEESjnajUG8HVArlEM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=Sv5rUZowcqV6/czAkhbk41+JPfgsVr+9GC4rnO1lG8o8DRksvqZlIsXnfCdfayarg
         FlPfsUXRAKeL/LT39qNAWDu4mJ15ajF35RY44f6GLKbsGCznPLF/7t7pr1XiFK6Yf4
         YcmbyRe/uuWp7+Qd9QV+9NkEFxgyWyHWO5zggsP8J5o0H21OOlREPKQ8f4kFN/sJ3w
         QGAmpKdIzONthv4iAlx5rWJHbtm/5Cag0o6dko8VD23tnqLf5Nhl3P9YTFTYKgOySD
         3Y7zcL1puUZQnqYehIwh/9Dy1SB1XxGpUy/z+F65Z/9/8TUyTBbKvgZIviY60vwLdn
         6s50s80aywfyA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of tegra_pcie_init_controller() must be checked before
PCIe link up check and registering debugfs entries subsequently as it
doesn't make sense to do these when the controller initialization itself
has failed.

Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5:
* Added Tested-by and Acked-by from Thierry Reding

V4:
* None

V3:
* New patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 471c6d725c70..f4109d71f20b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1563,7 +1563,11 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	tegra_pcie_init_controller(pcie);
+	ret = tegra_pcie_init_controller(pcie);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize controller: %d\n", ret);
+		goto fail_pm_get_sync;
+	}
 
 	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
 	if (!pcie->link_state) {
-- 
2.17.1

