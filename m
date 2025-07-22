Return-Path: <linux-pci+bounces-32748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80811B0E323
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593517B9947
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF928000A;
	Tue, 22 Jul 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qiSU+qmQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE43B29E;
	Tue, 22 Jul 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206659; cv=fail; b=W5OoZ5P1XOnrIHNvNmntr5ribKs0IpgdXFokFMrwR+emvzpN7tnx7Oz1cShnDGMq4GWFvlNPAyO8f+3d8TNrz9G+rz6DOvy3zrMXe//XxXko9aaJlxhE89TIkWu5NFLvfQILVLc9aHxyBIBqWd6JAkkC50/CK07T9gy+BXyrkRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206659; c=relaxed/simple;
	bh=oy+PsLQ1N2BJ2aQftvwA3O4fqEmxoQN1bsK1I+xL3tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3PvlCJrmM6LzJHqjuFnj/r49vQ0JYGDzQLd9o6GoHrhgv/gduBL/xGoBITqpAoi6VeK5YVSNLvVqknJKAxYZlFxFUASNkiwxAZ8ww4K8vxW0ME6nFE+15WKW8AylPOsl4RSleHf+tXsUhC3Ejz7uN2LGjlMh0Mak9MpFz7BvTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qiSU+qmQ; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o30VhgQfp0rDAasW0LYljFBpefudOQagcMAl6WPxWCmngOq+1/VNWZCuSR9Tuj/GShPSkccUD1KWJSKiForZCTAFCgjFq6mzQbmfy9v4XMaPUsEFqVW1LDndH/F0yo9irURt6K1+VgV3HqFGyM356vHoh1DMA8KfWHQ2XbJFU6W9me+dbFPC4nsSWvwbWZKVOH1GP6TgBUrz+QDmaSrnAKOJtXf6jer26k8p5uPC2GShL+NBxHxH8UTZX/gty/eGFjbmf3Ghe9UjAo7vBsUkGl6V5et2g1w02Ag0+gS2cmE/ZWXQCPzFZD3UOkpgmSbLhJOb1WMTwPmoL6ZokVoKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+q+N0vLbOO+f1GyhXF44zfcEm41Mltia5/ZDu3+pJc=;
 b=pGAj7AxfVucX+CHKRqdCkNE/RFUmZJI8h4rvzwuJyofl/ojdAyxGlcM9ImFN2wX1lsR1I8E4E4iOJFbCupTkC8xhQMxwUQO9VGveKO9qeCgEq5NXDoO0iRi3eLbdTT6VwI+3tLo/XMamacc3/XuouASm3xFXgpx0A7jKDKdY7cg2wn/t+oJskr4mjCaPMwH8Q5kJbvbi/3bOV8WIX+bbQmZejmt7ZzD74ZWILVi1pZ5ftzX3sSPT4imY7Pi+2xUEMoRIKrF21EeGtNbxvExvabrDlEqdVDYKwmldhCprVKQbe3gHkLzMqcrmvbDcC0/+EsYPINh69ywjy+nOb5mnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+q+N0vLbOO+f1GyhXF44zfcEm41Mltia5/ZDu3+pJc=;
 b=qiSU+qmQ9Jg7s1YgXAZYFxZBVcasxi4qoumNw3Nuhmu5KYMuuCqUo7vCZzR5Wg0XK1lpWD+RmhvyeA0y47xzMW/QoQfASne6QdHqOsL1TJJG/V1WoDvzeqHw7RJJsU+ZYXD44OKYQrtOV6D5z+wInY2+Corlsa7W+XDIzRA3R0o=
Received: from BN9P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::7)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 17:50:55 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::34) by BN9P222CA0002.outlook.office365.com
 (2603:10b6:408:10c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Tue,
 22 Jul 2025 17:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 17:50:55 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 12:50:52 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
	<westeri@kernel.org>, <YehezkelShB@gmail.com>, <bhelgaas@google.com>,
	<Sanath.S@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH 1/3] thunderbolt: Dynamically populate vendor properties for XDomain
Date: Tue, 22 Jul 2025 23:20:24 +0530
Message-ID: <20250722175026.1994846-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4443c0-4d76-4daf-f48f-08ddc9484ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JTNsjKmVcXa/FSiGzKRVF/EHNM/+FNjHa3VfV/yNeCcr8wrK71oht0Ep+4k?=
 =?us-ascii?Q?v3dYletal1fwxekW9TmEF6jeZxTewm0shTZVFX7ymkUYZS3C02NVb/8poIUW?=
 =?us-ascii?Q?NiZ9roqqGzizV1fLSnWT8Z9i0MdDfUnrWTQminSHSynzq7ur/MqwIW718/Fe?=
 =?us-ascii?Q?RiEO85N3bUom7KAclOQ2qVC4dmtqi28ViDdL/yuXAg2cLoAX1u/tGgxPvMvl?=
 =?us-ascii?Q?fCOYn6CHuEFmtZLsnFkIbrWLMVMftNzkPZ5FJ3Gj9x6ZU178kXmwXb+O9yyO?=
 =?us-ascii?Q?XhNFk6l8iww+HYom32j2YBBBdqLSKTkfgx9XQgyHZ+fN0PmXEqfcEPFpUjz7?=
 =?us-ascii?Q?eRoX1lY4IGMYXS9b4JoHhTrKti9W9h+4x89d1p9N9+PO3FTFa9M6b9mRU2o8?=
 =?us-ascii?Q?GzZudw6PqtQjL4ChcuavquthMutnmNPmDfQKKjz0deowhfALrUXJFAMWqcm2?=
 =?us-ascii?Q?UpA30KCMPJE5Toq3QXLz5XZ5SOEVzxWWXepXqIpk2rCwFoxYNOV0bFi+o6Kz?=
 =?us-ascii?Q?uaOyYje312bekMECUJOuWp8whhUvmCgTdqxRB0/zTKMvmUEisQBW6UV9WKt3?=
 =?us-ascii?Q?xhpy++Kpm0LyiHMmUkeHASeRnFrWHZFjCZ7/kU3l4a6XQVlJDXEcdXSifUGX?=
 =?us-ascii?Q?OZQeyQMcdqO4EDBxdSEZ4UaXIJbWGLjD81UjJAYE/BnpRFyXQaHOUwYH0lvl?=
 =?us-ascii?Q?nYCyYHGf1q79xRR/1PrEnIycjkw+bZjDHcAMd4hDXiUzXeJaFQeVZHIF6mZ2?=
 =?us-ascii?Q?KCqtC3nsb/bXAJPb7UwmFWJVVb5oVIJaKiYIWfD7tyITDIW9s0lFL4XinA84?=
 =?us-ascii?Q?QRQvgdMNCRhcy6fKhiv5qhwkV9VUn3fDYiFssLtaArKp6iwfoePiNmsuA8Sw?=
 =?us-ascii?Q?LeY3IZH3PL3ERefUD5qJ9FMEwqvtz+vp69eHWeDDLGXtu24OS81HUJhlhh/D?=
 =?us-ascii?Q?jGGhjkvkV1AUif4qL9CLg4X9mvTLRYUy3F2pYuvQIEFCFaQafXcdlRikuP9X?=
 =?us-ascii?Q?tg73CwyMbhcVuXSTpQEW2X5gqTVp7qRJEGOX07bTKc0ewxisxg2cAVExq6hq?=
 =?us-ascii?Q?fsiRV/0XKXigzihEwLIqFKHPderLULlM8qkp4Cp4egei+wZY9DXCxHM0/QMC?=
 =?us-ascii?Q?aVH0r0fKLr9envtCAle63SFjIOseLZDOlUgCgtOeoQFsWM6r+gYqKYID1BvB?=
 =?us-ascii?Q?QEyl0lgg5gimQfbLKPNYLVlcuRkg0WGN5GPfNedHLZiF5sQAUu53tJ0hLAer?=
 =?us-ascii?Q?/H8BIPBrvIJacdsI6s7RwXAz3VKy0hYdOtygbhby4nr4j2RUC2wtcnNk1qp7?=
 =?us-ascii?Q?od+gzQVYItQs6uTs//fTGa+A6tiu/gCVWIVeoLfwkEZrnu6o58/ItmOBD/we?=
 =?us-ascii?Q?+zpP4aIGL35XyghD50OJ1yM+Vs7Op77syx0Y4zejN9O0Wjx+lJqMOVRLBC+k?=
 =?us-ascii?Q?agHiul5GOg9bOyJuKx3MVFChzpt438iKJi5mP1ZGk9dvimRcvNSWzJBI1yRR?=
 =?us-ascii?Q?ZM4B/wU80BXnKmIbZz8f1x49ROJqM3AJM2ve?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:50:55.2461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4443c0-4d76-4daf-f48f-08ddc9484ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494

Currently, the XDomain driver hardcodes the vendor information
properties, but there are multiple vendors that need to be
supported. Remove the hardcoded properties and fill it
dynamically in the update_property_block.

Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/thunderbolt/xdomain.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index b0630e6d9472..749faa7c487f 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -653,6 +653,8 @@ static void update_property_block(struct tb_xdomain *xd)
 	 */
 	if (!xd->local_property_block ||
 	    xd->local_property_block_gen < xdomain_property_block_gen) {
+		struct tb_switch *sw = tb_xdomain_parent(xd);
+		struct pci_dev *pdev = sw->tb->nhi->pdev;
 		struct tb_property_dir *dir;
 		int ret, block_len;
 		u32 *block;
@@ -664,7 +666,21 @@ static void update_property_block(struct tb_xdomain *xd)
 		}
 
 		/* Fill in non-static properties now */
+		tb_property_add_immediate(dir, "vendorid", pdev->vendor);
+		switch (pdev->vendor) {
+		case PCI_VENDOR_ID_INTEL:
+			tb_property_add_text(dir, "vendorid", "Intel Corp.");
+			break;
+		case PCI_VENDOR_ID_AMD:
+			tb_property_add_text(dir, "vendorid", "AMD");
+			break;
+		default:
+			tb_property_add_text(dir, "vendorid", "Unknown Vendor");
+			break;
+		}
+		tb_property_add_immediate(dir, "deviceid", sw->config.device_id);
 		tb_property_add_text(dir, "deviceid", utsname()->nodename);
+		tb_property_add_immediate(dir, "devicerv", sw->config.revision);
 		tb_property_add_immediate(dir, "maxhopid", xd->local_max_hopid);
 
 		ret = tb_property_format_dir(dir, NULL, 0);
@@ -2555,18 +2571,9 @@ int tb_xdomain_init(void)
 		return -ENOMEM;
 
 	/*
-	 * Initialize standard set of properties without any service
-	 * directories. Those will be added by service drivers
-	 * themselves when they are loaded.
-	 *
-	 * Rest of the properties are filled dynamically based on these
-	 * when the P2P connection is made.
+	 * All the properties are filled dynamically when the
+	 * P2P connection is made.
 	 */
-	tb_property_add_immediate(xdomain_property_dir, "vendorid",
-				  PCI_VENDOR_ID_INTEL);
-	tb_property_add_text(xdomain_property_dir, "vendorid", "Intel Corp.");
-	tb_property_add_immediate(xdomain_property_dir, "deviceid", 0x1);
-	tb_property_add_immediate(xdomain_property_dir, "devicerv", 0x80000100);
 
 	xdomain_property_block_gen = get_random_u32();
 	return 0;
-- 
2.34.1


