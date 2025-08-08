Return-Path: <linux-pci+bounces-33602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3680FB1E359
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E411AA055B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642212459D7;
	Fri,  8 Aug 2025 07:29:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023112.outbound.protection.outlook.com [52.101.127.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1900236435;
	Fri,  8 Aug 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638182; cv=fail; b=nVvmc8C5nksh/xxn6+gZs7xAJ7MHN0Kb5xFeMw+edR13Eqh9o0cyAdqKk//TuMeuaKVBvNe2i1IRNB6iuUYy8mpx0yOGydTH28cfRyiRFYysTZbXMxQfTENzwR9ZZtGYrMIoGYyGoQ1juYaf7v6PGLWNXJr7yiWmCnIe69t4sm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638182; c=relaxed/simple;
	bh=sl7/VabDxpHGsJdbr1d/h3Rhe8ob4l84qjtjnRrrR1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPzmbJYNHSA0f5AJ+tqbN39qvKA71f1D51EkPEydxY1hwH9KGSvZdtXpVAkHQBxZU0ZijDdVIi68yEMpUxYivNkXd06uhBVG18NS31d8x+gkRtGLH9IO0yZJk4rH93K9gBSLXIK+93388vKZBY09RGFG2nhlE7GMQOMKAFatXqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFM+yWOdR3UkqLwuXPBlgjfGD6XK7v07FnCuAVi9ZN4MCB8phvEKgawNKqmpdJ27E0hP9buwjbtzlR/teh6mOOzcNfQzGU8wWhKyGT4N9+wKVz5ZpztlIj431oO7iE7gaDucoiMcfw3Jh2/E1BwG4rsNANOGebWJGesRLwYIOZggmURmL3dUSaQKSbbS3q29F1+n+jciGnYgysJYUH7dA8jL2Rc9UuuJF9byufz1F/8EioPzSUMWznoq5EsdpeLSuM7KEwOVSmviKjSUKk/nAoF6bu91d97XzdFEVJZI6V5hbD+IRZxxia9PAmjWiSIoA5kB0mK9f5eqLv142U9QHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOcYy8CSvCRKl/kPo7gnSb4Du3AmwoR5HWuzhkGaiwg=;
 b=rtdmkAv6ATsIlv/dOPx3q8Tcq118DsxHvESDzusT0UDx2wQDPnSzd6BjPwWL/wQI/aXZMl3PtkxN4Qlu98RmpTOHM2NTBbvh+arZUIVn442Z53nquV97E33scyilIQviOiVHLCqYONfP8zOjV4uP0ZjsjYylowB/cmx1e0sIkrIJ6ismvKvFZ/ImUiMt6L1juLwLJwXwcEnja/mrc5uyGCTca3nNMXoIySqG1NGCU5dKeRiG2tEc2UyE2h7/ItE6xEujUral8xK48jOlAtkfUTG0vS4h4nDCYlEDEwmhKlAXSFDyznzQzpeFtqZH3J9WalF/wi77PIgmT0oOgKdiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0036.apcprd02.prod.outlook.com (2603:1096:3:18::24) by
 TYUPR06MB5946.apcprd06.prod.outlook.com (2603:1096:400:347::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Fri, 8 Aug 2025 07:29:36 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:3:18:cafe::c6) by SG2PR02CA0036.outlook.office365.com
 (2603:1096:3:18::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 07:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:36 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 97F964160509;
	Fri,  8 Aug 2025 15:29:31 +0800 (CST)
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
Subject: [PATCH v6 10/12] MAINTAINERS: add entry for CIX Sky1 PCIe driver
Date: Fri,  8 Aug 2025 15:29:27 +0800
Message-ID: <20250808072929.4090694-11-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808072929.4090694-1-hans.zhang@cixtech.com>
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|TYUPR06MB5946:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22ccb7bf-d985-42f9-23e5-08ddd64d53c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qlTYVixLBQRXIXO7wKvdokPuXbGEEQwAFtz2boYdpIvQ2YDU2ciDI/QoAQAE?=
 =?us-ascii?Q?6eP1o0jhaz6CLzJSSlBOwGWekKgN0YNjgNFZNmZk4b79+T+8CSqmRSxJoyd/?=
 =?us-ascii?Q?C1NtPYgLhLuCdE7peLO9z4nJKDe+73fvAdQmq7XHViXv/Xv54JWOoyIhTXgQ?=
 =?us-ascii?Q?7CBbvXuPtGsDGLFpPtnOxF5t8pWHd+Y1ibvgIc1YEfTqKqKOXl1etKWSZxh5?=
 =?us-ascii?Q?hEXf6e9J+uTAalit3Gvj1q1ARWMiDba/r+G7lg2OQZfPrY6P2f2fLKdKDmnH?=
 =?us-ascii?Q?6nnO8LIvS5v2eiYJBhUWIrVpr85k8csCca07IhyD3hx6qarB7g0KnRelfhTP?=
 =?us-ascii?Q?ZXRPVM7RrdaUR0ufz/PxkMpXHdN/100qIjUPKeG+qjyhsBRXZkKkxSPkdNZO?=
 =?us-ascii?Q?OTRlhHLT4CBSwrUVTUdii6bulMsbV6Z0tEHCHHle29z170QqknZWEK5WpD8f?=
 =?us-ascii?Q?EGXRnZIJzXDy0fO3rFUpHDEwTEz+yO5ptT/yUONLrlBKG/oCtR4J07REIXMi?=
 =?us-ascii?Q?Vn8AfVzynWIvkZFiyulGbooF1tqaQxT+6Wyn2Y01LkJYGtyEddC0+Fp18KmF?=
 =?us-ascii?Q?J3MrD2TfbHOHbpduNXnwlVfvjRUyO49vdBjZNzgFcI4SJ3bleLShLiuDBgiC?=
 =?us-ascii?Q?5sDLe1+qzRhMblQXDzULw2ri1jz6v5+NuXHQqjYrSOp9tDfCBD5Ig+BoZxfR?=
 =?us-ascii?Q?1BOvUYadiLgTcZHezymysWQ4Qoii2hQi3xAAUFSK4Dczp24wx9NmS4iWhN+5?=
 =?us-ascii?Q?jANfi7CDgYGLepS9jMQAcTQaAUrMhvxNBLlVdDvoxFcYz8x/5iRw5SzjG2pL?=
 =?us-ascii?Q?VZBYa4W+0VRlzkp4C6Za7+Qj1vKIy360WJ+B89gZkWA9F3M/CAIQRDdz5AlU?=
 =?us-ascii?Q?3QuQyvClTB3APQFO9PxVRl4yhn6R+FC5xppmnZG2E08PIoIVa82mmDMXMqR8?=
 =?us-ascii?Q?BvDk0cjhmOyPwfYAO4TLlKqC0UaQrorja5i2t/C1xnvRz1mWv1ZiBdqcpkZt?=
 =?us-ascii?Q?cMkyN1Nt955d5vqsIXc01qvpIQgIwTArZN3U0O89oNflF06xpNeQlq1S5+bL?=
 =?us-ascii?Q?4JX9SQtxzum6N/GSb9ptEzbeAP4taISy5o1s6OVsvif3CD9ct9oBbhqiedkX?=
 =?us-ascii?Q?JSOFvDJqh3ND36fUpwWfgB85uux97F9fYd+R8FOK0j53LIMz84uQhAlW1dKG?=
 =?us-ascii?Q?w1DX8mh/+XVmsARI0ljGgsUWuKRoN1ZxCjYaxNE0o5/7FP++i7D/g3jdL4ZN?=
 =?us-ascii?Q?iXiSilB21VvE2G5BXoCN4EzOmtG80SVoIa8doiwoA1xAWGBdcLcQQ9jkuWcf?=
 =?us-ascii?Q?wnT6NTXxFMrnPt1IhmzsX32Ij1n1eQn1E6Lm6pXyO9alf2GqwayTAYGqbC3P?=
 =?us-ascii?Q?z+0AsGd9NMbhknwNyBRGs/09Vr21Fo3gsWfeyluEvCtSs5hJmhwIaUeenfpi?=
 =?us-ascii?Q?RxC81TC8oPSv3h+rzc+4Wfsvg/3vn6mX1dLovgX1Ln8W4RGqfV4cud3XwVcn?=
 =?us-ascii?Q?afNYPPY4jyLpDL+bOAgZ0gi76d1//5rdKMKp?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:36.0869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ccb7bf-d985-42f9-23e5-08ddd64d53c5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5946

From: Hans Zhang <hans.zhang@cixtech.com>

Add myself as maintainer of Sky1 PCIe host driver

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd62ad58a47f..9cd32ea6d60d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19253,6 +19253,13 @@ S:	Orphan
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


