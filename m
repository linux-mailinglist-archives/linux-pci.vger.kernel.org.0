Return-Path: <linux-pci+bounces-37045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F4ABA1D3F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8895655FD
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC75277011;
	Thu, 25 Sep 2025 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YgsD9nOa"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B0322A19;
	Thu, 25 Sep 2025 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839818; cv=fail; b=i0yWGX3cDuYHvzldj26lOBF7whaOfnQ8QfhPo7JH7Zk5ST8vlZpYr6qWyMYXm14ZXsXzl/teTx4BwFvNLKmDqSjFGvI70V6yfRCEmwaFeVHF1nWI6OWiM/JAholO20RINmsrx3RjpUBGRX8ZqPOShEB5V44IIWvt4IQaM11klRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839818; c=relaxed/simple;
	bh=DPLZ4+ghJDoC1a4jMK99NeNMM4y8v2MWO5dAMLhOaqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgf+Ld2RaNXVzcLWRjaK5LAJhbxdqVhHvHKOsdowJJ1CqedQmYp3pHlJgN7gWtDQci82FQcRi6wzk5C0MhxjevtVGqXVWC+zHYx2ENRStAhqg98pWV83PPHo08B9Ftv3KxTRhRP/kC63ievL7ZQ8BlmYhqDdqACQSUaBqZ4QrOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YgsD9nOa; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPZQUcm7slRniS17wBNyjYljZVRfkINK2bEbBxUOLSfAYzaP12a4kTFOS/LO6GO4HQVTjDpMyzvnjHu0K6dx4DEJsrMnjUd11CLiuBMZohFDxUWjqDw6DWayBoSL8LQbUUfcV8e6NMVZ/X+vGtnp5+3TeSt/dCntO8maqwfE7KrWoqAfaXK27nFlr05FFX6FAwmYdZidimfNHwxfcAy3QmBZh6rFJ5fv5qJZRq/q2a+glEVbUtojv3TB3cyFCuquUu2+zB+kMefSYQpcyt7IBpwOWL6DiQI78fJuckyTeo1SeJSnKmdFplYdb2vca+G+ItQh1qVeeTzkRAlxp6+Uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0RngLmWd92ldiuwm15YxDBgIib2XGAI2YNywPTDaJ0=;
 b=QTfiH/t5wTr3yrTWUzA2nSQZ+uCtzn0fQsqOF98wSzoRsxY1TUx8QCA4KHQMj7bUTUCOdMNadEQy9Rjj+oVDZPSfP3DCKH2EpO4WksDTvOrI1Wa4ReLsnIEi4s0IPUKqTy8ySlZHihWcLYoDf4xrRGpmzqZP8coOT/+XI1JsLJ+qYAg/3qK30/nnP0O96je4Jm17Z+satotHFKD6o9yDGuhmKd9MEQPmwGy/UU/7/Z9zl6VBlb/D5aFGf8dWSSRjjGwbJ8DzNZOltkiWplDbe28rJnwZ8y0HwwX6HXPt5CGRtAdiqyo/hDKvFkmDingWlUbqMmCpjMtlLZVvEho07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0RngLmWd92ldiuwm15YxDBgIib2XGAI2YNywPTDaJ0=;
 b=YgsD9nOacBL2uRcYGCfS/F0ZkUkmPQFfJNGrLzbi6i4M+Bm1W2pSR5s3PBpbRDv2OTYWDwLnJTx5Qp2IVaziZpIR/nEApF2EErz1Y3uSF4rIAQYhFj5sZcyGSfYtYfbbT/j4jGEM/gDmXf4iCYuM4cSPBXTMGI+IArOE2vb/KZE=
Received: from BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:36:50 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::ff) by BY3PR10CA0028.outlook.office365.com
 (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 22:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:36:49 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:36:48 -0700
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
Subject: [PATCH v12 11/25] cxl/pci: Update RAS handler interfaces to also support CXL Ports
Date: Thu, 25 Sep 2025 17:34:26 -0500
Message-ID: <20250925223440.3539069-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3c071a-b6ac-4a73-03c5-08ddfc84049b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|30052699003|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4ZAs0zMAqM8YOhT1eO/al7+BSf7TbNFsObwPUP3pJTIn3jiOipZKMT/kuiv?=
 =?us-ascii?Q?ohXXiIfcwRqRvYGoFjag4KlmsMhv0T6HGbpDry8rPM38TZXUNzcgs8wIASIk?=
 =?us-ascii?Q?0UAUzYJrxcLuF6FeGbYQPWbY5uUAKrwXr6UWreVeCXHaear/garafNcr9PT2?=
 =?us-ascii?Q?GYkQE1GZ+BD052+Q4jrYPps/FPfXefV2feoaLC1rwJa+giq9ulh5UnvCIxop?=
 =?us-ascii?Q?f00kGNysHBOEKaCY88oYEky7uMzwMRZlP1KJdJyBLKo5ViV3wnS9+1TrtnfA?=
 =?us-ascii?Q?avdj+PCXd1Csv1eIwnG/niuDGce7GRF9vJ9A2BKYI+7axxk0zfXFb5Tb0tYE?=
 =?us-ascii?Q?pI5VSBmm3QUKV1vB6Or9CwrTJcfIBronfiQMx80t+W3rS7JIhsg61RW+xXXH?=
 =?us-ascii?Q?v2dT44SY2F/LK5g82QJ2O6LNaDTAoycWysfKVHQwMfWUB3yMReosUG8XIZAa?=
 =?us-ascii?Q?hcnIItIBvzYB/LVA0IycSGsjtg9FzpASVtbylaLWdvT1zsgM3/muDUyCihhl?=
 =?us-ascii?Q?2rgMZhhW+unsg/ymxrrDPd+aFKsfpTBNLyPadVwdCA+s/urA9oCRb1PxX8UV?=
 =?us-ascii?Q?riA1x7T64yg/sEz5wX7ZRjMgFhnr0I9o4qKluOpae56Cq92QKVWTflxgLGn0?=
 =?us-ascii?Q?bA98CtYdnoSPL5rXY7G5U1HPdKPOjlmRdqbYn026d/oTVpAYA6yW77lEPZ+M?=
 =?us-ascii?Q?PIfUwrB2EZujiTFXVD42kVbxz4qsAdpTa+C4IQ9rGQqWeEU/3HPoKRVVp2LD?=
 =?us-ascii?Q?80DRcPMzGmTxz6Nf0XHZVLvSbj2kXkfxlcMqlxjdvEz4W5RAMfiXQWsW/HLD?=
 =?us-ascii?Q?bQnzmnpZwMUpgjSNNTdyTCKGW0YkDfxoopAhjjJtn023Ca8y1A/PMDYvDG3R?=
 =?us-ascii?Q?YRNpRzK/MROBTKYAtFsZFOvwYv30CRdb6tKU0mPMetp5ZRzo8YKl7HMcMKml?=
 =?us-ascii?Q?3JQP6rIrGyMvey81H6OXUPd2eud/3EIwEnmvhqRL5kObMOs1iXcpuO1lGsQc?=
 =?us-ascii?Q?p21+8r9rXL7DRaOuBpqeUDack2rtWFnOS4IZMnx1TonhpTo7mlgJU3dhI2pX?=
 =?us-ascii?Q?zyQKZYFaYyQxkjChj6xeFeW5vpnCNHlJtgWkS/tWb6p7A0S/FLGGDPs+h8lA?=
 =?us-ascii?Q?mM9OZRucqPmNik0beXjq4Kylt8+v0B1Fs0po66YE7lh+4kAuarx3h2cwI243?=
 =?us-ascii?Q?ZuraB+V53IBz9Byja1/vSCG/hHGihhtNnCTKcK4WhFPwRJmkTbR9yNz55l22?=
 =?us-ascii?Q?v3Q9Q3v+K+nRyqLxQPKboHxUCU/wu3HF7mf3K1KMTExIGepYnuYj94qybpvb?=
 =?us-ascii?Q?aykKZzvThDEwJuG4qwGkP0IODbYMw36MfymlsEVJlWrhXAFxnunPcZl8iqvY?=
 =?us-ascii?Q?nNZ2+oGOdD4Ykv387jZMqWjWhhlzYiwtf2Ocsxgto0RDZcJm5RvegtGSq19a?=
 =?us-ascii?Q?nvwXt20nErX/ADVjJwtznQR36oKUdSYzDZxf7G9MQTyyxQMRyPa7CERtw5zf?=
 =?us-ascii?Q?V1ZSrPbQZ5vWZPtQjbI+kfkj2ehbZuzwgaTCjpkeNSvKMDYsMlPApeOfbw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(30052699003)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:36:49.8271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3c071a-b6ac-4a73-03c5-08ddfc84049b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

CXL PCIe Port Protocol Error handling support will be added to the
CXL drivers in the future. In preparation, rename the existing
interfaces to support handling all CXL PCIe Port Protocol Errors.

The driver's RAS support functions currently rely on a 'struct
cxl_dev_state' type parameter, which is not available for CXL Port
devices. However, since the same CXL RAS capability structure is
needed across most CXL components and devices, a common handling
approach should be adopted.

To accommodate this, update the __cxl_handle_cor_ras() and
__cxl_handle_ras() functions to use a `struct device` instead of
`struct cxl_dev_state`.

No functional changes are introduced.

[1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---

Changes in v11->v12:
- None

Changes in v10->v11:
- None
---
 drivers/cxl/core/ras.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 1ec4ea8c56f1..152550bd3547 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -126,8 +126,8 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
-static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
-static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
+static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
 
 #ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -237,9 +237,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 #else
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
@@ -281,7 +281,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -293,7 +293,7 @@ static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_ba
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
@@ -318,7 +318,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -345,7 +345,7 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -367,7 +367,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -396,7 +396,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 
 
-- 
2.34.1


