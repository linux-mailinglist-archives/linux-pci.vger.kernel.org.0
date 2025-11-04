Return-Path: <linux-pci+bounces-40169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 956F7C2E8A5
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71B3E4E9165
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D11A9FB6;
	Tue,  4 Nov 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s9oOO4EI"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3EE5D8F0;
	Tue,  4 Nov 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215161; cv=fail; b=LFhcyK7S53PttmPI7KI1io6fQxERzxwJ1yN8b1Z2+f/xWvX8uNbnZqmXpDIcZ7xkF5NOoGRlgmSnITGtPvSoRRGHNkJTllP4keYT6OI/ZJmxE37xIyMAoz1YWHfYT0lpWcll7n2EcCF5abFAy7zs3lzwrPfXtR3EC3rxQMCRzW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215161; c=relaxed/simple;
	bh=S1GJOFDvnJn33tqp9bq0GYHvEvujlUKcT87DgMEnM3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfd2RmVKrpfmt1tjLR5HAYn7ilDUafP1Vic90GBgWyZu5o90WAGfLMcm43SOak0FmPyHjuhEykbSxRB5NCAPPVQuODQuVJTDf2dKoYaE+10ZZ4AwWWjgcvwvAlkNKoIdY1/dTSGU9y0fmtCHov2Gm3QVbXqa9qKtN+NV8guqc+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s9oOO4EI; arc=fail smtp.client-ip=40.93.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsPwos5qTcoBIXzipk/wnQ/6HmyVoaX/Cv8ZPMlXoeiCWR+WrJ1qseaOr53rjdTk1iAWtTVlIjyYtTHo1m7deJRctViK+WErCj4uTND8xJfG4vgY1mUc6muLcP6LGM+kQrUkEAU9GFCAQtDyEEaRJ2K7Pfmg1D9zZ5LCA09z21BdcSbYLm4OS0f/NJpyjjRt6j61yT9KSxVlXh18ZQntysXcJFf06F5BXAIkyM6mXnZn2XyyVf5brPSj7S/PK8R+EIf6REni2jH2ZeGMOj4ranTAX/zTk9Qjj0zJnpSveTX7TrPCyebTfLR22Ewp8bROK+793jcyJFY3uHB1eYs7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SQw6cY4AnYl4qnREhFU0Y/DyMgjNSKH2BQMxNAAyX4=;
 b=oUExHRboGw2/6QBn+SGP6iO+E13ylV0N3M8KKJZj9vnUHxTXBAb5tXsIh8dGxtFtwPWVLMJaZqVQTcRr+WLTf6N9xJB8qvm4noM667pxxfoVk3GUxnIgfPvXLn/tcqa47en2taAApnlB0KtTMDA8RQhV+BJ59inn//mWE+ysppQo+b34M4022RtHAkDgxo6Es3bs1gdbseaMKPHjg7qvYhQl/RLS0OLlVgH9DzYsYQu146SIAMDaB4GL44yg5ypGDmW9q+JlUvu+t+ObO4zlaYGSMj6W9kFtDpEe+wK628+1lHzrBjXH1lWZq/hX8DzxwTHXUw6xgasVqs8rwUm+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SQw6cY4AnYl4qnREhFU0Y/DyMgjNSKH2BQMxNAAyX4=;
 b=s9oOO4EIqewJY2s8JMBfdSUhPHpnZ46S86xGZsjBvE1knWzu257EoozCjUeT09DnGYA74+wlGM745ps2PvHVlHovzqTGD9hhELFpQxh6RoXtsRhPWdVe5fU+cqmk+hJFhl5UPU/chg5iDrTGtdg9f0uzaOvSifoM42bcHPbAYSk=
Received: from CH2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:610:60::14)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:12:32 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::66) by CH2PR14CA0004.outlook.office365.com
 (2603:10b6:610:60::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:12:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:12:31 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 13/25] cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
Date: Mon, 3 Nov 2025 18:09:49 -0600
Message-ID: <20251104001001.3833651-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfcfd9a-e87d-46f5-7d36-08de1b36d96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TO78HmQgq/9AlUmAmBU7ADuOLA6vyOC9+9VEOoP4NThgK9/alvBPwkUSDEAg?=
 =?us-ascii?Q?zj31xMKBUDzxg71nPjbiUFoiKO3UIYw4A5cQjXpuTL5IfpLstzUx2nvQ2LDW?=
 =?us-ascii?Q?nZlIDnymii697qrERRJnmwJtt0nn4ZM9rLkFszSY6gDNPIO1VKAeJOOPj07Q?=
 =?us-ascii?Q?Ee2n3ILtmRhvHSxX5cjN/Ia7lPn8ZInAQ9ctQ65HYoKAvS0ii/xOLb73K085?=
 =?us-ascii?Q?hBMDYP0/Yg9Uw45xNL/vA0gpB+6pApO0W9hh1UQHxmg3tKyQL1UxWUAdF7aA?=
 =?us-ascii?Q?+2sBkfqeMF2BorOa63J/bk8NtHv21zAJAIi0mGMbAYWFeWsNVFCdwAM7DCqI?=
 =?us-ascii?Q?0WmlZBBoktK0m9dJxeKJTPUeuTT3KF65RF+ye+yvcdvD3bI/qhSKEtjV7iE2?=
 =?us-ascii?Q?nR8prXSoBLH2Iz2nFCDwje1DmZaO2WbsvOgCBxnmkFY/OF4aUCff/HQgEN1K?=
 =?us-ascii?Q?Blk3mwJDoTrz7nOOCS3tcO9hWWWGSLfb+3FJMkXVjW+r3tXl6l1EqONJibvD?=
 =?us-ascii?Q?NCCsQNl5prhFosiTyVGg3LyYsrjpLh3eDegb6kOcDpVOnFd5UPZQJ1TYdRbD?=
 =?us-ascii?Q?fs4k3tmnJPF5rfyvPOOtnNwJmDb4CSIatsyPxIzRvAbdb16SS1dY4R5rsAAr?=
 =?us-ascii?Q?wV9KUM3Bbfv840Kh+gjaXgIJuryHGzJIpwRBzZwmTXyMbAlpQM4ksrsM5iTR?=
 =?us-ascii?Q?HGa8eDsuWtoj/E/q9hYk+iw5MMBcPoEK/UImYuZBr0sL2S/mHLUighq7vyEV?=
 =?us-ascii?Q?7G53xbeABftarkJJRgsUHOxJCWzf/+FJaw+dWtGoorhw41wXsXQYHOZnGhJx?=
 =?us-ascii?Q?tijy7UWZdnzF6c5RX6/1PLvZwJF4A99yUQ49aSQgLt4YslSUtIm1iAymr1jT?=
 =?us-ascii?Q?K4eYqsUHTOJzFi5+oJXpEGXTjozpc7eDHyIU0+5XPP7IYEaOgJcxnUhsoOua?=
 =?us-ascii?Q?Q1TRYkuYyMPMYTzaxX8WZs6Hs/8gAaKKgOrwh6MigDnV+NrUxPDEXC1GHTn3?=
 =?us-ascii?Q?WMoTk0IB48JbaZf0EHbggDzwTWVPX9hT664nkpS/JgKoxU03GHHjg0spyXbc?=
 =?us-ascii?Q?qmZ+pR6YTBybUWgpxyawsChwqBXMNoBKmwQkaoA2qXjI5g/iPv9g446geuk/?=
 =?us-ascii?Q?J4ephgK3J3y6Fw69WrwTdVOG6uew1b6nwZzt1Ih5IswsvouVKHjk9r7vjQD4?=
 =?us-ascii?Q?5eqUPjQx8ip1h6nGGqSCLFif5oNzdWhyfqSNmCP5yE409j7/B1QuJDM7Gty/?=
 =?us-ascii?Q?/rHkLTv6lafrQDV/9LM+F8zkUxw9j93F3pEXhMN8ZXKkYkjyYTwwqmHtVg1C?=
 =?us-ascii?Q?HZcLSWh4Rde2oauUNzOIKQhoWaz/sKgMrBcDSFwNpX01bY0UYbFlqUZlnXw4?=
 =?us-ascii?Q?HLTy3CxIWDk1I3BY5Vmarh/aIhlaccvu7T/gjwe13Ee2tOTTZAcvAEaQ4d8M?=
 =?us-ascii?Q?Dvvn7fI/sMV2d3X8lNcW/XC8QxQOvhDLKGvvx8chuLN4vM17nhBa8ejPbEvQ?=
 =?us-ascii?Q?qFyYlmRLDLVTtbd8n9tDdytn8Q/fIZ+xYsh6ybl5W0gyjLIPI3/BDjHP3ncj?=
 =?us-ascii?Q?XqeAKj8ahBEuio0xRYs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:12:32.2728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfcfd9a-e87d-46f5-7d36-08de1b36d96e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

Update cxl_handle_cor_ras() to exit early in the case there is no RAS
errors detected after applying the status mask. This change will make
the correctable handler's implementation consistent with the uncorrectable
handler, cxl_handle_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes v12->v13:
- Added Ben's review-by

Changes v11->v12:
- None

Changes v10->v11:
- Added Dave Jiang and Jonathan Cameron's review-by
- Changes moved to core/ras.c
---
 drivers/cxl/core/ras.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 599c88f0b376..246dfe56617a 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -174,10 +174,11 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(dev, status, serial);
-	}
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	trace_cxl_aer_correctable_error(dev, status, serial);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
-- 
2.34.1


