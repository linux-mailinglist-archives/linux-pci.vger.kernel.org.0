Return-Path: <linux-pci+bounces-15358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A789B115F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC30B24CCD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352521313F;
	Fri, 25 Oct 2024 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S8Obw/6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB151B21B1;
	Fri, 25 Oct 2024 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890275; cv=fail; b=YJkYOfELeLDhdOfS3pGkUAgQffWdUrbM9r2Rnh+Ie+KBiGlCYlgPSdX5HafTRtcm2r8XwcsLBq6J6H1BsxQ6M+9v17aXevpklVQdazP36IZ4i3EQxll2rzMMggwsAK3JHuk98iq5eQnsK01d3mKP086hLMEsYRzX/2f4ZHOoG5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890275; c=relaxed/simple;
	bh=Tei5V3LCgaZI2dNZaxk+p8W2HRQ7GNyUgiwrbkygGbI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbPKA3Jmh8v0d8PNBg46Dx4EScBCSDCFFk4O97qXtV+z8U6C95BnU8jPcrXe6AR+PsqSoQrr0x0d+0OloH/tY3gDKKdfG3h8Xqr9YnkOmUax9cpYfb7bNEMUqLNC2vGe4izKyVS5keBxJVAPpyPQeWPSFnorGSENqpSldmLLY8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S8Obw/6W; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsXcHDeatgVyQTHaHNbaaUlOnrlgxGxc8SmmoSYRM22ANxIo+fR9UkmsMNFS4Pw/y7rj7hU8bvYy3rsKP1XmhunOm4JsbvNDd2AfJetRZ/UbPqk8G6ZV81SsLUfcKWOMc318KKq9wE9kN6S4nSJ7owDvJjxdtkGXSqv7ljN9zt+/j7YayRXxJxr2H7fKGd4ZJMOuPPWMD/feL6Fw4w0MDSU2v4hzu2r522bNa+zeiqn/aFkWXIjDlrWjVR1wvTm8zFzTOw507qHym3m2jUapz78pUQmO4+T6ekC21Mu4LFydmYCOdDBOq0hm/789JB0CTZGNuYi9IHZTlKExt28gyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efNNfyFyX9vuQVwQ0Zt//7YkM1yqocs5wuQfewqjA6I=;
 b=lDr7Q05GVP/WOxQhJLZuq2QmUUeXCvQgdK462pZ3YQBd5aJRHcN+Z7+A0DmeeEmZGkoQC+aTqaQk8sT+OdjKXsBrYIKf7c9rl+aexlM3ALsMLCHnIEKhJozF9TP2+160dNBpI1N9zKlopPbFGhHTMOVGsokxb4YzqvWuNzezqCRpZsBlv43uIko9BGZQ0WXIoUbvhfCCYOVo1NIj1KgO5CkwhZNOUsqlN0Bswgj260AD7d7bv+nbNWa7IMyOzAWODMf2R2+SJMmjaP3I8VQYyd3txZQNQu49jkksEOdc3UffGh8Ab5KZxMSKzY8ZzE2IxdpWE4h8Fviw1oHSYyHQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efNNfyFyX9vuQVwQ0Zt//7YkM1yqocs5wuQfewqjA6I=;
 b=S8Obw/6WIz9NG0hBTzztWf/nmmv8VsSM4rs7tHf0aG+iUxMWres68lEEyEV5t1rke7+YMkHOokH9KFuwnluj4XG/gEHLUImfoqBD7SF7MhQLyIK1/+IA9q6mEXYztHqFI/eUh6LKEW+U7J9WsEmSFASdrRBKT3ZJe6SaElITUns=
Received: from MW4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:303:b6::32)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 21:04:29 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::ea) by MW4PR03CA0087.outlook.office365.com
 (2603:10b6:303:b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 21:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:04:28 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:04:27 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 07/14] PCI/AER: Add CXL PCIe port uncorrectable error recovery in AER service driver
Date: Fri, 25 Oct 2024 16:02:58 -0500
Message-ID: <20241025210305.27499-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: c66c381b-a2a5-428e-108c-08dcf5389d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZDOphukiMYcV4Ip3OrLGGMw/zrdSeVNsb4oaBw77EqlTbz4pvu4hljKhnBl7?=
 =?us-ascii?Q?CiSOeoS30NUU0Wf8VMe9iQHKOoIqJcrKrzWEoQUWZQ5l1gykKJF38g25Ljnc?=
 =?us-ascii?Q?RXwV+2npNWFcM7RXj98NcB6uwqT6FkyduxKjENt+3MklUqFMJCaeTauFsDuM?=
 =?us-ascii?Q?cSovq+japMBCUSzQwBbxiCt2Jqisdp3b7ZcvVqR2MM68yd/N28CZUphYFdxv?=
 =?us-ascii?Q?w2HZY3Hsg8yGg3qlUhLe352cXL3OKt7SsPpyC+vnLCMOYIuBoiYE6urV57gn?=
 =?us-ascii?Q?BXRSkeGl+V83/h1e0t+jeOuLKLVh1xYJdpqjoK9xSB2jHGLA8/6GoFsQEpxD?=
 =?us-ascii?Q?0lTlVHKhi3SXT0byWADxaaBGN828L2jP9dzL1/T+RkIkdxB9oV31HKWvfavN?=
 =?us-ascii?Q?SehcguxiBouPD+o5DDstLqw+VZUcst3hyYBmQDv9OB2FWjMPLuTtDMNYH1/a?=
 =?us-ascii?Q?k11pUeiGUifv1hYN8tFcmCAlXxIOpEg4xX87RLoxUgIIkJN1s+OFt4ocjhFm?=
 =?us-ascii?Q?Q+U2dRERiNqmKeyyzr9jwxE5G7LBw8Z5fRAOCiCDj8lcd/gO82lufobjO+Fr?=
 =?us-ascii?Q?fj6KT5d3DdS6GVQJcQw2qOMmltpSFJc1Gbpy6u9WVnQNBw7q4P8SI6zB1whb?=
 =?us-ascii?Q?HIsj3ErjH4ysXPL4baHzlb49ytsg7OhMaKcxLe6t5SZ64nCvvjrbT59PA/cs?=
 =?us-ascii?Q?0VutHFJ45BRiUFsbmycWOrxWeXvOninmfORfMpNdFZQowo1pOW3MyFsC//PR?=
 =?us-ascii?Q?+6nA/1rl1xpuniIVTssXcQ8lPvjum6gpymjUXIFeR3gkknOkUPxmwzTzO69/?=
 =?us-ascii?Q?M0OTuFr4b/o8qM6UJ1dyJS4Ic5XaJzK0/kSpJO4YaF8Np/kgWNQO9Bt9J+03?=
 =?us-ascii?Q?xDx+GX29v1sX540U4IMqtfSKdsKirplSm1a/NmXzl3x62fYPtvpEV1IdV2Oa?=
 =?us-ascii?Q?uOOJ7Ppo07DHghdWwnykZqtU/Rsn/OUVymiJDvfft5D0fEQ1DNgP6B42VLiD?=
 =?us-ascii?Q?1Du8i1w6SLNmQxID/2xtEV6kr/KvJQTj1k6jCKX0+bz4oSArjQsCNhQWJKVa?=
 =?us-ascii?Q?wigP+n44k3NlPd9w3w8fE5Y/dgTHHEmR5FopdDccIIaWZrJBnEW3PTsuMIEt?=
 =?us-ascii?Q?k470mCxeS+QOakLPW8T8zMKgDip30b5pLypYjHAfzUjIH8bxtPVwv/cWCMtA?=
 =?us-ascii?Q?3/3q+20nzx0CYOdaYua4tAGEnhuQN8m9S98y0X2Perrzg4Kcz58ZgalR5gj0?=
 =?us-ascii?Q?yPNHk/zJmBourqMFrDHJafJClx5vqoQIAhJfcn2OZ0FJ7BE3pCLZm1RbencH?=
 =?us-ascii?Q?4x1F4xcbIzZB7+7N+zRe7SqAGbQRrCDnaMJAEo9jO/jvSghuHDbMoIY8JOhH?=
 =?us-ascii?Q?7ea0ZN3EuNZ+5R64IYRVJO2Ohg/3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:04:28.8935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66c381b-a2a5-428e-108c-08dcf5389d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
apply to CXL devices. Recovery can not be used for CXL devices because of
the potential for corruption on what can be system memory. Also, current
PCIe UCE recovery does not begin at the bridge but begins at the bridge's
first downstream device. This will miss handling CXL protocol errors in a
CXL root port. A separate CXL recovery is needed because of the different
handling requirements

Add a new function, cxl_do_recovery() using the following.

Add cxl_walk_bridge() to iterate the detected error's sub-topology.
cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
will begin iteration at the bridge rather than beginning at the
bridge's first downstream child.

Add cxl_report_error_detected() as an analog to report_error_detected().
It will call pci_driver::cxl_err_handlers for each iterated downstream
child. The pci_driver::cxl_err_handlers UCE handler returns a boolean
indicating if there was a UCE error detected during handling.

cxl_do_recovery() uses the status from cxl_report_error_detected() to
determine how to proceed. Non-fatal CXL UCE errors will be treated as
fatal. If a UCE was present during handling then cxl_do_recovery()
will kernel panic.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pci.h      |  3 +++
 drivers/pci/pcie/aer.c |  5 +++-
 drivers/pci/pcie/err.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..5a67e41919d8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -658,6 +658,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
+/* CXL error reporting and handling */
+void cxl_do_recovery(struct pci_dev *dev);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d772f123c6a2..19432ab2cfb6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1048,7 +1048,10 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 			pdrv->cxl_err_handler->cor_error_detected(dev);
 
 		pcie_clear_device_status(dev);
-	}
+	} else if (info->severity == AER_NONFATAL)
+		cxl_do_recovery(dev);
+	else if (info->severity == AER_FATAL)
+		cxl_do_recovery(dev);
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..3785f4ca5103 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -276,3 +276,57 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+
+static void cxl_walk_bridge(struct pci_dev *bridge,
+			    int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	bool *status = userdata;
+
+	cb(bridge, status);
+	if (bridge->subordinate && !*status)
+		pci_walk_bus(bridge->subordinate, cb, status);
+}
+
+static int cxl_report_error_detected(struct pci_dev *dev, void *data)
+{
+	struct pci_driver *pdrv = dev->driver;
+	bool *status = data;
+
+	device_lock(&dev->dev);
+	if (pdrv && pdrv->cxl_err_handler &&
+	    pdrv->cxl_err_handler->error_detected) {
+		const struct cxl_error_handlers *cxl_err_handler =
+			pdrv->cxl_err_handler;
+		*status |= cxl_err_handler->error_detected(dev);
+	}
+	device_unlock(&dev->dev);
+	return *status;
+}
+
+void cxl_do_recovery(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int type = pci_pcie_type(dev);
+	struct pci_dev *bridge;
+	int status;
+
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_UPSTREAM ||
+	    type == PCI_EXP_TYPE_ENDPOINT)
+		bridge = dev;
+	else
+		bridge = pci_upstream_bridge(dev);
+
+	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
+	if (status)
+		panic("CXL cachemem error. Invoking panic");
+
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
+	}
+
+	pci_info(bridge, "No uncorrectable error found. Continuing.\n");
+}
-- 
2.34.1


