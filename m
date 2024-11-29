Return-Path: <linux-pci+bounces-17445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B09DC14C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 10:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA01280CB2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC08156C52;
	Fri, 29 Nov 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fI6bzIiw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188C15C13F
	for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871727; cv=fail; b=BGGdqdMLojFaIbvYPYQp3SvnHBN0qCAVZng3ISOcj9nT8ccXZIYftprtmifx55vu2jCfW8ILg/DOgGitz9eMOniXpUEui88w2d+RiBd7P8EdZaBUS7z0RmQCFYew4jVKUfrsaGCxAZd1cYgQYlaJX4wrTcJdfANzHtSWtgXEEr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871727; c=relaxed/simple;
	bh=nAf+orK4g5iZCh9kX/PvqJTSmnub3z+twwGJyN3uIis=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZv5DNr4zPSHkrDtFlhKpyd1iAdEUGPlIctEZmoqecm3q6w0FCgZUeQpCVpDpFnD07L7sN2wKcfkQvTw6e6RaNIcCCN4RN4KLzhqKcgguQDOJjN1Rcl9hy/mPS8jA8tHIF+TghZg2WhAOMpWlznzM6kXg34yOLBnBhccMKd2rTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fI6bzIiw; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnEM53fpCHLqLAsB5H/9ElbwTvkSYLtJVT/iJmtXmJsFKsh86qbT5f6+pTEtR2H3dvz1fj1AhhAngbYEbyfJ/60t9PxzUvS96AziQYw0JZqeb0xOjRLS3rahMLw/HWexq8bZsni5OZ9szkN94gss6V7fZlv7CkPyvQMWleyagcKOFxAH13U2vz1VY9MCSSd332+PVmc2oHsirMgxojhg0/4fchQW3hAXvUg7KcrwW37H/9J2fDbwyazQIQZft319PSopx2XAH4fo5Llamf937WChHDNATYfg+ZWgKPvni607sRh1TNnsbH+HS7RCgw8468jk3Y/+w0b8v3EPwQhQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c37aZF+4FOWAG051g9DOXO/Qz4KTXq06xurtibSAHDw=;
 b=MW73h3o8U6FATqg/IYiv9nvv9TNAh0yZFR0s6HrWwVQ3szmzRigD/XY76iE+SnBLmGpfXTs+8YKURvhQrVWEKuKPq/PIdi9kyjAmXwmkbWpoW1OL+xIOOPfbpmRoRpFjBNpMtvum0xMVmiNAOsp2AMtnYhRoP/ojiYRil5rM7lS0VW3v+HG+oCvDQkAsaeuYR66YZFNYATVDUBQQLIEemrvis3ShFz89c/QQBCBFXJ3o362spD8TLEdh+H2ESLB9tEi1eNp56Z75GIanK/EPEd+xk0TXKIyc6cRpTfATcjP0w5qStBP14NHhKf9n3O2Dq051BnYeUDxNS2FbuBDfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c37aZF+4FOWAG051g9DOXO/Qz4KTXq06xurtibSAHDw=;
 b=fI6bzIiw9rI14/lCVpMunUaUs9ISYP7H2/4vQajDwtKOhi0Q3hklnHtnrb3U9VW1JwLpdwmtUY4L+ZT4oTlDPI1hc0YoyS41cOdWE8XI3y4QclKxOp9LOkWHb5LF3zfzuxq0MApktyJ5YGWnZvjR7Gjrfd8LF3zGeppSgbj2fXU=
Received: from DM6PR02CA0121.namprd02.prod.outlook.com (2603:10b6:5:1b4::23)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Fri, 29 Nov 2024 09:15:22 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::45) by DM6PR02CA0121.outlook.office365.com
 (2603:10b6:5:1b4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Fri,
 29 Nov 2024 09:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 09:15:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 03:15:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 03:15:21 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 29 Nov 2024 03:15:20 -0600
From: <alucerop@amd.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<alison.schofield@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH] resource: harden resource_contains
Date: Fri, 29 Nov 2024 09:15:12 +0000
Message-ID: <20241129091512.15661-1-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb364e8-81dd-4649-0f71-08dd10565a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6l6GnAed0+qSEW5Q/Ct2j4VE5DlfGy9yALBxTxUIjFaZ37p0xXyNHnuXR1U?=
 =?us-ascii?Q?ldF0UJ52OOyYmmPBF7fMwGKvhQRsJzRLMGg0mQTdp0qOT5c+dikYMkVUZC5z?=
 =?us-ascii?Q?l0RWPOEVYB6MezxO1qMNIOB60GC+gLxEhLmWLzFv8ntVCcn9Mzb7mqFiPHm1?=
 =?us-ascii?Q?aWVHr8zkCL7An+a+lUjrR6b8r7GE2mun/5ZyBth9MfX1ecFMrCN4/pf0aJ7n?=
 =?us-ascii?Q?YKUxlMHEYuiqjy+IXN9cBM9Bukbxh0wjAl42pcq1pRDH5cyMWqLFRR+oxWzj?=
 =?us-ascii?Q?IQR/zJnvmIhmfnfB2ZXkxSYvc3q7B1D/dov+oTeRM4TYhU+C0WoT45UIOZbT?=
 =?us-ascii?Q?Yq3P4pdD/4SqgYvGMK2h4T+tRAQuEdiqzj/2c19x2E2CZR31c0OpG+5nMBpv?=
 =?us-ascii?Q?ke+2Qc9EN76n8Wy/ccB5AmAgcqXV8bMKzDparCkn039S1sH6WnHeZp+yZhTU?=
 =?us-ascii?Q?7gsBQREZKNpCqrt/ELNIsHzEQOYWWR1mn0LV3nvINgkeh3fJc7bC9WVWT3fZ?=
 =?us-ascii?Q?1J5m5SU6QTYn5bNtN1T3z3V84/1VgtMqvywu5bp14FloLyFsSZuUKgamxmTK?=
 =?us-ascii?Q?dXIMvoqY8i287E67G56k6//jb7nxCyPt/dtRqLxL7Px59KPDjybpSVJvoafc?=
 =?us-ascii?Q?hcUwN902mDpkcnli/CR4QsE0sBqrTmc3/0nE9yT1TIYlEvlkIbNycdFp+qA5?=
 =?us-ascii?Q?BuDLQZ3c/zbfIFhqjWd57n3am0CU2asnsDgM+PfMj/3rQkkkHj84nyeGSZpu?=
 =?us-ascii?Q?KdNLX0bUuWHMQwlUY0V7U53SlHRHYQinEArlQwjlbmj76PAMOUbA4+Kdn0Y7?=
 =?us-ascii?Q?bpCy9TFuH4Rl3gOrMPri8QtIZFh2Mm0P/xclkkxVkLqKlR4JuOD6by3lGNaI?=
 =?us-ascii?Q?zNhxfC71E5PQ/KlFC1580oH2+h4W3Bqbf35eoVx7Y01hsWWKEFEZITnQyXgz?=
 =?us-ascii?Q?SJnhTN0vnn06ouEnyEfbeHc+kLSCrb1kyNKpjTAVn4KE2I/gNif+eEms+AM0?=
 =?us-ascii?Q?/RHCnFqKN7MvHrdvnydoL/pQ4/T5j8z1NQIsF9hnsVbuwZi88W2NgLW55rD8?=
 =?us-ascii?Q?tAeMWOCP3OZvbmXt+42rSA/cdAIPVtwEXQxFKYStqx+/14Bz7kUc4Mh+0tLk?=
 =?us-ascii?Q?Dnoz/Epvt9jSOOyuOhOA12rUuCYWgC1V38B8AUHDGvS1tKnGySdw9TbhjS5u?=
 =?us-ascii?Q?9JAFSe75Ldaxs48V79SGM0U/SvWIJX0MAnLMm46zafn994NHVWPCFDfdHz+X?=
 =?us-ascii?Q?qGagaYiHQcJWFXwRn3TlbTNp0b2qj2fb+gedawPzX8/aj8o4NRJAI9Pibrj6?=
 =?us-ascii?Q?frV3yLjVfBu9X/bSGPwY2mCjgJDRK0t8/Sfzl69QuPVp1mUuqru5NVO0jEWD?=
 =?us-ascii?Q?veq1zWZ86F3EbEGGX27g+aBsaOYgO7kwX6h9UxR0JpFYZzBCOAWDeeB8Habf?=
 =?us-ascii?Q?UUjrCqx1njiyBi/oEwYi1lV5V/HuRJX3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 09:15:22.0208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb364e8-81dd-4649-0f71-08dd10565a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

From: Alejandro Lucero <alucerop@amd.com>

While resource_contains checks for IORESOURCE_UNSET flag for the
resources given, if r1 was initialized with 0 size, the function
returns a false positive. This is so because resource start and
end fields are unsigned with end initialised to size - 1 by current
resource macros.

Make the function to check for the resource size for both resources
since r2 with size 0 should not be considered as valid for the function
purpose.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
---
 include/linux/ioport.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6e9fb667a1c5..6cb8a8494508 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -264,6 +264,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
 /* True iff r1 completely contains r2 */
 static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
 {
+	if (!resource_size(r1) || !resource_size(r2))
+		return false;
 	if (resource_type(r1) != resource_type(r2))
 		return false;
 	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
-- 
2.17.1


