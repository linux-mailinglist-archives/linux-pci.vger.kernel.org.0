Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BF38A085
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhETJCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 05:02:52 -0400
Received: from mail-bn1nam07on2073.outbound.protection.outlook.com ([40.107.212.73]:2007
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230458AbhETJCw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 May 2021 05:02:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6lv5R9n7zF5X24z1CdkbkyovEq/AuCs1R8lK5dag+r98FNEGTppfITY0Sy/DlTTishUjdkIpJr8P4ScZP0rgEk0lX59+ZrqVV6iy6J0Phplm8eT+SHFQkJqmPe22JC5qlu/Bb/416Wp35SWWguM/NNv1j1nykOaHY0pblkiNu9rRN5cnfJMcbUqXc6N90byByguJ9/wwV7y9bYQ1eHKFO9xjCSgqUdZqb7YOhrh41PtLmboBUAcAV2xKaYSqeBazHcIpyu9mBSz7dcgtqKkHvzvYPcprR2BypqZg6aklT/eKP5JJHzLb//Ilr5lTEtzsVYoiR+jAsFrxWMKbpoqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmuAjyIHwS3blbHh52wk7+v7Tpe0U4ZNkqbhstYDktg=;
 b=jC0S67VQD8F8zdWC+i6WetYizy2RsX29VTuPMUVWDkQj4C4ezVQJ7Ms6HsVHZ4uW2uKKpGNheiI3dx9hSGMDE6Uv0vyspJ6xJugdYvxObO1BQrkBqMIzoDNbAsH5v3q8om/Mgar5AtUCxxoHlM0pyfPva8oA4omokbHxJzP4aIYTMUWqYITljheWAB5bUE6rN1bdjaYzS7lkvEKUk45YdWXPBP2BSg47rSQXjq90OTuYEIQE9vMg4X/MrL00GsDR483Iu3lReVCMDLvsWF50/7VlS/25NRaTn2tUSh3j/dCkK9Wz+Yy8qjLPj1VKRECP/KRz/+XsOjICMU/gQyeNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmuAjyIHwS3blbHh52wk7+v7Tpe0U4ZNkqbhstYDktg=;
 b=IVkAe7DpIS5EMuPfvYV7eiQ69f05WGnv2oKDDI9y6Q2b9pJKpH3BVUat6dAy0aSu5rLoWB3LK0g/FUo7Qu+yNBGGpt+9wOy7zuvMipVd+WYttR5wF94WtM7FfRYPOu1P0MeaVxwfr3y1Zoc+UQ6qWu4dTF/MkfRjCPbE4/OFpltw3RTZqVmvHKCXjd5tcJgnDQR7z8FCFDVMzhbt+dWBhaqJoVj/XATChalF/tjMxK7a7XSj7r1vs9vQEVRuKMpzIzSl10xrTvfOTu3GJ6HRJ3IfIkWUce7E5T+h58B3nv9Uy40M7qo7gPXknMvU784gsvRKrLyfPmkIeScd4pC0eQ==
Received: from DM5PR07CA0038.namprd07.prod.outlook.com (2603:10b6:3:16::24) by
 BN8PR12MB3411.namprd12.prod.outlook.com (2603:10b6:408:40::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Thu, 20 May 2021 09:01:29 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::fa) by DM5PR07CA0038.outlook.office365.com
 (2603:10b6:3:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Thu, 20 May 2021 09:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 20 May 2021 09:01:29 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 20 May
 2021 09:01:29 +0000
Received: from moonraker.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 09:01:27 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
Date:   Thu, 20 May 2021 10:01:23 +0100
Message-ID: <20210520090123.11814-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed7ca2b-7ad4-4d5a-feca-08d91b6ddb64
X-MS-TrafficTypeDiagnostic: BN8PR12MB3411:
X-Microsoft-Antispam-PRVS: <BN8PR12MB341183C78DE7561E2171BAE3D92A9@BN8PR12MB3411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNbQ8hf8RVJVB+Ho/Mv/ZaWO8XB/gB7pSETGasnexgERRRR7waExPqAKkqm7w+VYmtmHh3wuksELuSYjbFZzlqQvT9b5zOAKM8Pxa0OinGQctlgtl1QpaGyrUCAWBzl6cX+wYavs/tsNfyqeGZVfuaPwR10+a+BYVCMetBL7OEUDqhLFIvBQIy6dWH52BExYve+S/HV9KQAnmVQHJgV1etak0YCL3Ql81x4CasjjjchxeDAVUiQDL0zGDviSYrr9F3yljorqvaoDkJuYlh85loFeYqLQlv43iUBKciRZQH6Cca9zdBi4EXxMfD4RYgsxYaHRkRIhsGV43Lz+DXesu803Pts4NrMPMOnEuIODXC4nyytI6FTzuAZKnxIo2byDL9qah/q4Y7HHSddco4N5O987b1IT1thE6VsWT/B6WJxLSs0aIxmmZj1kWHh51Yn+h75ocVi6HU7ckAd9UvCC/lVMg2pDc54jh8HZ9e58eUCnXL/BxRZZfvU19/vIzivhAeUaJnFqrbugS16PS4/u7w2I2Gqm4vfJX4czes4Q4axdAboJf/zJqRdi1YU588nAJqLHRxVJlqf5AoAksGyIjmM4uF3JIB9JCnFvPjeQYedHj/1ckmiFdxvNbmw3Rt2SmDQaHmxGlIYdcI5+jZkoY5oISmu99OhJ7LnmZfFWWz4=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(1076003)(4326008)(8676002)(26005)(86362001)(82740400003)(316002)(336012)(7696005)(6666004)(36906005)(107886003)(36756003)(5660300002)(8936002)(47076005)(2616005)(186003)(54906003)(110136005)(36860700001)(478600001)(2906002)(83380400001)(356005)(426003)(82310400003)(70206006)(7636003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 09:01:29.4630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed7ca2b-7ad4-4d5a-feca-08d91b6ddb64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3411
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
errata") caused a few build regressions for the Tegra194 PCIe driver
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
3. The below build warnings to be seen with particular kernel
   configurations. Fix these by adding the necessary guards around these
   variable definitions.

  drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
  	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
  drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
  	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
  drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
  	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]

Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pci/controller/dwc/Makefile        | 1 +
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index b19775ab134e..ae70e53a7826 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -240,13 +240,16 @@
 #define EP_STATE_DISABLED	0
 #define EP_STATE_ENABLED	1
 
+#if IS_ENABLED(CONFIG_PCIE_TEGRA194)
 static const unsigned int pcie_gen_freq[] = {
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
 	GEN3_CORE_CLK_FREQ,
 	GEN4_CORE_CLK_FREQ
 };
+#endif
 
+#if defined(CONFIG_PCIEASPM)
 static const u32 event_cntr_ctrl_offset[] = {
 	0x1d8,
 	0x1a8,
@@ -264,6 +267,7 @@ static const u32 event_cntr_data_offset[] = {
 	0x1c8,
 	0x1dc
 };
+#endif
 
 struct tegra_pcie_dw {
 	struct device *dev;
@@ -409,7 +413,7 @@ const struct pci_ecam_ops tegra194_pcie_ops = {
 };
 #endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
 
-#ifdef CONFIG_PCIE_TEGRA194
+#if IS_ENABLED(CONFIG_PCIE_TEGRA194)
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
-- 
2.25.1

