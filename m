Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5301129E693
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 09:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgJ2Ij6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 04:39:58 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18654 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgJ2Iiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 04:38:54 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9a50c00000>; Wed, 28 Oct 2020 22:18:56 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 05:18:52 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 05:18:48 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 1/4] PCI: tegra: Fix ASPM-L1SS advertisement disable code
Date:   Thu, 29 Oct 2020 10:48:36 +0530
Message-ID: <20201029051839.11245-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029051839.11245-1-vidyas@nvidia.com>
References: <20201029051839.11245-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603948736; bh=u7cA/MfQqfQQ5BTRPJ65zvlJ3WLKc3dByk1zTUQnz+4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=V+XmfIxFFMsLu58xOYbj/GwsDc2aN9ykBp5XEAMX77Oe4jAfscmM1gO17Z24l5+TU
         f5MsiY53H7LT9mQl8sL9qfboUSzd3V8qZxBS5hj3Brk4XpQgOsACv1dsxw2Xb7hwqN
         k9HM5bZAOgeZkFTgWxz6JP65Xr7lBgGDTC/DyjLM4GPR1bvxNoJln1ML6PoSAMpADc
         ehM9zLTa8c5aTlE+WVlEkxpzcAWl96yPBm1+nsBZdPOvSqJ+55KmPSYzlKa0W4dS+N
         DOzdUIQze27m/wuuydNk1EVNz6mzkVOee6YDQdycNwFwCqT/CLGjq9T/rT1tXxpYlE
         f1OU8BjCoRa9g==
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

