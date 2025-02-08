Return-Path: <linux-pci+bounces-21002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7983BA2D23A
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A581882A34
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A8D29A2;
	Sat,  8 Feb 2025 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pYQcvkCL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA014F6C;
	Sat,  8 Feb 2025 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974708; cv=fail; b=MoqEh9uqLAiTLAZLeU0Et8DipV6YrUb/z4RXqT3p9UhABXt9iJDR86/6Nnwu0B7Bjx8ocpEeSSycNhlADcMgbz8fyrpIMbVQCkm9eiDLwcthuQQ3z1S3IZuAWFRxOVyLjqm9JGrfD6g9OpoIvXKYMRVS/Kg03nyeQbPdutInZrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974708; c=relaxed/simple;
	bh=d4nZTaOMCy6FqOAWOyynD5OEvbkuCvxSrnhpISIvSeg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGfzWA/plqaeHspXsfo6FNKhGCO9BxiU54lwCcuYG9/hY/nX+l/7FKDclPpyo/6dkut1hnukg7wcShL0TtICYfkwE/w2oIiyA4uoAqQaA0we6+luQZsacRi+6nKI3MLMotHcvHB5uXpt/zMvu1yE0j1AGhAKRxHiCZO2PwzrnrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pYQcvkCL; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWq9//wytWtGo4HTNuAcO3eunQ3xj6DhfwPCB/S3HbCkqLM2831pyXXd2nSVnBaohz9++KTiR7cZZy+w7jsLUAlV03svZsalWGpbHLoHVaVwADi/dgWllmTY6yTqnaqLCGFU6Fag/sZeAcKCpOkXFC2nK5ct2h8oLG1ma8wsdnh781k2hLiIo5DUzzQCVSDlaw2TlVXEAXdGNMsW2Ckj7uN0WlpuHY36acHAnX6dxyh8jmdtK8Pses05KQ6KF5h4bSwulyfZLxIc3otNEQYvO7nYjbsNATdub34RMElojkgkArm8pfWJrJ4xQDYT6l03AvD9EmKX5Um66dkvDACUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UOu2E60rqUirroUe6Rnv9ofTJ2vJj7fbfljRFD1efk=;
 b=b2qzA73bLhid+ozI68EzrlW8GGbOHMlj/ePoDMTA/woDq4R9jNkmjg6ZsE2ECEXx1IxZW+I9kd+VO+lRkyUtxI9X5lfZF770NsFIadGP7VIVxu01RKM3kFxqxqmTzxeZXGXVxEAnNeeFKBFtuavtxtphm7/bUMvBf8spSmRqZ+c90Gb7GAisBkLHfnSpz9alttHIcClVPaFk1OaoGF2T6x71kLqLM+NP8eDANdi0WprliyGv0a0gEXVTFnktAcAdGjJwyoEYRlq1zIz4m/0tcOiMTBb+b9yFynRcEJDiFhy45B0TAPWLQCBcEsCUoA/K8UtXNPn8hKFpcoAipktpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UOu2E60rqUirroUe6Rnv9ofTJ2vJj7fbfljRFD1efk=;
 b=pYQcvkCLIEicgI591XPqS0cfrwn/N+6z3zaYntjPSSlDFK6GOIcGhi6dkGBxW/arA1QWcIwuiuKZAcCoBh04ydMCL+Gd3fwcJOkO+3NcXCcNM7Cor6UjkzBzYeJK+L0l+hOz9kl0aoTqcjyC7tuJcTOEQPm0QRM6dzqfWVF00qA=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 00:31:40 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9f) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Sat,
 8 Feb 2025 00:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:31:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:31:38 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v6 10/17] cxl/pci: Add log message for unmapped registers in existing RAS handlers
Date: Fri, 7 Feb 2025 18:29:34 -0600
Message-ID: <20250208002941.4135321-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ae9b61-e53b-4649-ddfd-08dd47d7f468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U1rBXOxkRROurM9wUWLTDf1aBNC0QjlIW/8oT/QfMxSiwG1jroCVngg9omED?=
 =?us-ascii?Q?vqW14VqEJLjxIiYs+Rbsexx0Z63UV3gRMJII/7CvOlw4etQ0mHf7IVndY9Rc?=
 =?us-ascii?Q?tbW9y+pzSkX1UyQko1e8ipiE7crhhPTLOr0QUUXd5WbBna4YGf+pBUWv57NB?=
 =?us-ascii?Q?Y0LF/n7y9rWjwfq2MrD7vC3ZWMz5j3Dnojp5c0c/gpgy96RZ+La7k4n48ExS?=
 =?us-ascii?Q?cy/cYnAou5uH7Y3dTkretyHWV2dvyocAmEnAOXpn9jbhPLSVrzkHRLj6sNym?=
 =?us-ascii?Q?k5fFYLbUnaX3gjwQz8YSnLWwC118JFruE4UBlo8ChNK5UvJhBJJw84TeQZ+G?=
 =?us-ascii?Q?auRCUM482nwX3s4VUu38ERH7AWwMoAiQFOgy+gwzJAbXjhnkQHR5HmJDOZ8Q?=
 =?us-ascii?Q?Z/Fnzy/MgCePN4QABIvZSgIaXr6U9hovP13cHxbdKv7KmgHMlT0R4wApaQIJ?=
 =?us-ascii?Q?Cva8Q0i/TUAHIf/sXjH5rB158ClxNXOzWZaaYDQnU59K4OqIvSxnclNfJ7jn?=
 =?us-ascii?Q?BWfWgh6S1ZhqegcDRsVkxVB9/eLIJZecJEAvOGsqjU22tSnf297PrL6NHwfm?=
 =?us-ascii?Q?A2n8JKhyJsYLqYLY5GDwcK1urLT2RldBHnsC9yccz99NBhiTorPvtxhzAyM5?=
 =?us-ascii?Q?9dzWMY1a3j1tDM/TiHOiiakCe3EI9bXDJzUbAvEvwjAetSKd4mvOu4fqnnJA?=
 =?us-ascii?Q?Y3qpkOOoZAqDa7gpY/+JsUEiv79QbMTwdjjcnefgt9biz/MKFFXhL+YSjEZd?=
 =?us-ascii?Q?8PlAsddikVHNxO8b3jrTVpChtF0i6o/2GXgXv/8ke32ucaEzBWfWzBmZTGVJ?=
 =?us-ascii?Q?oyDMzLqnJ5J/26v3SiicxKThfUERX0h+wndzOd8m7tVc//ih2LW10itkf5Ts?=
 =?us-ascii?Q?UrJ77b1rOUCNM2sQZbSSVV+FCgzl6nF9TGfExJD7xYqyBBWKB6hpwoG+ROEw?=
 =?us-ascii?Q?FPon1TjV38V3DtpH8fk+VMGPMiMjnc00A5F2cGC41kqvWqRH2q0fy8gOni1p?=
 =?us-ascii?Q?bMlMzkEZ12GmVhITr1WXMgnh8N0BHtC76o0BRyao1YydKA8MQ8sYn/RiAhbI?=
 =?us-ascii?Q?w4eDrJnzyARLMBzndXue6nXlscRxGUiIbowWj9DBtKz04WsCfEGOJ2Pkp5T0?=
 =?us-ascii?Q?2yHLSSpkNU4qHdHE4Ch9XUVcyeHE26hXA5kjLgNK2DeXBqBENalobuLQrzZw?=
 =?us-ascii?Q?uE0NuWwNiN5Nc77W10+G9JP192tznObSqeyHKwPypAw3JvfKruuSnRXTN2up?=
 =?us-ascii?Q?jj4fKAVw8uhnA4iXzMdwCLPIA1CpRU3I3e+iawufxE+4sLtrdpl+SKIMd9Gu?=
 =?us-ascii?Q?VIMR76YaoM/ouA+iMMw782d2b4TQdfQuHuex5mkGtth0I7XD5T+qwz4zVBGJ?=
 =?us-ascii?Q?fEko+XfNejwSDkXT8KKU9MQeeSsNBhg4+ZsJ1H61tntLCYDLbJ/Mff7yqAxa?=
 =?us-ascii?Q?jMwJ7Q0rgTOvqEJ8e/J5/638iVh1t48D6RG7u/s/AXhv6CcqsjAGA9vXL1/N?=
 =?us-ascii?Q?PcQ3SNwVv2hawCs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:31:39.8813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ae9b61-e53b-4649-ddfd-08dd47d7f468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0adebf261fe7..a99ba1d6821d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -658,8 +658,10 @@ static void __cxl_handle_cor_ras(struct device *dev,
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -706,8 +708,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-- 
2.34.1


