Return-Path: <linux-pci+bounces-12889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E71C96EF54
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 11:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE3E1C21AC5
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D31C8FB7;
	Fri,  6 Sep 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YA/KwICx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B41C86F3;
	Fri,  6 Sep 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615148; cv=fail; b=V41Vm2ddi1hG5xsxl4xODbJ30HGQCpS2Q1Y2GDDwsEvvFk/DbHkAYgrOFMyGMsIeVVCmq/uIyEnO0ODBHNFVS+ZEa6pBZirvsC3kfuOpks4p0IOwxSB9eB38CaVrsvyXYpEYZZvIrpwMqD24Y4VmZ2XP/mpTXUrWlza4vzwOauc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615148; c=relaxed/simple;
	bh=QGAbhZGzJ8xWMqwR0n5g6/14Lu5AC79BbsFpR5v2L4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZu2S9aiy91CmBwE0LAcDmx9VRJr0HVjdE8iI+MYkjLI7EH0UctwtftRSll+ZpFGvS8Fd2MSxCNyiRYXWjb1fwyr28UcAupXrHk5yQWOx4SnxD67xIqSzwhsslzWMWHhrXNhPRn58cl5g7SO41rXVo6ZYKezdb8/4xXeyOVWQnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YA/KwICx; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk7OS5Mkunnb1LbYqD2d1AiShxxfwP8rtxyM7l+mjhFIAjanFX+/JU6G5Q3GXxMXs0qVwmr09TKeccr7sX3ihOubWvHNVHoKBvUcVw1L91Bhfyt3pYeEO+hnuxh6WKCilXTnqnoHqjZf07EdcTf8T8MRRXTbxNqsTDxaBkJ9X4hq3BhvxxKplMYNd+aYXJ0Lu62hcP8+s7sXBK1lsYlLQhoekKdMdQF9cuQZjuY1jRdefI4rip5VSGjAhgz8XGOL7gqxFWfdZzmGAPjKHtoXppyXhjMkIxoxJYdCzLt2v+cHUUo4Cz937yp0+r3BthvlFZls7nX23HHEGBkUSRIxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YOqrT0AojDcSKqnRtXqUNbpkncz4YmnEBLi7chPvdE=;
 b=lg8ZhwLZRErIS0g5rJggdP8IB6M5mPSuKubodMvU6Pfjh9lznL+6ziEM7W0AXNzuU7XuqG3rW+B7bwtnp4iq4Zf99BJbstm2Y62vRg7mtWBUEwrDKSyXXeEUY2JS++4kCxfq9FttAJGyBpDuZwhHBtsJJSpEYDnx1rYMwdwtwu5H8Dtl3ZXCJ84SakURziMrkDh6g1jGyycojBRGsjAtv+z2+TdFUr3WxhU2DNuvIk/zcPDgz1dHwkdqav8g9iFXOXwOYemM86hHHAlXuGsMUbE6rpcbhsx9SjzAj8yaWjMHgjXZW+jS0S9Us7CWxkSBh8ykBTK4NqVuBJICkfFTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YOqrT0AojDcSKqnRtXqUNbpkncz4YmnEBLi7chPvdE=;
 b=YA/KwICx/6SlidyO5qhxNL3WH6rjzvabD1faC2CP0J76poGn4tjcYjObu45MPsnjkSJ+sn3buPi44LVXt58yVNsp4dt6qXE7hGEldIExRlXyQ/5ZxL89WQ2Z0QJ4soMFYxtGj2jq3goPJpfip80/QI/YEtV9Mb2QzuyfAJ5zehc=
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 09:32:23 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::f2) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:32:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 04:32:18 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 04:32:14 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, Thippeswamy Havalige
	<thippesw@amd.com>
Subject: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port controller-1
Date: Fri, 6 Sep 2024 15:01:48 +0530
Message-ID: <20240906093148.830452-3-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906093148.830452-1-thippesw@amd.com>
References: <20240906093148.830452-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f89fac-557a-4b03-a6b0-08dcce56cf97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bl9yClukUxYZCOgSCVq8tsz3O8DBLwxytdMahanJ83jQ+sTKzRXNqpVGD3zT?=
 =?us-ascii?Q?GdFF310qBLB2rQKKRAeLHvrzjlcAecjLoLdg/tNJWH2Py+DE6Z+7LYRoTq83?=
 =?us-ascii?Q?h45SSyhJsG6FnGNgMxGi9GPG5xnojNuNkyablSA/lMj9AG3wJELThAm6uF9w?=
 =?us-ascii?Q?Sd2Sz4Ouav14XORYd/3ZHgjC8sPg7+k0jtvDDEBpyfJfywON04ByegkqNbs3?=
 =?us-ascii?Q?uHKLqDrZgSAJOTNoHNxiqiGKUOWpPjE05WbXzuwZsdPDh18KPYVKLEIbrPl9?=
 =?us-ascii?Q?jJlFsACIv0mCQ6Hw4Ngx+64Sn+Ee4MrVt2bMGJQ6ew+9E/adQGDJz+TcIW8F?=
 =?us-ascii?Q?HY1bla2T0KuzcNKE1hX0Fbu8bCrU1bKO/LVr2D1keJN5Z77B3P02SungQRdG?=
 =?us-ascii?Q?WG6NBFpJOIHT4bjuNe2pYhnyVhvqmYFRDN5vGDIQgulDZprkrRHsp9syQMis?=
 =?us-ascii?Q?5WxdNOEBIe3ih9w2u6PKo2unP9cFWxKX2UnZ+UmClPW0LB15vD/yekzoziyc?=
 =?us-ascii?Q?rE4qUfm6OTmfBQb19mPErAoMCf6Nk/+OnFybPFIosKPIrpchm6Hqa62OeFBE?=
 =?us-ascii?Q?ygT0cFO8xn5KMVLoKYpci9T8yjsD2i985WQDLIAoHwNcjYrXZysNwAgHnqVc?=
 =?us-ascii?Q?99oC9plgRTJ+/xSfYGgiR7nSP8Rkhzht0tJ2o7sLXbHWumIK1XUfKIuCtwG2?=
 =?us-ascii?Q?DuEKJQy63Oogx1AP61rgxc1h2H0Nb3Hed5/RBFnBFnYuAzqIZ/s7/9MYk8Qu?=
 =?us-ascii?Q?braXp9yNkCpf1FhFPwl9RuoueiLiDpP546OPhlwVSyIhtcUjgDWlPNyyqYxH?=
 =?us-ascii?Q?GcJ6RPcEin7jVSYjs5Y49QSF//xQgf9kNqIRyU2bUhz3bcuUPQM2tJjuRN5M?=
 =?us-ascii?Q?k4YiWJ07Ova02DmWCG17ltNl79qOldjW+dmsSWJnnxVQmHK1/jzCUb/J/fhv?=
 =?us-ascii?Q?wJEhNWGH0SCQQR7Lh8qADOXPIOXuqlGKC2NeV8Y6HL29xPx4d9WFz7h4w3Bx?=
 =?us-ascii?Q?ze0DVDC1DAPWlVHZxACj+XNlSZWiKqCXxZHkD6YNlj0cqj4XM8n6r16xxVh/?=
 =?us-ascii?Q?xQmFoFeWwTgdjzEwCMQjqYH/uqxiI+DVt6RUYzOl29Uoz5mHs9hsWgNNTvMu?=
 =?us-ascii?Q?0YsuiGdA9517DXsF0F4cs5zFw9vceLFMWMWzL/mtMju0MpX4xnJXHh+pFxwJ?=
 =?us-ascii?Q?6RtquONG9qTqRrHs4nw8ixYYvXkoYqKUF1l6DxlPnqMavfHRWy5jcaoLOyat?=
 =?us-ascii?Q?ZaJrFhHwoLfSxvtAo/VTwYU7pUA8Vn1x09nN++dqLk+W3ncgv7Tod8u4DfIC?=
 =?us-ascii?Q?BbmlLEtekv2sUyyWokxwH2BWpxGOjauhNjeEvaD6uaLTdPt+UmWOK8X1nRYl?=
 =?us-ascii?Q?5lwFfOBDJ4ArErztGv/5Ur/4foz/B6jVQ18Rv3fzwZv4+Z6KHzjbKyyop4Xk?=
 =?us-ascii?Q?wheYQKyJyg8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:32:22.3380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f89fac-557a-4b03-a6b0-08dcce56cf97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

In the CPM5, controller-1 has platform-specific error interrupt bits
located at different offsets compared to controller-0.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 39 +++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index a0f5e1d67b04..d672f620bc4c 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -30,10 +30,13 @@
 #define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
 #define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
 #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
-#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
+#define XILINX_CPM_PCIE0_MISC_IR_LOCAL	BIT(1)
+#define XILINX_CPM_PCIE1_MISC_IR_LOCAL	BIT(2)
 
-#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
-#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
+#define XILINX_CPM_PCIE0_IR_STATUS       0x000002A0
+#define XILINX_CPM_PCIE1_IR_STATUS       0x000002B4
+#define XILINX_CPM_PCIE0_IR_ENABLE       0x000002A8
+#define XILINX_CPM_PCIE1_IR_ENABLE       0x000002BC
 #define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
 
 #define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
@@ -280,10 +283,17 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
 
 	if (port->variant->version == CPM5) {
-		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_IR_STATUS);
+		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE0_IR_STATUS);
 		if (val)
 			writel_relaxed(val, port->cpm_base +
-					    XILINX_CPM_PCIE_IR_STATUS);
+					    XILINX_CPM_PCIE0_IR_STATUS);
+	}
+
+	else if (port->variant->version == CPM5_HOST1) {
+		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE1_IR_STATUS);
+		if (val)
+			writel_relaxed(val, port->cpm_base +
+					    XILINX_CPM_PCIE1_IR_STATUS);
 	}
 
 	/*
@@ -483,12 +493,19 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
 	 * CPM SLCR block.
 	 */
-	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
+	writel(XILINX_CPM_PCIE0_MISC_IR_LOCAL,
 	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
 
 	if (port->variant->version == CPM5) {
 		writel(XILINX_CPM_PCIE_IR_LOCAL,
-		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
+		       port->cpm_base + XILINX_CPM_PCIE0_IR_ENABLE);
+	}
+
+	else if (port->variant->version == CPM5_HOST1) {
+		writel(XILINX_CPM_PCIE1_MISC_IR_LOCAL,
+		       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
+		writel(XILINX_CPM_PCIE_IR_LOCAL,
+		       port->cpm_base + XILINX_CPM_PCIE1_IR_ENABLE);
 	}
 
 	/* Enable the Bridge enable bit */
@@ -615,6 +632,10 @@ static const struct xilinx_cpm_variant cpm5_host = {
 	.version = CPM5,
 };
 
+static const struct xilinx_cpm_variant cpm5_host = {
+	.version = CPM5_HOST1,
+};
+
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 	{
 		.compatible = "xlnx,versal-cpm-host-1.00",
@@ -624,6 +645,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
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


