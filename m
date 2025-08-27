Return-Path: <linux-pci+bounces-34838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BCDB3773A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8787F7B617C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6CE224AED;
	Wed, 27 Aug 2025 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eZPInjl5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118B1F55FA;
	Wed, 27 Aug 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258786; cv=fail; b=mnmoAzSIUJgdPTNNwA+c+mUEcWqdIdVa0k1PFSHOwMR67/SCEmhnrgX8sdoF+oAFNvPGiEASqBVvqDcv6aoB/EY0Z556MAYdB+BC9GtBdIrRGZFEll9O1xPhKADUUyeP1w0uh9b6brq4+dLj9pBPWMWNj2J95ef9c8bIX+3QPYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258786; c=relaxed/simple;
	bh=J+46zlemN7UVweNVMYehfJrgIZvh8mXlboIULFcbnyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+B2fppQk5GYQ8mEF7Wa025qLdD9pZI4J5aUir7h+2MpG6vOWbsEag6gfgpCS2oFjx1hNnNz5oDhRlR4nzW019jMPCqhjyAUdI0eG+BS7+fSteK+oF/W999/WWKhNPGlbUrQfRa0E0vqKp2TS85vtCYzn2M3SEBkiS1pRQDCwR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eZPInjl5; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NESgEcpTuztVFjGm2K6WCZHZRqfOuUf2L2UsVlGPP8pfsKTCtD6z/ZPNVGVdNJLahYtTnEkhTA3HmZhlRUuYJ8kW0/qt44CojJc3O0gxbyoWb+jawQjWUIWCJmGNvQJLYLtGLoXBDuVjxXRqV+V2c73cckcXBu4etKF4NK2YBCx/wEnF1mDc4pkNUwP7dsXpXw/7qZxdgvhYx9GAWGm2HAIFPIhLq8gfc7FbHzoA+JbMLAg+KpiCTWzYJQThJ8o8WLpVZ+W1vAJwhNYQl9lUsdt+dtbVRV/BoNR//iXwYb4WdyFdA3bSP2IMviCIE4MaW0DbEPVozHZo9gYSwZjgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnZXQ1t/x7vXLnn1EoVOkCjQCCOsZL7EnbledwKYfFU=;
 b=EBHAXf2JaKxvvxXfL19OkaLmI1vLXFjee0dDWuztlXYgI0laYIaRQtaN1ATfR3CmsS37T4t09y74ulZyU/8P/XtxqGHbEv1is8FfqDO73T8yZuclCcUsUb2liiy0vSGUjqt/mESKLo8tCfF4RQwjA+5ScBPV1GFSbK76+4mmd8dUcV6v5DEGa7kie/Ev9khvJNncStk/uQF/MB1gU+SEEfdPtBdnILyXhO8Kt7W3MkC7vBGL/I7I9S38WB1ArC/ATIEc5CNp4BQKaXTqnutytgT45uXlFrzNLsIQ+QbhQqY+0HWfm5VQGYjWKA8IVcNVs66S9NdAldV3Ap5Rgg0shw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnZXQ1t/x7vXLnn1EoVOkCjQCCOsZL7EnbledwKYfFU=;
 b=eZPInjl5UFdCAIQkiXpV+kBBst80nRCr3rc45kdvMOCRTdL5o6xw00xtvlTFymGyEIx6hRCuReDUmOvWQ4PV9XNwJzt0N0UVQcmdYzkBeo1OvaIJwxJmPMXr/kqSJe3fTy9PK3LOk87sV2Eyf4CF/LIX4LAiRVKSbFrkaAKB+LM=
Received: from BY3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:254::12)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.17; Wed, 27 Aug 2025 01:39:40 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::ef) by BY3PR05CA0007.outlook.office365.com
 (2603:10b6:a03:254::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Wed,
 27 Aug 2025 01:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:39:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:39:38 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 21/23] CXL/PCI: Introduce CXL uncorrectable protocol error recovery
Date: Tue, 26 Aug 2025 20:35:36 -0500
Message-ID: <20250827013539.903682-22-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 402f9bd8-80eb-4946-8345-08dde50a96af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sgKV+/O4RooIFWJjAyC4rU3kYAEHI0PgTZJaXmxPq5WRtl1K0Of5ITtBPiTX?=
 =?us-ascii?Q?Fk9EJaD20nwrxEjEOXv+FNrlmFncCQu9x5XEhKHiOgo2epYkgdszybTm6aot?=
 =?us-ascii?Q?3ymhyaowl7+m9p23CcxUoTdjRLe70umkSIW0unSVEmHbqMP+yL226YGnqOuj?=
 =?us-ascii?Q?LfnTdyHBYESwlfO5u1Y6amPuOnZYqk+DqfSsksKJEAG7G3/gJ15dlqwwpcL8?=
 =?us-ascii?Q?b4rnySBSfRcfb0Sp4ZiWsp+UKBwxcxwrQChflKinaMQTb8Zu93EN9I8yZa/+?=
 =?us-ascii?Q?nDNr8AczBhTYW3tO0FKwePow/mdEOG+jYp5uTW/3TsAM6PxWY9pDW/H9Hh+8?=
 =?us-ascii?Q?yNafsPCuSi2J5Nn3aXUpfZVj5CzFYu1jjBd+fYxNcPzlmCavKZWk4SWaZvBs?=
 =?us-ascii?Q?2Iie/A73BCVcTkpj11xgUPXKhInFLDRoxfvoqnDShejD5Jwe6IuALtEX2Ql7?=
 =?us-ascii?Q?LoiNFU2ijRTWVxdLH8V21fGyf7HzKJ/bE80XJXlw2xPjBB3S6wJUU0vtx4TI?=
 =?us-ascii?Q?QztC6Cq4yBAf8BC5/18oS/pFPZ/h9l/jqyvAZK4cZ1Ata/tYO/6JzcmBQrCX?=
 =?us-ascii?Q?97UYh0s/jc/9MiFsR9I7DCs3JwldglJQSXfIZ6yI0rhjGvHj3QeuRmcrkIr5?=
 =?us-ascii?Q?MPGcUc9cnuSp1bSB0AZ09ejN8wNtgDofH4tzEzhgJnZfAyXbhKd2L8K7611m?=
 =?us-ascii?Q?vFq3dkfzy+jI2hEU1127V7YOkLh6mHMkqlqz6ABK8MSeUbxoZX2dUHmcRRq9?=
 =?us-ascii?Q?Z+++xY0Rx7Jdesc/IN/hML6vp+EvoPHTuY8slT/mefiP8NuRaiqO2ylMUhCd?=
 =?us-ascii?Q?EouPlX6pmr/umdN6HydLAOqe5l5L4LWnJoGdNCpz9SLsnRwgFwHWwhLzqrEe?=
 =?us-ascii?Q?p1zVnCFam4cC53Ew6niPdRg1gWUjuYGU17L7qfYFSxCY+BdTI98x32X29cJF?=
 =?us-ascii?Q?vNNmTgDaw+WfjGy/MPdrf/vR0muZyq19DBhxbjyxJ1ea9IqlojbOgFY7YKlc?=
 =?us-ascii?Q?gKgo6N1SulqGMwsjAorUQKXy995XT5OA2OFuKm+lNJXqNa0O7Qrs6uDPqy9E?=
 =?us-ascii?Q?VxJ/v8W/UOPrTdvFXpHXI4+o0XTw8k5kCi2H2bKLIn/mU+TryGwx6tkxlni9?=
 =?us-ascii?Q?AcprLzBmajDplYojqlc9658G8LNUYoZzf1bM36j7FAmQgmXbQuM/Tt2d0iwx?=
 =?us-ascii?Q?hKK6a0W5LlAnRU9FEk0hKx6lJbUEV5lTWaqvdI3m4iGFNkJvfkhl/K0kHT34?=
 =?us-ascii?Q?iFOarOyJpu9jM7Cn/NgcfksGP80qdKobZgQLCgrfE2V7uuYKiGsaQXBfEqLh?=
 =?us-ascii?Q?GK4Al6hYDd0J8zO1BAuHCxSUPfBZeuFpLXNevcG9W4Q82iHQOzEa0bjkr8LM?=
 =?us-ascii?Q?pXqMytffHHKhPmwwOlcgN0sorLxmKsLPeo65P7bZsGQMbNbYQWzVpK82kx0D?=
 =?us-ascii?Q?AdZfhPYXiOuCb3p0mx4CmViON00Yb4bphLUaaQzHy3Pa18q6oHHC0dqusUre?=
 =?us-ascii?Q?bYqNnC77p3oeafc/KoKjTtXG83PyELdEdYMkORAEYOpLFX3ZrLTJfX7KuQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:39:39.5647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402f9bd8-80eb-4946-8345-08dde50a96af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
handling. Follow similar design as found in PCIe error driver,
pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
as fatal with a kernel panic. This is to prevent corruption on CXL memory.

Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
CXL ports instead. This will iterate through the CXL topology from the
erroring device through the downstream CXL Ports and Endpoints.

Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---
Changes in v10->v11:
- pci_ers_merge_results() - Move to earlier patch
---
 drivers/cxl/core/port.c |  1 +
 drivers/cxl/core/ras.c  | 94 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h       |  2 -
 include/linux/aer.h     |  2 +
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 758fb73374c1..085c8620a797 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1347,6 +1347,7 @@ struct cxl_port *find_cxl_port(struct device *dport_dev,
 	port = __find_cxl_port(&ctx);
 	return port;
 }
+EXPORT_SYMBOL_NS_GPL(find_cxl_port, "CXL");
 
 static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
 					 struct device *dport_dev,
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 536ca9c815ce..3da675f72616 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -6,6 +6,7 @@
 #include <cxl/event.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
+#include <cxl.h>
 #include "trace.h"
 
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
@@ -468,8 +469,101 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
 
+static int cxl_report_error_detected(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	pci_ers_result_t vote, *result = data;
+
+	guard(device)(dev);
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
+		vote = cxl_error_detected(dev);
+	else
+		vote = cxl_port_error_detected(dev);
+
+	vote = cxl_error_detected(dev);
+	*result = pci_ers_merge_result(*result, vote);
+
+	return 0;
+}
+
+static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
+{
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return port->parent_dport->dport_dev == dport_dev;
+}
+
+static void cxl_walk_port(struct device *port_dev,
+			  int (*cb)(struct device *, void *),
+			  void *userdata)
+{
+	struct cxl_dport *dport = NULL;
+	struct cxl_port *port;
+	unsigned long index;
+
+	if (!port_dev)
+		return;
+
+	port = to_cxl_port(port_dev);
+	if (port->uport_dev && dev_is_pci(port->uport_dev))
+		cb(port->uport_dev, userdata);
+
+	xa_for_each(&port->dports, index, dport)
+	{
+		struct device *child_port_dev __free(put_device) =
+			bus_find_device(&cxl_bus_type, &port->dev, dport,
+					match_port_by_parent_dport);
+
+		cb(dport->dport_dev, userdata);
+
+		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
+	}
+
+	if (is_cxl_endpoint(port))
+		cb(port->uport_dev->parent, userdata);
+}
+
 static void cxl_do_recovery(struct device *dev)
 {
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		port = find_cxl_port(&pdev->dev, &dport);
+	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
+		struct device *port_dev = bus_find_device(&cxl_bus_type, NULL,
+							  &pdev->dev, match_uport);
+		port = to_cxl_port(port_dev);
+	}
+
+	if (!port)
+		return;
+
+	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (cxl_error_is_native(pdev)) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
+	put_device(&port->dev);
 }
 
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 69ff7c2d214f..0c4f73dd645f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1170,13 +1170,11 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
 
 #ifdef CONFIG_CXL_RAS
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
-bool cxl_error_is_native(struct pci_dev *dev);
 bool is_internal_error(struct aer_err_info *info);
 bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
 void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 #else
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
-static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
 static inline bool is_internal_error(struct aer_err_info *info) { return false; }
 static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
 static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 1f79f0be4bf7..751a026fea73 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -81,10 +81,12 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
 void cxl_register_proto_err_work(struct work_struct *work);
 void cxl_unregister_proto_err_work(void);
+bool cxl_error_is_native(struct pci_dev *dev);
 #else
 static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
 static inline void cxl_register_proto_err_work(struct work_struct *work) { }
 static inline void cxl_unregister_proto_err_work(void) { }
+static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.51.0.rc2.21.ge5ab6b3e5a


