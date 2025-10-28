Return-Path: <linux-pci+bounces-39534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE93C14F78
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39163501026
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE078F3E;
	Tue, 28 Oct 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lCNsPtes"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azhn15012014.outbound.protection.outlook.com [52.102.136.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D581FE45A;
	Tue, 28 Oct 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659169; cv=fail; b=Qvlc4NN4ChKSPqDjNVOJJ+KFmFbPrSuaafR5mnxHKcqS0+h2CMOZiknLLkg4mOEnAsuNBAwXIdeByMLzh+tAtf/tDMfWeDMIYriXurppxdXy8PQ5qQJnTy2rekdH8EeP8SCLSa9oOMgTQnxf79TocXVy0MXv2l66ye8UnfTNOeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659169; c=relaxed/simple;
	bh=VXwNj1NYK04We9O+6IPGIPYNkH5Qw7PU0JYimhICYaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDDJksI3KzGB2/F7DXztzvFBxZtHsWqB/XvA+mVcOjnLKFuyrCVpIhybErZyuTh3QgzBxD59FAYOX2NsP46fSfGjYa7K+puGt/2TWL2V/xeXp3ZuOBFnLj2bM1Ul8/JIcmwJFaBSWBTDrfzW4ClgOE44X4zHPveES0qXVUt4a0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lCNsPtes; arc=fail smtp.client-ip=52.102.136.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDxQ/st6GxYiDzMXVLrVwQX7lJtOK1SMwS96ykH/Vnm8Y+2lQS++llAO9/4n1bQsK6+lPYaPBdrJMcXwQJjXFDSwNXF3wABA+NP+ZOWzCzUPs8IyE5xoNFSorQgYuKs6r/EKjbChYAD530EhOrYz1x6I9HlGVw8evBoSb5mP8g/TBlyA6Wd09z4S/wr+3HGY86cPev9gUPHU2QY2frUUN+i5pN2SGjpzCoo7Pb6/r/W2TwrfNfTgc9lTudFlRL4KUpsr3KIv3104qPbvGdoocO0XICEc/KtqIV3GwFdG81NcMmESK1K4Ezd2nJYmjb+z91wIn7X8p8y8K6hNIW0hKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw9EEbjF0ePEVHz7Rt5+pM8oEMvcYUZTsBf9ZMhPCe8=;
 b=AQtfR5a+qz6jpQejDF59jWaawhda97HynSPH/lXTVnBooC5itPRi94Zgg5UAR6g3qS1z7iWgVRjiUXQ8DISrFRHM710Kzm97BbeP295h9g7gtDAfKYFtnIpzW2ASPr0BpZiFLk3uSXKMeLET7z1kJUhdwy1kO6/jwsNuh+EgR7GHqHMCuZqbVijOIwBxK/P3MTIoGbLxk8Ub5qOG58l1X1wldW09aiRzQH3kOctbvD3VJhgX7RJbtnIxKFF9JMHM6b8daZjRe4sOi4rMYK//HD73qwZo71G03qyh9cuSjwJgwjwDt/ZkL9wEP/fFSmxhTy9EonGrSj8pgAI5RW3taw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw9EEbjF0ePEVHz7Rt5+pM8oEMvcYUZTsBf9ZMhPCe8=;
 b=lCNsPtesWSdM1xgRP/XfYlm76IydJa/bZkGNQtRuLwyjauIfb/vfkj/J6awsSpSOXDbs1NQjLP7UcXRnoCO0/5/3OYplMThcsyQ4hZHKNcl0s3p4UGT6dTHKCfJSuJRVVpXiNfM7BoXFa/tXzTMNzGQpuixcKskTZzkO1K+YUTs=
Received: from CH0PR03CA0324.namprd03.prod.outlook.com (2603:10b6:610:118::18)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 13:45:56 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::55) by CH0PR03CA0324.outlook.office365.com
 (2603:10b6:610:118::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 13:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 13:45:56 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:45:54 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:45:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 08:45:54 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59SDjoak2388068;
	Tue, 28 Oct 2025 08:45:51 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <kishon@kernel.org>,
	<18255117159@163.com>, <unicorn_wang@outlook.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] PCI: cadence: Enable support for applying lane equalization presets
Date: Tue, 28 Oct 2025 19:15:58 +0530
Message-ID: <20251028134601.3688030-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ad00a5-aa40-4816-e088-08de16285208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|34070700014|32650700017|36860700013|1800799024|7416014|376014|82310400026|34110700003|34140700187;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yP6jqyaJhedsKQPr0qFchDfNVkrM6OeNT2zhtAk40k2V5Fw4RzNBwDWtEqPF?=
 =?us-ascii?Q?Bw6v9b1fmW7tkF51ws6MsQGqtcR4oVZLOmVddINqSIyFuHC70NsRkCYKZgXq?=
 =?us-ascii?Q?Fk7fHMrOL6brj7E9MH5mS+Z+3UL+kUFCNk/gQu4DnyX8NI407v1P3O4lRNuq?=
 =?us-ascii?Q?KRN+GQJvGTgdIsqtUIGwlpalCJll0xKt4bGPd82V+ZyKwEAGG6jSlv3Rbo5W?=
 =?us-ascii?Q?ayZ/7y9IMnaGPMZbvCxovB22J0MhaKYDLj12EmUQRlDUT+m025zskZwgvEbd?=
 =?us-ascii?Q?/I35WyGY+7aNmow0MLXo5fjX6sACzDqNm8VqBa+aly+9jDAmoQmz71RJ2Z12?=
 =?us-ascii?Q?09kj8xfuzFZqV2tMVsZ3FZccW4ofkqTUm7w+7P5tr31vN/Jj9ySsnXfGTbsl?=
 =?us-ascii?Q?dvPyxGPzIisYsxuxyBzkB19PvH2rdb9w02si8yJT8D3hsUS7z6LRC+3qwFLJ?=
 =?us-ascii?Q?QZiAXpghbU3n3SALB1R7KxDA/qrt9yTwzfTnAYoV1DRID86Z2vWTRD11DPqg?=
 =?us-ascii?Q?ULZKvG5SA9TEKNr+p5ChkE59zW8EeVdsnPuFj+r+LS2OxvI3xZWJOfGGfdDv?=
 =?us-ascii?Q?iK0dvW7XGQiw0QO7IUIup1mmCXNhNyLv4kzAlVqyx9rEc9wFQ1cj6S9Nelve?=
 =?us-ascii?Q?6yiAWckrtD0rjXwFSL+wOUIeZWoM3wkhCzJFOxSODAnGvcfNCL/zRByA595v?=
 =?us-ascii?Q?9VMeTchFjgGwH8bLjiYvkxb2RFNULPNJAQEYR35waqcFOJf26GlM+t2OglUL?=
 =?us-ascii?Q?/6QEgMGhi3vin0efeIZeTpqu5th5VcLZvfcGEfzxMnRbKDGE/C6/RLlZyn1I?=
 =?us-ascii?Q?Wmo9R4JgdijCqJc9N9y/EP4gD9mrIjXzmnjm9OMrScbfPXFZIgPoy6Ts8klc?=
 =?us-ascii?Q?KZx4bpSbBqWN/obAxJ0tdGg3QtLneBvhr6qODZxCj9qtsdL4pcRu1GLsq6Kq?=
 =?us-ascii?Q?TS4+zfwrb75ww33DWZZ6K7OrB1+dldEuREYrB4LjuD3zbuI+Xz6qidCCty7u?=
 =?us-ascii?Q?/UUNaXZLW+JRHeVzSNNUR1B5wEg4K5tPXwUHstdwmi3Bo5mHarrl/tsethFF?=
 =?us-ascii?Q?gZJiuRByIsTqDo2BGyrJbjuvKy0q8iY8HrllAu0w6LVHdJV8A7cwX0f2CIS9?=
 =?us-ascii?Q?d1O1dCCMZORPNBBXYkU8cmySV+ghIojM0DdFB2cG2lgN4NaxQ4H2owZ3fWl4?=
 =?us-ascii?Q?i6JpOj2hKWTC//5rzCUrx4Dsbxrzly/E91lrNDIXRIPRFaRZSUIQnmXOrL0r?=
 =?us-ascii?Q?bW7QWu+JpGdFjbPxbctl3Rr0T82CrEPFjxF0zdNWkeoRvEiCyzdjDmw72LQO?=
 =?us-ascii?Q?BTd2r8eABjNJ3AwLdvvxg6yhSe2bgqsQAd3JBTXAVnL9ONCZzauAghS+1cW0?=
 =?us-ascii?Q?CnLRPg4FiCgT2WwZJZWdIrBXxlAMrho261UY/3hM8EhS4N0gCdqIZWfmfrjh?=
 =?us-ascii?Q?EA5chaVxqayHWE+7GFSaLuNr63fdjWSMZWWgbuI/3Fg7BdzfC0voSnoRF1eq?=
 =?us-ascii?Q?oXHmEJRYAeNwcQeTjgsaWIOJuYMj7l7ZB6xw7lzDxhRdMmaJunyscoi3/Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(34070700014)(32650700017)(36860700013)(1800799024)(7416014)(376014)(82310400026)(34110700003)(34140700187);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:45:56.3342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ad00a5-aa40-4816-e088-08de16285208
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823

The PCIe Link Equalization procedure allows peers on a PCIe Link to
improve the signal quality by exchanging transmitter presets and
receiver preset hints in the form of Ordered Sets.

For link speeds of 8.0 GT/s and above, the transmitter presets and the
receiver preset hints are configurable parameters which can be tuned to
establish a stable link. This allows setting up a stable link that is
specific to the peers across a Link.

The device-tree property 'eq-presets-Ngts' (eq-presets-8gts,
eq-presets-16gts, ...) specifies the transmitter presets and receiver
preset hints to be applied to every lane of the link for every supported
link speed that is greater than or equal to 8.0 GT/s.

Hence, enable support for applying the 'optional' lane equalization
presets when operating in the Root-Port (Root-Complex / Host) mode.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20251028.
It also applies cleanly on v6.18-rc1.

Link to v1 patch:
https://lore.kernel.org/r/20251027133013.2589119-1-s-vadapalli@ti.com/
Changes since v1:
- Implemented Bjorn's suggestion of adding 'fallthrough' keyword in
  switch-case to avoid compilation warnings, since 'fallthrough' is
  intentional.

Regards,
Siddharth.

 .../controller/cadence/pcie-cadence-host.c    | 85 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  5 ++
 2 files changed, 90 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fffd63d6665e..ae85ad8cce82 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -168,6 +168,90 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
 }
 
+static void cdns_pcie_setup_lane_equalization_presets(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
+	int max_link_speed, max_lanes, ret;
+	u32 lane_eq_ctrl_reg;
+	u16 cap;
+	u16 *presets_8gts;
+	u8 *presets_ngts;
+	u8 i, j;
+
+	ret = of_property_read_u32(np, "num-lanes", &max_lanes);
+	if (ret)
+		return;
+
+	/* Lane Equalization presets are optional, so error message is not necessary */
+	ret = of_pci_get_equalization_presets(dev, &rc->eq_presets, max_lanes);
+	if (ret)
+		return;
+
+	max_link_speed = of_pci_get_max_link_speed(np);
+	if (max_link_speed < 0) {
+		dev_err(dev, "%s: link-speed unknown, skipping preset setup\n", __func__);
+		return;
+	}
+
+	/*
+	 * Setup presets for data rates including and upward of 8.0 GT/s until the
+	 * maximum supported data rate.
+	 */
+	switch (pcie_link_speed[max_link_speed]) {
+	case PCIE_SPEED_16_0GT:
+		presets_ngts = (u8 *)rc->eq_presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
+		if (presets_ngts[0] != PCI_EQ_RESV) {
+			cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_PL_16GT);
+			if (!cap)
+				break;
+			lane_eq_ctrl_reg = cap + PCI_PL_16GT_LE_CTRL;
+			/*
+			 * For Link Speeds including and upward of 16.0 GT/s, the Lane Equalization
+			 * Control register has the following layout per Lane:
+			 * Bits 0-3: Downstream Port Transmitter Preset
+			 * Bits 4-7: Upstream Port Transmitter Preset
+			 *
+			 * 'eq_presets_Ngts' is an array of u8 (byte).
+			 * Therefore, we need to write to the Lane Equalization Control
+			 * register in units of bytes per-Lane.
+			 */
+			for (i = 0; i < max_lanes; i++)
+				cdns_pcie_rp_writeb(pcie, lane_eq_ctrl_reg + i, presets_ngts[i]);
+
+			dev_info(dev, "Link Equalization presets applied for 16.0 GT/s\n");
+		}
+		fallthrough;
+	case PCIE_SPEED_8_0GT:
+		presets_8gts = (u16 *)rc->eq_presets.eq_presets_8gts;
+		if ((presets_8gts[0] & PCI_EQ_RESV) != PCI_EQ_RESV) {
+			cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SECPCI);
+			if (!cap)
+				break;
+			lane_eq_ctrl_reg = cap + PCI_SECPCI_LE_CTRL;
+			/*
+			 * For a Link Speed of 8.0 GT/s, the Lane Equalization Control register has
+			 * the following layout per Lane:
+			 * Bits   0-3:  Downstream Port Transmitter Preset
+			 * Bits   4-6:  Downstream Port Receiver Preset Hint
+			 * Bit      7:  Reserved
+			 * Bits  8-11:  Upstream Port Transmitter Preset
+			 * Bits 12-14:  Upstream Port Receiver Preset Hint
+			 * Bit     15:  Reserved
+			 *
+			 * 'eq_presets_8gts' is an array of u16 (word).
+			 * Therefore, we need to write to the Lane Equalization Control
+			 * register in units of words per-Lane.
+			 */
+			for (i = 0, j = 0; i < max_lanes; i++, j += 2)
+				cdns_pcie_rp_writew(pcie, lane_eq_ctrl_reg + j, presets_8gts[i]);
+
+			dev_info(dev, "Link Equalization presets applied for 8.0 GT/s\n");
+		}
+	}
+}
+
 static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -600,6 +684,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
 
 	cdns_pcie_host_enable_ptm_response(pcie);
+	cdns_pcie_setup_lane_equalization_presets(rc);
 
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index e2a853d2c0ab..39d03b309978 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -11,6 +11,8 @@
 #include <linux/pci-epf.h>
 #include <linux/phy/phy.h>
 
+#include "../../pci.h"
+
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES	10
 #define LINK_WAIT_USLEEP_MIN	90000
@@ -288,6 +290,8 @@ struct cdns_pcie {
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
+ * @eq_presets: Lane Equalization presets for Link Speed including and upward
+ *              of 8.0 GT/s
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -298,6 +302,7 @@ struct cdns_pcie_rc {
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	unsigned int		quirk_retrain_flag:1;
 	unsigned int		quirk_detect_quiet_flag:1;
+	struct pci_eq_presets	eq_presets;
 };
 
 /**
-- 
2.51.0


