Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9012CA086B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 19:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfH1R3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 13:29:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8292 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1R3S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 13:29:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d66b9ed0000>; Wed, 28 Aug 2019 10:29:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 10:29:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 28 Aug 2019 10:29:17 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 17:29:16 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d66b9e80001>; Wed, 28 Aug 2019 10:29:16 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 3/6] PCI: tegra: Add support to configure sideband pins
Date:   Wed, 28 Aug 2019 22:58:47 +0530
Message-ID: <20190828172850.19871-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828172850.19871-1-vidyas@nvidia.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567013357; bh=pP3FC6DZxMiOab+sYRmEOZSCLGGOw9w1tNXbOyCzOG8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=D2SKiixIzpvRcdDH9FBmNEtA7SzzKcQeUufCEjdydd1oyAYx/yvKALppa4JE54spg
         9vaD4dfSzMB3jyJX6AhJ0slYSGO4HJgbKDqACp6DG64pf5u7u8TWdZmIN3FPLya/KI
         kTGNcw0CO/gQExSdclFD9wNZaO3BYxAI84+IdMGGEgOPwVHPlJdiYbKt66eai+J7vx
         svKaIgxL+f0QBqgdPfXiBvS/rSmuyGg+SAQN7jF1vic8auMsOXZ2rieYxBCsuH69jW
         5BnrxHsAz6kHbBgK0IxtW+HbcNRl0p5+zrRqcmNk4mt9VVgxD70XS9Coo4DPeXetNP
         r2HkiLDmZVZSg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to configure sideband signal pins when information is present
in respective controller's device-tree node.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Used 'dev' instead of 'pcie->dev'

V2:
* Addressed review comment from Andrew Murray
* Handled failure case of pinctrl_pm_select_default_state() cleanly

 drivers/pci/controller/dwc/pcie-tegra194.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fc0dbeb31d78..77fa6f70bc96 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1304,8 +1304,13 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 	if (ret < 0) {
 		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
 			ret);
-		pm_runtime_disable(dev);
-		return ret;
+		goto fail_pm_get_sync;
+	}
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
+		goto fail_pinctrl;
 	}
 
 	tegra_pcie_init_controller(pcie);
@@ -1332,7 +1337,9 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 
 fail_host_init:
 	tegra_pcie_deinit_controller(pcie);
+fail_pinctrl:
 	pm_runtime_put_sync(dev);
+fail_pm_get_sync:
 	pm_runtime_disable(dev);
 	return ret;
 }
-- 
2.17.1

