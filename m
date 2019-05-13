Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD81BCEC
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfEMSJc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18177 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbfEMSJb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2e10001>; Mon, 13 May 2019 11:09:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 May 2019 11:09:30 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:30 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:30 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:26 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 25/29] PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
Date:   Mon, 13 May 2019 23:37:40 +0530
Message-ID: <20190513180744.16493-26-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770978; bh=JV3VEwbdQS1ZtlQeKK6vNUmYyT97x80JA03aAwLs1TA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OpKJ9eLFU5q1lDvQxiALBwUrJpnnj/E7LzpkTce6QyOkuVBoheA7a/z87AtX6smx1
         rUs15mGT9O8RUN0RYeeUJnd8IRPxLUe90ShgtVdKKt4CN+KgMGnlEL3lHwXD3g0TbO
         EkMIM8icxCn/njOg6g+bWjr5MqFgq6sFEu/FIhwrCAIk63SwSUpyCbl5WvO1S21J9e
         wSr2u41PlPBmB0ge7bdInKyKbGFu0Qvu04Qn2kiHdJ2O/suN18rrO7IWaxXrGPLliF
         ed3GUzLs+BwMGTdpoGRO0r8EEppCiZqoqj3nSmFNKZPgYY8KdWgotH5LDcyxN6PNHg
         fhSwigKe/ZcNg==
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

