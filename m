Return-Path: <linux-pci+bounces-30859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D548DAEA9E0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06813AE8DD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C708A224B12;
	Thu, 26 Jun 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T3Jg2WWI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33D22127C;
	Thu, 26 Jun 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977907; cv=fail; b=tDAOo7281TwLkEvBJmN1Ym2VwCBYmZubIoS3VY57Z2NXrpeCeyjIXdUVQRCGAVPABUiNfEmHxcI194xAeHkP4sz1jlthIwKdG1z12MxbNkOJ+a/2ajprgBjQPEHbKSTiAKxF9hFV/8/oFXgJlYl/59r5FNzdQuAQHKCI4ccbGNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977907; c=relaxed/simple;
	bh=igg0n7CBRSlkFqKymQmakP5teI4aAV6kfAiG/dbFfcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfrYn4FA73hYvWwzp12iz+nEbtGkEkF9y8h05bcRRuLsbIVBMoo39FDu63zYjsW9g7Mi1n1u+y9d3i9Xwiqa6NYffh6GXX8S4oQHG8cnmN7Z8htONzIVKtJW2o3JLnOZGe5yBess/5yE4vKxvCv+wf/R7fIGNRqt0cgJit7et5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T3Jg2WWI; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNzVRsfXxqt61dbuB2ZyV/gamspReohHCShkEEHa+PPR/4KiXyTneZcEhmUf+ETgSU+fqJQLx7MixYKGUus8dSEiZI87AU4498NSsVVQTLJYrBPktdcYHb3Z2KUb4YTMdKFpUTnZGLQILL5bGifdWsWzgv3yxOz2mgv+hh90X/2zdSpQ0Ze3RZAsmjNbywjvB7mxts2cZzo86eo20vk/6Vrw6pqwq8NC4WJKNwEBOa4PSkSyO41D7XDyL6Ka3xpaNcuANlZd319FYAY48wvmeMF5TVc/yjr5yaPyaOkXnejqvZcBSBkPMSroZVodHAd5aZ2MpNPwc5VYcUXr6psG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJBByLMkEcF2YKgFfbuVjrY5oT0jRZduGTYdZBVp7/U=;
 b=PwQ+RF9f1krT7zzAtwn4rWetqfkbGIOiHpLVgyLMHuJODR1k8x3VjYmwbThKjDoG1bwfTArAOIU9ZSvgM3qzK/k70+qYP/qwzCYO55fqrzBRgOB9l56ypoNunc8LS598ucqqwHCrRlhmBoYiAm2khd0+KWc+xV4w0Q44j5PMsMEeFKMT1FyMKUpPUHUwaidWGQJajrSjPTutSMi+MQnTTLvb4YuSFb6dZJxxEXUhBq1wcwIb4gbNv6gbWb2yM9GTwdoDRyL/rJoQuWeEYw3l3EL6YIrTC12Y7qj/Ou7Ib9yBz+7nCaMIsJvEZE0ZjrE+sQUQQhq93XLUB8kMX8Xd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJBByLMkEcF2YKgFfbuVjrY5oT0jRZduGTYdZBVp7/U=;
 b=T3Jg2WWIrZ4bZB6wYMjK1I8RABZPAfDhIu9sZTj7iC8LRXRldz/CRmXM/o5facEwaXmHrt9jHMXuwk2AHX5j+VdimCQuhScOM1IsZ9KIMkiEPvOAOI10SNP5UJO7qLyyalILD6WIo/Z5ELJKWb3QEDdPh1DcYXzchTdt8vh3cQA=
Received: from CH2PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:4e::13)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 22:45:02 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::2a) by CH2PR02CA0003.outlook.office365.com
 (2603:10b6:610:4e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 22:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:45:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:45:00 -0500
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
Subject: [PATCH v10 11/17] cxl/pci: Log message if RAS registers are unmapped
Date: Thu, 26 Jun 2025 17:42:46 -0500
Message-ID: <20250626224252.1415009-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d24f5a-6459-4f8f-ae9b-08ddb5031617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1s/la5EiWErhk3nhblmDhmzdPifkz19MoK+QT0GhxFVN4AQ8tsfFOHgbPenP?=
 =?us-ascii?Q?dGpy6iPU7QiTYFbNTcd9FVOxMiR22JT1gj9pde3qmrftFSxO0VsiSruWRjcY?=
 =?us-ascii?Q?2zX9WJ7VWMM84+UqFrHDugGQUC9K4paCcyce1KIl+hAk7nXSjqev6dzGOxt7?=
 =?us-ascii?Q?HMDoyfIYBUv/O/nUd6lLHSpEkBMO1dJXN9Q1pNWw6mt3YqPnbYT4STcsCZip?=
 =?us-ascii?Q?Lhto5cdSjbKyWBgPBTtn4tGZuEfHWMfNX9RyarAv2HrKETJwIwcoCrUHH0vj?=
 =?us-ascii?Q?S/t4n3BK13IrThiC1X5u0+aZNmvQ25Gvvh8JDy0UiTPx4ay7oLkXGunbnYlx?=
 =?us-ascii?Q?Ql96rnVQlXPeFkKkgJnAGuYfmj+HlyyvPZI4jKQDibWzBE2GfzgDIY5d0JNo?=
 =?us-ascii?Q?RJeDy4M47yU5bIVG+8cejrYoQ+eD/BeAqOQA3ptuxIe5aw578DA+meqT+dtK?=
 =?us-ascii?Q?aoR1Xg4XWiSl2YkWRqUU8jbjddw1x7dvwoCUAHljz9aVb2+I8dWGvFLmehXr?=
 =?us-ascii?Q?dU+sf7ZmgNmZ/qRjY1FpLc9pfbeLhPUXv8UMgU1BujQOzpwrj33kZ+TBFdwk?=
 =?us-ascii?Q?u1SiTbMb17fODV51YFlFAlCfkKXuY1DwuYXRZlKPoDNy5KJJxxV1sDGdXmKV?=
 =?us-ascii?Q?x4Fp/PAryAii50dvUY0TCzB1m/iDwmAWFnyWfz6NSMIw25GvdLWDZQeZGbbP?=
 =?us-ascii?Q?2xzCmZ6P4V0IImCpNzMnMBUcKgwRwlCPUN8Jc4GL3G4gjQinhtHtJ7yegUvM?=
 =?us-ascii?Q?Di3aLJpw6/LT6DcCHBHKr/s08mFdz6Hi4lM400RArAoC7XYHf/BJq1xOscsl?=
 =?us-ascii?Q?ZVTB8FHI5rT2VkdIixjHGveRmmgUg62Re3iT42/i6mfd3mu3hQWhO+WZAN8Z?=
 =?us-ascii?Q?fFkJXv8qpg3oiGb58WdXR5UZBLsXxBrRP07EIH14j2Q24XdFBZdA1TXe+qwE?=
 =?us-ascii?Q?aGSnPYVIjyJucceUn47IE+/sPag/9b1AevaTjfczLazP/XLRjqD2BwZ1ZF8y?=
 =?us-ascii?Q?RJwbrlxZz7PAwMYparq3a2ijLEmNR6+tP0tG7Gat1AvD8uq9sIjmrtC5XoRf?=
 =?us-ascii?Q?N9uyPgn2FoC9ZEWCx+3RCjWZKqsuaMPf+oXDW4bEygKu7K0MMmKSXfreOudG?=
 =?us-ascii?Q?6fN/WFB9LgRIsE5rk83YD/2f4Ymren1i+XN1xd85/m00xndx4/xkooY2meOO?=
 =?us-ascii?Q?uoXrKYvDlIUKltURDDpVe3FY/EUSn/KZY6NfNrX7HhcC+Ga3TWtjBDT6/0f2?=
 =?us-ascii?Q?yZYj3X3XgBCeWKJi5Rxpd+r9fUMNjoHUfRD7yQNEhVq5e0h/YZBr2RnTGMU2?=
 =?us-ascii?Q?6RDUOcTiBZOIp70epX7J2l7JQoveFAgmK0m6ulWAj3KE7gmk2FPuy9jW9tWM?=
 =?us-ascii?Q?6a1PPM8zHgL+fZ8WISXyw2CPq1HW0smjex5VtJnw8JpFt/vIeFsVnH3bcK56?=
 =?us-ascii?Q?l6iDk0oXAwZMXDgbuMwF4tGEM7IgfJozkb3R4Qif1BV56VV6IiMwAljQGDtR?=
 =?us-ascii?Q?4p80Ix7/bYAQtMfvLRJjImTGCI/hiQsg/WWf2KeDQW/TLFw/VIaGS8bDRQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:45:01.5858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d24f5a-6459-4f8f-ae9b-08ddb5031617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped during RAS error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/cxl/core/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9b464f9c55c1..c9a4b528e0b8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -670,8 +670,10 @@ static void cxl_handle_cor_ras(struct device *dev,
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -709,8 +711,10 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
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


