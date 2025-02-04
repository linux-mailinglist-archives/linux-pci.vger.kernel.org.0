Return-Path: <linux-pci+bounces-20698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C3A2724C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 13:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617A73A1409
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDB5212B3E;
	Tue,  4 Feb 2025 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jG7MDLos"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101C212B33;
	Tue,  4 Feb 2025 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673205; cv=fail; b=Cp31zsu06kkqeHJWmT+1jdcMp4mqnbcPOfuRzXYDuD7lh7U8A6hbmN/paOdtvlrWUqxtbrRyJM2qz9xxhidUt2rPHWwrZiiMl5eojMiSbNIdB233JQ48VjRfyXq4hO3g4k/GqWVEaeRwgn1ZHBO66hkjWA5VQQJeYKwWKchuXno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673205; c=relaxed/simple;
	bh=5Fd4TF3sj92GYjpg8MYn18J8WHvD957aeMdwJ+7spBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL/BvYochGmuiA7v7uh0Hq0yuMs8Nw+puOa2nx2YjWePkHcyPLW+1wi0nt9q0PEGWbhSosUdMILVuqOqlK31ZLuEN2zEYqPCtcxInssRDi9wmAAsbZpRSprh+nGYynFDhiBjgiiXx1tp5ak+vyN27qTrH39vll9grjRKhs97ZFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jG7MDLos; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOnAzcjMXsyEqLxRWMSaE46Ob9tneOQ63hJCz+enDLlsz2WXk7aJ1lH0TLIe3Kga1alnzIL88nsstOinD36Mgvl8lq+vA0KtCEmcq1cm8NPmdqmhv3jqC/SjL1reTkVq6T7Y2IQe7f6YnmR2dukP2GYtYBP/vGfGe1vW+GH/ZqlWCAs2Y9J6VYc1++xD2TMxPyzazQfLhEw+aukgaLk6C5CZ42MjMKyYeEMjm+bQoCZj30Q26quYikjwRf0fyQ70iMZMbhpj1sDkmVPnyuq0rVtKOdpdKYGeiIo9Hd8gZBpYrcjAHEWutFvEZmi7T6lIx7IAPJGlBWgsd0tTjn/a8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmuiMExSuLi857K93Wzl2hGnv/r3L2sbz3CADuHqcww=;
 b=Am9D7VACI2Q9pu22IlHn1R5CbETmCQwqcpJPpp3Kmf0kIKuIGYwFpPY4Jp3iUw4q0lkZanGNA5EtRdfAtxuH4ejFaF/R1Zv1P9BhZfelb/aEJ791zfYqH5PQBxEELlBM5peIYA2AI1+EhO/rj3EQ45TJ85iAUKjy9A1CHEz3N+qfPTmnL3ZysmIr3sp40lYpHhKyAbUr9f6InG2FxpnPFhPUvlkDHZt/9QMs2g40rSR2EW5H/eTrCVPSAasT2XzJoqsPmdzS4UXueZw60juwNcmlzWu6sq2VUuFgo+QSnFHlGgwFQ0A4AK9jcy3pilFvZwql+l5YyGGCVQwQSVlXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmuiMExSuLi857K93Wzl2hGnv/r3L2sbz3CADuHqcww=;
 b=jG7MDLosEgCswPtG81xa/bS9oK+APqGVga3mhlkn+Mtw9CruJj/7/StKpuOBpBm+qM8crJnCPlgOojAXXQn4j9RxQKGHONYi2p/5l5eHJUjcMb5P8NEmSUiM8ySQHK2yFhjKYWLI0wr3/T79md0Mx3oUES0Fiz3TubusgvH1PFo=
Received: from DM6PR06CA0102.namprd06.prod.outlook.com (2603:10b6:5:336::35)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 12:46:39 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::7f) by DM6PR06CA0102.outlook.office365.com
 (2603:10b6:5:336::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 12:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 12:46:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 06:46:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 06:46:38 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 06:46:34 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v9 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Tue, 4 Feb 2025 18:16:25 +0530
Message-ID: <20250204124628.106754-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204124628.106754-1-thippeswamy.havalige@amd.com>
References: <20250204124628.106754-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f30ac79-3c70-4912-5f2a-08dd4519f7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ggrJDNDtZnDbXKuyob2GVL8w79yagFKg9lpPXFhQds764R+KzztvXSx0gMT?=
 =?us-ascii?Q?vDIHeInrc4867NbWFf+w+s8Xmgzo7cWGyJd60q9bx527TvOU3AEYudzwfzat?=
 =?us-ascii?Q?cbzGTgNUOGdi/GST00cv8LfATvtXzBBzhC4ldfXbw72G5TiNeQR5BMNWICjV?=
 =?us-ascii?Q?Hi870xX2E0xNp/VJj5N/f5PsJQmzkhLPrm6IHw7568vrf/Xj0HneyK/FJOnD?=
 =?us-ascii?Q?/wD2mhuyBkeGFaz1TUJ0bQHgDMvO+DpdyMpZ41gqfL1v8X4xtKFvDQ/WZ9fn?=
 =?us-ascii?Q?Ktvqbds4T+pHPO7C3MrIwRIS+hdoS4nbgThTErPJpgJkHp18OfKIeqS8KEbC?=
 =?us-ascii?Q?S/6hza/CHQoO80T9vnTfYKJlJshPrN7h06veyY+uh0vS6l4qZwSTMo08BLs/?=
 =?us-ascii?Q?j4Alnl3liB0ayHIMtWAruGECM2+CZN+SGHnf8QwzfbWSU8oFRgHzfIAU64yN?=
 =?us-ascii?Q?LSyXPF+9f9qT8RWi8V3jJwW2IOWJkFMVvFtIItRWkkInbg+Own5Zl1G8D7Mj?=
 =?us-ascii?Q?eC9D0ENlsonnIWXJMJ4Cmw80D5L37bcmI8NkF+L+WsrN1+6jMAbVdhHVBQEI?=
 =?us-ascii?Q?KlM5bEcTzQmZ42JVkLa0W0Pn+2Sk4qdRbGA0nsV4Sp+LTuWPZ5jhPPpmpgqk?=
 =?us-ascii?Q?/YGuA5sqUDz00PWgmfNVkACpfd8kn/jNGBp6hlNGPypnEWX0O1Nv8Px61hLt?=
 =?us-ascii?Q?7nOe914nvVAVdI5gLRZWdHjFDYY2sUpPS+G7RXvITyEilm3sKtehyR9VsZea?=
 =?us-ascii?Q?KlF7egsA5pEQjdRBdz6SwpNDZCtqB1GBEG0kM59QaLAEdJgw1s6B1pfizqrt?=
 =?us-ascii?Q?WlPYCmhbXHkG5tdvxb9MWpbcKPJeQTjA79ck7X6vLraDzsdVF91DdVbaiQKL?=
 =?us-ascii?Q?tUySNjwlunIg2YuN8U4eit2OmXXeEHbcWanSvLzDPXaZBMhkHd9qFQfPiKx+?=
 =?us-ascii?Q?0V19q7dGuucY07FGyt5mAJZjEhSZje5+XQr7eKp0uClEQs0Xns19XWnJOL/8?=
 =?us-ascii?Q?N9ThDgFwmgPRqv7b8KOISqBKQqEWd+rAQW+ilWwC9WjKYkeHlV+0p8W4pjgZ?=
 =?us-ascii?Q?L1rQeCZcefwL+lMFIIK/fALLQ41lb51YHVrgyxc7QFirfRPvN3z0ITSYGjSP?=
 =?us-ascii?Q?Dghi4F/ZAwyWRpYWFTdH18hBiC3wuxG5a9glxXctJ7lKdieckKh6vDBr7rsX?=
 =?us-ascii?Q?lk+qMAeVxPDvHS0i0p1TJuNXLWsxZK3gHu8/RmigF5Ri4h8HadBSWoHd+dLE?=
 =?us-ascii?Q?wnneHGALiQKiFhgUj8DmMIABuzwrm6Pyr3up3j5Iykh98JBPtWGXiAguhvrx?=
 =?us-ascii?Q?CESEaUlxRoDY6f3Eipeq9vy2HPU8zn7tZcK7a6aaYsXzR1/8cBWwUeIQppo+?=
 =?us-ascii?Q?zkQyzSCzvFejI5d2HYA8SR+LP6vCk9okM4TUQBSCfBppRkEOe9R66Y9NeLx7?=
 =?us-ascii?Q?1wP/7ED/0y0o4MODZov7MmWJdLkngnRT53nYDSqI+zX5W1jhtC1nh3xjf2Yq?=
 =?us-ascii?Q?TrQMFaUL1Q5FFFE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:46:39.0691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f30ac79-3c70-4912-5f2a-08dd4519f7e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
-------------
- Introduced below changes in dwc yaml schema.
Changes in v5:
-------------
- Modify mdb_pcie_slcr as constant.
Changes in v6:
-------------
-Modify slcr constant
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 205326fb2d75..fdecfe6ad5f1 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -113,6 +113,8 @@ properties:
               enum: [ smu, mpu ]
             - description: Tegra234 aperture
               enum: [ ecam ]
+            - description: AMD MDB PCIe slcr region
+              const: slcr
     allOf:
       - contains:
           const: dbi
-- 
2.43.0


