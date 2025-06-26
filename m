Return-Path: <linux-pci+bounces-30861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F96BAEA9F0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBA01893974
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D008226D1D;
	Thu, 26 Jun 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zs4I6pPA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2472264D1;
	Thu, 26 Jun 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977931; cv=fail; b=NMwbUhwmpTM5+JwbVxIEZ6H3HCs0Hiongz+B4U+YZf4icS43oZ3BI6muu4QmqgeBQjSJV7AesaQzYYk4eVEdbKIRQkmzDMQwTH8sixKqHZIYZMjrdj6lTKIuEUbE7jfJy3vYyTrwQ9eMPXwr4S0lgSuZi8OoG8iZ1oaoW7LeSaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977931; c=relaxed/simple;
	bh=sCB9oJ60tPT1piurbkDQMvey6FT0Y9utpU2jThvp4Tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAEl5GBzNFjl5bCC4ksAZCTWdF/9uT4JxW6dYubZWmjo/ogJtnJKqdqCzBeT3ICwHkYRozmt7N0JTkYwsFUW18wgBUiSXBSaydPYugbyogoPBb/iAZFCkkyXz9Xu+k3fW+RdAO/Jxbc/uEgSnS2f5gjHA5HAFdkLLeAD001ncDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zs4I6pPA; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlDhoYQ+JmG3oe+aXtKUBQurH7kVm6jr6VHha7IbRNDddYpxYeUl72wVAXB33jD2rC9C+qFafIi7ycQdJ+kQU5oZ5oJgLzfr1TcIfLY2PMcU80X3V77JzZvqQxW7UfUmBjGhQzcPe7CDc10cGY3GuyVp5/v62EAXJuV7Ei1Ks261xMUUQr5oHNNtnqLSv+j6PxsBBmyJaJ9cF588i+4TO/ipu4w5H7CwrfoDwEx9iJAve990BAr6BtAVc5Gh6bN19DRvlc0ovZBcCg0K42JXcnGSk9E6xkwCICkIL0nQZJwVSCBbK1ASpTEo8c5sRj4tzsJa6Ezz442m5BGVm7QW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SiMczQlkxq8cRYmYGK3LhWYteq6kTuAnBVwFoqWJEQ=;
 b=q5vPpfcTPherYFJSrDBeuxdwy/XCNQ/hA03tbZCza+/RdEFLbPQTmnUc1KKMzybIjtxkq6PnU269BnjDEUbSph/LUYYfkIh8PZqhxidNFEiJZhIGrdfDCVtNoDjTqibDDrndl0ukuux2D5bXOpU7R7h0idrQHKPLgTH+FSjee8Nks562KduJHssDRffGv1DLipFf+SiAmTqeiq3aAOacXA72olQB8ofPS5EOhmlqcAnCnovHySyCH1ANCgokmNFTRSeIxoZI1vMJMz4klXceMgsQkzdhmts5B3h3Xo6lW9jccsXXnSXNZ1oTLlbBDHfoyvg6NEsCUKgdf/SOnc2mhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SiMczQlkxq8cRYmYGK3LhWYteq6kTuAnBVwFoqWJEQ=;
 b=zs4I6pPAO0vmSU/BqBccIL+6HKaVh1+mUEyj2MInjjOdm/tmZvGm82KmdVHYkNYIHpDmwL2fENY8eiRbsE87p2BLepgJxrFsG4FhYy2ZQQ9qMVmVE13l5QVp6JnE5HPDEttTNLYpJQt7dzOaR5AhX1jnamOFyOHqFzmRjOM2Vno=
Received: from CH2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:610:58::24)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 22:45:24 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::52) by CH2PR20CA0014.outlook.office365.com
 (2603:10b6:610:58::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 22:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:45:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:45:22 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 13/17] cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
Date: Thu, 26 Jun 2025 17:42:48 -0500
Message-ID: <20250626224252.1415009-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: d32e3929-40bf-4d79-405a-08ddb5032361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NTHW9XA7/ug0jLba0Q0HCgmZrQTzfoTU0OPaTvdTq05QulsHigqU9PI4Rf+K?=
 =?us-ascii?Q?/ZCzu1u1bmHAomPjc3bjyrlR+oJhpX+83c1vJi5nYMPaALo9H0P5FOhCyvub?=
 =?us-ascii?Q?evEXktYq4SWuiSQ2Aw5ia9uZXxseM9Ow5yCl8IDK8I2b5C7z6U38XicvC+Vw?=
 =?us-ascii?Q?/HPZuOPcXQwpYqljD5KIDRxzyIwiiRrZgnhTmlFAomMiau9iD7a0G5GZIZsZ?=
 =?us-ascii?Q?sdjeEHwdGWdZL9ZVnpdm2iHsea3KzAo4b6vNPz5e4wEPSsSRRaTa2PivCDIH?=
 =?us-ascii?Q?gJ3qQ0KyerfKb9QLnz89E1gVvHkCUyMb3guyK86MPtvNju85EkK3/qNQs2BZ?=
 =?us-ascii?Q?hau0Qa0OU0vo922byEHmgTMtFI1ZSa8hguD5BNJgidE5sxgk71trKiD6d54B?=
 =?us-ascii?Q?Shx36F5uHA9+1MJkLORBDqLJF1uLv8y2aeM58K0yGF6A2G8UHio49xkXsjyN?=
 =?us-ascii?Q?YryaqpfpHCe/WnEMynIdPYqfjviTMbXO+8kfqqcXLne+s63O2mbhdmy03eFX?=
 =?us-ascii?Q?Q0tV6hPWFrrul4qSxUYn8oC7FHkoFxMkC/HKiW+rpczQJNhRbdifXlixNTsr?=
 =?us-ascii?Q?cEBnWo6oOTtD9RwhSsY5+8ua2HT6BZLgYM3ESBtb9YBgFk9V4Cq4/AQciq0m?=
 =?us-ascii?Q?XtFEvKWC6sxKPfV7qd18kRSjMgjxJCKy07Rd38QDnYbYfBKADeUl5WNLzV3+?=
 =?us-ascii?Q?w4/Zk4uuhN1r9BFs6W4xD1M7lI+IfB23oWHCfapqrI0PvDUlaW2LAEAuXIv9?=
 =?us-ascii?Q?FBZ4kDV0BEGabyHvwfrHrtoECAvOxFJhv5DYhrhEPzBrRHkKu84pJJ0AkVs2?=
 =?us-ascii?Q?lQFTEZq/9+1vBdCdKswl6ulaxvCzxDwvRZDGsn24yjubzzvK/4V4Ywkmzulz?=
 =?us-ascii?Q?kYi3o/79kLk/aiXd7fit+CVLC2Gr5dpwhq7xm4J/XzsTu7li/ZOlP/GqSnn4?=
 =?us-ascii?Q?0scfeZI5fvZW3P7+5598VccsFchLyM5CYpT2OGyN9nvtDHh+Nxayc58GcrbW?=
 =?us-ascii?Q?2KjHhQrLxbxdwvlCKeS67YRJmPgEDlGOeIP5wKI3hHM2CZAl9Y2DdKTfnerm?=
 =?us-ascii?Q?8dtIoP35t1YYhfW4BW6ZNqpgc6zXmUKsKKjCvHlcxyxLS0KU6XrnbfZlEIOq?=
 =?us-ascii?Q?+SgrPRpvFFXRNEcVdcasfbqcZhLIXZXUv7FCNMJCblB9KVr9MZJithVBes7J?=
 =?us-ascii?Q?IWaxbMHR6a+u0hqyqko9D0RpTRfRi89N60ZlKk+mfHK9him84k9EdssSetvZ?=
 =?us-ascii?Q?PcaZxGv8Di2M8WZZGSxwyXow6WRi28pB+1hrLZZP8EnEAvK8mPTVqBAI6GIo?=
 =?us-ascii?Q?fozpZ6BryX17GTMf+tgihRouXzgF9BrqrY3gr/fX/9XvsZGkh2dPpMEXnbnc?=
 =?us-ascii?Q?41a89FmbAZPgP3Fyv78ieOtVLg3FUpXbIBXl8uowz1ymaXnbd/sbFvth0yGX?=
 =?us-ascii?Q?FqBk0D4ZkPkYFHmqNanNiCIczgt8j63XDtEpP7A3oBjS7iKUWFjPhVpLDjsf?=
 =?us-ascii?Q?bQsRi7hGAMJgxf5dDp8FUWaI6cSacSciDw7FWi7v6pYkx9RivdPiMEwN0Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:45:23.8786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32e3929-40bf-4d79-405a-08ddb5032361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

Update cxl_handle_cor_ras() to exit early in the case there is no RAS
errors detected after applying the status mask. This change will make
the correctable handler's implementation consistent with the uncorrectable
handler, cxl_handle_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/cxl/core/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 156ce094a8b9..887b54cf3395 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -677,10 +677,11 @@ static void cxl_handle_cor_ras(struct device *dev, u64 serial,
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(dev, serial, status);
-	}
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	trace_cxl_aer_correctable_error(dev, serial, status);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
-- 
2.34.1


