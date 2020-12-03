Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B352CD7F6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 14:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437215AbgLCNgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 08:36:22 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1789 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437207AbgLCNgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 08:36:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8e9ad0000>; Thu, 03 Dec 2020 05:35:41 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 13:35:36 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 3 Dec 2020 13:35:33 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 5/5] PCI: tegra: Disable LTSSM during L2 entry
Date:   Thu, 3 Dec 2020 19:04:51 +0530
Message-ID: <20201203133451.17716-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203133451.17716-1-vidyas@nvidia.com>
References: <20201203133451.17716-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607002541; bh=FzOTD9Je2Yb9E4ZN56eudlZMA2FxlWvUtl9VQXv+GOA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=HGh5gkIBOrXR5PJjElyACgO0DgKyFHJsX5F54nDbKrnXRswivgXyxNsUCb/mCokBc
         ZET/9ku76GNr5W2VN+OeFF2yQQkGGJdYHzpdbKqiiIDtHbZXuvIIZRbZdAV2qku0VE
         krk+vDrsd20yMJCSqHTj5mD5Hfa5GPFvOIk9qZUL2ZYlJr2V+z0gB4pVM4qBexjgJ0
         JIVJelMgGza+DuctzTGnKGD/QUIyVdA64Uo+EmHFZbG1L5khatmk3sphVbJFztazpT
         6Vq8AnSzROH98OmQQQqhigtXyLQFrt9wRvp+W3Wuo36Q79QLYO1FUJiZtKAJ2Sza9l
         h/uISq3u4FWTQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe cards like Marvell SATA controller and some of the Samsung NVMe
drives don't support taking the link to L2 state. When the link doesn't
go to L2 state, Tegra194 requires the LTSSM to be disabled to allow PHY
to start the next link up process cleanly during suspend/resume sequence.
Failing to disable LTSSM results in the PCIe link not coming up in the
next resume cycle.

Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5:
* Added Tested-by and Acked-by from Thierry Reding

V4:
* New patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f4109d71f20b..5597b2a49598 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1506,6 +1506,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_PINMUX_PEX_RST;
 		appl_writel(pcie, data, APPL_PINMUX);
 
+		/*
+		 * Some cards do not go to detect state even after de-asserting
+		 * PERST#. So, de-assert LTSSM to bring link to detect state.
+		 */
+		data = readl(pcie->appl_base + APPL_CTRL);
+		data &= ~APPL_CTRL_LTSSM_EN;
+		writel(data, pcie->appl_base + APPL_CTRL);
+
 		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
 						data,
 						((data &
@@ -1513,14 +1521,8 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
 						LTSSM_STATE_PRE_DETECT,
 						1, LTSSM_TIMEOUT);
-		if (err) {
+		if (err)
 			dev_info(pcie->dev, "Link didn't go to detect state\n");
-		} else {
-			/* Disable LTSSM after link is in detect state */
-			data = appl_readl(pcie, APPL_CTRL);
-			data &= ~APPL_CTRL_LTSSM_EN;
-			appl_writel(pcie, data, APPL_CTRL);
-		}
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
-- 
2.17.1

