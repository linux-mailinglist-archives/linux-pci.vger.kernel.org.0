Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBC1FF22
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfEPFy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15080 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfb0d0000>; Wed, 15 May 2019 22:54:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:25 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:25 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:22 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 20/28] PCI: tegra: Use legacy IRQ for port service drivers
Date:   Thu, 16 May 2019 11:22:59 +0530
Message-ID: <20190516055307.25737-21-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986061; bh=dPCOd5yuVmrp2ii5aVlnL0dVYLKhSLCb6C4CmS+O4+M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UNzm7PNoNQ/Uj1mM0amLoaFgdTcK2zZ/fLpPeuPWBEZpVjZVxnbCkA5iBbeDgI5u+
         W0oplADffW6W3eacDXEXT1LUT82V6L7QfvcdDBGAF80XELcgQcq5lQR9SZIUEjJnv8
         kzpHubEi3YqlO28DTI7Vl4WH1axfEoS88nLx8CAFts+Mmu7Cn8NOAVnn39+MjuuQ4M
         IV5PA84e7xr9g9DMJ414XDU3H/FvB3TeIHqkg3ycmhDpFaEotx/G9rOvLux7Qb/VPD
         NEIQSU07sibALmbgN/ZX9ejtRQgpgy5vKce1/dj7pgxWQWw7h14VreV1n7OPZx3Pml
         o4f8vhIh54Pgg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra signals PCIe services like AER, PME, etc. over legacy IRQ line.
By default, service drivers register interrupt routine over MSI IRQ line.
Use pcie_pme_disable_msi() function to disable MSI for service drivers.

PME and AER interrupts registered to MSI without this change,
cat /proc/interrupts | grep -i pci
36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif

PME and AER interrupts registered to legacy IRQ with this change,
cat /proc/interrupts | grep -i pci
36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW notif
37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4: No change

V3: Corrected typo in commit log

V2: No change

 drivers/pci/controller/pci-tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index ac57c5badd9b..0024bc42b400 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -41,6 +41,7 @@
 #include <soc/tegra/pmc.h>
 
 #include "../pci.h"
+#include "../pcie/portdrv.h"
 
 #define INT_PCI_MSI_NR (8 * 32)
 
@@ -2725,6 +2726,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		goto put_resources;
 	}
 
+	/* Switch to legacy IRQ for PCIe services like AER, PME*/
+	pcie_pme_disable_msi();
+
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err) {
-- 
2.17.1

