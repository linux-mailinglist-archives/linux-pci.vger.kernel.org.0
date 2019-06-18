Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1054A94B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfFRSDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:03:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8877 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbfFRSDg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:03:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0927770000>; Tue, 18 Jun 2019 11:03:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:03:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:03:35 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:34 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:03:32 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 24/27] PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
Date:   Tue, 18 Jun 2019 23:32:03 +0530
Message-ID: <20190618180206.4908-25-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560881015; bh=F7/IQsLUSFDtoJAmtRiBHPPcKDZOovoDa1eoFVVPPE4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Zpv2LiTBSqmxwgDEaG9IQ3uKeOM0lUywHRilMcDC99vmetxfEc7gpCqxlel0kawBq
         MGk37RpGqWo29GqVMV8Ub9Rs0NYw5M0CYQVe+fnkSgNO2/Z0lYSl+Q5M1/z4PTF/IO
         fG6or4ehbXQtMhDSwBU9VmaHQswfshCnboZRIWlYX72wJv5XmUTsEPn9zHbP9YV77m
         2N7lWpLpMsjz+2oHbUbjF9X2JonbxvniQmK1QbMSuyoVzPJdXmRK0ZLRBvfDBGTHCf
         0QvAltjk2WdQuYvQd72ZBozecJcUwHm40ELKXAfr8+97ULq4NmLpzPmFgyfcE6R+8M
         zY88QsW0H9HLQ==
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
V6: No change

V5: No change

V4: No change

V3: No change

V2: Using standard pinctrl functions to apply default and idle states

 drivers/pci/controller/pci-tegra.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 347897271943..d2841532ff0e 100644
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
@@ -2834,6 +2835,7 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
 
+	pinctrl_pm_select_idle_state(dev);
 	tegra_pcie_power_off(pcie);
 
 	return 0;
@@ -2849,6 +2851,13 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
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
 
@@ -2858,7 +2867,7 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 	err = clk_prepare_enable(pcie->pex_clk);
 	if (err) {
 		dev_err(dev, "failed to enable PEX clock: %d\n", err);
-		goto poweroff;
+		goto pex_dpd_enable;
 	}
 
 	reset_control_deassert(pcie->pex_rst);
@@ -2879,6 +2888,8 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 disable_pex_clk:
 	reset_control_assert(pcie->pex_rst);
 	clk_disable_unprepare(pcie->pex_clk);
+pex_dpd_enable:
+	pinctrl_pm_select_idle_state(dev);
 poweroff:
 	tegra_pcie_power_off(pcie);
 
-- 
2.17.1

