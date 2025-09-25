Return-Path: <linux-pci+bounces-37047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F05BA1D51
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA55A1C83809
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC52322C94;
	Thu, 25 Sep 2025 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vzgq9p1N"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C96322752;
	Thu, 25 Sep 2025 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839840; cv=fail; b=S4AQd8ZmpKOMA0ZXaPX9Jf/pEEkd5uMJzfsmjC4qlAXr2b3maRqC3DZQ5UjayBGxA8EiaXhu1PMfJXBBLhrroOz7i8ci5P8zgfDCQG+TZVCqK7YBzSIajT83Rni93SPcFk28CM/eo5nhbj1TS5UvrD/i1B+5ceao6pxtXUQb+i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839840; c=relaxed/simple;
	bh=T3NZl2P2qEIg7YjeTpphqALKI5WZSfeB0V7QFT5L0bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQMSKCdvlXFVgmFkORrrnuYNW2SqOGWglB49S//p5Yl8I/qzA0rVqQ57ITP//RLYAzbSheDy5nt4at9Npb/E8dO7H9BGFbEbpnBq1kvBkep60D5QTkcL1dQNNd1qA6lQ9tHBd/JkOF8DgYMgLjO5J7/bhxWm3onrAAaNgirLX1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vzgq9p1N; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpk4geIVRmYge4+jVLH4SG7SNF6G1ZgbIXL3ngKQZs39hGVbIz5qKbEZqtE/r7rG1PPYc7etZFdecZH7DnL8zozS3KcfljnB0XIaGMmmB+rXLOhEppfq0ZChzTDwYbn7Q7aDRrw9IksHr8Udw7ach9Dm7Cx4KlsPv2MO7R+0p9h4C+kIE4jXsB0XuyGbdm/PPpYUXx332i0k1Hqo1OUPEXWCD2rz8XJ4Ql34emCki04N9myEU1zJ3BocomgfkU337JCB0AI7uJSn+KQ4u8q9mI5K6uFBJF5YwSALU2V8MAsnvLT1Mu3CFvBWlitqrwKT6DHEmOmSaTvTOeLFwHuv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGqsUI9+BhbHw0GxJorNOYBKnjEBWXpcKCdth0VkMe0=;
 b=P0bc5/15/cBNUZWpmMc/Fr2ox5uWQC4dtd6e/RVnpOKhTb2k8Zg8uCy+XRbx6KdoXehfNcivodyVKDQKK3HJ2kLCRWiRBp4MqzELsjd7yeWs2LL2I5Qjv9x9nHbRrdD5/uIgXsY3CwiMZtBQIyTOhhZFpW3ed2FIaSH+dEa7W2UMJyggmmUTgEciGVOXWdojU9uCrVKTbKwO2im/5ZGTdnmLQB9Ljo8EVgK0wuZOc+9/8kYIBwjnIW+U3YBn+x7tG1cBbuVJhKVY1rFq8K853pouFuJ0JiNwjPsofTOrX2/JcWSWPdoI6E/5qk+kqvt6aK/CVXJsuxvpqqpSycPD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGqsUI9+BhbHw0GxJorNOYBKnjEBWXpcKCdth0VkMe0=;
 b=Vzgq9p1NaZNvmDMqbYqI6tKEZDsek8Mc+Te3Ym/Em7B6/KuzkoBL6fo8dXx4sqjlOSvVisYZJzSD/0pK0DsmYCc3uOInSqP8M+dbWXLhuVEpbnO7so08cAl5X23gnMjXgTHun0mONyzxO4WrnWad2XPLz6dbDriZ4RMuJYR7B80=
Received: from SJ0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:a03:2c2::26)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:37:12 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::14) by SJ0PR13CA0051.outlook.office365.com
 (2603:10b6:a03:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:37:11 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:37:10 -0700
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
Subject: [PATCH v12 13/25] cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
Date: Thu, 25 Sep 2025 17:34:28 -0500
Message-ID: <20250925223440.3539069-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb164d2-330c-4cba-3177-08ddfc8411aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/rUmTL9sfSajptqOWAL6/seXMNr5ect8u0O+10SwPMLUJnl+B8t0qPyJpc5l?=
 =?us-ascii?Q?fFLwDbE6b/e+6/ViyLiFOJ39H8PTa1vdEv+71QtonrzI8MkiXTfw9V+lVaI9?=
 =?us-ascii?Q?FoKKqEmLnZkMJGK9Qr9yi1YuU5xEFpVOzCvxNRDRnT9rmroEQMk6qGjXQ7j8?=
 =?us-ascii?Q?Mq3iUF29II+EzYUh5nxdfaAjLkJfDBQa6Eq1hOk5brC4gghWpfHNUqyyu2Nx?=
 =?us-ascii?Q?doHCa21HgM3NOgldZzGBq6lZ+Egdax+JCm/0k4U7z/eFW9SMENsCWgAy+54U?=
 =?us-ascii?Q?7Eb0FMg5RmLBCoJmndbyujX9dils2pbXhXGl/Q3ryLVovd+6iDk2RPWhZBEG?=
 =?us-ascii?Q?rtYiCM7B8/TA8TW3JfXXdejSbr9SN9kOxan2tk7S54iiza0tuvBPMDywitXa?=
 =?us-ascii?Q?8Tb088zolceh1Vj7EOT5NZCgQ9RCvUxlO3VP4gy3NUnryaSSQgCNfJuwy6C3?=
 =?us-ascii?Q?VT33yFZethvoUwxqGuTz02CxnJBVymIdONZ/In7j6Sfe+2C9rGYT+7fjgZU2?=
 =?us-ascii?Q?2+ssUygBiYEfbUgWdZXFItfJ2cqCUdr37ryWafwT+K8tRm48uqJ82haFmHHF?=
 =?us-ascii?Q?NTiz0Mrn77bFTzZXa2cDWtGG/idudfr3ufCG9rIo0o/DttsrKAmlZEDy2ciV?=
 =?us-ascii?Q?J5BAtJsq/GfryKM4jlwYnIgdc8zo2NqUkN3N9OI1qfyKy2N8pgfZyc3F1Vzw?=
 =?us-ascii?Q?/6H9m5whOxwIFIfHg8H7Rl5r350/o1cwqJOLVWRBarnZyMhlQKWMpMLO/ITA?=
 =?us-ascii?Q?p0b3aXrLzKm3FiYxJXuiVCYRgqXvq4mfuMGyRK/PfcMH5bIINQKnAlB8TTT0?=
 =?us-ascii?Q?/Y5kq0hMR5VqiFc1Jipa+8oGKAlDINOI6MZS0llbxzk3h+W4MCS4O1VLY2m7?=
 =?us-ascii?Q?NhBPWh6StO6U1iiKmv/fElRHiFIcsv0nOkCOiGtsQRF+/lwGW5wwrYmPeJ4D?=
 =?us-ascii?Q?pKMKpuMCkebNvhdyLGe88PW9NzE6ggsXp3fNGUvebxujSZ13GZ7VgHaW5NYD?=
 =?us-ascii?Q?knI9Zr2DraeSaYNR6nOZLEMMqUJN64aEL8fHH2A1C2YbCJqFBQzZAMK74fy/?=
 =?us-ascii?Q?I0+aAUbYkOZSa7moMuvNiqJkvtPVme/nzgvsy8ltS6KB4R3cLlTARk/Lqobf?=
 =?us-ascii?Q?YoAEvJJR3EnJCAnY2EdPkxl3T5tkGnpmKqozch+XnqZ1cyMGmetjoWmKFOOA?=
 =?us-ascii?Q?7DlLzyo+y1c7Nnjh4nnDwmV4HjMPzeP6b7ivBMY4l3TJp9AGfYutBdLIdWML?=
 =?us-ascii?Q?Na6olzalpNqALwAw5shFmNSiTDLUxHnr3cyJELfpjIupcVLZnKO96OdkyhhR?=
 =?us-ascii?Q?tllGjwMS4JMbHestfSOaWJIgCHJtbiQZ4tdcMazQA3xo+HB+9uxcnJEFOe0C?=
 =?us-ascii?Q?BsaLoXpm0EUCwxAD4jftmc4NlQoWDlc68YuE+RUtcPSVCo82WAyyvpBHwNMV?=
 =?us-ascii?Q?VBj5LTfONO9IG4P5azxJ/DLLkGUP+4qoQon2nSnVgHZtIQgCu6h0EHnzWxFY?=
 =?us-ascii?Q?oCB5ZMW+MMZ/rDmp1zNO4UXs9vMVNTcE/UwlVezxdqunhEg+DEgBnYNP0Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:37:11.7383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb164d2-330c-4cba-3177-08ddfc8411aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895

CXL currently has separate trace routines for CXL Port errors and CXL
Endpoint errors. This is inconvenient for the user because they must enable
2 sets of trace routines. Make updates to the trace logging such that a
single trace routine logs both CXL Endpoint and CXL Port protocol errors.

Keep the trace log fields 'memdev' and 'host'. While these are not accurate
for non-Endpoints the fields will remain as-is to prevent breaking
userspace RAS trace consumers.

Add serial number parameter to the trace logging. This is used for EPs
and 0 is provided for CXL port devices without a serial number.

Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
unchanged with respect to member data types and order.

Below is output of correctable and uncorrectable protocol error logging.
CXL Root Port and CXL Endpoint examples are included below.

Root Port:
cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Endpoint:
cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

Changes in v11 -> v12:
- Correct parameters to call trace_cxl_aer_correctable_error()
- Add reviewed-by for Jonathan and Shiju

Changes in v10->v11:
- Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
and unchanged TP_printk() logging.
---
 drivers/cxl/core/ras.c   | 34 ++++++++++----------
 drivers/cxl/core/trace.h | 68 +++++++---------------------------------
 2 files changed, 29 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index c66d37d65241..8a3fbc41b51f 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+	trace_cxl_aer_correctable_error(&pdev->dev, status, 0);
 }
 
 static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
@@ -28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
-					       ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
+					  ras_cap.header_log, 0);
 }
 
 static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
@@ -37,7 +37,7 @@ static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_aer_correctable_error(cxlmd, status);
+	trace_cxl_aer_correctable_error(&cxlmd->dev, status, cxlmd->cxlds->serial);
 }
 
 static void
@@ -45,6 +45,7 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 			       struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	u32 fe;
 
 	if (hweight32(status) > 1)
@@ -53,8 +54,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
-					  ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
+					  ras_cap.header_log,
+					  cxlds->serial);
 }
 
 static int match_memdev_by_parent(struct device *dev, const void *uport)
@@ -126,8 +128,8 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
-static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
-static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
+static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 
 #ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -237,9 +239,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 }
 #else
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
@@ -281,7 +283,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -295,7 +297,7 @@ static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		trace_cxl_aer_correctable_error(dev, status, serial);
 	}
 }
 
@@ -320,7 +322,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -349,7 +351,7 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -371,7 +373,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -400,7 +402,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 	}
 
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a53ec4798b12..60b49beb5e3f 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,40 +48,13 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
-TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-		__entry->first_error = fe;
-		/*
-		 * Embed the 512B headerlog data for user app retrieval and
-		 * parsing, but no need to print this in the trace buffer.
-		 */
-		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
-	),
-	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
-		  __get_str(device), __get_str(host),
-		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
-	)
-);
-
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
+	TP_PROTO(const struct device *cxlmd, u32 status, u32 fe, u32 *hl,
+		 u64 serial),
+	TP_ARGS(cxlmd, status, fe, hl, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, dev_name(cxlmd))
+		__string(host, dev_name(cxlmd->parent))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
@@ -90,7 +63,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_fast_assign(
 		__assign_str(memdev);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -124,38 +97,19 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
-TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-	),
-	TP_printk("device=%s host=%s status='%s'",
-		  __get_str(device), __get_str(host),
-		  show_ce_errs(__entry->status)
-	)
-);
-
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
+	TP_PROTO(const struct device *cxlmd, u32 status, u64 serial),
+	TP_ARGS(cxlmd, status, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, dev_name(cxlmd))
+		__string(host, dev_name(cxlmd->parent))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 	),
 	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-- 
2.34.1


