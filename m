Return-Path: <linux-pci+bounces-28894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB69DACCC12
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9F618986F8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E7C1E5B8A;
	Tue,  3 Jun 2025 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZvC9iLl1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001F23C4F8;
	Tue,  3 Jun 2025 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971462; cv=fail; b=cFiqJiQTXFah9/PYibslf3TwdEH7Zxo7tG02s1vVyss/xo2zhPALWpROCPhO7v3530rUhjX8o5X2sH8citVUIv1shG6Jz9Opt8ur2PeISpTNUv0X3OKJhEMR6krRQhoe9TFuF+glhqDL5mEzXIZ6v80gP8/1HKysS9lOvpvj0JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971462; c=relaxed/simple;
	bh=/KQwqy1ZbTlKRDzl95Q38jBjpEK60aDJRRdBlcrEsCk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5QRt70FfZgXKCgm/Ih78ieTtYxrffhrhE+Pnw6UBs6p9rhRi4QaqmZUTz887cnW5aFZW1S7xcGa7C+xBJtYkAGZNzM1nezWhLsemiMgtProJv+Q8hDUNvAtmW4SjlAAo+BbI52xZXgoNW85aQ7s/ht2m4T+uTsZvTQlb5HYk2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZvC9iLl1; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN1a0xKbUjWc6Yx2pJBOOno82qKtsx18pa38sznvPrGaP2u9LX2USTii6oVRdIoGNjYXMy4cdiL74/Jt51oquZxSgz/SQHmbEMOof1j/a/+e7P9u2wSpH77qmPrI9nMO4BIQovfEs/zsP0WI55kLCLZa0jG+BIcnInyueDH+xKWAM72m4sR8PQrShJke1nl14kot614q9UrIFlOpsDbuPCOp1Fhf5w56GrNaUmJHc38AKTFZZ9M85YN7xTyb5LeJZMBTZc+AJD0bwf76ACnSbfsfQq2oR4JDee2Af9dwyMCK09ZNUaVRkCZsCSn2RdqzWPPj7S07ES9aNC2D5DCKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPnKW/xp5c2W2wdCMrUt016efRwffIhKGY1Qh8CsN8g=;
 b=JJeYE9UjaRpV3uau9IUHNM82RIrtXeT/kRvEpTqGGS71ob1CLeDnUeCbzl3Bx3Xc/IOCqaSZROu2DjAc/FIRzejrXqKN2FMXRWrUQUUEMdZ1ccuPAaS6dgc2YyF72Gdg5Q2yP1+PtH4OeyMkKGhQH2hzGWRv0bboG8VVytTcz2IsbGrTVlfDmjscp0GSbVnhhqOSVa5+TUH18hPde0CM6lX+x4XURFubM4PrvAyPOhuWGPaS12MP3NDCOdp1qw5Xfvg1SQh1zJukAlZBuNmkzAagceGI2PCwF/HRPcENNX7ogZV6AAVHquDUCUB1JaKWitqEGB7UrZy1G7HDPiMXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPnKW/xp5c2W2wdCMrUt016efRwffIhKGY1Qh8CsN8g=;
 b=ZvC9iLl1/pWe+tpVoAi2vHIDi6ekB1+lOppzWcRCt2q5S65NEBEQZsTXwUM/h2Vk9NtD/Vv4kQcPGzNZ7aVZYhqJsotzqStospI9sOsZ+oUVclsX68iNEIzelFcZbsJEhgbIQsUdNMS57XFbyUIXY3sdjdGHuiKMKAYFstA/7k0=
Received: from MN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:208:52d::21)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 17:24:16 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::e3) by MN0PR04CA0022.outlook.office365.com
 (2603:10b6:208:52d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 3 Jun 2025 17:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:24:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:24:15 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 08/16] cxl/pci: Update RAS handler interfaces to also support CXL Ports
Date: Tue, 3 Jun 2025 12:22:31 -0500
Message-ID: <20250603172239.159260-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc3653a-4cbc-4821-1db2-08dda2c3775e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kLy6cOkoFhpqFyad3q8sDkDeP7UbUrg2VWNonVUJkKq3fjRZ2VCGA5EKOBV4?=
 =?us-ascii?Q?Dg7miMTmhEh7YkK92eGppjZwJlxbIGB5SxztMBmox77o0KuCBodTI6m/apjT?=
 =?us-ascii?Q?q5lBHeM88M2vgB9UlegFa+TCzWeNL/axVCv7IfcCP4SxMkp1xauoIlZwBD2l?=
 =?us-ascii?Q?CI/BbD0uxlizFKV8W5cZrADKdYSnhpKL8hpOVebK3Xhl9uBGs/xKBL6m3ILf?=
 =?us-ascii?Q?phOro73tmpOatNzlSlUSNEnvY4gOjimmhr3GrwVGYMfhsbmc7X7hLSWd3kc0?=
 =?us-ascii?Q?BpD/vBmDsdtAqlWzpViOiUTNnziJSQPt5AvELl/QxerXMiHBI8/Cq4OfBud5?=
 =?us-ascii?Q?1z8pfR1YHBNsGO/VVuSgTa9Q4OekQ/m+xbV3ApTvkhxQau/ZEUKKl/dNQiQc?=
 =?us-ascii?Q?InNsg/CeLjPkB1pyjBbnWmW62bkkbvoESNMTn48Qwrn6nKpQdcVQKDWR1ucN?=
 =?us-ascii?Q?tCnu5WCsPK+DdLvuMDsfMLqrWUftPxkcyegym+tRJ0GeYNuYpL2CCoZqr6ao?=
 =?us-ascii?Q?HoaiRO8OENDyUmXDEqoaOvCglTIGpw9td3KUClj7O01CL9RmCaO4H9Em6f6b?=
 =?us-ascii?Q?3Va3TMc/LzODvG9RNVv8vFNwNPNEyRE17w+1GgbpTxJLQF/q1uLWd5P/n8Qt?=
 =?us-ascii?Q?oJKxWPSpksYrp+sGijO79mNE3yoga5BRzP63NriEVid+LUnB46cZ5g4X9XXI?=
 =?us-ascii?Q?Ijb6XOWQbUgQvpV4E7+Ks+O3qlkkN0o2vCzIn5Yojwv3VgewOg2F9e5Hs9yL?=
 =?us-ascii?Q?4tSrQMcXbPGPdIEWCmtslnrCOEpSJJ0hnltte3cOTUOXiyFLkn1lRrJ9x2TZ?=
 =?us-ascii?Q?jtYuE0dSrs+ZZPWnHyIRUXyBqrIfC9gGO7nqB+vX0Hz2mufvF+bSSQymdrml?=
 =?us-ascii?Q?bt0Gyl35cQrqCWTAokbUSqgcfQotiXaVyNp2aK6hAMc/SWjcvE2QD0G3p91U?=
 =?us-ascii?Q?qWvO7DCTPvj4OaHcKqRlr/s+KiqvJvrzHWGqkEwsLeGCvMMtVd6AYeBLRdBI?=
 =?us-ascii?Q?t7QSZSnY8TCTB8hn/rmM1FvWntQqg2teM/rYVQ5CCFYNp5Eu2YToaPL0+ruG?=
 =?us-ascii?Q?daU0QDUf1/UBT91ygwD70jK4Ao/nRZFb+D9QDwE32crzOHj2bv+kbrfoVJgJ?=
 =?us-ascii?Q?SQSDxig79SpMsItpvdXRu31I/v22GJZ89hc8QAyVsVL8xlCz+YVHUNgyeesa?=
 =?us-ascii?Q?beuPd53/Kg7GBUYidDqSknF2hQTMeD4Xaoerp4AGb9CGC2YlgyHAwmr6RWRO?=
 =?us-ascii?Q?f3Ki6oQBn7IlLzQt5kScXZAJfWONEZD1GZ5x3UGPjqigB+h77hgJbPqTcki5?=
 =?us-ascii?Q?lFRdA1j0SDAtBmSIipanFpInJWSTW6D2/xku3wlU/YwXu1w9z2hi7kGmQLxq?=
 =?us-ascii?Q?7gr/8jzmeSF+3c9eeaRf1BWGw3ZSUVA5BnuPy8gqZSFUwAWLWYcnVY4wUcJL?=
 =?us-ascii?Q?XXf+vNQyEQADRdmzquhKqAJnPU432jLsLOiGZh3MDUmcDWjUEabXTClhhvLW?=
 =?us-ascii?Q?juQElx/+ldMXiad6sRlWedlxAWg64Lv9yuWsOOgV4VicfFvRd8QGXbbyJg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:24:16.0976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc3653a-4cbc-4821-1db2-08dda2c3775e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

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
index 317cd0a91ffe..78735da7e63d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -664,7 +664,7 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -677,13 +677,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
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
@@ -707,8 +707,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -735,7 +734,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -743,7 +742,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -751,13 +750,13 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
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


