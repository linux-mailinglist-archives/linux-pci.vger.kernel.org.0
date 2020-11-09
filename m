Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5ED2AC206
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 18:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgKIRU1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 12:20:27 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1384 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbgKIRU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:20:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa97a560001>; Mon, 09 Nov 2020 09:20:22 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 17:20:22 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 9 Nov 2020 17:20:18 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 6/6] PCI: tegra: Disable LTSSM during L2 entry
Date:   Mon, 9 Nov 2020 22:49:37 +0530
Message-ID: <20201109171937.28326-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109171937.28326-1-vidyas@nvidia.com>
References: <20201109171937.28326-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604942422; bh=K99h23gugfP4Evxq0Qx1iksWffmd1YF23yjNhOHjM18=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=XrFDO2otaP7S6Uk1pWnkv/2zx2P3DOrGFJ6BusH33HbJi8LpoorPUDIofWMyCIn25
         ypnaJZkepwI+8wyYA+MWa195Z1CeyrLs1GJM6x7iWxp265N/DYAqO5Sh+o36+4I9Gk
         /BvoHWYgnzr5UtNb9meiwzUTdg7LvdwDHijrVxI6sHpni0NQ00f6FbqkvZRG6JbCwE
         C1KObnvEVUCpDajvW+/cSFAr/QeD23c/vAE7VdSjrMeH0/8V9rJ/UWKCZaDJs/rpDz
         JFwoIHhMRnU88EQ4h0KifSs3z9Jeyqsp1v675XGbn8XHk1ZeGz22SwYgvBoC46OLOb
         3DoNoliyC5dNw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe cards like Marvell SATA controller and some of the Samsung NVMe
drives don't support taking the link to L2 state. When the link doesn't
go to L2 state, Tegra194 requires the LTSSM to be disabled to allow PHY
to start the next link up process cleanly during suspend/resume sequence.
Failing to disable LTSSM results in the PCIe link not coming up in the
next resume cycle.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* New patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 8c08998b9ce1..57ff0657bbe2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1513,6 +1513,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
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
@@ -1520,14 +1528,8 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
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

