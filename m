Return-Path: <linux-pci+bounces-33219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BBDB16897
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D41062276F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA922253FD;
	Wed, 30 Jul 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cuf7iXMH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8213D246;
	Wed, 30 Jul 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912257; cv=fail; b=JVH5tQWDKe2Rrs6tgRJgWJ6BN2BuJxWGD4NyVSpSPaubb9YTsksZ3UvK7+dp0YffclniBhe5kkMyYuCt5YcZf9eEU2clsIhUpBXxuXApoWBUrThcG3QE0t+JONZfjLvTJnVI3Ul8+8cTE3iO8zfJkGFVNk89EqVC3yBZJnOh9EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912257; c=relaxed/simple;
	bh=1BD6bBjz2hfijF091QpXmTbXkAmRiVSghB0fK+3nqRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2fhSiSwsZzlK/ytjf1ejpRZOI5W6xHLpeBPy76CTkSqUG2tAQzxfwtPimXnbhIohLGX3aBQke7bNtINVtDzsUrdK0wUYkKPDKG0lVSHnHsSDUZsonX2EGcE18UE7lzBPJMM6lf2LBr1NQIkD1W3mPC1bHr6x/CA7SbcgIPCLu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cuf7iXMH; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+pPIzfWMy1eie4hDV3FWClCtvspHTpcdeZIBy6tvFd6SuqZU7WUyJBT55WIiRJLr/JPWzKIfjqK5K117pYmPdcOVkMaJd7BT6h+srUKH1uVe1E5sEJr7b5+FDv6o2T2xLxx7IU8AXo6VWkvRvPIbtLl2xHzZmV5Pbo5zoEigXlVjiE8DYJfI3L1HS/Hh9+dKZ7iyH+NEgvNL53itjTrc9kXmsHZn0OPRJjs1xCqRrckDOZGQ14Fwl5SUn4vBmzJI0T8/Qo+oCg6uB7jDKDEOHk36VC6MmJBvFubhSw8HQmRdFQDgDjT8lK6LEVKO2vkKTzKxm9fCWy83+DqzynRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C01fztojnL1yVcXRcYaB6bgyiSOYpGaKrVfCDk1TKw=;
 b=AkZghLf6MWejOg/3eeAnpKoTtzel3M53DqsgE625kS4V4YefkpZwdcTD4nXYvQLZfVq3KSnXJJrVUvCfYqxwJpBPKTB7+4u6qjU5441NuIqy+btT+FPD75GuG1/yrRnZbAWcq6tYm7yRFlRkD2OGvv2cwruyJoL+7PNl/32tjghjyBVX70ieVtMkwwLImSjh4Nns/PYJ0O53ghHis3qJ07kbmWxh9Ra7oXhF/QiHxfxl7u16sadgC8svSjf0T/fGqW3UaDA78kNTH9++cDwzHL6Mo6aOehryVhPrzXknGk51woz0rfkjjSV/tDpwSNsJWeAJtH1HAOAlcdXw2cQptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C01fztojnL1yVcXRcYaB6bgyiSOYpGaKrVfCDk1TKw=;
 b=Cuf7iXMHQ1kX5hISpiQpkW+gY4sojlxIfCR5X/LG8qc5XcNnmvgrgdBxfNFV9Dy6ulEkO/jI1Bwkx5H+cKXsOIslxRLtpc57ireSGWizhEjHBpzRTiYt2PpT2E2GYQ2iSDBE4lYB7xBXMlfcUqK1SFlkHrGOX9XnZ2dObfmApfg=
Received: from MN0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::22)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 21:50:53 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::8f) by MN0P220CA0005.outlook.office365.com
 (2603:10b6:208:52e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 21:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:50:53 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:50:52 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 15/16] cxl/core, cxl/acpi: Enable CXL isolation based on _OSC handshake
Date: Wed, 30 Jul 2025 16:47:17 -0500
Message-ID: <20250730214718.10679-16-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: f34ab9ca-d7c4-4095-25ae-08ddcfb32814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KcLLvl+/hnrxTaAchTAye6Zj+8ue4d8WF8gcKgmavcaXIJlEnudP3m3ZERsa?=
 =?us-ascii?Q?kdkqqL9sIezt/sNLH/0HNp/rOV7r9y5ymqSFZ1meQtnOp20hFcPHnMzzAGOz?=
 =?us-ascii?Q?mNB8Mu4B9ZdldU0/sD0nWWqD5vDOdoaEO5S22E1cTDrAGXy5uA3m4YWb+S0g?=
 =?us-ascii?Q?yqDPGPnKSeVToTCkVUw7iojcnUX96QhbCGcTdCqlkYhTl8k8u4HFN82Pkar3?=
 =?us-ascii?Q?L1Hpquc6IbN71I4pyUe0tOv+S/NokRBCNQpl+f8oF2Ctg/OmgQBNsSz/mSn5?=
 =?us-ascii?Q?LGmZFpObonO4inHQRywc1RKvkA2goIW00nKMPF/++eEnAdqkHShpBe8Fn3df?=
 =?us-ascii?Q?jppw8C2W0d+Hez0kkEqSmvxDb/89gdQnD9fO/iI5o0BQ/qpD1KwhkytD4dkx?=
 =?us-ascii?Q?SdUwjpJvTwdFk2yDdCMtDO1fU8XJxWJSAzAB7QhOLTOGAwq+QWrW4O0bwF6r?=
 =?us-ascii?Q?xPfhLK7GdkeUh4w+XFp4t7PyrpT8Q3Z08cgBlcCAzDTUyLBvuN2l3WLJsyfj?=
 =?us-ascii?Q?9Bz3QQvTiw98rDpYTDeM9BICvW1fxaG0D1gZoFZOWctmGyG0Kp3lPNUGNrtq?=
 =?us-ascii?Q?XvPqNsnggoriCpwQ0Gs2L3+xol6hM7tLNqsyULJvFjJSxuHb0JNTzFA3Dwtj?=
 =?us-ascii?Q?3SZVn6N+Ksmjkh6JqUSc4GPzl0IW60fkvFtRXF9/cbsZ8AVkUm/jKDrhSfXI?=
 =?us-ascii?Q?YWtOntJ6E6dV6gwmf9HEqm6I7oDRW0Fz6TT1EZKT9WFjYAD2cnmobNo2NNEK?=
 =?us-ascii?Q?gouSweKcBmENen0z+3sJ0gerp+GCAys+m4Ua99QP4RCedpv8Ow1iQX7RWoqw?=
 =?us-ascii?Q?m8B1WpnkQ4sO3IhUA8wuEXUFG0/zcwbhZHoB6G/xaoUbLe2+jlFNKgwLlSbL?=
 =?us-ascii?Q?1PCnz39WNU/xCjCyWPQxTVFztI8l+VEhvWaH0hbyEF/R7YMYzoRjVwa5DbiU?=
 =?us-ascii?Q?eVVIVQN9VYGs5+fezlnWbHzPiO5Pk/daRVzm0nwF5IQWI8liDW5exltWeZd1?=
 =?us-ascii?Q?OO0w7aWCF0VFUkjhFokgAcKHN/zEH9/WqGcmC8NgBAxIf0pVgiSRDJGhHESr?=
 =?us-ascii?Q?E87IXkyAz2jLlw7FahyFlT9kYkSeM+/gxbA1za0Wf4mO5qfVqhPvjflxq3dk?=
 =?us-ascii?Q?BVfH1UUMs980Z8hSUadUOjbDDFnZPpdHBZ29I6dhTL7y+VWZp2P6W/zv2pAW?=
 =?us-ascii?Q?D/DMb4R5NTdiXbrBa8353SNYWaljpMPRkAfoaH5FlWVlYz2HPU1qJD9AgQ6/?=
 =?us-ascii?Q?ICBu+Lk7KCdz70x1c+odG8uJNc2fx1+gTJ2vhnagm6sxidhu8d8TGDm0LPxc?=
 =?us-ascii?Q?eKpxRSIePeBFbux9NbUU2An4BHFd6Pv34L51sYJFGcJwterrtWm1j1usJHca?=
 =?us-ascii?Q?FHFmvpkQ/h6ImJrXNIbWIbmvY5W/tqvKBG5z+dHFaI+r8o5R9EZcYaW1ng4P?=
 =?us-ascii?Q?7GkJBennWY4dQ5Dcjw8YuBQSnM7YtT1Oyk0A/wUg0mK57klpVeX10g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:50:53.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34ab9ca-d7c4-4095-25ae-08ddcfb32814
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879

Enable CXL isolation based on the result of _OSC handshake, if
applicable. In the absence of a _OSC interpretation callback (i.e.
platform is non-ACPI), assume that we have control of all features.

A link for the ECN (expected in CXL 4.0 spec) that introduces the
relevant parts of the _OSC method (CXL 3.2 9.18.2) can be found below.
spec). This link is only accesible to CXL SSWG members, so here's a brief
overview:

The ECN introduces an _OSC field for controlling whether the OSPM can write
to the CXL.mem Isolation Enable bit in the CXL isolation control
register (CXL 3.2 8.2.4.24.2). If the firmware reserves control, the
OSPM is expected to not modify the isolation enable bit when writing the
register.

Link: https://members.computeexpresslink.org/wg/software_systems/document/3118
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/acpi.c      | 24 ++++++++++++++++++++++++
 drivers/cxl/core/port.c | 17 +++++++++++++++--
 drivers/cxl/cxl.h       |  5 +++++
 include/cxl/isolation.h |  4 ++++
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index badaa99ab33a..b964f02fb56b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/node.h>
 #include <asm/div64.h>
+#include <cxl/isolation.h>
 #include "cxlpci.h"
 #include "cxl.h"
 
@@ -367,9 +368,32 @@ static int cxl_acpi_setup_hostbridge_uport(struct cxl_root *cxl_root,
 	return 0;
 }
 
+static void decode_isolation_osc(struct cxl_port *hb, u32 iso_cap)
+{
+	bool err_corr = FIELD_GET(CXL_ISOLATION_CAP_ERR_COR_SUPP, iso_cap);
+	struct acpi_device *adev = ACPI_COMPANION(hb->uport_dev);
+	struct acpi_pci_root *pci_root;
+	u32 osc_ctrl;
+
+	if (!adev)
+		return;
+
+	pci_root = acpi_pci_find_root(adev->handle);
+	if (!pci_root)
+		return;
+
+	osc_ctrl = pci_root->osc_ext_control_set;
+	if (osc_ctrl & OSC_CXL_MEM_ISOLATION_CONTROL)
+		hb->isolation_caps |= CXL_ISOLATION_MEM_ENABLE;
+
+	if (!err_corr || (osc_ctrl & OSC_CXL_ISOLATION_NOTIF_CONTROL))
+		hb->isolation_caps |= CXL_ISOLATION_INTERRUPTS;
+}
+
 static const struct cxl_root_ops acpi_root_ops = {
 	.qos_class = cxl_acpi_qos_class,
 	.setup_hostbridge_uport = cxl_acpi_setup_hostbridge_uport,
+	.get_isolation_caps = decode_isolation_osc,
 };
 
 static void del_cxl_resource(struct resource *res)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b5a306341bb2..e9eb7a8a5f72 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1322,7 +1322,8 @@ static int cxl_dport_setup_interrupts(struct device *host,
 static int cxl_dport_enable_timeout_isolation(struct device *host,
 					      struct cxl_dport *dport)
 {
-	u32 cap;
+	struct cxl_port *port = dport->port;
+	u32 cap, ctrl;
 	int rc;
 
 	if (!dport->reg_map.component_map.isolation.valid)
@@ -1337,11 +1338,23 @@ static int cxl_dport_enable_timeout_isolation(struct device *host,
 	if (!(cap & CXL_ISOLATION_CAP_MEM_ISO_SUPP))
 		return 0;
 
+	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(dport->port);
+	if (root && root->ops && root->ops->get_isolation_caps)
+		root->ops->get_isolation_caps(port, cap);
+	else
+		port->isolation_caps = ~0;
+
+	ctrl = readl(dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	if (!(port->isolation_caps & CXL_ISOLATION_MEM_ENABLE) &&
+	    !(ctrl & CXL_ISOLATION_CTRL_MEM_ISO_ENABLE))
+		return 0;
+
 	rc = cxl_dport_setup_interrupts(host, dport);
 	if (rc)
 		return rc == -ENXIO ? 0 : rc;
 
-	cxl_enable_isolation(dport);
+	if (port->isolation_caps & CXL_ISOLATION_MEM_ENABLE)
+		cxl_enable_isolation(dport);
 
 	if (!(cap & CXL_ISOLATION_CAP_MEM_TIME_SUPP))
 		cxl_enable_timeout(dport);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7f9c6bd6e010..aa36eba79181 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -139,6 +139,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_ISOLATION_CAP_MEM_TIME_MASK GENMASK(3, 0)
 #define   CXL_ISOLATION_CAP_MEM_TIME_SUPP BIT(4)
 #define   CXL_ISOLATION_CAP_MEM_ISO_SUPP BIT(16)
+#define   CXL_ISOLATION_CAP_ERR_COR_SUPP BIT(25)
 #define   CXL_ISOLATION_CAP_INTR_SUPP BIT(26)
 #define   CXL_ISOLATION_CAP_INTR_MASK GENMASK(31, 27)
 #define CXL_ISOLATION_CTRL_OFFSET 0x8
@@ -629,6 +630,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @isolation_caps: Isolation capabilities given by platform firmware
  */
 struct cxl_port {
 	struct device dev;
@@ -654,6 +656,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	u32 isolation_caps;
 };
 
 /**
@@ -679,6 +682,8 @@ struct cxl_root_ops {
 			 int *qos_class);
 	int (*setup_hostbridge_uport)(struct cxl_root *cxl_root,
 				      struct device *bridge_dev);
+	void (*get_isolation_caps)(struct cxl_port *hb,
+				   u32 iso_cap);
 };
 
 static inline struct cxl_dport *
diff --git a/include/cxl/isolation.h b/include/cxl/isolation.h
index f2c4feb5a42b..54b57c42e46e 100644
--- a/include/cxl/isolation.h
+++ b/include/cxl/isolation.h
@@ -4,6 +4,10 @@
 
 #include <linux/pci.h>
 
+/* CXL Isolation capabilities we have control over */
+#define CXL_ISOLATION_MEM_ENABLE BIT(0)
+#define CXL_ISOLATION_INTERRUPTS BIT(1)
+
 /**
  * enum cxl_err_results - Possible results of an CXL isolation handler
  * @CXL_ERR_NONE: Device can recover without CXL core intervention
-- 
2.34.1


