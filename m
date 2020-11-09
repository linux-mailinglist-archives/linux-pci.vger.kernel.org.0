Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63A2AC205
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 18:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgKIRUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 12:20:19 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1351 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbgKIRUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:20:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa97a4e0002>; Mon, 09 Nov 2020 09:20:14 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 17:20:17 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 9 Nov 2020 17:20:13 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 5/6] PCI: tegra: Check return value of tegra_pcie_init_controller()
Date:   Mon, 9 Nov 2020 22:49:36 +0530
Message-ID: <20201109171937.28326-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109171937.28326-1-vidyas@nvidia.com>
References: <20201109171937.28326-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604942414; bh=IiykI/a7ajJ3/GWJO3+HlUOt0S96bxffP6ovv8CN5x0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=JeP2av6kez/BTs+ATf60ypgdKksM/Dp2VCGvVAMprK3baAvOQG6BDOtbFMoDQRkym
         WVK7PxyPow763QEaO+3aaRLIKEOB1+uxPi+F3C952gUSphzcxV98Ela6Jy+fIsur6W
         NXwmdFen0mOYey7uux1eTIOzvlaCznPVNE89MXp+PDPlIU6wtMxRwx/9Rq5A/mHMRY
         MIgNMk7ZLOjYLKeEvThcYR2E9Ft0JPw8+nR+OHuc4kVLIpw8Y1X1yMOYR8zo7gcrDQ
         wuaz2jB7rSX2ZV+c3U7K0L6hL6L5rI0bYosUtokGsVp8c0fUnrkzU1sjNdctnsgnos
         1deuv98CC5PuA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of tegra_pcie_init_controller() must be checked before
PCIe link up check and registering debugfs entries subsequently as it
doesn't make sense to do these when the controller initialization itself
has failed.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* None

V3:
* New patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9be10c8953df..8c08998b9ce1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1579,7 +1579,11 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
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

