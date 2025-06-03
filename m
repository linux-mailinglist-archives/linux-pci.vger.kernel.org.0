Return-Path: <linux-pci+bounces-28897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D4ACCC1B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDC718989F9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6592405E5;
	Tue,  3 Jun 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iW7m24ty"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73F1F4C90;
	Tue,  3 Jun 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971498; cv=fail; b=dniCi0vKpyEGwWO9Zr2gx5GaAiTxzAQMsffgpfgur9g3RKrFlPvA54a/vHRkouvxqxnBoHE9RXoouXYKG6kKN88I1EBO8l5xMVQZv8jCi4RsP4DqlW7JRd3ftdotf2OkxLaADtIEGak4skYsQzvtvf/JiXm7+0lJlbtxUvo3LgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971498; c=relaxed/simple;
	bh=ayIunaeR8cJ+q39qam/q/ZX7ONSyQ2dPdtyBcAmXUHk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcPTJE1jL7g1gyrVc+pC47JQWh9UC9ilArq3vF38Kn2OxsWWmp+HP4zaCVZl66L+A1S9FRMBlgjHhk6+pvNKU77P2C+C4B6yfWGjOhLEZh/aRUGoYsD9rcNkogCsR+PulS9J+HxFYJBdpie7FiACoqYt8nAv+t9vWrsO6UOT99E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iW7m24ty; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rc2ZRELvE1k+zqBgydfEjXz4wozMciGV9N8ctNEBEcScD3+GR7sVRCdDYQ76aMR5FJZvnYhvYlDMN/zy626VCU3iRwuhh2yzo962FIbS+agl0wRysMLnWwNk8kp/alMZhN3YtrdSmx4Lu3ZLDMFzAckFpUglNp1kP+H5wBzOxxZKf9BVnqOKQvGXb3nLWg5397/2hXw17RSfF4OO6RRPJ2h/MgWUbPX9EBrhWwq+XoHSQJm9hm864wlyiAEy7soPhSmiYX7PihwfdGBKOdj7Z+xq4wPsZwTQxkqrVfLPabmxjNwNa/LxURzAV9RjIlyPRkwRFRTroWRNtxGzPoM1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLqsJ2oyeS47XC63eje+FcyHAWxPKEQRahaEIuB4aio=;
 b=ccvpalApn+R/W01Vo1B++EaPM1bKoy6rg8VmYn3qBsJHJn8k3WkJvjUEoP1p2xgzOo0VVOFkyC2AZIdh2sk7Prlg4w+Q4z5XqQPHMoat5KBGN//S2S50ESLZU69AaJBPh0tF3BXsM3gLbNtRU1VZ6SBCSxc6wvENYNBNluXdMz78r4HP5nwI4pOPzkOeaLd/m5UvZS3eNKFhvN+A/yav449A7opjdP3D+LwivFSAYTchHsVDm9VtgtcHOIRtvTJQMTsYJS5BXEiZN0/PrMgjNOBJ4KwvNFiir2GfXzh9sYD++9r78TNYiQSmkbeCZAihBrs372Y6Fqhs7yBTgrnnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLqsJ2oyeS47XC63eje+FcyHAWxPKEQRahaEIuB4aio=;
 b=iW7m24tyB/aCfqTQj58hMziisDzWvqDBS5JVEjzMK6PwdGTpUFJ/FZq5vK7MhRdhlgMCnu2auC6/gG609iE6eXFL+BCjBX9sXJpI/XArPwN0yGkGAqfKDpue5nGqr8lhNN4ELGXhzfmOuZjzwSG/cVzUD7HnMgmtpHtMUyngZYw=
Received: from BL1PR13CA0196.namprd13.prod.outlook.com (2603:10b6:208:2be::21)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Tue, 3 Jun
 2025 17:24:53 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::6) by BL1PR13CA0196.outlook.office365.com
 (2603:10b6:208:2be::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 17:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:24:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:24:37 -0500
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
Subject: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
Date: Tue, 3 Jun 2025 12:22:33 -0500
Message-ID: <20250603172239.159260-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dc4ff4-9088-47e0-2fb6-08dda2c38dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S38c3NZX8FwHLk+AsxIXnkXF1NNTX09ulk7gFPQCwes7YhLS5+lfULdoE0cT?=
 =?us-ascii?Q?60EnTeg1XKOEkEbmrrvq0ZX2c/KSJqyp2v/ru6K/7wAjtLPmCdxAVQDXAzG7?=
 =?us-ascii?Q?nxYzKS5TnGnRSOYXMG7eecDH3X2+NKzRDfmacG3AteenSXSj/H/qRcvwwEHd?=
 =?us-ascii?Q?JoXUBM/+nW8FXkpuZsgj9MIt9fxxvdiI4Uf7CKSmNETS6moSUZRBvQjgLzJj?=
 =?us-ascii?Q?sgsYrfm0rduu3s6h8ZruAM6Mlkp7xX3xBzek6fd+fjMOMOVG/76qchtRZUgZ?=
 =?us-ascii?Q?z5O4xmhcygB30urEN6VLm+kVWrbIwmnqwHOA1T11QZ+UXt7l4ryt1J9SuYFy?=
 =?us-ascii?Q?f1ZyvbV+NVR7d//ohTm47+Sp8Y8EGI1TL32JeQskeQizGzSt5+eXNYU9L/MF?=
 =?us-ascii?Q?BNka6U0vGo9N5nqVodbttTGd8xWlaX895BlLwU5jcLpYzFleL7IxnTeZu0Vd?=
 =?us-ascii?Q?ZQy5TcF7jP8udPWjUIuCnlTuxbNwb8IgJrVj7Z7Xcv7nwjtuuo1jjre6c+Yr?=
 =?us-ascii?Q?wdOFglhJi3Tl7KT8qYyLY0GS0o6paiohyupvLjgx7zid8S1Ys1CUkaHhQTqN?=
 =?us-ascii?Q?nXFEPHt4PDfsq/UO6H4AvbX/UiA8Ynux1glOl1YEcoO9pnWBj48ARs5YXFnr?=
 =?us-ascii?Q?LbYMZDmYm4eHIBPynlxrxmGTtoeQSRq7eu/EOdZRuHU+u0S3rcy4nZCBFM6z?=
 =?us-ascii?Q?ekmA9tn3mNFYhT5cM3PS/QfKBOrNUY7DmvRCiam0+LRoTnRHbzNCeXuZuy6V?=
 =?us-ascii?Q?j1UTb6YILUK2Nh75FPRVUm/m093D/ZR3heWRtudYxPFibqDChgHLzn2D9bDA?=
 =?us-ascii?Q?g7uAdMMCMUKCitifiBK+xHlv/kznH2xIqTlG6jCJdDve6dXPJVsduM/tpcTT?=
 =?us-ascii?Q?1WGuuCdxSqyp31jQa51KdM1ztYiccwWORJ8DR9BtSKZiNyz0Wh0BsJ90Rpsk?=
 =?us-ascii?Q?ZMqGWbJYXEDA0kUZD2aXGS/gjgEZw8mqrkJRT+QpoO4EgTcGm0bkmoefV/uX?=
 =?us-ascii?Q?okT3N6xseq5Vo6X7bUCyrjMoCZ8D9k1i41Xmzfgb2OxheGhFOphAktMpjYja?=
 =?us-ascii?Q?4oflwmgs02FaB3mXiuDMZDBj2ttS++TGdJfNNBrRKf5k3c63KWhbrUBZh0ri?=
 =?us-ascii?Q?ZyQAnXcGArEWmmIVgfzCRIhVUbysNqPKYXegakJw4SqXn2cjZ93Wh7tuj+7j?=
 =?us-ascii?Q?/poiZjhN6eVVfYXSw7Uw9cngr3T5CUQkPYV0ZaZZEPW9xxAmo4svUFmkM6At?=
 =?us-ascii?Q?CwtBNA7keEBBERhHvrjvOW6ABLqjOhDzEh4NPJG9UBClMyw8+ZDAeXgjx2Xa?=
 =?us-ascii?Q?MLTKu917ZgWcEYM5+4Nk93xQPNAJ3EColeiLDTMrj52+WO+n/g8/G39D9VTd?=
 =?us-ascii?Q?y2oswLE1BVUXGSapgZpBiiyqTIlDSZdw7eHluZcavh7j1n+a9EkufgWElYge?=
 =?us-ascii?Q?6hX+Ke0P5GY3alrBkTrcUvx1t98Te3jifnNy4Qi33pAnK3fLXZ+0vzLrlf7r?=
 =?us-ascii?Q?KFmywaJcccFm6ar6uY3K4JxVDr4UmuX/JnnpsAy7lLhTsAU9U16aFZEY7A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:24:53.6728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc4ff4-9088-47e0-2fb6-08dda2c38dc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155

CXL currently has separate trace routines for CXL Port errors and CXL
Endpoint errors. This is inconvenient for the user because they must enable
2 sets of trace routines. Make updates to the trace logging such that a
single trace routine logs both CXL Endpoint and CXL Port protocol errors.

Rename the 'host' field from the CXL Endpoint trace to 'parent' in the
unified trace routines. 'host' does not correctly apply to CXL Port
devices. Parent is more general and applies to CXL Port devices and CXL
Endpoints.

Add serial number parameter to the trace logging. This is used for EPs
and 0 is provided for CXL port devices without a serial number.

Below is output of correctable and uncorrectable protocol error logging.
CXL Root Port and CXL Endpoint examples are included below.

Root Port:
cxl_aer_correctable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Endpoint:
cxl_aer_correctable_error: device=mem3 parent=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: device=mem3 parent=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c   | 18 +++++----
 drivers/cxl/core/ras.c   | 14 ++++---
 drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
 3 files changed, 37 insertions(+), 79 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 186a5a20b951..0f4c07fd64a5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -664,7 +664,7 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct device *dev,
+static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -679,13 +679,13 @@ static void __cxl_handle_cor_ras(struct device *dev,
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		trace_cxl_aer_correctable_error(dev, serial, status);
 	}
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -709,7 +709,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev, u64 serial,
+			     void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -738,7 +739,7 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, serial, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -746,7 +747,8 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -754,13 +756,13 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 }
 
 /*
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 715f7221ea3a..0ef8c2068c0c 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+	trace_cxl_aer_correctable_error(&pdev->dev, 0, status);
 }
 
 static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
@@ -28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
-					       ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&pdev->dev, 0, status, fe,
+					  ras_cap.header_log);
 }
 
 static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
@@ -42,7 +42,8 @@ static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
 	if (!cxlds)
 		return;
 
-	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	trace_cxl_aer_correctable_error(&cxlds->cxlmd->dev, cxlds->serial,
+					status);
 }
 
 static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
@@ -62,8 +63,9 @@ static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
-					  ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&cxlds->cxlmd->dev,
+					  cxlds->serial, status,
+					  fe, ras_cap.header_log);
 }
 
 static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 25ebfbc1616c..8c91b0f3d165 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,49 +48,22 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
-TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-		__entry->first_error = fe;
-		/*
-		 * Embed the 512B headerlog data for user app retrieval and
-		 * parsing, but no need to print this in the trace buffer.
-		 */
-		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
-	),
-	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
-		  __get_str(device), __get_str(host),
-		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
-	)
-);
-
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
+	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
+		 u32 *hl),
+	TP_ARGS(dev, serial, status, fe, hl),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(name, dev_name(dev))
+		__string(parent, dev_name(dev->parent))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
-		__assign_str(memdev);
-		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__assign_str(name);
+		__assign_str(parent);
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("device=%s parent=%s serial=%lld status='%s' first_error='%s'",
+		  __get_str(name), __get_str(parent), __entry->serial,
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
 	)
@@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
-TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-	),
-	TP_printk("device=%s host=%s status='%s'",
-		  __get_str(device), __get_str(host),
-		  show_ce_errs(__entry->status)
-	)
-);
-
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
+	TP_PROTO(struct device *dev, u64 serial, u32 status),
+	TP_ARGS(dev, serial, status),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(name, dev_name(dev))
+		__string(parent, dev_name(dev->parent))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(memdev);
-		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__assign_str(name);
+		__assign_str(parent);
+		__entry->serial = serial;
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("device=%s parent=%s serial=%lld status='%s'",
+		  __get_str(name), __get_str(parent), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
-- 
2.34.1


