Return-Path: <linux-pci+bounces-28899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E729DACCC14
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A325D176C5A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F5C1A3172;
	Tue,  3 Jun 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="srxYVaDp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09351DAC92;
	Tue,  3 Jun 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971514; cv=fail; b=kxjpewqD856ZsK3bxcSYm2NsG8L/1mMzQolfm8Yxo88gL+koAdGmc9MJbK7akyvqAuWdKXBvGurZ+Jzx4hdanvhoOUvbdhnj/mS+T02nk4G61MGHr4jcSc26KgUgWsXLfO5UR5h/Z75fboePBfIKFFjvfhDAjYZB/vhewhdhHe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971514; c=relaxed/simple;
	bh=xUNIZuFW5Ede/pkil/BhQOrBSMqZ71aURRRtugY4si0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGf7u5U/jdff/XE3kJBTpYomfKOdPslgBbvMe5T6JPDKXODB/c9Wlw2psf1K1nUmtlAu38rs2Y3To4TG3OqTIxzzPYLRqCChOWjRONHLM31GG6dhQHOQul5CzvxtEHDeNugnCfqMlHb1hEBGoGoX3DFDpUdLi5QfSbGoDvhNT2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=srxYVaDp; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XepsLUytwUgBc1ZvGTx1DkDArTIh63/Nzn5+ZNqPoLDvfO/cEVHOntjtgVzPvuha4YPwV+p3aoqSoOIh9rw4yBRjt1Q+RCIxpBMaGxkwTvACIL6kJJqDRNnZ0ADKfR4ERneCZmvU4vkRVx7cnS+EN0ZoMDXeNJx7pJpsfxyHLR5PbP3A1MxNmlAOcVOS5D0bIF1bR5QuFc7PP2+dU/QTDuxXYnYOuS/lVPxzIEslNOxSRaaGxJHCkvgIyvjXTJ8kzpr8khKLbDAzpsoR6t1OinT/MHD0JhV2I/5vu/JHhKr/PSBGR51UIN8FSkT5cWrQCG8vGij8RkGjQDnMZFDixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt5W+h15YIgGglewz+nVkk/Adz2pZqkQUUikLhstBYU=;
 b=VSHtiRBM0GsZG/gkwinG905BrecaLLLcl0Y5rDVIEay7It8Aa/XjrXDrtUL3/ktWtDuVFPlutOSQvF5ZrBPrhgV+19AHhT7s/bAvrhTyRDLzcQrgtnQgwI3T4+AgWw9jFiNXheUtjYtfYKg6PLUJMoM9bLCC+8+VLXGTscXahoXhlFRyJ/ZloqZWEl/zVRWhJjcK1Q152jUMrEEkYFPflv0vqsOf6PJJ3/+1aaaElWOWLEDDec1KZH4SqVT5KHhvwG5en4R50Fuf34M0bMRPE2TIQf64QBR+jpxgIb2f78DSUbz0NIspoADvqzhMsTFeb//3MC0XEaZLzEiMMiXF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt5W+h15YIgGglewz+nVkk/Adz2pZqkQUUikLhstBYU=;
 b=srxYVaDpiGLg4yI/JWPsIgegbvHShvxaRmxAom4Rb6HGUrNOkFwSPiiZEtxGaB3+2f4E7zCPlDs2eMVjv7DE+PZ8sEDvDQWQIeUW+ZYHRfW/mFwasdxR0eHv4NCxFQ1H0TXyiJehODm42KX8aNdIxBBx0JRL+2ia1oVVnAQc0/Y=
Received: from MN2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:208:23b::30)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 3 Jun
 2025 17:25:10 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::9a) by MN2PR11CA0025.outlook.office365.com
 (2603:10b6:208:23b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Tue,
 3 Jun 2025 17:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:25:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:25:00 -0500
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
Subject: [PATCH v9 12/16] cxl/pci: Introduce CXL Endpoint protocol error handlers
Date: Tue, 3 Jun 2025 12:22:35 -0500
Message-ID: <20250603172239.159260-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: be798828-f6d0-478c-2c2e-08dda2c39797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zSLlfy8n4FZ13v4w39hdCVhGIfwYhyEWhc/iafS3nTX3tQHlsYPux21hMFC5?=
 =?us-ascii?Q?iTAXQK5E08L8WklZiqRvw8AL4qE79rp4oAg4OyrhATa+YgAwSHvvwX+4tAq0?=
 =?us-ascii?Q?0r5n8fdKJ++cfEhYDHj3uNqOenaUtXBtsE7XlcTzPmdhlFmizDA+O3dNQv9Z?=
 =?us-ascii?Q?hbkCfX5nDVVF4yqVvJhfkFKBH/iG1ZY8dw/4V64fTj8955juo8hRsHTnLcjm?=
 =?us-ascii?Q?8w/cusE7adu6kXmSOvKtcvOIVVRI+NvSHBSqK0h+53tRZfuClMWkzM3Ojf5A?=
 =?us-ascii?Q?mP3GoEkOhnBtsbQo2+ZzB4eLlA/4JNI/e0pc+VUShEFczZAc78epOju/r3sC?=
 =?us-ascii?Q?CwmYJ6tIYoAVWZ4Nn3gZGIewaBkX8AfekRwJEZf+NyD3yNx6qjMoazte3xo/?=
 =?us-ascii?Q?cQZcF3xP8UaZdql8UefGdehqgb/raSjQJaQ91nN/5ZQG+ecfeQ2unIAih+pY?=
 =?us-ascii?Q?bWg3ApMGX/bThrLD33D9xJM9732khlI+waCAttDvFh6AYzn8lv4ejrsE9B6G?=
 =?us-ascii?Q?2c49YfvBk2fEZgJhZVrmi6IwFPXJEdVimxWjuzFdt24bBSyUAg4v4/A8R2l3?=
 =?us-ascii?Q?7DcI+CmhyPMYB2gvh/qByND1nl36ZtS4IzX/JbT199mJjqJkKFPdREhIgv2S?=
 =?us-ascii?Q?DTix1NdPh39L+czUG9vwl/HL6ESy6QRneiUytYo9xtCNSQRENWpg7ojzLiE8?=
 =?us-ascii?Q?Huu/muNiUrBvoN+SjsbcFFhuo/sBSzTdfv9SlsPgNSlikoxQNPdzjLkqolAr?=
 =?us-ascii?Q?W5TK33sLUoKeTFng5/9C4hTDvvUxGkJuS4HLbYCLWhWd0S/GL8XtdIgvZ86M?=
 =?us-ascii?Q?1JlJ1HI7/ApugPb+44MeACedXe2mNNyWAHE9C2UPyVYN5Eedf92LjEthdY/d?=
 =?us-ascii?Q?nkEGlXfR2noje+kPAfskjCaPvtZAeFcKkAIXDNF73JWSx5np/COY/W3I5CdA?=
 =?us-ascii?Q?PSigJx8MBFkBqNToeWX4vwISbLUzz6axTWr/PlcOMQI7zwZGYdjnjo0tXl8P?=
 =?us-ascii?Q?3hZ6tO74zIRP9oKvFyPyygtqfZAe6p+/V+TbAUTT7aXyBOfKr0YPqqVIFciw?=
 =?us-ascii?Q?M7iylDZa751zhk5UOFkfEx0MzehxHjfvb/yvDTiE+DwB2fo6994UJ1Ieq1de?=
 =?us-ascii?Q?8DMWqnkteXu2bjJWOezshlhE2h5j5L7DyKWZSnWVSo+Gaq0Fhj40SkwieBp8?=
 =?us-ascii?Q?SIXV4LL1yzEBwELzmfB93z+n7K8Fjuhy6V6eyAwkLnxko54Nq1v5BsRnclYY?=
 =?us-ascii?Q?6KeKAdEzwpaPVxJKS6S8htrqxdIHdDmq3tS3ZvxUfpU69yt3fKPu60hl7Cdh?=
 =?us-ascii?Q?rS9sbGZjHuFk/71zEE2W78E/u/BUF6VLqWIp7dy0RjPYvhINlebBjzfWv8wF?=
 =?us-ascii?Q?0upvAccwD9O81mnOFOflJLvqvEt3XFRj7ofL0ajFvRxkUYVAsoCLhhrpfy87?=
 =?us-ascii?Q?a6ClE+lDP/o0FLqBV1vGacsLW9N/1cLwkLk4aIMTajsB7GoE25qDsixeWt90?=
 =?us-ascii?Q?DYxt0oDFYBCr0l96w/Crh2z3FWtU2ljn3sS27Hapf98Je2eAaZZqDE1b7w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:25:10.1440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be798828-f6d0-478c-2c2e-08dda2c39797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239

CXL Endpoint protocol errors are currently handled using PCI error
handlers. The CXL Endpoint requires CXL specific handling in the case of
uncorrectable error handling not provided by the PCI handlers.

Add CXL specific handlers for CXL Endpoints. Rename the existing
cxl_error_handlers to be pci_error_handlers to more correctly indicate
the error type and follow naming consistency.

Keep the existing PCI Endpoint handlers. PCI handlers can be called if the
CXL device is not trained for alternate protocol (CXL). Update the CXL
Endpoint PCI handlers to call the CXL handler. If the CXL uncorrectable
handler returns PCI_ERS_RESULT_PANIC then the PCI handler invokes panic().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 80 ++++++++++++++++++++++--------------------
 drivers/cxl/core/ras.c | 10 +++---
 drivers/cxl/cxl.h      |  4 +++
 drivers/cxl/cxlpci.h   |  6 ++--
 drivers/cxl/pci.c      |  8 ++---
 5 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f5f87c2c3fd5..e094ef518e0a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -710,8 +710,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct device *dev, u64 serial,
-			     void __iomem *ras_base)
+static pci_ers_result_t __cxl_handle_ras(struct device *dev, u64 serial,
+					 void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -720,13 +720,13 @@ static bool __cxl_handle_ras(struct device *dev, u64 serial,
 
 	if (!ras_base) {
 		dev_warn_once(dev, "CXL RAS register block is not mapped");
-		return false;
+		return PCI_ERS_RESULT_NONE;
 	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -743,12 +743,11 @@ static bool __cxl_handle_ras(struct device *dev, u64 serial,
 	trace_cxl_aer_uncorrectable_error(dev, serial, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-
 	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 
@@ -844,14 +843,15 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+void cxl_cor_error_detected(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *dev = &cxlds->cxlmd->dev;
+	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
+	scoped_guard(device, cxlmd_dev) {
+		if (!cxlmd_dev->driver) {
+			dev_warn(dev,
 				 "%s: memdev disabled, abort error handling\n",
 				 dev_name(dev));
 			return;
@@ -865,20 +865,28 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+void pci_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
+	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
 
-	scoped_guard(device, dev) {
+	cxl_cor_error_detected(&pdev->dev);
+}
+EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_error_detected(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
+	pci_ers_result_t ue;
+
+	scoped_guard(device, cxlmd_dev) {
 		if (!dev->driver) {
 			dev_warn(&pdev->dev,
 				 "%s: memdev disabled, abort error handling\n",
 				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
+			return PCI_ERS_RESULT_PANIC;
 		}
 
 		if (cxlds->rcd)
@@ -892,29 +900,25 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		ue = cxl_handle_endpoint_ras(cxlds);
 	}
 
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-	return PCI_ERS_RESULT_NEED_RESET;
+	return ue;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct device *cxlmd_dev __free(put_device) = &cxlds->cxlmd->dev;
+	pci_ers_result_t rc;
+
+	rc = cxl_error_detected(&pdev->dev);
+	if (rc == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
+
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 0ef8c2068c0c..664f532cc838 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -153,7 +153,7 @@ static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
 	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
 
 	device_lock(&pdev->dev);
-	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
+	vote = cxl_error_detected(&pdev->dev);
 	*result = cxl_merge_result(*result, vote);
 	device_unlock(&pdev->dev);
 
@@ -223,7 +223,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
 	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
 
 	if (err_info->severity == AER_CORRECTABLE)
-		cxl_cor_error_detected(pdev);
+		cxl_cor_error_detected(dev);
 	else
 		cxl_do_recovery(pdev);
 
@@ -244,6 +244,8 @@ static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
 static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
 {
 	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
 
 	if (!pdev) {
 		pr_err("Failed to find the CXL device\n");
@@ -260,15 +262,13 @@ static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
 
 	if (err_info->severity == AER_CORRECTABLE) {
 		int aer = pdev->aer_cap;
-		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
 
 		if (aer)
 			pci_clear_and_set_config_dword(pdev,
 						       aer + PCI_ERR_COR_STATUS,
 						       0, PCI_ERR_COR_INTERNAL);
 
-		cxl_cor_error_detected(pdev);
+		cxl_cor_error_detected(&pdev->dev);
 
 		pcie_clear_device_status(pdev);
 	} else {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 73be66ef36a2..6fd9a42eb304 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <linux/pci.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -797,6 +798,9 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 }
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
+void cxl_cor_error_detected(struct device *dev);
+pci_ers_result_t cxl_error_detected(struct device *dev);
+
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 6f1396ef7b77..a572c57c6c63 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -133,7 +133,7 @@ struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
-void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
+void pci_cor_error_detected(struct pci_dev *pdev);
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 785aa2af5eaa..2b948e94bc97 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1112,11 +1112,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected = pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
+	.cor_error_detected	= pci_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
@@ -1124,7 +1124,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1


