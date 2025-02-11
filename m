Return-Path: <linux-pci+bounces-21201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3123A3155F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCBD7A10D5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305726D5CA;
	Tue, 11 Feb 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aSjoZ0n8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB926D5CB;
	Tue, 11 Feb 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302007; cv=fail; b=tKwb+LyXwYeYRoF9FAL/IQJRKhjSp+EOIkVocL83apVJQMrgL+q+kc0LkbL4oS2396AucslfQ8w4ZwPOdE9+R2nLtJqY27e1mh2QU4ltkHEG0TZjt5KYAKRxfXNu1Qd/IMM1irijAzuP6uGY5LI4oN4YpNqsupnH+hC3Jee+QdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302007; c=relaxed/simple;
	bh=BsNZ8cKEUJd0dxDcYy48owjcxODjImgQ0o0l9M2dCro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o79fwcUdwSfywap2MOaoZcj/K6gIwaesnMyUzydFGm0YBjG4EFR9+tdAoTGnHFdeoRzaRkI3fshfjqV3YjJ0ip/Kixoo/RkSRq7M+mQQ9fyTgpv27TSqQ6CCYaD7W4zMlFZcNCrN5IHJvkhMazUI3SwX8z1B9UPqCWXdZyGWVgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aSjoZ0n8; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVmwPWAoDVduYWGyfe70v/xUSWtebmKRBpb2uj7xmYhfwnt+lLrGRv14FMJQCWxhnVWiF06n3iJ+1tfjOgSD+oylcV1Ss2I3ytGMYQB6IhYOhbhKdS1rw36vSQNw0n/qaqjBIm600ToECI59uPA5mf6WD0cZueUJyMF0cm228yTU7I0ZrSUkqLurpEK+MCcgnaAvE3JhQntiAekDSLegwBWGmbVdj+rYukv+NrAcJcPOWryLCJ3R4mRpqYnhKzR3+RXmJoUgZkw0O6mxHJK8ResKmynGKqM6oUouxh5yG/COqCoV+rGkAtqHFYEj59X49piAnKKwT1jVHxKdT6UOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGG+kwg0PLLC9TCgPeuKPSI8QVoKXgMl1SK4YMw2f5I=;
 b=yQrqW1hDwgJKET5O8DeYMyYp7w1BIkUUpM6D6xrOai4aHYNzijcBnIms5crMpFY1pz4yoFGKjnOCsfsx6N/iNLpEMxftx8mYe9QlhSzqQVzL85mxTBugKBw4FGKQEq3wR3QP0bfdYisiKKsnbCZ/BLLPBSQ/bo6IkGIxVKh4TEQYdWISwgwHUANkRYfceWixVxetDUD6lzJVVzysqLbC/T8cwBoxfrulPh4COq8C7HnqTLrTsjvnkYmqpfY1UKXYOaSOUq6geBb266IiKp01Gia7e7O/lMhQN8QCCkT1BgUNMSiRzroNeG6L0XwIU2h+lohFIsNG3VlbGwuvcNUYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGG+kwg0PLLC9TCgPeuKPSI8QVoKXgMl1SK4YMw2f5I=;
 b=aSjoZ0n8wyKqPojP31f4P3tgCiPIKxca5kUt1RDRFhzbdOZ/UfzAbEQRJmlaOzcIpzw5DBOTwh52AWEWsQxBbQPCZyuQxiFSCsQLUeFSB3WiG7eO5HF7nIoYXk+L261O2s+VlM0KnQtZ4gEwUXQ2+5EDEyzN7zphybMaq7FR5KI=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:26:42 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::13) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 19:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:26:42 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:26:40 -0600
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
Subject: [PATCH v7 10/17] cxl/pci: Add log message and add type check in existing RAS handlers
Date: Tue, 11 Feb 2025 13:24:37 -0600
Message-ID: <20250211192444.2292833-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 044b0880-69b9-41f2-922d-08dd4ad203d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XHdDcFBEA+KDe67QUyddcjDGhWXY1p7cvANk4ergeuSu6UIb3CLUV89vIEEx?=
 =?us-ascii?Q?WdlPP2pw6DZPLThvK0dHESYKNWZS2orIiaeA8sUsncC9jW3R39MP8Sipo6vE?=
 =?us-ascii?Q?hcxltfe7C8ozXLCDNSVWBAPIIX7YzDYC1vqGMYlGSdApJASu0YqeXnAarehj?=
 =?us-ascii?Q?Y5IAwFmziedunWjG20ny1KI4HcgZMfSuyWNYQgqOjpuJHMA+xAVRDVDc9oeV?=
 =?us-ascii?Q?lXokplbwa+seMn7aAF77K2L8XctiYUQj3+U3AlRQPoCg89RBmH6Dt7RGLAuB?=
 =?us-ascii?Q?GP49JyWcGeMAkFWrLibwJwJp+S9fFWPnIEwHEjhheocfxuHyoCL4+7iJo2Wg?=
 =?us-ascii?Q?gQHIwl7GtNnzK+VOHXI61wPd6Chlkx31iRcWk4rGSnABEbWZaUxsFyHmufFG?=
 =?us-ascii?Q?dGtr7ERug5NEsSoNdrl20ZLb2NWX9GmwxzrOEf0Pn76VQw7C9K3d67D41DPQ?=
 =?us-ascii?Q?cXZL2oJrW30ibKmq5107zYwU69OMT5klwbidezVtjLRFHMD5qrMZgl7/A91X?=
 =?us-ascii?Q?geek9gezL7XcaDcnb8Hv4qsFebMgbmg7LFG+OcnfKVGFpgA1Bcn5hcuN4gaY?=
 =?us-ascii?Q?AwwiqUQU7g4+HOgOAr+sRF+q4fX9c66dLvtWJvHNdum1EHKFuV3qPHLglwQe?=
 =?us-ascii?Q?/R8FzZ70HyVPa6402HdTIDmzv/s5xFqoKUSdBaMCGpf48Na8bs+6GZc3xLOl?=
 =?us-ascii?Q?zyJQnKPpivOtbAYjGRUu5pYAuyqxFIsML3ze0IFpHuaugycZx/a7dBf6Rsw8?=
 =?us-ascii?Q?2xDSRdKdCOtj9pFQN6vaNGVv8uPLso78L/SckIAN4I+rwvOw+7nyp87Sdpnz?=
 =?us-ascii?Q?VrXtX+mQYfuTmpUYCafqItcGYJ4eQfKHJXGXPHtLcedez0e/Mjv7LdYL6cX1?=
 =?us-ascii?Q?TlJJ8heqnjUCYzmCHTvNm8XwQnRIYa8ZfKomBpPP1WY7K8Zq1yGmqLZpQ3nF?=
 =?us-ascii?Q?TVANRxWKJFxAZfDRQ94G9SOLDDjrBbnL0ZuwoEO2GGcYe2NuAqSObkV5s3A1?=
 =?us-ascii?Q?NJd9WYX0VG8F5ug405q49eGhGIVkm5hAN9gTPddnrmcYIwy1BBXD4rFeE8MO?=
 =?us-ascii?Q?4Y5/OYtqwdBRrbdi2RM0YUbS2BhaIl5mJ+EWrb12IMiwRQ7SgPH9Dc319Cwj?=
 =?us-ascii?Q?J1CSQFPpCngiBfD3/hcyuiSEJRg2xUk9LIPAbn5u+E4BBJajI0OD1DutYZgy?=
 =?us-ascii?Q?i5M6sOHjZxR1R4uLB9FpAtthQTk79e5ak2Jrg7zApTs5OS+YcErm2qgXGOl2?=
 =?us-ascii?Q?IFYArdzxNcSuEOK4Fi6530U+a8u1go5B1Y0EfapO3KepxrFF9uscExF4NP8a?=
 =?us-ascii?Q?NuR/JwEnnQnNF5GGKKA4HFjf+hx8JZyrWwExwiXCZhYLZ7PzjlzxanxB6Xio?=
 =?us-ascii?Q?YQtgUjQkgqRFJf2jURXyYT0Duq19WWruLgCWR4oEkmM/O2Z7ODdNDIiuLj7c?=
 =?us-ascii?Q?lKTfiXbclpN+WnchEXOxFUuEDQX84HeeKg6snLP5PNfYGIJEfFlXjvSyNj/t?=
 =?us-ascii?Q?ZD7ol7e0YCBkDXM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:26:42.3250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044b0880-69b9-41f2-922d-08dd4ad203d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped.

Also, add type check before processing EP or RCH DP.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 69bb030aa8e1..af809e7cbe3b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -658,15 +658,19 @@ static void __cxl_handle_cor_ras(struct device *dev,
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	if (is_cxl_memdev(dev))
 		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
-	}
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
@@ -702,8 +706,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -722,7 +728,9 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	if (is_cxl_memdev(dev))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
-- 
2.34.1


