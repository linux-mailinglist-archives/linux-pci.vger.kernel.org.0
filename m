Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2348AA0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfFQRlV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:41:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10984 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRlU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:41:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0bf0001>; Mon, 17 Jun 2019 10:41:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:41:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:41:19 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:41:19 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:41:19 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:41:16 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 24/27] PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
Date:   Mon, 17 Jun 2019 23:09:49 +0530
Message-ID: <20190617173952.29363-25-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793279; bh=C0nr43GtIDO9ghBtWlKB+lzvBgWIiyorbjODqPXBsZk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Wzagf+zGlT8xgPM6HDLvBaNfhqbBHhx6FyvNhsfWHrVU2epX96phKifJsbiccOUyk
         1lfhfPpag9l6muemi4vHlp+IMHs8FfR4gn5xdZzyc5m1Nndi/T3KUliOavBR0VScvn
         XGdYnM+dN2RuqTunQj4f8ypizzuMtlvzT3UhejLAN1wxSPssV4+kpSjRDAnqwcnTL9
         R63jJyD6/+s+2cRWlUyspEl5w3LmqH3udulARk+LBys/9YbZXvnbRGYpbjVUxk2MJr
         hq3Nyt+DY8rGsY8zQdlPkJhe+I3RW6C2f2GVeWwo6iV5jCeNGar2F/JW99xjWko/zG
         l0X0SFigWFdZQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In Tegra210 AFI design has clamp value for the BIAS pad as 0, which keeps
the bias pad in non power down mode. This is leading to power consumption
of 2 mW in BIAS pad, even if the PCIe partition is powergated. To avoid
unnecessary power consumption, put PEX CLK & BIAS pads in deep power down
mode when PCIe partition is power gated.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5: No change

V4: No change

V3: No change

V2: Using standard pinctrl functions to apply default and idle states

 drivers/pci/controller/pci-tegra.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 34c5cabd8e80..d3b9e6440dd6 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
@@ -2838,6 +2839,7 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
 
+	pinctrl_pm_select_idle_state(dev);
 	tegra_pcie_power_off(pcie);
 
 	return 0;
@@ -2853,6 +2855,13 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 		dev_err(dev, "tegra pcie power on fail: %d\n", err);
 		return err;
 	}
+
+	err = pinctrl_pm_select_default_state(dev);
+	if (err < 0) {
+		dev_err(dev, "failed to disable PCIe IO DPD: %d\n", err);
+		goto poweroff;
+	}
+
 	tegra_pcie_enable_controller(pcie);
 	tegra_pcie_setup_translations(pcie);
 
@@ -2862,7 +2871,7 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 	err = clk_prepare_enable(pcie->pex_clk);
 	if (err) {
 		dev_err(dev, "failed to enable PEX clock: %d\n", err);
-		goto poweroff;
+		goto pex_dpd_enable;
 	}
 
 	reset_control_deassert(pcie->pex_rst);
@@ -2883,6 +2892,8 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 disable_pex_clk:
 	reset_control_assert(pcie->pex_rst);
 	clk_disable_unprepare(pcie->pex_clk);
+pex_dpd_enable:
+	pinctrl_pm_select_idle_state(dev);
 poweroff:
 	tegra_pcie_power_off(pcie);
 
-- 
2.17.1

