Return-Path: <linux-pci+bounces-19430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82534A042D3
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE51B18833CB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1601F37A7;
	Tue,  7 Jan 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xp8bZyoy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AB1F2C51;
	Tue,  7 Jan 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260804; cv=fail; b=FRu4weRPQselKohxCroLN5/5v0mXsSKmdptX2tXbrkOVzLJqF27UJfpWShd/arPKvC5k5WqD0InUWnuvFC6kXyqwmU9+6Vlhj8U0hKG1NWldfaV1lyKaRAshhiO/0jkyroE7J97JmvS062NrVpIQgdDV0iBkZdfSk7KaxLkdbgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260804; c=relaxed/simple;
	bh=+R0yKGbPVHFs9l0T23fO/osRkmfjuGF8DNmf7pLlkRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFwID/+0T5HNW35PGC6D6HdChjipkpzoby77hSD0NbmMMnqZ1+mEfKM39gsuA+5Ea06AMrkffNs7GqMzzm4F08Szos0wbEwc/cyUhQymXuS/XapUs4jtSKncGLbhKXBbIY8987WWWLcqfk7ouk0XsAcsvniN5TM8S49eMpnD03c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xp8bZyoy; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptkj73b/xRvLEMMQK8/yJn7pH9g+ge4/tfBNdsCglydH6Q0u/wjDRpodvb9IHA0wvIXboWW/jnWrvS7waOpCFywOedCmy+tvcMSZ+w8YF4YaDZ8PVK8WKWIqzbZxWecjXKNYectZiez14tPAxTM0PAotc9UY10AEI16nx5ujsizyMEC7Q7VJvakVX6GQpjllzv1C94GTrcBfJ7OlAKi5u4WqyCzZpqUauxWf1TDz3UY8PlJyo9TS8g5B7nZpPp5T+2z8hliXrUhNWosh4HF8tRzvO7xvInZoUfbxHuyW1SftMCarhbZ88/5AbEuTAGOYWaJCL40yLBIO0GzjYgxC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WRRa/dMUzuq1BoDLQ7GdnLoBbiEHXEhdM+Cdt7WuSM=;
 b=jnCveEZJ/w1afWKl88Zq/NlawWYl3bRJw4d3yv70pyZMq60zufxd6sk/FVkXkexwyNOIH7Ul9dk34/IARE1JK7oZu9jMjI7Wg2u5HrOuUk5wxi8kxzXq8MqBrS8fUiO+p9vDEg1UASa/SMd7Jpg2HL37zjncjLu5vJq62/CDcmTBNBHFs1Sf2RwF1GS7zSwOE9wYobouyDCAyMidEsYzAZ0LuA3LusmO71j2fOTLrqY/bFxQmrlWhowmY6YHZSQ2/4dRDL9x1StMXmea6gVSwQtlIToUIM4SigebPi5ZfeSi4v5c59O4NF4zoXJPiOsiE44tGI6gKqAZ0P1Te53iOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WRRa/dMUzuq1BoDLQ7GdnLoBbiEHXEhdM+Cdt7WuSM=;
 b=xp8bZyoyV0Ud4IINxYOq611wC5AXRTaIHvaHnNftxV1ak5fywsGandGalh0kqAvHB/IkD7RxfHtZH+OqVcVDLWMjoHntlzptniyyT2HtmTgFgtcDDIuZT4MaACfLVrHjkpIuq4xn5/7Mx2ar9iRKqEv4aMa/u6oBp+1ss7P9MqE=
Received: from MN2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:208:239::23)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:39:55 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::d0) by MN2PR08CA0018.outlook.office365.com
 (2603:10b6:208:239::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 14:39:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:39:53 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error support in AER service driver
Date: Tue, 7 Jan 2025 08:38:41 -0600
Message-ID: <20250107143852.3692571-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccee729-27db-4343-03e2-08dd2f292713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bH+D2NNLNk9Lx7XqjUjryxpKKA7HGefOj1QO9roIyWREqsSTpWUHtT3Et6u9?=
 =?us-ascii?Q?xXgbB4xwgViIzRAnGzI1S7UQKdTAfKVgL7ZRuQMvPAyNK+j5k/kvvoTWBEIL?=
 =?us-ascii?Q?xIsGSPr7iiQVMRkY0DS10+CGlXLWOhu/EIDO9o8guRrSocZqiZQWItrFMuAe?=
 =?us-ascii?Q?c+889dAv0qTeumvL2cwSTLuVShQLtva885b7Wi2SLg6oljNF2r5isiX9aNiV?=
 =?us-ascii?Q?F1zubjK112TEbdcbJ6yXu2F0Ds2c7sfNshegigw1CDwhVC943srzAt03lylR?=
 =?us-ascii?Q?hGYza40gHD/IQ93VW56z9Rbze7vFi3k87lLJZjPA598HhoB8evrNKE7cj82+?=
 =?us-ascii?Q?MNImE7DflidgVx3Oe18I5K2KGBpmsnnnYiPzD/YrzTeXqxAEbSLzxqJL3C7l?=
 =?us-ascii?Q?wb+cwYhbCNHPGBSB2h4QciGSV4CHUN23Xj75ElShkpMZRQ/m0OhtceUge+yb?=
 =?us-ascii?Q?ImYljHnpQEXLNMiv3rdWymoTxqlXoAR7zYvZk14/rTWAq+XeVtAmSspK+o8w?=
 =?us-ascii?Q?DhnpuMUhV8RDHAq5kUB0By/9UOWiPpyzgGOxnbHE9BiBa2ySSThp/TE8+Ret?=
 =?us-ascii?Q?Wx/qHHJ8jU7YxFmdUhkcxZoYkXOK2lGefzJfPOF+3NFaL9qebBQdx8khg/ls?=
 =?us-ascii?Q?t7rU9BfqgJkN0uyNiC7/DviLAxiKRPmZVrwh+aZau6hJSuJgB9dYG8YPiBdF?=
 =?us-ascii?Q?TKcyy9RVfUYxNpXU2NyRLK0zfT3WPlTRtP3rRgnvWf04qUMSi0WO5j25E7Lk?=
 =?us-ascii?Q?hsUOcCh4dqZABsS7s0f1O+getFukVSX76lfozaQS1vxpBFDuJAcuVfrkZMXQ?=
 =?us-ascii?Q?bzwAvJF8MzeZCdjA2LZbYDQrZ4bHYmYqv2/cFJmjMq2F7UybqeTxrF3YGtcq?=
 =?us-ascii?Q?bf6pMJrDrGMqpPPc6EOryWuB/9+PeHZEusirWnb5sHa3PwJGNIVyOi3eqBt9?=
 =?us-ascii?Q?tnOIN2uXqVLBOtOLkETWw5STRr51eO3cg2I2lP6N7MyAp+9RTmfXu69OLJPu?=
 =?us-ascii?Q?KN/iaHFjj6BPhhK27NLdJ1T5Rs0Zt0kCL70M2EbkjIpQaLUucbEb8G0n1RzZ?=
 =?us-ascii?Q?uJgx3JVhV0tbGQPlGV0cXLlh8dW0rEdFwAJqKbP5XFFN4DolpuG/6AEO4wzl?=
 =?us-ascii?Q?MS1erpPq1zvAaJPlkbfRg1QOC2pM30Tusi8WzBXMd+Q4YJ8SBgcPNKgjB5oV?=
 =?us-ascii?Q?54C5WPj9ytc/GmuGa7/MvvHrvxIrkPC8TwVZL13D+dnnsMZeVLGUGtvJgb9e?=
 =?us-ascii?Q?1WW7CP7ST0ErnaR+5kmw0EkHKt+DHqP1d0aGS4fvGz6sabLXLt0VsVRCCgzY?=
 =?us-ascii?Q?Se9fgxn4lT/n8EYOs8xO1mTtb2T9MsmrkPq+CFNqGfiODdsFLzMa3qQmWHIZ?=
 =?us-ascii?Q?sRsTXpUS3lnMpYa8FrIbr+iHbz58cqdMjT1EATWgXaNBTa2X7gApMyXNN7Yn?=
 =?us-ascii?Q?PF/hLdITgKvZFq66ZvSh1RjfAGOZk1j9N4g9oTuE1lLUFKMstBeTUMzi0lDv?=
 =?us-ascii?Q?C/fnEETq4JvbzMOLUbHaEoIb7PizD6iu5nk/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:39:55.1575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccee729-27db-4343-03e2-08dd2f292713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605

The AER service driver supports handling Downstream Port Protocol Errors in
Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
mode.[1]

CXL and PCIe Protocol Error handling have different requirements that
necessitate a separate handling path. The AER service driver may try to
recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
suitable for CXL PCIe Port devices because of potential for system memory
corruption. Instead, CXL Protocol Error handling must use a kernel panic
in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
Error handling does not panic the kernel in response to a UCE.

Introduce a separate path for CXL Protocol Error handling in the AER
service driver. This will allow CXL Protocol Errors to use CXL specific
handling instead of PCIe handling. Add the CXL specific changes without
affecting or adding functionality in the PCIe handling.

Make this update alongside the existing Downstream Port RCH error handling
logic, extending support to CXL PCIe Ports in VH mode.

is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
config. Update is_internal_error()'s function declaration such that it is
always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
or disabled.

The uncorrectable error (UCE) handling will be added in a future patch.

[1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
Upstream Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f8b3350fcbb4..62be599e3bee 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
+static bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
 
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+#ifdef CONFIG_PCIEAER_CXL
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 	return (pcie_ports_native || host->native_aer);
 }
 
-static bool is_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
@@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 
 static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+
+	if (info->severity == AER_CORRECTABLE) {
+		struct pci_driver *pdrv = dev->driver;
+		int aer = dev->aer_cap;
+
+		if (aer)
+			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
+					       info->status);
+
+		if (pdrv && pdrv->cxl_err_handler &&
+		    pdrv->cxl_err_handler->cor_error_detected)
+			pdrv->cxl_err_handler->cor_error_detected(dev);
+
+		pcie_clear_device_status(dev);
+	}
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
@@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(dev))
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
+	else
+		handles_cxl = pcie_is_cxl_port(dev);
 
 	return handles_cxl;
 }
@@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
 static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
 static inline void cxl_handle_error(struct pci_dev *dev,
 				    struct aer_err_info *info) { }
+static bool handles_cxl_errors(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 /**
@@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_internal_error(info) && handles_cxl_errors(dev))
+		cxl_handle_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
-- 
2.34.1


