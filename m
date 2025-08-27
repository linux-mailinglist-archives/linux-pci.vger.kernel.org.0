Return-Path: <linux-pci+bounces-34830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F75AB37727
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6B37B03A2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219421DFD9A;
	Wed, 27 Aug 2025 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hFsp7y+c"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142619924D;
	Wed, 27 Aug 2025 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258702; cv=fail; b=oyUgcAJxT63+hUHjFJYTCiY0Zut5ZAUtQWrhBixfJxx7d+Vu+bpubhguuQJSQA/8Qjp5Lu+jPXd/LaP6lDSXiD+zZ2vwEPG7icmoyW5FKSH54YxIZ1G2SRv9g2DxX5nXIsbumfQDDM6aydDxnXeXrnEdebjTckX5MG9VF5hn0BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258702; c=relaxed/simple;
	bh=CdIPH6Oy+7Ry2oSTWmTHqL9LQT8B4mEaGadzlYKeupc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJNOAnVu8Jt2EYCqTRqIVnah7c3QgWTORAYehyt4PkunIV64rfOWm/1BY3AEOzoyrGLTGuQbHjD3U1NR3YFWgK1EIBs97NXU7nN/C9vikat9PtHBxTVoYzpKE6CJgZMZt7ro1qltmSJcpM33sB6NGi5L6vv1a/xZ0HVUGqEuuzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hFsp7y+c; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO5eadn/fYTiwwPJDWnunrQcMqyYjD3kY2OAEDzGUy/Z2LqPTPpttGGbP0aKfIJSmVfHa9yC/eeoNDodIfrbWgj2mh4gtbgONrSrowptfEwlAax07r5FC01lK1CoPL5+ZddqGKGFjTW7KUjDByaqNetWPNc4b6ZQnDV7LayDIuT6ED7pDpVo3QRDoGX0SKpwn3pJ164hg4lAfcdRJYNZa6u6l3fu1DZi7I30feUpQ3waUbAeuXOCx4ffrBWDZpexlDTFf6pBQNSWPrwuHRYtsisvnxuBYbGi3/f/ThThp9DEjaqxkQ/ml+ZTksNvJY+mZXt3D5Q9KU5HHT7VA8+pVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGosnfaTqMnS2GT7TQIdWHq01QNcOwc1NlzWgL5NOKM=;
 b=oxDmCCLkvlNFuuYrHpiEajplzJXBwzdbQ7WOlm0G+Ir5fZeYoxgU4Fl+urD28i36GNabtRrdJCPETkssR+tcvQGA/iJX+dbta2RK8e3+TJqwwTraw7g2STgL1wCjbsra+nipwu6k9LGKMhMe8aNrP7xv0nQMCZz+2j9GhJKiybjm/gUxrXyjWgidxjh2vN6wfD+byAZaDZ+H4OEauXUcRuUbOa3gkgXvMNpnwQ2m/jWlR0R92HxeAh2bYLtsy6ZHcqiegTcteVYre+DBvwalLKQTpRd6jiQeKHXMkfxlSnbRX1CCrwt94hNv35Xv81gNl/6GG7Bac3UOO2L7htOL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGosnfaTqMnS2GT7TQIdWHq01QNcOwc1NlzWgL5NOKM=;
 b=hFsp7y+c++e24rfyK/h8XHJ66NBvfDdbjIjVsefzGsm58Gj0lJ63TkbyK+Efrmok8N80o/z3Vdq+5HbvMZl5ETF8a+RjvGDHarJTMUOMPhJJCW2Fh5WnNOIwH7EPUKX6l/vrY3hcoBx5x3cZDyK9RRVwiGcgdIDol+6Y9RE0wT8=
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 01:38:14 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::90) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 01:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:38:13 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:38:09 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 13/23] cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
Date: Tue, 26 Aug 2025 20:35:28 -0500
Message-ID: <20250827013539.903682-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8631f0-2ecc-4092-15e9-08dde50a63a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PC93FbxMRgPXKFbKMovxEUDQ8P2tu65c6briJ1Uc6/YGhLXaOTdiwrd9O4KO?=
 =?us-ascii?Q?1j2biyaDTGINciSxIEglF347wH10EZNUPKIYZqiCuKf7/NqNJfg1GSBTy036?=
 =?us-ascii?Q?4vY5nwfwL0a20/+ynX5gM7b/ezqrKmVus82moiGFKq7Mf2IBRWW8VzwWkue8?=
 =?us-ascii?Q?qFArBo2vmcka6E2CWoOa+Fn5mlaH5z1PiG197Vtw08yu7GyoLucacNfVioaC?=
 =?us-ascii?Q?vut9MuHu+h2yLm+8f1XIfknPRAjb3p3W1X6oezQkVctLBRmU8fYoc2Oj7qzP?=
 =?us-ascii?Q?rcSOTVi1+9ISdpI0sCogmwO8MIjL3z7kl4PBkcTR4HUr0Ti6H0Mhpk0xwK1W?=
 =?us-ascii?Q?z6MZfCiWKalXc8+qqfiyiaj3SodnDnboJAO4XcsdEU/nhYenGG3Ki2wu0rRl?=
 =?us-ascii?Q?+rb60MqsluIFb858aBzzYh/YV9cOV4uYt7ncgVNTGZua9+mGIPlr6ZDLeAz7?=
 =?us-ascii?Q?b1QvSswXoQApgTAFSaDBP1RyHQ77j2NzWpb89KnsjArCsQM0aK+xhLJWuty6?=
 =?us-ascii?Q?EwOPgpvsDcc29TIkXaz4uw2o8YqxUIth3JYVKOI1xap/1HjGfJwSPEl+oaLZ?=
 =?us-ascii?Q?+AOuWxmNffTy0EkCxhrPTwfYbFF6CHBR/CdQ3kHr2DoP+I3fa8w2/GNc/ukx?=
 =?us-ascii?Q?q/OoeT9CgJu6s35AJQZazwPvf7l0Q1ty0QXROpFkeBCbhZLCoNQ1G2QRisPQ?=
 =?us-ascii?Q?tXkKwtpb9RedbUlNHgSbdWAfG6KgcBdiTaOCUKG6zpQ72eqbuv8goaOu76TE?=
 =?us-ascii?Q?04M68syTsbQ2vwFNgqN9dRC//nsfOqY7AX4jmSjqhUAR7aSpvKzx+l6/53ZM?=
 =?us-ascii?Q?Ha/mmeBTU2nurbYMFaID/DrhvWU+mbKgtsDYqvFmRRh3hmB5zMC/5GYluTP1?=
 =?us-ascii?Q?Uh/30CClI40tyLm7yIDJ9SFAU6kvMHUar3A4WNiJfL/KEa4wMlwKByCKU9Jb?=
 =?us-ascii?Q?NnEzv61Dvll8NzqLbpgC/CiaCqZFWwSZlSaydQrxy+Iwq+j9/KaduaAK6g9h?=
 =?us-ascii?Q?7Jd+HH2RiQ1CRPxPuxse01mPUDnvINdG6u3E0hs0IVdil59/wFaUPVFWnz+n?=
 =?us-ascii?Q?sYxf9hgruslczDtRYcwerwTYwAIi+nSOLUZ3wFnceS2h6GaU7/WhceiXPjc/?=
 =?us-ascii?Q?40HdfojMUJRn4fPRi+2CfjYTHXZP4l1/2mB/LjaSFzFDwQ0vZGyqX/1InasI?=
 =?us-ascii?Q?CQsjOmEZg2w+K99x8u4/5asPG6o4nmTEzFH8E09T4pAmfbO9P9F7o/1SlU7q?=
 =?us-ascii?Q?TNt84ToyTVCqQmAkykJoG5SxnmT2Z57lUMURRUsz76We1f5mIii5hp3gOcCb?=
 =?us-ascii?Q?5KlmgpNLmQgP3RJt3WFZg6qaZH7LaeDqOfRcWHh5C2H4cQMOutg6erewHZEC?=
 =?us-ascii?Q?JIodjxja5uOO+vGc5s5oB4NR96OwqBBxPJyOAbGJrOlV/2yvRkVi1lfe7b7Q?=
 =?us-ascii?Q?tfSujzXgUBx+EbPpnUzKcOx53HrZhwdeSpAbLL6AuyZHb5/68A0Stn3iJSAe?=
 =?us-ascii?Q?ORGdTJXzduFSw3mvgZyAoAPj/cxSXeYVc2lQTy/XehLXILyXc/wBLz4/Qw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:38:13.9124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8631f0-2ecc-4092-15e9-08dde50a63a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

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

---
Changes in v10->v11:
- Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
and unchanged TP_printk() logging.
---
 drivers/cxl/core/ras.c   | 35 +++++++++++----------
 drivers/cxl/core/trace.h | 68 +++++++---------------------------------
 2 files changed, 30 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 3454cf1a118d..fda3b0a64dab 100644
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
@@ -37,7 +37,8 @@ static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_aer_correctable_error(cxlmd, status);
+	trace_cxl_aer_correctable_error(&cxlmd->dev, cxlmd->cxlds->serial,
+					status);
 }
 
 static void
@@ -45,6 +46,7 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 			       struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	u32 fe;
 
 	if (hweight32(status) > 1)
@@ -53,8 +55,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
-					  ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
+					  ras_cap.header_log,
+					  cxlds->serial);
 }
 
 static int match_memdev_by_parent(struct device *dev, const void *uport)
@@ -126,8 +129,8 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
-static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
-static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
+static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 
 #ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -237,9 +240,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
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
@@ -281,7 +284,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -295,7 +298,7 @@ static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		trace_cxl_aer_correctable_error(dev, status, serial);
 	}
 }
 
@@ -320,7 +323,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -349,7 +352,7 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -371,7 +374,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -400,7 +403,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
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
2.51.0.rc2.21.ge5ab6b3e5a


