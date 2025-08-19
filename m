Return-Path: <linux-pci+bounces-34285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D391B2C265
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99986222ED
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCE3314B4;
	Tue, 19 Aug 2025 11:55:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022120.outbound.protection.outlook.com [52.101.126.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929BD32C33B;
	Tue, 19 Aug 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604518; cv=fail; b=SwLGhrQ6mofv0WfkJtanyaXzr0TpKGabZuFqpi3x2Py3XmqGCsdioToK0NKd1chElGW7AjMmnp/EN1OnSuz9v9lXwv8eh5hgn2pdHHvTeWsdESgJEK49TDyKGAn6qWHGXiQa+lEO+cKb9dukA4pmvteMNiTQDGpy8mFM7a7tb7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604518; c=relaxed/simple;
	bh=jxMNDQ9cuKoWY4oPkSGosWIUDpYyiMxVn5y8Cjp+1J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwkpC/idkRADdBHvc9FtNzUQHZt7yvhc880ztW8Q1HRR5REUXMIyyyKXH8wUvPpyAJ6RP3qfSs9nzR1yIgywzK2WL5CCRrIYorHK+28Lho7oJoxD1s2cyaeWzyd19oAsuk7LBRJZEx4bKf+kw0biutMqyhImXZVBkxfOdtjtuU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRAXjk843NZhQdJapVKvoBibzj4+dRm4pXlcJnJ3rmKRfYmHQPHiqyd1d38M73inrKjUf+OD3dOpauBNOLmsFD+K9IlAQBuQ9KXSHB9h8i6vaA2WTiIEGSs/HG6QoHqAGL6O8IBcIVZS/4SA9EbQPHiWEBWOntNI7/+fV7AQ37MoK7ma1a14Srz1iHstF1Cj74RpB4UCLYGRm9hobl75n1elqa/R4HxpHhF4+hXs8nNQknjANAE1zpu8FRztSUGaA/8szvlRyGBIgITm70Z8mgE3fhY4R/rrkKag1/5yUdkT+MCBH0dy6GN4TG35npB2IEs5s9NiUZ620o0maluI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zQ51HG0ICc+pFIk0HZjm4xwAk4d0jkYiojau6hhquw=;
 b=tu6NXROtUzXJn7wVUgeqyayLzcEU7WeIw7310urr82XnjsF+DYk5D/gKz07EWlBfZQMBxw5g5Xb7NbuGoUfaaAl17g6jm+EsvmMOHFv/Xrsn6W8UMqnXVMQ0QUQwVq78yX8vA+RXBv6jQqDcwy3VyT/mVsnsf2ZHQbzM2Ib6UmXoxn2ihr3LrOirVsudOqhjuSKNTJh76Uo5G8VHZmwRGra2lR5ZBFsDoruaiRjPjQJzO7zMYXdd7HpGRiGhKZbF2oXvo1r83oOjeLQS7buS1Et+ZT+dSByNUaKWYcde9voidBX5bvTldjdXJXRqKvkKxt7WiGidgmIL/npX+nv3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR06CA0042.apcprd06.prod.outlook.com (2603:1096:404:2e::30)
 by TYSPR06MB7068.apcprd06.prod.outlook.com (2603:1096:400:466::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:12 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:404:2e:cafe::cb) by TY2PR06CA0042.outlook.office365.com
 (2603:1096:404:2e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:11 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8E26D41604E7;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
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
Subject: [PATCH v8 04/15] PCI: cadence: Add helper functions for supporting High Perf Architecture (HPA)
Date: Tue, 19 Aug 2025 19:52:28 +0800
Message-ID: <20250819115239.4170604-5-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|TYSPR06MB7068:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2dfaae86-30c9-4ae9-e064-08dddf174088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJU4xm16hH/JEwxxiPrcGq48SxcSZ4Wc1LJsIgeUhoqdx9Qjjl7w/nCGBeDS?=
 =?us-ascii?Q?+Wt+UVnFrHBa9WndGzn93oo+dLDN+XhHhgOdXZqEDr5Bwd4d7VNYx9sjMOjA?=
 =?us-ascii?Q?HtYIHPED31V3IhsI/qGhs6ltBBPhhjv6HK9fHYRB2u/c5EembJqXvtpd8ewg?=
 =?us-ascii?Q?dirzFwmu4EsFXf4H78Zvv0RQSwyfDyJkota5An8IcwrZTpbpDW/PiBp1D0PO?=
 =?us-ascii?Q?/g/fxCx8ZpkuRESjUt9UpVkuQKXbdIrrVLvseYWcz2/1fZOqgmiyoKoCZO2G?=
 =?us-ascii?Q?BLbMhD8ptZ5ZSgz26UEaABRVHL2EtmiNewCqn5SKnforjZ5n9imwZMGWYSXc?=
 =?us-ascii?Q?ollQs5Q+eGWVn6DqdxBDuXQG96d96EUAMJ0VGqgevgt+5Gjh9gwJet0/6XEm?=
 =?us-ascii?Q?ppa874ukAf3wIZQrXQaaaC+hd0hNTVl7gIPgMU7q4DSxa6+s8sEgP3rFVv9t?=
 =?us-ascii?Q?gx3IeaAJB9Ciuf2PSq2DC4C3LMpRCNSrWFwXhKl35sGs2A0GhqzjvQDYzx/t?=
 =?us-ascii?Q?AYbCmHRyVAp8YQ2vQr7j7AiXxXNdboLTSPiipyR6bnyD1TKjsZsT5MleTGUq?=
 =?us-ascii?Q?iNrlblJWtUOT43rnpr3ABuNqwBJlJwkDgCbbIqxsq3UAfItnATkv3pIHRbOY?=
 =?us-ascii?Q?7NYln78rwb8g3GFW0DzHCXM4pR26KL/VDSxOnlhMYmNCxcC6I5TqECpcsgVi?=
 =?us-ascii?Q?//8IFnqrarCJ5PsnwRxYBywYzSWyk9W0mg9NSe5D/On+oHj7P4EtBdYjIEKD?=
 =?us-ascii?Q?E+WwWWj1DxVolYVViopmZblf67Utc0ZhGjYrrMTkztwHzPuu/GAnvxpUthER?=
 =?us-ascii?Q?K5ClLxWVNaWwICBXraQd9s3jy+envIoyfW8KNs76MJm/cl1j2g76P98wXcim?=
 =?us-ascii?Q?12An+I6vuEHc/z1VaFQT3MGgYB/kj5EnD1EMiPiiOD5pIXcOzjrxlgZW6JxT?=
 =?us-ascii?Q?8lQUfIb878QQxaiCTVJgMBZhES0Bur4+pd65EnLgGs8YeiNELWg5yg5uyF6b?=
 =?us-ascii?Q?fVHE73lYuMiiNKDmKTskXcgQofsfmaSkbBEiOrgO4vRqT+j7CEvRm1wzm4XO?=
 =?us-ascii?Q?2/mwd7pHTpsE4g3FsxXY57Ej1fvk9C3tNcMMnS2SiKo3duuxCg2oTxRSw3CN?=
 =?us-ascii?Q?lgug7qIaAO5F/vq5+et4lHfZ8EoBD5wd5pcZ7B2sgeH2r6E5nkG9AQYke30b?=
 =?us-ascii?Q?OJteQxqQZpP1XsRJ5n4NfoLqjfOXpN7z6TzcIeAscs5y0Wiqws7Nuq+prIfT?=
 =?us-ascii?Q?Cofsy4OJ2kmnXLxqnWj8mvZcdMnuKrX40QXXI7RC+4cN58vr/DgFvedqcSzy?=
 =?us-ascii?Q?ZzMVULPKihIqnA/yRmBA/wTy8KF0GL8xsbvcyA5jqHmGe3NYGRUKk1d92cIi?=
 =?us-ascii?Q?qluYo0Fwig5k0gqXSU66ErUERlNntNSQszoKXbbNifIReHs92Y3SxO2EqSjF?=
 =?us-ascii?Q?bW8EyXTknz6QeQFrCJGUy41omF9gVlrMa5cv8PhHE0yuXhaNCBGCWPEmXFHG?=
 =?us-ascii?Q?oKrenWPheksYx2aL2AlqsImqFPZLYGbh3lyv?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:11.4272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfaae86-30c9-4ae9-e064-08dddf174088
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7068

From: Manikandan K Pillai <mpillai@cadence.com>

Add helper functions, register read, register write functions and update
platform data structures for supporting High Performance Architecture
(HPA) PCIe controllers from Cadence.

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


