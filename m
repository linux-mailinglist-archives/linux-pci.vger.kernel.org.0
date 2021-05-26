Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE6391760
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhEZMfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 08:35:22 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:31040
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233186AbhEZMfV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 08:35:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9cWjtvNJp/M6pcq/e38DjnrZgyRw/SKOT852KuhBQAqG31uK5YweHD9kBeUINk1E3pKldyPNLJ1eufco77eAKxu7oSsM/N6CO7LKDEgYjT4ET4VhJQZSmo2IViC+wrM3YrpmjrvucQsRKI0jmRRDSJ6/d7JlwQ9vWK3R1k2f3s57gEySpb53cR0GssMuUpMJ6gviK7UQnjFwh4S0tkMJkBmVzDFRk4ylE3BIG3/f+2B76Wve9Q1b+wgGglmUfYnSMJp2ENKi/39DVk/7gAplIlGFTsf9hcTUuGjswsnlYp3I3PGUfiCdFt4KigGPmIz9zxO4Yo19jwCIdWLd07KXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ykn/l3Ft4YVe4vNkjB6O5lfvNnpz2kKH1zA7sPFxXpk=;
 b=ShV+SopRbF5nSy9PKsARYypvx2OvwE1r/FVF0aqJFCybuh4w9mfM+qYThjsMfh//wOsRLyZLQmjk2NEhB64VZCY2SnkGnNF2t0j+0SOwseD4VOEv+zh7EoAotJyqpAZwWunjLEIvXVhTnTxgDLriMRsWJps/mtj+ziXPvsmZPODBg/3qRNVHuoej2YuSEygk3fK3jbwVP7yzZ/52kHeiDQyeF8QMyuYntA1oxXoWQLhGrsrP63T9fXBULC3xvHQtZYib00Ymb08t/WqWNGb+3n+JLcNvrdT+Q/mo0Gj4v4B7VLg9mpWd4LJChDOTiiDGjQp8zoPW1KtCnT6mdVHN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ykn/l3Ft4YVe4vNkjB6O5lfvNnpz2kKH1zA7sPFxXpk=;
 b=K47qtbeoj+ZzK7l3BkRacAccH/6sPrd8w7wMgxEl+3gxvbJ+rjv6iyAFp0K6Zfx0RE8yXFXVGJ0h/OW9fPvG7aoFK1bdnDQPpflWq+n4ykfdBcdK1HAD70hrN9uUqLOycmeHHU+3eTTQ3KsBq9EsUR8DAbeZOUxDtbRTZqX6XrXb3FdHoMZL2I/8T/gJbep5knPYSGYkNIYfGH2hvuYDBzH2prRA2Qo15ipwTltgfndY4Bchpyj/fzAmRSAaCPvic5HJ/QbauFMQR7QB3gGk1q6nFJQOJ8m2F00dJQ6fYP0bacovK9pL8sqL6DDKFl6tSSpDRPYG5bjTPAY5DH6vKA==
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by CY4PR1201MB2517.namprd12.prod.outlook.com (2603:10b6:903:da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 12:33:47 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::a2) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 12:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 12:33:46 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 12:33:46 +0000
Received: from moonraker.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 12:33:44 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3] PCI: tegra: Fix building Tegra194 PCIe driver
Date:   Wed, 26 May 2021 13:33:22 +0100
Message-ID: <20210526123322.340957-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1931e967-6626-4437-312e-08d9204281e5
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2517:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2517743D51B0E6975C695B45D9249@CY4PR1201MB2517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rd4C2TKYzm6B4cTSmHgb7cdHigB40uzB+aZ+M0Rh+vvzYcwXjN6hj5l3XfF6orJpDsiH/CkCj7DOmOhJ939hvZa7i00Ptq0K8xdX+tSQEtm4Y69XFA1tLjkJLK3lC2YmjVmSrz/IIDY/DoMFsguPwK4jCUQes0my0ipnJCL2/YMh7FXEgjmQAa/oQYhmxDXQJGYGye6cKNvBCdhVqdnc05fhmrQPbnR+QyQpso3kJ4cT+BXfvb68K1szCKKPE1EKfSIDJnn86uYn5lptBXVjlPuqQ0iEAk7QDZGQfoE7ZC7c/ruNQFSTAnFuqyajjBSNA67q7dykxLnglh8M4aB0FeCv04YcQqZoEOYLofdQ9RwNn4CVpiOtyop4B/AbGWd5nHyV2yE0Biywo5v5XjKFsFPeiCBhnuxK/Kxmi42sJWxxBb3RiSp1pcbXmHGA+Lbdt0F9UjCL7BqlMNnBBot/ja83Xm/rWEmRkV/Bzu96rmyf6/ratTUbzwtRr4XnGtZuT4l2Y4g0hpPyDu/1laUd2RjjJS7/p+xzUZEvPbCJfEWHhiXZ4DgYcmcYVHC45CoSgZgf/Dsbo0IIjPbeGKlduNxoXIksoUpvPhlSnSSp2XKAO/aoKk3Kprgs+v9d7eiS6dY367yaHdfSqC0SWbgJ+h8gcaK/oesc1G3ZLY9Fhk8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(336012)(1076003)(82740400003)(8936002)(478600001)(36906005)(110136005)(2906002)(83380400001)(4326008)(8676002)(426003)(26005)(6666004)(70586007)(36756003)(70206006)(2616005)(316002)(107886003)(7636003)(186003)(5660300002)(47076005)(356005)(54906003)(86362001)(7696005)(36860700001)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 12:33:46.6998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1931e967-6626-4437-312e-08d9204281e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2517
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
   driver. Instead, use "IS_ENABLED(CONFIG_PCIE_TEGRA194)", which checks
   for either CONFIG_PCIE_TEGRA194 or CONFIG_PCIE_TEGRA194_MODULE.
3. The below build warnings that are seen with particular kernel
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
Changes since V2:
- Update the commit message per Bjorn's feedback
- Moved the structure definitions within the necessary guards as opposed
  to wrapping the existing defintions with the appropriate guards.

Changes since V1:
- Added fixes tag
- Fixed 'defined but not used' compiler warnings

 drivers/pci/controller/dwc/Makefile        |  1 +
 drivers/pci/controller/dwc/pcie-tegra194.c | 51 +++++++++++-----------
 2 files changed, 26 insertions(+), 26 deletions(-)

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
index b19775ab134e..9b3758ea1cba 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -240,31 +240,6 @@
 #define EP_STATE_DISABLED	0
 #define EP_STATE_ENABLED	1
 
-static const unsigned int pcie_gen_freq[] = {
-	GEN1_CORE_CLK_FREQ,
-	GEN2_CORE_CLK_FREQ,
-	GEN3_CORE_CLK_FREQ,
-	GEN4_CORE_CLK_FREQ
-};
-
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
@@ -409,7 +384,13 @@ const struct pci_ecam_ops tegra194_pcie_ops = {
 };
 #endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
 
-#ifdef CONFIG_PCIE_TEGRA194
+#if IS_ENABLED(CONFIG_PCIE_TEGRA194)
+static const unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,
+	GEN2_CORE_CLK_FREQ,
+	GEN3_CORE_CLK_FREQ,
+	GEN4_CORE_CLK_FREQ
+};
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
@@ -694,6 +675,24 @@ static struct pci_ops tegra_pci_ops = {
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
-- 
2.25.1

