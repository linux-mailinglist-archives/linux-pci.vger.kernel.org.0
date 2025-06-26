Return-Path: <linux-pci+bounces-30858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBBAEA9E8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06D21C45CD6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938AA221DB9;
	Thu, 26 Jun 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oymN5zoI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5B2701B1;
	Thu, 26 Jun 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977900; cv=fail; b=rKV63pCueEnLFn7CJhmM56v5PwiBQ3NijJL1b13GZd2GEs0VelddyD9ev70Zl3SKMAc4cJX2ZfI2AQLYno2o1dYIV7+3CtNC+2zkVaHSRlVDSLgjHZtFpe8TO6vaaT1jVub4LauV10fD2xIeeG8zs5tWRf1J5Eu5UkyP4Qfar7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977900; c=relaxed/simple;
	bh=/2Xjpcj5tU5RRtjwdI3B0GaPDLqoCBZdwsWJtP/eAls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4ImEhvcuYLdjxqx8iypeQyd2qNe6B9qvXVwDGA1bX0Vef2t62PTB2a9+/xKdAJ+ZjyMsbMXPSkJ4Lckyk3drPAJo3urprVzuMmTM3+dwVnp9OMJGR+OY3Zpny+3R2NeiySalDYZKsQ/rYaU1QQGBFUhCNcV27Pk+CkjtmBhT8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oymN5zoI; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScuUwRNKX2amDeet2+gNGmmLXRsxDEZYMZQv9GpjmH8Wh6N5fRNLQ19GC9owmjdsATfL6nyEQ/sg31WjA8jTNUQ//c9L0cBnolnL8IqMfJ0dGoB31D4Ip8e/6PYMJJgPsLjuNjdxVldeO49AZrs+I2BEh1jrBFvhjVGLSSWAAaVwqRVX8u9yWk+s9yxwAeZ0S2wkoU0fGx/YjifpbWr4UXYoh9mr8uvZIzT6Bz1lOHD0zk5tqkUPKQD0fkSw/+h86RrFWFJIQOsnYvaKvyzvh9UeNia11J8vFEhokF8B/9gCpg0aq6gkcYcD4Yc0A3LeYKKi9hk4B+9wCTrx0xgl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r432+MrsScy1caMOBKy75oNCacrtmQ54KmZl3qaaVVM=;
 b=jalxxZN8K/PogOcv0teZMZfINyuJ0kXeQI7Ytf6xApLKMrAK55FfWWE6J7Co2ZBaEeLeMZRLSA089yoF6K0NkB8v01LYHvl0vpSPRhFr2Y0YI70/jIagZbV7hpsEmllkcLuDvQ/Ob26YRNi1MSpLcIrwD15ajwORg9FuqTxNuVgogusZX9jeTRAl8mT1RwInQJipif+YYaaZY4OmMNud5913+Knjm+3EDSHa91BlGFFL+zGBT3iHleIJkif3j5cGobNElFE2iUd8ZMUNbF0Zy6WuivBA8b3qVlGzU4nUeZKkWmeXbEaC1CJsp4zir37oO1c6tnliwNReVHMBIS5Jfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r432+MrsScy1caMOBKy75oNCacrtmQ54KmZl3qaaVVM=;
 b=oymN5zoIFAD7h+AXHROZpuUm7eagLw4d0sTCu+xgJwu2/vJ3Fc2GScjyiPESyOtfdqM0entI4SYoZVV702WO2pVN27VJB4vd2FJKT1WrJzRV/rtm9e6kBQtw3ZI7caD6KfN1GLXWVHN1Rd7glrJB/02yZsekhS1RJQRjZS4BrXM=
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 22:44:50 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::fe) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 22:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:44:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:44:49 -0500
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
Subject: [PATCH v10 10/17] cxl/pci: Update RAS handler interfaces to also support CXL Ports
Date: Thu, 26 Jun 2025 17:42:45 -0500
Message-ID: <20250626224252.1415009-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: acfcac6e-4ee6-4d84-96e9-08ddb5030f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VmuuS7Wwav2xQzW7W8oSTSfhXihMqi3ZAaGfGT42dPPzOBGdDN63UbzMQH2a?=
 =?us-ascii?Q?Bikp9x8Hyfru4Jbm/iAO4cJquO8j2XWzvwIok5bBI9hYYZau2fym4Y98Si5i?=
 =?us-ascii?Q?vF4Npg8/rcfNDRydEnUfgMyPzvt8/M+3Bd/EXflJEm7cDfdBzV8SEy7cZR3Z?=
 =?us-ascii?Q?6Nc+av++5IosSnrBRmsFcQ46KrAB5oSwhSWcNL0BCwjd2M+MODagTzFYhDZo?=
 =?us-ascii?Q?aY9vMFG7M7Y/RvkLIo35dUMpW8ss5XgVpl0dsNfeJksipAq30dE2lRh05FYS?=
 =?us-ascii?Q?ZyRoryco6pWRpzxjEDtN+qYufIERZRYQy3oXV6EhHsraeAugZiPZ2Ei6m49+?=
 =?us-ascii?Q?cMw2aEo0q7Gj4EpFv4W1ph9yoBFFsquso+VSrZk+jLFsYBk07lvrBF17+TKh?=
 =?us-ascii?Q?jHLiaC63C0+uwUDol7aA5Deaw1wuTW3U/SWwDuK+WnV1c9j3mxWjxd+gmwfA?=
 =?us-ascii?Q?BrM81xNLHOs3nMtlwL/R6OO6obEvnGzY9a3Gx/r0g3+RG8AIzopLvZKuDMFt?=
 =?us-ascii?Q?3yPAK6xeMGmQFsJiRs57D2FSz0DLXLL1wAvzqbWf/BAPsTlCCtP2Z9Ai8ZZ8?=
 =?us-ascii?Q?vAWsTaxm49zlXIXPuSj3oDfjD6ihAVt9qPoH1P0kvN7SqjpAH44XxLo6t4TE?=
 =?us-ascii?Q?fwWELVPYkgg9lughEF27yKG0/NfrgcazAf0Mz4Q94r2sOPCu6Yi8oTi6c1iG?=
 =?us-ascii?Q?jZTmpakaABi7rg8Fz9DvQfSarrqaQk6e/bNpWhbJdgeXKmCaYfg87ipKQ/qx?=
 =?us-ascii?Q?1hGe6ApYEir/tHRujcKPn5tuB0v5i13/MZ4iZYi+5JnnCHDvsE9IjYwE3GqD?=
 =?us-ascii?Q?lqvfHAuLsj25SCOWB++AW0Fr4qjVKF+AUsBPS2msljP97FU9yidhFvDivdeM?=
 =?us-ascii?Q?2dl/5HdsqAy9Ey/tu9sryA9EqHLXVqQ4AzsLD21YRGm7Ukc51ZVK38mABZAd?=
 =?us-ascii?Q?X1kIuVlvsSIYgQIxM0sKPRIMEGHVayyrtA35V6mAvgy4xd3V+HD1jxqT4VDQ?=
 =?us-ascii?Q?B+gUhKON4KVV82jZDZ8CiED/78suhvpv5F22r+vrmLC3KBNxQTfkoTjdsj7i?=
 =?us-ascii?Q?mZGmgCs4wAvmU+q+54QCjFIwN/+hvhkzt1f/cygWcSEzfv5BseFot5ICsvxM?=
 =?us-ascii?Q?i7N1GwJTOHNCRiuj4C9UK/VO3yDJ59qjXezyKZ5rAAHyIG7W70SYh6F18fV4?=
 =?us-ascii?Q?plqzQYk8nYJCQTr1vzxrWGURljmKFSGqhmkwe0uzejdlwrbToqCfSTkaKCty?=
 =?us-ascii?Q?CTOZ8hmZQ6B2maHqUWClki+mh/8L9bmag0iwS25UPPIVi8NNwCgqjZbN8UQy?=
 =?us-ascii?Q?gmzXHlkxnXDBvtB5Hfvd27s+mDjkO6LicwGh2KsST3tph2ofDkATcx+aR2A6?=
 =?us-ascii?Q?Yr0178jdmhnw1LuEJ+Mxr1jjW6iAJW7/YnnK9UTrFHI+YEiGsSlpurE7c+r0?=
 =?us-ascii?Q?6CbaZF9/Di4Vc6oZ7OIQBVSMOKDSmFRdXXq71uI15vibzWrhTEXyWO2D0w9d?=
 =?us-ascii?Q?CniF4Au3J5MaIn/LbiVXwQmuOWJanA1QknwrV1PbiwVuJrjL86rgcKT6Nw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:44:50.2873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acfcac6e-4ee6-4d84-96e9-08ddb5030f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

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
 drivers/cxl/core/pci.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 35c9c50534bf..9b464f9c55c1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -664,8 +664,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-			       void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct device *dev,
+				 void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -677,7 +677,7 @@ static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
@@ -702,8 +702,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
-			   void __iomem *ras_base)
+static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -730,7 +729,7 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -741,13 +740,13 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return cxl_handle_ras(cxlds, dport->regs.ras);
+	return cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 /*
@@ -844,7 +843,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -873,7 +872,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 
 
-- 
2.34.1


