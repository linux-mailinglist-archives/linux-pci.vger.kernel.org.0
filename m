Return-Path: <linux-pci+bounces-31046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE7AED35D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08ED7A7C3E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907D1FAC48;
	Mon, 30 Jun 2025 04:16:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023112.outbound.protection.outlook.com [52.101.127.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4901B87F2;
	Mon, 30 Jun 2025 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256979; cv=fail; b=KmNH/bOLViJmPMXphgIyEOtsB1hPn1ymxjHpJakg3map4Q1jc8g5uNjDIwEHEIoemYYDltX8mjh5uhCF9AlAsi1JuX7sxzwwEMnu5NqYF5of69HLzf+IVX/b3hc/Hvm035PIxLWHnyn9AzGFz8+rCpaM/qO/Nrm/QuaAJXLzz14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256979; c=relaxed/simple;
	bh=3EejdDVXsB8HoqRcDnbybJq2hQrNl3IZuDGLDKCWNdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq3zQN1Rp9jqsoE5xEbdzB3TUbI/bMTIVzv7QhtomEivZbwNr+XC41yvUIQWYlw6nNbDDyb40YiUXnrh5qxEgEctMOBYeub3Lp6VEvVnwwlr4NFrXtQ3XH9PZIROTqJM+zUQ3OfT3zWhMMzXD5B90KITCVw/kgvHut045fNvw8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEDP1YHNh761s47hFrBLHAbtxBGpAGqoEEMw5v27d2Nc3LDUxInvK+F5GDK1inyJ9sKy5DA/LcPAiUhRqO92GLc2J3gVipP2V5f37l2DLJUheYAk8IjO4Nz44Rbzj1yfGsEsjPqf8zZ/ZP/grC2xdfgV3SGFzfOyabVfnf6q1Yrbhk/YGWRfr80zv8yCRfPcrGTsbvcLRkZwzsJnls3luywwsMcEhetttfaiL3pwa2WEo74PiI7gYgG6IaJZIuT/TsPh4y8rx+TORorgm1iWZg3iHVHHAEEJLqR+qxom5RVU8YPL8Tf6U/5GyLuJGf9/b0q0UVpSyCYVFSvM07xBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5Rr83JdYGu2MSvWJTWQMsP9xODEBAG7nJxTs1psBkc=;
 b=E5li/lOZDTcVChMrHJe1YnPIMzcW45rDbjphxOCoKj31BJ+uj3erYOFH+mJ+vyb6sA85XsPNjNhUruh4RzmtNqW5edOD8GOuYbt4xOIeYi3Cmjb6JXlwDqsQiiu/Pzq0LYwAxJnceAuxxA7TpB7ah3E3DMOT6bOCNTGVYQBdJXVwGFkb6Df4cas1CPF9adX+UTfLWapQQ532MnHjNvmz0PQ5cGEO5uS6YmvbjpARPAsYEIcF+InaV4K0YirL89hflMu9Gz7v9b2kSCa1ovsQRcHg4cXTtkHXUbe/sCP7nRlxnX0HeoWB3GxYRS67OWeW8Vgc2MsRkgZI3aawDUJ4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OSBPR01CA0098.jpnprd01.prod.outlook.com (2603:1096:604:71::14)
 by SI2PR06MB5289.apcprd06.prod.outlook.com (2603:1096:4:1e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 30 Jun
 2025 04:16:11 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:604:71:cafe::94) by OSBPR01CA0098.outlook.office365.com
 (2603:1096:604:71::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.26 via Frontend Transport; Mon,
 30 Jun 2025 04:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id E7C3D4160503;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
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
Subject: [PATCH v5 12/14] MAINTAINERS: add entry for CIX Sky1 PCIe driver
Date: Mon, 30 Jun 2025 12:15:59 +0800
Message-ID: <20250630041601.399921-13-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|SI2PR06MB5289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3bb1108e-8ba7-4af9-0a36-08ddb78cd844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yc4edI+YZYxBMw4WA1RWnYUtr9vX3jPybXjiqUtucikOU8T31CsS0l2yJCXu?=
 =?us-ascii?Q?XBQivI4i/e2ZpuM/0KQkWm9WFWZG+6sTK8vdR/vuNf7XO14Kgc0l7dt/6LKF?=
 =?us-ascii?Q?ig49z/zRNDRczyXB7xoM2kqLnfrT5n42hRETDJnH62l5MVjknOMMDWJKvt0C?=
 =?us-ascii?Q?441/PVc6rsNMC3PR0/KQ3ix/+fed4iSXZOAbKaqI/6p64QsyiXPk4qMnOkVw?=
 =?us-ascii?Q?z8TR5HuqUk9i5jt7sBtFupSZGnnD1yzRiq8Q+OBjLJ7ActrVvrhKASSVowDL?=
 =?us-ascii?Q?CI7ZaNndP5nmUysRRyVZooHOYRcmekEXmTZv4YOsBFI0K9Zki0x6IgK+CfJ0?=
 =?us-ascii?Q?rBCNn4Bfg6iTxRqg6/IuijM2NUcEM8V6IQlQlS/G+bCJlrRw0IGHQ+e1hk2y?=
 =?us-ascii?Q?96gpzvuJc1GutIgWn2Ro5Bd7sJa2zcQTzbFo3pdryah/gU9pPMR+ZR5/th4v?=
 =?us-ascii?Q?j92AlvAdILIiLsIk9DGUokpgSMlyAgIj4CDbbEqsKvqmnBKhRmR8liDyZFGv?=
 =?us-ascii?Q?7dNylAORm6D8ZQaRVbvIiYzSgAP+epZsAgRnnz7bcGke1fe7O6gpzd24gwyV?=
 =?us-ascii?Q?91FQG/4qHwWRIvh081e8T3XQlcn9J4R3pTLGvn/EgT/TBDxylLhmMBCI1ymo?=
 =?us-ascii?Q?MnIfmt8CeWK2RCcianWLhHaRMvSD3svVLfpzrY/Yu3GbfhDqTZ+QZqcHqEUG?=
 =?us-ascii?Q?YB2xn6OAN2Fg7kkkyJ1taCqOhFmguS8h9YHq5pMje60ZIHYLPtiSeHPrVtY0?=
 =?us-ascii?Q?frhMwSN2K4f+43Sz0soN95tpOfcc/jEYUBDTyRBidTzXxwWCdRyUzSPfll+n?=
 =?us-ascii?Q?NnJQFXfaWlSyMKjzwy8IWNuOOdAFSMLBNNz2xIFd3yVJx11Rq/rx3ciYY2MR?=
 =?us-ascii?Q?6Z5KQk8HstGUgZeIUBI8n0Gu6Xs0F6qP1V1osuCSGu6Z0V9CIEkFpLsjW0bm?=
 =?us-ascii?Q?xpI3BYRwzuDCDO6cmKpztdMJ6E3nAerRC00vrntjSDPWXW1fZxzUnX4N9SYx?=
 =?us-ascii?Q?0biOLff8gJDcjSX9nprB4ZJRKLy0tKsAivCtFxQekUrLCP4JwKe1zg/gBtjg?=
 =?us-ascii?Q?orjus4QwPgGt3eYMGW8vCk2tTr6XORUwTxi0ViVWe6UNIi7xLdGL+uMhDAae?=
 =?us-ascii?Q?9OZ8jGP8TuHzODFnGDUkhRqycW/cnTwBW441A/c3ycQX0C8+YHarxymT6K1Z?=
 =?us-ascii?Q?fewG94SUeNbx6kM10bXU7Cb6GufORMP+U2c1ZiyLE+sT/wanmhailI8mfKFe?=
 =?us-ascii?Q?/LTRFnkveTRjfB/sP4dtLbegVynrpp7sbNkFuopQUjLuAy4Tz4SPPHC2tGpE?=
 =?us-ascii?Q?wyl3hOPzHAPVDeTAanHeIpZKH500KFpq/3LVuK6sx1+GTzr/egjkhUBjJeJ7?=
 =?us-ascii?Q?JWQnR5BlP1EX8SkU8pHIfZ9aVdlla5UUUOp3e3Pax5TrkmqOgqGrRgNjzQri?=
 =?us-ascii?Q?1GvhyWatYDsQ0msS0hKxNNCLZY0xXG+dTuo27H6FZbCBdca1lSKdrtlLsaR4?=
 =?us-ascii?Q?/4UoL03Q+EApHkXYLi6RfWc9YsKjH6am0f3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:10.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb1108e-8ba7-4af9-0a36-08ddb78cd844
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5289

From: Hans Zhang <hans.zhang@cixtech.com>

Add myself as maintainer of Sky1 PCIe host driver

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f8bee29bb8f..2972e24c7b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18951,6 +18951,13 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/cadence/*cadence*
 
+PCI DRIVER FOR CIX Sky1
+M:	Hans Zhang <hans.zhang@cixtech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/cix,sky1-pcie-*.yaml
+F:	drivers/pci/controller/cadence/*sky1*
+
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
 M:	Mingkai Hu <mingkai.hu@nxp.com>
-- 
2.49.0


