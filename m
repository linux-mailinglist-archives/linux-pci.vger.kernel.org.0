Return-Path: <linux-pci+bounces-30849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89CAEA9C6
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5227B3B0C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042DB22126E;
	Thu, 26 Jun 2025 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F2XPxqSs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581120487E;
	Thu, 26 Jun 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977798; cv=fail; b=Xx6t9l7Hbzw2FWOM5xtUJwUm6quzqlniUxCYK+cmMiUN3h4hFNUGr3++k4bza1aKIEENBRxdf1PsfTba03F7fesKKehFOF5NQGXUdSEjDJuUXwntXBywaXGLwqeUY8tJlL+YUENcglL4eJJkBJArGdn96augHt4hitCA4WQvzSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977798; c=relaxed/simple;
	bh=YMV96OABWbFTRwXwIHAcW3vQrvc4EZroYghPpWDSfbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bnuk5RRtAeA4Bxmkjj5fL+pyeX9HBEDV4AenunWuCDGtowi6+fBR+uore5zxG9kuZuufNfPoJOON74E0+/ZvOxTG8Xweiu4HteuqmjOKRVx1HQmJFcJNNuJUKnJWilK1Kkm4RShW/gk11doKXd5M9i8R7kOOiJNZHwXhI9cPP4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F2XPxqSs; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOHpTiHVxEpx+qhOTQwk/4CL3iGKObyYJ5opNt8LM2U6g5mVc+m3D3rFtlTZLCVCHAXkwqsc0GZVUaTqi4iXWyAxTYZySD+TmhB/8bCXtcwaNaG7ZqLUlIrfI5Nf4z0k+mXPXzYAzXY1ytC4CFst5Wd/SIRH4Xje7MLHM34UAuVfqNuMKW8P1141DJWQNquLsp1uzHZUttw98S0fcIm4XZsxepjacQcaSWoZVRSAt97LjL2jC3Ut9x8dlmZRxQhw3u4n9mdUBbGXJ6be9MBV191cN9ZDSFCED2Rz0NwOcMiKuz26shxEfReJjP9hgtBkPJv9y2EVHrpoahwb80d8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRUgwwGVgsqpJOFifGHcvaBxo6iOm4cloGgcI5a1N5g=;
 b=GksrXcpPT2j6E5tSD5iUGfHSU9zDWDt+9+oxw18tvOCRRT6yyzbdtO3Yp+O4Cpa7DO0Z2abGkuRAoxVergTQyrA0/jbyzosVhatyAvFU+X8GM9bwtR8TOEC0+lD6nTJlLiCt2UFmd5Yx51Sd9Qm7c9jJ9JH9cCpv5WcomjgXZaOd4ClGdlJXHjqHPjaQW3gIcuJbov1rRJlPlK+iEPfSQwrNhkyhVhIJkn7OrUm/9xDrmquzF8PMslAeIXQOgwgCVFYfLgBVsul1AHaa5ma0fAqNIi7qgsgDEodkREsYS/KXdUmxniCHcZ3n4H9O/Oy+RO81J4jKlfqb7RHDPO6XZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRUgwwGVgsqpJOFifGHcvaBxo6iOm4cloGgcI5a1N5g=;
 b=F2XPxqSsPJ/4nfQeSIyAC35wbf3ejdwNEu1KfHy2bdJZkWRFk0R0axdR9WXWyALPgVtEsYZbIBWSyHNG++VQX/CVDhRzV2DiEHVv2CCzUlr0qnx4Cw3Y//x1pdjBqsdRu7H2eh4xtLKu/3dgZ9Ex4yjII6qtHjVix+Mt0GfeOsU=
Received: from CH2PR02CA0029.namprd02.prod.outlook.com (2603:10b6:610:4e::39)
 by DS2PR12MB9824.namprd12.prod.outlook.com (2603:10b6:8:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 26 Jun
 2025 22:43:10 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::2b) by CH2PR02CA0029.outlook.office365.com
 (2603:10b6:610:4e::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 22:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:43:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:43:09 -0500
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
Subject: [PATCH v10 01/17] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Thu, 26 Jun 2025 17:42:36 -0500
Message-ID: <20250626224252.1415009-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS2PR12MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: 43308e82-3ab1-468e-835b-08ddb502d3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|30052699003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAtPnDxnis6YPIMG899pX8ZO2sTB4qY92HEaX9UQ+wC3/YUiqnnINhxB6QUq?=
 =?us-ascii?Q?/zQfsqZuwL0qlUOIvpl1qTL2dR0m5ln5XzdMXnvZvsq82M/FbyWTEJNk3uBI?=
 =?us-ascii?Q?+tutx5CNKouRiUff7n1mWJlSk+7qCtDz7PhYIAg6vmnD5L+ZA9frM/wHH8nn?=
 =?us-ascii?Q?TNnJtcE3/DnRzwLAsgmfo8WJ6oXF0jIpkm5xq6hsbE0ArLCbwo6YzI30FduQ?=
 =?us-ascii?Q?97Vg4+nWTYHYQHCQnWuIUBhPhh95dkkWYJmHbcIh8lPWFvGV1s+6VYfmlPgd?=
 =?us-ascii?Q?HMiq4WYrNzHtnVti8WkpyknkethnHRftA4pwSiKiB7ZXMoQ7CrCo1eDq+LEi?=
 =?us-ascii?Q?h8mSuaQ3ShMtQJJEuDLE3/mxcKpgbdISNxaSimdrAM4NNTGRkaGowCv+wpT2?=
 =?us-ascii?Q?2oOmVbIUjEmJddjZ1NeeR7vbUydsmb/p6Nn9VX05sPM06vEaySzM5k/DzI9n?=
 =?us-ascii?Q?ZzbJgtpPLVdQrmcRvR/WCMDYQlfNX8bGOIzcQWqwtmlWQ3YIk4AIYcBO6kfv?=
 =?us-ascii?Q?J0HUtlf19g6mzoamaPgQ6iK0xBdIECfx8KbYFYeb1Cwe9qfVuB1XeHryNgxb?=
 =?us-ascii?Q?lJk8p8IosuohcGtLcXnCxxVub5/I+Pl7E6x1m/+RLgKrJDJHUKcN7qtAW7q+?=
 =?us-ascii?Q?O8NNE23yuCigxrBJbqstYJY7QA77kWu4h1ZARux9U4DUYs4SPEMIzAXQIXrL?=
 =?us-ascii?Q?HYgdFEpNYZUraSQBQwO9txubzuVJWONZhjcaM3ygemIoIqv/XMfgMP1pcUKd?=
 =?us-ascii?Q?qnyiTTAuRtzGCToJ3syQk1scqEPTxsxbbil0cHY9uk/m4cxvTe9GZpseaQrJ?=
 =?us-ascii?Q?T3sSnB2FV7IV8QhQQqMlNuvDuXJXRCEwtX7SuCWy3PBDkp0dFBbTx2/B4xex?=
 =?us-ascii?Q?xBLhn/qAhcrQNrJtm/JVia9Dj8FtfVbxhUhaRQB3eOiJDBbDQzOsMXNXQOXC?=
 =?us-ascii?Q?wp5ta/FOXb88LSxk/wbjH1qblYAwQ8/PpdElmvrTLbIqpKho6Bys0cBTmN+J?=
 =?us-ascii?Q?oVdg6iQRKR/2/ZMOyElq+knDLaCIFLppFSfDXJMZVUfX1lB34S+Apim7+iBH?=
 =?us-ascii?Q?HQLH5CuXYjGyfU7iCO19yc0Zixj/k2Ti3WnbZpYLPcaLjE7ilsduy2vCT/VI?=
 =?us-ascii?Q?zPRB8ptSi6ycJTowaV7kFIyIXeJFy5+f45SibpQW+5tfk3+APLYdOiTMIZ9d?=
 =?us-ascii?Q?g815sSfvqOV1cn0DY6Vd9BYR/O6My8Koa2zePNIw4oYKu3W2NZ1jklqtJWqM?=
 =?us-ascii?Q?6MK3mp+kpwp2K4/yG+D7c8ZIAB6lAa2OgKLFvDtbKdsjFzPUMcodGSUkRVmS?=
 =?us-ascii?Q?jXn21i1DnH56S3U+KEzynD3+/Ik/7pGhjyeIg6ZidsgsTa6N5QcXoWFJ3r4L?=
 =?us-ascii?Q?SmCnKiEc6d01wHQSkHVnrZeiRJp38zRxoKxUhv4acQWQyaMxNlckyh2JTfz+?=
 =?us-ascii?Q?Agz2Sz/+1Iq/XfIRa9KxEuqWvmo6N/AtqChSMxReHz0Sm0cAb31Qm1Ij+szQ?=
 =?us-ascii?Q?3Lv5HSNP2R1OJxi6UEXnXDFlRemfca+wvf6AWV9WMOC9WtyX385Gr0B3vg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(30052699003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:43:10.5207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43308e82-3ab1-468e-835b-08ddb502d3e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9824

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
 drivers/cxl/core/pci.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b50551601c2e..06464a25d8bd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -664,8 +664,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-				 void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+			       void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -681,11 +681,6 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	}
 }
 
-static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
-}
-
 /* CXL spec rev3.0 8.2.4.16.1 */
 static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
@@ -707,8 +702,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
+			   void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -741,11 +736,6 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
-}
-
 #ifdef CONFIG_PCIEAER_CXL
 
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -824,13 +814,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 /*
@@ -927,7 +917,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -956,7 +946,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
 	}
 
 
-- 
2.34.1


