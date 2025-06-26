Return-Path: <linux-pci+bounces-30860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92280AEA9ED
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285EA188BD99
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B16F22126E;
	Thu, 26 Jun 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IjZds9JR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9107D2253EE;
	Thu, 26 Jun 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977921; cv=fail; b=uiI60WjRSG4GRnsPSG/4cqw2wyrIIj5Sx2ZhvYbTjFtuWB6d9ts9kOVt0oTW3oRYryb83xeTvyQQ7ZsThpNsM0aCMvSyaGdvGBHtoGzZ0GvW9EB0XW+Sr1rZeIFIwxKRD2W/cMgDKzquBsmKUuzLFPR9A9m+npU1EkFYkiKuoOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977921; c=relaxed/simple;
	bh=s8YZAWII4BR+XvqruHfL7OdjOv3mR2yWjDxAuaDfp2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4eG2UJ1AGWo7vn9csbORPmlXhIhWRq3z6pwT+s+mdGIvqlq/cTsO4NDyIo7QvjvKtIwDqvX45fss+wr2RkY7iCAAbKjhBSRTipSO0MMQ2+F1MW1ABRhhoJB3IGU1nTUTscfLnOHDmcWo3PRlGuNrTJdSqfko2v3jYa9SjM/Dyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IjZds9JR; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl7xkhDsrnkU+OYZsGigjcTxqwNhPfFDvrPd/f3KLY/1nexjmtStPg0qmzTqQofzsL7NZmUaEXAQ0el+njH1lgP8q/Pd1MLksf0yQyFVD4nksKRtob/q7bpoLTtmVg+c2L6lz86kjfZsM5qQBo6Rkgtcfb4rSr7YOV9qadHvqyT7y0yiS56Ee55DMfb83mh/NPUZOAy/6ee73cXDkdot421oxbRpmmES1aMzCqOkkWx2qV90aaXrhYmoctzpsa0XixMoTCe8npXVhW+p9X50mWn4Mw6G3e3Zk7QhaRICJOHEmfOeZRZ4oObYrkEpPd4Qh1imGrcmMFxRvcnndtBNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A38+QLMenbeLqFmkxDZ00mtw4XaU4Itbcs8pyVwq/Uc=;
 b=Sg0LyRLHhKzqy9VpBgVuDWqvmEyi2949bNx0rLcxYdKCXlog0POK8r3BhDULI0JH2hmnfjGHLXk1T41rKruop0oi6o+Ftf1cq0I+zBbWNTPbAEjk4xY3a90yLU9c0r2bp1u6RFimjQfcI1dSSjshKINUuDtT6CwRMRqly/j2ayFOA9P9Rjef9XLPPE/uo51nb/VqcQxmvtU+a4xkCPMz0NWcZVNU91odCZ+6eIDZon+ZV0VrwBJNkA3mUQrezgdTsV7FAMO97u2eSQKePVPE7OqwCBIJWX5MJP1m3rap83+IQwDfRuVDY06Rd0S8R4qFfaGDQfLmv/uUnhswAZrYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A38+QLMenbeLqFmkxDZ00mtw4XaU4Itbcs8pyVwq/Uc=;
 b=IjZds9JRPuMYigFpCqfu4Dbv98d9Zs487bAFylDVnt79o3JG5lCTe1UQ7EPFYprur1wkxF3lkdRat+WLkPbItNZFjeEOEMpVpOte7AAy8fGJ4X4x5p4EfApFEwvl5pLjOjUaCCTih2BmRlkCTPnacWuZsV7W5qoWaNatBjk5q74=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Thu, 26 Jun 2025 22:45:13 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::56) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.10 via Frontend Transport; Thu,
 26 Jun 2025 22:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:45:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:45:11 -0500
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
Subject: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
Date: Thu, 26 Jun 2025 17:42:47 -0500
Message-ID: <20250626224252.1415009-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f755945-2964-4693-3a41-08ddb5031ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|30052699003|7416014|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d79A2INMf1KCDLt/ql8SF09OCq6fKs13NawTXCbIxan9NCgpD863SAV7XAdX?=
 =?us-ascii?Q?H8sqp0NA3Ttj3eBakCf4AP1wQAbq87tXPDKDZGI8895WG6fLWCFDlu+E24XD?=
 =?us-ascii?Q?FABbFqREtfZR7r9n/YmxwkgaMR6n4aWi5JhSLWUZNm5XxVmn0R9LIG+p1iFI?=
 =?us-ascii?Q?ghmMjc/M70DPa0lv+soFAgT2NTgY7J99yiQM53k5BWy134L538YPfe3QYqFf?=
 =?us-ascii?Q?PDQrxN/OJfJHNrzyMxucLA8OzNdA7lZH0Hxl7WNosU7UZSCBnQ24kLyvUXKf?=
 =?us-ascii?Q?x4ZPEuwcCD+gK5x2a2wP+gCBQETDa+S+aipGy89sGuf3kuIXmnqPut2Ifsu7?=
 =?us-ascii?Q?Dtg9f2k70fxyQyfa6tZSnyKGdWa+BgAPtEWsq6HaLl7v2dZ8o44D2+wyoSuV?=
 =?us-ascii?Q?dYUFkPuV8sz1t3QpcrGqdOnYLjvsESqxDzPsowhdZYC+YKf8LQfDFYk6I1oX?=
 =?us-ascii?Q?SLVfVNIc3XrRWABgsnN9BrIRIzd2cgsO7UUkAb3YWfqhCMKi6Tnuv/C7t6Zu?=
 =?us-ascii?Q?pxXFuQIzbgsjbmp23dhNUSXOHk9E23MNSxywipsDVn09vs1lA6X8pdywPAUR?=
 =?us-ascii?Q?mjlydRFG+KeJdRnGn5KDeL8Y4nx6//oNLtrmW9ECiAbWYGoHF1nsferfDlKd?=
 =?us-ascii?Q?mY7xQjX8WCqu193eFevlsPkYl63LCjQ1pGAq5FZfHoB32w4T02VG/d0w1B67?=
 =?us-ascii?Q?o+hHKwtnIa0+rhzSD0GOzUhUoEiLqU+iJJqP4JGYfWIwrQYS2dILmrJ/nOqq?=
 =?us-ascii?Q?Oam4gcC5P6RHeXbOhORuJwMQNcw4wySYAI9j8nIHULO3eV9/6FmePj0/hFdD?=
 =?us-ascii?Q?ormHNRu0B8onBu+9ey4xcfSONLGlxx30Pb84Ett7XpAuazNbtDL6KwGs5Wcq?=
 =?us-ascii?Q?SQZxo+iuoB38CVrtkIQBsjDY48aFSzChtx/oQKmc+efRUTjL/ZOeDodk1cA0?=
 =?us-ascii?Q?BEVa4VbaQ8Ti/y3I8BfmNfIqfnvwIM40NwHtpR1xlUAnKFlD/ybeWiBxrDWm?=
 =?us-ascii?Q?UyBgWH0hBBvzFv4VoKDQSHFnlcO8B//GnJg2MrW1i0Ll+HIYzIuLTaRQyuGU?=
 =?us-ascii?Q?r9deL97WfI5gLvoQllXbto9fUIkeVwQyjBvijvk5uZxVVr8r4KrrBV6RH94C?=
 =?us-ascii?Q?Dc/LX+dMFz7wiEHUUHirRDHDoNIrtwqTvIrQsAXqDEt2LBUSoI7aax5aKzxc?=
 =?us-ascii?Q?ji6C+pwRoh58z8tMj76QKkfYD3nLK+4I8R1pC24P2DaMSAP9QgMJPyYV+WSl?=
 =?us-ascii?Q?Qi/9BRXsZTW3lS2DDOWYIyGHyQt6x/ivt6DysEa6h4QSiW61agXhhLY5DBL8?=
 =?us-ascii?Q?31VYRdd7f1s2AYN6ocETX9OyI+JkchAbnN/fUfRfKRN4cQi4tu3NZBmt/3+V?=
 =?us-ascii?Q?yGyTi9EHJraEzgCqh1BiynCv4f4f3JXc/Uh3hr5YWCfAqvQ9JyZe9PQfXI1D?=
 =?us-ascii?Q?jtFWn5bpY7TwgMyBK/Z+ka6JpjZ6r02geJ93uSMh6JN5gNdLewAVrsGuNUTd?=
 =?us-ascii?Q?CrCqeI9W5qOgXByEPeL1YryUviZrnkM15Ilr7FQr4emRRLH2t2hogwUNYg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(30052699003)(7416014)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:45:12.9846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f755945-2964-4693-3a41-08ddb5031ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103

CXL currently has separate trace routines for CXL Port errors and CXL
Endpoint errors. This is inconvenient for the user because they must enable
2 sets of trace routines. Make updates to the trace logging such that a
single trace routine logs both CXL Endpoint and CXL Port protocol errors.

Keep the trace log fields 'memdev' and 'host'. While these are not accurate
for non-Endpoints the fields will remain as-is to prevent breaking userspace
RAS trace consumers.

Add serial number parameter to the trace logging. This is used for EPs
and 0 is provided for CXL port devices without a serial number.

Below is output of correctable and uncorrectable protocol error logging.
CXL Root Port and CXL Endpoint examples are included below.

Root Port:
cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Endpoint:
cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c   | 19 ++++-----
 drivers/cxl/core/ras.c   | 14 ++++---
 drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
 3 files changed, 37 insertions(+), 80 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c9a4b528e0b8..156ce094a8b9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -664,8 +664,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void cxl_handle_cor_ras(struct device *dev,
-				 void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct device *dev, u64 serial,
+			       void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -679,7 +679,7 @@ static void cxl_handle_cor_ras(struct device *dev,
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		trace_cxl_aer_correctable_error(dev, serial, status);
 	}
 }
 
@@ -704,7 +704,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static bool cxl_handle_ras(struct device *dev, u64 serial,
+			   void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -733,7 +734,7 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, serial, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -744,13 +745,13 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 }
 
 /*
@@ -847,7 +848,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -876,7 +877,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 	}
 
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 962dc94fed8c..9588b39faabd 100644
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
index 25ebfbc1616c..494d6db461a7 100644
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
+	TP_printk("memdev=%s host=%s serial=%lld status='%s' first_error='%s'",
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
+	TP_printk("memdev=%s host=%s serial=%lld status='%s'",
+		  __get_str(name), __get_str(parent), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
-- 
2.34.1


