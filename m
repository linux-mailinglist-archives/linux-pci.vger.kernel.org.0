Return-Path: <linux-pci+bounces-37035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4754FBA1CF1
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCD017D585
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE3286439;
	Thu, 25 Sep 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UZ7MbVcc"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9513218B1;
	Thu, 25 Sep 2025 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839705; cv=fail; b=rOMcaNSOqbWESUh7YhsUkR559r4ykpC8C6TWBmqsJFC3jxHmztKYvkcWyvv3enWp7OScMFZm8lWdrKm4ptB8GXyNME7ZRAjCtIE5SLJCjsrvVsoly5zV9P6BlQRm6pxTRNS4XXpfiSKvWys1jLaP6QmQybDluMZFEYfs1U6zW8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839705; c=relaxed/simple;
	bh=we2yb8xze4xQ6eg1W8p/RbdYZK7VDFJRM7kaqZnTHEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWFOkvOdDkmV4jmhueZtcka1awuYBrP1zcTB4/G4tSwJuo0uGvRgIHZiX9S9qhNxfQfSjwMd3Yh1knXMsmyMkEOoj7ixOFVzqLagqE9ZvKgzowVndHZ6awiFJ/UwdtiYT9HDWhoRYNXU/yyx8j2fYhxPppAN1owvQGYXhw056r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UZ7MbVcc; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9XRzm0Og1DhfQeQIsDqxP4Oeh/GonPLmjaSlnPrX+xN8mohxdsaylNVJCPap575N9ygCqpnHiEjqzDcWa8x3lOYCt60HxmdSbCuii4LDC1PCw9WOODo+7YGUsHlwfZQSgH0WBkuDW+8mwBJZ3aVqqNmzPjopkCJpZ/p3zsNeTDYYfKsZK8GrQsIFzCPXWvptCTW+r3WHQlV1ht0LvXY91W8WWwc3DfYKJLFpzuZodDIz+oZlVyXpiVXEveHT1zOyIffHVngJ0qx5CEJ+rRv2zjh1KTkQy1Do7neER3AU1sa7AflBkdEfiaT6Cii3/QvgmMDQrJkCL6WdQU9qeuw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daUB2+cA8NOYz6XrOm/uM32K+zNas/tJeRLX2CLF8kc=;
 b=eNk21nCYjjFe4GuHuaVAQJ2AjJDvwWVpKmJ+zPjH60NNudGoXAVIvY8AAqI7ZZwlIRUUOjKVkJ1tRlz9vrzE7jK5Ctibu0haOGfxJpysjFqWe2toIMmBW9Pn15NF8qMVrVDjf/v6rSNmT+10ux4Rvl0ldG3QT3L5lwAdqfJWOqBy23wr5WGfOJc1pI/tgzWR7jJIlEUujH8i9FLdzflJIZk96nW3Jr7W3koy+WEsDzrkT0vGCsEbbZv2zMz0yJvYxd0OicBw5GUf7h79WDkeRO9V7CLSANOonNd0b5qvfOLuOQBdZDvrQjGmnX2BoZTUypg92YYyk3xlSb8bcjkldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daUB2+cA8NOYz6XrOm/uM32K+zNas/tJeRLX2CLF8kc=;
 b=UZ7MbVccxIBtOQc1v85XPTrnWXY0JrrbFxJ+nd0B+iO7BrDBULwnj2Xdwi0F7ul08YDaG2CJKsFa9zPAPJKLr+CbyivautJcmZVWVakI6oW0CdD1/8upxnOE0PWAN4vGgCaOeowGGIDRIHG7ZJleni8A9oQ17u6lAHHxuwM3FEE=
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:34:58 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::b2) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:34:58 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:34:57 -0700
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
Subject: [PATCH v12 01/25] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Thu, 25 Sep 2025 17:34:16 -0500
Message-ID: <20250925223440.3539069-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 094d915d-be67-4810-f2c6-08ddfc83c238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5EWR4OYnhOqKbXnGT95zXPEpRy8FvKkHOcEd364tG2EWNkKC5pg5k2Id+HeT?=
 =?us-ascii?Q?ESsAsis5BwoRzFa1ymImWJReJfAoeS0otsjKcoJlj+svMGfMCU6wa5swh3to?=
 =?us-ascii?Q?vIHHDH3eSE0O9pmYBJO9RRofeD3Yg13ajMFbw71O8f6FY05pvImb6SR5TSTN?=
 =?us-ascii?Q?nj06W8AdmEkAntmUJBDCbMExZtzy9pTiSEGGJYKW0B1DuCDF+rKSHWXQq/OK?=
 =?us-ascii?Q?A668FjKQvUbaL+fyfIwn/oktklEIyt+C31pMFTSZZAiBsuePcBZrUNnRnmC2?=
 =?us-ascii?Q?pXYlA76VfLLFBr9WkDcEIB17aGD3hL+SWu8N8NDETSy6HbnqsUkaGl8g74+C?=
 =?us-ascii?Q?4zGGMF6f8HzwwCO4nqDSYcFz9029Q8aZTJ8DP40CDxpqUKzvWpWm+FiOMzMp?=
 =?us-ascii?Q?1y/Ev4LiNL5FLuthjWQfnClUKFRiyry2g5y94PtFYGJPtbSx4AS9wKn7yI32?=
 =?us-ascii?Q?88XSPKpb6RQYUS6GG7o07EcnuNQN2gt7dV5giEVr3f8wjs7kCt+GPIGAcmVt?=
 =?us-ascii?Q?S6fABwowKRN4Li41HJPDtA005GitcPCfd+P53gBfrr7DkzG7p9YF7QKP1k98?=
 =?us-ascii?Q?PwHFPsr0KDmwfzoZSbU02uJ5m9bE1C91kMz5z3WbYA5c/gTOdnpoQ8USXjcR?=
 =?us-ascii?Q?B0N2iJy3JTy5ylwzjDxX2x/p/TqgCIisz1vlF99p14iAKcQd9hRIcm/sDU2R?=
 =?us-ascii?Q?VURcI9vCFj/6xIyPfGyRGFAHT7W1E1I4Suvyvi3DJ934ZBQgya4MWljtGCM5?=
 =?us-ascii?Q?tHijaDjuEiLsWL9xZPrq30rwhbuFtgJzBRCCRTD2FSKwZMF90riaBGAASYmd?=
 =?us-ascii?Q?vhcgE1tvxREMd5oanHOP8d7nUeYClLvd4CMwo96ymeYTTRqE3vj4ylH7A7ci?=
 =?us-ascii?Q?qf8rzPcFVIYX6sktTVWQ90JtwbVfu9KQDJxZvG4L5gFH2v+gcfcsx0jbI7eF?=
 =?us-ascii?Q?HCMZfw/fqEw3WVR4h819mqWFkW2zcsRXOYMx96bRHmT6XVUpR6eR4E5TjdRS?=
 =?us-ascii?Q?M8Cm+0Qga7oyfyQ9jlRuDWWGyr66jDinls9DrpyVr12QKuVOU4zUBZAktGXE?=
 =?us-ascii?Q?B4K4go2GJZBCNTBlx5myuOo+nzYiM8A97Cb2fdaEKivCI7gNn6vrabRAPsOu?=
 =?us-ascii?Q?B7uWtUXi5xem6ln6u8WOWH0nCIuHnM7IHVFCJFHt5f84jtkj1S0VzFTPF4//?=
 =?us-ascii?Q?L3Lp5W5SHucXIS4ilHnTVxkx6aOgJJd0z5kx4Nfq8Q6qNG5T6oDt3D5P+tLt?=
 =?us-ascii?Q?gVoaNUn3sTjZ+YsI9k1e/VlNTKWRMVtOWrr+BTFM0JEaHLOw/z83lJ81oFJ8?=
 =?us-ascii?Q?ebPzX+BQHTRB/8eCCLFw0Ct30qAl7/K67kpLGIISBD2C51oJPnfluneuEOjQ?=
 =?us-ascii?Q?2m+1UmLuhpWb6GwuCDQa+hNtulnxKsGhWDaKtavltV4EtGQ6BQcm+aYCmJXd?=
 =?us-ascii?Q?hOWOV5CY4vJDGPCadHuJEW3WfAVJAck9oC7CEyALr6CCuKTPvYtS0xST/LMY?=
 =?us-ascii?Q?op4T0M+dF1wslBFc7FPCb375Hf8xLotPCgORCO94UFcwp/+6DwVUBCnt+BRX?=
 =?us-ascii?Q?fQ1ilkDGFNUK3ycdSUHbzlTvu1DOe4ouvr1LHPA7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:34:58.4569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094d915d-be67-4810-f2c6-08ddfc83c238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
are unnecessary helper functions used only for Endpoints. Remove these
functions as they are not common for all CXL devices and do not provide
value for EP handling.

Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
to cxl_handle_cor_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v11->v12:
- Added Dave Jiang's review by
- Moved to front of series

Changes in v10->v11:
- None
---
 drivers/cxl/core/pci.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 18825e1505d6..078e9e5651e1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -711,8 +711,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-				 void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+			       void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -728,11 +728,6 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
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
@@ -754,8 +749,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
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
@@ -788,11 +783,6 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
-}
-
 #ifdef CONFIG_PCIEAER_CXL
 
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -871,13 +861,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
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
@@ -974,7 +964,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -1003,7 +993,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
 	}
 
 
-- 
2.34.1


