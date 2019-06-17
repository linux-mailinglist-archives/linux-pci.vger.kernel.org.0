Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8BE48A94
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfFQRlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:41:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11975 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:41:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0b20000>; Mon, 17 Jun 2019 10:41:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:41:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:41:06 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:41:05 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:41:02 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 20/27] PCI: tegra: Use legacy IRQ for port service drivers
Date:   Mon, 17 Jun 2019 23:09:45 +0530
Message-ID: <20190617173952.29363-21-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793266; bh=uQA58VgzPjv8dLYgIVATUmvyuU1Nsi/P78Ei6Om+4ZA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=lSfPP6xizg1rWhXmcWsFuLgAS0GFImR+bLaUqo9wQLMvNZIVa50RdNAcSi+BM2+HP
         OXBCGNuPDJm1o3byDtjei7Iyx7FU2c15rFxbXYSbE9Kh6JVrEjMIj+qfctbBfoYZmP
         SjtPCtN7y7LE0L4uR2Qli5zU8BZ9eWEPa8okl8K7PsnuglXpuxBLYEJ2NvaWXPpKj0
         18UwB3xzWpWo1XhnK+psoRzSSFvDGsJ0rkoln0pFpWG47a1gYxCBO1RAoXJa8STy4z
         iExEzR1yWBe183ppx/torn+rKk/rrIN3hGbyxtGlcH43pe4l9xecpRnrcK+8fyEzNc
         sVA1l83zKXi0A==
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
V5: No change

V4: No change

V3: Corrected typo in commit log

V2: No change

 drivers/pci/controller/pci-tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 73d5a8841405..9429c0c6a1f3 100644
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

