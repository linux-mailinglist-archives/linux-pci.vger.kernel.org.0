Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7710C3A249F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 08:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFJGnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 02:43:42 -0400
Received: from mail-bn8nam08on2068.outbound.protection.outlook.com ([40.107.100.68]:23328
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229865AbhFJGnj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 02:43:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvPlEFr/usfStpAUm/aHlC4FEMzbYzcS3AUAQTZBeECXyi9br1FgXn5VgNLHua9l1liER0YRkWd6cc3I++ADR0I7Taluw/hABjsTf1NQCgcyFrFNSayLFEul4HlXE8wMt4g1W0puhlPKsybLpWZZJ47iTkMp/n6xsn+miARgwykhSOjjY1KgVLIhYHhk7wm2GaPTiEan17mfEej+/9R+Y4JNMdhJAGpSdi1uH9rhScptkBRfRCiX8KLL0LFhzaYvA+HSeV4Cvd+MNhAncJDdLmbhJMe0D3eZOIWOv1stn333duECoLbsV42sRwfXVb6SpbZJl3qWZqZHjILzclRWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6lTNrdtFoQk1wKm9Tvevpmvi/B0dF481In1Q16M0rs=;
 b=O2Oh2cySqYNEiPqptme0RG9r8ANFoShX34rAxyY5RhyaWY01rVZTkLvOJLqs3AKZtYKVmCmtLd5/M7mAFVZs1FMhb0b63/1XQ3d9riUaO2Q0VGH9aD91RJz9MA2fzLVFJs0c6mXdZ3T8kc9le0k4LO5juyt5U+tBu09h+4BqoQf1nwi9FiItX7sBQuXJ677zfPH5cIvrwrV7nqKzlcHj1mEG3Ufal/KQoa633BkxYkdnR2ruKgzvdCm4wf53MNA6N+9wskSgZlt9IrkCEGE7jxcEGf4vF/a1RHjtsqSdB94+GuFXiiqaDcgtZ8DmKaJBJ+LuXTTS9naI063m6oTbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6lTNrdtFoQk1wKm9Tvevpmvi/B0dF481In1Q16M0rs=;
 b=QQcflfa6kCT0TAftX4b0Y+Pi2pYJ4Ppfv4a6othw9QkIaWTqg6YTP4GHvhOnl9kYT1dHacaoOh3SntKblBoFXK46pQLw3ajax/KG36/73cX4CW5WIcMqW1QZJPRIxf88a9trjGXEJ2yRgoROQqRdtn3ek0tYCguWlcdqEELkOKVcDPDDGD/vX0EaF16rjYPopZ8RziTpPPhFMgIXT7d0MeaCbecrYA3cKhF/Pipmqlay7Am67Z7rHpAYal+WBIjTsITRY0HiMLC7q48x4gGrPPUqs+ZYGrAdtwnAJxgGZ3n8hGhLdczyX2YXzgBahU9g3Qg38p8UkWPwQ0+SE4rAyw==
Received: from BN6PR16CA0003.namprd16.prod.outlook.com (2603:10b6:404:f5::13)
 by BYAPR12MB3623.namprd12.prod.outlook.com (2603:10b6:a03:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Thu, 10 Jun
 2021 06:41:41 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::3) by BN6PR16CA0003.outlook.office365.com
 (2603:10b6:404:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 06:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 06:41:41 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 06:41:40 +0000
Received: from moonraker.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Jun 2021 06:41:38 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4] PCI: tegra: Fix building Tegra194 PCIe driver
Date:   Thu, 10 Jun 2021 07:41:34 +0100
Message-ID: <20210610064134.336781-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95e4fb02-f953-4ba5-e0ab-08d92bdace5d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3623:
X-Microsoft-Antispam-PRVS: <BYAPR12MB36233708F63C95499EE2A9FDD9359@BYAPR12MB3623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+VR5KE7MVcAivnXtU6XrcCCMGfLepaZzgKtFLqv1sKxZDFKiVjJPZbiINN2n1md5JFistS9soSTItn9X7GXgugBlH1QTDSI3vYk/GT4ZIQOtMf0gRntX4g/xb8yeJhaLGrWvsZC0xnOYiDdmK/RXFP5VrasHz8ELQMpgcASE4H1PSZAmtXNsOpCpaiOihW4evbpioSXf7macqzRPWtNEBAso8f1HRL/S9s91kXu+8r0PVEa6oWF0U7r0K4O95Vcs8InSU3ANHjbEGR3YyFNJpR21SJUFMQuGn5+vOwJFcffamiOStb7vQIoy40HbjC/WtOOzzGw9nHZDrlpZmVOjoLQIQV3b8lzHH4l2fuopS+6Qu5hPhV2BvVDB1Q0gS2U1WFg+N9zmx2p4cklEGRoJ9+Qeuh7jNv0P0/BjBRMm/g1e3NJNh5JxEWTRqHxYK9xiE7HwnlEnMDxdx9EtzwbOxstKmLbIoK3Qva6DugYcA5dBzyLRf03dJaLhFyllaGn4US1ABQjQJs08PULQHZV3NZPJL3C7Ze2ccsDKSFd7RLnvbEhkFuyo6V6YPOAll0p09sDo7sz5RQvK+hbpGNoy/tcJhcRG+6nqbd3vVKFYZ4ggv/9IJ27kD2hOMHlvTv0iUBNYS7i7NEDZIXr8QkTt8/TZNqz4tieVVKjnHlac5c=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(36840700001)(46966006)(2616005)(186003)(86362001)(4326008)(70586007)(2906002)(47076005)(478600001)(1076003)(54906003)(26005)(70206006)(6666004)(316002)(36860700001)(30864003)(36906005)(82310400003)(336012)(107886003)(82740400003)(7696005)(8936002)(426003)(36756003)(83380400001)(356005)(110136005)(7636003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 06:41:41.2350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e4fb02-f953-4ba5-e0ab-08d92bdace5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3623
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
errata") caused a few build regressions for the Tegra194 PCIe driver
which are:

1. The Tegra194 PCIe driver can no longer be built as a module. This
   was caused by removing the Makefile entry to build the pcie-tegra.c
   based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
   so that we can build the driver as a module.
2. 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
   errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
   driver. But if we set CONFIG_PCIE_TEGRA194=m to build the driver as a
   module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
   (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the
   driver. Given that the ACPI quirk code for Tegra194 is completely
   independent of the native Tegra194 PCIe driver, move this code into
   its own file so that it can be built independently and we can remove
   the "#ifdef CONFIG_PCIE_TEGRA194" in the native driver. Note that
   given the native Tegra194 PCIe driver is only used with device-tree,
   this will not cause any conflicts.
3. The below build warnings to be seen with particular kernel
   configurations. Fix these by moving these structure definitions to
   within the necessary guards.

  drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
  	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
  drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
  	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
  drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
  	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]

Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V3:
- Moved ACPI quirk code into separate source file

Changes since V2:
- Update the commit message per Bjorn's feedback
- Moved the structure definitions within the necessary guards as opposed
  to wrapping the existing defintions with the appropriate guards.

Changes since V1:
- Added fixes tag
- Fixed 'defined but not used' compiler warnings

 drivers/pci/controller/dwc/Makefile           |   3 +-
 .../pci/controller/dwc/pcie-tegra194-acpi.c   | 108 ++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 138 +++---------------
 3 files changed, 128 insertions(+), 121 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-tegra194-acpi.c

diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index eca805c1a023..9e6ce0dc2f53 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 obj-$(CONFIG_PCI_MESON) += pci-meson.o
+obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 
@@ -38,6 +39,6 @@ ifdef CONFIG_ACPI
 ifdef CONFIG_PCI_QUIRKS
 obj-$(CONFIG_ARM64) += pcie-al.o
 obj-$(CONFIG_ARM64) += pcie-hisi.o
-obj-$(CONFIG_ARM64) += pcie-tegra194.o
+obj-$(CONFIG_ARM64) += pcie-tegra194-acpi.o
 endif
 endif
diff --git a/drivers/pci/controller/dwc/pcie-tegra194-acpi.c b/drivers/pci/controller/dwc/pcie-tegra194-acpi.c
new file mode 100644
index 000000000000..c2de6ed4d86f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-tegra194-acpi.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ACPI quirks for Tegra194 PCIe host controller
+ *
+ * Copyright (C) 2021 NVIDIA Corporation.
+ *
+ * Author: Vidya Sagar <vidyas@nvidia.com>
+ */
+
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
+
+#include "pcie-designware.h"
+
+struct tegra194_pcie_ecam  {
+	void __iomem *config_base;
+	void __iomem *iatu_base;
+	void __iomem *dbi_base;
+};
+
+static int tegra194_acpi_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct tegra194_pcie_ecam *pcie_ecam;
+
+	pcie_ecam = devm_kzalloc(dev, sizeof(*pcie_ecam), GFP_KERNEL);
+	if (!pcie_ecam)
+		return -ENOMEM;
+
+	pcie_ecam->config_base = cfg->win;
+	pcie_ecam->iatu_base = cfg->win + SZ_256K;
+	pcie_ecam->dbi_base = cfg->win + SZ_512K;
+	cfg->priv = pcie_ecam;
+
+	return 0;
+}
+
+static void atu_reg_write(struct tegra194_pcie_ecam *pcie_ecam, int index,
+			  u32 val, u32 reg)
+{
+	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
+
+	writel(val, pcie_ecam->iatu_base + offset + reg);
+}
+
+static void program_outbound_atu(struct tegra194_pcie_ecam *pcie_ecam,
+				 int index, int type, u64 cpu_addr,
+				 u64 pci_addr, u64 size)
+{
+	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr),
+		      PCIE_ATU_LOWER_BASE);
+	atu_reg_write(pcie_ecam, index, upper_32_bits(cpu_addr),
+		      PCIE_ATU_UPPER_BASE);
+	atu_reg_write(pcie_ecam, index, lower_32_bits(pci_addr),
+		      PCIE_ATU_LOWER_TARGET);
+	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr + size - 1),
+		      PCIE_ATU_LIMIT);
+	atu_reg_write(pcie_ecam, index, upper_32_bits(pci_addr),
+		      PCIE_ATU_UPPER_TARGET);
+	atu_reg_write(pcie_ecam, index, type, PCIE_ATU_CR1);
+	atu_reg_write(pcie_ecam, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+}
+
+static void __iomem *tegra194_map_bus(struct pci_bus *bus,
+				      unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct tegra194_pcie_ecam *pcie_ecam = cfg->priv;
+	u32 busdev;
+	int type;
+
+	if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
+		return NULL;
+
+	if (bus->number == cfg->busr.start) {
+		if (PCI_SLOT(devfn) == 0)
+			return pcie_ecam->dbi_base + where;
+		else
+			return NULL;
+	}
+
+	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
+		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
+
+	if (bus->parent->number == cfg->busr.start) {
+		if (PCI_SLOT(devfn) == 0)
+			type = PCIE_ATU_TYPE_CFG0;
+		else
+			return NULL;
+	} else {
+		type = PCIE_ATU_TYPE_CFG1;
+	}
+
+	program_outbound_atu(pcie_ecam, 0, type, cfg->res.start, busdev,
+			     SZ_256K);
+
+	return pcie_ecam->config_base + where;
+}
+
+const struct pci_ecam_ops tegra194_pcie_ops = {
+	.init		= tegra194_acpi_init,
+	.pci_ops	= {
+		.map_bus	= tegra194_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b19775ab134e..fa6b12cfc043 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -22,8 +22,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
-#include <linux/pci-acpi.h>
-#include <linux/pci-ecam.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -247,24 +245,6 @@ static const unsigned int pcie_gen_freq[] = {
 	GEN4_CORE_CLK_FREQ
 };
 
-static const u32 event_cntr_ctrl_offset[] = {
-	0x1d8,
-	0x1a8,
-	0x1a8,
-	0x1a8,
-	0x1c4,
-	0x1d8
-};
-
-static const u32 event_cntr_data_offset[] = {
-	0x1dc,
-	0x1ac,
-	0x1ac,
-	0x1ac,
-	0x1c8,
-	0x1dc
-};
-
 struct tegra_pcie_dw {
 	struct device *dev;
 	struct resource *appl_res;
@@ -313,104 +293,6 @@ struct tegra_pcie_dw_of_data {
 	enum dw_pcie_device_mode mode;
 };
 
-#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
-struct tegra194_pcie_ecam  {
-	void __iomem *config_base;
-	void __iomem *iatu_base;
-	void __iomem *dbi_base;
-};
-
-static int tegra194_acpi_init(struct pci_config_window *cfg)
-{
-	struct device *dev = cfg->parent;
-	struct tegra194_pcie_ecam *pcie_ecam;
-
-	pcie_ecam = devm_kzalloc(dev, sizeof(*pcie_ecam), GFP_KERNEL);
-	if (!pcie_ecam)
-		return -ENOMEM;
-
-	pcie_ecam->config_base = cfg->win;
-	pcie_ecam->iatu_base = cfg->win + SZ_256K;
-	pcie_ecam->dbi_base = cfg->win + SZ_512K;
-	cfg->priv = pcie_ecam;
-
-	return 0;
-}
-
-static void atu_reg_write(struct tegra194_pcie_ecam *pcie_ecam, int index,
-			  u32 val, u32 reg)
-{
-	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
-
-	writel(val, pcie_ecam->iatu_base + offset + reg);
-}
-
-static void program_outbound_atu(struct tegra194_pcie_ecam *pcie_ecam,
-				 int index, int type, u64 cpu_addr,
-				 u64 pci_addr, u64 size)
-{
-	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr),
-		      PCIE_ATU_LOWER_BASE);
-	atu_reg_write(pcie_ecam, index, upper_32_bits(cpu_addr),
-		      PCIE_ATU_UPPER_BASE);
-	atu_reg_write(pcie_ecam, index, lower_32_bits(pci_addr),
-		      PCIE_ATU_LOWER_TARGET);
-	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr + size - 1),
-		      PCIE_ATU_LIMIT);
-	atu_reg_write(pcie_ecam, index, upper_32_bits(pci_addr),
-		      PCIE_ATU_UPPER_TARGET);
-	atu_reg_write(pcie_ecam, index, type, PCIE_ATU_CR1);
-	atu_reg_write(pcie_ecam, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-}
-
-static void __iomem *tegra194_map_bus(struct pci_bus *bus,
-				      unsigned int devfn, int where)
-{
-	struct pci_config_window *cfg = bus->sysdata;
-	struct tegra194_pcie_ecam *pcie_ecam = cfg->priv;
-	u32 busdev;
-	int type;
-
-	if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
-		return NULL;
-
-	if (bus->number == cfg->busr.start) {
-		if (PCI_SLOT(devfn) == 0)
-			return pcie_ecam->dbi_base + where;
-		else
-			return NULL;
-	}
-
-	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
-		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
-
-	if (bus->parent->number == cfg->busr.start) {
-		if (PCI_SLOT(devfn) == 0)
-			type = PCIE_ATU_TYPE_CFG0;
-		else
-			return NULL;
-	} else {
-		type = PCIE_ATU_TYPE_CFG1;
-	}
-
-	program_outbound_atu(pcie_ecam, 0, type, cfg->res.start, busdev,
-			     SZ_256K);
-
-	return pcie_ecam->config_base + where;
-}
-
-const struct pci_ecam_ops tegra194_pcie_ops = {
-	.init		= tegra194_acpi_init,
-	.pci_ops	= {
-		.map_bus	= tegra194_map_bus,
-		.read		= pci_generic_config_read,
-		.write		= pci_generic_config_write,
-	}
-};
-#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
-
-#ifdef CONFIG_PCIE_TEGRA194
-
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
 	return container_of(pci, struct tegra_pcie_dw, pci);
@@ -694,6 +576,24 @@ static struct pci_ops tegra_pci_ops = {
 };
 
 #if defined(CONFIG_PCIEASPM)
+static const u32 event_cntr_ctrl_offset[] = {
+	0x1d8,
+	0x1a8,
+	0x1a8,
+	0x1a8,
+	0x1c4,
+	0x1d8
+};
+
+static const u32 event_cntr_data_offset[] = {
+	0x1dc,
+	0x1ac,
+	0x1ac,
+	0x1ac,
+	0x1c8,
+	0x1dc
+};
+
 static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
 {
 	u32 val;
@@ -2413,5 +2313,3 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
 MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
 MODULE_LICENSE("GPL v2");
-
-#endif /* CONFIG_PCIE_TEGRA194 */
-- 
2.25.1

