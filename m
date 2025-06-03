Return-Path: <linux-pci+bounces-28888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBEBACCBEE
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D207A2C30
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12361C8629;
	Tue,  3 Jun 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TfbVeFVE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D11C54AF;
	Tue,  3 Jun 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971394; cv=fail; b=h7iJGk+fkQy6S0YrjFwX2t1mwnGXB5foXrij8bk/LDpK0N4ycf4Bhnijsshz+1fK18tHLjSqXHYRWJ+0W5YAQAsOy8+zi6wPE8VtVXkNLgsx/dLm3IvLKr8URwAwiOt+WNjC2/GbYQo6Euhbf39S8e7E3F7pIVThJFyVkjXC4sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971394; c=relaxed/simple;
	bh=d6+JA9gP4iBccKopeBo3MvMuzo1MxxKtftZaq54P2hQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsI7G6JvvJ5fX1yCTS1jcDiQGQ0lMuXCdFBNKirS555knjUuL8XgD2CCvbU6TDIzznXKdnavRGWzeZdiOG8umVsQ4m90fTbXT59/tEde9fgcYG3BWz+sHubtrmj+59/1K/VnqamRP2NFtpOKqI/cIfGJKLi4MCwTKX6F9yT/sus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TfbVeFVE; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs/xerfVDqcgQZrbzl7tM33gy6ak0se4WlRyUqDwivKd/SKIwVtG+DBuuvYHdTRONcLTIbEOxbBOhafcKxe/bZ37hQRn8GlYNLLZWF766FaSWzqrcjDkgFiYRJJegqEiLh05gweLfDR3gWv64alNkjdDd6+dBqZGsqxf4HvwSGVgf83wY0frJ27uTHX23tUYmWN/b5yZnSIwPVaDrHHRGT62zthmoGNq8TOvtgCGyCf+rxhsgeiGOwMUUXdWb4FvEpZvIk2FrVYcWskcc+1md7EmCCdTHZ3tEfjFUvjmw3adpODPv4KVYkNjPhOn9yACdxviehExUeEo6Io0wVxCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ix7M1tI8ZzrHjOlmVpgoBCzCH6Xog06En+h667QNQ4=;
 b=u6/seE/QdITwcbOtL+PsSvRiH0WB94T4zgpvYmOK7f+n1syuZgT047gNo6Xd/rw3oQDkkA7xcVct956KJ9yA3d8b/iqNhgIP9sc2wn47HfYkvK6WIpreVlBw8SJSDsO707NxSPgeZRWz+jjh57RPtR34R+GhQJFLae3FElZk/PvAVoiYC2Zb1y2cdA+tSar9BuqrpxDtWhlhXcy7N+rWhgPdUxvIkNs8tEPJcdRH+sxeFa8+hIeV7AWb+3OSfqCwwIRII6buJ/W9jyLk1ac4S43Qkq20P2HQee5DD2S+lhb8kTgiOjdjeMo1knlplY1gSsef0XQV9TNP6YfxtHMt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ix7M1tI8ZzrHjOlmVpgoBCzCH6Xog06En+h667QNQ4=;
 b=TfbVeFVE57L9/LMN58rcDC2zvctbomAH/spA24eYtf6hhsCV59L4GBW8BKM/5ZKFkXXpLdBRFch8KOcPT0x8BX3MOtfiu+rY0IEggQYNm7B/5lBJwkW3JYf8q53IZQVuCenGmpBUQq9j6tLfwWCbByD2+I4xucKJw1V+Ew4G/f8=
Received: from BL0PR02CA0123.namprd02.prod.outlook.com (2603:10b6:208:35::28)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 17:23:09 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::95) by BL0PR02CA0123.outlook.office365.com
 (2603:10b6:208:35::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 17:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:23:08 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:23:07 -0500
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
Subject: [PATCH v9 02/16] PCI/AER: Report CXL or PCIe bus error type in trace logging
Date: Tue, 3 Jun 2025 12:22:25 -0500
Message-ID: <20250603172239.159260-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 1333cdbb-f5fe-435c-3832-08dda2c34f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rN4+4GNktO+COEt80wyGanpWORdleXjYeJmVZjWsnhj+JOaPPP8iu5lfJbqh?=
 =?us-ascii?Q?mN2pH6/Mh1h1Bd4yVwJtZdQwvRcSXJjhDFY6Yv8JKV6m7kza/nvpJSivh48n?=
 =?us-ascii?Q?wEf8dS65MHylQHFXQjh7ujYazMgDZ9iQChBPKCxvsAIoo5jEE2yXhmDknRjI?=
 =?us-ascii?Q?WgAJ/WN8OpMoRbvK3UuDurif59Xfb7v+bYtLdMXTXI9ABPRGqfUSJ8puWyxP?=
 =?us-ascii?Q?Pr+owLLaGoVmptxm3MbseBVCk4AKv40l3kdjlZWCP8DgwUiFc5q2wbQrh+q8?=
 =?us-ascii?Q?hQPgtKc6GXXqYjy1wUJ+PR4MO0zte1vLw/oqahQ8JiI7bP4RwV4Pd+arX5sL?=
 =?us-ascii?Q?4sZfaCUoMEyWhPYRIsH2FyjVgoNGHrwBgFDc4HA/WrWp4FJwDTRW4FG8apjN?=
 =?us-ascii?Q?lyuRNesR0ht9ykyS+TJtJVjlePWlHb3IYA6iagjQNxmuNzJWiXr7NEDAbwvb?=
 =?us-ascii?Q?bHs/WOWxt0iXaF8/M1VUyGJkAkycexV346wRRP8wXOOFRFl2r80KR9jzBWFY?=
 =?us-ascii?Q?AxjPRhIT0ABSGHcgIS6WJmctD20Yn7XNWUN2EwxxKldRq35MypjQCmUKGuVe?=
 =?us-ascii?Q?V3FVJMCiv3jKgrKcUHAI+KS0tMopm4g72qH7e3hsFxkTvwZCTZbxH4ZgBxVE?=
 =?us-ascii?Q?EL/NEba6s8hWYGdk1XoiyGKUlSPaigBvYwoTI49es8PmpH9kjUPTmkvVXC0w?=
 =?us-ascii?Q?kz8gY37Wss9jUUeaiNaHRLtjagP/cY4KK3V9E8z+oq0IHR6tvgdA3NBkIVA4?=
 =?us-ascii?Q?H3J2eLDtq6zXPP/LQATYEopJDaZkEQsJaT3/BX2RiOmJxj6GGFLDxDd/XSvE?=
 =?us-ascii?Q?/O6D5KQveK3GuJ27gNsy3Ece+HL3P6UsHUjWxlLA+t84zCVwh5/BFx2TEhRP?=
 =?us-ascii?Q?wtBsxNl5BYNJpd7ehuyFbySpyYe812UrGC/LO/OM6+4eP8PA1ZdoQ/wy2/Yk?=
 =?us-ascii?Q?LRfVW2+W/TlDiuMNgTA/jIBPMsKPoIHpab5S7iuLGyx5tkndnhY9Oy+rvQjn?=
 =?us-ascii?Q?2zlR2PtQ34kdbe9Lx7MmlVMGxmGqlTTFn4s5e4vyCqw6dzHD+jWG5wDXJ0An?=
 =?us-ascii?Q?tZeTUrtVvYY0Yxq8B2d0A1Nkvrv9tbApTk3u6j5WDyi1SEdNgSlxYsPJ2Fi2?=
 =?us-ascii?Q?PTj2EhccDWn5LeOeMgcmWMg1vqgJAH7GEPmL0vXkM4lzW/8uNPj+iU8bk+Ht?=
 =?us-ascii?Q?ylK+UJrRVygjkL6N3WL0MWE2FKjmQ+12a9y/Zo6vwtfVudV2oDRq770Ugbw1?=
 =?us-ascii?Q?WfExmMupzTknGFAftrcfFd2rnQA0E8V2qv0R/pW0PBbPsKsFhLOCe2xTeuEX?=
 =?us-ascii?Q?OTmTND7E3JRKuq2ag2clOf7WFREOWGcrEI4dJqNPGtTzoAIQ3qKMyKxrqt6T?=
 =?us-ascii?Q?fh+tfAF6M1x7qHRuErqMS6LN7AfiqwjKop7zC4gRHqMcXcimBSJFdHBSEyZ6?=
 =?us-ascii?Q?T69V1Zx5VTH3aEKl7ZqlADmaE+56eGoctS4CE5Xk+rp9AsPllNC5znVjsSqS?=
 =?us-ascii?Q?1ZeXlcLN438JA1DpURVd6tH3gG30guzKFoE/B3x0jGZTjGDSEe3JR8DWJw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:23:08.3815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1333cdbb-f5fe-435c-3832-08dda2c34f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors. Update the driver and aer_event tracing to log 'CXL Bus
Type' for CXL device errors.

This requires the AER can identify and distinguish between PCIe errors and
CXL errors.

Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
aer_get_device_error_info() and pci_print_aer().

Update the aer_event trace routine to accept a bus type string parameter.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aer.c  | 18 ++++++++++++------
 include/ras/ras_event.h |  9 ++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..d6296500b004 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -588,6 +588,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
+	bool is_cxl;
 
 	unsigned int id:16;
 
@@ -604,6 +605,11 @@ struct aer_err_info {
 	struct pcie_tlp_log tlp;	/* TLP Header */
 };
 
+static inline const char *aer_err_bus(struct aer_err_info *info)
+{
+	return info->is_cxl ? "CXL" : "PCIe";
+}
+
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..adb4b1123b9b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -698,13 +698,14 @@ static void __aer_print_error(struct pci_dev *dev,
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
+	const char *bus_type = aer_err_bus(info);
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
@@ -713,8 +714,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -729,7 +730,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
@@ -763,6 +764,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type;
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
@@ -784,6 +786,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+	info.is_cxl = pcie_is_cxl(dev);
+
+	bus_type = aer_err_bus(&info);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
@@ -797,7 +802,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
@@ -1215,6 +1220,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	/* Must reset in this function */
 	info->status = 0;
 	info->tlp_header_valid = 0;
+	info->is_cxl = pcie_is_cxl(dev);
 
 	/* The device might not support AER */
 	if (!aer)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 14c9f943d53f..080829d59c36 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
 
 TRACE_EVENT(aer_event,
 	TP_PROTO(const char *dev_name,
+		 const char *bus_type,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
 		 struct pcie_tlp_log *tlp),
 
-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
+	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
 
 	TP_STRUCT__entry(
 		__string(	dev_name,	dev_name	)
+		__string(	bus_type,	bus_type	)
 		__field(	u32,		status		)
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
@@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
 		}
 	),
 
-	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
-		__get_str(dev_name),
+	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
+		__get_str(dev_name), __get_str(bus_type),
 		__entry->severity == AER_CORRECTABLE ? "Corrected" :
 			__entry->severity == AER_FATAL ?
 			"Fatal" : "Uncorrected, non-fatal",
-- 
2.34.1


