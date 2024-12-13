Return-Path: <linux-pci+bounces-18352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A69F04F1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 07:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580EA16A3D1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D055F18CC1C;
	Fri, 13 Dec 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="abz1q83W"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4D15383B;
	Fri, 13 Dec 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072066; cv=fail; b=Kd9+mnkBs8DIVgEx+j4g9zLFtia0emTOaDMvNF47gsO72LjqiM+u2Q6XHgNg7J2YYrlrnw2CwE15eXk1f7O2R48NaIxQER/lhLE3rllzALY7pSXJKpmSRMKZRTes1XaTDY0MgTAKOUIN3R+W/vEJBHLkUrbsxf3zmv8S7tYGREY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072066; c=relaxed/simple;
	bh=LUkd46oYVoghRXDPs2DqCXwa+H6TZuOmbobrY9Vm1mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cl78pqjMsQY72R204mHHWmxseBCgeffYKSb6BffwxuindNPWxG4GqW3B0slw8F82mFbGosV0leU/aiFtviUeFfGxG2FSVSGfOojnYsYsgFtBeFtGaeRiGe+NEiEyN0dyxERU8tqNy6+vGgXB/5p7IwgwO8dVyCbQApnm2TGc5LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=abz1q83W; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUD6AeQxvkYb1qBLqut+FE/jWcM+/NQVTIhykyPEh6KyvqQEJiqrNvZcytM6qoGimQvXx4ZyTN0Vlh+3cimbmUaiQgb5ixvw5hDE7pEAlBjm6P4Bd0ohzquOr6XQKrv/pqo2wQLIXZ+MLzasTXspfXz4rojjQaby+v3BNZ8pwXm/EZsoMP+3QPa/hPOftuMuB6nySbG94pWkcdefulEBijvAA7Gyok5i/zLR4oEVAZe4KtLqmXKcXdmbYWfOxcEXvkgfUOFMjny4mrDdhDGIKkvPEJxLO82z4woSq9ZSU74xXhuE+wATdAsidwFVpetwpoyA6yT1nokc8fxtt6VPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTxvKM27TnnFZsfdDmKzFnnw3NjvXD91BO8p/poI5Tw=;
 b=ZCu+Z48xaR1z+LUTop77kl12e7m3kuM2yjoEs/AuGSgF9ZkNhjvRsTnFGSEHtfV9Gx3g7ipP1qFrTEbNtTRHahjOjLRNXe2IHWhIb8am9VmPcjlAMBV7/dJotvHRpKel1Om+HoUm5Kg8jpD4xhXrL415MAnwJqW9XjJH2tZhlEnkvAL1Gp9/pvue6d+1aknTz44ymSLvhplEvH4jXx2d6cWx2ZmmBBl9QqqgUAFWgU41a1sKLcmTVGnn+ZUIjpwWU4ZWrZoj7LFAxGaQ7rE2qGKivGt91vqytHyOjI8yWPsKinCRZHNwaeLK9slLkhz8EdI6jsPxz9/ph0jF3I9yYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTxvKM27TnnFZsfdDmKzFnnw3NjvXD91BO8p/poI5Tw=;
 b=abz1q83Whiy9N/gbe5pKkF7mzr4eMLy1jY/dZCoG2Ptxua4lHTwYEWXiomLZDEOdli65oMh9zRJJ3qjQVDA7pR7U2nfswSegPyouEEOdxHLa4nA7B/ecXmWv2XVCCXmqLH0AHMg3NJeWF/XRvLeihqovfs5LznIqwfQl5jmsR9U=
Received: from CH2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:610:4f::32)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 06:40:58 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::c9) by CH2PR18CA0022.outlook.office365.com
 (2603:10b6:610:4f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 06:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 06:40:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 00:40:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 00:40:57 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 00:40:54 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [RESEND PATCH v5 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Fri, 13 Dec 2024 12:10:33 +0530
Message-ID: <20241213064035.1427811-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: fc99e482-fb58-4530-5cd9-08dd1b411a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?38Q5J8jb4Cs8y0xgGkMRbGd6N+Z6gddyYgvjcqGrvJY81rYedyMSvIo/3Rra?=
 =?us-ascii?Q?iOF6vcDcXtCNwovO+wzmyUHEJZxlRhQjMaLkFQ0kgXxfmP8SAFBALngvVAAG?=
 =?us-ascii?Q?Nz4eg/Fs+GnxXiq8u4mgraRDtzNA5pv9SdDGinA0LUa9krUl/Kt3ExyZ60om?=
 =?us-ascii?Q?j0239cPZ5cvb9RNRRKs2z3u9aAuPiw2VS78HGHAetG1Xn8J9j+60YWCnzxAL?=
 =?us-ascii?Q?Q+Px6Y/NOXl6FqGLSDMmlbd3TBQs5kFLGhcbH06CTxznQEgol5P6jmgEwyJz?=
 =?us-ascii?Q?314u0/RmKj/c1OnJXF1GI3O4Fo8S3UCgwRxWVC9wMmMSb3A8UK073feGqkpw?=
 =?us-ascii?Q?9JK47t/jeiZDA+vWEpZwm8Dw4/b7QLz53ObJe5ycuIHkoAKW4QNB6CRHrJha?=
 =?us-ascii?Q?NKEgk6YQw1K+2lNSBGHPydTOIXZDLz6wybGD5kvgDlC9uEnfhDO3KcsWjsXN?=
 =?us-ascii?Q?HIx2VMMBU7gCLScw23dUEHB8wZ7BXZQhysHIeKuoFwKSh2Gb+Kh/Sc0E3Nij?=
 =?us-ascii?Q?5rAAAsuP91FrL2CA3sVf6Cs6mbC6NGFuZUoqIN1K4gywxQaXFHr3/xFddoKH?=
 =?us-ascii?Q?bBepguxXwJ3euJTY0Zqxdhfx1JzVswyMSg3jPG9EKOZT/KpfBsKlkrw+8KQ9?=
 =?us-ascii?Q?1urMfu74VpJ+3g/3vAkyPFteSHw4ZjPNam7BzFjRj8HP4w8Y8AvUUJ2RGzTX?=
 =?us-ascii?Q?mtgPau/H51DqrsBb5mxwmCCzmdMWmD84u3fh1kw1wE6Byh0UiLXe8zlS86RI?=
 =?us-ascii?Q?K3GtnKWUBqR+1Qz5bmBJV+5AE8RW3UPmhpTnbbwBnBjCs4NNE145ur83D9Nx?=
 =?us-ascii?Q?HM3V/bEGG8AKtiTHU901in7yizIYuHMtxNVYNLXP1TLza18bu9R98t8V+R+/?=
 =?us-ascii?Q?BYZKJxbQqgD+Jz73623s1S/C6/DQ3r7b/c/tHiAuLlNArVtuto+h8jojVmco?=
 =?us-ascii?Q?uIXfCHNxpWgO6TBAQFGu3A+rE0xUTiJhw1By4+XCcHHDo3WShkqt1EvtBOJj?=
 =?us-ascii?Q?TjLGR3oUBPz8FcE6cVVKywl3NNqB1zkzhx7cGcBp4HWGDL2fF8PLh8TPvSjP?=
 =?us-ascii?Q?Povu85JoHYzgF4oHTGSJDZ0Ip84J+Q9hIXJdIZSa+Ml+F5tmWKNLpyYGep9x?=
 =?us-ascii?Q?nagxZKFIo5uS7rvbcomAAuNesjgeyBkBRgAuVdPvnZNHRfksjeoXZVnTBrVY?=
 =?us-ascii?Q?oLxg1tfawCMLmJAwembWFzU/5lPF1QcOYHiQHMpmyyqOj+ngBl7lJIxmT/bX?=
 =?us-ascii?Q?Mj3MTefuIu0KBTbwRxP31fcngTjUVQkaj9OqhIogmHyW+Db+LyWqwdoWjuP1?=
 =?us-ascii?Q?2nAUICf25brP1bw62Eq1Wp50XhAQSLP4zsHRrZJ5AZgHLhsuG7JEBn6UonwX?=
 =?us-ascii?Q?eU20O5GNbpPcCdZQusZ3Bj3DH/DxzTycXJ1E3HvBlIy0FTOxOkPFTSi0qiAf?=
 =?us-ascii?Q?ftmzbpCMblOBngVov1lK4zoD863Au3dI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:40:58.5493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc99e482-fb58-4530-5cd9-08dd1b411a6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Changes in v3:
-------------
- Introduced below changes in dwc yaml schema.
Changes in v5:
-------------
- Modify mdb_pcie_slcr as constant.
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 548f59d76ef2..696568e81cfc 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -113,6 +113,8 @@ properties:
               enum: [ smu, mpu ]
             - description: Tegra234 aperture
               enum: [ ecam ]
+            - description: AMD MDB PCIe slcr region
+              const: mdb_pcie_slcr
     allOf:
       - contains:
           const: dbi
-- 
2.34.1


