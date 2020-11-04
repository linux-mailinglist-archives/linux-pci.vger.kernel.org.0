Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA52A5FEE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 09:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgKDIw2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 03:52:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2627 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgKDIwU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 03:52:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa26bc60000>; Wed, 04 Nov 2020 00:52:22 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 08:52:16 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Nov 2020 08:52:12 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 1/5] PCI: tegra: Fix ASPM-L1SS advertisement disable code
Date:   Wed, 4 Nov 2020 14:20:14 +0530
Message-ID: <20201104085018.13021-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104085018.13021-1-vidyas@nvidia.com>
References: <20201104085018.13021-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604479942; bh=pE6B5W32IRU6jU0blW1A2aBVvj4gHjrSf7CmW+Ju6pg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=qcoyRoCZ0piUYe73ac3RXhzFqb2XBUMAuLGZRxa+DjUUQ5uozNBm3gFVaoF5cyHQQ
         mbqzO9QHYJTjrKgl4cAn++kssJLlXXLQebPPOghBi4Y3q1rnKU89Thed9MLnWW9HeD
         xbhG0wgKxqBSk4esSaGr2HY66uIbG/Q5alsc9BdnUjORlIp8kuGfRX20iV9GwCeDan
         aab0YZCQbePSm0DP2XG/UlH0qNLAJADjyYKvcNdik0SdB7KViwJo2hGTgVyXjRC6F5
         PY+0BIpRq4DV5+HHt7nSRwiZt3V4OhydPMpC+d9rnw0UfjDG4Yr3fiLhWdmnAtCb0r
         dhUpxYsdCUumw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the absence of CLKREQ# signal is indicated by the absence of
"supports-clkreq" in the device-tree node, current driver is disabling
the advertisement of ASPM-L1 Sub-States *before* the ASPM-L1 Sub-States
offset is correctly initialized. Since default value of the ASPM-L1SS
offset is zero, this is causing the Vendor-ID wrongly programmed to 0x10d2
instead of Nvidia's 0x10de thereby the quirks applicable for Tegra194 are
not being applied. This patch fixes this issue by refactoring the
code that disables the ASPM-L1SS advertisement.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index aa511ec0d800..b172b1d49713 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -896,6 +896,12 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 
 	init_host_aspm(pcie);
 
+	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
+	if (!pcie->supports_clkreq) {
+		disable_aspm_l11(pcie);
+		disable_aspm_l12(pcie);
+	}
+
 	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
@@ -1400,12 +1406,6 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 
-	/* Disable ASPM-L1SS advertisement as there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	return ret;
 
 fail_phy:
-- 
2.17.1

