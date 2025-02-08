Return-Path: <linux-pci+bounces-21003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A733EA2D23C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317D33A9DC3
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDEBD2FB;
	Sat,  8 Feb 2025 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kAmoZECQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB512AF0A;
	Sat,  8 Feb 2025 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974716; cv=fail; b=BuFMqBLDoQJyhT/rR9yIqBq2Vo2FwD91Gn8krzXK/cfm+2qn82pkyhGj+sRhP5MdnOOm5F7Ms/QKNzTVlOXhpPfBEbdCJFQzmqV7vUu8CKhU5UUCE4RloYXSr6PwWIwLfZlCql0YEsZLwvb9iHogfa37ww4PpAYOnVYpA2CsyYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974716; c=relaxed/simple;
	bh=3cEUtq3pEBEdRbHub0mpq+H7LoLhgY6Gs5LqqiSmrH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=If4I08U04uUxAH7PmnWxYOokI41NvlZvsEFszu3zppBVfzqvjm7K4m4R/+YaS3qSCgLLDwn/BeYxsSoT+A/5vzgzJJuVQ5Y/67gwtvslqe1jTmnvAI1gpxGEkkgHf5jdYIVlKZrq9bSUmLArjohfHy1odgpQjz8tercUjbXj270=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kAmoZECQ; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ340hJNZH9gic+25xgOBiObN4UPe8HWQjYLvPPzhLAmoA6UeKImd2wjLyWNxDbHB7RGuLSwH0pkbQ8mC4qu0yNGO8K0eCupyeJh3SzuTXjIM91wD2UEqZwuIWc+D8G9Zl0XP/IvokXQ3bJwVLUv/6eqfDTy1VLEXjmQhbl+9v+kBYQ7BRr9Eah9qT1+AcsAtlLDqjBZsqPg/CHmmEKyo97D2GoEQEh02X3xtpwXNQ/Pnszp1Th0vKb+yeuArtQq30ElOVR8RtXLnxguYxqwzjh2DLdPblDD9hk19l806Z/Ju7DRz8WwxP8CIRqxtP65Cj9DGW0NQZPx7j02rLoUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNupzYRXghJOuAOq6Jvnt0xvLZ8nVsmheBZQrqyg3BM=;
 b=T3Q9gXYn+8FmYLMlfyBzO4kbOWcjgoF9TPtPQ06jsSeBEiLKmGV8P6ly4nR9hF2FuHSMCjRWS6HeTstiysFcR0zNBCvg3Vsw5nLOrSLeOgEO3IhsTYssHWRILpJIVhcIiNnHDgDRIZC73XppK3Q58bQ/7A1ORKRCPg5TulNBh4veO+pWr//XyNkzM5nagscJ+6+4fTAYA1mPttjPO6E0RYj+Fc8ZpWsHPgBBF0eojNg5XHpgQ8jPH0SnoJDYmy350ZtuRgw4io23HjHS2j7GeSWNBCmXh+q2WnvZELcEZDn9OlubFdtXYL4Ucx1jsKrpDEth8hnv+GWtlPiYCalG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNupzYRXghJOuAOq6Jvnt0xvLZ8nVsmheBZQrqyg3BM=;
 b=kAmoZECQbBrlqCQC9Tyj5G4bB01J6bYroysd/4zMKUWJvNoE6omN1TXBejmirfYXarOn2LhqKFO9h2vf8hmfKhi4qBQIEB7ZeHA9a3q+HGyZAnOtcJTSJbF8P8dOVzgJ4RNYtarZD5bxzMs/ipPGr684jlTuvDL4PhYRsGLPvEg=
Received: from BY5PR16CA0031.namprd16.prod.outlook.com (2603:10b6:a03:1a0::44)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 00:31:51 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::9c) by BY5PR16CA0031.outlook.office365.com
 (2603:10b6:a03:1a0::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Sat,
 8 Feb 2025 00:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:31:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:31:49 -0600
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
Subject: [PATCH v6 11/17] cxl/pci: Change find_cxl_port() to non-static
Date: Fri, 7 Feb 2025 18:29:35 -0600
Message-ID: <20250208002941.4135321-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6d4416-c8c7-44c4-f75e-08dd47d7fb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9lMC7rbQGuyYwzCMQamlxbejh2j7cYYlZvta3DqLh446mg7Ztbfyd1JKTMeM?=
 =?us-ascii?Q?Py1xrGuGMQc8lZ4W0LDPv+sPOx2GGkMv9JkeI9pyE1SG6L55mPnWBAvfNqgf?=
 =?us-ascii?Q?nvTftoTWh32kWEO2C0b7itT5lpSQ+qBC/uP+jGEPJk4Sdrm1AOyqeyR7KIy7?=
 =?us-ascii?Q?9qPfIRsNoyzA3ZTuRCgg5yv6/1rwTuyzp1bDkitYOndGnDoVNCz/DDEOrY0Q?=
 =?us-ascii?Q?+G4Yii2lMCvesRhnTAwqrb+De/j8ighzfBWY/y7WM47NbTe+viygjXXCHxRo?=
 =?us-ascii?Q?wI+R6aqAAlsF9DlL+30BceRRqMUCUdgPxImsFG6mOlIhbIDPB5B9Z8dcNRv9?=
 =?us-ascii?Q?Lr1Z3RLQr2smcZ69Lnme2YE5R/cQ0ABmLlKvWLFiTHUoELXz/kRby49EtabC?=
 =?us-ascii?Q?CCmAqYyCrWapZQFgduq5px39TaqL44AgXHutK+BjGq4WqsyzFAWz/F4sjYQ/?=
 =?us-ascii?Q?mi2UFzDk9oqs/gpynzdXbYj+UiQO2JUx9l5R+G0YoCRIGMVgwokcOO00pWb2?=
 =?us-ascii?Q?T+0rDIo5Y+6udxuUT81V4PEC0QiHCG9jWyCzV9mrQRva1kYYySIt54zivVsQ?=
 =?us-ascii?Q?85Y5Q53yFov2acJehyjkV5eYQgho2ucF+RRc6qF7JDZGDGyqgf8JlqpH12d4?=
 =?us-ascii?Q?fvbZMctWdCgNM6YJW1SluiDQrpxQGs1AfwDsSz3UQGJ23WZXX7BYwRcz0hzw?=
 =?us-ascii?Q?OC21GTbjEyjNwcA3IGP8fHxqtv60HS/z4dhUsDP6qQ3HRsLifK7bsDwiA5Dz?=
 =?us-ascii?Q?hC197biWjaHTeE3HGyl8coV84bhszx8yduMsT7uXTx/bL3Pfzl+KyfZzsyfP?=
 =?us-ascii?Q?hZWH63RM8vW/IZ7xVzTjzpJvWLlOZ/NL7XJIK0RVvxwX0/OImdWGFtRfkrJm?=
 =?us-ascii?Q?YZZWpAMWmrnh7TRg6VjsAOO7NclJ57ru+ZaxFtamoJga8+7OhP0XmW51ybGv?=
 =?us-ascii?Q?vG/XOSLPHpKyzunJBEzVuEeYT/d1UlW8sEJv0Ynq+nd0GGn3gIzHFw2vQfh+?=
 =?us-ascii?Q?Eraa6LG9uIQPwAtofCb9VuO0fWaqSyMvPAZDhHwA+XzNaPgT9Khx0ohpyW3V?=
 =?us-ascii?Q?fDQc3lnxOVf/qgorCb4HTYBKLT8mweCPEYalwrEHsv1xX0BiJKoMVmWyoLMA?=
 =?us-ascii?Q?34xZcJ7F+MLMaUSoFk7vSyp9twEHkbIcycgxE5SGw88d4skO+n23MK8kYq4M?=
 =?us-ascii?Q?BsRnSctJlaAcYlsk7PEjioR50fWYH56Jp/zi2cwL6kY7DTdawfDYB2m1xuJA?=
 =?us-ascii?Q?tq+JtlA2WyBWR0/Gj2rjeWuSmFkw4+N0mX4/TCzqc3LRxfzJe3MsAZ/eWINB?=
 =?us-ascii?Q?8xL6VV2GWaZ1Osl9tXhM6Gi4euRjrq0P57qivJ5fZskj8kHaW225KDSuiylj?=
 =?us-ascii?Q?OcuYCrnV9kWTAWQIQsC23NoytqMn7dmyQzqe/o7NckGaHRBL17UgquXFDZAv?=
 =?us-ascii?Q?D0cuvlPB65jmhKJVk9eLT9O0sY1wyW6A8YRLWqLQb76M3Hfx0VOWpFmRVWbM?=
 =?us-ascii?Q?+lPv8MNZiMLLQPkMzrVXexb31Qlvv1+3zU44?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:31:51.1698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6d4416-c8c7-44c4-f75e-08dd47d7fb20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746

CXL PCIe Port Protocol Error support will be added in the future. This
requires searching for a CXL PCIe Port device in the CXL topology as
provided by find_cxl_port(). But, find_cxl_port() is defined static
and as a result is not callable outside of this source file.

Update the find_cxl_port() declaration to be non-static.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h | 2 ++
 drivers/cxl/core/port.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a20ea2b7d1a4..796334f2ad6c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -118,5 +118,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
 int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f9501a16b390..ae6471e4ebff 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1352,8 +1352,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
-- 
2.34.1


