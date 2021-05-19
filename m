Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED63893D5
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355207AbhESQfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 12:35:36 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:11265
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347677AbhESQff (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 May 2021 12:35:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbsL+XaHQi9Ay5Aqfh+AUDK2Sc+36wM873ueMnU4sZzaCddHJVdh02ZGYDVCU8RGiakBZRxrjOlf2jJtDx/MrcVVe+mk5aKmUHlGz8MHv2/8zlAt4BC6pnRGp0PLurQTgMHxO1x4DpynCA+hWsLo0QRbLxbMh5WCFQXKkxIcWUmdmb05YzgNap8SWXmNiPsFKUeQ+5mg2RryCQOQUWGFQYL71laQNiAp6YN/1T7MH7HmoihLhihKBh8g3kYLqo/0poNjigCC562AAKLhAo7UlidxB+nkMXOruuPf3XnfgSJx9Dfi30bR7ts+5vg9PGs+ady8JTz/aTbyZUS+WBSmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBR0Z+nF//0JJ+cbwbGGei2dDHOWZSIPf68BYWkGiPg=;
 b=j5OvjYD+GcPJaRRA4AQciTlmcjide7g9BmgKdplnOQ4DCk3LK+V8NvzUPrIIiOtuMx4c5lIqr/SVFRasiuaLA6I1n/5GoMdF2fyhw+1fxFEtxzSOE26/J/7r87VW9F+3r+jhQEeSs1cHRXUsHaId7XRWrPEAaNY60Rx/0HYHdee7Sre/TO7fe3xhl4C67Gm7Ya/j3fNa4WXor+L+5wllH/pMPyGiC5PD6uc9/vnnfHjBrBKzpPI22xtcD222pMkXoBh+zK+WaKT73A1tAW/Os+3pV/Z1B/JbRUumIIG5grGSxDFyk6KRWc7Zcl7bwbo8ghbXi2MZC/3/+qRNAholBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBR0Z+nF//0JJ+cbwbGGei2dDHOWZSIPf68BYWkGiPg=;
 b=QK9g1PhF9Wq+2H1qbMDAL1/jfMWTgHoZFfSSxXadIm/BcEfgxM3kd9RVaAD3YLUnDZbyq23Nyx1L1SAFADEQq/qysyrSE86x5SpP+qUapCD8F3AF6Kd8tOZgrXzkOE5Ym6q0DPsz0OGaxNPWEHF5CpgVe1bFcmBE7gQKUhYjXCJnvoYehBHMSUmGIPNTh7IERTSdWJ2w3HhmJbIiIGALFgj+h3usO+XO1NMoVOoSBpeXS8D2HuXjPyx4R/NoJ89T9xetTnReAonpGcsJFAfvDyp0E8zOLHR/lWbbnAhHZFFpSuB06ZYPDPZoyTpY+WaYC5yv5wQ5rl4ooAjusvpDUw==
Received: from CO2PR05CA0093.namprd05.prod.outlook.com (2603:10b6:104:1::19)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 16:34:14 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::cd) by CO2PR05CA0093.outlook.office365.com
 (2603:10b6:104:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Wed, 19 May 2021 16:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 16:34:13 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 May
 2021 16:34:13 +0000
Received: from moonraker.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 May 2021 09:34:11 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PCI: tegra: Fix building Tegra194 PCIe driver
Date:   Wed, 19 May 2021 17:34:03 +0100
Message-ID: <20210519163403.212362-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d241c94-95d5-47a6-de38-08d91ae3f026
X-MS-TrafficTypeDiagnostic: BL1PR12MB5319:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53198DC513D5029B69C386FFD92B9@BL1PR12MB5319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ug/26Y9ScGHu9i6epYHsrEyPJNTFSdYLM7mLdia7ZwX9CmeaDPk6rTGgwe77dJn8JnXqVNGAPFWxsMoSSlhMbM0wYZQNHBddMm+tqLk+vmLCBRQpszwSGu+ipTLKCyYuAFVIaCgsX1uoBSPF3P9i6QIXh/MSyw8WGqRZpErpKLGtGtJP5n5jg0ELx7Glg8e9hcbUuq6Lhn4SeXbQpAY8+p5apIF6Bujar1zfdKMmgW9f53ahc91aWXt0bSujRidzZ7548JTYXMzTAQ/s7opsTvZ9DNue4dlr+mAViOg1EwktMQlw2hmd+nnzN/iw7Cz3VGsJ33TaAW/Hyx86HGl/dGyMBkfeNk9rhuUG512G1sB0MKg8DaqctWA8TP1tTxwIIZj519xmEL5iYPKAtco5LHNnd0nmMTf23g717pf6WbD2m2uti1vABJ2xuq6j0JetCf0QMxTknhxiGmuCbZ1rocenlx/LzfRp1A0hK3He44w7MAfCxqkS7TpzSqFduV61+hTADDnkFi6CuM7VBqoGEatd5iMqpwbQbTQKuiLPNLQ9Mu6z0N3Ch6Zgb2MKL8ArzqX9wHeKsymRZt27BAXlZDwpujpJfIEE53IRcCk4wkYhp1MS+FClxT0ST8m55VEhNsgE1oq5HYAgc1hKuGnttTMWLtLZVYHyxpQUPesPbs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(316002)(54906003)(7636003)(8676002)(356005)(26005)(5660300002)(83380400001)(36860700001)(36906005)(82310400003)(8936002)(7696005)(107886003)(6636002)(110136005)(82740400003)(47076005)(2616005)(478600001)(336012)(426003)(186003)(70206006)(2906002)(6666004)(70586007)(1076003)(4326008)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:34:13.6374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d241c94-95d5-47a6-de38-08d91ae3f026
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
errata") caused a couple build regressions for the Tegra194 PCIe driver
which are:

1. The Tegra194 PCIe driver can no longer be built as a module. This
   was caused by removing the Makefile entry to build the pcie-tegra.c
   based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
   so that we can build the driver as a module if ACPI support is not
   enabled in the kernel.
2. If CONFIG_PCIE_TEGRA194 is configured to build the driver as a
   module, at the same time that CONFIG_ACPI and CONFIG_PCI_QUIRKS are
   selected to build the driver into the kernel, then the necessary
   functions in the driver to probe and remove the device when booting
   with device-tree and not compiled into to the driver. This prevents
   the PCIe devices being probed when booting with device-tree. Fix this
   by using the IS_ENABLED() macro.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pci/controller/dwc/Makefile        | 1 +
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index eca805c1a023..f0d1e2d8c022 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 # depending on whether ACPI, the DT driver, or both are enabled.
 
 obj-$(CONFIG_PCIE_AL) += pcie-al.o
+obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
 
 ifdef CONFIG_ACPI
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b19775ab134e..8bda1485d0c2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -409,7 +409,7 @@ const struct pci_ecam_ops tegra194_pcie_ops = {
 };
 #endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
 
-#ifdef CONFIG_PCIE_TEGRA194
+#if IS_ENABLED(CONFIG_PCIE_TEGRA194)
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
-- 
2.25.1

