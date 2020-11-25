Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EEB2C483C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 20:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgKYT0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 14:26:05 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4389 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgKYT0E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 14:26:04 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbeafcc0003>; Wed, 25 Nov 2020 11:26:04 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Nov
 2020 19:26:02 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 25 Nov 2020 19:25:58 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <jingoohan1@gmail.com>, <kw@linux.com>,
        <amanharitsh123@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH] PCI: tegra: Read "dbi" base address to program in application logic
Date:   Thu, 26 Nov 2020 00:55:54 +0530
Message-ID: <20201125192554.5401-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606332364; bh=JWEIVMl/77bu7Q+BVjyybEbxe5MdS6MrC/6uj772QPg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=hdVkoaKOWf2K3iNdsk4GNjg9JAXIX8mjLhwUl9zs/cy3Ikza4uqq6GGvDckE8MqL4
         YT466FnFMNDfAZL0b4vD/hEX7hTlcgcuU5Cv6na9guprzE7sLjE8tJtlFuLtVopIs2
         azKxk7e0K3nHjYqtcG/4DaEjjNCtKEBKbVpRV8ltNrDIMmKtwU56l4fjRB6Eo1W287
         Qhg3gOdyFEOyl3aq8WR/PK+HAvT6moyikB1xoCCNJK2Bpl7zaNbKRGRAGn54tYZQKb
         qIGyIbZt2LTZQ71wypNaX2s42xyGzSiVBjvvOEWOzfezWakLnQAOGvR67KfgxySl7Y
         kXEi27jy74+WA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe controller in Tegra194 requires the "dbi" region base address to be
programmed in one of the application logic registers to enable CPU access
to the "dbi" region. But, commit a0fd361db8e5 ("PCI: dwc: Move "dbi",
"dbi2", and "addr_space" resource setup into common code") moved the code
that reads the whereabouts of "dbi" region to the common code causing the
existing code in pcie-tegra194.c file to program NULL in the application
logic registers. This is causing null pointer dereference when the "dbi"
registers are accessed. This issue is fixed by explicitly reading the
"dbi" base address from DT node.

Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fa54d9aaa430..ac2225175087 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1053,9 +1053,16 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 
 static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 {
+	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct device_node *np = pcie->dev->of_node;
 	int ret;
 
+	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	if (!pcie->dbi_res) {
+		dev_err(pcie->dev, "Failed to find \"dbi\" region\n");
+		return -ENODEV;
+	}
+
 	ret = of_property_read_u32(np, "nvidia,aspm-cmrt-us", &pcie->aspm_cmrt);
 	if (ret < 0) {
 		dev_info(pcie->dev, "Failed to read ASPM T_cmrt: %d\n", ret);
-- 
2.17.1

