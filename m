Return-Path: <linux-pci+bounces-16708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B265A9C7DF9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7229F2838FF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018FE18C039;
	Wed, 13 Nov 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="36nUST+w"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1F17DFE9;
	Wed, 13 Nov 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534992; cv=fail; b=BTU7djS7uT8Gd8K3u+QqaGFBlJ6hOWAzQnA472cebz8jyB9KJypWJd9rDjoKZqpjnY/26UKofl0LfnC+dHWsZR9LPgIiZFJRYRDYA4nerCtLs/ASsgMmaQUCsDxhG66+DwYml23Y7e7cVHXWVLdWW0wZE/BIvjFsX9SasVDLjYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534992; c=relaxed/simple;
	bh=MUXIHd30SkBzTAMKZUq0owLkwA+THU3b3XmvQnYXGio=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiHR06QX/8hSqPpLkwgcXLR84grFo3VIkXhUhxFreJKG1c3jWtHdyZXWOqKD7XTITmRsf85WCKo7YSC+rucJfYYMi+aSM2pjw22C0wwnAKrGM9tjoHKo8pmXQ/6uVRxXS8XLRF6CeeBcU5dPPBGXicuUYJzA77oB7n+KVuKjOTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=36nUST+w; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3vM2CB9CLT9QZAiGYa7PiPDPp3tm8Gami36oSHaMJdNNLlePzj5Zm+C/03vVK/3OGpf0XOT3HLxndROzjy3i5nqL9mLbR1/XOe2J8pxT3tn2vPCRv9/PW9pqYH9skzpFL9ZQ87AKpsbmmPlygY9Iw+dcpZQJLEJLKkMWPXI3v4KnYewykvmglE8ts/xaSBq29fdFf1xCS4MtLMR3LvMwMGktUTkrzch7g7ASUva5GmPHGMNCdQttP0JyGR2hjdOamLAe3nkFGym7mDt16YJLH8PJ7I/XcpO3o349GWTCEh8sb3ru5vXh7CGn1FVNks4dNFUouIsnRmINhEjN+96MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea7bZo0iRbeYUrH0erFRcJQuM4t06xgIkaLhMxyCy+E=;
 b=kYtvXyI6LN9thyx6A1RMwatHlpV0I+3q8w8TOsxT1OzhamtUyvlKCRRnMg6jl99iwpa9oaD8fvP7FMG6eVpmj2uAq6OqgB1OieZFbtIml+QzavIUZTQE7CQwsAIp1my6G/JjVZyFCwPKhIWWxWk1UBR4ZriePmJVrHmZLuL/d64EkswIMFx4htqGU58bxkd2EkV9shfMlU9Bt+sh6B/rulyJnmFBz6mLaB3tGiktOrs+daPboME6AGxI0Sw0yC333apKzAekuJ8i4K//iXfGVog7U1Y3xND3cq8oZmx1ezvQor3t3doq0COUaEz33XmIEZHQu2XxLWwT+C7kg0BvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea7bZo0iRbeYUrH0erFRcJQuM4t06xgIkaLhMxyCy+E=;
 b=36nUST+wDYJTL8RPyWUdmq2tZf7odXGUGOvZALRVOOfAAsJM7OQikwcGFi0WlkXrKSe4B+uyJNiU1ztZTEVpJoOHiMZIT1kCkD/uchNHdBcqTubeDu5i7+MLOEir49ZurpGynn2irYNwZHtSzCK43ScyLCxP23QXS7B7w1/eYwk=
Received: from DM6PR04CA0019.namprd04.prod.outlook.com (2603:10b6:5:334::24)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 21:56:28 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::d3) by DM6PR04CA0019.outlook.office365.com
 (2603:10b6:5:334::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Wed, 13 Nov 2024 21:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:56:27 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:56:26 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 10/15] cxl/pci: Update RAS handler interfaces to also support CXL PCIe ports
Date: Wed, 13 Nov 2024 15:54:24 -0600
Message-ID: <20241113215429.3177981-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6f993d-1e2b-462c-1980-08dd042e0697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrJc5pWTaxTjKvEWeuZtr7mpyySq46+CTI4MjVzAKg1zfKMPZQh7eB7hAxky?=
 =?us-ascii?Q?TWnBMSFZotSOqs11vQaZil5pQ9+LBrHYsv3vqlCvcgAokbpGtaghyu9bN0YZ?=
 =?us-ascii?Q?LIgwJV6j2MXYeGfPoVVA9lH3DyaTOxn93weHE1Uvz8LSEjMavz0V/qxcDInf?=
 =?us-ascii?Q?xKWQyfiU4HQUrXHJmR55VuNqzONsmeuYhGXmXfwXGQoUZ2WBoO1Pzthv5ae7?=
 =?us-ascii?Q?sYKYwYwZb+eRu2w7Y1FpzJUFvEGlNqhQu3+EdoKFHTM953IV2RkYFwS1F2fW?=
 =?us-ascii?Q?cz1RgYX+hG4pGThSnrYsJs4aZF57WNPjO7w6KWD5epNp4HWw0W4LdfU7Ocq7?=
 =?us-ascii?Q?Hda698Bjmze2lh0j/x50xgt4OLqydr63x1/SIO7JkaK3GVz7N7qBm5gvAINB?=
 =?us-ascii?Q?OfiBxVIsSPTOA8YOWQcAr08oEySLOZi++TojP+Wo8F8rma2ZxJXTzKT4Fd8N?=
 =?us-ascii?Q?T7aFg8YoZBxcyztSoQDgrdcHook1/7fY9qeRxv9qcSAmrOZ7GhlbY6es3GXx?=
 =?us-ascii?Q?xFfF6bSLclj60QiwIEr2bQq4L0ZS+n7OWN9h6EXQCszk1/ba5R9rFfKzYcCc?=
 =?us-ascii?Q?Kzi/i26+jPINcd1oqd4DnYiWbqC8PpOOovmlgKRJ2qL0xaFu2FNHLIkuboWW?=
 =?us-ascii?Q?HRxgT/Nqqij9fTvdmIcjQ6BMtN2Acsc75Tmg0G+tYqvkZ4ZW7P7SFhUpvf3z?=
 =?us-ascii?Q?42w9iieauEbYGUN87rIh/UE1aF/4V4YQToyspPklTMe/jgruhzVWxrBSXGlI?=
 =?us-ascii?Q?IM1ETcuXP2LVKaFNXne10BmCQhT3P32j/e1QLXDS+ETfAofw1hZL0fAyI2W6?=
 =?us-ascii?Q?1zffuMAr0UEdCcmkacE4OkPyHM4WclQcz2jgVfkky7lInXip8nDB2y+vtO/M?=
 =?us-ascii?Q?gPG9TeECIYcd7Q4R4+ceZDtQPcBFpxHk7JFhVG47OHHrI9hXjqFA1V5Z1f+T?=
 =?us-ascii?Q?LVkO6kL9C3j5q0sdGSyGCvMAEXMwqyCT5LmGL5TIz8qiHWM2tpeKwEWV7gYQ?=
 =?us-ascii?Q?Re0u8xyukE/GqsqtUyFUbWTFLmhy9V2mK6dCDNL2B6u8WsNSMfvah8hzGQcm?=
 =?us-ascii?Q?LoicuYAtUhRo7EtnebgqO+TdoOrlKwO96EuZQFtsCo9e0aQSFq8E6Eb15hB/?=
 =?us-ascii?Q?P+6zzRGqfffOZ/yWmd7EUp9E0xYftxQPlvwhGlb5ooREssVk7FwzCCDfGPXY?=
 =?us-ascii?Q?Tcn9658Gmw7m51R3eDpZQM5Ncne1zyYggaKcY7Ux+H+D21X2hiD0oCY4a68E?=
 =?us-ascii?Q?bLPWP7YeaAnUoeZwJk17zMgBasbhHIBE/3RwOfhZ9mAVqXwfKOx11gVG9Vya?=
 =?us-ascii?Q?dnypoU3WrDgDb++ghHcwxBGvOlaCvlWyipMJ7TuX2tk1AC2V1p/U6ctvkE2Z?=
 =?us-ascii?Q?tJpUSxmlMMrgMsE0U5dxqvDDOV1N8k5jmnXz2tC0NzGF/PW/y+mycTMDHsIG?=
 =?us-ascii?Q?BeKSTLcImtM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:56:27.9863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6f993d-1e2b-462c-1980-08dd042e0697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016

CXL PCIe port protocol error handling support will be added to the
CXL drivers in the future. In preparation, rename the existing
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

[1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a9f891e9de8a..62d29b5fd8f3 100644
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
@@ -819,13 +818,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
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


