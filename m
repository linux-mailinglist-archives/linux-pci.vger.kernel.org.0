Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FE2CD7A4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 14:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436885AbgLCNfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 08:35:51 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17819 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437051AbgLCNfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 08:35:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8e98b0001>; Thu, 03 Dec 2020 05:35:07 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 13:35:03 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 3 Dec 2020 13:35:00 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 1/5] PCI: tegra: Fix ASPM-L1SS advertisement disable code
Date:   Thu, 3 Dec 2020 19:04:47 +0530
Message-ID: <20201203133451.17716-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203133451.17716-1-vidyas@nvidia.com>
References: <20201203133451.17716-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607002507; bh=BFek7vJlaZbrownN3cTAQ+IV1PMfDMjoJ5+0cXFWPq0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=gdWUdjwxas0SmsqWfjKaTyJd5HToix6Xtl6KFDsOgeCywv+NscQ7pHuHkM0lhfnBc
         2pG41qOJXmmC4KflZYRyK+1MNbfKZvQacfcimA8nBkzRNGNAVyLb4K1M2uRH/19viB
         667Gr36e+KVheMuo2kvg30BwKGB6tLPjPIhlzW1Ec0BHWf7ryPco7Cj0A+MZcwuNlx
         hLDtV7dv8gUDryHjmBT3CaGYt7s3MQjHANlSKb6oroK3L7Ovu3p2VmOHCtOB/4qXcy
         xgyR2Om49uW/PiqbuwpeMoTDORUzyMI04n77KobNT0yA+le35Z8DvkCV99cvb1XB0i
         orLtIiy0Tn0EA==
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
V5:
* Rebased on top of the tree code

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 648e731bccfa..4c966e9adb2b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -863,12 +863,6 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
 
-	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
 	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
@@ -897,6 +891,12 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 
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
-- 
2.17.1

