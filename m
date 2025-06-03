Return-Path: <linux-pci+bounces-28889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF57ACCBF0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1993016ABFB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C71D6DB5;
	Tue,  3 Jun 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3mmazKF9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333071D5173;
	Tue,  3 Jun 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971407; cv=fail; b=FnKs3lm0yvvdcr8LAz6PxgczdOv4u6nh9rEb/Sj2soM4eGVxPtuOvyUDaj3temxl8S3f8NQ2X3Kg0wbNw/xv8WJjIoqmlZ74kii+Yux1fFsL0aVBkjDqk4F+unFdSo99+pKh1hD9+CQUey0EGt7CadyFcdInL3Nu7t8CiVshV6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971407; c=relaxed/simple;
	bh=tUNA0DREN4WBXkwsWhP1tX9Pi7IYZRjmuO1zin9vMbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPbRlxF6zwuFzCRyARVLaqo58n6oP3cnljhzK1baacnpDQCozYUOxhoZkihZSHdY3f+w4MB1ik6fD3H7WpKPpip694UGDCcPGtEHEp1tVTrYwJlSxb41FOiBH19h74sIKfzoI09D79DEWv2dsXOi+e8YxsW13oQn/umK71wZ+JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3mmazKF9; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCl6jXfZQlrhvuxsXQ+JjzwkDPdWuwk34Luejbnkb9qzKmm+v4NLD3VG0M8B3sfcNHZWXxkqb8gL7MIPfJB9mLF0+aL1papFxqCXkHPU3OteXMzZMO0YET1hHJoXjU2lHMAPAUHVsMQDrR9NYRo5gof79U7Lqo1lbRTM1pIsdYMS/Pt+1aO3j3S/+nNP0tYWIk8tWPFsByjiRERdmDtpmPWfSPPzJyNGDFtw1cH5thWlxI18hduFQqN6RAVDUQCrhJHZk89zDHyVI+C3GvcZs2+MPBfWuhLP/OJjE1XaI7hVrkABHfWnZJMAxiqlEs/lOt/tTrJncuOwVZx3ZCWIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQa4cM1S/anb8AtJnt0hyjzf46Ann7bQOLhvozVzTAA=;
 b=P5vtfa6v/CzX9/Uu/194WIgFbwqo1A8lZxLZRHGIX6BQq8W/K6RKqHNN0RBLkbVvxQx39rIK2iQdhVmPaGnaqJ47TqKy0wsaxTs3gGOnhVlqWGXgZPXJ5rnDRJ+8fP2KEkZXztavErjTItEdNAUYSEbkF3beM5B1eaTQqJXscCd2s5pljiCxGnTmvGt759hARrA3ly3ijr2rZrPDLINeekqHgCDw8mL9cac+ZvHnnTWFzeg9R7qxIeNYwv0S0JAXgYigIIfK/45fFoAt8Pr/JzL0UYhzzDkc9EnPhZ8Du+pVPuV+AkDmafa00julx6HwGVzTUl5ovBiYxbkJIGBhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQa4cM1S/anb8AtJnt0hyjzf46Ann7bQOLhvozVzTAA=;
 b=3mmazKF9MOKppqFT6bU5HCM5gfHvcXIBDniu7Yc/vp73WL712yf7ocXxDOBHng8QFv8gtkraSXvLz1X+kbbcJDoJGmVdUvWE7zbVt1XniEk7FYh8RkfqEopcv8AVPm71JYqHX3A0v51IgfQtVVJqa6AiXxzKPeSniAbLwFzteVw=
Received: from BL0PR02CA0122.namprd02.prod.outlook.com (2603:10b6:208:35::27)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 3 Jun
 2025 17:23:20 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::1d) by BL0PR02CA0122.outlook.office365.com
 (2603:10b6:208:35::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 17:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:23:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:23:18 -0500
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
Subject: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL errors
Date: Tue, 3 Jun 2025 12:22:26 -0500
Message-ID: <20250603172239.159260-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f586c5-7c81-4630-4a2f-08dda2c355bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/AF/cJ6sH3MI8Ab1WW0/9cH3BEeIOrV7qYuDGIFd2sF2IWr6wyHwRGRMTFr?=
 =?us-ascii?Q?Gk2JJXIdOdZu9WrhzU50kH20XADnHWJBH3qWLaII4dBDLWODynniSoX4gD7E?=
 =?us-ascii?Q?o6lLcVDdYGq+BlSXhJokQurM2wvSv1v/BQOVtVwTaW5xx/s00uT7ta+YhroY?=
 =?us-ascii?Q?wmiUhk1kcbskc8DG95sm2iETcgqLm+RtrJbDfAUiH6vrIjv7lpNolx6ez0GW?=
 =?us-ascii?Q?K1CCuMldZEy/n4PhmAVJD0mhfnTYN/Rd+2oIiw1pAHWGvsBriPN91sOsooeW?=
 =?us-ascii?Q?IvXROFFe9nfEEuskZcIfcjLvb4QThyU9JmEswuQApBrMrmdE9I5KvPzX7Bb7?=
 =?us-ascii?Q?lJ/2xrpleTEd7fxhSyaGwhueLIaTrBNm/BaDTa3Lm5v9KbBNoyYpCLtxz1ob?=
 =?us-ascii?Q?rFNMc9DQSfFxPWnGHWQg4UFbMLxK8qwm/TS6ZgnkVTyEgki9l+3KgvRaCQrB?=
 =?us-ascii?Q?nM4XT55iPrequiZLWJDGtY+tisNzESxXrM6EojATiGLwuYCyhULwwwnWuUZn?=
 =?us-ascii?Q?lXsQqkMG4mISEkoJP/iwrQZgqKkb8Gvy6OPHhR/64wz7JhMnwxijS0D7cuZu?=
 =?us-ascii?Q?CDW8LqfBkNNxgyImdeb29RDKC/Pu5H+2RHg61BfZFUnol7LUKUVQmT/oaL77?=
 =?us-ascii?Q?p18rVV1Zk2ujMHU1rF2nYwHMKypl0QlcW2AYxoTPb74IiFNp0XJp1nzAlFvT?=
 =?us-ascii?Q?8c587PR9Za3h7wFTF+swPe8DhQezGBoZQGdVgf8GlLVrvd4OqKtQ+UxouGl8?=
 =?us-ascii?Q?ofaYExPOZr/KxIvkDdAJCNDGcelj/wgBECT1q1V95AGOR57INRoG4N6CfGQo?=
 =?us-ascii?Q?mqSuLkbK5D3qOdJ88RNIwRIMglp/Y6Z7q67rHbo6M/wDGMiXVI8scBlB7oMu?=
 =?us-ascii?Q?wLHwvbquthOH1n41qpmyCVljads2f2KpTvF+guNExXZvFjUM4xFlW8lGOa17?=
 =?us-ascii?Q?Wk1GJvxOvsEktIHosb+CZbnS5tSMA4YT35A7QsNWvvmoZ5YYEDDMGoYpNJjU?=
 =?us-ascii?Q?Gb9vAu0X3mk0cDq3Q56riuxFO91SJ9xjo9wwyJFbB2hB/xD+Nx8iUiYDs8Lv?=
 =?us-ascii?Q?X17FDUCM+KpnTV8SACaEnwd7NeOO8X/zwfjPzdpPuq3ucHuUQwRpjl37fj+C?=
 =?us-ascii?Q?HW4gemH3c8kEvfzewmoXmLf0zavcXFVx77tPYAAdzoBUgIBbj7JS+oiKKODf?=
 =?us-ascii?Q?E2Fvge9DNL3eug4stTjlRQooggavbrSadYJpZIZUQVVO4LpS+rT/PR9kVRzj?=
 =?us-ascii?Q?1Fa1e6E5G+Lku63WivQC6UEU+XwvtAYE9vfCy4smFXvicWvJeWE6gaTXe9yw?=
 =?us-ascii?Q?6j5fOLYFU8hHiagdDERmeR5iD+uqjQbf67KM32Oau2t2Wq/WN9A3kpeUGnw3?=
 =?us-ascii?Q?dd0YEJ1+4ezh+YMus9NZ2xhpEGYW1VGTmK7zfyngS6W7XvXD+5HCLS9l6lA7?=
 =?us-ascii?Q?XsuGVNaTTzGKROa6VTGJCv+4SNOalyXymmuA700SHQG6mNYR4icJBdwCrzxi?=
 =?us-ascii?Q?vg1bvtDuazQhL8h1/IrTSjKKivhFr7HWh2j1JJOCgDZsu7V6GZ7oeKsq1Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:23:19.6819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f586c5-7c81-4630-4a2f-08dda2c355bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

CXL error handling will soon be moved from the AER driver into the CXL
driver. This requires a notification mechanism for the AER driver to share
the AER interrupt with the CXL driver. The notification will be used
as an indication for the CXL drivers to handle and log the CXL RAS errors.

Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
driver will be the sole kfifo producer adding work and the cxl_core will be
the sole kfifo consumer removing work. Add the boilerplate kfifo support.

Add CXL work queue handler registration functions in the AER driver. Export
the functions allowing CXL driver to access. Implement registration
functions for the CXL driver to assign or clear the work handler function.

Introduce function cxl_create_prot_err_info() and 'struct cxl_prot_err_info'.
Implement cxl_create_prot_err_info() to populate a 'struct cxl_prot_err_info'
instance with the AER severity and the erring device's PCI SBDF. The SBDF
details will be used to rediscover the erring device after the CXL driver
dequeues the kfifo work. The device rediscovery will be introduced along
with the CXL handling in future patches.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/ras.c |  31 +++++++++-
 drivers/cxl/cxlpci.h   |   1 +
 drivers/pci/pcie/aer.c | 132 ++++++++++++++++++++++++++++-------------
 include/linux/aer.h    |  36 +++++++++++
 4 files changed, 157 insertions(+), 43 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 485a831695c7..d35525e79e04 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -5,6 +5,7 @@
 #include <linux/aer.h>
 #include <cxl/event.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include "trace.h"
 
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
@@ -107,13 +108,41 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static void cxl_prot_err_work_fn(struct work_struct *work)
+{
+}
+
+#else
+static void cxl_prot_err_work_fn(struct work_struct *work) { }
+#endif /* CONFIG_PCIEAER_CXL */
+
+static struct work_struct cxl_prot_err_work;
+static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
+
 int cxl_ras_init(void)
 {
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	int rc;
+
+	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	if (rc)
+		pr_err("Failed to register CPER AER kfifo (%x)", rc);
+
+	rc = cxl_register_prot_err_work(&cxl_prot_err_work);
+	if (rc) {
+		pr_err("Failed to register native AER kfifo (%x)", rc);
+		return rc;
+	}
+
+	return 0;
 }
 
 void cxl_ras_exit(void)
 {
 	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
 	cancel_work_sync(&cxl_cper_prot_err_work);
+
+	cxl_unregister_prot_err_work();
+	cancel_work_sync(&cxl_prot_err_work);
 }
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..6f1396ef7b77 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -4,6 +4,7 @@
 #define __CXL_PCI_H__
 #include <linux/pci.h>
 #include "cxl.h"
+#include "linux/aer.h"
 
 #define CXL_MEMORY_PROGIF	0x10
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index adb4b1123b9b..5350fa5be784 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -114,6 +114,14 @@ struct aer_stats {
 static int pcie_aer_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
+#if defined(CONFIG_PCIEAER_CXL)
+#define CXL_ERROR_SOURCES_MAX          128
+static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
+		    CXL_ERROR_SOURCES_MAX);
+static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
+struct work_struct *cxl_prot_err_work;
+#endif
+
 void pci_no_aer(void)
 {
 	pcie_aer_disable = 1;
@@ -1004,45 +1012,17 @@ static bool is_internal_error(struct aer_err_info *info)
 	return info->status & PCI_ERR_UNC_INTN;
 }
 
-static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
+static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 {
-	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
+	if (!info || !info->is_cxl)
+		return false;
 
-	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
-		return 0;
+	/* Only CXL Endpoints are currently supported */
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
+		return false;
 
-	/* Protect dev->driver */
-	device_lock(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		goto out;
-
-	if (info->severity == AER_CORRECTABLE) {
-		if (err_handler->cor_error_detected)
-			err_handler->cor_error_detected(dev);
-	} else if (err_handler->error_detected) {
-		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
-		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
-	}
-out:
-	device_unlock(&dev->dev);
-	return 0;
-}
-
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
-{
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+	return is_internal_error(info);
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
@@ -1056,13 +1036,17 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 	return *handles_cxl;
 }
 
-static bool handles_cxl_errors(struct pci_dev *rcec)
+static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
+	else
+		handles_cxl = pcie_is_cxl(dev);
 
 	return handles_cxl;
 }
@@ -1076,10 +1060,46 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
 	pci_info(rcec, "CXL: Internal errors unmasked");
 }
 
+static int cxl_create_prot_error_info(struct pci_dev *pdev,
+				      struct aer_err_info *aer_err_info,
+				      struct cxl_prot_error_info *cxl_err_info)
+{
+	cxl_err_info->severity = aer_err_info->severity;
+
+	cxl_err_info->function = PCI_FUNC(pdev->devfn);
+	cxl_err_info->device = PCI_SLOT(pdev->devfn);
+	cxl_err_info->bus = pdev->bus->number;
+	cxl_err_info->segment = pci_domain_nr(pdev->bus);
+
+	return 0;
+}
+
+static void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
+{
+	struct cxl_prot_err_work_data wd;
+	struct cxl_prot_error_info *cxl_err_info = &wd.err_info;
+
+	cxl_create_prot_error_info(pdev, aer_err_info, cxl_err_info);
+
+	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
+		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_prot_err_work);
+}
+
 #else
 static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
 static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
+static inline void forward_cxl_error(struct pci_dev *dev,
+				    struct aer_err_info *info) { }
+static inline bool handles_cxl_errors(struct pci_dev *dev)
+{
+	return false;
+}
+static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return 0; };
 #endif
 
 /**
@@ -1117,8 +1137,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_cxl_error(dev, info))
+		forward_cxl_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
@@ -1582,6 +1605,31 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
+#if defined(CONFIG_PCIEAER_CXL)
+
+int cxl_register_prot_err_work(struct work_struct *work)
+{
+	guard(spinlock)(&cxl_prot_err_fifo_lock);
+	cxl_prot_err_work = work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
+
+int cxl_unregister_prot_err_work(void)
+{
+	guard(spinlock)(&cxl_prot_err_fifo_lock);
+	cxl_prot_err_work = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
+
+int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
+{
+	return kfifo_get(&cxl_prot_err_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
+#endif
+
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
 	.port_type	= PCIE_ANY_PORT,
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 02940be66324..550407240ab5 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -10,6 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/workqueue_types.h>
 
 #define AER_NONFATAL			0
 #define AER_FATAL			1
@@ -53,6 +54,27 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+/**
+ * struct cxl_prot_err_info - Error information used in CXL error handling
+ * @severity: AER severity
+ * @function: Device's PCI function
+ * @device: Device's PCI device
+ * @bus: Device's PCI bus
+ * @segment: Device's PCI segment
+ */
+struct cxl_prot_error_info {
+	int severity;
+
+	u8 function;
+	u8 device;
+	u8 bus;
+	u16 segment;
+};
+
+struct cxl_prot_err_work_data {
+	struct cxl_prot_error_info err_info;
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -64,6 +86,20 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
+#if defined(CONFIG_PCIEAER_CXL)
+int cxl_register_prot_err_work(struct work_struct *work);
+int cxl_unregister_prot_err_work(void);
+int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
+#else
+static inline int
+cxl_register_prot_err_work(struct work_struct *work)
+{
+	return 0;
+}
+static inline int cxl_unregister_prot_err_work(void) { return 0; }
+static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1


