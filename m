Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A31362167
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244237AbhDPNrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 09:47:53 -0400
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:16064
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235263AbhDPNrw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 09:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJEOzPzqcmCAohG6lFKzMCfiLRft4LavRlDQX4Ci7/5U4TaBZ1pFZqn0CJizhV799LIxUKnrGfXMT2H0sU/LJL3Cu7Kwi3EEbxHfpysF+dBcZe+ybokob/TSdIuYee1bAMh4CDfGY2/4htP3gf9ZtSwtX/NaIp6KWwCAgrYFmCVYOf0wPU40GzygMYm7GtGwxj/oeVkCI/4qX+7nugkbBlHM7evh815C/YG1BY01dUZUCWvr/7jQj88z7xalgauBjpdtEEFPV0bNdBLNDn15Wv/2o48UQMnSKgg2YSHe0EWHd1bLuwzKjCLIydZ1m0jGDTj+qLptlyFTcs1EL5bFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymicH8Acfmb4a1UknWog6XQYd7xdS7dMKgxTdNgcKms=;
 b=GQNSO0dtWUr2Nwh7HTvB/926rgxulw4WQrItb806103Ny0vsfgfke/RAZ4Fk/PCU7WPq207UVvX09fd+k7oN6B8pI4890wgLg8lGdRDks8oLS0ccjm4LfD6Afuogw/gQNSidt5zkbGhEGXjmytHcMvITjOIKT2i7BhdQ9rlR0TGMWz+dfGiBNYlz+5HNyfLXRPxopXuEKOA9HbYqA3Vvu3VfUW8WMsq0E7yGE9UHlDu/5xZH5EYNKERfCS99Xo9lA8GDSeMcjhIRJji8Gfdb1wiqrPtm/NTtofM/7HW41YFvW2HTG7r0LIv6BySTxZnk5VBvcdVU19AWZF+ZEpKvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymicH8Acfmb4a1UknWog6XQYd7xdS7dMKgxTdNgcKms=;
 b=srHXCp2Ms4ilwpkh3QnHK2exhQ4dA6DZ0D3uvre/uYT/Jy5cNzEGRz/3UgFuG4H06UdPevSnZbSavtnCLmSwg+31NSeN8heLq2kRXfqdKwqrIwaMz1iImY1jKMPgvUACyXcENUJZLpvkIxucAxiHYK7V5C9Im7cH6ZgtQxVGurUyFixSKD3jkPsv0SuDOB/oByvheryZNSbwPdZ8/OnfdgFx1i+AWGCp4c1E1W/VvczPAxb7wg3Gr/kKBhrgC/VVsv5H/t2r5UwFWrLBfyceuhaOUiDqAQZhUF19lCeH5VDD4CuAv8owQXu4lMxs/IBh/lO1UcyUwClzf3QZ7EDvog==
Received: from DM3PR03CA0005.namprd03.prod.outlook.com (2603:10b6:0:50::15) by
 CH2PR12MB4645.namprd12.prod.outlook.com (2603:10b6:610:e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22; Fri, 16 Apr 2021 13:47:26 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::e2) by DM3PR03CA0005.outlook.office365.com
 (2603:10b6:0:50::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 13:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 13:47:26 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Apr
 2021 13:47:25 +0000
Received: from vidyas-desktop.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 13:47:22 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <amurray@thegoodpenguin.co.uk>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V4] PCI: Add MCFG quirks for Tegra194 host controllers
Date:   Fri, 16 Apr 2021 19:15:37 +0530
Message-ID: <20210416134537.19474-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110191500.9538-3-vidyas@nvidia.com>
References: <20200110191500.9538-3-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b479b8-ee5c-4ac7-5716-08d900de2bae
X-MS-TrafficTypeDiagnostic: CH2PR12MB4645:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4645B68240D30D20801185D3B84C9@CH2PR12MB4645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tx3Nkqd5hcfQmC3FHxKFwKUocLH413AbOETkQEJbdZO0NiZsrzjH8CAs/9GqL5LDLXhsSYEKmOlDE/XAfIg02n8NFeELIHHMPJveZotw6CARxQ4+aywNq7ytAAXULAD4w2g3NQQA1DMjHjOV+g5O32CQtV/q3kdj6KRv2cuxlIqXxBvCiU/Q95SqPfLbI5hg6COskLpnWKa3Np9vKsaOCvxoZuoOKZI6V66JgEeheJfCOhXLUkqU+Ivzj4HcRvs7ZQPNWfJMiZbnk7VVLWbj2L0odG+OMkwqeXMYMEy+xTkY9Fj5eVxsDLGMKgvmVDIsTIS56MmwHs8BqE9R3cU303MglORBZhIwSM9/RrfMxnZUsAv43DQHFE6U9BFbLHdlQb3LMCucgLe7dFb5oD1HZqZrS2p5nz+mwHr0zQhOV1yoIYMxDsZeOersTGBoSxNYqVgQiR0sH79jo9Y0+WGxwDewBAzXxXxTPgD7MIgbO1oMdtSrtrV/0FmFgJ/cv+Do0wNZNS8E2Uzf6MN9ONfhRBkLR7UzM3zynJSHEZzjfY05yEBxJovqclxas03KGu+ngx5xIZ5fOni+AviwTCM+X3epUl8ip1TVVpJ9dtjVsKhSq3DF/nimbKkrkO8SuZmN+Bgjz3hUst5YYtsRznVKRQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(7636003)(83380400001)(82740400003)(478600001)(2616005)(336012)(8936002)(70206006)(47076005)(2906002)(82310400003)(4326008)(186003)(356005)(6636002)(36756003)(36860700001)(6666004)(54906003)(7416002)(110136005)(36906005)(426003)(26005)(316002)(1076003)(8676002)(86362001)(70586007)(7696005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 13:47:26.4221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b479b8-ee5c-4ac7-5716-08d900de2bae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4645
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
With the current hardware design limitations in place, ECAM can be enabled
only for one controller (C5 controller to be precise) with bus numbers
starting from 160 instead of 0. A different approach is taken to avoid this
abnormal way of enabling ECAM for just one controller but to enable
configuration space access for all the other controllers. In this approach,
ops are added through MCFG quirk mechanism which access the configuration
spaces by dynamically programming iATU (internal AddressTranslation Unit)
to generate respective configuration accesses just like the way it is
done in DesignWare core sub-system.
This issue is specific to Tegra194 and it would be fixed in the future
generations of Tegra SoCs.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Addressed Bjorn's review comments
* Rebased changes on top of Lorenzo's pci/dwc branch

V3:
* Removed MCFG address hardcoding in pci_mcfg.c file
* Started using 'dbi_base' for accessing root port's own config space
* and using 'config_base' for accessing config space of downstream hierarchy

V2:
* Fixed build issues reported by kbuild test bot

 drivers/acpi/pci_mcfg.c                    |   7 ++
 drivers/pci/controller/dwc/Makefile        |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c | 103 +++++++++++++++++++++
 include/linux/pci-ecam.h                   |   1 +
 4 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 95f23acd5b80..53cab975f612 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -116,6 +116,13 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	THUNDER_ECAM_QUIRK(2, 12),
 	THUNDER_ECAM_QUIRK(2, 13),
 
+	{ "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_ops},
+
 #define XGENE_V1_ECAM_MCFG(rev, seg) \
 	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
 		&xgene_v1_pcie_ecam_ops }
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 625f6aaeb5b8..2da826ef18ac 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 obj-$(CONFIG_PCI_MESON) += pci-meson.o
-obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 
@@ -35,4 +34,5 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 ifdef CONFIG_PCI
 obj-$(CONFIG_ARM64) += pcie-al.o
 obj-$(CONFIG_ARM64) += pcie-hisi.o
+obj-$(CONFIG_ARM64) += pcie-tegra194.o
 endif
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6fa216e52d14..cb38e94a3033 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -22,6 +22,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -311,6 +313,104 @@ struct tegra_pcie_dw_of_data {
 	enum dw_pcie_device_mode mode;
 };
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
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
+#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
+
+#ifdef CONFIG_PCIE_TEGRA194
+
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
 	return container_of(pci, struct tegra_pcie_dw, pci);
@@ -2311,3 +2411,6 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
 MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
 MODULE_LICENSE("GPL v2");
+
+#endif /* CONFIG_PCIE_TEGRA194 */
+
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 65d3d83015c3..fbdadd4d8377 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -85,6 +85,7 @@ extern const struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
 extern const struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
 extern const struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
 extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
+extern const struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
 #endif
 
 #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
-- 
2.17.1

