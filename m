Return-Path: <linux-pci+bounces-24806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B6BA7286E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDECA189DD97
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C566854782;
	Thu, 27 Mar 2025 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SxeCwkBu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116B13B5A0;
	Thu, 27 Mar 2025 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040118; cv=fail; b=r0l8lB2/z/Ko8zQIE8z4JUDGOO0hMRbkLMzqOIPb7nR1S0o1EXvYVpdTxS3s2/xsC5ctg/8T+cc5iRrCKbnxjBg1s9J/Wjk33ThMpAe/40eaXr9ywK1Au2D7DowEpUS0NNgwU5/Ub7y0agYOYy0xJ+/W/y1XHUsEkmdQ+NnAvsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040118; c=relaxed/simple;
	bh=GRBceh4bE/kleCkOXroWMqYw4oaon/gtJ2UBz6UBSDs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MprM+GGmZudsJUUIlljNUxkFrw+dgXXef7yd5/rVPf9KF4X1AzRIu6/9duzaYr2X/0OVlD3+TQKBvwwbEFKtBfiE1So8Fq/fOzmAP4ECfpy5RbekG8yej9Au7HWKfwxftPKJRGkQJz0Owz2/2XAmbcZE95iVRDscctFfXFvd7gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SxeCwkBu; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENBgQ9Kms9dXXabt/ER5hYL54vFs0LZuI2resRZvagsPbLdOFuN5vK7swk5/xIKFO3ZtSaVSWrcr7m45EfVY5IJX1U9HE+69Zd/+gVqBnhErU10FXBLr5BHgvja6+SmFV07T0YA/25hp5U3Plqxo8EQ3KBGRWK44AGii1EQChhCw6tIQYUxm+5bq5GEF0GHYBca6GiUhITacnrDLYf8wyWXXGGOKigNtn2EoSF+YNZMRb/oI4zRe89JDvzJ4ujTyEPIEbh1T685Fy3LSfLiHm8TXFiam3Y6QZontnGzI1daF/ywS12fIUqeFa4YReNs4sYnmqCvEGh1CV9NFzbnJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaiQ++Kacp3McQZM6yx8PgYKOkS5kKCYWXJoCM0iPOA=;
 b=lQMauw8u/dMIQhsJzY/dLlwBMtN003sBHtEvn+q35248Jo3tXyLFidgP5LQbVYCBxlsX61Lx7ydZEsdhA1qgiaLBypflaVCr2+ksMeh/k8Qoc62NTWpaynzgfY1SL83IHj3jFMu1IGgQRDIktPOgSQdVe4gH6NJ/e4D9j76VOyGGiX8wyhE1lHsxhij4mA31lqdUoaU7ECpJmBmOUkGkR/HEeyeTyu1Xo5zGhqbboYX+BuU8Jm10Ty/tL1mMkW7+sn7sMo3B5aBiVaj6Q7DNu1PQbp/PYCXOgHvAWbEbu3AIrGkt1U3vSbU+7e0IPpgtXDi/g4CaC75sZqMJeGWr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaiQ++Kacp3McQZM6yx8PgYKOkS5kKCYWXJoCM0iPOA=;
 b=SxeCwkBud/FP6jAaVUbqS0b1LHrR+81zokwTHWDv58oIMgq4L0IGJkJbun6lzA3jfgwbom6zyxM29B+K6n3jdsRranDyjUQvo1SYksHXVMn1bNny4m/1Kavr0+i5XeaXgfABat6o2MPw3bXSyXKfPsptvqCgxtr1yKnVoiOAmig=
Received: from MN2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:c0::25)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Thu, 27 Mar
 2025 01:48:33 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::ff) by MN2PR05CA0012.outlook.office365.com
 (2603:10b6:208:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.26 via Frontend Transport; Thu,
 27 Mar 2025 01:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:48:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:48:31 -0500
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
Subject: [PATCH v8 06/16] CXL/PCI: Introduce CXL uncorrectable protocol error 'recovery'
Date: Wed, 26 Mar 2025 20:47:07 -0500
Message-ID: <20250327014717.2988633-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: f71523a5-d232-41ce-1694-08dd6cd17b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6g7OYP4PG3e/HbYygf7xl/iNOklMWZZWjEAZI8JD8fdiAee2l2CG31OuIq9?=
 =?us-ascii?Q?GGhhqkeeYFGYgB8oMk19W6H6qxxmsYM4n8X7U8O/HywkysI48uadN5aSDlAD?=
 =?us-ascii?Q?hCPY64w/UwgitH9OBsRVjAPqzI2yOEPqWLlbOa/RG6IDkAFUOTCPHLj2VlKK?=
 =?us-ascii?Q?36k7SFPdGi71MqCHOgiujA0Lr4EG3oQzfuWZbVtdmJdVAFDWarAOzOc8Foo0?=
 =?us-ascii?Q?wggJzH9y8t494nNyEyXgEI/mG+uF0EFShW3K4zQHr2v6R762FxIiARHVSp3P?=
 =?us-ascii?Q?E6S/RnC88zF8TVFwF+YP7cIu8gYEDngmK0KF5YUmSVbNsawgoGKHNTQwcVgt?=
 =?us-ascii?Q?OFxz4s1Iyv5nqP33EofVHLmtsRbK6KqbKcKNL7uTQtRtbM1mtfp4giybiwJ3?=
 =?us-ascii?Q?szwogNXOQXjl8faPtQKE5LW+QgH8k1SMsPeFycM1tmTmSZKlj0HSoGZKykfd?=
 =?us-ascii?Q?Y8WzrSyrJXxqoz5Et2kauu7GrlqWb9caOWrf0Ahrs9g+/R9dsIwMzcOMzbHU?=
 =?us-ascii?Q?9ZyHXWLQCAbynj51u76P+JpQUX5D+j2NDF7aTkeo29ruhHZVWnhOOySAeDxV?=
 =?us-ascii?Q?hV1f9l/CmnFzScWgZWjb4RZvEpZ6hHR+MSWfW3Oxd1rMayMJMspm/mF/2Wd/?=
 =?us-ascii?Q?1IwTQa5QctvxCOcF2IGHtO9Z/fVWw4vR8cMBeAYZMNYdOEijz6VUKS6QHG8h?=
 =?us-ascii?Q?FZgFGYugPm5gWZe8/oke61eaYCeXs+9HvY3hHgaXKUI20ItzlCeLpgiYMpCl?=
 =?us-ascii?Q?1Oubo0u1v9N5Q0CqeKz0ODNgYcK326YG3GJcJzb4gyYIcqXS4gu8HzKFlDE7?=
 =?us-ascii?Q?p4eoDcywDgHKRtu39FKlCKPdxqBVLpkAtRYO1s6B03wtfSgdMiSifPS/jHom?=
 =?us-ascii?Q?OcMnOWm7ie05qiFPvDC2NfITrg45tOzUW88MCNFKD9jF5rlJeNQpf4DGQP3l?=
 =?us-ascii?Q?hyt2DKQ7PN298euiLnts09/9jhVzId1+8h3PnheBA0htRSCqmStiJRgyaWpe?=
 =?us-ascii?Q?uwGLWYESGgGhTSAAjtmUrGQTTa7WG8A+00OjlJ7PTcZE0Iwcvg/WNuLs+zwi?=
 =?us-ascii?Q?J7ez3iSMMhBTtZ0jjAWkYXaQ9YawNHEI+4nmudGE4nppy3VipUrvCJGoi3Xu?=
 =?us-ascii?Q?/1QUkCOFWVzkmm9vzq0NQ4S4OoIKVUaLrO773SG/slzhRq8sN0Zo3GHtGkLr?=
 =?us-ascii?Q?T1m5bZHyNzDShUexcERBJ8jiyCQoLY6a6N6dkdhAnkac4BSJZjNoRN8ShtRM?=
 =?us-ascii?Q?mq1ScyryRfHlq7cQlXEHAjgN2iM59Ci4zMyxF/ynZ+XUcNdVX4qmeAizGHuC?=
 =?us-ascii?Q?L3WMSEqwknDlhmmT7kTuDx0PaLpX5scIDaBVY9UWiGClH7B1Rwrfri4RALE4?=
 =?us-ascii?Q?vKWDT73maGOZ2AVjNaGBCZ//SmoAgE1mJM8XrzPIVxjCF4oC5s0yRzSz/qNZ?=
 =?us-ascii?Q?aBmt/K5YwDFQU/TzML8F9AYHGs1VOclDYT7lDPTeO3MGgeDu/ey0TYNU8BEl?=
 =?us-ascii?Q?i+Pbzr67t4ez6QddqmrHC1XlzwoWA7yYe0+Z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:48:32.7731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71523a5-d232-41ce-1694-08dd6cd17b3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
handling. Follow similar design as found in PCIe error driver,
pcie_do_recovery(). One difference is that cxl_do_recovery() will treat all
UCEs as fatal with a kernel panic. This is to prevent corruption on CXL
memory.

Copy the PCIe error handlers merge_result(). Introduce PCI_ERS_RESULT_PANIC
and add support in the merge_result() routine.

Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
first device in all cases.

Copy report_error_detected() to cxl_report_error_detected(). Update this
function to populate the CXL error information structure, 'struct
cxl_prot_error_info', before calling the device error handler.

Call panic() to halt the system in the case of uncorrectable errors (UCE)
in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
if a UCE is not found. In this case the AER status must be cleared and
uses pci_aer_clear_fatal_status().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/ras.c | 92 +++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h      |  2 -
 include/linux/pci.h    |  5 +++
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index eca8f11a05d9..1f94fc08e72b 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -141,7 +141,97 @@ int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_prot_err_info, "CXL");
 
-static void cxl_do_recovery(struct pci_dev *pdev) { }
+
+static pci_ers_result_t merge_result(enum pci_ers_result orig,
+				     enum pci_ers_result new)
+{
+	if (new == PCI_ERS_RESULT_PANIC)
+		return PCI_ERS_RESULT_PANIC;
+
+	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
+		return PCI_ERS_RESULT_NO_AER_DRIVER;
+
+	if (new == PCI_ERS_RESULT_NONE)
+		return orig;
+
+	switch (orig) {
+	case PCI_ERS_RESULT_CAN_RECOVER:
+	case PCI_ERS_RESULT_RECOVERED:
+		orig = new;
+		break;
+	case PCI_ERS_RESULT_DISCONNECT:
+		if (new == PCI_ERS_RESULT_NEED_RESET)
+			orig = PCI_ERS_RESULT_NEED_RESET;
+		break;
+	default:
+		break;
+	}
+
+	return orig;
+}
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
+
+static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
+{
+	struct cxl_driver *pdrv;
+	pci_ers_result_t vote, *result = data;
+	struct cxl_prot_error_info err_info = { 0 };
+	const struct cxl_error_handlers *cxl_err_handler;
+
+	if (cxl_create_prot_err_info(pdev, AER_FATAL, &err_info))
+		return 0;
+
+	struct device *dev __free(put_device) = get_device(err_info.dev);
+	if (!dev)
+		return 0;
+
+	pdrv = to_cxl_drv(dev->driver);
+	if (!pdrv || !pdrv->err_handler ||
+	    !pdrv->err_handler->error_detected)
+		return 0;
+
+	cxl_err_handler = pdrv->err_handler;
+	vote = cxl_err_handler->error_detected(dev, &err_info);
+
+	*result = merge_result(*result, vote);
+
+	return 0;
+}
+
+static void cxl_do_recovery(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+
+	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (host->native_aer) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
+
+	pci_info(pdev, "CXL uncorrectable error.\n");
+}
 
 static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c32eab22c0b2..1354c7cfedeb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -886,7 +886,6 @@ void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
-void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
@@ -895,7 +894,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 56015721be22..0aee5846b95c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -862,6 +862,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic  */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
@@ -1864,8 +1867,10 @@ static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
 
 #ifdef CONFIG_PCIEAER
 bool pci_aer_available(void);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 #else
 static inline bool pci_aer_available(void) { return false; }
+void pci_aer_clear_fatal_status(struct pci_dev *dev) { };
 #endif
 
 bool pci_ats_disabled(void);
-- 
2.34.1


