Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334721FF31
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEPFyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:44 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19844 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEPFyo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfafa0000>; Wed, 15 May 2019 22:54:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:43 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:42 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:39 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 25/28] PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
Date:   Thu, 16 May 2019 11:23:04 +0530
Message-ID: <20190516055307.25737-26-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986042; bh=dZSw76Jjvph6DuwL5jJWR4HVQmQVAUZBDWnIn1Sk750=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jdLMDPd9J2PPiSXc8zQ0h+TNbetotaE5H13d6/hlP7jqPfYQjBPKo3pZ0+oEKoRYu
         XE+eV+gjV6DsztzlDsQhyIbmD/cYhAfGo72GikihEL/VOJhiAqqkWJIALacgaODfUc
         8BOxlLZLpPODQFcIXh8DPCZCv8eRniKjA/0q/9vIMhJJGxGyalQkpQBfTGmtqnJ64q
         QqXJyibhax28dxXzrmlkn05i9VZfC1NsAaUz7wPRL1OjHMDsDA3UyXEZGdMqpHalG2
         3UMyA3xxARUCaqTx/YA+L2ErDogCh3R/y+nEbdORn5Z/BLckTExakuyUE8muNMYhSJ
         /cPQFT0gm0M0Q==
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
V4: No change

V3: No change

V2: Using standard pinctrl functions to apply default and idle states

 drivers/pci/controller/pci-tegra.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 33f4dfab9e35..06b99fcbf382 100644
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
@@ -2875,6 +2876,7 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
 
+	pinctrl_pm_select_idle_state(dev);
 	tegra_pcie_power_off(pcie);
 
 	return 0;
@@ -2890,6 +2892,13 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
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
 
@@ -2899,7 +2908,7 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 	err = clk_prepare_enable(pcie->pex_clk);
 	if (err) {
 		dev_err(dev, "failed to enable PEX clock: %d\n", err);
-		goto poweroff;
+		goto pex_dpd_enable;
 	}
 
 	reset_control_deassert(pcie->pex_rst);
@@ -2920,6 +2929,8 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 disable_pex_clk:
 	reset_control_assert(pcie->pex_rst);
 	clk_disable_unprepare(pcie->pex_clk);
+pex_dpd_enable:
+	pinctrl_pm_select_idle_state(dev);
 poweroff:
 	tegra_pcie_power_off(pcie);
 
-- 
2.17.1

