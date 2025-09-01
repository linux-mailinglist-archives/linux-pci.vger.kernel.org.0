Return-Path: <linux-pci+bounces-35253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E58B3DE4C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE202188A716
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8800131A064;
	Mon,  1 Sep 2025 09:21:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022103.outbound.protection.outlook.com [40.107.75.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B630E834;
	Mon,  1 Sep 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718477; cv=fail; b=PFBFQPmNQt4qGQcH78c/H+Am1Aa/gvb4sx9Y/4tmRr/ku4iMYiLTDelKecbiNd7lW1gaGJJuMl83iTp38pqbjaEoUXL3Bg5GKCqPBH8wb2Ijzk1pHflLAMZZahc3ZAKUMWq/uGP8s/XSvd49hVo0iAQRSl4W0eiAdYiDj6ICBq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718477; c=relaxed/simple;
	bh=gKR1MwT/NLO/wSb4SbXvu0ZyQVITzkgTh3+Z+YjNaM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AchNxWuFGI1aSpZ4OgQ1pHpqTl+rPjwnJ8LoGh0v6tGy9NvyJJ+qn5xaooAWS0qTvIw31WuGAiyGd83NCCxGSmiz8NrJcyaMmXXOTavkSmntS4ESxYA/yJjMF6SiQtTksmymdZbLC+5MwyJVd0fyKNg380xclg+bVVWrOkwV/7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3gvwq5dmmCVHuNFybuNU27vJ6lkz019Y9S41C/ZUsaHIPGvubnDQ5jjH2xpeR54t45CXTyxODO7cjOuH63fHDgiGzyxcKDMXjK9ULXKceGLyw7ZY0x9wrf6VRj6BS8a8gDRziGPyGwkhzkzmsmH2wcI5rDS61vxUQB92y9XJA9he02qPLUKDvvJJ/RD4AlLr2FQFaYL50OSWBrD3Tymd/MwvVoL+tbMY8DJx6N05gKXcO2LnPPvIhSeVaafMgtfxHKr/XDhH7T7NPu5XPqbhbZsrLpHDJSxutOAWbQP6gFn3RBEgL5l1et1Qb2IlLcKL5fMt6I1hsUtdHF5S/nffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tlqa3rUaNyW+3l9aXNntsEcD1Qjb8EoaATatBgR/NcE=;
 b=rRX48Jc6nStPiWCmr+QVk3MIt/K/vJtm8TwKTPHkC15TpJa39/E9hb1z/DPlFIJSzhc9dDtjRAAm2F2mxeFZBnF0tyOPassRSWeiPW2by10X2PqfNPnxyk9kMy5bKMF5nOQVYTsKd2VCSIjzAAL00rlRYHXSYB6BrQ0aTt+4Xk9+9cZYWMWgNi6j+jm8o6ogP3IBY4BMQEaujJYhZqg9+kX3F+gE84Gg6kbIzBo6NfPg9Zh7/9qdyOIwy7u+/0VHSgJmF04YKr+1NB/oDNH2QbWoRQdOtPF2vrYwRgFjbaDioSQbATeIqoZ6eTJytUHYGzCLm+s9fIlx/CnuJ0zHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21) by
 SG2PR06MB5191.apcprd06.prod.outlook.com (2603:1096:4:1d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Mon, 1 Sep 2025 09:21:09 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:b0:cafe::43) by SGBP274CA0009.outlook.office365.com
 (2603:1096:4:b0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.27 via Frontend Transport; Mon,
 1 Sep 2025 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:08 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1200E41C0154;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
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
Subject: [PATCH v9 04/14] PCI: cadence: Add helper functions for supporting High Perf Architecture (HPA)
Date: Mon,  1 Sep 2025 17:20:42 +0800
Message-ID: <20250901092052.4051018-5-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|SG2PR06MB5191:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f65b6794-0013-425f-48b4-08dde938e29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P3IRSSuHTTwAbN88W830mJqaGdTjR2Fbm35VDNtVnHYOiTbOTsYLN9JbIMIH?=
 =?us-ascii?Q?YO4Uc4ID8+ODp3RdC82N5iN+0jBId9rf5OoPx82vmAEAGZL24QDeKlHnjDAD?=
 =?us-ascii?Q?PLpXry00zOcVESRKuzBgTjSj1uCdgMrWwo0IRzKVY0d8femRKWt31EnOBsDM?=
 =?us-ascii?Q?zP/VyGC1Zc3ikKBvmEquyvonfpYxeY7hMHLGs8VaZa9ru27/Ts+wvfqV6EAa?=
 =?us-ascii?Q?F1LGgVrnSF6VRE5TG8TU8iOUC73XB/fsv5gH9IyTg71XcfHLCNMcOgLDFdd8?=
 =?us-ascii?Q?5MtQZPH6jyYA2p6OviJ6Gi8k5N8ERHzsSozQ3LOab3HTnaUo54wbPX7cwj/c?=
 =?us-ascii?Q?AWtnit6hGds7/SjKHQQLAcNMAiYn/jnXQMCnXAPxSlq5r1Td9dmmUyjIh713?=
 =?us-ascii?Q?OCFHiza0aZWIFg2Q5zmGcu7FjNrCJt9tN1pppk2OdrCrLd2Vjv4x5Ow74+tz?=
 =?us-ascii?Q?YjStmlfRyKzDhNaLwa8t2UyGAB25xhGb0LNp/OlRtpltpbfjroJwAspizBub?=
 =?us-ascii?Q?k0PZs1rB4Z2sjgM/eFX9TMLOhkn/5dK7Q0cpBTCLrpzocsd54SF0WCGg1yTg?=
 =?us-ascii?Q?lh8t3ZHR0azki4YDmQz3ii5JO5FjVsH4vTmgdO2V3W/Yh+Sn18DF2+nifwnm?=
 =?us-ascii?Q?M09t1IpOBuTZlG7uNuUO1/gAjQqYXbK7HwNi2A1JmeUpIHKfWMS+e00Y/qNl?=
 =?us-ascii?Q?CiN4SE8fLFYYxcuGM0Z5Xia70ma0tUnuWPdHe47J/jxJvppN6A5CCkGQq01X?=
 =?us-ascii?Q?ngk7J0nSqtFGsY5/VZsKidppNYqjkQMFjIW2iXW/R6umxMZlViocj+stMAb1?=
 =?us-ascii?Q?wrwbE788AdTBZ82mlGtCIqr9gXhlZ+PfZ+0o2jya7dWXT0gPrOzeNC/c5sfp?=
 =?us-ascii?Q?/YtGN76nOTki+wbpH7/NFNcArkh67oIiB76dSsEx3jxJQ571I7Twwi5Swo/9?=
 =?us-ascii?Q?R/Smb6CPvJy+tow4EDHyxfMCndw5TYNlQtNj4yLBNkE3feSFXpMN5LpFd8dQ?=
 =?us-ascii?Q?OoXivteFrHwVz6ayavggOs6Y0iZsN1PtXpGi8WXnvx30VZeozgm4gDRbueEf?=
 =?us-ascii?Q?6XMxIjFRfzBIVmwOuHC8Ldy6yRmhZU7NsX3eqmHjI1vXt06HbD3u0ChUTnLR?=
 =?us-ascii?Q?+7MfXLGCvHFGgn+xDhbhGFcSCng2aS/Ezi7uVOCT/DS11JevvPimWId/mrY3?=
 =?us-ascii?Q?8iEKD5dvsY6d95OiNz5QKBz5JTFfAS9qWfqDZ2XAeuEy7iZSQiwnB0BP2CBr?=
 =?us-ascii?Q?OGcM9hx+LSibgg7Ahd/6tbdfL8kpUetyU9ZMxtd0IwjiEdgTS2GQ7dyXejvr?=
 =?us-ascii?Q?khwHivn0nCpbrEb0afU0920CH7e4P1JBFGNlT6odIJFQOxHNYnSHMnEgEMC7?=
 =?us-ascii?Q?N5hwHDmFxkyFNa/mE4gowMhcox65q4EEyTG0tSnOxh6yUx9fnM3Qk/kHzI3/?=
 =?us-ascii?Q?AybcKwrioGu+SyczbqasjfaPd084shmwi/Xaf+so0Vk2jYqfshkwIw5oai20?=
 =?us-ascii?Q?UU9LNdBvYHFwUBDlEGwbIx0KST9tQkTYusUP?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:08.4122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65b6794-0013-425f-48b4-08dde938e29e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5191

From: Manikandan K Pillai <mpillai@cadence.com>

Add helper functions, register read, register write functions and update
platform data structures for supporting High Performance Architecture (HPA)
PCIe controllers from Cadence.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../controller/cadence/pcie-cadence-plat.c    |   4 -
 drivers/pci/controller/cadence/pcie-cadence.h | 111 ++++++++++++++++--
 2 files changed, 103 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index ebd5c3afdfcd..b067a3296dd3 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -22,10 +22,6 @@ struct cdns_plat_pcie {
 	struct cdns_pcie        *pcie;
 };
 
-struct cdns_plat_pcie_of_data {
-	bool is_rc;
-};
-
 static const struct of_device_id cdns_plat_pcie_of_match[];
 
 static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index ddfc44f8d3ef..1174cf597bb0 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -26,6 +26,20 @@ struct cdns_pcie_rp_ib_bar {
 };
 
 struct cdns_pcie;
+struct cdns_pcie_rc;
+
+enum cdns_pcie_reg_bank {
+	REG_BANK_RP,
+	REG_BANK_IP_REG,
+	REG_BANK_IP_CFG_CTRL_REG,
+	REG_BANK_AXI_MASTER_COMMON,
+	REG_BANK_AXI_MASTER,
+	REG_BANK_AXI_SLAVE,
+	REG_BANK_AXI_HLS,
+	REG_BANK_AXI_RAS,
+	REG_BANK_AXI_DTI,
+	REG_BANKS_MAX,
+};
 
 struct cdns_pcie_ops {
 	int	(*start_link)(struct cdns_pcie *pcie);
@@ -34,6 +48,30 @@ struct cdns_pcie_ops {
 	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
 };
 
+/**
+ * struct cdns_plat_pcie_of_data - Register bank offset for a platform
+ * @is_rc: controller is a RC
+ * @ip_reg_bank_offset: ip register bank start offset
+ * @ip_cfg_ctrl_reg_offset: ip config control register start offset
+ * @axi_mstr_common_offset: AXI master common register start offset
+ * @axi_slave_offset: AXI slave start offset
+ * @axi_master_offset: AXI master start offset
+ * @axi_hls_offset: AXI HLS offset start
+ * @axi_ras_offset: AXI RAS offset
+ * @axi_dti_offset: AXI DTI offset
+ */
+struct cdns_plat_pcie_of_data {
+	u32 is_rc:1;
+	u32 ip_reg_bank_offset;
+	u32 ip_cfg_ctrl_reg_offset;
+	u32 axi_mstr_common_offset;
+	u32 axi_slave_offset;
+	u32 axi_master_offset;
+	u32 axi_hls_offset;
+	u32 axi_ras_offset;
+	u32 axi_dti_offset;
+};
+
 /**
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
@@ -45,16 +83,18 @@ struct cdns_pcie_ops {
  * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
+ * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
  */
 struct cdns_pcie {
-	void __iomem		*reg_base;
-	struct resource		*mem_res;
-	struct device		*dev;
-	bool			is_rc;
-	int			phy_count;
-	struct phy		**phy;
-	struct device_link	**link;
-	const struct cdns_pcie_ops *ops;
+	void __iomem		             *reg_base;
+	struct resource		             *mem_res;
+	struct device		             *dev;
+	bool			             is_rc;
+	int			             phy_count;
+	struct phy		             **phy;
+	struct device_link	             **link;
+	const  struct cdns_pcie_ops          *ops;
+	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 };
 
 /**
@@ -132,6 +172,40 @@ struct cdns_pcie_ep {
 	unsigned int		quirk_disable_flr:1;
 };
 
+static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_reg_bank bank)
+{
+	u32 offset = 0x0;
+
+	switch (bank) {
+	case REG_BANK_IP_REG:
+		offset = pcie->cdns_pcie_reg_offsets->ip_reg_bank_offset;
+		break;
+	case REG_BANK_IP_CFG_CTRL_REG:
+		offset = pcie->cdns_pcie_reg_offsets->ip_cfg_ctrl_reg_offset;
+		break;
+	case REG_BANK_AXI_MASTER_COMMON:
+		offset = pcie->cdns_pcie_reg_offsets->axi_mstr_common_offset;
+		break;
+	case REG_BANK_AXI_MASTER:
+		offset = pcie->cdns_pcie_reg_offsets->axi_master_offset;
+		break;
+	case REG_BANK_AXI_SLAVE:
+		offset = pcie->cdns_pcie_reg_offsets->axi_slave_offset;
+		break;
+	case REG_BANK_AXI_HLS:
+		offset = pcie->cdns_pcie_reg_offsets->axi_hls_offset;
+		break;
+	case REG_BANK_AXI_RAS:
+		offset = pcie->cdns_pcie_reg_offsets->axi_ras_offset;
+		break;
+	case REG_BANK_AXI_DTI:
+		offset = pcie->cdns_pcie_reg_offsets->axi_dti_offset;
+		break;
+	default:
+		break;
+	};
+	return offset;
+}
 
 /* Register access */
 static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
@@ -144,6 +218,27 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
 	return readl(pcie->reg_base + reg);
 }
 
+static inline void cdns_pcie_hpa_writel(struct cdns_pcie *pcie,
+					enum cdns_pcie_reg_bank bank,
+					u32 reg,
+					u32 value)
+{
+	u32 offset = cdns_reg_bank_to_off(pcie, bank);
+
+	reg += offset;
+	writel(value, pcie->reg_base + reg);
+}
+
+static inline u32 cdns_pcie_hpa_readl(struct cdns_pcie *pcie,
+				      enum cdns_pcie_reg_bank bank,
+				      u32 reg)
+{
+	u32 offset = cdns_reg_bank_to_off(pcie, bank);
+
+	reg += offset;
+	return readl(pcie->reg_base + reg);
+}
+
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
-- 
2.49.0


