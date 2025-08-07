Return-Path: <linux-pci+bounces-33529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78768B1D385
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA453B13EC
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F9A23F417;
	Thu,  7 Aug 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WuovjNQ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0723F41F;
	Thu,  7 Aug 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552451; cv=fail; b=THnoWCdNoBFirBoab0Vg4l0upLMxFmlW+8mkTefiNwF7Bt5+VNtbv0hc+pYfkTrnj56L7nrTthtwmcm+vm/OV3orSjyQA/dsFazUj7zm04+ObuJfDgi4avDVZGYIx6uaJa5hfUJkoC4/UuhUWJkSPH3SRTrasJVCxLYzs6x39+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552451; c=relaxed/simple;
	bh=ahxayEVIua4m4t6TpaMWPuticKNJRqaOvT04D4fWa74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8u3pSnWXIwJbtDiaKx+nPmVRd0w5f3xYJm61kslsqVh1rEVjkgS1+F46KtQHxnJ2OlabtInOLDK9niEmcrKLObqVzPgCpd3fIOTJ5HNcMhG1JjEs+fJVcApW08A91BP2Q3FnrEsZQHprsFPor6b5vESwitJ65/MEL2G0KLznvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WuovjNQ0; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4efJs5hHP+Bry7IQ7a2l/YyqVJhFM9CL2I6YIsYEQb6msAL8S3QIV6iF6D5EThp1FzgOyp/sqBHsTf6NMEt482VW2UDlcyQNu7yVSxFSp5JnLe+5gpZ1cGxAcAr1cZ4BJEdiPRknYpRrK0aJb6vu3RaXhzBJ1UYXQYWnJcgf2cLwm0WIHMtZRx9W1N3Nc5zlVCKSwDPUO1JiS7nxM4zCb2GHBf3VTwgY4mGp60RsTEj17gkPlDcQvYzoVZ533g9gYtH3566p8Gj7ibhJrgL6xpeTfMgaxWn+wIxeYTOFLEHEqTMvri6Xiv026YjApSjHkYNFELqhvwe1u50S37T8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yscpRpIJvDYJSpVrpvVJlnmWmhOJ1V16CXycDJj8nlk=;
 b=SD8w0RN4Uwbcfz2vm5vd1j0F72vg8ragj0cEVPBL2lN/RHgZ8dqHshVY8SVhKYOG/rsXV33//MrD2bN5o4qM5Jk5BHHKJnAPF0pkFV5kYYYrUEOM6GoTY9zjVo0Utr/zbMjZD1ifMrW/H4zVoTucL65YDCGsdCngWrJxkzcY7tGGizXddobrwyfXXesEPTg+YjTMmRGm7s62tnZV2SCsGaB+y0tY6jJ8qmv1kXBK/aqZxuXJPY+3ugXAygkLtuA5KM27rTU0r5+xFtPITyd2ocfZdLTGtOb9acxRbx+/1B5k5AHFLn/n+pGbYkIhT+SSYEI4jJJavMshCWlLOW3njA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yscpRpIJvDYJSpVrpvVJlnmWmhOJ1V16CXycDJj8nlk=;
 b=WuovjNQ0ROyN64iMOcPOcB9hBkjMCu90ApB0sj2kItj20Z3Tr3Xzu5Kud1Fxgp6iVmUZ5u9M8p0ZtNtyvM0bVxMzEgkmgXwtm2JJHwiYE/NfIE9MXITso1U7mPsf8o/DIfZz5aaOCrzGLQ/YCKUyTNUZ1yVfIFRXQ8Gl4GITmVA=
Received: from BL1P223CA0034.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::16)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 7 Aug
 2025 07:40:44 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:5b6:cafe::77) by BL1P223CA0034.outlook.office365.com
 (2603:10b6:208:5b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 07:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.0 via Frontend Transport; Thu, 7 Aug 2025 07:40:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 02:40:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 02:40:33 -0500
Received: from xhdlc200217.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Aug 2025 02:40:30 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v7 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
Date: Thu, 7 Aug 2025 13:10:19 +0530
Message-ID: <20250807074019.811672-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250807074019.811672-1-sai.krishna.musham@amd.com>
References: <20250807074019.811672-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: b612f61c-0b90-4881-635e-08ddd585b639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/pcCp3pxbZ2RgsZ0DelC8vWTJ1ryKcgD0IcqM+IshwzM2DThZm9SpGMo8Jj5?=
 =?us-ascii?Q?KDgx6Y/DoH9oY9WjopspMfCm7SEjusK5+wQ81fQ8qeBe47rIJzUCorvQSJO8?=
 =?us-ascii?Q?Wn8ooxDzhEI3kNHxWKqX6pu+GQ1d6pL1UHooA0PXlR3EtV0lU7+HrQKyLeew?=
 =?us-ascii?Q?VtT8ypJxrSvhYYUw0PmEsQBIoSd3wK43AxVVGYan4KnDzk9J973wxGZiQIEa?=
 =?us-ascii?Q?vRU7/Xzs7uQDzGJojWkZWioAHJhZ46DIaOSKLK57frIonvD7ULHyEZ22EeFU?=
 =?us-ascii?Q?NoDSxMm+AGxJsX2j2+SwC6cDIBh8O7ZFizJu50ehvZy9JpW/mNGI0Xi7TiWz?=
 =?us-ascii?Q?Fe2OgkRKTzd2iRf6PRAoeHJJaouWOPNh/0FLHYYHlfaKMJPFG/Gw8Sraf9BX?=
 =?us-ascii?Q?uh2uywhNgla2Btpr7rzRfNr+pv2eTJGKwOfKb+OebhJmr+SMX4+YQwSr6VOg?=
 =?us-ascii?Q?boAPE5d9h1vF9GeD8bSrVm9NGB8E9OtcI9qHD81CTifpW0Q0vtRZdFLM0F8l?=
 =?us-ascii?Q?P6W7NT08YmIl8OXyNbCLHIwPMdweXvWYE6L2/jYhGZBlAU86bta6JSk3r1TU?=
 =?us-ascii?Q?sghDMWrJST2pXMiuWRMhh/ido0ydUPpnH50r70vrqR2RMc8D7zVtBWAx4zWX?=
 =?us-ascii?Q?Y8/peR9AhY1/ZPfKSe+50SYo2bU5sfpOOrHiRxFERfph6tvSoUrITnvPutiN?=
 =?us-ascii?Q?24MXsv9RHnNVm1WMFtwYi5qJVGEBpSkaf3BxpA1NPd7wrMP6wu9MIyQoXAED?=
 =?us-ascii?Q?DxI3zFufK96u4NYpzei010CBPxnsgV5BfKyOVEMgBl772N5pAnJ4p5Vm62Bf?=
 =?us-ascii?Q?8NM6eELu5ApZ1IQSiKgwyXx3l+cEii/mIvFtr1xiQ7cmLShADf/KFpIrGeBC?=
 =?us-ascii?Q?CfphUcyK/kGTr+EWEHN5vK/U51gb57yb+iQmnHHa1VK4PmR9bfdGvIqLt0la?=
 =?us-ascii?Q?a6wF85PoFm3I0BV4xZrka/P/P1lV+PTzieHDEIyapUTW80TFBo4ZBdyftuLp?=
 =?us-ascii?Q?icP1Rpe0GHODQBbbKdnlHlOgAFbnqH7tEpF20Sq5pqWrrvd8t7mGp5fm4IQv?=
 =?us-ascii?Q?iMu7pBf7M5nQYtGHFCU0pkwMlUpvGMjVOh/j7QGAETmGQDrMJzivv4FlmR97?=
 =?us-ascii?Q?j+X3zxMOf+J41u/FVZA76/C5U2Wi7a3DrPvpS1aYJwEnWGkofxbOw/k8AFHK?=
 =?us-ascii?Q?JONHjeZVGBze5N9RbpW3dcrnqOQKhMzJjjoJwCY3RhuWQblgEbsa0iWEBYgB?=
 =?us-ascii?Q?VEIotLi5s1vD/kzevy0cfz5p0qeSJOCDp3wkqPF/Vr2VeVlQ6UjMLbMTQ70j?=
 =?us-ascii?Q?Dr/emUBe4jmSYGxZ2cjuEXSPPt1Ox4PYwCT9fNKQMnHfQG/BwBfwT1BTonWC?=
 =?us-ascii?Q?z4Sby+kvidJu2sWag7vIr+qbQwB+Apnu0J5WhITgALqD5C28piQUe+48C8+G?=
 =?us-ascii?Q?Kl6yDQXT+GrC9lTlLDqobUNZDf/sKgLDojs7TsrrY6g9KCxWFhDS3Y7APblM?=
 =?us-ascii?Q?rJGDjVAPF0+84r/FkrPtfRW6moRKyZ7xQGltiQsW53KLWyrYeNEX/IytCA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:40:42.0635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b612f61c-0b90-4881-635e-08ddd585b639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
signal via a GPIO by parsing the new PCIe bridge node to acquire the
reset GPIO. If the bridge node is not found, fall back to acquiring it
from the PCIe host bridge node.

As part of this, update the interrupt controller node parsing to use
of_get_child_by_name() instead of of_get_next_child(), since the PCIe
host bridge node now has multiple children. This ensures the correct
node is selected during initialization.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v7:
- Use for_each_child_of_node_with_prefix() to iterate through PCIe
  Bridge nodes.

Changes in v6:
- Simplified error checking condition logic.
- Removed unnecessary fallback message.

Changes in v5:
- Add fall back mechanism to acquire reset GPIO from PCIe node when PCIe Bridge
node is not present.

Changes in v4:
- Resolve kernel test robot warning.
https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.com/
- Update commit message.

Changes in v3:
- Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpios property.

Changes in v2:
- Change delay to PCIE_T_PVPERL_MS

v6 https://lore.kernel.org/all/20250719030951.3616385-1-sai.krishna.musham@amd.com/
v5 https://lore.kernel.org/all/20250711052357.3859719-1-sai.krishna.musham@amd.com/
v4 https://lore.kernel.org/all/20250626054906.3277029-1-sai.krishna.musham@amd.com/
v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 52 ++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 9f7251a16d32..3c6e837465bb 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -18,6 +18,7 @@
 #include <linux/resource.h>
 #include <linux/types.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
@@ -56,6 +57,7 @@
  * @slcr: MDB System Level Control and Status Register (SLCR) base
  * @intx_domain: INTx IRQ domain pointer
  * @mdb_domain: MDB IRQ domain pointer
+ * @perst_gpio: GPIO descriptor for PERST# signal handling
  * @intx_irq: INTx IRQ interrupt number
  */
 struct amd_mdb_pcie {
@@ -63,6 +65,7 @@ struct amd_mdb_pcie {
 	void __iomem			*slcr;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*mdb_domain;
+	struct gpio_desc		*perst_gpio;
 	int				intx_irq;
 };
 
@@ -284,7 +287,7 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
 	struct device_node *pcie_intc_node;
 	int err;
 
-	pcie_intc_node = of_get_next_child(node, NULL);
+	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
 		return -ENODEV;
@@ -402,6 +405,28 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
 	return 0;
 }
 
+static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
+{
+	struct device *dev = pcie->pci.dev;
+	struct device_node *pcie_port_node __maybe_unused;
+
+	/*
+	 * This platform currently supports only one Root Port, so the loop
+	 * will execute only once.
+	 * TODO: Enhance the driver to handle multiple Root Ports in the future.
+	 */
+	for_each_child_of_node_with_prefix(dev->of_node, pcie_port_node, "pcie") {
+		pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(pcie_port_node),
+							 "reset", GPIOD_OUT_HIGH, NULL);
+		if (IS_ERR(pcie->perst_gpio))
+			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
+					     "Failed to request reset GPIO\n");
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
 static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 				 struct platform_device *pdev)
 {
@@ -426,6 +451,12 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
 
 	pp->ops = &amd_mdb_pcie_host_ops;
 
+	if (pcie->perst_gpio) {
+		mdelay(PCIE_T_PVPERL_MS);
+		gpiod_set_value_cansleep(pcie->perst_gpio, 0);
+		mdelay(PCIE_RESET_CONFIG_WAIT_MS);
+	}
+
 	err = dw_pcie_host_init(pp);
 	if (err) {
 		dev_err(dev, "Failed to initialize host, err=%d\n", err);
@@ -444,6 +475,7 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct amd_mdb_pcie *pcie;
 	struct dw_pcie *pci;
+	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -454,6 +486,24 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	ret = amd_mdb_parse_pcie_port(pcie);
+	/*
+	 * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that the
+	 * PCIe Bridge node was not found in the device tree. This is not
+	 * considered a fatal error and will trigger a fallback where the
+	 * reset GPIO is acquired directly from the PCIe Host Bridge node.
+	 */
+	if (ret) {
+		if (ret != -ENODEV)
+			return ret;
+
+		pcie->perst_gpio = devm_gpiod_get_optional(dev, "reset",
+							   GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->perst_gpio))
+			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
+					     "Failed to request reset GPIO\n");
+	}
+
 	return amd_mdb_add_pcie_port(pcie, pdev);
 }
 
-- 
2.43.0


