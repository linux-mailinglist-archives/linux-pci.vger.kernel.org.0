Return-Path: <linux-pci+bounces-40236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E2CC32376
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6BF18C49E5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757693254A9;
	Tue,  4 Nov 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dTkzdn1H"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F343396FD;
	Tue,  4 Nov 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275845; cv=fail; b=M8d/kIj+7SDqknXX626Mri/tlU4vHiXjIAy3himgulfmlQp2YEpttAz9BNH3saZnuIJnMiRcrN6RWJu2PVfYUJ1kp043UYeAqzV0fCtupwj8nrGARA0gchidWv8UglRz5ltuSSHP2URhx017HLpeQueHyx748LIW0KCYUxcKO4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275845; c=relaxed/simple;
	bh=XKw8Xx7eiNLyEYZA/6QVpC1aZmWmFDGjqumrsbiAV9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJEjF1U4uHaism7+9aa3qvoV1dnHYIl4iF74dJJmeeRXfKr/FfXHT/nq3d+cHBsGgrlhpGSA2MZfBce4dqXF5V7zWsiM8teHG8DSDXMIfZ1aVImdfSq4EKZxwjrMybkX/iKypuYKciUgK6dBVD+LJGee6o9E2QVs+M0LZ1zXt0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dTkzdn1H; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3bL5Z7chBGJFhQ6+cAXF9ox45KyW2BhxUwXhrJ+liShsZUF57GAdtAmyJ+kLtP85YAPi/KdoN7BxCUnU8DkSAWJfgSfi9RPsp6s6MBc7DHdvCapApEK69hyPkm39E0FZuliDWi8O3h43tbjL3PzyHe8LKTMMaMX5xRte8NYriZED7YZ/htr3xq6piaCnY7NFKH6Edqx4X03cI91i+RujMePZGxG8LJKPQmI21SJfbUUtkAF6/XTRSXbKIvLqTMCsZR9MAi6wHYj3ZNSxKGCVK2nNR/VSA2Yy94gOlt8asqHiKtVsNN3qRoi5bGbceZ4mVV8VRLneaZwpPtD09hS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZDo8YopKJyFYH1tCwVTcFe7YyO/4DTGdGYM3nTBvmY=;
 b=uLpmKEyse3WbUaCau1vvwPEGJo62zy1RYpgVDM3eqg/xLAyqOcoIug0IZMGnKxrO5qi7EOiRZavjVAQcj/723gg5wHNk+ypi7Z1JTdAzcIYylwIIwzdNcQk0WBJJHmdLkuUaXikU5aCj4EuediG32VteznMNBcXMpY+lJheOo6L4FDB3Y9wE/e6wD+FeB8F+AK1klC9L+enoXcvN1P8L3qRt/XhJOMHnOvoJXXuZj5Eo6+kHARZ3sTwNfFy6tu0Ao9HxbKjORfXdg/irhFDv/gDSmF2WpWqMt7Uzr1zni96mkggVOq13J5h/+GfoXZuk2eh9xXnmxKsLwWNXkmAwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZDo8YopKJyFYH1tCwVTcFe7YyO/4DTGdGYM3nTBvmY=;
 b=dTkzdn1Hh8kO2Duk3vr0t0XlTjSFSXzgyvuDPBgSX27fZJBGAqZfZF88O3y8reGW5TZwrDDuH2OGrngw1mOzdtRfIUDaQr7ydnKracNDid14NKzsJ63rYc071GsHDIelLGBozbNV2k2BgZtjxBB8qZsul6aDJugQ6xkEnZ/ax5w=
Received: from BN9PR03CA0983.namprd03.prod.outlook.com (2603:10b6:408:109::28)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:03:57 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::16) by BN9PR03CA0983.outlook.office365.com
 (2603:10b6:408:109::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Tue,
 4 Nov 2025 17:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:03:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:03:55 -0800
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
Subject: [RESEND v13 04/25] cxl/pci: Remove unnecessary CXL RCH handling helper functions
Date: Tue, 4 Nov 2025 11:02:44 -0600
Message-ID: <20251104170305.4163840-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccc4f89-bdbe-4735-64f2-08de1bc42445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nCVpSlnaXyuAJNTEP5b6A/2SSJb09kH0JUy/DDKzyBbGF23sLz/myVtSUFRW?=
 =?us-ascii?Q?Mxz+FitAB296UGSOGjCO8C6uYIuQFcj59eX1J/CA1I3P5HubuU7JZwVAnzZC?=
 =?us-ascii?Q?CAVzztFYJO6RIYZ+MLn2xDejpu5/e+8xtUZJnmAp9thSYRRC5vZr9q7LBBOY?=
 =?us-ascii?Q?i8n1d/lvsMX242PjuIxzayDx2RS+90mo3Myc4TWyRKehAh3vLl1YsxdrHAK2?=
 =?us-ascii?Q?ILQ3HEN6Ak6+SPIJLDDX2BUJKQxx2K8Sd/J9cy6knQWkRX4WgcXuA0KKTf9Y?=
 =?us-ascii?Q?ti6s0IOgGoVHXRuAst7Iwuf5VNg9THo81DbaCelpD9OnUY7R0EYX5lvtbklD?=
 =?us-ascii?Q?80cI/uX0otK1w3jo74++mkp4wJ6tCUBJH1tPi1mcbPMH6tPvR8eTfBaF+7fJ?=
 =?us-ascii?Q?k5tSVcPyY5wMY5ztNayH9H0RdsszGAy2uO1+fzgZF2DhBZnkC2fZPDt+mt3V?=
 =?us-ascii?Q?M8yy9hQ9twMpQyqhqe5oKkVbhERwNxDkBLcyU30Ixm+l+08l7/j4aZV70tuQ?=
 =?us-ascii?Q?pry3/9xtQfRKq22PAn66kOgs/CIxM5yAcQ2fK1OWpBFoHZWfsvl1x1jkHtti?=
 =?us-ascii?Q?7oT3VY/Jcn7uPryMKn4ROhpwGpb63TxjD7qwP/475WW4FOm2p36dCh6Rv8gi?=
 =?us-ascii?Q?IWE0+GDfyIUSVwjIWxC5JvmEqznnFhtJ1K785wGkMRUXVgR6fHFR3Pn9pvJC?=
 =?us-ascii?Q?P9UXj82XLcj+WezC5pbT5jDXOTta3yklcBmX2Kbb0lInNFwaPt6Lv7F9rHJP?=
 =?us-ascii?Q?RLp3Gt0Ba7YVo2umEA4mR6HL7r6om2JEoMgPJB5vIpnHztRNeYx9VE9qmpOe?=
 =?us-ascii?Q?8f5f5NUunHvWtC2X2/GeJdEOP9VYT+Ib7+mRX4TVtLiRHC8vqlE2nLrt3wgb?=
 =?us-ascii?Q?c5Q5te1uhbylDsA8E1ln0uxl67XNFCahUdeX0tlH0JGkEaMeW0u8mtreii6V?=
 =?us-ascii?Q?oV+eXXrFg5Pl+Vyb6ALinwU7lV/l5YlsCjvrIl2FzbONWfmYsPY+syl+8Twh?=
 =?us-ascii?Q?FEMbBjnZEnFRmW27jtFPixSDSmy3NXfxNfqz0HR9bIxmbNywD9lBiJSpi+VI?=
 =?us-ascii?Q?q+HBKGRmAk2i+mn/MCM3+VNy7pGxlUxIpwZ/Ta5mcVNKNE1NAhjtgQO5wV+d?=
 =?us-ascii?Q?uaWy2sSMalfiE1U0Lh/KHxEfc8SNErsyFpPCOrbq7/7c/GObljcWOe1Ajj23?=
 =?us-ascii?Q?aYHXa5RzfMA9adY2gN9jwy7ntWCDjwGElEVsqqW9/9utk5AYYhXj/9RGNr5m?=
 =?us-ascii?Q?qNvhEocMcM9qeudzYPajERFmiYvdu3Sz43eNIdgXd3OqTkAymX2qOQfDTx6N?=
 =?us-ascii?Q?vzrVdXhxG28D4/+IpnVxwupI7GCxkWX/JNvBB2yPsRl4Z+bmFhYV8Jlqqdxf?=
 =?us-ascii?Q?f/a3bE2Z3MmwFoBXykHdSMHIdwr1lWToFyUxDWzaOqU7RUUQrRFraDz58P9+?=
 =?us-ascii?Q?6ITUzw0czUD6xm8iF7eubBc20Hcef805TUUn28Acmy21eef0X+LBCy1veGo/?=
 =?us-ascii?Q?qcthHRhAM0k8fbjLE6FsT4vvfr4ebFRHbto+oCUx4kEX9qKPzMtVtZpWxCpe?=
 =?us-ascii?Q?WARhc6ve/2oOOSpSOGQdzD0Ey6ZLFOc+LmYPMVGN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:03:56.8822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc4f89-bdbe-4735-64f2-08de1bc42445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763

cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
to Restricted CXL Host (RCH) handling. Improve readability and
maintainability by replacing these and instead using the common
cxl_handle_cor_ras() and cxl_handle_ras() functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

Changes in v12->v13:
- None

Changes in v11->v12:
- Add reviewed-by for Alejandro & Dave Jiang
- Moved to front of series

Changes in v10->v11:
- New patch
---
 drivers/cxl/core/pci.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3ac90ff6e3d3..a0f53a20fa61 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -858,18 +858,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
-					  struct cxl_dport *dport)
-{
-	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
-}
-
-static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
-				       struct cxl_dport *dport)
-{
-	return cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
@@ -939,9 +927,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	pci_print_aer(pdev, severity, &aer_regs);
 
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_rdport_cor_ras(cxlds, dport);
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
 	else
-		cxl_handle_rdport_ras(cxlds, dport);
+		cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 #else
-- 
2.34.1


