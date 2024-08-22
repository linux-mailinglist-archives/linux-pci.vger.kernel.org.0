Return-Path: <linux-pci+bounces-12043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6995BFBB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CA91C23314
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4FC1D0DFB;
	Thu, 22 Aug 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SauX1uH+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C191CDFD5;
	Thu, 22 Aug 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359340; cv=fail; b=nDHg9P7d+k2RdwVxtrP4W/WD3P1816EtMNYLdRMd+sKr8OCHzcoD5xU3KAYksjiBFu0rE2beYDzL/CXjVFi8ajVfKVSoSQpEWV1YmYmnfCUm7mOXtkIJrRWLXA7+LJjyBVimIKpU4GWTgdZYXc/Pex2941L5NGd1Uoraan5ACyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359340; c=relaxed/simple;
	bh=KAgJBHjAyWO8bO+uvadWpvELKncabt+8eeSuQs7dvBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXGB66QgjqRn6eefCW9BIGaVvt66VAiWSBpCss8dmoLSeM3QdLIzIqqe6UyUGvW1pHi5ES2etC+uP7Ccbx7bKPNPnVJSnA3zBhXRDQ3bxbQ96OZfe/9HEVw++0j7NQXUqhYtYUxAFC3EbV2Aph/Q5foVu425X89P3bAHT5QZqg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SauX1uH+; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAPkEmvj4i78IEx/1iW0SDbr9lU3+6EoplNMoI89vtbDHmL6fV0Rr+SfZWXH0IEk0dobI/Ct203/cQxrDeO84klHTiGgF6/HW7T80btFyLdXwVMx33jvgQgi0E5YtemXglW2R5469qBAnueH2w9xAlrao8g+CD/Mffk0oEH4QgisznAd2lX1gV7n5nA6vRMCltFZ+3JaKl2xrTurzqarePWX86smHHi4sl3LXdTveLuDi3ZS8ixL0cxc6pFV9WQ5L1Kzshm0NOORYVRzZ+bgV9N1jt7iwl5A2U+hnxptFMLLLpdmI7CK88dfyafmWbYrnKxLrSIctwADFzNTmT/FKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUksyS7lRHIRzRcpofQuvHY9NslDjXez0L+vGPoEnlk=;
 b=xtLt7mhonQ+QL7LeGQDPTC1+f4MGP7Y8Ac1Jg4EhMaXlz8B5OGaU83IQQjmKefs/3mDhwj2tU/X+jSJycqicGVrog3S4CsxNnZXKx9e8K1b+PIWHdx7kWl5ITrXO6tgVt+6PJ9L1XBKcwusDPqQdUF1eYhENV8IXtHudpiVUXkvqu81THrPqJxTIziEHciPCjvAcCp/IEQyE5Rp4dOvoYVK99yIo2+7fnyw+PJyYCH0VoBvaiUxbJlQFvbch/RGSbCbCG+Xy/ZVyoX/KGLNwH58aD6FYIJrgTEtqTOhrCLTdIYm+D7Qr2Tsf7ptjpG1EveJFxJ95HcM4k264UU7wCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUksyS7lRHIRzRcpofQuvHY9NslDjXez0L+vGPoEnlk=;
 b=SauX1uH+wVqh/IG4Tqv85DjE/MuB6YNxGkQAyJ/bXdORAD2myMkh4Uq1ZEt9I6raVTXVzigZrSXVS2sAFgz5Yb7SPU3Xy3ihkJhbXFx7rbM7ByNohW0UipMH9DWb+H+MGRlXkTG31JKXT/nqZDySIV0pkCTM3vBHe1WHQx4VXMU=
Received: from SJ0PR05CA0154.namprd05.prod.outlook.com (2603:10b6:a03:339::9)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 20:42:15 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::26) by SJ0PR05CA0154.outlook.office365.com
 (2603:10b6:a03:339::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11 via Frontend
 Transport; Thu, 22 Aug 2024 20:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:42:14 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:42:12 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V4 04/12] PCI/TPH: Add pcie_enable_tph() to enable TPH
Date: Thu, 22 Aug 2024 15:41:12 -0500
Message-ID: <20240822204120.3634-5-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e047c0-0562-4c5b-2bf8-08dcc2eae7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5NTxioxAabeBa3XuQUrZ8Rt9GtM7CBsB6vVmCO6r27a010z2/epQIL9PlYrI?=
 =?us-ascii?Q?+fVe5UglxAZQS3DwrbwJx1vKBFCT/M3JN3FuKWKmau1sqFdVD00zkFa9do17?=
 =?us-ascii?Q?/cUTmGUTt6Ulsg/7m7FJ/atcq1GxRIW7q3pmkhYSIdq2Ox2mesiZgHCqWT1F?=
 =?us-ascii?Q?LzIJxlD3dRH/aEiokAZhnMLxpQ186JFrh/+7/qkCGUcKBNjvPRnU+/8hFRu0?=
 =?us-ascii?Q?TW06x+KMNbgEPvIsOKHyhDizp/1+wkDqIXfEqmwBcjxenVDNsALd9RMf7vOs?=
 =?us-ascii?Q?meUN+dNjJzC+4yyIGs1znIJYGNdcrz6YQxafbHeq+8YHSqktqI84w/k8tJ1d?=
 =?us-ascii?Q?Puxg/6s+IkYBUrNv8zFgWmIso+Im9qxUxZ556Ev3KQFihX43+F6IU4e1IdeM?=
 =?us-ascii?Q?8BC804iluhsvWmoltGjAu11CS7TTYbFelynIpdAX84K0NYvtdgojsROWyTek?=
 =?us-ascii?Q?IK/EEYJKtT9PBG2h6FB/O69Oz/N5dIBqsXRwIdazXpLUBQIGe7rmCeIr1eQ2?=
 =?us-ascii?Q?courYibB0Z43XdKHOcIH0+ODUALuk30PIcTZw9gzKOo2zMCqiAu+JnnfKZNu?=
 =?us-ascii?Q?0UagaKYgeRjzrdpB8g8MvB3ZP4yIeVAxSi7JhEmv3lVl8eOZ0vd/iqya8sZT?=
 =?us-ascii?Q?vkmeEC1upe+VlV1UHH3lNP4oxJoLN2hxJqR7X1IJ9Bsoend92brI1ICD2UVV?=
 =?us-ascii?Q?+f7WhOPFaOiiGk7KprOMre5P/fTLZZ++ICJvEM7tceoIz/yqtfmOt27aw6yO?=
 =?us-ascii?Q?gocuxPEFYhnCsmPchaZs67UZSG6Hav8DOqQF5DyK7kLs3A78qZecH+Y5017T?=
 =?us-ascii?Q?DsuV962yhnR2H65MNbY+LO+RVURYehIZLQFcVDQQpaXyS/T6lRG2bkK7W6pS?=
 =?us-ascii?Q?ySKNR9XYrLpfdwDzV1R0IObvtEEx2OKUlIbgXdgKcAtlKBbVQzE1k7QJCj5E?=
 =?us-ascii?Q?UaxhJE9ia0wjLOD9Zr7tRlEZ7r+GOhagGt7st9Cnoexx3Wi+l5yMr4iZQYRd?=
 =?us-ascii?Q?qaq4wXFR93bDy/rwGxWcH3f27h9wkzwGGFZhy26oNc4zIFzHaG1zsUXEoT7t?=
 =?us-ascii?Q?F0WVKrnzeQxpvy8ZTcn06xSjD8GM6Z2RgGYRYOZyDJh1TnV2Us8Jej+ovV/Q?=
 =?us-ascii?Q?SdoidyCwboOLj4b4PZXX/DNegb2Ww/Um837GOM+zrgzKaGQJeQTQhBd701+6?=
 =?us-ascii?Q?irxub/Uo79cJqNr1qz6TP+iQ33AgUu0pYMKF7YhR3KVsqM/pgah3GOvg4i57?=
 =?us-ascii?Q?I2JeMyxjjQElwJp0TGkMBz0JokN4vn8K/Xgw7ggUyiCv8eE/bC4srY8jMAcj?=
 =?us-ascii?Q?NhHepctaW0+1DdEIkDbr0/XvwFxNXyTv4JT2sisFBEvhrvHXti/Ju3MSpINM?=
 =?us-ascii?Q?c6BLiRRVtfrdpV2yV7r1Di4O+P99LY8hCeIFMgQeo6wDoPCSltyTGzSgtwaD?=
 =?us-ascii?Q?6oO3iQ3nSGk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:42:14.5273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e047c0-0562-4c5b-2bf8-08dcc2eae7d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037

Allow drivers to enable TPH support using a specific ST mode. It checks
whether the mode is actually supported by the device before enabling.
Additionally determines what types of requests, TPH (8-bit) or Extended
TPH (16-bit), can be issued by the device based on the device's TPH
Requester capability and its Root Port's Completer capability.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 92 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  3 ++
 include/linux/pci.h     |  3 ++
 3 files changed, 98 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index a28dced3097d..14ad8c5e895c 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -7,6 +7,7 @@
  *     Wei Huang <wei.huang2@amd.com>
  */
 #include <linux/pci.h>
+#include <linux/bitfield.h>
 #include <linux/pci-tph.h>
 
 #include "../pci.h"
@@ -21,6 +22,97 @@ static u8 get_st_modes(struct pci_dev *pdev)
 	return reg;
 }
 
+/* Return device's Root Port completer capability */
+static u8 get_rp_completer_type(struct pci_dev *pdev)
+{
+	struct pci_dev *rp;
+	u32 reg;
+	int ret;
+
+	rp = pcie_find_root_port(pdev);
+	if (!rp)
+		return 0;
+
+	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &reg);
+	if (ret)
+		return 0;
+
+	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+}
+
+/**
+ * pcie_enable_tph - Enable TPH support for device using a specific ST mode
+ * @pdev: PCI device
+ * @mode: ST mode to enable, as returned by pcie_tph_modes()
+ *
+ * Checks whether the mode is actually supported by the device before enabling
+ * and returns an error if not. Additionally determines what types of requests,
+ * TPH or extended TPH, can be issued by the device based on its TPH requester
+ * capability and the Root Port's completer capability.
+ *
+ * Return: 0 on success, otherwise negative value (-errno)
+ */
+int pcie_enable_tph(struct pci_dev *pdev, int mode)
+{
+	u32 reg;
+	u8 dev_modes;
+	u8 rp_req_type;
+
+	if (!pdev->tph_cap)
+		return -EINVAL;
+
+	if (pdev->tph_enabled)
+		return -EBUSY;
+
+	/* Check ST mode comptability */
+	dev_modes = get_st_modes(pdev);
+	if (!(mode & dev_modes))
+		return -EINVAL;
+
+	/* Select a supported mode */
+	switch (mode) {
+	case PCI_TPH_CAP_INT_VEC:
+		pdev->tph_mode = PCI_TPH_INT_VEC_MODE;
+		break;
+	case PCI_TPH_CAP_DEV_SPEC:
+		pdev->tph_mode = PCI_TPH_DEV_SPEC_MODE;
+		break;
+	case PCI_TPH_CAP_NO_ST:
+		pdev->tph_mode = PCI_TPH_NO_ST_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Get req_type supported by device and its Root Port */
+	reg = pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
+		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
+	else
+		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
+
+	rp_req_type = get_rp_completer_type(pdev);
+
+	/* Final req_type is the smallest value of two */
+	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
+
+	/* Write them into TPH control register */
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
+
+	reg &= ~PCI_TPH_CTRL_MODE_SEL_MASK;
+	reg |= FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, pdev->tph_mode);
+
+	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
+	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
+
+	pdev->tph_enabled = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_enable_tph);
+
 /**
  * pcie_tph_modes - Get the ST modes supported by device
  * @pdev: PCI device
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index fa378afe9c7e..cdf561076484 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -10,8 +10,11 @@
 #define LINUX_PCI_TPH_H
 
 #ifdef CONFIG_PCIE_TPH
+int pcie_enable_tph(struct pci_dev *pdev, int mode);
 int pcie_tph_modes(struct pci_dev *pdev);
 #else
+static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
+{ return -EINVAL; }
 static inline int pcie_tph_modes(struct pci_dev *pdev) { return 0; }
 #endif
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c59e7ecab491..6f05deb6a0bf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -433,6 +433,7 @@ struct pci_dev {
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
+	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
@@ -533,6 +534,8 @@ struct pci_dev {
 
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
+	u8		tph_mode;	/* TPH mode */
+	u8		tph_req_type;	/* TPH requester type */
 #endif
 };
 
-- 
2.45.1


