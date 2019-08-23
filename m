Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB18B9B331
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394385AbfHWPSj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 11:18:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17287 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733205AbfHWPSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 11:18:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6003cf0000>; Fri, 23 Aug 2019 08:18:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 23 Aug 2019 08:18:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 23 Aug 2019 08:18:37 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 15:18:37 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Aug 2019 15:18:37 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6003ca0003>; Fri, 23 Aug 2019 08:18:37 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH] PCI: tegra: Don't print an error on -EPROBE_DEFER
Date:   Fri, 23 Aug 2019 20:48:32 +0530
Message-ID: <20190823151832.14427-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566573519; bh=klbHIqUG1MOQPk1835oiZcvUqTiR0BpWrtVZRaGnKJE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Z5hDrRcC2hLvacpyu+xrgxzOWhU+xST7ZMYONdndHMjtPIKxqWh1EmztmJ1iyrKYs
         LDQO8swaFCYLBh7wO/tBM91BKLXmMnFPIGXnaTmul10lqwRpSH3KBR6iqQkoVmDBUT
         s1nlZTjIHUedeoUs3LnU0fnijVfadJaaTvG4ue8rKB00FcOD7pk101nI68/XFkaYC9
         vbxXG8UaF0msKy5Rm93+cianCzr0PTtKsmqwoMhRQ8GwUvMw+twgMxzkxEqXPTNkOF
         rKQUPHOmtgGDYDdG1TNVGotuFGOrgHokzLppQGFQvMwINS0IrIuaM150q8k1WZbfS0
         jDmq2xGzLU/CQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

APIs like devm_regulator_get() and devm_phy_get() have the potential to
return -EPROBE_DEFER when the respective sub-systems are not ready yet.
So avoid printing an error message as .probe() will be tried out again
at a later point of time anyway.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fc0dbeb31d78..c730986ed34d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1368,9 +1368,11 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
 	if (IS_ERR(pcie->pex_ctl_supply)) {
-		dev_err(dev, "Failed to get regulator: %ld\n",
-			PTR_ERR(pcie->pex_ctl_supply));
-		return PTR_ERR(pcie->pex_ctl_supply);
+		ret = PTR_ERR(pcie->pex_ctl_supply);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get regulator: %ld\n",
+				PTR_ERR(pcie->pex_ctl_supply));
+		return ret;
 	}
 
 	pcie->core_clk = devm_clk_get(dev, "core");
@@ -1412,7 +1414,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		kfree(name);
 		if (IS_ERR(phys[i])) {
 			ret = PTR_ERR(phys[i]);
-			dev_err(dev, "Failed to get PHY: %d\n", ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get PHY: %d\n", ret);
 			return ret;
 		}
 	}
-- 
2.17.1

