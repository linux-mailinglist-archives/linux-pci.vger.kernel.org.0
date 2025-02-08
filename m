Return-Path: <linux-pci+bounces-21001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21ACA2D235
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3561884283
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A18520DF4;
	Sat,  8 Feb 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D4tVDcyI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609756B81;
	Sat,  8 Feb 2025 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974694; cv=fail; b=k4lFy/eQjAPRs4zFama3pt3beF0LeP5npD/RlVeZJCrznRq36mjcTfWZx8QFAHc70QmcerToxmQi9Pl5kRKPrIZNZ+b88hyXI+IFkpJrIqVMCZNi0J38i4oqy2lIcDf6WFA/1EbRXFfX39rbTHvEDZ01R0i1clZgKka5NdCg66k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974694; c=relaxed/simple;
	bh=lVEB/FNNE/W2IU8I9qGCEjHVegRo9Wxy6f2e34CtSSE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iw/LSgr5iezcSB84NeCqoutxyFePM92lxVvvPZ5WoBbQ3HJxHAJcNcbxUP2a/KSFR/keVKZGWk+uMbbTr2RL55wdlgHQE4fo49751Vgh6Lb9458DkiiX8U2dUejpTHPhGCZqj2g3T/1qZhd/vU0m4n0rZWw86YrFJiPvdy8kfc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D4tVDcyI; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMcufN2ysvehdnBJDHsog91P5OPEfsx6Z7VeFI6j5+6X9w8vaNvITcsZL80N6r8Mh8BUP0gS+NSD1UDPoSL2JVVb5yG68nWHuIFtrZzTehiUdi3BbEmEsJP1uwVggv/WukpWGtuTrTaOJodgtlGFI77H4ncHwD0s96JT1JzBLs7VjNOX0bvCKWoqTxYfqoSuoV8UvA7EDTG2Ryb0fjeJhrFi9j7E86lLSjjK+kw7wvBVNprYvQtpd4rMHAlRULD0ilYsS+2L29ZO0xHrWTm2FRPBIk6YSKsYYlBW3lRxhrcLYCYr6gI7Vt+xlbCsZsuqLDuPJiZgYCTkgIvQ6vsSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdMOUmuc0ttWyF8Hgwo1k6pQhSHuwnDWd3gKQJ7qntk=;
 b=AuZvpOdQnfpG62KzznuNm8gdkkwzW/O750KuQ+u0ZCqehZ27nWA/t9XWLEL/Wbtfhmrxj4uk9842SF9z03CN5vD3TFp65AjsVk0UlmkeQ5w5poR2x8HxpJKXOn1QK+dRuU0H04SU5aoG4aCMUov+r5aTlJgh5ZPrsD0SfLZ9eZlHPGzDLnywPAwBnBwr2iv0cEunyTPAUuAyYBrYsX325/UmM/iUHxL6o0BUCrAUCQ8vsXCSh4Qai45L2D/09KlKtfTkbpksZyZsw9IqrMReATWuCDcT/u4+pQpHcusCkhjddqYVvdHOmMln6BdtQm1HmvnvFCmUb4Zbo+oimnJwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdMOUmuc0ttWyF8Hgwo1k6pQhSHuwnDWd3gKQJ7qntk=;
 b=D4tVDcyIftsxWxUN/w2k9W+d3r5Gn6B0FAuk401yuIHtxVPCm01z0Bbcl2hWELsCUWS5vF0Fo5A57BTCV4uia2ucoc2MfWP9aNlL8VVn/VX1oNyx/gjVfXqHYFD0biUrbgYw6duKj93BxpFhvRBsPgc2Sj+ZuRvoYVWtyaD4W2c=
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sat, 8 Feb
 2025 00:31:29 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::9d) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Sat,
 8 Feb 2025 00:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:31:28 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:31:27 -0600
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
Subject: [PATCH v6 09/17] cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
Date: Fri, 7 Feb 2025 18:29:33 -0600
Message-ID: <20250208002941.4135321-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5705ac-d37e-4e8e-de6f-08dd47d7edc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UGOjbaMruOS6X6sGQzBDMupkK+IYgvr3TuqtO+0iX2gLabmNYRxqJ0VT6oas?=
 =?us-ascii?Q?SkG8k/iCO15/9FObxbiFDxiq+nHQJDCYvK+zwj+gLpl3FbaR3kgD/HYNu0ht?=
 =?us-ascii?Q?Ro0qY/PZSjIzzoS8pdh70Br9gQhUzy6NHVAZaWTpakpg+pXwAL5UTjUyw8E6?=
 =?us-ascii?Q?0CglwiZEyyXicoKqAqX3XGjyArph69YzTb4q5gwAg79KdjA2p2PWIRSmKxVO?=
 =?us-ascii?Q?ii28j0KFw5SmdCJjfcemVC8giVe0y/+0uGy4EeFPpBr0ddArZTz8XiGkfFdn?=
 =?us-ascii?Q?/wa/lCSIdFcgSijM4n7mgDJefz74qR6kbpv4EeMAS82Q1hxekVWO/yUvr9mg?=
 =?us-ascii?Q?M3k9+Ve47Obmru2z/dPJ2+ElUmkJejn8y79V9bUbPkeitkxDbaq2IpcHBO9z?=
 =?us-ascii?Q?DsU5JVEd9fVMiG8rUohaXvuixhnWo1LGpr7xX+QJesgtIrp5ufTHY6A9/DLg?=
 =?us-ascii?Q?74QT0+XV3ykBAdU/SSaEbyiFeHq0gtvHUGL4rgpS10EX5+hUqFkEUl/sKju3?=
 =?us-ascii?Q?CapNqtJUcweA7T6Zx3euSvxpHKFBSOrCx5fTnV4f9/GX+iOzVzrdFMmqRWhJ?=
 =?us-ascii?Q?egSKWBfoen6gC1Zpi341oJnk9vjLTfRBqjgwpg2njQg24/cygstdMj8z/3G7?=
 =?us-ascii?Q?pyRb4n6qnidTV5wQVWgqMAB8thuj6dlpkNheHk/xZs689KVUV/I5Z24G2buQ?=
 =?us-ascii?Q?3ZxWnUVgW76WGiR6mQs7gkYqukyBTc/B1IJUbRvqh9AC8O/qckIfbEENrd93?=
 =?us-ascii?Q?6iqAdDaINO/OA6FQA5d8xbzI4p6Yl45vff2j2ct5XU6ltQmOsnSiEuH8LWTL?=
 =?us-ascii?Q?l7MCEuJnvNkmMnZCyLb8Ll05JIYERfRU7gvTIDWZdVdgniMUvSea8UptMv+b?=
 =?us-ascii?Q?/xFNEW2frIAxo8x9RWATosy6Kxhs/p1H4rfLsxJyMjfojMnJoSiMS363v+M8?=
 =?us-ascii?Q?GpWT9aJcF3f9o9bxR9w/+/eXLP3tTx4rb40sNfDw45iAvZAa2b36tjQjVztT?=
 =?us-ascii?Q?5/S40rIi2asJKZTNeMlz9zdNr/rfJ7N8a2uToPKAdtiMJPvC8tHqefexnFXv?=
 =?us-ascii?Q?goYTF1bQKRxBvFTv2nKjx8WJmiB4/eEJZkpCscURq2l4ENjarhl4KN3ou0LK?=
 =?us-ascii?Q?KuPj9dnqgtiD27wqcWWtM4U/tRoe4aLg1SdzfyCjxsF6Sj7MSXU31kEtqP9M?=
 =?us-ascii?Q?SmCyBTuMh8ADjPbR2ipBktl9uXb8Z+7ce8c0BPjBPXdU5+eJVQXyxjeRtdI8?=
 =?us-ascii?Q?lnOsQfhk24d3yMO5Pc7bXvmNuDK33Eqz6/Oz+xMRAO7eQwo5GuR5ep5RW0Ql?=
 =?us-ascii?Q?nXy0/czoweTwUzPLLOenvIaWv7STDsX4mvhpFfDfNf0yiNDd4m8EWKJTS3OJ?=
 =?us-ascii?Q?v69xB5JVgPrwmG3Pc+btUNJIwTHBO5Dp0x61kltVFGIU2MVxYuEl5mnSfzsI?=
 =?us-ascii?Q?G74jjExM7wznxpAD2cGbXZCJz/hEWwMcIhR1gf4CrxAuWiY6yAaH//stTgfy?=
 =?us-ascii?Q?dgBhXxLxVcX4OYvEARPH3/qEm72zN8TUZaUy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:31:28.7689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5705ac-d37e-4e8e-de6f-08dd47d7edc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087

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
 drivers/cxl/core/pci.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4af39abbfab3..0adebf261fe7 100644
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
@@ -663,10 +663,8 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK)) {
-		dev_err(cxl_dev, "%s():%d: CE Status is empty\n", __func__, __LINE__);
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
 		return;
-	}
 	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
 
 	if (is_cxl_memdev(cxl_dev))
@@ -677,7 +675,7 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -701,8 +699,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -729,7 +726,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -737,7 +734,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -831,13 +828,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
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


