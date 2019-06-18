Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DBB4A909
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfFRSCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:02:23 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8785 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRSCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:02:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09272e0000>; Tue, 18 Jun 2019 11:02:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:02:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:02:22 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:02:21 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:02:19 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 02/27] PCI: tegra: Handle failure cases in tegra_pcie_power_on()
Date:   Tue, 18 Jun 2019 23:31:41 +0530
Message-ID: <20190618180206.4908-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880942; bh=+sebw7zxu0S4aEH/9UzMVQgZv3VF38vm5V4QBImyLTo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=gWtYF5aF75h8JLZhZXOqy2WEHqeXdXF8AYbu01jD+E7AwDmX26aQO9c8nTwvxlfNx
         PiHYOcGbQYl9o8UXlO785OR1x47aOLNM2kuYB/E9zO9rM3e0yPYSrmyGT853BdOHtc
         REJ3FI+HhJBt/R4UihSmnkLyvGPA0s8I0F9amcC5w+BUXfNzxrCp+j0cQqaDTFnWHf
         xzsXU8ubg+o1i0KDOqAq34vxcKrJMixivytGBiYAFg0+j6kVtnQA2HarUseEqrhQdh
         e3bquDC1Pb37F9CKtoGIRXNf8c8JaONykgRfzcPhoSb44+z9JSx3MBxpQDDcOibdFn
         dqkwzKbtpYfLw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unroll the PCIe power on sequence if any one of the steps fail in
tegra_pcie_power_on().

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5: No change

V4: No change

V3: No change

V2: New patch to handle error cleanup in tegra_pcie_power_on().

 drivers/pci/controller/pci-tegra.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f4f53d092e00..8235d937951b 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1052,7 +1052,7 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 		err = clk_prepare_enable(pcie->pex_clk);
 		if (err) {
 			dev_err(dev, "failed to enable PEX clock: %d\n", err);
-			return err;
+			goto regulator_disable;
 		}
 		reset_control_deassert(pcie->pex_rst);
 	} else {
@@ -1061,7 +1061,7 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 							pcie->pex_rst);
 		if (err) {
 			dev_err(dev, "powerup sequence failed: %d\n", err);
-			return err;
+			goto regulator_disable;
 		}
 	}
 
@@ -1070,24 +1070,40 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	err = clk_prepare_enable(pcie->afi_clk);
 	if (err < 0) {
 		dev_err(dev, "failed to enable AFI clock: %d\n", err);
-		return err;
+		goto powergate;
 	}
 
 	if (soc->has_cml_clk) {
 		err = clk_prepare_enable(pcie->cml_clk);
 		if (err < 0) {
 			dev_err(dev, "failed to enable CML clock: %d\n", err);
-			return err;
+			goto disable_afi_clk;
 		}
 	}
 
 	err = clk_prepare_enable(pcie->pll_e);
 	if (err < 0) {
 		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
-		return err;
+		goto disable_cml_clk;
 	}
 
 	return 0;
+
+disable_cml_clk:
+	if (soc->has_cml_clk)
+		clk_disable_unprepare(pcie->cml_clk);
+disable_afi_clk:
+	clk_disable_unprepare(pcie->afi_clk);
+powergate:
+	reset_control_assert(pcie->afi_rst);
+	reset_control_assert(pcie->pex_rst);
+	clk_disable_unprepare(pcie->pex_clk);
+	if (!dev->pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
+regulator_disable:
+	regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
+
+	return err;
 }
 
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
-- 
2.17.1

