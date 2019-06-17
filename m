Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3641448A58
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfFQRkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17019 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfFQRkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:40:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0770000>; Mon, 17 Jun 2019 10:40:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:40:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Jun 2019 10:40:06 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:05 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:40:02 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 02/27] PCI: tegra: Handle failure cases in tegra_pcie_power_on()
Date:   Mon, 17 Jun 2019 23:09:27 +0530
Message-ID: <20190617173952.29363-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793207; bh=TimfuWd2DF1QodIVKCqBiZpD3olJWXpCC9MHxbQra1U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=gw/O9oMHI7wb0DP9X+x7QqvY6edVW5tNnE0CTfAnhQ8cZ8HALEZ6xQqRHmYk+R+07
         nlsVIw1b7w32/TR3aruj7O4fS+lgSQo4P6lgkmIH9hlVlWXKsKl7jTKad7r/K0gKnX
         T7nz1Tn6YjkVwHz6yqtbM7F6Ky00kQJSc2zwUaFT5gz78DBsuUMOjpZavEaxs7CoDi
         23NbEdOnFhZA10JY92uuBMZIg8QD2twOZDiDIuYQPox1AT/IdVY8jGwJB+r1/us3En
         e1TQ10aEaavx0QnotuSCwi1xuIdlmaHkSOAjHgvc6aR+v7TNv1DTqV15LKSGJeuDO9
         NBT3L3qqFJqaQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unroll the PCIe power on sequence if any one of the steps fail in
tegra_pcie_power_on().

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
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

