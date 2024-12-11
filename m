Return-Path: <linux-pci+bounces-18202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E49EDC12
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1787618897ED
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EAE1FD783;
	Wed, 11 Dec 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bd+ibH/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE21FC102;
	Wed, 11 Dec 2024 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960530; cv=fail; b=UIrjj30TQ2mBoZ/HDZzZTxCutsrZnGgSeb9aGiq1gj4IxYufFAEa9oDkvgmKUFobPzxF1NHPu7IH/scwDQQmo+XwnA+bx+3xqffbOLobg7LeFaxu1RRJACfBor3NJWogjMkt8TKErytcD7fCpE49tLapzFRmLGwFrRn5sDmRmvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960530; c=relaxed/simple;
	bh=E1M3tWs0O9nhMFCjqU23iYUf3cc6bS57oUswWq7hu7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7Y0D42ct9M9Bl/cHhsGE4TW83B+avRlhMh2QkOcHjw5XBj6rSnahy2DeOyk2Ux58P8sANUKwo+P24bwjuPOhOSkBPWzMwsZgNU9jdNNhXH+gSN9bqsrd4LqLT+JXy68fURrOtn9C3OWScAHPCQv+iSiaD3clzSTW0SE2IcLvhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bd+ibH/Y; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHzI6RFqdc2z7pqNJO+ft4JcyZJcq8sUbCcfB5YVoEj7u9cL98X3xCEpR1e2nchss28D5+IVwXCxxXDkUJSuxz2FhFda97SEB6A0Ax5a+JhmtqhiJc+obAmlotVs52qI2QCCFWZwbctv5YV4pyHy8aImIUt3pNJCwIYtjD/LqNOGvllfb0oYTxqgZpSi4RYXw1X2nEviT/AcTs0J58PNrlKIfvXLHeo24klnksd6lFB8lugYa4gaCnCKEzYz+59w/7qHV75177xuT4/9cdNHcKRy6MTSjSntMV+5IZpiiKL3ijQFbFbFzI8QsXaK/JfTUI4c4HyiAHVZUBDqgwB8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Miso7U0fBIPNbIgwku+pRaGhKUCRUdE8eQVx0cmdRtY=;
 b=ocEEzqf/vnmpICC4vkCPNTO+aVaJsv5USGVSdSyjj51nqPxWVPV74JfYUXfUMgGA9BD2cYYyqykadJA+mRediSFXIergsooGQpeP40VNZPCiCS9oqHxLFVXz+sw1eP2+APitrCP0LPgeeM84SewP+6cnqbZ3E+lE/BM1YWxz8p+fdbrIN013rCKHJi8pAewbuwQ+xGohSV1MdOKxLPb3g9HK6pUtgxO38/O5cmga+bNQhlu8zltgjJZSsvfz+QanCNnlo53SWyGM9jB7Fz5GqYNFo+M8eFvDN+Vkq95XLlrnk/DcFBEhVy+DbpdGObfLL91DbRtgzl3uMljvfaCCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Miso7U0fBIPNbIgwku+pRaGhKUCRUdE8eQVx0cmdRtY=;
 b=bd+ibH/Y5eUtzlPaOgNBApBUtLq/Zjtd9eMdjVZanE5ASHkYNa/R0vcOmayfOTggKr4FJqI7wSuDud+aqDC5gEInLqIC1iylZ86+YBD3LHXGUJV/KnAxkjJm2+Fktxtxb2vifNZnLyZqm0hZQNMgBSFp1InNSsw1UFirt3TEsVQ=
Received: from MN2PR14CA0025.namprd14.prod.outlook.com (2603:10b6:208:23e::30)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 23:41:59 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::67) by MN2PR14CA0025.outlook.office365.com
 (2603:10b6:208:23e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 23:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:41:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:41:58 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 10/15] cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
Date: Wed, 11 Dec 2024 17:39:57 -0600
Message-ID: <20241211234002.3728674-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 97659a9b-d1ea-4e31-1dc5-08dd1a3d67e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AXRnzjIBHKQkUrv70YE+TVaqfXqdgEKdj0dL/8n+DJXigegLza0nryzPL9p/?=
 =?us-ascii?Q?UMK3mxB8dNEH8/5BRxLKya0Go2aQ8PzMt1YFyEGrz4Bib2hB1i5iT8dBiPRa?=
 =?us-ascii?Q?51suI3VWPXMd77/wG3EMngK67km7h25O+gVDC4v3EzsLgoZzbyoEXdNGjM4v?=
 =?us-ascii?Q?VCSk6qcZo+1SB5/+b50q9IqPrLWSyfz+RkzN3EBHeS/3It+0DiM20hp5nZPb?=
 =?us-ascii?Q?1uzvYnfTBya1zli5NN0Utdeb2ki2VDRFk9c+YGPg22Sr5KcRO+oO6AO1fD/p?=
 =?us-ascii?Q?vhDrZVNSIVRA2u98TGnv1kIj/+rfrTT+IY/WLxQ6ZJsBa3jLK6a8MLZ/g3o7?=
 =?us-ascii?Q?eY6LpEflstNV5Du88DiOVG2u8gkh4B0Cy7jAO1d8c8OevCuGCpi0NiS03Lmt?=
 =?us-ascii?Q?s9SW5ZoL6lpQ0xFWFpvCjNHAarDdcE6pAgKCd1fC4nUSzLdrMRmPkLm9f5RM?=
 =?us-ascii?Q?aoCa3Rv0fljnbAomTHOUu6mg5ilr3MqGPw3zazV8IyIv5VG9D87Y+C07Q/qe?=
 =?us-ascii?Q?zO6M1YUKPbePHPTry5V6BnOzr6zEGIDlDujZVrvniGbLlqvJ6XMVUKXpao6G?=
 =?us-ascii?Q?6IJphXBjwLYUGVieBNTt4RSpE55sz4uMzkpL2bKIMwmGmC95vTnGUg0wGau0?=
 =?us-ascii?Q?WwAcCrSXRQ9LyQ/omth1qXT8yIpYXUdslGS4HWwAlfYH1JQVVzyDJIp9DLqW?=
 =?us-ascii?Q?q9ClCTncvNeRtdrsyai2XKQdyviDzEY2wuKzO/7/HBLvc/zkET5vq/whjCSQ?=
 =?us-ascii?Q?zr0KiygW5dZbCDQYErlbHtHkOzkvbICoe0AqKtF5QeJpK++zsjtjoJbPDy5x?=
 =?us-ascii?Q?940Ux+hR74BCO/eOlRwa14v45ZxMJAJUcLQz4Ff4Qz/Zx/qAy21j8458QYQO?=
 =?us-ascii?Q?gDyFX2QEPDAoCDHLk7Z/GLmaeYnWzpDAWvmOUhnZkRGSByRU5bOGkoM4T6mZ?=
 =?us-ascii?Q?lowq6I5MuVbOLaOTDiNaYoiePC5YxMIOqzpWRU65I54aJ2Cdroz536jgq7OV?=
 =?us-ascii?Q?hT7gks94Ba2G7ac8JgecpIaXGCTMCTGOEOvOl0Iv4CY3moIahsZbfpH43WP2?=
 =?us-ascii?Q?cq1dgPZE7HskaHJW2c+rGBPfRv3LtXflh6iMUIx7GSiJ+EoEjnm0dBXNlW7/?=
 =?us-ascii?Q?D4WtuNZ2jfG7U4AB5p8dwnc5QnC8Whvqjxo0mW2gT/8vy/Kl/YlkzK7dy642?=
 =?us-ascii?Q?7wVIEUCmn4Vef7cewI3bAILq1elFvFgVC2Lpzs6vvXFsKIyl1ynJxdV8vFNv?=
 =?us-ascii?Q?rWXNKhqREkCza3BmHB4PkouUMPlkNuPtbhksF0tyf5QVwTkwmlTKU1kEubcW?=
 =?us-ascii?Q?Ho/V+lrLq1MX6BrrNaeI5W+S+aMmNNf2SJ7GUdrd78u8SCgkrn6z5HkwzQ0v?=
 =?us-ascii?Q?OueXQeKhgEH05Fm6debcbiLcZpmQ1AHbgn6q45uHkYy1jHIVgPJX+zMb7+R3?=
 =?us-ascii?Q?ZxVcSf/7NEPa4x7yN3vjlmjHoXh9pCzaPLbp9QgITr3GfLg681Xkkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:41:59.4027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97659a9b-d1ea-4e31-1dc5-08dd1a3d67e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035

CXL PCIe Port protocol error handling support will be added to the
CXL drivers in the future. In preparation, rename the existing
interfaces to support handling all CXL PCIe Port protocol errors.

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
---
 drivers/cxl/core/pci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 08073bbe2697..89f8d65d71ce 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,7 +650,7 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
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
@@ -818,13 +817,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
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


