Return-Path: <linux-pci+bounces-13343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A056D97E03F
	for <lists+linux-pci@lfdr.de>; Sun, 22 Sep 2024 08:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237E61F213AB
	for <lists+linux-pci@lfdr.de>; Sun, 22 Sep 2024 06:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B8C193436;
	Sun, 22 Sep 2024 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fm0JnxWi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87619341D;
	Sun, 22 Sep 2024 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726985682; cv=fail; b=FU3zKFrAKuqaEc4+JYO2GrlYbBaX96nInS6PXjDukiV8jLFIBiCJOHtKudUnGhj+yFqiF6WpsCFaghgZI1lE9yc0ne2YJq4DmrEQHv8YP7KoR/kd6Sxy7XGOTr1swpPBs2EeMkTbVNz27KTK+tisflWb+m/VeWFPze04wC7DVtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726985682; c=relaxed/simple;
	bh=hXL1bshEl396GxB5c91+hvy43k1Q+BNjLfHXJ6cVqNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLTyrEE91WKZOf31DIzvYSJfEjxx0yk8iHOyhfEXB9J4fDvMoIolPmG6KWogS0RVGvW02ZdEPc54h6SNdLhUZUSuzZ67TRT4kgnvoWTiLWoAyE2RXpiofB5Krzeamrenf9dCz+4n6B8xtDt09Ci7bAHtLl2mVbemmE60nzr7Mtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fm0JnxWi; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/euI3zi5sG1Srzb/4ptpQKMWXYFWP0rPAcqdttXos9/RgEllQ78CL2WXZfwYjDP7hQkHKB+noMD0yyxovC1/+nraF1Y1RiBxCYeYqscmUHJsZzBY+i/y2Q2nNSwoAqPp+5HAGH9ZTQDtBYnC2zAFAgR8c4rVhsfI8luhaJRy55bWayhBduii6deTAWzoyl3XfbUQ7CaC1JLfyzy95OyntGgdANDq7x8dQGsfFdtNXH7Su9sqKV6yVq3RiwlHufJLvx5N7Zll5H8gMPDQENr9BLQ9RRCzLZXmRAuGMHThcgjgmOkt8U+ubwPYb8UNZHxO6HC/LnyDbTzH4f+cgYVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBuvVMnnVKbqnv+iphtY26yvPTNjkif9GAX0Hr8VLHM=;
 b=Bog8fIUVQWWtXYknTcUsDlRX0l2tfB3ldZ+hezDnTfeTnTL1S8Ri1opHe8FzGGqiJxn1mCCcunnE8d3LlCqkQWkTofnGlzUPFwaXtH8h5LNVj92F1BHbFi+UnLINiqoRgTcuNzH7zFfzyAqf7VO4fWgbMLebWDxL6LFUUhWIjJt5LLV6asGhmf1WdRGOB1gs+y5L+1vYUVCKzy9qBmZ210fJmxWrUHPy5x2HAexWQdnSjyDABGS+CMoSlGw+xm5r4y9U6MS54DNfOC4f5fTuI0b+mOPo6srXKstTA5sCOq+I/n+0+vNYoCQwTrRxRWyA0Sqb+VqJ1PjN2XH/C/XjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBuvVMnnVKbqnv+iphtY26yvPTNjkif9GAX0Hr8VLHM=;
 b=Fm0JnxWikK7ueP2kxOTOyMKaYECyiOJWFAiiwmloFii4ds/T4xuTQ7PuOp+NbvMtUR4gdsLXhwulERFQAMYNlShDtCGt2oiHN6c/P5MjAnhPUnt7+fVwb/pqYd2qu7enk9QfOHFd7PZhByQlQiS/oxgjt1J3l3QMXOYjvJvhreE=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Sun, 22 Sep
 2024 06:14:35 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::e9) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Sun, 22 Sep 2024 06:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 22 Sep 2024 06:14:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Sep
 2024 01:14:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 22 Sep
 2024 01:14:34 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 22 Sep 2024 01:14:30 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
	<krzk+dt@kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port controller 1
Date: Sun, 22 Sep 2024 11:43:18 +0530
Message-ID: <20240922061318.2653503-3-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240922061318.2653503-1-thippesw@amd.com>
References: <20240922061318.2653503-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8dfd2b-545a-45ec-5f2b-08dcdacdd501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHVU8h2oetBhjJH0AbWhVp8cjLvYqzwggKs/y1KDyhBzd1YmVIZm+ur6qsvJ?=
 =?us-ascii?Q?j8o9KGY2RAsHjUB95in5JsSppONg2Hvgdd0cRJY8PMHNEwNT4ERo0uESCDuB?=
 =?us-ascii?Q?znT62sDKNHbYMERuv7rFvmrAfCt8HS/g6GVIq1V0wRTnWhF27xKQS0QwcWIF?=
 =?us-ascii?Q?8DXVVlcSHxdedpPZ66XYB7PT6L74WOLQIQjrSnFRCF3j4ei7w6i5CIzzHCPd?=
 =?us-ascii?Q?Chj8Dsjasv6R7LMTA7Y3S+gjjOVeF8298KF9dH/dNEL3QdogHEKrF5a/wSsl?=
 =?us-ascii?Q?TsXCTd9Bjnp7iEfqulrgEqqYabnYOLQiZQM+dJrwCYF3zkX/pez/Ay9DcUSQ?=
 =?us-ascii?Q?XwRZMFeKcP3fzwxH9kfygrhH6gvyszUyQCbwHrBTPE1+d8ILLKixxeIx9E7j?=
 =?us-ascii?Q?sRYdpxKl6LBtGv80OMEWt/Oj6wshZHE23oLlBHtPehVpnVXpjMGAXEz9LeXw?=
 =?us-ascii?Q?s0Lsr6wsTaEbeA3//S1xDZlsQDfUrUivuKjskDgNNnkDOZMQRH+nA/xrYHTn?=
 =?us-ascii?Q?nfk+hxWmPwm+z4VC5uWtUufHh6dQyiZ0++KCfvzOe8wHylncBZI3p5x3Q+PR?=
 =?us-ascii?Q?c5MTfSrZB2P786pEwujgiNrXmxN4c1Jp8qL5AI7eVqLBhfpfCimnKYZ5Ahgg?=
 =?us-ascii?Q?y7R+sBJVOCiCZndYxIURnYwpmXaXWJMRNkSJHGwkfAGfdpooWE7Gfw3NmCiH?=
 =?us-ascii?Q?5MEHE144XVrRYwTSEl8N5hfVl56U8LblE2mTqbKqYpTpN3XqUMTiwda+a0QO?=
 =?us-ascii?Q?KYcf4bfEmCc+7Y/6ZrcI9FeAOLD9+FAwszgFcfqu25GFHRJuP4XNx6d0k3x5?=
 =?us-ascii?Q?OBaDAbZQUiSW/IjrKCOCIP26GhAbKi/msM3xXeA79cCXnGMPn3xcQAy6bvNe?=
 =?us-ascii?Q?d+ljK38BPSp4j8unLncWXfZhriKu1Z/4I315s6y1cEKP4Mtv6cTQhFkzl2Xu?=
 =?us-ascii?Q?+RAadJhLg92fXBmMrqgxfNG/c5Gsar5ILtIn/e69wM9MSnA+iRjQpVTXrKS8?=
 =?us-ascii?Q?ePoQKdtyg3QdTz6KY1mU+P5xeOVsqXK/5oMIZBgAu1iEtnuGumQtzNkkPqxM?=
 =?us-ascii?Q?fESZ08w1fUAYm2W1gZ9zemAJh53/Ps6pr4kzaqdiMbHv+WGqyprkoUaZjutR?=
 =?us-ascii?Q?5CF8yVScXoHl1hrQabE5qDkOD+6YPP2ReiuUBZeN5BqlxR1x/oBI9yJNW6hn?=
 =?us-ascii?Q?fapMmHdoils/Szu6n+p3rPiflKh8SOIKqCrrkmngWcs0sp43b60oV7pBYT6j?=
 =?us-ascii?Q?YIXZo5lU9Q3JO93iPUPmQ7EMgUpS7rkD+XdcMjoufz9dGJx0vkysvO0n1N8/?=
 =?us-ascii?Q?1HubsgT54FSIMKG0BWr2ytP8Pua5tHFs4br34vq8wX3m3q8cAQ7ZWc87jucG?=
 =?us-ascii?Q?a9oz+w/gtLzbhwNebuxnOjvOYtCJQFboX1N24jTbIEtUf/NP3oUF2iNI8eE0?=
 =?us-ascii?Q?5pK5BV0yWx+C665SljfBQuPl5CkacPQG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 06:14:35.5461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8dfd2b-545a-45ec-5f2b-08dcdacdd501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

Add support for the Xilinx Versal CPM5 Root Port Controller 1. The key
difference between Controller 0 and Controller 1 lies in the
platform-specific error interrupt bits, which are located at different
register offsets.

To handle these differences, updated variant structure to hold the
following platform-specific details:

- Interrupt status register offset (ir_status)
- Interrupt enable register offset (ir_enable)
- Miscellaneous interrupt values (ir_misc_value)

The driver differentiates between Controller 0 and Controller 1 using the
compatible string in the device tree. This ensures that the appropriate
register offsets are used for each controller, allowing for correct
handling of platform-specific interrupts and initialization.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
changes in v3:
--------------
1. Add kernel Documentation for variant structure.
2. Modify compatible string.
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
 drivers/pci/controller/pcie-xilinx-cpm.c | 50 ++++++++++++++++++------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index a0f5e1d67b04..81e8bfae53d0 100644
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
 
@@ -80,14 +83,21 @@
 enum xilinx_cpm_version {
 	CPM,
 	CPM5,
+	CPM5_HOST1,
 };
 
 /**
  * struct xilinx_cpm_variant - CPM variant information
  * @version: CPM version
+ * @ir_status: Offset for the error interrupt status register
+ * @ir_enable: Offset for the CPM5 local error interrupt enable register
+ * @ir_misc_value: A bitmask for the miscellaneous interrupt status
  */
 struct xilinx_cpm_variant {
 	enum xilinx_cpm_version version;
+	u32 ir_status;
+	u32 ir_enable;
+	u32 ir_misc_value;
 };
 
 /**
@@ -269,6 +279,7 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 {
 	struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	const struct xilinx_cpm_variant *variant = port->variant;
 	unsigned long val;
 	int i;
 
@@ -279,11 +290,11 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
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
@@ -465,6 +476,8 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
  */
 static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
+	const struct xilinx_cpm_variant *variant = port->variant;
+
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -483,15 +496,15 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
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
@@ -609,10 +622,21 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
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
@@ -624,6 +648,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 		.compatible = "xlnx,versal-cpm5-host",
 		.data = &cpm5_host,
 	},
+	{
+		.compatible = "xlnx,versal-cpm5-host1",
+		.data = &cpm5_host1,
+	},
 	{}
 };
 
-- 
2.34.1


