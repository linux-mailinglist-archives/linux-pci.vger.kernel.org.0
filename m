Return-Path: <linux-pci+bounces-6689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2B28B373C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB4283737
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24FB145B08;
	Fri, 26 Apr 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eUkiWTPW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6F14535C;
	Fri, 26 Apr 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134491; cv=fail; b=ImC+wLBX7pFguqccLSq2vx4oNaoqjekYvPXGejnT3iZdlg+BCZrj/YIwFyADIun/k4BdUiFTrVGelqGaanewNUz0gYSI2G7KbukrXdnFs8XLo8Fq3XZqRNT15JYSU/++SBNUNRoQEq3cPZpLnekOlMVl2isHnVRgcLn4nIxNb5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134491; c=relaxed/simple;
	bh=riFXBKJN2AiW4z33ywwA4gvuJMX1zBckt612L6RUcU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzCPBl0LNgA+5ybAAw36rF+lGTePlbHQjvsd+6n68smIyMqzVHLEs+6SfUTB9ysy+kSf2mbeAVHsMp5K9P7K8DjyJDU8kJ6i8y1Tzn+BLs5XGRlV2gAGV9WdjUIaL5YGOR7+IA7U7Z/xZtFkVh66Hni87Hy49oRd+uzW1T3Od7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eUkiWTPW; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6xZMmSpkqaT1K2MA9pUl6tteyUTVAZbphwArOCdECTyeT/AzouuwVdmCfEYoCficCUghnHkaKaNgEc5VmUWRbdfX6Ea29NnfBShbHgV0dNJN6JGmRmsnVUc2DA531Smo9gFvaxeLLiWPejXWatRYkgj/XYtpvGPoLKmbXbmrNO8BwpLP3gFIsPw1mmZI1+lKlhMUV+Br0gVz/QbDeyo7J/ABZ+CPYbxyH873ee8BErLO5K2SLGpN+2wJ8C9AHG1WW6bEMhWhkAWW8GnMtmBW0cAwYPKk7tOo3OJQpu3uj5Gx+Uslcw9SspHnHyHnKoc/jFRJpWaw3YV9Aq6KQ6UhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poHmnVwy7jh5PlAka6Fd0Sagaqcckqj/ioJ1aSAPwqU=;
 b=BwOtSArknGubvbccAFtZX5VEemVwgh8DnQ8d+b6VHjgdAR5ZnxyIy7970thQL5zeAWn1eUpWT8a0TAsa8GAG1knYoz8gktnzTgvxow7vglS/ThVA5XyBPCKnyMAVxsOPe9sGljPUjDfHmGbBhk7OCNCgqU0kB20TOAQk8+wnCFvnbBVMOQs2ENh/Aa9+RdUtV4/phTuLdS29ZKA7/xeQFK7j8cZulkurSoK/OMo83X/ZnExBi0fUrT/OVwBi2tcUefwPc90aY09RTXA4tpWsNGcJktXk9sfDBNXmtop/uxR1Ft/R0puCvLjO9++MCELrNBwYaG2oNMW1j1iuI12yDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poHmnVwy7jh5PlAka6Fd0Sagaqcckqj/ioJ1aSAPwqU=;
 b=eUkiWTPWxTJqdpalIe7kj9hb9e9DFwbo99VFJ98/35Zxt7b536KSxilDyIf66HXwA68C39DZa8I8nidwPq4yKM6Y6faSRsw+jnpWTPO/7o7Qy5h1Hhvt53ND7NN7sHkgzqYaOuRfpek8ElvYj17tJM/nQywDq37rpk5m1iiTd+fvPmZjWoKud8j+m0UdO5SlClzza19VMbzOsU7uJCYpC2NEQOdA2k16TAm2aCypI8++h8+EDT5lIzm1lbgCWhouVYwPeyMCQZstaT+WWr7vTFKwpTqhZ6M700Ug7d1LJPt4cUgqKVxnM+qiiY7iDCOKXVRKbNBqM4F0N5oBS1lgMw==
Received: from SA9PR13CA0153.namprd13.prod.outlook.com (2603:10b6:806:28::8)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 12:28:06 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::e1) by SA9PR13CA0153.outlook.office365.com
 (2603:10b6:806:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.18 via Frontend
 Transport; Fri, 26 Apr 2024 12:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 12:28:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:27:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:27:41 -0700
Received: from moonraker.home (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 26 Apr
 2024 05:27:40 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>
CC: Vidya Sagar <vidyas@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH] PCI: tegra194: Set address alignment for endpoint mode
Date: Fri, 26 Apr 2024 13:27:31 +0100
Message-ID: <20240426122731.42499-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 543f33ab-b157-423f-a332-08dc65ec537b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400014|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/dGcr5wktF1BKfLq+vV76j0Lv2iOn0xEOOi7Ln+CWSpM3Dxuutq6tqz0tsv?=
 =?us-ascii?Q?n6gKzJ8mmC2yHavF5QqenIcgo1blsFqrhNmrcWK3DO52nJwd+oiKOkJ+Bhzf?=
 =?us-ascii?Q?Zo5w+PhXramogSIFjPxFnmhvNgQNKffXfXWzO6hWXXdCq6bcyDuIvW5ZzqvR?=
 =?us-ascii?Q?hXRBgcZSzET0aWNx5bLbO9TKOP51LHN14ZfbA2c690+eSJ/Dxy070NwAjMRA?=
 =?us-ascii?Q?1DYL0nsaQwAnZfhsljjgKeGZ3mzTp+ZP+VV80z6jDNd0hMHECjZ64r2EL5uq?=
 =?us-ascii?Q?WDPzRZ3sTAvk5E6dURZ/2f+TICxqlzx0hZcwQ4dDngJ6GhYJx4JwfuASxlpx?=
 =?us-ascii?Q?2l6xMPxGl1r0uivOPoo+Rcx1uARD+wnjXeNOZvvwO/8WOqt2T9ikmkY+xQ85?=
 =?us-ascii?Q?nS2cmGlGWtqW0rCH3g5Zls2YdH4Jn6ERMAoEnaq3poVAPjE1QrZjbTf6IvrS?=
 =?us-ascii?Q?EJJooxS3dJxuSEHh6Xuy9fkgvt0bX2n6XDndh/UcnS+kTHj8HQyjEt1hwzIH?=
 =?us-ascii?Q?aXzS7wiz4RB9kcFUUBW/earnqy1T/s3uc5SRb8zAFfaRO+D8Qz79BsrcnATC?=
 =?us-ascii?Q?XlcjFio/Xh9bzU8vowhCLpSmASn+BobGyC1htIsWwvZy0xg54c7tFfn+jCgf?=
 =?us-ascii?Q?2eGoH5LdLoS1Jrgu1kozMaPlwzdSLvZgR7gRQ7AsV9B1WrFnKc7MXQHv1Crb?=
 =?us-ascii?Q?aMWd9X4Xfq81ntTgDWWbZ0BKQ4nSW0dmhDgbm5k9bGqyBPF8NDM2R04hzx+w?=
 =?us-ascii?Q?osyg8NXi22/XLdjJWE0z+XT8WZZBKjqQnmybbGOfMz3E7aQgZNdb7DcocG97?=
 =?us-ascii?Q?/ppiyj0MHaHFe7wJnRq/pZVB+f5K6YAZ60s/0UXP3it8BDW7xBlXb7pUv8f0?=
 =?us-ascii?Q?nFxDoAGLRjdUcs8qiYzwTDjfoisbie9LMvQrUpe1RmEBIHyBrdchWYfqjWcb?=
 =?us-ascii?Q?iuBBTSLfSOnHFA59HE59B2T9iDkkelTirs2JiMEGhAshaQllnpiT3tSBNtjx?=
 =?us-ascii?Q?wpkA0vpVrr64++sDMNXV+E3p2jaaXTWesWWyK3MYAIvEGaZaKpp2HqmR5pFW?=
 =?us-ascii?Q?W8LvEsT20tsc/TFzKq2RQVRpL3oaKzcG+kxzh/IS7P7bWAqB1Ai9bmHg0x+L?=
 =?us-ascii?Q?HVI8rtDkeIwdBOxflJyks3TIf7K2l2lQnjIZafmAZ7Ypgzliedch1gGBhoYz?=
 =?us-ascii?Q?0tDeU3Nf9kyHnF0hKTZHlp3H/JoYcep+tyAo958mxI6w+Ft68jXuWfUmn/kX?=
 =?us-ascii?Q?UF4plzyuXKL7dnqPpa6VeuoqPPoLjAgfa5vOsKtA/hVc1/uYV01jgQXM8GqH?=
 =?us-ascii?Q?8zK2qRKYlTwD3wHCnbQ3cC6kUZ6kUI5u5n1UtCQyY5g59xL7Ex+YKquV0zxl?=
 =?us-ascii?Q?F+60XYF+hukHDdF3sCd4UiYHno2p?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 12:28:06.5504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543f33ab-b157-423f-a332-08dc65ec537b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

Tegra194 and Tegra234 devices require that the endpoint address is
aligned on a 64kB boundary and therefore, set the endpoint address
alignment to 64kB in the Tegra194 PCIe driver.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93f5433c5c55..4537313ef37a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2015,6 +2015,7 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_4] = { .type = BAR_RESERVED, },
 	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
 };
 
 static const struct pci_epc_features*
-- 
2.34.1


