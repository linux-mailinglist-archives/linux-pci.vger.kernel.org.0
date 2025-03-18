Return-Path: <linux-pci+bounces-24025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D1A66FBA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A28E16A2A4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC74207A16;
	Tue, 18 Mar 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J3xA8RTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4624207640;
	Tue, 18 Mar 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290034; cv=fail; b=jXdxPQ6GI1NhEKYtgLYYVTEQ5yj6GrOF09rzEcVQVVY3iXg7cjyf1CffLIpwRTsnd3nJqGkvRQnVjPwHw4g5LNED/dwlsPHgGFRm4xYZGh8s8SuiViXLzD3k3DXfsV0CbQwhqyeGgKpPLeooPyc2BwsurqczKOyF0qk7Vu+Agh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290034; c=relaxed/simple;
	bh=v+9gYVh8vXd9GSQAeBhv/zXKGQiFD9tBchWyBPNyE+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVR3Wj0Ity8p5gyUxJ3qAXcIFSwx1G6021eDWZW0IhZZudWj/xGuq+b+siGoH5zWpaSW+BIHfC280QV5yiCbGU09LdeN1ncXFFKpA0cNamOJd6UuDBgq8IMrVPwJ+7dypSwmQeFhiX5oj/+zy8sNUWUv/wAB3RUJSeBvUhT0S1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J3xA8RTR; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMyKVVaZ3ipVEZJVdrKdfNg3pVur0q6xzeWb0t29JXuHTogP49VdtUsx+327YNSk1DOjSkvs/ZuOh3GSntT2uz6sNBCbW35ZTkU1w0T3ho9rucvpFLhOZtbmmSi8KZpQFudxIb4ODrzvlAb/uEx3UEZUezvjtlhGraUvPz3BzoaF6oXeNsOzyKVQ8X0uhrvSai9YHqa3KTorO6zxvFp16BHXyjsFoKRnsHVyKKKIsEN0P9SKg2qAIm9ck4p6OBhSyNxON4Xre93fb1C8hI7E/NknpP9Ulg4kmpwIPbA/dnBq7jh6/wrYcjMg0tuVcrEondSDoUkcvvptaTgHZjFYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otLVHMriqRbGqqmmVijqKbXc4/dh3Hd31ulhlqKDtC8=;
 b=Ajag8+CfNQCrsI12TVtY1eLhSQVNpmfmvfAjRpCSaNKlneH7i5+/AH0mzG+N+fiSsS1DYV3R4pPG8c0lM55q+pnNKiFBw3hs1uESvz0rgIksDL9mBzLQtbAiG+uWUwwzygGgn3V1TjCnszZpmgfLW0WruA4I/tIlnCFSE0QC8EKra0N/xc/t9qg0ecP/XxGaDWUDL6kftBW/0L3TSnL7XG7l7e1I2ZGHAwODUWuOzIDqh3Br/Qaym04TKigQlmXtIAVN7SWEVI81mmoDtKyTnb/IACei4cPcve03xIOxY33snk0enPBcnEkmXjh7aOIn3GWhq7jX0/K3YFso5b8YxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otLVHMriqRbGqqmmVijqKbXc4/dh3Hd31ulhlqKDtC8=;
 b=J3xA8RTRVnboqY8x3maS4KJ1KLhljhzTRqgZO6+dhkq33c5/vcvHie0303Iqcp3l7KgIKEgRzRwJFIrjmsxaODtkoc1+xxiOy4zGajNKcQE8+BQF7gmUxJ/A4TbIH8DX3WqrDsUpYgc00atRNncec+9TVFBtn4t3jwHWz1No8TA=
Received: from BN0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:141::33)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:27:08 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::7d) by BN0PR07CA0024.outlook.office365.com
 (2603:10b6:408:141::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 09:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Tue, 18 Mar 2025 09:27:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 04:27:07 -0500
Received: from xhdlc210324.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 04:27:04 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Tue, 18 Mar 2025 14:56:48 +0530
Message-ID: <20250318092648.2298280-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
References: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1abe08-1c0b-4ced-d852-08dd65ff0dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pFRp1E+LQBBgmdXTFXjAwybtB36S+Odzysmwo/edTOrH9RZ+4okArim6wCrh?=
 =?us-ascii?Q?8jDtugI6nDHiWrYpJ8+VGY4vsmJRcwIQnYDPyzAkJ58Enc+87lsj2B6sIUK/?=
 =?us-ascii?Q?Twgjf3j4iNFAmqiiYCU0R0Y63P6GI4uw9fD/oXlTJk00+azZ8rFmXU/wg9qg?=
 =?us-ascii?Q?1PYWIb8naRzBh87iL/ielSK81pVDjbp0RhC0qN9p4jfd0G3AxODdC0Flerjb?=
 =?us-ascii?Q?uu046EXG+Okz9QTHym69JhLi2FPvb12YrLEQJPhIiS7vq+o8B/cWKqBx5GYD?=
 =?us-ascii?Q?kWw5y4qktduVasybMvzLvFJWoIFZpf1CU4wwgzthSYEe8JniCuPGgxiU0pKS?=
 =?us-ascii?Q?UaITpkYnL8bYYQ2Jd2DGQV98wQQNANG63NAGcNNdHaxb7USt4fRi2PAuZb2K?=
 =?us-ascii?Q?bwxI6e8BpkXImdW82Q+L3QYL9QUsrTdSQCa93cl1j5lSVuanmlBtBLqT8ORd?=
 =?us-ascii?Q?p46NneU73is/n72OJgg3tBkIHe7SkjZzWlwZkBhbV54feKWTo1uqxqm0Sl9p?=
 =?us-ascii?Q?BpqHB81o1lySccnkB+E1S/Welhk6QF7WxnLXjBBHkP/ocGKC0aUAl28GWSg5?=
 =?us-ascii?Q?cpVHOd7Mgh2hhXdfDNxQgrkUypOykfF++K9FbJJk+tx3DRA34P+cVDkdYHLQ?=
 =?us-ascii?Q?+uO5MZl35sGIYvsc69+TmHZL6YySNt7Qazd5HCUIjnWcy0lJWFJkWp8ZQLaC?=
 =?us-ascii?Q?ta3J58Lqt2o5wlYUS9K+d47UmqUJKhI4TsgzvcjhxY+Xa+1fxGVF92GlHwh0?=
 =?us-ascii?Q?f5uvfC8gxcTrjt5CoMtpkKjQceUo+ARBpgtP5jWcTxZt7Uj6gXbGD5I7O0be?=
 =?us-ascii?Q?wrCgIFeOyzjFGACu9K51qaASD7p3m8I+pBz7ZfcfGhaGFCSmfKA/Jy3S8C4q?=
 =?us-ascii?Q?mHPqG2U3Wz0Pf6jozdSfPsur4hKRxm3ROHULCi0KrSsVnKlGdtBdNPaz/rkJ?=
 =?us-ascii?Q?d5x7VoEiq1hyxIN8+zvE8xL4Qyq0RlodS2NwSo0ZtDxPtNrLYwkwTOLma43a?=
 =?us-ascii?Q?ND2Du5+eascvX7exq+bngbHkEBGHNRVhXNqlInW4P0J9Z+75JoVoeWhrDBwJ?=
 =?us-ascii?Q?ZjAQB36wufRT2UsHlwLx6DjPaxVuk8k1bSfdnjEDb1t2TptvJafVrA69aUWk?=
 =?us-ascii?Q?EPDe1NSQIgPOOObRV729azLOSBPZ4tMjE6HN+Fuw2X6q6rg+32Z1XWN7gaIF?=
 =?us-ascii?Q?oUqHxFzoioD9OvaAFvpiYGsHq2MgojM1uiZYkN+LGGBx5Xu9lcxbRdK6ir4Y?=
 =?us-ascii?Q?U7+OQ7ZfyyDJ6rRX6EaDNksMpRG60dLinCvH9lWoQisdV12Bqh7FxOAH9ROX?=
 =?us-ascii?Q?QhdyPjvuhLlrEsVOE/TT4GWiC3V5SSngErskmvG2vgYGlyOFqSdY7RhWswX6?=
 =?us-ascii?Q?1czyjNgnf0XT/6axBFJdMs6jJRozwBTZ/fAsG5TzKrhRNVVXESbRA3756AtM?=
 =?us-ascii?Q?l4X8v1kWCTrqlqAVTk1TRT82MsaAaLkv9Pk4efYY5OecPeoIwFdmaKlJFU9p?=
 =?us-ascii?Q?F+XqwhARQlly6q8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:27:07.9193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1abe08-1c0b-4ced-d852-08dd65ff0dd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183

Add PCIe IP reset along with GPIO-based control for the PCIe Root
Port PERST# signal. Synchronizing the PCIe IP reset with the PERST#
signal's assertion and deassertion avoids Link Training failures.

Add clear firewall after Link reset for CPM5NC.

Adapt to use GPIO framework and make reset optional to maintain
backward compatibility with existing DTBs.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes for v4:
- Add PCIe PERST# support for CPM5NC.
- Add PCIe IP reset along with PERST# to avoid Link Training Errors.
- Remove PCIE_T_PVPERL_MS define and PCIE_T_RRS_READY_MS after
  PERST# deassert.
- Move PCIe PERST# assert and deassert logic to
  xilinx_cpm_pcie_init_port() before cpm_pcie_link_up(), since
  Interrupts enable and PCIe RP bridge enable should be done after
  Link up.
- Update commit message.

Changes for v3:
- Use PCIE_T_PVPERL_MS define.

Changes for v2:
- Make the request GPIO optional.
- Correct the reset sequence as per PERST#
- Update commit message
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 66 +++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index d0ab187d917f..fd1fee2f614b 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -21,6 +23,13 @@
 #include "pcie-xilinx-common.h"
 
 /* Register definitions */
+#define XILINX_CPM_PCIE0_RST		0x00000308
+#define XILINX_CPM5_PCIE0_RST		0x00000318
+#define XILINX_CPM5_PCIE1_RST		0x0000031C
+#define XILINX_CPM5NC_PCIE0_RST		0x00000324
+
+#define XILINX_CPM5NC_PCIE0_FW		0x00001140
+
 #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
 #define XILINX_CPM_PCIE_REG_IMR		0x00000E14
 #define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
@@ -99,6 +108,7 @@ struct xilinx_cpm_variant {
 	u32 ir_status;
 	u32 ir_enable;
 	u32 ir_misc_value;
+	u32 cpm_pcie_rst;
 };
 
 /**
@@ -106,6 +116,8 @@ struct xilinx_cpm_variant {
  * @dev: Device pointer
  * @reg_base: Bridge Register Base
  * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
+ * @crx_base: CPM Clock and Reset Control Registers Base
+ * @cpm5nc_base: CPM5NC Control and Status Registers Base
  * @intx_domain: Legacy IRQ domain pointer
  * @cpm_domain: CPM IRQ domain pointer
  * @cfg: Holds mappings of config space window
@@ -118,6 +130,8 @@ struct xilinx_cpm_pcie {
 	struct device			*dev;
 	void __iomem			*reg_base;
 	void __iomem			*cpm_base;
+	void __iomem			*crx_base;
+	void __iomem			*cpm5nc_base;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*cpm_domain;
 	struct pci_config_window	*cfg;
@@ -478,9 +492,42 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
 static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
 	const struct xilinx_cpm_variant *variant = port->variant;
+	struct device *dev = port->dev;
+	struct gpio_desc *reset_gpio;
+
+	/* Request the GPIO for PCIe reset signal */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio)) {
+		dev_err(dev, "Failed to request reset GPIO\n");
+		return;
+	}
+
+	/* Assert the reset signal */
+	gpiod_set_value(reset_gpio, 1);
 
-	if (variant->version == CPM5NC_HOST)
+	/* Assert the PCIe IP reset */
+	writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
+
+	/* Controller specific delay */
+	udelay(50);
+
+	/* Deassert the PCIe IP reset */
+	writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
+
+	/* Deassert the reset signal */
+	gpiod_set_value(reset_gpio, 0);
+	mdelay(PCIE_T_RRS_READY_MS);
+
+	if (variant->version == CPM5NC_HOST) {
+		/* Clear Firewall */
+		writel_relaxed(0x00, port->cpm5nc_base +
+			       XILINX_CPM5NC_PCIE0_FW);
+		writel_relaxed(0x01, port->cpm5nc_base +
+			       XILINX_CPM5NC_PCIE0_FW);
+		writel_relaxed(0x00, port->cpm5nc_base +
+			       XILINX_CPM5NC_PCIE0_FW);
 		return;
+	}
 
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
@@ -551,6 +598,19 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 		port->reg_base = port->cfg->win;
 	}
 
+	port->crx_base = devm_platform_ioremap_resource_byname(pdev,
+							       "cpm_crx");
+	if (IS_ERR(port->crx_base))
+		return PTR_ERR(port->crx_base);
+
+	if (port->variant->version == CPM5NC_HOST) {
+		port->cpm5nc_base =
+			devm_platform_ioremap_resource_byname(pdev,
+							      "cpm5nc_csr");
+		if (IS_ERR(port->cpm5nc_base))
+			return PTR_ERR(port->cpm5nc_base);
+	}
+
 	return 0;
 }
 
@@ -635,6 +695,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 static const struct xilinx_cpm_variant cpm_host = {
 	.version = CPM,
 	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
+	.cpm_pcie_rst = XILINX_CPM_PCIE0_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5_host = {
@@ -642,6 +703,7 @@ static const struct xilinx_cpm_variant cpm5_host = {
 	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
 	.ir_status = XILINX_CPM_PCIE0_IR_STATUS,
 	.ir_enable = XILINX_CPM_PCIE0_IR_ENABLE,
+	.cpm_pcie_rst = XILINX_CPM5_PCIE0_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5_host1 = {
@@ -649,10 +711,12 @@ static const struct xilinx_cpm_variant cpm5_host1 = {
 	.ir_misc_value = XILINX_CPM_PCIE1_MISC_IR_LOCAL,
 	.ir_status = XILINX_CPM_PCIE1_IR_STATUS,
 	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
+	.cpm_pcie_rst = XILINX_CPM5_PCIE1_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5n_host = {
 	.version = CPM5NC_HOST,
+	.cpm_pcie_rst = XILINX_CPM5NC_PCIE0_RST,
 };
 
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
-- 
2.44.1


