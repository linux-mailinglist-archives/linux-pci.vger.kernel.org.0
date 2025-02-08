Return-Path: <linux-pci+bounces-20998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3EAA2D230
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360D53A5530
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49571D52B;
	Sat,  8 Feb 2025 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tJ181HBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE943DDCD;
	Sat,  8 Feb 2025 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974662; cv=fail; b=qXnhHmUnw3ITinVc60FmHIm5rm1a2JpxCvHZeZa/vvf7D7BOGcmb6lVyUSI02qoChtrStX4mbYq+juCdIc1vjElnRCa4jZqy/AcosllpIu4qDtn0jmcq24BMv4yso24wpwiQrwCgelSpV6bEArqK3fXRn1XGwAyHLIRXubRRWPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974662; c=relaxed/simple;
	bh=WwS7yY6CaE+26ukiRgQQYQTr7ue9dMYCmjch0dCqiWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khE3nkmnSrwb31+vsQuAXG92hOjAttXm9qxt+TXWuqF/N/VpZeV7lqItI718PKrkjMLzv92t0yMsYe/4/igBkX+S4C9CYOQtXHmnoDju1Q9rbKrxTz+AljYMAsCwEjpth1fWkjbuupiiR4cdG5hEJU1RaOSn6/IHRBG2PR11hfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tJ181HBO; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFF4wRKWrNmQGo2mHbvsnYDb0J7/2PccqUZMVkCWi/wT9NT5m7V9P+8SE1dcyqPf+rOaPF0EETXXEC5NqVinnZa/tnPCSGBDwCNABNOIiyiuO6lUwADcAm5FOpPcTYAtLhM2/HaQYsIjTzg5WUepBwemxbpzN/n/RTgz1woVqP+SZzioG3LSTglGG66cY9HXXqDn9vVGf3NmRGdzM/yFkcrkfUlEchyC6ns41itlk0VcHOYXQcr0v86hCztyL0XFPXSQQR8gruZXnFaGGC/tnQ+5wvAyl8FQrSKCwAhy19Hr7Q1VSJPgagXGSfkHhuenyKBcq5F69oeomI6/IStjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vW4A1/HYVR7uSZ0AIjloyBwTehRqPSP6Yi4n5KIyHA=;
 b=HHBHysXseyzWe9uD+LaLsaTRIybTT0wsKE8T5p1j1g0n2/C4qAVcGI1E2HMHD4RtJPRbwGhdu4As6RjquOkHKMScvMBQChnXiSkI47gNAEcpxhRToEfEf2VOm/vQ7KmZs7cM0gV0QISzynG6n2NqoMqLq+DTpLDtVN93qoo05ZwjANRpQnv+OLLczCuqtmLdSJAxEt45b12IYRRX+qxEk2h0weW+burpzisFIVgWfJYIzN8/FpH4UupeLf+t+iT6SIkUDKNpWtsJddRP2Dv6lWjT7KG+yk9pvdsd5mAmEQ1Z6m8BprAAMJY73Ff/KVW3+IVUL51Z5Oj0Oi5R9OcEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vW4A1/HYVR7uSZ0AIjloyBwTehRqPSP6Yi4n5KIyHA=;
 b=tJ181HBO2Dz3rDxxFFDgcoJ2YJajBJ7iyW6XuRQgOAuN8JA5oYt4TOZekdRcjrRT7SFX3GgicV4yCsYOWsIf48l3x183XAZixoMRrN8PD/3IA6KeGcEDq8/CNv2e46pMUQeXKexLqGX5u/YLNM3b3I178SJqyGdi9eTCAyRMqvU=
Received: from SJ0PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:33f::19)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 00:30:55 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6d) by SJ0PR05CA0044.outlook.office365.com
 (2603:10b6:a03:33f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Sat,
 8 Feb 2025 00:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:30:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:30:53 -0600
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
Subject: [PATCH v6 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error recovery in AER service driver
Date: Fri, 7 Feb 2025 18:29:30 -0600
Message-ID: <20250208002941.4135321-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: af7e2362-4695-4e5c-02f8-08dd47d7d9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pch3TJhz0mMl5mpiSg59lbRzoiJzmGKngOSJdKQhovvAiNfGjaz2+yFvmKSH?=
 =?us-ascii?Q?/feWVTYfmJXlBja4EqrOVibLiuWGY4/HTOS5sGkQns4w+nWTT2ep+R+hT1OO?=
 =?us-ascii?Q?j1EK+ToTabZjPgSHWlKsWZCo/v4yG9pf650hoAlfGfgD7Grlpg4YeTtEVCb3?=
 =?us-ascii?Q?bc7cpwpyupKLlMeAH+TDUP9XZajyi1CQewWY7pZ4SHF1GtzepyDsgf7ZeykR?=
 =?us-ascii?Q?IYJh+MnfGXOyR6kCNsD3l46c3lgBUVDw+Kj0vOWTePifz8v4kLw25Bt8vwYw?=
 =?us-ascii?Q?MtTn7AX/2GxvA9t5EBturpo56QW2Lgyc0pzWm/RHzCO4QqnKL5FUANbTSFQK?=
 =?us-ascii?Q?f1VN/IXwtwKn2soFYEzSgI6ivAK1hbDZLnJS/hgqlAr2gaeQp1dOOlHyg/7R?=
 =?us-ascii?Q?yOttpRbNocvgEdaLltReT5XZ4qqGxEgWHeKdkXHOl8GgfyaEWLXQcl2iYP8Z?=
 =?us-ascii?Q?6eeKsYJbxeoq+FLTSG26tU4dAz4dyCwFaPliNBGj1bKXc+8/wlMrTYJ3pCon?=
 =?us-ascii?Q?Vz+cBT99W5zcV0SFyUDsVz/7u5kU4wQgnnixZxJ0HXYPv+s9jG0qDaUGCjUA?=
 =?us-ascii?Q?YcDnYANbG7NBFJVYuie0xM/RQkiSMHaOLxRxpH4uxQSRIoWqYmtJ47a7rylk?=
 =?us-ascii?Q?hKf076l9sByQbjguuBEEYxLW4pe3XLBawkssYyjchdzusqoD9U50a332ZgPc?=
 =?us-ascii?Q?lAouOc3Q3YRTyHaQAh5g57TQANp6vZf3VhcqLjqeGdkWeOotYUpHXQ5eKmYT?=
 =?us-ascii?Q?9byddFN5s0V8NMfm9W9XnixEd31qw1dW9HXlIKF7EaWY0j7FvJE5JXQ1jp1/?=
 =?us-ascii?Q?nfkE1oiwXGAkytN4M/wt6zJICkMJZfmQGYNbzqQ49cnPOYoV9vN0X8SkFnQb?=
 =?us-ascii?Q?AkrUT30133SvUolr43mLJk9Gf5xX8HHdVgdd07Uk5iF4S52YxisWYTSBQnaj?=
 =?us-ascii?Q?Rf6izN91m4CYcJOLXBwDY4XW+DMQ5cdxyQyeGJlDfTw2NjD8EuuJMoSDCNRF?=
 =?us-ascii?Q?ZogsUVE2Q/bPrLvW8CiBh1Xi8C6gH7bLue2yMAp7P4fTFpypxs64XSd2Jf5X?=
 =?us-ascii?Q?0isuY3MFzeIAJPqt+8I02HP/7VMJv9sW0UNpr7B5nJNfapZqzmrAr6DgxihF?=
 =?us-ascii?Q?Jue+nfTNlNG+E7/In8Qnz72M6GzWEvP9k0ph2sUgLAFHyOip6lw+WE9k4PQo?=
 =?us-ascii?Q?kVVXhEbEybhRjaEhqMcLxfsBQwFL3GX+zyduuAF4a2trbsyDSYBonRNgkm7C?=
 =?us-ascii?Q?/JUKitAfFefdouoKjV0RrVGeJBt81dCST+2S5SJHxTZH5pbnaRJUGFN3RZHa?=
 =?us-ascii?Q?QoaKDNw0fdOLP5pGbJzVdEyvUdA/0u3tRumHZEU3ZsJbYooQfKpkFPIaY+rY?=
 =?us-ascii?Q?ug8ZIm93NI7IteKSO+uGYDjpP79rQrvlybQC3MbDES+FkvQeyQwWcor9KXYX?=
 =?us-ascii?Q?7tMSAWwc9AVv3YkUUIyQB7+VB8QInwmeHjcu9PIywGlldEIyZLPDNME0a2ze?=
 =?us-ascii?Q?usWfTnGgDbhe17IyInnb888qZR63Few1CLi9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:30:55.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7e2362-4695-4e5c-02f8-08dd47d7d9ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
apply to CXL devices. Recovery can not be used for CXL devices because of
potential corruption on what can be system memory. Also, current PCIe UCE
recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
does not begin at the RP/DSP but begins at the first downstream device.
This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
CXL recovery is needed because of the different handling requirements

Add a new function, cxl_do_recovery() using the following.

Add cxl_walk_bridge() to iterate the detected error's sub-topology.
cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
will begin iteration at the RP or DSP rather than beginning at the
first downstream device.

pci_walk_bridge() is candidate to possibly reuse cxl_walk_bridge() but
needs further investigation. This will be left for future improvement
to make the CXL and PCI handling paths more common.

Add cxl_report_error_detected() as an analog to report_error_detected().
It will call pci_driver::cxl_err_handlers for each iterated downstream
device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
indicating if there was a UCE error detected during handling.

cxl_do_recovery() uses the status from cxl_report_error_detected() to
determine how to proceed. Non-fatal CXL UCE errors will be treated as
fatal. If a UCE was present during handling then cxl_do_recovery()
will kernel panic.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 12 ++++++---
 drivers/pci/pci.h      |  3 +++
 drivers/pci/pcie/aer.c |  4 +++
 drivers/pci/pcie/err.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h    |  3 +++
 5 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a5c65f79db18..eda532f7440c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -661,10 +661,16 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK)) {
+		dev_err(cxl_dev, "%s():%d: CE Status is empty\n", __func__, __LINE__);
+		return;
 	}
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	if (is_cxl_memdev(cxl_dev))
+		trace_cxl_aer_correctable_error(to_cxl_memdev(cxl_dev), status);
+	else if (is_cxl_port(cxl_dev))
+		trace_cxl_port_aer_correctable_error(cxl_dev, pcie_dev, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..deb193b387af 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -722,6 +722,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
+/* CXL error reporting and handling */
+void cxl_do_recovery(struct pci_dev *dev);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 34ec0958afff..ee38db08d005 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1012,6 +1012,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 			err_handler->error_detected(dev, pci_channel_io_normal);
 		else if (info->severity == AER_FATAL)
 			err_handler->error_detected(dev, pci_channel_io_frozen);
+
+		cxl_do_recovery(dev);
 	}
 out:
 	device_unlock(&dev->dev);
@@ -1041,6 +1043,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 			pdrv->cxl_err_handler->cor_error_detected(dev);
 
 		pcie_clear_device_status(dev);
+	} else {
+		cxl_do_recovery(dev);
 	}
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..05f2d1ef4c36 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -24,6 +24,9 @@
 static pci_ers_result_t merge_result(enum pci_ers_result orig,
 				  enum pci_ers_result new)
 {
+	if (new == PCI_ERS_RESULT_PANIC)
+		return PCI_ERS_RESULT_PANIC;
+
 	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
 		return PCI_ERS_RESULT_NO_AER_DRIVER;
 
@@ -276,3 +279,58 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+
+static void cxl_walk_bridge(struct pci_dev *bridge,
+			    int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	if (cb(bridge, userdata))
+		return;
+
+	if (bridge->subordinate)
+		pci_walk_bus(bridge->subordinate, cb, userdata);
+}
+
+static int cxl_report_error_detected(struct pci_dev *dev, void *data)
+{
+	const struct cxl_error_handlers *cxl_err_handler;
+	pci_ers_result_t vote, *result = data;
+	struct pci_driver *pdrv;
+
+	device_lock(&dev->dev);
+	pdrv = dev->driver;
+	if (!pdrv || !pdrv->cxl_err_handler ||
+	    !pdrv->cxl_err_handler->error_detected)
+		goto out;
+
+	cxl_err_handler = pdrv->cxl_err_handler;
+	vote = cxl_err_handler->error_detected(dev);
+	*result = merge_result(*result, vote);
+out:
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+void cxl_do_recovery(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+
+	cxl_walk_bridge(dev, cxl_report_error_detected, &status);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_clear_fatal_status(dev);
+	}
+
+	pci_info(dev, "CXL uncorrectable error.\n");
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 82a0401c58d3..5b539b5bf0d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -864,6 +864,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic  */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1


