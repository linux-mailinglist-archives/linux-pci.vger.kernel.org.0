Return-Path: <linux-pci+bounces-24809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBF1A7287D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932E03AF68D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6251145FE8;
	Thu, 27 Mar 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RfKjA0gz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3D1474B8;
	Thu, 27 Mar 2025 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040155; cv=fail; b=UPBflMuPLZjdVfeLqp/etncpV6xhZuPdShoSGAVQ2lpwTlBJedwvGRB3ZHrIQofWGCa8xiehM6+Jt5YsoT/K4NxM1+naTJYP3j//UzBBGjElbJ5zJu4VgyiTqFIbTclo5bUKCKXlxUzmZVtGNkTRCiZVe7HuwPbtk0LEVbJuw6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040155; c=relaxed/simple;
	bh=EOao7UuycJIjU4sQciwSEqKuY4hiujkyspG182Raixs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdCPlIYHc3tov/rF6CNyM0vx5WvNYsKVyOpZQxapFSyH18MIyquBL4nmGynt+4sWngfcsrDfBTrZ6Q0XK8ZEu7xa66PdXf9K7SyonR85OEqILeN0A5Vr+LLT3sNFA19g8e5lAaJ5q0s7E68TqDgbxAtG4oWORDUX7quWOnnuSD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RfKjA0gz; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMB+ZRZjxy3ziDrCWCDodMT+gILW9QgSWGl01MNDbfyfbS8eeY0pebwxu+gmmTKOWxJaJanJ/NbG6/xmUVGUWW87OLT0tFobeA04pp2/eEd8OZwcpP9VTd5GXFxuXsTbFFDYIH3PXHcKfzZTk4Pz88H36oaSYCWKcjwQDn0TN3mD1wwLJVs8htImWMXZf5ZWLxMg8PEVxEjDsQN9z/aPlpjVZ2SpOyvkKW2Zt/t+bDNiP5sY3i0F8uc4qLduM3tc3WJscC/1yw0cLvVU1GKtRDW7CFpFiIc4TRLI4KDWvo99q9Tp0XzJbAAjER5C8HcgKSHkEyqLljhs9qNbJNhkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr9RGJcGudcjfMDMdf5UoKSOS7NvOBm3XEo9KYK6trs=;
 b=Z3CcVzg22biiOAiI7w8X8FKNunbe3cR43sely7hhffpuMnTqJU66ZYXwvAH3Hx40JwNtFIlczTkKLZIxs8xthRIWh7oW3fAIus1l6HG0JYW7OiLOHaC1K1el2y31PPwUCZaWUpi27tO/whtEfHxdfTwrEbBBljK1yk/vSzSsbDBLcGgiLWNenI9PcI024Dw5unff2i9Dk/79C5hTs6cbg7ZuwFd4ECv5FFvwwwFRTb7EomskeQjQ2CstC8a7thUvEJx5tR6C2yDgOU2Z650+V/pmDdopHEc5lu9qRZBUoVY1JQ5ClmVzbM1HE7D+/ZbkYsFn+SJw73M+9S90Ihkr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr9RGJcGudcjfMDMdf5UoKSOS7NvOBm3XEo9KYK6trs=;
 b=RfKjA0gzKVSm4fsQQpeYZlmAz0ZL28ecAlGJmMdINfbllvZIGWDkHIiKJj4EbZyvE3qnplLghTRAgYL8cRzyatm/57ukJCf4sfrtG3r7hSB4Zm+Nc569djlqPWgJ3LzaDTHMiUGq2t06Z5nAZ5L1nqWcGZKFYeBeLp/IE7hXgFY=
Received: from BN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:ee::9)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:49:09 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::cb) by BN0PR04CA0004.outlook.office365.com
 (2603:10b6:408:ee::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 01:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:49:08 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:49:06 -0500
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
Subject: [PATCH v8 09/16] cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
Date: Wed, 26 Mar 2025 20:47:10 -0500
Message-ID: <20250327014717.2988633-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 340b9a15-94ad-4714-a16e-08dd6cd190ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?op2wFLx+ydZlhL1kRHOPekKkwTC80UP1bIxKcB9V7bIiCs81NCzfzkDnx7BW?=
 =?us-ascii?Q?a60bO8QDR3y340Sm9O0a3sdQxwB+mH14r7Fe6inzSC2rN6LQfFZVBFcNVRz7?=
 =?us-ascii?Q?YKtK3JGwoPnJdYX8k34Og0iLTsG6iXE3aztG6Db63yCYfxvA75v5U1v8TC3o?=
 =?us-ascii?Q?yxjIvUfbx3a51uBr13S8B7tUq/YyP/6aRISIFya+pX7F9PLHzrbbP6vKahkV?=
 =?us-ascii?Q?JkZaGevfQ5fiQ+ajeKQB8d9F7QH7L3wi/XcwZ1uZtfWRSNIjdZ4wTXWDF5To?=
 =?us-ascii?Q?h8FJ1UgnfqM3lU/zGLO92r3ByWtd+edWvWg5shapLvU/VwuMD6aZxPg7jpkz?=
 =?us-ascii?Q?+clyUbuaU0/NTvEZUfrV1A37AAUov5jaibHlokZxJ39mZ4DjRPaFwnVaI/l8?=
 =?us-ascii?Q?y2JOaDrmY5jV6VuENVDW5RKDXN8Yz69RTn1f9CQbFHoxp1kolCfTXNNdW/FB?=
 =?us-ascii?Q?l40Kd2lmrDBb1rB2Nii9n+2Z1p/ReTdrZSbXiIJOkPbdt3XTK4pvcsiu9WIC?=
 =?us-ascii?Q?jIEnBVjBrZAIE4jcLmdnMkmdnmLwkBtshwFUY0hvxUubzda9oPFO0X7cjhcd?=
 =?us-ascii?Q?xrtv1Q+QN/5zi1nb49GQMJvu84Ce6ktlRNFYR0ne6sgOasXSHvzkGhWe4Kqa?=
 =?us-ascii?Q?MHnvzU2C4zc4BY6PwwDyFD3bt/XFKluytZ8KAlaciyLF1hWd1+AWmYq2/9Mj?=
 =?us-ascii?Q?S6Ei6z5QI2AOlVQcpq7Ifc5ChcSbfFdlSSPgH33FVgjpkj9EL9WxLbmV3oB0?=
 =?us-ascii?Q?j24qIGpy5fMaUjoGCmVRrsenpo+9oDXVL11f6Jf2LAoJ/ITz/6f6wtjXsrxs?=
 =?us-ascii?Q?UGuprdC+lzIxPYh4nRqG6Dbp0Cm30GwXAYyksQHvcm6NXXKL563p5GK/Ztwp?=
 =?us-ascii?Q?hxVQfJrQb98z6gbW3heDRvnG9OUemdO4P4qKP6tc/PqALQ+QGcRWhpA7T7/B?=
 =?us-ascii?Q?40NLucjdUOPfWmuR2e12fNLkQoE5lvBV0alhAe3jIYKlG2EVSHiGn/73mawy?=
 =?us-ascii?Q?bgN0vwUzZj0w2OxbqKSpidhlkRJTPwryxAxMWgI8rHrEEAi4IVmHN0hoEIW7?=
 =?us-ascii?Q?dCknHPLHbdPYPlKzqrL/s9GlN87GjCInPtLye4BEqLSgNqcguJeuG4hF4Gn2?=
 =?us-ascii?Q?ZzOJwSRDcT3zY7GMek+05vU4nAwYEnL63kGLpCCmLKoXQ/ZpGh6JceH05POT?=
 =?us-ascii?Q?I4dnB7TLiTLuDDv6/TflhGnle+3cNoVLa3jgwsnF7N22wb+pKPrv2SzSuC/q?=
 =?us-ascii?Q?Obq5KSfKrxQMq02oSNh+yfNwzZJushL7KH41RsCkfx7m9EiJ/qdrajtpV0ZH?=
 =?us-ascii?Q?7OBImQu3sSaIbCTGtGnK3lcczuq41GhA/GTGKTp1Ly3PkxrzZ8mRPwe8Eh5C?=
 =?us-ascii?Q?Kn7gGwrZfBWyWVcq5qI/LngFoOOgWVQDxRcSKMcxplCKfUoUKtBMIJKHh0kF?=
 =?us-ascii?Q?37GYAYbaYpmStdvzQKB4NWuwce7feoBsZCJhH/KYRaDmzE+eK93eTJAXkuvr?=
 =?us-ascii?Q?5VS48vxdgg+804oGR/Mvg86ZvR1pftff4EKE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:49:08.7207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340b9a15-94ad-4714-a16e-08dd6cd190ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611

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
---
 drivers/cxl/core/pci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 27ef3d55a6f1..1cf1ab4d9160 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,7 +650,7 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -663,13 +663,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
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
@@ -693,8 +693,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -721,7 +720,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -729,7 +728,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -737,13 +736,13 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
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


