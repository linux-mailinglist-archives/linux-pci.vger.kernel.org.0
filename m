Return-Path: <linux-pci+bounces-21205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB0A31567
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479C318830E1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE62D26B2A5;
	Tue, 11 Feb 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EOSRTRtt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C826B2B9;
	Tue, 11 Feb 2025 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302056; cv=fail; b=Ou2wvLtfHW4e/0vu2wVUxf80D+SfnC/bd0UhdclFWYHEynEZ+rQaPiYj2+tUwi9leqmWd1Vgs17dWna1bkX8vkXsqQjnqwbUoxwhda5GZ7IN9UJ8jrBy6SMopjTIfKfe5OHzBQtz4Dfo7Cqd2Gjvt3ZTNU0tUdY9oBO+srC1Jvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302056; c=relaxed/simple;
	bh=2hvE5s9juZxh9ugoC56sj5QQoS2+uyUToT8tOjMYmGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HH1Rn46BWWeqA7I9EaRlEKbjvc7CvL3PjpvVJN7RsVzO35AsBD9YnfH3lG29G73jIsWVGbm1yJEadrm9CViG7ZpqwCF6UUNr8xH9LJaQiUEm09bMPaIDWaq0Lf2R2LHTrAKPKim045irHflJiphCwCH2t5SdbuAqLflUtr9IxRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EOSRTRtt; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAiOABdbaxyX1TR9M28TQ1y0nWMNxaUaZIePHcFyW/fdjgv3EsLh3OnubafDE6yrpBEUshb1ji+YF+IBBRx7gXDMsinQuzzxIQ2v21uM9DUGPSC/bPtXEz8B21h85wYN3AxP/ldPHEHk5SVCtJUZRx4DU87n7UCvXzNwfgKtKcHHLxMf0RfdHBlrIYXI+bCybNhWmibrazDW+jGC+lqLLq0uH2M3PC8Trpi2/wVG6/zBz7qAta3Yatn5FhYmQXGocLBcF/Vhnf+S/JYGFNxwRc6vXDJsfNTx3+a+YdF/6gtkmTetqr12s504/3RkEH1SDgdo1IIdjoARIyX4vRWdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrDruBWFYHquY4TB7p1+cE5Ko/Hb10goW6a+Sn5ypK4=;
 b=KilopnvwBQufNuwmGTsqqBZNITse5W3b9Vb0xgTnsgDMLuhXm34VOvlzA1nzvCmPC8Mk2ryY+m5jIHzFUShr7vlJXBeelBvkzCQyUmymnh7DEQjmTrIqIqprE4gG+cx758epRPzvBTNRi0sVxN5V+zySFx5LXrAP9Q0li27IJr3M8JPEj2m1Enr5USDKbbFUmabkWIIUwZV1FwltEdDqmXWEQe8fO9X7ifJyjAPVMNYnP/Bk09ZLcrqK9h1p+yCNPU2HGTgirYcVb/9uE8HzAbNCNZOSQd74BZd5pKQtoKtbnq32FN84mNvhhg3kEyRUbzCKzh0Q5ywERz74JpV8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrDruBWFYHquY4TB7p1+cE5Ko/Hb10goW6a+Sn5ypK4=;
 b=EOSRTRttwlhBWAxmx63C9lB7KeI5ipT2SEIXWo3HQGZC8hecBO1ZGuUve9nSzFBAi1WEThuKr+SXFK+4+yiZhThaO22cxV7wYvXkaVp3o/AWx8zxPlCxQb3xnm+d+CpLfcUyYGWjiVY1g6qBJRO3wwRAa4Wij8y9vib+UnkzLrs=
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:27:27 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::ca) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:27:27 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:27:25 -0600
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
Subject: [PATCH v7 14/17] cxl/pci: Update CXL Port RAS logging to also display PCIe SBDF
Date: Tue, 11 Feb 2025 13:24:41 -0600
Message-ID: <20250211192444.2292833-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2137c1-7e13-4659-a073-08dd4ad21eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2YC4YvpZM6/VH2yko1VCKN4kFyeECDA43VQKZqjQdNFbHTJd/mSK8VkRq/bP?=
 =?us-ascii?Q?O6Ku8BKDQXUGdddU/7CQ0Pk684U15pEgQB+eoQZP/5CeSGhiM09vTswAxtJ6?=
 =?us-ascii?Q?acDviVP8wZNBgAuEDvNM/8YUAzc4ZnFK/LV9OL4o6NCZL7/eQDBDDE+kVICQ?=
 =?us-ascii?Q?ngTqsCVZPKzaF9tZj5b2fjkU7L/DE1CMVgWxsqdWWHqDHlDZ60CpHy/blk5U?=
 =?us-ascii?Q?qpHkgiU2ixHPCdIjqZNB1juEigyq4JeXbq8ZgdkC11k3AoGEuq73y3m7SmId?=
 =?us-ascii?Q?T35nJYmZsKSvOqVNRvzBPg1XispnQm75MxnTCZ3DmHcmuxtvpzY31mW8CsiM?=
 =?us-ascii?Q?ZvKSqrVQ7Pks0mr8AESsds7oNHTCf2dVdOJhTozS94t6fbGOsZDkwk24t2rU?=
 =?us-ascii?Q?oVfUgw2ipGMrQTnOcmv+WSaGZgRMALCoVWnJJ7fFk2THodMZojn0VyufQQ2I?=
 =?us-ascii?Q?1YZuvSIJON+imXBLi6C1p6dSmeYfTBpaX34PG8h2FUtKgndtgsASt7GhSg4K?=
 =?us-ascii?Q?ByUP14ruLmpbiGSRS2V1FvKY/TG5sL2hypzGAaRS+2nqSEbpSrBPuudy1tKT?=
 =?us-ascii?Q?HS8gVg+E3MGtnY4NdHvFkYiyNjIURotENmJWcyOGe36YI9DYwXIy217AtzIK?=
 =?us-ascii?Q?AOzorUU8cYSoTV8z/xWqyQ8IgXQvRrIwj6O2CW8+oLMibe+b0zP3OPYGUUuE?=
 =?us-ascii?Q?FQ3VhRfG1xY33AE+epbL50aoUfJCXELTXafzkz2b4YY59CT/2boFcykiLqHz?=
 =?us-ascii?Q?08m15Bh+ltqAqZieuCNq77+DvCn8QmbuXO0jvT+vf4AP6DEtA1mlHMO/ReKK?=
 =?us-ascii?Q?JH9hi76gKvbIMJPR6TwcZR44dnZLgjvZlmOC2eLUh7JFHLyPzKanB3THA/9Q?=
 =?us-ascii?Q?3eouAqBkMowpVKjIJC5qw/twPmV1l7Kq1cxlNcBf95+/UnQCKixdJu2onRDC?=
 =?us-ascii?Q?r9c1XONA26AKjv2EDXOgDNItZUSHyd1yH2kbnNWVibmWhLYgjjAB21t4lgLo?=
 =?us-ascii?Q?RwWNnlXu4QHVfQ9StNwXKXsxHSWzcUtJyW3Y6XWUyqneIHD88O+cIixOx8Aq?=
 =?us-ascii?Q?p8AOJUVt6kJi4+KBDp74333HYvpIOv06qzrcSZWSR8uTgODbzgXTfkYLMqXP?=
 =?us-ascii?Q?ZB0aRip1HGoG+H3VN9uQvxuOLCb82bdC2dsD8InIvXdAMnvIzK1p4RJV22tw?=
 =?us-ascii?Q?rW1LvSoOQe49MxWMqKC355g22rqP2bjcy4xAe5sbC6o5wV08fGrOV24lBJSw?=
 =?us-ascii?Q?qnJNoryEjyHBkUxmulEbfEv2goqSmRDiBjdRn9rUzgE5/Y7r8M7ILSBRXAYU?=
 =?us-ascii?Q?1QIZLDf9Dd9BzHCoCClYYWpTci+6SErztu+ufC+vpKAr7nLMh27oVaEIE6nw?=
 =?us-ascii?Q?RKn/DXsHwu4Camvh1LP44yxWHz0WtReYpXE7CVH70Fi5XTMSlgZlB8ooyAlh?=
 =?us-ascii?Q?Rg7zY6KJU5dAYScBVPRrhRheHK8Yy7iop/Tci+mz3JhGAkdMPOosQuSGCOj3?=
 =?us-ascii?Q?wR+iKWYsGN+ahvhNahR/2gAShGU2M3g1LHsH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:27:27.3395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2137c1-7e13-4659-a073-08dd4ad21eb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716

CXL RAS errors are currently logged using the associated CXL port's name
returned from devname(). They are typically named with 'port1', 'port2',
etc. to indicate the hierarchial location in the CXL topology. But, this
doesn't clearly indicate the CXL card or slot reporting the error.

Update the logging to also log the corresponding PCIe devname. This will
give a PCIe SBDF or ACPI object name (in case of CXL HB). This will provide
details helping users understand which physical slot and card has the
error.

Below is example output after making these changes.

Correctable error example output:
cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status='Received Error From Physical Layer'

Uncorrectable error example output:
cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c   | 39 +++++++++++++++++++------------------
 drivers/cxl/core/trace.h | 42 +++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9a3090dae46a..f154dcf6dfda 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -652,14 +652,14 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct device *dev,
+static void __cxl_handle_cor_ras(struct device *cxl_dev, struct device *pcie_dev,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
 
 	if (!ras_base) {
-		dev_warn_once(dev, "CXL RAS register block is not mapped");
+		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
 		return;
 	}
 
@@ -669,15 +669,15 @@ static void __cxl_handle_cor_ras(struct device *dev,
 		return;
 	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
 
-	if (is_cxl_memdev(dev))
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
-	else if (is_cxl_port(dev))
-		trace_cxl_port_aer_correctable_error(dev, status);
+	if (is_cxl_memdev(cxl_dev))
+		trace_cxl_aer_correctable_error(to_cxl_memdev(cxl_dev), status);
+	else if (is_cxl_port(cxl_dev))
+		trace_cxl_port_aer_correctable_error(cxl_dev, pcie_dev, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -701,7 +701,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static pci_ers_result_t __cxl_handle_ras(struct device *cxl_dev, struct device *pcie_dev,
+					 void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -709,7 +710,7 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
 	u32 fe;
 
 	if (!ras_base) {
-		dev_warn_once(dev, "CXL RAS register block is not mapped");
+		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
 		return PCI_ERS_RESULT_NONE;
 	}
 
@@ -730,10 +731,10 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
 	}
 
 	header_log_copy(ras_base, hl);
-	if (is_cxl_memdev(dev))
-		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
-	else if (is_cxl_port(dev))
-		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+	if (is_cxl_memdev(cxl_dev))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(cxl_dev), status, fe, hl);
+	else if (is_cxl_port(cxl_dev))
+		trace_cxl_port_aer_uncorrectable_error(cxl_dev, pcie_dev, status, fe, hl);
 
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
@@ -742,7 +743,7 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -814,7 +815,7 @@ static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
 		struct cxl_dport *dport = NULL;
 
 		port = find_cxl_port(&pdev->dev, &dport);
-		if (!port) {
+		if (!port || !is_cxl_port(&port->dev)) {
 			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
 			return NULL;
 		}
@@ -848,7 +849,7 @@ static void cxl_port_cor_error_detected(struct pci_dev *pdev)
 	struct device *dev;
 	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
 
-	__cxl_handle_cor_ras(dev, ras_base);
+	__cxl_handle_cor_ras(dev, &pdev->dev, ras_base);
 }
 
 static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
@@ -856,7 +857,7 @@ static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
 	struct device *dev;
 	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
 
-	return __cxl_handle_ras(dev, ras_base);
+	return __cxl_handle_ras(dev, &pdev->dev, ras_base);
 }
 
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
@@ -909,13 +910,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, dport->regs.ras);
 }
 
 /*
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index b536233ac210..a74803f4aa22 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -49,18 +49,22 @@
 )
 
 TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
+	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(cxl_dev, pcie_dev, status, fe, hl),
 	TP_STRUCT__entry(
-		__string(devname, dev_name(dev))
-		__string(parent, dev_name(dev->parent))
+		__string(cxl_name, dev_name(cxl_dev))
+		__string(cxl_parent_name, dev_name(cxl_dev->parent))
+		__string(pcie_name, dev_name(pcie_dev))
+		__string(pcie_parent_name, dev_name(pcie_dev->parent))
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
-		__assign_str(devname);
-		__assign_str(parent);
+		__assign_str(cxl_name);
+		__assign_str(cxl_parent_name);
+		__assign_str(pcie_name);
+		__assign_str(pcie_parent_name);
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -69,8 +73,9 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("device=%s parent=%s status: '%s' first_error: '%s'",
-		__get_str(devname), __get_str(parent),
+	TP_printk("device=%s (%s) parent=%s (%s) status: '%s' first_error: '%s'",
+		__get_str(cxl_name), __get_str(pcie_name),
+		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
 		show_uc_errs(__entry->status),
 		show_uc_errs(__entry->first_error)
 	)
@@ -125,20 +130,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 )
 
 TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
+	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status),
+	TP_ARGS(cxl_dev, pcie_dev, status),
 	TP_STRUCT__entry(
-		__string(devname, dev_name(dev))
-		__string(parent, dev_name(dev->parent))
+		__string(cxl_name, dev_name(cxl_dev))
+		__string(cxl_parent_name, dev_name(cxl_dev->parent))
+		__string(pcie_name, dev_name(pcie_dev))
+		__string(pcie_parent_name, dev_name(pcie_dev->parent))
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(devname);
-		__assign_str(parent);
+		__assign_str(cxl_name);
+		__assign_str(cxl_parent_name);
+		__assign_str(pcie_name);
+		__assign_str(pcie_parent_name);
 		__entry->status = status;
 	),
-	TP_printk("device=%s parent=%s status='%s'",
-		__get_str(devname), __get_str(parent),
+	TP_printk("device=%s (%s) parent=%s (%s) status='%s'",
+		__get_str(cxl_name), __get_str(pcie_name),
+		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
 		show_ce_errs(__entry->status)
 	)
 );
-- 
2.34.1


