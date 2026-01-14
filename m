Return-Path: <linux-pci+bounces-44797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C166FD20C74
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D506309F2DF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDD285CAD;
	Wed, 14 Jan 2026 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hleUNtrZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2833507C;
	Wed, 14 Jan 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414924; cv=fail; b=rdM6N/YGj9olN4Pz7veFnY2pscuxdKxlImPaVuUgnNd8yINwxQl9xDmlpOb4I+YDA4SGappJYxSsyp59T3h2C3ji4AC6Mf56uUsRuSfnfqu2kYt4iGIJGcYk7e84heHJ7iiQgqmj1b/U2KBAPoj8L/xC/PzMqtNejxxp7JrmK7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414924; c=relaxed/simple;
	bh=0Tyx2I/Keh5o6wuN1b0qbTyVghIaxps6yvfGVBHAj9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4wcBMH1qeNHYlNC2iOZ2qCafy3R6AxbiOsjG+DPfxxeq4BWYNmWFCnS42zFlacfG9Z0gwidg8o2L2BiJZzKiKy6bdzxgTd5okxjlZqYElWSjZ8kC04mPIx+PVwZUTrZxPHkTpRzQKIjA33l0Aie+ouJ7OPbnE7ar/NXYi2ApvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hleUNtrZ; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icy6VLGeHduqI3d7KQ98t/HbBqjFgPM/DcChDniE8i+399E1djy2DNw/4eEjx7YKAxzEhUNUcJDY1+SvGYfNcTQPSoS399z4TAFlKIGUbmgZ5LV4FEf2ZAWJl4dAuQN233gCVkgNFnsfasi1kD2rp1xpKXTgQvD7iQjMKGPg8a4NF0rPXySIM0elZVVMQJpmBVuzc+b9hkKgiejRrikFtiyhllCyyFAfIVeSh6+bHH/ID62Qp9I1YVra5Ve7nGtbTVwDPtSaGlruA7fSfsR5NlQlOVVDh5WdBfA3C/zwoxWTCgBw/7PWn3fK8KxkKatbsYYQ03vlr5++stooRGkbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21idOm+f2+OcpXeZgZvL4Z5ixC8EvMlDmKBrAqznguE=;
 b=aKoZEPhypp4/16QXK2KEXQgKJd5m37iIC6gpSFeiqDqT7hUNdHKMX/9ifonqZ+jasiBe2zfriygtqyZyH2o3Dd8a8Eb2MsjSDT10dySO8J7psq8CX1cqaEj2T8vemTfxlYhAcKWX94VO+j9HpFpees3CREbCBVYTVjx13lZHh0AG14kp178oNHpCnRlBH6xFzGuJGbaSzNANMFqHDBAijkCr9zVh+BOPMLnPmW54XnvvUSz/mSzLDMatqXkJCHZbxIC2Zc2vSFK4TlvbfXWo9v8Q3rwM6mBlGDFBX9WTACQXV4ko14BKGD+ytn9tEDQ/+ytp6/+qkHIRdn77qaA1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21idOm+f2+OcpXeZgZvL4Z5ixC8EvMlDmKBrAqznguE=;
 b=hleUNtrZblgzM0ct/FCvVnKKguVyrA4GwGy5505r4fNVUurM9pQ/FXJ0z8Ilu8PrT1Luztn+euis58LifsCdunJm268/ocD/IilGFN1Wo2FqWUthv9RgW89ipdgrOOukddOabeuGdkzvz6AZwteXAnf/3wnLNLWdcbTBIQQk87k=
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Wed, 14 Jan 2026 18:21:58 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::b) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:21:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:21:55 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 04/34] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Wed, 14 Jan 2026 12:20:25 -0600
Message-ID: <20260114182055.46029-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ba3281-b6e3-4d64-5bf6-08de5399cd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|30052699003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TiFsr9eEdABZO4lOU2YVOzIRZXoVzdcRUMWiNUixGsdFPdXCb2JqSXr2MmB3?=
 =?us-ascii?Q?kznuZWMbM8R9b1zw8OJEfOAv21By+vYJX+MXNttERTPQA9vAzRrYirbNTfLJ?=
 =?us-ascii?Q?29NbRkrkaTmM/YbrFVQdiJTgXJwr4MbxGrERE6Lfu0VtaOer/YAU9cxzr8xj?=
 =?us-ascii?Q?yx+mV3FwCbv1sJS6ySNY9SUOUQgnWrRmU9jNpwQjaJS3qprP6k4ZvmvmH4TM?=
 =?us-ascii?Q?Lj32iDr8is3lMGNY/DFmM+mG2py4pnYWlvDu19n8hpxWBZF6SNrSv52zUiJh?=
 =?us-ascii?Q?0ttAmRJ4Y/HynOwPnd4K+AAYecdjyiIE9GBZeTIu0X30R7q+nleYDJETgjTf?=
 =?us-ascii?Q?XZG5TlIKk/6AQ/QnXDRtd1q1Cb+mG+Ya0cJcr4bH8H/v/fFF2LoELnGcAUMk?=
 =?us-ascii?Q?FFk/n5tWM33EmLR6yS3efkCU+MUlGTfakejhKY1QfMj/7Nc7LwmMNjYhEM8z?=
 =?us-ascii?Q?uLbRu+tWX+q4HyNdUfNF4myMPYSmNOTv+FY9sQVJT1nOK4vjKAHehtFeR5TP?=
 =?us-ascii?Q?nY7LWRFQG7XjPilbgwWghQaHv+iqrH8YOx4jri1+bOEL/vvfSkJ4mxd94T5+?=
 =?us-ascii?Q?pktFszIv2CM/873Ftzaz5F27Bdu7ezJ7wxF8gM7aFPsSOKUerT7/VfpOluPR?=
 =?us-ascii?Q?gmqVRSLl2KiWK5pB06uQzHyyACJe0VMap69qNOHncywdEBy+sv+kXoniMvIw?=
 =?us-ascii?Q?lgJlC4Y1Zh5sCi1h4gdjWuq+eQ8kX0nZe+kiuJ7rpG/VKC25wgN6dHsIhUV6?=
 =?us-ascii?Q?yYTSlKqoa2XvKbJ93L5rlR4nYU0vwhIl9KjaKB0655eh04Wb+VlrjeBXmOKz?=
 =?us-ascii?Q?JyYM+qiFTkvmM8U4cSgVygUCTTQof8eScsajMR3wP2+BvM9ntzWOR4FMkd1k?=
 =?us-ascii?Q?e1irTSjN9tdeQiDmMIoyUjj8y2ZmrTc1DJWEPUy/MWixHdhBr25NzX8dnGvp?=
 =?us-ascii?Q?Z0vjXqu9eu9SMfpsJ3MrTgTm5xIgR3yuHwP0JShQqTkEGpwtLTKuEKup6/JI?=
 =?us-ascii?Q?W3COAkvlCkuujSHKpCS5+eWd64rJQPzV/j0dmTLisrYO1wjtuoN95ZephVjf?=
 =?us-ascii?Q?wqwI06PpYZWTaMajv07UIckFU0RS6vrMZW5u0RfFvY4G/gG95sId5mnHMaT2?=
 =?us-ascii?Q?9Bo9tGzc/IVctnacW3Ms7f4HKaV7V8l3CJsIvhOXhQPi9RFztl0eNmjwOKaH?=
 =?us-ascii?Q?EWRps7wOCqRHNrY+qsqThUck3LITjtpkaZ61iYBwC9Tmmxw5qN0KU4HYLN/T?=
 =?us-ascii?Q?65B1ykzqo7mehyjDxxFcayDlaybr3LqafyzzMs6Jy9ahE1CwG+bX3x+F2xk0?=
 =?us-ascii?Q?Fq/QfUl3okqScE4MuMCX4jCZYaJIMty2WFCsu6WDeOJENlcHsWFlYMzh0JtB?=
 =?us-ascii?Q?ceMhXFt6nlrTrq9QmE2/NoorBSnwIZIyGU2+Uah4xDnTV1p6VgRE/7JzzIzA?=
 =?us-ascii?Q?j2sGyuEcJvmT4ZiKCYc/pUfeFvTdNo/1W4yXO2xpeOZm8iH62sNkw1/zSSbf?=
 =?us-ascii?Q?1UA4Ih/qR75SociaCwrDDfPtjCAvOXzeaG5gJXLtX3VOL/RhUGlqaSs9oAAR?=
 =?us-ascii?Q?60DVwiXtR2pCfJo2oiJ6h0OB+OwCi9PR6cUMpN6Qf3vihWfo1plxhv5GpupV?=
 =?us-ascii?Q?rzgsJOcqPwy1JjSlyhKgfxAGxWC9mnXg8NCP7gugPJWYRbF1yP57OoPePK2i?=
 =?us-ascii?Q?tnRUeKiFr5ZxIWPf8Q0wzSeRGpM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(30052699003)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:21:57.0713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ba3281-b6e3-4d64-5bf6-08de5399cd3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373

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
Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- None

Changes in v12->v13:
- None

Changes in v11->v12:
- Added Dave Jiang's review by
- Moved to front of series

Changes in v10->v11:
- None
---
 drivers/cxl/core/pci.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 077b386e0c8d..3ec7407f0c5d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -632,8 +632,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-				 void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+			       void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -649,11 +649,6 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
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
@@ -675,8 +670,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
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
@@ -709,11 +704,6 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
-}
-
 #ifdef CONFIG_PCIEAER_CXL
 
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -792,13 +782,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
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
@@ -895,7 +885,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -924,7 +914,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
 	}
 
 
-- 
2.34.1


