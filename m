Return-Path: <linux-pci+bounces-13240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D397A622
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 18:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BBA1C23445
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7768155A3C;
	Mon, 16 Sep 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gxjfE8DO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34114659F;
	Mon, 16 Sep 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504680; cv=fail; b=sXoKCsc1vI6cYUs45UkJ5ZrOkQ7QQyHuOsGhXNF3KEyNbp7UG6l33wPqKHaE46PDgPqxKWNDi6eDMNWOQ9ImSDZbd0RKu69a6yRfkGPQhPc/7pIU4PYp15vLqhWf/6n7ZdL7F3TzZyTQDX1A3CX8KanX0NhDF1WCiF9ROjcQJkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504680; c=relaxed/simple;
	bh=8aDsOY790JjL3sMGWWGARFa+DuXUi3LSbtSQNTxw6/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WKBzn1wH28JNc0b1PNbo/C6vqY5u2H6sKSTZdB58Ebuo6Ga46PB1B92DfGGKWaxTNHKscD2mRG+Us8YJ485Oo/JRjNyHgpkqw0X95fCh+qJe7zgbTaw40NQRMz2+Tmuyjm22Imq/Bhrt/tEFDi4cCyRG8sh1GuMRaUUJRe6+c3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gxjfE8DO; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVEzjsjhthfHUwzPPu1RGbntSLFMBFSGy7aPAmlpfCiqWeIZs5R7+Mt6vbuEW/i2XQBfFSM+CigmNDdD33tCY1FQMOpk4WhxXo7rkU7kbK/Dq2cE+0XE6R/aTLdHyPWiFaa6Le/rptPps10edA5QyC/kFy8kHjZwBtNvZ6eQpIQQMABipuqBF11iD4uPfyYK5V+fPe+xmVP4ikKo2pPZlS0fgutTltgWyda+49i5luMG7PTjzNDJgzETR33DamRYJZ6ONJGG26GofpO+fytupZ88KvFcY6Grk5ImZwm8lGoBA/2wlVMImpW7fv/1DtAznZxR00pnFog4kza404TRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhumEZzwQ3uuGsCO1zkcg5BK5S2IEFAePuTiGybIZMc=;
 b=tVLW6WXaBFz3o1egVIxZl0FxKAZarrzJ6eIwV+jokwftasjH6tcQtAlV8h73LKZGGvopBpwChnb2o+zZSlKRDx+5TqCGaZ6fGB58JfU1ocShQ2aeX6lTxOMk3O92g3XfgDU+nq18Wi48CEN69wye0F82aqvlFrvWq8a+nm8xNVTzs6FdFLnOdureIblXsLcPqOc4dN3wXu0gs+HUQPkq24xCK4M2gKdII+Div7YKAG2+0PkEBvgWtnmNVvOkMyaCdGGTCOLmitFBGDhx/GGyn0gooBb4lXojrOvBDqxVMpCSSqwEQ3IgH+s1scZiz1JtfjE/PNe+9IYpraOYNTKZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhumEZzwQ3uuGsCO1zkcg5BK5S2IEFAePuTiGybIZMc=;
 b=gxjfE8DODyFoZMMFBeHrDvljEhn5VozJJLmoQs/igj7Xz/tOmgx4GcNlETQ60Baqo24BYDQYhWq6cevNmujxiaC0AWKbs2S6Xt6uAa0I3R4Djku+fbwfheJuBIzxrSwHNi1n4WhzERK4TKH9o0e+T28uofL3r7Qs8yeZkvJBm+0=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:37:55 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::f6) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 16:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:37:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:37:54 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Sep 2024 11:37:51 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, Thippeswamy Havalige
	<thippesw@amd.com>
Subject: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port controller 1
Date: Mon, 16 Sep 2024 22:07:48 +0530
Message-ID: <20240916163748.2223815-1-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 354d4464-6599-446e-89e5-08dcd66deab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAc4kZyrLo4beJDHJ8LsMEe/MkGcsmLPUoitUDqHXKdTflEKaGeHPD1XcOcF?=
 =?us-ascii?Q?2buGeR6vawkVDlBXtN3Ry3czIKy5aCVd5M8mDuykL0ivCfLVpGHmRG4SbFuF?=
 =?us-ascii?Q?J7SVGUzXCeyyzntFe1o2fXdDzInqU/mE1bk5qgv8jdxAHoFrNTmRUKJlpJ47?=
 =?us-ascii?Q?FtOoJfRck+aXyu6v2OsqpOJg8kzzbZCGbvSjJ0CuLZnM3e4SKnn0QhP2ZzuG?=
 =?us-ascii?Q?E1N55xTy6vKTDFpaQmn69Nwjirb+tpzwV4FPV5Rcx8ZRfSMG3JxF8v/dbOvN?=
 =?us-ascii?Q?VK6pwaXmaQrtgUdpR1zwsp3aBsO4+pMMvkd0v+HcDZEQLM98mjhjnkeYMRIq?=
 =?us-ascii?Q?xq4uLAosSvcW85QJaRuj7TBbnSwYEZXNlsMuWcjFP9zq9N0SigKCRJNynkYV?=
 =?us-ascii?Q?RJgIAY4PwNIMjX53atEi63s/wjlavADkKPPj/kVkIlsiV2nA9jFYs/jvWVr+?=
 =?us-ascii?Q?zWPSww2ek64EvvQZ46eN2KmacNF1xgpdL96A33l5sEFU1aB1X3vgxl1kVAsw?=
 =?us-ascii?Q?zaNhR5KFAMzlM/YhY8cR6BTxoEmmxcfcArUB4h/A3z8gnAxkK6uHVP93ioSA?=
 =?us-ascii?Q?DOxo5LL5q6UD3LSpRBH7KD0f+rClfw2r+9EJbNY0PYD2VjzKDbLPT77VxVdi?=
 =?us-ascii?Q?9cr2GzssF2rUCljw+HbECmfymOjvdjzZkWnJXEIlZ4fcg9Pln01sxV8aNuAf?=
 =?us-ascii?Q?orUcno732t0VJwPJinUuaZ1s0Zox8gjoDpxRSFwp56sGw0birY2buSevdnh4?=
 =?us-ascii?Q?+gOexKmAKDkieAoN9C79FMA/OU4AT4nBVVBAJ/bhSOvc9LaD4/fhUWcEKiCD?=
 =?us-ascii?Q?/VMN7hLAN9mPx+G4KjicFM5EBfrNCtH90Rm8jgSwtSHrYI8oyZJlHZ9Uc5vp?=
 =?us-ascii?Q?ajTmUMTjXXqibyqXOGP7cxlouw59Ffm3bSrbaPDgaK8MVYTics4E8VfFEysr?=
 =?us-ascii?Q?LFyftU43I2taBx4WhsTAsA8wTf9/609jCVOsuSQAUbIiY1rJsB/p3HY3PQuu?=
 =?us-ascii?Q?9MH3pYP90aEANfPsSrv1UcjJ4LWhs9PnE59urKvrOiMIpbfKqhq15OZDOkt4?=
 =?us-ascii?Q?lgScqY5IcMzOKAFVtTI+bcAo2CViUhZiHbYHjunjoBZGNMoGDh81zuqDMR7G?=
 =?us-ascii?Q?zFa4qHfZqASFBZeCFhsy+DuXoHMBts+qSxjqjs08aOWkyUvsJniGla3zrPvk?=
 =?us-ascii?Q?2PXBMTTxTzqi0ErKyb4a43JaNiNL9iQAyQqk5WC+5ONvBabnTcmDXQAnFuqN?=
 =?us-ascii?Q?tvwtxUF4NDtRIAR2eMLhenlBtVS2WfFXBOyQKxikFtuX4GOQW0s+FA/EFf6l?=
 =?us-ascii?Q?6t0r8e+n7wooeuqW7Puyjty5X92eErGS1JWBH96/hF/hRkAFzY+JpARoiFkj?=
 =?us-ascii?Q?D3+IsiXVtm9u1iifWuad7QNPGdMCCtoLN/TMpazHuxpFlDqQ2Ujm+XLqkikd?=
 =?us-ascii?Q?m2XJHSrw1ndHMCuyPGtM4tsazGNglpv3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:37:55.6269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354d4464-6599-446e-89e5-08dcd66deab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

This patch adds support for the Xilinx Versal CPM5 Root Port Controller 1.
The key difference between Controller 0 and Controller 1 lies in the
platform-specific error interrupt bits, which are located at different
register offsets.

To handle these differences, a variant structure is introduced that holds
the following platform-specific details:

- Interrupt status register offset (ir_status)
- Interrupt enable register offset (ir_enable)
- Miscellaneous interrupt values (ir_misc_value)

The driver differentiates between Controller 0 and Controller 1 using the
compatible string in the device tree. This ensures that the appropriate
register offsets are used for each controller, allowing for correct
handling of platform-specific interrupts and initialization.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
changes in v2:
--------------
1. Introduced new constants for Controller 1.
2. Extended the xilinx_cpm_variant structure to support
	a. ir_status,
	b. ir_enable, and 
	c. ir_misc_value for different controllers.
3. Updated IRQ handling and initialization to use the variant structure.
4. Added a new device tree match entry for Controller 1.
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 47 ++++++++++++++++++------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index a0f5e1d67b04..b783fff27c9d 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -30,11 +30,14 @@
 #define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
 #define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
 #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
-#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
+#define XILINX_CPM_PCIE0_MISC_IR_LOCAL	BIT(1)
+#define XILINX_CPM_PCIE1_MISC_IR_LOCAL	BIT(2)
 
-#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
-#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
-#define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
+#define XILINX_CPM_PCIE0_IR_STATUS	0x000002A0
+#define XILINX_CPM_PCIE1_IR_STATUS	0x000002B4
+#define XILINX_CPM_PCIE0_IR_ENABLE	0x000002A8
+#define XILINX_CPM_PCIE1_IR_ENABLE	0x000002BC
+#define XILINX_CPM_PCIE_IR_LOCAL	BIT(0)
 
 #define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
 
@@ -80,6 +83,7 @@
 enum xilinx_cpm_version {
 	CPM,
 	CPM5,
+	CPM5_HOST1,
 };
 
 /**
@@ -88,6 +92,9 @@ enum xilinx_cpm_version {
  */
 struct xilinx_cpm_variant {
 	enum xilinx_cpm_version version;
+	u32 ir_status;
+	u32 ir_enable;
+	u32 ir_misc_value;
 };
 
 /**
@@ -269,6 +276,7 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 {
 	struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	const struct xilinx_cpm_variant *variant = port->variant;
 	unsigned long val;
 	int i;
 
@@ -279,11 +287,11 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 		generic_handle_domain_irq(port->cpm_domain, i);
 	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
 
-	if (port->variant->version == CPM5) {
-		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_IR_STATUS);
+	if (variant->ir_status) {
+		val = readl_relaxed(port->cpm_base + variant->ir_status);
 		if (val)
 			writel_relaxed(val, port->cpm_base +
-					    XILINX_CPM_PCIE_IR_STATUS);
+				       variant->ir_status);
 	}
 
 	/*
@@ -465,6 +473,8 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
  */
 static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
+	const struct xilinx_cpm_variant *variant = port->variant;
+
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -483,15 +493,15 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
 	 * CPM SLCR block.
 	 */
-	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
+	writel(variant->ir_misc_value,
 	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
 
-	if (port->variant->version == CPM5) {
+	if (variant->ir_enable) {
 		writel(XILINX_CPM_PCIE_IR_LOCAL,
-		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
+		       port->cpm_base + variant->ir_enable);
 	}
 
-	/* Enable the Bridge enable bit */
+	/* Set Bridge enable bit */
 	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
 		   XILINX_CPM_PCIE_REG_RPSC_BEN,
 		   XILINX_CPM_PCIE_REG_RPSC);
@@ -609,10 +619,21 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
 static const struct xilinx_cpm_variant cpm_host = {
 	.version = CPM,
+	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
 };
 
 static const struct xilinx_cpm_variant cpm5_host = {
 	.version = CPM5,
+	.ir_misc_value = XILINX_CPM_PCIE0_MISC_IR_LOCAL,
+	.ir_status = XILINX_CPM_PCIE0_IR_STATUS,
+	.ir_enable = XILINX_CPM_PCIE0_IR_ENABLE,
+};
+
+static const struct xilinx_cpm_variant cpm5_host1 = {
+	.version = CPM5_HOST1,
+	.ir_misc_value = XILINX_CPM_PCIE1_MISC_IR_LOCAL,
+	.ir_status = XILINX_CPM_PCIE1_IR_STATUS,
+	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
 };
 
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
@@ -624,6 +645,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 		.compatible = "xlnx,versal-cpm5-host",
 		.data = &cpm5_host,
 	},
+	{
+		.compatible = "xlnx,versal-cpm5-host1-1",
+		.data = &cpm5_host1,
+	},
 	{}
 };
 
-- 
2.34.1


