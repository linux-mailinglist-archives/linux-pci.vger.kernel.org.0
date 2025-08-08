Return-Path: <linux-pci+bounces-33607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC00B1E384
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6B7A022C7
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802E274FCD;
	Fri,  8 Aug 2025 07:29:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022133.outbound.protection.outlook.com [52.101.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12A23BCF3;
	Fri,  8 Aug 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638183; cv=fail; b=RqAJG2QdIIWqhHPWh5O9y4YvzNRSl8Dv47YQ4OtKHid/5JY3zX5U6sppA65EjaLwTSRPGl9jJj3D6kRYuI2NmbWFvDnljQyAB4TPWGToS0TqDMymuuoR2gZtppaqUEdVKlnHmJ1byMWOjJwUrzMC6Renokw1VtSo8CHW6qwjS+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638183; c=relaxed/simple;
	bh=n+p5K9xZBkIg0LprP+KO3+LWcRCWNTVMpKGnakFLFa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5uGxViO4WvpF3QJwOjWCPLGpDcJiFYBkNGrHIODWeQd/vN1XHZnn43dUdJNmc0B7EESjxLzH4O114xplFrhwDOCZNKdEc4Azes57bdaztx8SaB3QATU7xzORqJul2xx1PdbI99xA/meK9JSKtNS6VWEQrk8nMYZNIYcGYQV/v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnppBnlTPvmblon4Su8oRp+gJzVN/JL3KaXLggjXg0pTRbK3966LZBHftaDn2vvsDJqNP6XBHh/sBXyfjOJUCmNVOoWPEoK32nIlpTSSzKhMRnQm8OzyA4cj8uSEnaRWkNeRjrSNc1ZMw0rMv9O7MHOw+2p9vrShy5NW6sUALNTrthHSnOQ8N4vhifyhO7oj11/PMzKUyIYUfIk28LMXkTaXCXs0y4bGgnboHKh5eEQPu/XU0AIeUemzBZsiXn7lntPZbPtFP1SfiFDMUmbkMo7mFKN2aAIzNbw9knWckzhg5X4wIrqsNGAfQgnGb2JlrrMerh6X+1bCuB23VYdGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOYyEUsbYuZACLAgTS1s/upq1lcvPWv9zXckizdwNwY=;
 b=BJGozPwKwZEmxKtzfj37KNozNt5afzCUHQmkAq2zlcMaaPnzJ8a8+GZbPA8t030AH+37nDBlRVh7ErqZTMnM+W5j3io7OYiCD1Id3ZrHjY9wbdOuIs14Jl8EUs+5TOTcNIhGmqoOq2NOdrVi9SX/SXxITW9KVqQh/SSNugG8RVsSblrzVvx7/Uuo8zz9gHhUL96gLdDlIG+SM4YZi7IQECKdiQvRF7vOUkl4NDYPBM4+Ax301emZ1h3X27UXKOczCyUGIPiUem9HP/jxWszy7YKUX5dlZUqA3pwCVd0MJRwTZ0WPERNCTIzaiQ5Z5o+3Th3gWLDc1DTArNeLhmcSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27) by
 PS1PPF3AA5DA295.apcprd06.prod.outlook.com (2603:1096:308::24b) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Fri, 8 Aug 2025 07:29:37 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:b8:cafe::ea) by SGXP274CA0015.outlook.office365.com
 (2603:1096:4:b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 07:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:36 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 912714160508;
	Fri,  8 Aug 2025 15:29:31 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v6 09/12] PCI: sky1: Add PCIe host support for CIX Sky1
Date: Fri,  8 Aug 2025 15:29:26 +0800
Message-ID: <20250808072929.4090694-10-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808072929.4090694-1-hans.zhang@cixtech.com>
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|PS1PPF3AA5DA295:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f6dab27-c15a-45a2-35e2-08ddd64d53c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XrAP3hfsRjeLLWDxOQwo74dPKFLEO/czC8ZHuu36NLO7Sr1GezmgneBNdA8n?=
 =?us-ascii?Q?9owNG0bJyRRV4HaZFxdu7CKhgymxSCFbCu6ElxcWKFH6FOLbFmfbx9OWmlRf?=
 =?us-ascii?Q?ziG1JpxEJFG5o6PXS9Ed4Aol81IHi/ZZ9S563Ve6dIFTBI76x+VE1iOr+rgG?=
 =?us-ascii?Q?2XoJlgSzR7SAqf6GpFcGht/1DWNtJ0+UgaYy9yup2jicesazHuqon4V9uppE?=
 =?us-ascii?Q?JzKDHtVQtIOL485V/FgfKornCyxz+OuvdnaFD1onSMjeQCeiGGNL0nV6nxYv?=
 =?us-ascii?Q?Lq0Sni4vXj67FpuDqlS8BMf5QBP3pTHIvJjjsxF/yDPg7FS65UfYqUPiBh5t?=
 =?us-ascii?Q?T7sjdSmdDIbW5OVEl6YhNctJh7lFFwcTAd2ucPlD3nOfs3aqdpKp4jt0X6w7?=
 =?us-ascii?Q?8tgfHmPQsK05s80p0BaibuoKakRuLYOTzGqAn/y4FPkYdi7jieANrgeNCHq2?=
 =?us-ascii?Q?MV15mUDZoryjZqpJKZ9jj37O8m2bLCAFN7Eu54ADYFrYXgPKXNttJsRQWdqh?=
 =?us-ascii?Q?2Da3p2IgM+KJO0O0bhxE3X6uvelIDODT50qCd34l4ZQR7A2fYA9LQMVAYbbI?=
 =?us-ascii?Q?8fZ8gEd0OUg8vuuxLT2W1EvKW+Mw9TeFz+hJpTaymoPkN4rnfohB6qa1vR0b?=
 =?us-ascii?Q?s4PbcFLD+BUnlhmRgZCg7+KztsN6BKYESpko56YGhmrRbqM++UnZumj4VvFq?=
 =?us-ascii?Q?niXST8hEy2FC/RsV96AHwaG6OynQKkLmpdTSdkpTXwDP7lzrY3Wvpg0kFbbv?=
 =?us-ascii?Q?CleC5vcCvBLsRxC9bV6UKw2hlNgayl3BPAiF2kmkdT6HUmkSRAA8h8WVqW0n?=
 =?us-ascii?Q?xBtE2QUiOxFZgKyh2UZaWC5WkvTXtXhH3lufiNsza9I+vkBjUHgeTrOAQ7d4?=
 =?us-ascii?Q?l1O+QJ5/6sm5/qbqCpBG7aePWIJ6WdGaa1tjHtTJryxKnHx/sc+wVa8h4C0v?=
 =?us-ascii?Q?eJdn++Ubiao24mGoMetRYFjBhqgtVrLW5Zhh4MZRTs3Vz2Rvoj62dnyLetvS?=
 =?us-ascii?Q?FoZkFxmhCJGzD5GH9+FcLKah88ShAvLxBT53oTld9UdPPAzKI+7oI+uetr93?=
 =?us-ascii?Q?rjvDf7MqIPcFsdKR+M2YdEfV4+2EVgzal0YpWGjSlhlcQf+6VE5pQnPj1mXP?=
 =?us-ascii?Q?HH3IkQV0tZD2yKeV16jKC5YjIT0YQB/pgbr8kOKuHM9Pt2nfzkp8T8FTP816?=
 =?us-ascii?Q?JUu4FBjb9/p5gbDQRiRsIp0h8SiC3OashQUXJ+1Kew9mKoWwFMqP3fBMQP1h?=
 =?us-ascii?Q?BRGvjJh6FZ5mqgfD3CYN565f6cPoqW6GmWJv4moTc8pd4RaKT/92kM2695ar?=
 =?us-ascii?Q?7GO87mz5WiOusSwugykNooJhLI5ezphYRXrOmnpb81KI7CzfFyYQr4BHdykJ?=
 =?us-ascii?Q?mfXpCP700pmcOYvmOcdNV14x3XpDdNQDTijz+S4blxWkQRnTPjjGTd+8kdfy?=
 =?us-ascii?Q?4B/VDMWPfOrx+TvoA6/dPZK0du58T+gj7IGkhxbCIu1Ca7Qtn814MtdZrkR5?=
 =?us-ascii?Q?AOdifRpabpf8qR2WSKBjJkQTGL+0r7yfkjp/?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:36.0933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6dab27-c15a-45a2-35e2-08ddd64d53c6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF3AA5DA295

From: Hans Zhang <hans.zhang@cixtech.com>

Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
on the Cadence PCIe core.

Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig    |  12 +
 drivers/pci/controller/cadence/Makefile   |   1 +
 drivers/pci/controller/cadence/pci-sky1.c | 292 ++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index a1caf154888d..be52f31c5371 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -75,4 +75,16 @@ config PCI_J721E_EP
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
 	  core.
+
+config PCI_SKY1_HOST
+	tristate "CIX SKY1 PCIe controller (host mode)"
+	depends on OF
+	select PCIE_CADENCE_HOST
+	help
+	  Say Y here if you want to support the CIX SKY1 PCIe platform
+	  controller in host mode. CIX SKY1 PCIe controller uses Cadence HPA(High
+	  Performance Architecture IP[Second generation of cadence PCIe IP])
+
+	  This driver requires Cadence PCIe core infrastructure (PCIE_CADENCE_HOST)
+	  and hardware platform adaptation layer to function.
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index e2df24ff4c33..c8af7486036b 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o pcie-cadence-host-hpa.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o pcie-cadence-ep-hpa.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCI_SKY1_HOST) += pci-sky1.o
diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
new file mode 100644
index 000000000000..290bff8bf151
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe controller driver for CIX's sky1 SoCs
+ *
+ * Author: Hans Zhang <hans.zhang@cixtech.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/pci-ecam.h>
+#include <linux/pci_ids.h>
+
+#include "pcie-cadence.h"
+#include "pcie-cadence-host-common.h"
+
+#define STRAP_REG(n) ((n) * 0x04)
+#define STATUS_REG(n) ((n) * 0x04)
+
+#define RCSU_STRAP_REG 0x300
+#define RCSU_STATUS_REG 0x400
+
+#define SKY1_IP_REG_BANK_OFFSET 0x1000
+#define SKY1_IP_CFG_CTRL_REG_BANK_OFFSET 0x4c00
+#define SKY1_IP_AXI_MASTER_COMMON_OFFSET 0xf000
+#define SKY1_AXI_SLAVE_OFFSET 0x9000
+#define SKY1_AXI_MASTER_OFFSET 0xb000
+#define SKY1_AXI_HLS_REGISTERS_OFFSET 0xc000
+#define SKY1_AXI_RAS_REGISTERS_OFFSET 0xe000
+#define SKY1_DTI_REGISTERS_OFFSET 0xd000
+
+#define IP_REG_I_DBG_STS_0 0x420
+
+#define LINK_TRAINING_ENABLE BIT(0)
+#define LINK_COMPLETE BIT(0)
+
+enum cix_soc_type {
+	CIX_SKY1,
+};
+
+struct sky1_pcie_data {
+	struct cdns_plat_pcie_of_data reg_off;
+	enum cix_soc_type soc_type;
+};
+
+struct sky1_pcie {
+	struct device *dev;
+	const struct sky1_pcie_data *data;
+	struct cdns_pcie *cdns_pcie;
+	struct cdns_pcie_rc *cdns_pcie_rc;
+
+	struct resource *cfg_res;
+	struct resource *msg_res;
+	struct pci_config_window *cfg;
+	void __iomem *rcsu_base;
+	void __iomem *strap_base;
+	void __iomem *status_base;
+	void __iomem *reg_base;
+	void __iomem *cfg_base;
+	void __iomem *msg_base;
+};
+
+static void sky1_pcie_clear_and_set_dword(void __iomem *addr, u32 clear,
+					  u32 set)
+{
+	u32 val;
+
+	val = readl(addr);
+	val &= ~clear;
+	val |= set;
+	writel(val, addr);
+}
+
+static void sky1_pcie_init_bases(struct sky1_pcie *pcie)
+{
+	pcie->strap_base = pcie->rcsu_base + RCSU_STRAP_REG;
+	pcie->status_base = pcie->rcsu_base + RCSU_STATUS_REG;
+}
+
+static int sky1_pcie_parse_mem(struct sky1_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+	void __iomem *base;
+	int ret = 0;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "reg");
+	if (IS_ERR(base)) {
+		dev_err(dev, "Parse \"reg\" resource err\n");
+		return PTR_ERR(base);
+	}
+	pcie->reg_base = base;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!res) {
+		dev_err(dev, "Parse \"cfg\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->cfg_res = res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rcsu");
+	if (!res) {
+		dev_err(dev, "Parse \"rcsu\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->rcsu_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pcie->rcsu_base) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
+	if (!res) {
+		dev_err(dev, "Parse \"msg\" resource err\n");
+		return -ENXIO;
+	}
+	pcie->msg_res = res;
+	pcie->msg_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pcie->msg_base) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		return -ENOMEM;
+	}
+
+	return ret;
+}
+
+static int sky1_pcie_parse_property(struct platform_device *pdev,
+				    struct sky1_pcie *pcie)
+{
+	int ret = 0;
+
+	ret = sky1_pcie_parse_mem(pcie);
+	if (ret < 0)
+		return ret;
+
+	sky1_pcie_init_bases(pcie);
+
+	return ret;
+}
+
+static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
+{
+	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+
+	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
+				      0, LINK_TRAINING_ENABLE);
+
+	return 0;
+}
+
+static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
+{
+	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+
+	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
+				      LINK_TRAINING_ENABLE, 0);
+}
+
+
+static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
+				  IP_REG_I_DBG_STS_0);
+	return val & LINK_COMPLETE;
+}
+
+static const struct cdns_pcie_ops sky1_pcie_ops = {
+	.start_link = sky1_pcie_start_link,
+	.stop_link = sky1_pcie_stop_link,
+	.link_up = sky1_pcie_link_up,
+};
+
+static int sky1_pcie_probe(struct platform_device *pdev)
+{
+	const struct sky1_pcie_data *data;
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct cdns_pcie *cdns_pcie;
+	struct resource_entry *bus;
+	struct cdns_pcie_rc *rc;
+	struct sky1_pcie *pcie;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	pcie->data = data;
+	pcie->dev = dev;
+	dev_set_drvdata(dev, pcie);
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	if (!bridge)
+		return -ENOMEM;
+
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	ret = sky1_pcie_parse_property(pdev, pcie);
+	if (ret < 0)
+		return -ENXIO;
+
+	pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
+				    &pci_generic_ecam_ops);
+	if (IS_ERR(pcie->cfg))
+		return PTR_ERR(pcie->cfg);
+
+	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+	rc = pci_host_bridge_priv(bridge);
+	rc->ecam_support_flag = 1;
+	rc->cfg_base = pcie->cfg->win;
+	rc->cfg_res = &pcie->cfg->res;
+
+	cdns_pcie = &rc->pcie;
+	cdns_pcie->dev = dev;
+	cdns_pcie->ops = &sky1_pcie_ops;
+	cdns_pcie->reg_base = pcie->reg_base;
+	cdns_pcie->msg_res = pcie->msg_res;
+	cdns_pcie->cdns_pcie_reg_offsets = &data->reg_off;
+	cdns_pcie->is_rc = data->reg_off.is_rc;
+
+	pcie->cdns_pcie = cdns_pcie;
+	pcie->cdns_pcie_rc = rc;
+	pcie->cfg_base = rc->cfg_base;
+	bridge->sysdata = pcie->cfg;
+
+	if (data->soc_type == CIX_SKY1) {
+		rc->vendor_id = PCI_VENDOR_ID_CIX;
+		rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
+		rc->no_inbound_flag = 1;
+	}
+
+	ret = cdns_pcie_hpa_host_setup(rc);
+	if (ret < 0) {
+		pci_ecam_free(pcie->cfg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct sky1_pcie_data sky1_pcie_rc_data = {
+	.reg_off = {
+		.is_rc = true,
+		.ip_reg_bank_offset = SKY1_IP_REG_BANK_OFFSET,
+		.ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK_OFFSET,
+		.axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON_OFFSET,
+		.axi_slave_offset = SKY1_AXI_SLAVE_OFFSET,
+		.axi_master_offset = SKY1_AXI_MASTER_OFFSET,
+		.axi_hls_offset = SKY1_AXI_HLS_REGISTERS_OFFSET,
+		.axi_ras_offset = SKY1_AXI_RAS_REGISTERS_OFFSET,
+		.axi_dti_offset = SKY1_DTI_REGISTERS_OFFSET,
+	},
+	.soc_type = CIX_SKY1,
+};
+
+static const struct of_device_id of_sky1_pcie_match[] = {
+	{
+		.compatible = "cix,sky1-pcie-host",
+		.data = &sky1_pcie_rc_data,
+	},
+	{},
+};
+
+static void sky1_pcie_remove(struct platform_device *pdev)
+{
+	struct sky1_pcie *pcie = platform_get_drvdata(pdev);
+
+	pci_ecam_free(pcie->cfg);
+}
+
+static struct platform_driver sky1_pcie_driver = {
+	.probe  = sky1_pcie_probe,
+	.remove = sky1_pcie_remove,
+	.driver = {
+		.name = "sky1-pcie",
+		.of_match_table = of_sky1_pcie_match,
+	},
+};
+module_platform_driver(sky1_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe controller driver for CIX's sky1 SoCs");
+MODULE_AUTHOR("Hans Zhang <hans.zhang@cixtech.com>");
-- 
2.49.0


