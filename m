Return-Path: <linux-pci+bounces-14016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA039959FB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6A61F216A6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35A7215F41;
	Tue,  8 Oct 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l4SH0v4M"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3218C34D;
	Tue,  8 Oct 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425952; cv=fail; b=flm8D5hfFJ8Mkoho//5+h7Iu30WxYUWZMVs+/hajglbCbsJ1JoRTBPFYhNkceDizT1boJyCqYln0s2qqLEihOABeIwltZL79jhMeaG2XpPsBeESuczHG3bl5RhRcK0EkOySRVhTOFtWIm0LTWqzfhvtS4LoJYQvekUK/fcJHNdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425952; c=relaxed/simple;
	bh=x+j0Tkc+Y9G58y00iX85dCYxisy/ach7mi79EWt181w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUvLwBxECzYHh8vhU2CBU68hi1XerOzvqqB0gX0Vsg8sW3xHsR4K/huaciFTC6+Bi0jIybq78nHmE1Rterr4sD2kZvAPKM2C7UVC48qQhJyGeNyxwrIz5yBpUq5a2eOIejghQ+17yuYzjUbkdKc26w9GALPR2/j8zVZ7ksRNHZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l4SH0v4M; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY4Yo9rzAFc4cAq2o4VKMs4sOQ/hZiyEVY0qSbChirYQQUAz8zWreAYisacagcJKse3hnNJp1/zeN0BUOiU1dlIc1Hzc5Ufgcsh/p3XQPrD2bMgqMcEYSrb8mSwUA0jvBHLzLq1WEWbUto/pjkKArwy9pVoHKH8sgXuvaT8LzNkdu0OAOkQQLe45ZjVvVlN66oQSCGIBZFcZA7QpnDx+BSxQAJN+3P8Hr8G9rFOlv2QhtnzfUOUqGUgnFiDmAjZNX9JVDb5SLd4ylrOfMzyjpURVkuMO4c+7cNIYzIjvE8vEoqq+XSfiFKondDBn/R31qgDV+ye0SqwPZpjJ6RtcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGAOPC69NGgnNbFIIELRp/hMlB8yj3IgPCUzsuTIMnE=;
 b=XxOjj5TFnNbnjxgkKisAa/BSG5b/Y1qdJMzjevIkUvgkKJT4vh5bDu0rQ3+MVpX4Kyp/0lz19RSFzzRVvBZUqDGDYeTxi8Snzi+7Lxh7njso558y/URdLRIScsut6tGa/qU2zJgVldFs43/Iz+XlSo3aBH7ZvU+B6LW+cab81UMeH0gHBhA92lDCz5tKQ6+LrEZoY8kUYmi7JpEN/p8ZQlVNNU5XOGKIKakal+nQsfIum9cQOYeeb/DMfmH5C1CtxPNVKK7qWyH4evzzXUD8nFuk8449dgtwDMrKTZ6ffIKAOaX/7t6+4E3m/HqEm+qN/9H8LSUPXqic9t1YiiB64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGAOPC69NGgnNbFIIELRp/hMlB8yj3IgPCUzsuTIMnE=;
 b=l4SH0v4MCSRG3bVjVe057p/NZ/QHScfDyZyhIVs7ePchXC3BtoqU1y3EExX4N942GHSVpBA+0lU5dutVv5hDW9pAks38J1Rz7DD7Keo18gVmW5GDCkd1VDIbkRCaJkSbRr53tpUs9KqMlt3EP31GVVxX9bCNWzSSzLM7YUAAMVc=
Received: from BN8PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:70::26)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 22:19:06 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:70:cafe::94) by BN8PR04CA0013.outlook.office365.com
 (2603:10b6:408:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:19:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:19:05 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 11/15] cxl/pci: Update RAS handler interfaces to support CXL PCIe ports
Date: Tue, 8 Oct 2024 17:16:53 -0500
Message-ID: <20241008221657.1130181-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: e635509d-a781-405c-b0ca-08dce7e73933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gmtzKOkiyuDktIdt054PnfpaIiIi2zSky2X5tHqIAzdTr2wXfMH09ivSY952?=
 =?us-ascii?Q?kytKA9IgcPwn1TX4+47eGGaI23ZEHWLnbmXprsb3cYtc9Zh4eEIrCcUy+D/b?=
 =?us-ascii?Q?XL+YWpJjOAdduLn38zPC4g11cUplyzH8FcH25nqH6/hrUII5iTldRMO0ItIn?=
 =?us-ascii?Q?XXr8nBkEGKV5urbkiMoPcesyhbhcJUEP+O09t9of42JJS8EEXNlMxkfUEH43?=
 =?us-ascii?Q?fx8607lsMqkGhtB6QtHqPG17DEZ+6kFU18Nj5FwW/a6aJyAmAqHNxkTV6Jji?=
 =?us-ascii?Q?Uf4jCXDyQwTu6dFvkhly7iXbjHT/wfkjyNe89TTKyBrEsYXeR6EPOSivKEDl?=
 =?us-ascii?Q?oisY350uQ8RqAgr2DFJOW6HT4DHhjM+A0MjK4og2Idjm8f9g46Aywjkcf+2P?=
 =?us-ascii?Q?e4/uKub8xleGEegsVEs0dtA7azGgkUcbKwuTiM0dMdMvx4ZI4szDn+RDraJg?=
 =?us-ascii?Q?z/MtN8GxIWFlqIL3TseiX05DrgYf+/nnUCydci9JFj2PcXv3kJVEfzW+eWhr?=
 =?us-ascii?Q?HLRm2oIH9a5Yhj4+yn7PXr/bI4WLlwfqdfwkKK0PCb8EqgY0LNotV8d4gytK?=
 =?us-ascii?Q?WKPNKZHrGQT0XXbi6ZTvAwFW4GSmkbNwGxzhkHitrKneoYWZcUtQMOV2pLpI?=
 =?us-ascii?Q?9yrbJ686JlRDBbGD2NzjVQrmzuY3FRXfMffc61MJhA0qK1V14/VndJsY2sig?=
 =?us-ascii?Q?r5OX0aR0nO/TzzW0UpJ1pQ/IRWHEv+V1oYkc78HVzsaOOXZ55K9ShRrTy5L4?=
 =?us-ascii?Q?V0Gov5p6jx6iVrhnxe232fpYUc0yWD2hgBBjBxgsptNUauNkblbTvOlYKHfn?=
 =?us-ascii?Q?QNcH+gylxB25wld+pJ6v6Z57MZUTsEjnpaUMeW1VESFZN7h9hguf1n5UpPnL?=
 =?us-ascii?Q?GZZ1afgLS614KAgEUQHngH5Ci5dn465R9CrWmnqD73Sd2osg+0aGmFc9EP4C?=
 =?us-ascii?Q?GM4AO4SZ/k4bNuoDHx+cE33UkrpqRW83PqrmqjyhrXLo/0Q4X2wDXHmwjhaL?=
 =?us-ascii?Q?7yWIovlH3XezkyTtN8fhFya3s+VDgmM1HMCmHsVwyZ8GG963zpARTqPJwc7A?=
 =?us-ascii?Q?Re9BpnzietXdHcLWOToeOqvtgygehZeaJiluLIrQGCJVeRSxki+iqk210oRY?=
 =?us-ascii?Q?lrrJyaE1LPeLc6B275vifX4Y+eQZfkYvfCYSI1ziUIgYD6/P5VmfWVEOpn/+?=
 =?us-ascii?Q?eZlsh3ZVWv0Sfr3C04TvXLiMcfdzW92RlzKTwEZgWzqzSCE9pHhrmSBObSfM?=
 =?us-ascii?Q?Qbyf+BRgA7avgBqCoLMIYTUd148zTW7S5tn3Bj1k9JM9CmRviPj/VstVjeB5?=
 =?us-ascii?Q?U62WwEUavV7aWOLV12/7xRzhZ2mXlCRgA0LTWfQksSXND8S+pXLgLaEYmrZA?=
 =?us-ascii?Q?01Ob8bwcfbCo9a2/V3w0YzQ1z0FT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:19:06.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e635509d-a781-405c-b0ca-08dce7e73933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145

CXL PCIe port protocol error handling support will be added to the
CXL drivers in the future. In preparation, refactor the existing
interfaces to support handling all CXL PCIe port protocol errors.

The driver's RAS support functions currently rely on a 'struct
cxl_dev_state' type parameter, which is not available for CXL port
devices. However, since the same CXL RAS capability structure is
needed across most CXL components and devices, a common handling
approach should be adopted.

To accommodate this, update the __cxl_handle_cor_ras() and
__cxl_handle_ras() functions to use a `struct device` instead of
`struct cxl_dev_state`.

No functional changes are introduced.

[1] CXL3.1 - 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index be181358a775..c3c82c051d73 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -686,7 +686,7 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -699,13 +699,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
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
@@ -729,8 +729,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -757,7 +756,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -765,7 +764,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -865,13 +864,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_aer, CXL);
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


