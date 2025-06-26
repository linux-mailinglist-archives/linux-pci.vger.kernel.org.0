Return-Path: <linux-pci+bounces-30851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C123DAEA9CA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363CE1880188
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2AB267B15;
	Thu, 26 Jun 2025 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eJVJUkLo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE122173F;
	Thu, 26 Jun 2025 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977819; cv=fail; b=Gejbe2tyMwAjwch2SuMVcqys4O/5jPKvHLySQ5ZjfVNjtCcFzOTouxHtOe6Xb86gaNG7jfhVtldMyNSQF4gcG+I4528XUemfK3ZMyBFT4yxzbi0tzacpMpgp/WK6yOfLyhTNGeZHJb3I4l9CaPvrFBWmrcxiDzWv9yIVo1+O4mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977819; c=relaxed/simple;
	bh=47onKdiJ/3fE53T8nINxP6oaKa78gPNyWxFnSsfqfSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gy0VfLIXbuT8O5ZRcS802IApdqwku+ovwXfG90hOuekF/SWgORvxi0jM98fmhvCm+wOoQCXW5XbZ67pK1b5IIA8Hyq5+6dMD4HODWYP9t4GjDKxy3uX8tlUCzci75kIMehrba6ObFVt1BLgzySlFYT3S4FRt4MsBZpg2ryZ9m2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eJVJUkLo; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGvJNcDhiJqlmMFIr5adglR4uCKpphNNGkBpAP5t4AGf8ga+S7hIouN8ui+F2U7ZwDRouqlz2ydvu//7VKkoTEFXhX4ta59USs+GGwaDgxEQuDBYoo/1IlXuQkJNq5cGYFM9HEqqMbPaKYpdZ2/K6VNymKgsCqxKDBBWr4vy5BmG5saajydnitqfdtkfF+cEZFFlBwImqd6VlqO8l+t5DEAdWRyhhourb/Sru8MB3OLBfoS11lOZtcLTDuVP3kQmSNY3r2WKnAAhZ0FS2V/7BoI1RWI2RfIbmZWNqLITLs/jy9Ow5aoEIRaua/BpHVE25iIboHSS87EjRflbELvnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=648ZKREPExPVk8GZhp+esCp2YSUftAO6AiocWIHQUbo=;
 b=MPiSB9fJNJV+EGAMBDXUex3TPERfcuTQGfEi4lKbyrms7X3x7KHCbAMuOp5QTORusQfRKauBOFBC9mQVUcJFbWEMj38YQoAIbsQcmqiFrbaG36v66lXpWsluD+vEk0k0xRC5ysNh8jIlN2r12lFkhIxJq/YxigxMY5qwkApmCHGMOkcN7LD4oeHReITIZ/2v9qAILBYprQI3qdM1OtMVIN4rCqACoEXcW6wByuxP8hbFU72oeTh6w2K3ASzDncJQ2e4v1fbEz3oIbROZvWF1Ii2nC6ltCfHS7qnFg9HW/A6nbD/dP/jylvsoTeJ2yFoeQAP/hIdCaMvi4Lg74GZkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=648ZKREPExPVk8GZhp+esCp2YSUftAO6AiocWIHQUbo=;
 b=eJVJUkLodVBnVOVc7BxXx31zvBED7uqFb2yL8FpJgd/F1m/i0Ghj5Du/TN/LdfwIbq3hQBKDQHmEGtcSZFKvHEwj3FspeZTpujR5mi/CoIgbFACTZZ3apPETPkROohMV6CNx6V9gTCkMP7Cq+wF8MPaGCaz5JfWi/TamY6A2frA=
Received: from CH2PR05CA0027.namprd05.prod.outlook.com (2603:10b6:610::40) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.41; Thu, 26 Jun 2025 22:43:33 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::90) by CH2PR05CA0027.outlook.office365.com
 (2603:10b6:610::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Thu,
 26 Jun 2025 22:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:43:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:43:31 -0500
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
Subject: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in trace logging
Date: Thu, 26 Jun 2025 17:42:38 -0500
Message-ID: <20250626224252.1415009-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a42e907-84aa-4bc7-3c7c-08ddb502e0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Kd+xTL3n7xwKq4cmT7IE+Ea3hEaovophGVT0tC6G0x524WRr01RVWvo7xiU?=
 =?us-ascii?Q?5t6H7hGS9u6zEe4YWmrHnqKaWIPqtcVj7STPgw7Ix1UhOClPjpErGyAQ+oAR?=
 =?us-ascii?Q?1cXKpuVwZvoMoWBalUYcqhGU49P+A5TKPG/7O74sQfi6tK83hBubq2IHatmw?=
 =?us-ascii?Q?4ZRyzolSZR6FHwCyuwLkbNxpgtga7e8Fzm/RnR9fWgUTtuHyCU1qTcL+4lyF?=
 =?us-ascii?Q?qtNecoYxzFbQy9BT+RIZcBOv5olxC/qinvxrSVzTZtM8tDuAbScyI0SB34BL?=
 =?us-ascii?Q?LcbY0fwbleXVTjAL7EdHeEfG8BKwgRLk7uApGTj37Puvyof99Bwwnr5MqHMW?=
 =?us-ascii?Q?JrTrzjsluzXX0ILZSo6wp/xZxTsjs9S1Ki1fQPVHpslYnp3Xipcq0NHYsAMQ?=
 =?us-ascii?Q?0+KKmKbSytlKohiBDHw8DEdjlvyh5C7zT1IGNGlicSEEyJqOmjSqFdepvjS/?=
 =?us-ascii?Q?a35mLUQTHfw0e4Ds+Gx68ADgG1rogcwwvrQU4WB4sVcinxpNpuai6knYHqto?=
 =?us-ascii?Q?wg1HWdArFVk4f9VMmcJsWKEmFrc5YR/nlFXb4Gt/rxgM0u4msNPbAHgvFRaf?=
 =?us-ascii?Q?fcebl/xm/EGWn5F2vcnsjdzOs1yuYdwwAhDG7bP/hO18yUoqpNZ1DaKL3f84?=
 =?us-ascii?Q?+0qlYVCB6NwuZSmJ4TCdj8KPKxwYuUUW/gyzs1zUAzrkfp4il1Ml+ZTQd/sK?=
 =?us-ascii?Q?vMviK2F2oXSZFluiBb5VsRTP3jDLi5rSErWSY7KZ50JhGlGxpzQg1nKInfRW?=
 =?us-ascii?Q?Xj65Klr5JZkIY91EdUKuFitkEJwxjukjVBBpJ+HNjpA9obwkUYPi/db10pHA?=
 =?us-ascii?Q?VuAxe56Rhx9MN6Ikr3bFl9gjiiRHmIrsNNUaf1Oz18s253Qy1AdQAZyyQAh4?=
 =?us-ascii?Q?X9Pobvr4ifaNdSH8b84Xd/dkmq5h9I3gdAxRQVdnzbZTx3AjSfzRbQGLFvXr?=
 =?us-ascii?Q?o5Ke8iThH0gmLpH0WmAFji0izBUvbrqz26sCh+VUuMaXLT6fP6shjbMJ+dtQ?=
 =?us-ascii?Q?LU4HS8qaQGTnD2ArS8nn7ZCyyOV9AtTPG+40sqcMnYMQWNKLU0WLW7bei/+E?=
 =?us-ascii?Q?sRFDGbhIafS1jIy53N3vdeS2D0H8lEWiHWTVjU46LrJOXMKOLXITW+ism6BJ?=
 =?us-ascii?Q?ShmTNtYQ0q0Og4YLdNwuCIyB/37lTSUplFho1XZ6uNAIfcMBI8cWx/u27Ctw?=
 =?us-ascii?Q?GLUGnOwcL/UeuVx6UdraG7+fmYer/hjB6KWdQmwhndTxg7/yRUSspujLBWgj?=
 =?us-ascii?Q?4ChECM+lVDLEtQA3fnS6gWrPcsW5uo7AknH62NrsVD+WvlpDawp3MOIyQYPr?=
 =?us-ascii?Q?TpRcheSNQhDXcgzziVqXwrrezcpyhbCp7N11Zu0QcMuIF9gqfb9zYi3QABNY?=
 =?us-ascii?Q?tQ/Usa7MDKwLIJvBtV07fIN74ZSqy3DdHdXPDtjupLl8ObM5c8QCBNQmNYap?=
 =?us-ascii?Q?VJxnuWxlueUavCNDGuNGjhlTnGZ4rH1STD1lSMjyQPma1shAPHhWMHPndqIO?=
 =?us-ascii?Q?jidkw/ffvc/irpgqKOy00b7d2va5cT9HKYV/zcHx8sq9RAjzxZHl0X4JDA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:43:32.5001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a42e907-84aa-4bc7-3c7c-08ddb502e0fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

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
 drivers/pci/pcie/aer.c  | 21 +++++++++++++++------
 include/ras/ras_event.h |  9 ++++++---
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..a0d1e59b5666 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -608,6 +608,7 @@ struct aer_err_info {
 	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
 	const char *level;		/* printk level */
+	bool is_cxl;
 
 	unsigned int id:16;
 
@@ -628,6 +629,11 @@ struct aer_err_info {
 int aer_get_device_error_info(struct aer_err_info *info, int i);
 void aer_print_error(struct aer_err_info *info, int i);
 
+static inline const char *aer_err_bus(struct aer_err_info *info)
+{
+	return info->is_cxl ? "CXL" : "PCIe";
+}
+
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
 		      struct pcie_tlp_log *log);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 70ac66188367..a2df9456595a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
 	struct pci_dev *dev;
 	int layer, agent, id;
 	const char *level = info->level;
+	const char *bus_type = aer_err_bus(info);
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
@@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int i)
 	id = pci_dev_id(dev);
 
 	pci_dev_aer_stats_incr(dev, info);
-	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
+	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 
 	if (!info->ratelimit_print[i])
 		return;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -895,6 +896,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type;
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
@@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	info.status = status;
 	info.mask = mask;
+	info.is_cxl = pcie_is_cxl(dev);
+
+	bus_type = aer_err_bus(&info);
 
 	pci_dev_aer_stats_incr(dev, &info);
-	trace_aer_event(pci_name(dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 
 	if (!aer_ratelimit(dev, info.severity))
@@ -939,6 +944,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, info.level,
 				   dev_fmt("  "));
+
+	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
+			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
@@ -1371,6 +1379,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
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


