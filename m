Return-Path: <linux-pci+bounces-24329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF33A6BA12
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B16719C3E6E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C78226CF9;
	Fri, 21 Mar 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HpWC7qoE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335D224B1E;
	Fri, 21 Mar 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557352; cv=fail; b=k4/sqTKOS8XYQ6AKZb9T8+Zz4EjpQGd9pdk2Dmdhgrs6S8/6SETIF296Ic7ZE0+ym3bAO3mqqearnC9bsR7LZO0jdYaaLuABUsjX6CTzHNgQn7Byya0rSquLKk83pzhCUQu3Qew7iJBOUQRm2Vkxo1xxG9RzelrWE8hIX0Mcpuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557352; c=relaxed/simple;
	bh=t3WRxSYMKGYYH8jd36CEIM6JMt4IumUmNe4VF3YRo+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp2z6ZyOxcp5pMPndbqFi4Alydq0FYJZMqTkMfHm/TzQuCmaOyRchut3wILaHAoeOUPvUjqYjgZ5z1wQnaKbal3EAiUriVDwGAMLukpgM4bN2txBGqCf/NNVxVGsD781yyGC5VFQIdzdrPNCt/DwM2YtvBSAgzp53RZMeK//aHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HpWC7qoE; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rki3IE2oANPAeL4A4/sozx9I55MYsGIBgTsVJxQ6vxHiMPQ8RmkjYmsNg0dJ3CNDeyaJ9YnrV2PkQc4bEOtd6UM1rnmX4P55fyCT6u3IlL5Le0D0/yfcTTJEU1uqLIRIUJ+noAsd13p9VtUVxPxTzBVj1NhA7S4j9zfIwvjMJbHg4DET3kxvQCaiLTP9CcFzw6XqurVTtmX26qdRQlCxkBhI0g9G8QDyedCwt8HWU1SQR2+h1LxkgRwWQgaGYPodU+sTV/l+4V3eljMMrb51v0gplMvXA2UDQnL4woL/dsJmqdWAVss+8SuCScF6YRyFgWyfaFTA1jWriBkwMCXiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPoxDWAdwUW+k6dQkBmU+64RRWLm/eWdV9ducxT4+mg=;
 b=Db2pjWoVa7Qs1UBWadbixBZ06f7nqlLjaqxyevqCB8cIskIszLkvN101wQq8vL83bsp6ZUos6MqnPhCJrGTprsag6YyG5WLGDfGKW3vc7QgoqAyfO7mO6/qEvb/WUxoWTFPizWBHgS84k+zOFi8/mbHorqy2lkS3HfzXZlkwTT5mdWjo5A15LKtXVER9sShOb0/FKNOsf5I2XX6uZ/EWVIecz5cJboh5jCsFbrNEhCLaRoiDojWK5BiKNNoZFDkHtUyqDnpXlbJMRCo9g1ecPhMRJeIM6E0Nn8X8EQ6ethao0J7czwjy2DCGMeJJ3O3xyRl5W9wm8HpF0NkCPBXDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPoxDWAdwUW+k6dQkBmU+64RRWLm/eWdV9ducxT4+mg=;
 b=HpWC7qoE8Clphv9/nFOn0rz96cBF9x82NZFr6L+5Vkb2eA6i8RXcjQMHJ1/uEQSaKfxOnTJWT9fFaxEynPDLtSxUrRbwUtNVgU85AzWIL31IAuZX+oBOyduGfXffpjQe4x0m/tKHJI7K9NlXFcIS8w9P1oOLPGuxsKNn5PJ0c9E=
Received: from BN9PR03CA0930.namprd03.prod.outlook.com (2603:10b6:408:107::35)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:42:26 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::ae) by BN9PR03CA0930.outlook.office365.com
 (2603:10b6:408:107::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 11:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 11:42:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 06:42:25 -0500
Received: from xhdlc200235.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Mar 2025 06:42:22 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v5 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Fri, 21 Mar 2025 17:12:11 +0530
Message-ID: <20250321114211.2185782-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250321114211.2185782-1-sai.krishna.musham@amd.com>
References: <20250321114211.2185782-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fb6361-4f76-4789-a230-08dd686d741b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Gdatp+nZAniR6gR0bD+EtAtFTW3NvK5tvq/hZWqboKueU8tCWr0Rr08MENA?=
 =?us-ascii?Q?zVow3fVIv1C6SqjNEx5Sn5T2G2zzgEa/A1L7VJabA0rYoDcPAZxO5Yq0KvLD?=
 =?us-ascii?Q?NBtEuaXfhCAjRHQ0d0taRrAATfe0Yg7/oqinIiLTiEoYo0j9T5icRpU6BQla?=
 =?us-ascii?Q?Dv5U2H2ItcTXn8CP/k+33qzVwxGeGAVoRIIB5IaLhiHO0ToGeiao7yhRaz4U?=
 =?us-ascii?Q?wPUPsfsSUmZale3dd3T3ivex5DGA6lHiFOnRXa8JWyaO4igV/cYJvzxnaZ/D?=
 =?us-ascii?Q?KXLVDD+Jx/6TFcCExXoK2hLlE5SAnbfikHj972q17+mV6XjJ8P/TrccJT/fr?=
 =?us-ascii?Q?B8fNV51JX8IAuQy+B3eEwq5W8GSwqs3n2BxL5+qRkg74SRwcjwsFF3MfYaA5?=
 =?us-ascii?Q?huREPSoEeob+B8RcPFzjwJxcFDV9N1IQuj9KMXzqI3kc+eT3tkdJDVZ7pmf3?=
 =?us-ascii?Q?kmZA34xBa44FT2rS7tTN+mjPSBx0p0xVPeHf6QtQD2VM6vnElFA9iWxz+vNW?=
 =?us-ascii?Q?yjhzoOlpCtklGz6PNYCn2dH2okUpxTjZfAYSWsdDnXIEpIa9WBqIRdZ2kXK4?=
 =?us-ascii?Q?LDAc5+f4/Gyxlun06q7a+ZgUFTPhSlE6LpsEjMBSdkqxSrAjgc7h6AGBs3Rh?=
 =?us-ascii?Q?79rB3EJ8R0zxqu0rUHr9301WbCzdrWZgYrcw8fZqYb6Z2SsDmwqcAji3OQaN?=
 =?us-ascii?Q?GTtOztSlaSZ3a+nrXzarHwKp3lXjVdqD+95t3PwMsyKx/5DjBIknqa5Yl+b0?=
 =?us-ascii?Q?yuG5w+hSE18AxqTM5duKMRhMbIDnwsxFLX71ruEVmwJUHIteQnugt/HO9uae?=
 =?us-ascii?Q?coDNtcJsEZ3pSLbhTXhrGWz+GnClobKHuyc9xjl0ntERS23rVN0ay/GabmI6?=
 =?us-ascii?Q?ExKVNaPE2aqICw7ecZUxqjObIDZ+XoyXi0wsVITkf5GbittuWAVhN9dyQPtd?=
 =?us-ascii?Q?Xk/VQgthzjbl7FhHnEGgjFXICQ9JkB8aulLvxceyrYPp4lXMeBUO9CkKXG/l?=
 =?us-ascii?Q?XWYJNz9lLDRtVcnUFgKfcZFnIU55bQXkSZfyuk9QXkCQvIHgmmH0nZhMgKBG?=
 =?us-ascii?Q?gjjPCilgy0Pu2tjC+Fjb1A4VBX5EP+aYB+0c89wsF+DOcbeOjWBy22CVGaNm?=
 =?us-ascii?Q?S1Oy1xf1/v3uPS9gq2oZMkMQEl2w9o52zGRBDdrkuLq456EI+q5K4Y+jzAlx?=
 =?us-ascii?Q?VOts+1v9lquQgdXnpuOpsXIJ9CHJXTKsnCndMmB0jsPAjZkOSTz/earIBrNb?=
 =?us-ascii?Q?I8gqSAWIZyKQ5/yi9DU8htd05KtiDnlOnAGlYDX6YXTjM1ESxzcZh3NmOfZO?=
 =?us-ascii?Q?1jKFwQCEjqMaAuNN1isrO4xDFzBfmWlrYrqNy0hTFsp2AstKWQJTa+EjT4Qz?=
 =?us-ascii?Q?MGUtJHnyID94qfGKy7xjNdIj7xi3GmXs5S3nUWVS2zFByTHPk4AO4AlRtrew?=
 =?us-ascii?Q?s9/BQenF/TubAPTtqnrvgOMdYHNQOT7j/e1dj7fzGwa8AzpbaYY/YItNIpvi?=
 =?us-ascii?Q?CKs/IHVBD3jLGHU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:42:26.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fb6361-4f76-4789-a230-08dd686d741b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

Add PCIe IP reset along with GPIO-based control for the PCIe Root
Port PERST# signal. Synchronizing the PCIe IP reset with the PERST#
signal's assertion and deassertion avoids Link Training failures.

Adapt to use GPIO framework and make reset optional to maintain
backward compatibility with existing DTBs.

Add clear firewall after Link reset for CPM5NC.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes for v5:
- Handle defer probe for reset_gpio.
- Remove multiple assert of reset signal.
- Resolve ABI break.
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
 drivers/pci/controller/pcie-xilinx-cpm.c | 86 ++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index d0ab187d917f..527bf96e9014 100644
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
+#define XILINX_CPM5NC_PCIE0_FRWALL	0x00001140
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
+ * @cpm5nc_attr_base: CPM5NC Control and Status Registers Base
  * @intx_domain: Legacy IRQ domain pointer
  * @cpm_domain: CPM IRQ domain pointer
  * @cfg: Holds mappings of config space window
@@ -118,6 +130,8 @@ struct xilinx_cpm_pcie {
 	struct device			*dev;
 	void __iomem			*reg_base;
 	void __iomem			*cpm_base;
+	void __iomem			*crx_base;
+	void __iomem			*cpm5nc_attr_base;
 	struct irq_domain		*intx_domain;
 	struct irq_domain		*cpm_domain;
 	struct pci_config_window	*cfg;
@@ -475,12 +489,45 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
  * xilinx_cpm_pcie_init_port - Initialize hardware
  * @port: PCIe port information
  */
-static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
+static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
 	const struct xilinx_cpm_variant *variant = port->variant;
+	struct device *dev = port->dev;
+	struct gpio_desc *reset_gpio;
+
+	/* Request the GPIO for PCIe reset signal */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio)) {
+		if (PTR_ERR(reset_gpio) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request reset GPIO\n");
+		return PTR_ERR(reset_gpio);
+	}
 
-	if (variant->version == CPM5NC_HOST)
-		return;
+	if (reset_gpio && port->crx_base) {
+		/* Assert the PCIe IP reset */
+		writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
+
+		/* Controller specific delay */
+		udelay(50);
+
+		/* Deassert the PCIe IP reset */
+		writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
+
+		/* Deassert the reset signal */
+		gpiod_set_value(reset_gpio, 0);
+		mdelay(PCIE_T_RRS_READY_MS);
+
+		if (port->cpm5nc_attr_base && variant->version == CPM5NC_HOST) {
+			/* Clear Firewall */
+			writel_relaxed(0x00, port->cpm5nc_attr_base +
+					XILINX_CPM5NC_PCIE0_FRWALL);
+			writel_relaxed(0x01, port->cpm5nc_attr_base +
+					XILINX_CPM5NC_PCIE0_FRWALL);
+			writel_relaxed(0x00, port->cpm5nc_attr_base +
+					XILINX_CPM5NC_PCIE0_FRWALL);
+			return 0;
+		}
+	}
 
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
@@ -512,6 +559,8 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
 		   XILINX_CPM_PCIE_REG_RPSC_BEN,
 		   XILINX_CPM_PCIE_REG_RPSC);
+
+	return 0;
 }
 
 /**
@@ -551,6 +600,27 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 		port->reg_base = port->cfg->win;
 	}
 
+	port->crx_base = devm_platform_ioremap_resource_byname(pdev,
+							       "cpm_crx");
+	if (IS_ERR(port->crx_base)) {
+		if (PTR_ERR(port->crx_base) == -EINVAL)
+			port->crx_base = NULL;
+		else
+			return PTR_ERR(port->crx_base);
+	}
+
+	if (port->variant->version == CPM5NC_HOST) {
+		port->cpm5nc_attr_base =
+			devm_platform_ioremap_resource_byname(pdev,
+							      "cpm5nc_attr");
+		if (IS_ERR(port->cpm5nc_attr_base)) {
+			if (PTR_ERR(port->cpm5nc_attr_base) == -EINVAL)
+				port->cpm5nc_attr_base = NULL;
+			else
+				return PTR_ERR(port->cpm5nc_attr_base);
+		}
+	}
+
 	return 0;
 }
 
@@ -602,7 +672,11 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 		goto err_free_irq_domains;
 	}
 
-	xilinx_cpm_pcie_init_port(port);
+	err = xilinx_cpm_pcie_init_port(port);
+	if (err) {
+		dev_err(dev, "Init port failed\n");
+		goto err_setup_irq;
+	}
 
 	if (port->variant->version != CPM5NC_HOST) {
 		err = xilinx_cpm_setup_irq(port);
@@ -635,6 +709,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 static const struct xilinx_cpm_variant cpm_host = {
 	.version = CPM,
 	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
+	.cpm_pcie_rst = XILINX_CPM_PCIE0_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5_host = {
@@ -642,6 +717,7 @@ static const struct xilinx_cpm_variant cpm5_host = {
 	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
 	.ir_status = XILINX_CPM_PCIE0_IR_STATUS,
 	.ir_enable = XILINX_CPM_PCIE0_IR_ENABLE,
+	.cpm_pcie_rst = XILINX_CPM5_PCIE0_RST,
 };
 
 static const struct xilinx_cpm_variant cpm5_host1 = {
@@ -649,10 +725,12 @@ static const struct xilinx_cpm_variant cpm5_host1 = {
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


