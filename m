Return-Path: <linux-pci+bounces-34820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C5B3770D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445D936013D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53864101F2;
	Wed, 27 Aug 2025 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uMJt8pDE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984091C1F12;
	Wed, 27 Aug 2025 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258588; cv=fail; b=btqWYTrR3j6uADDo07+8+OMeZyJleCW+nbVLDTTHRvFNm/a8ZoGIWjs5LJx/YfQ+28vdEzjpLa4XDGYbLZekaxSOZev5doW5UAOdGk/xD2D8UWPxtojFnjtZlaqSXDSLx/SH9xSCbClzR2kuexLK0SbUB4am0CeHAUFRWWng6hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258588; c=relaxed/simple;
	bh=mIWwnFwv7n/ReKkyyIXgOqAcWuvBoRKKrB/s/NRuVSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9oExoJui4YCttM1Zr8Sp7ac+5neOnnrbBVWABXZCQtojXNNamXXkb0l6yfmQ81bJhhdmuxMMQnN5h8srdtNWrLmACrViRQELUnJvVQS5VX7+2gkYaLYfoxKeg5HkpRzqWKz95Y2sV2sz44d10QHfz96hrQ3wlDXKqVmwiVccyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uMJt8pDE; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk+fZlwAgXbyQOQZdXp4DaNWa9/8DlxBujITPPTYBZ1G4okUIRYArnV6gKoa/SwfLHNz1S1owAJBWm6w40Di2aekRxT5EhnKrrcFqVCzf+sYG4G3loql/PmBuGD0f/E17NfF3SAkZhtUBI8k49D1AmPMwPFKG1MF9BHGnLCA11E4T+gYWEqLal+SsNurudxskgymMcgeem1b0iIFxf5m0qUOWIaDVFyCRv6cydzdROxY+3J7u7/mpdnyf2+q3GpG81ln1wBxBAF5Ml2Vyge+hFIEcxuHGYX5O0tO1+QN3JNgFQTtC98dLs25qD2H+vn5FFtoZIxzr3PJuwfPB0nPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Shy+40vFuEPUhDmg3UIu0aCsd1MSP4VlsdpaHSduph8=;
 b=mZeX2TyYwN+AqfVJaCrokZiaCgsjf2AtipYK7pAPYQ5tB2QB7E9DUajSp7oQCFBI9n/8aaBJ2YM4xWuJ9owd74oPqQGBk36eWXf8rSTINzE6Pcpn4T0ypdAzXq825n3ATEP+1coyQ0m6i7nPNZpOJDqIr0wBYBjNfI0WcaTbwLW4PeJQ0QrW060FamXpYC0fwnsHIikpOCzCgqUR3iUjn9/htqUMAuagMbhh5Y/deg60x0BJKiRRYIihveiOfnHX7JvqTSgL2B3RgBmxwDq6ZId18+4c1SZnCYX2zTwT1z3KbGMdhnNZ7ZxbWULDrECxhC5/vdCpBDyquAzJG9+aeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shy+40vFuEPUhDmg3UIu0aCsd1MSP4VlsdpaHSduph8=;
 b=uMJt8pDEWg5WOeNPFSgU8nVoBkRkfEtuCRPjLbbT527jLxwEnNAViVFL0vqHpzOWPXbG6btNf/xhBAQh0oQMWNlzKCWTpXhBKp0iFHJetPdo3nR03PhAk+onVG9Ns6mRaKdWRR5I9+5csp1wd8jOXHHn0wd0ThmmcA8Dw4VSHqQ=
Received: from SJ0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:2c2::7)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:36:19 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::43) by SJ0PR13CA0032.outlook.office365.com
 (2603:10b6:a03:2c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Wed,
 27 Aug 2025 01:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:36:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:36:18 -0500
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
Subject: [PATCH v11 03/23] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Tue, 26 Aug 2025 20:35:18 -0500
Message-ID: <20250827013539.903682-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c100bc-9e0f-493b-88f3-08dde50a1f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|30052699003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUHkf9V2KcHFM1WnxIiJWBvFXcEGK4GyOE0tLgvhIw57205qerdygFKA9KtN?=
 =?us-ascii?Q?Y2K0YW1bOJuzdnvFSyO/mChc0ni3qOp9Kuv26Hk6xGwoW43vb55cMKWMvmvb?=
 =?us-ascii?Q?hfvXxYdfbWX3ZVDbpV1IKrEYuslu0CyDEcSmSRfPQgjIWDLTd6YG9+3kpluq?=
 =?us-ascii?Q?S3tSGB0Gc9bIqe70gnCAZm7Ev0j49Y8v4qRoeOlViPe2GCv+FnGnUkjxIh8w?=
 =?us-ascii?Q?tSfn6nrfyvv0ELoCb9PlMp3rdmoHSVqpHnvTrm5qGb+7/zlRRVvQBUVkeQz7?=
 =?us-ascii?Q?HJyRAMAUXJbQ1hyyvf72ZO5J8rF7Nc3syvKBT5iVh9GX7OrgIFh2mvIR4MOW?=
 =?us-ascii?Q?79BQh4V40FuUcc6Tr9XzuLui4atIyBUVyU600k+HK3PfTUt2yQ2rfXUYiq4O?=
 =?us-ascii?Q?Jccu0WGszGMFOLe0MHhZvJ7Fpzc1LWPCkskjeD4mZK6yEk/CJvldHUKeYEAu?=
 =?us-ascii?Q?qOT5uxP1uBs7WZZ9hU9LZGqT4XJuHNJ/4Tw2wM7rRB0TXjpeX9pJvHz8vzpI?=
 =?us-ascii?Q?rh3fGfbGcP/iZCeTC+5dOMP0LSP1gstDY2BLpgE6ttAg9WxlWSt1STvBAl0j?=
 =?us-ascii?Q?hxcYFJKfy3CMJ4JNGYiigC9hhd27LuNFTJ15DKvQpUCXujk0+sRb9r5PdHmc?=
 =?us-ascii?Q?MBmvOPAK7ACiKwT7ef7BLjAv3DvT/WJ89zzk0ABTuSuaLiWyd1qIAOmRH9wE?=
 =?us-ascii?Q?gKUNreybp3NFgWyQnJXBSv3PmhAbpT5FrSYr0banG1QljkF4SoelpknNtFOh?=
 =?us-ascii?Q?yNx1Q7fSw3bbYB7n59dMBxWz77FWJQbIdpp+PNLB3KspqPTgpNqwZ64At1Ds?=
 =?us-ascii?Q?BR0LtGOzkfkWhhW5KfE8wf8k1MNtGJ7Ng1aoMkLv78P8p3sLlNr4ccXlFr84?=
 =?us-ascii?Q?MEVgWh6IGOgfAfEqDu+hm2sddZs3SpCtZLic9NqTDGWDtY/iNreKMPH9uF/t?=
 =?us-ascii?Q?b4e6bFPsHBtpp2D0JuM8z1KFC0s4grG1w7piXvw1DRlHhRT0aG5vIdUC8UTi?=
 =?us-ascii?Q?h4Q6SiXrJ+vlfEABFM5GUnrMFCV4l1gH5hr/9242aU3zI9sBCcG3lVeMYUpz?=
 =?us-ascii?Q?UwuZRQlAulNQuvAFJPqM96s1AkyrTz3/pexRGmNKqJ0tIeoSSY+uRACHj+T7?=
 =?us-ascii?Q?XczeOZi5aMBc+rgjXzmhBbrA3OGvOZtc9zTcxAlUN8b3B17c8YSLbMZseAsJ?=
 =?us-ascii?Q?DLgxvxoVs6Mh6BjAOCdLhdESPKEpSQduxPy4gkinWwsHGFWWx3Y/0kiwLFkK?=
 =?us-ascii?Q?ful9vzgyWkt39moJdJvVT2qEudI1IyU0lylFWRwhAre8kf8juKoXpzJ0w3SF?=
 =?us-ascii?Q?SJ+YZ1wRrdSY2fUuP0U/DMys1E+ovWqa3c4XTjsWHxuXaid+zDBmuJgyLUL8?=
 =?us-ascii?Q?4rc9wwXxBg4XIlaLgJQVerpELtVADWU79/1IeRh5khyo0M1Ey5+X/W9S478S?=
 =?us-ascii?Q?uLnKtfhyn9Na2mHVH2/9zadjuUqJKIHCSVyDvZnRhnQRc2ZoloKdTsDQAn+Q?=
 =?us-ascii?Q?IyEEOn/4zMT13sPaviB8s6fyFkezMMEbfc10xCNir1IlpsyEs3TLW8+U0Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(30052699003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:36:19.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c100bc-9e0f-493b-88f3-08dde50a1f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
are unnecessary helper functions used only for Endpoints. Remove these
functions as they are not common for all CXL devices and do not provide
value for EP handling.

Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
to cxl_handle_cor_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

Changes in v10->v11:
- None
---
 drivers/cxl/core/ras.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index c4f0fa7e40aa..544a0d8773fa 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -200,7 +200,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -236,14 +236,14 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 				      struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
 }
 
 /*
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -279,7 +279,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				  struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 /*
@@ -355,16 +355,6 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 		cxl_handle_rdport_ras(cxlds, dport);
 }
 
-static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
-}
-
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
-}
-
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
@@ -381,7 +371,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -410,7 +400,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
 	}
 
 
-- 
2.51.0.rc2.21.ge5ab6b3e5a


