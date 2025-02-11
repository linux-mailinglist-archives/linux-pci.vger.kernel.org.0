Return-Path: <linux-pci+bounces-21200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF37A3155B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B943A868E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792792690D6;
	Tue, 11 Feb 2025 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c5+HBb+b"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872D2690D2;
	Tue, 11 Feb 2025 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301997; cv=fail; b=K+lGPuunCtt5Gu7tOVbkycaq5rlaqQEzUQ/Jc9xJ+TSf/Rz3m7BpvQoGzi46O34azRfQ/yozqLLUPM4wSbii+Z8nx9IXPl6iu0EwXvCqY/aOyqgC10573bFDJau4Q3IptzlUPkni/TJ6DtaY8U5qTQ292ahyHfk66EaOAybkRC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301997; c=relaxed/simple;
	bh=1EeTWPm89iSwq9deoCsTxEMQMukFKGkphz+7oful9W8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9xumNIu90v64soX1OrQu05N/u3OYDQCVKNTBe9Ir7jLDwOhI6OCXp+2C2nE4ZKw6Dj2AK6OIk9OY4p03Lj5kk3uUU3f7Qn2xCRXk5syA+ckUEnStriguURXso8+jFupx6tuP3d3wqTS+Tp5nbxgwbF/U2pJ6fP1wEsB8vE86og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c5+HBb+b; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnxrfWQFm4Bn+rlgILhvIwyopbJD9S4DVGCyB2ruBae8nc7yLwhOgoncSt7Tsi7VY1P4PzvEETtMyqokBTw8uHcW9btLWigBWiO4GGSsMOrxw19K0ZrLJ+4BobD2bQ/VdxS/+MJaPTfBpJKLIt3nliZZt605B45hoTz2drUewplyT7qQQt4qBmnghvxw+jvfSvSsV1Y6yV90sg5OJYADEeyEbFv46VlKGBGf9r9bRyxeMA/fwgzl5reSxUzDcTF89Ggd6ATVRnMdj6gAGhSkLj14W/bwhSXKlGZloBQkIvVf9xuX2cESLO9S6fGUTZoAFAFFXMuJprhuMbkyvHeByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACY8czk+80UewBEq2UAD1wUyH1WYWXX/l3Y7llPCsyM=;
 b=zG70fj4T1Xm7yjL1Kd1qxuGtR5dXsxzPGLWu9mxu4LHXd78Wz4+Ds2p4tfl9FTvyP52ony8Qi5gkwOQK3+xelgmavBPN43XBb7J9sOE8JljNynQz8ZNLWs8X7pbyd1SH/R/OKEowv1ia2u2le//2Org2nsVy1ZfBOFkbV/8ZFMugbpZwG8pARZfLlQKJQPSBYRZ6IIG6SCLnSX6QaHFgN47brz+xE0C6vBN3nXxC6G0J3nAkn9fkfR7jpiUCge3gEwmrO96keSBEtjzafGim1lLRK4kC4gNLx0df/gbkJlpsRQ7a1W1b15Bo5HYKgD/gRjO0K7+q0FS+eYePkcmLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACY8czk+80UewBEq2UAD1wUyH1WYWXX/l3Y7llPCsyM=;
 b=c5+HBb+bUte4RSHTQW6gyyoeQYeEzst/OqlwWvaCM77lK0jJ3PNJS5pIMah5mRsWbC5Xa+2+upOPyQzHSWydnLC65REdFYSLO1CBg4+nbNeeeNxCBTmaB6kuZj7p6uIBxCNXi4N9JdjqWhV+RmpVlJWNZNAh2gfbE0ANQZ35DbI=
Received: from BYAPR07CA0006.namprd07.prod.outlook.com (2603:10b6:a02:bc::19)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 19:26:31 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::dd) by BYAPR07CA0006.outlook.office365.com
 (2603:10b6:a02:bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:26:31 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:26:29 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v7 09/17] cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
Date: Tue, 11 Feb 2025 13:24:36 -0600
Message-ID: <20250211192444.2292833-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3728a5-9f94-4b5f-4ad0-08dd4ad1fd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S49vWbZkALx1zOk1cMwIzK7v91YguQJVjaTjo7HqRh1ZBkCp/VSqvp8mQl5f?=
 =?us-ascii?Q?PhZIp/9PUKZlCQFBtqkYP2Qvgc0r9S+/hXrvLYoApbWJU2ZlekBkktGjJWIo?=
 =?us-ascii?Q?7vg5/5H/bVU2eaYcEG9PWB+Xnc2T64gpcZPH2WKBIvqgviHUO/2PKStxYZnh?=
 =?us-ascii?Q?MInzY4W5GsaIKFdB6c5mWEkjOYcphktxboKgqRqW0Fg3S54HnxjYMB879ZqX?=
 =?us-ascii?Q?rW6NqYCQF2CA18LrHkwhaP/yMbVnHPoPKnVQSi8Ol4zof9S2dAFjlzwZp2Ym?=
 =?us-ascii?Q?liEly8R/VP2buFTExHFzJ26vjsTuLSyfVkBnrBGtnTYvQcY6IzXWO8j8s1C0?=
 =?us-ascii?Q?2IJdDreDlCCwg52e5Tajjs5MFMpScdCkEVmjbJrBZruscFgJtlMKHoheW4kW?=
 =?us-ascii?Q?CXsA9Qmrfc1chJSWJ7a8C1WJ89Ee4lZX9934kl/mhYLXD2ZeqpKCr8oW8zwO?=
 =?us-ascii?Q?f17y0Poaqb86WfJezGULTpUW2toAiExuua2AvrdE7yruLlCVRVy8s5L9oN4m?=
 =?us-ascii?Q?tK0EnqfsyjMIkPaVO/sc+IgFwK5JBoFsqnSdI2swggJwEVGKDIVa7CtnW6v+?=
 =?us-ascii?Q?xXDW+I4qOgOCz5fh0G+75Nc84vKurSDTPjeSjyLHaHA4mHaWjaAcuSQ8d6eE?=
 =?us-ascii?Q?qJL+N8rQ7NMoBiEKb+NLM6ibjrgXlltnvI2QeD8ImMBPYRx/8HH+hw/YUcnr?=
 =?us-ascii?Q?T8IvK4BAojBcKllI7V8R7IFfegOyrSuBMnzKDzFCa8BkUX8IZ+fZhA358d24?=
 =?us-ascii?Q?khNHv+9al3qkouT93FoangEZsFOrXd0Q+jgZE5XNuR0K7vySm8DnRpamsq4/?=
 =?us-ascii?Q?vppLlRFPbR13qyWvCRHIDYG6VjGg5akXIDAcvTktEXT6siSx3aAVOjStzTV5?=
 =?us-ascii?Q?TyNQy40U2K2lO3cGtuufxdtE0Iv2P7wFyPx4cgrlb1E9pq7Lyt8BgtO10ki+?=
 =?us-ascii?Q?AxYgVaD4moJiJ5qre6mfVtpKq+ZDcD8oNQVv5KdWcRaiH/xi1RCYuNtmlicD?=
 =?us-ascii?Q?L6xJN/9e+AmmYQe5qN4YbPaUHDq2xP3Q4emWfCmxITvy9B9lS/k4BoZTryAJ?=
 =?us-ascii?Q?ND9nN99fVcGH0aVwr6vwIV9xKBOC3f5w0it/4PkacI43LQE5H/fMWakg5tZK?=
 =?us-ascii?Q?GKaHYCoQFY2dlIuipWEqwcHyIrzOpWfmuIdtHxO5RRfYI/iA+FaepHu+3kIk?=
 =?us-ascii?Q?fK+CHhqQuKKxdsAhOzZ4V9PBIdOwlv9mer5Z5VQ8tWUIs+wC6sQr5bp4a4Xq?=
 =?us-ascii?Q?CmABHne8YhJOfT8kWBKA/xq85CVofW4/hiuyc76ZmFQ0T7X9mZT6+YS/pT/h?=
 =?us-ascii?Q?HVrXbKUd/za0mhAjsp3MhaWcU5KPaT2J4MVwPsMlQ3Ypg0kR8qIMKdwGA4uo?=
 =?us-ascii?Q?Q/MPKE35FYMTfkRdIP6lxO7cJfaHXkNLq5zVL1uG4qi4zJJ2ql984JJWhf6I?=
 =?us-ascii?Q?8sjI9ifqYQVgm2aLq8I2iXmSceIensATeeBBdtEDGmUzRrV86re23Ljcpgfz?=
 =?us-ascii?Q?nIfDswkP6rpz2FUYYs0/MrHVjkohHlDLEEGK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:26:31.1861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3728a5-9f94-4b5f-4ad0-08dd4ad1fd38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

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
---
 drivers/cxl/core/pci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 25513b9a8aff..69bb030aa8e1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -652,7 +652,7 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -665,13 +665,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -695,8 +695,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -723,7 +722,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -731,7 +730,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -825,13 +824,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 /*
-- 
2.34.1


