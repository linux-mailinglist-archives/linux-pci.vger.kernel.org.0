Return-Path: <linux-pci+bounces-21208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C870A3156D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD531882D69
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB3267F49;
	Tue, 11 Feb 2025 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GSAxDdUl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12126E65E;
	Tue, 11 Feb 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302086; cv=fail; b=kghU4HTiYBEiDrYRUtSnXzX/yZON/VT1dlIYHSlESIL5xbszVUdhGrOCx61mwVdInMdK/xfExHM7wFcjwPEdkJ1aucB+U1XqE7awmXesUd/CMdhl9F8BR4YbLNLuTK+tqrcWoZygAwUtqpvBYvY4BmYFZ9Iv37BqeOzBCeprkHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302086; c=relaxed/simple;
	bh=bxsTtUyZzGl9ShVnwxI/UIdyY5dcHx2HLKlnyrfCOps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5Od9GgTyy9UeFiybOAP3EqHu6DZaZbKVuAbM/C7Jq3F4TkUM0dhSk8LVnxwbEKGnPdvxf7Ah6Jo1hv4XLcJFHo2K/R1cIAOOaU7NVeu65hVUUMxEV+TQ1UT9WEfcJrG5siROH4EurT2ndg27KaUnHTk9E3NzFQcFmR0dfc670g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GSAxDdUl; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+SnYAsheJNb6mhABK1URe1nV4pLS9I1Cr0Kc2N8aajbDZ1i6PYOlil/rkhb1XxRkDEpw0XLU+AZCWMK70fSbeVArEgF4ZOoFkl3amlUxMtxaAjAox1NZHtHUisLtPjZniLDT1gj2vR7W2WXlgLFOZ4+JDMeCKYLqziLCjV+c33qH7IR7ikPemH23ztRTlbAvkqL5RzDSm8wpONyrVU2yiGXEu3KUUGbbW/mUJ+/IwL9ZBq2V+iRpejaGycDBd1IzahXwERm4LpzKMA3gJUrlUMe8px04AcQXUxB8ptCOc/xJry9jMgNL+Xdi4DGVHG3Ov0IFrTvsXkgT7YPPz0tEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU7LVLqpjbtJbTxZYP03mWR2XCCu2peOpUe1x/M4yAw=;
 b=mkwkJwF3SZVmEOviXEKzA6koqWR+2PA+Mq06HAya+6rywo/DeNe6rIxEuoti+/XJA+YPAzl2iD9HMCWO5Ukd5driyxjEMbaeBS7+Z/9rq5dw81wC5f4UEEyPIywsMAizXjP49KOHlVwBKbZTLgs8H+Atw1eujC3eN9VH3+ZEjOo5DLCvHC//undN97tv8xWaoWFZeKgbBDGkNwuTxofRJjS+kgjBCwCqGLxvOscr7cIEWvRD9lrlQKRZYzS6ucCkemlz3Hhx0RLMqXRyF3DENNnbtevSbvGwyKoa/DV5TQaCOPsgLImwblWkAUOMN7Iv1hCLfhVFzrFJbLgoBHqzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU7LVLqpjbtJbTxZYP03mWR2XCCu2peOpUe1x/M4yAw=;
 b=GSAxDdUlgbrC4bYNOhnw3CvYXmOIjQrTIH4ehWHsQpDa5p2VDOJHz8DRhGF4jDZN9CtEm6AsiMpOLvOPpb3owxj8rUk0UO7ItiaRizkqTbU8uZ2WTiXY/+GQtGCQ/JvAFyr0pGDneuTbJ1Vlflj4dcLwcZ6llrYib5SrNbk+nu0=
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:28:01 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::96) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:28:00 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:27:59 -0600
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
Subject: [PATCH v7 17/17] cxl/pci: Handle CXL Endpoint and RCH Protocol Errors separately from PCIe errors
Date: Tue, 11 Feb 2025 13:24:44 -0600
Message-ID: <20250211192444.2292833-18-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df75a7a-0b7a-4026-6082-08dd4ad23275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mi01CSn3wZ/P1QSrT7b4cwDG8u46t7n4mS4PW/hF682Aa6vMBCLMLzRv/f79?=
 =?us-ascii?Q?olW6DL4hoaTSDJgdzS1SsrRynV9KIr97v/o2bpa3A8P7Tf3l6UcJHFkvZz/W?=
 =?us-ascii?Q?+Q4rxA84IUul/kuycdetOhYZaYE1lAtd0+yCUqpma1Hyb6kyS+WHL2Ei6TbI?=
 =?us-ascii?Q?tWzyjPBJ3xDZI3OW1ZZjWg5SDSt5Z9fQpQNXlwKg6SSRYCFr1vSmfoN5B3ZY?=
 =?us-ascii?Q?Ru2f7OMCLygHaj1Esmmzjwms0TF8/mbHSQO474YXJeDwVtVFcsc0lfK1MKtO?=
 =?us-ascii?Q?aFy7JZfw4jklSpvYtalN22yEYYsk+JVSrMX+2ykLbB1kO+/tX8chgZACI85y?=
 =?us-ascii?Q?/fnryDD8ccr6OFk0Q9BJVH9zSo/XohKQU4NsHMxHIghcZBaj7QLjYZHDAZOm?=
 =?us-ascii?Q?O2ko9hlkj1G/OihkLg+gVjc/ZplfCwK+BdQsvx9uXAvET7/7o3kgs0VJRPsW?=
 =?us-ascii?Q?zUJH/sHkVIVKBn2dCE+H+QgwtvgeHcD8LC2+IKWmk8rXdf6bG5/G1f0Kq5ov?=
 =?us-ascii?Q?shCmXkpvmbZSAPvY/G/5ssBjqUVfCaWTM0bQX5/vDF/7YA63v3c2C74K/EBo?=
 =?us-ascii?Q?7u389RDKuTe7ZgpEAdhJbXEKJpYwM90lhXTH1Z/CcSkiNOCv0Ij4Hb3fJlfv?=
 =?us-ascii?Q?otqGByi0vyVSPEzKZ//gq3Ipc+EpAdGOoo4N8HKSuWUg7qKruUjO4VtCHLAc?=
 =?us-ascii?Q?bCxc+qr2q2p8Lz/PaTl/gKVmJ3WZiSOZuqzduSdIL+QcIogpnAKt0lbkJjlA?=
 =?us-ascii?Q?fkjc+1dl+ASMdqz6dsvQaz4eVkCtSMbXcHvGcnJyWNdYVOpGUDK9fgI+fM59?=
 =?us-ascii?Q?Yr9kFzDkg7vqagg5W8q0CrSLCXbUmpASJZIDyTwc4sUQ3Z86kL3GRSHFANdm?=
 =?us-ascii?Q?LyKp4OetoGrDUUgDtIe6yjXd0DK4LllXIGc7+GIDqZZF1c+1mwhHQ2mCbGa+?=
 =?us-ascii?Q?PXBCpqvDbDhcaKV01JKzQH8W4+ZJQ6R9tmD5no4sMal3gIMz9U/mykHxAEAa?=
 =?us-ascii?Q?4Q9qqc8Luic56Aoe52NXjGTnA9f+CxeW/+6qkA2bIT/B8HnBMj8Cy20q687k?=
 =?us-ascii?Q?h1iqm3gNeeF1xqoz3c8VVCQqoi+cb1n2ovVXA3Gah4xrGdT0GVW4zkjsVXLC?=
 =?us-ascii?Q?LTERK1336D8d18zqSAUaTT2Il98B47/FPYMxtcgBY7Ck4dHa70q+ioV6THQI?=
 =?us-ascii?Q?XzpztW2986ZSLIMQHE+uaZeIHVu1X1MsW/UnQ3Mlf2RxbEq0Dp6R6xM8Qn8x?=
 =?us-ascii?Q?LkjmbiEufWFjMmAhUikR6M72gpVG3chWrGas2yadwrL6GC2IpanpfUDNW0/j?=
 =?us-ascii?Q?0oGwDSOnyZYJFriP7b2jBbVBLmwDHkhLfTY3mQvrrdTCEU6uQRa1c7zXBohW?=
 =?us-ascii?Q?8BnD+WgWV3uE8e7fhy89AnRde1Hr5lfF2N2rdeJvUCmYEhxUKms+ZA4w0pD+?=
 =?us-ascii?Q?YHqcvZGfvDP4/juliu6hxJF1QpspwHJr8cC+zRGJrTa2Ou8pkFxF/1IvHeL1?=
 =?us-ascii?Q?nnIiMbgERrlehaVj+m4ygaERE4L2LjqVBdYy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:28:00.4900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df75a7a-0b7a-4026-6082-08dd4ad23275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

CXL Endpoint and Restricted CXL Host (RCH) Downstream Port Protocol Errors
are currently treated as PCIe errors, which does not properly process CXL
uncorrectable (UCE) errors. When a CXL device encounters an uncorrectable
Protocol Error, the system should panic to prevent potential CXL memory
corruption.

Treat CXL Endpoint Protocol Errors as CXL errors. This requires updates in
the CXL and AER drivers.

Update the CXL Endpoint driver with a new declaration for struct
cxl_error_handlers named cxl_ep_error_handlers. Move the existing CE and
UCE handler assignments from cxl_error_handlers to the new
cxl_ep_error_handlers. Remove the 'state' parameter from the UCE handler
interface because it is not used in CXL recovery.

Update the AER driver to associate CXL Protocol errors with CXL error
handling. Change detection in handles_cxl_errors() from using
pcie_is_cxl_port() to instead use pcie_is_cxl().

Update AER driver to use CXL handlers for RCH handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 26 +++++---------------------
 drivers/cxl/cxlpci.h   |  3 +--
 drivers/cxl/pci.c      | 10 +++++++---
 drivers/pci/pcie/aer.c | 11 ++++++-----
 4 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 36e686a31045..18d47a14959e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1075,8 +1075,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+pci_ers_result_t cxl_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
@@ -1088,7 +1087,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 			dev_warn(&pdev->dev,
 				 "%s: memdev disabled, abort error handling\n",
 				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
+			return PCI_ERS_RESULT_PANIC;
 		}
 
 		if (cxlds->rcd)
@@ -1102,26 +1101,11 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		ue = cxl_handle_endpoint_ras(cxlds);
 	}
 
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
+	if (ue) {
 		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
+		return PCI_ERS_RESULT_PANIC;
 	}
-	return PCI_ERS_RESULT_NEED_RESET;
+	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..4b8910d934d5 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -133,6 +133,5 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
+pci_ers_result_t cxl_error_detected(struct pci_dev *pdev);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2c943a4de0a..520570741402 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1104,11 +1104,14 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
+static const struct cxl_error_handlers cxl_ep_error_handlers = {
 	.error_detected	= cxl_error_detected,
+	.cor_error_detected = cxl_cor_error_detected,
+};
+
+static const struct pci_error_handlers pcie_ep_error_handlers = {
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
@@ -1116,7 +1119,8 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pcie_ep_error_handlers,
+	.cxl_err_handler	= &cxl_ep_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8e3a60411610..07c888fd4c08 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -993,7 +993,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
+	const struct cxl_error_handlers *err_handler;
 
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
@@ -1001,7 +1001,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	/* protect dev->driver */
 	device_lock(&dev->dev);
 
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
+	err_handler = dev->driver ? dev->driver->cxl_err_handler : NULL;
+
 	if (!err_handler)
 		goto out;
 
@@ -1010,9 +1011,9 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 			err_handler->cor_error_detected(dev);
 	} else if (err_handler->error_detected) {
 		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
+			err_handler->error_detected(dev);
 		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
+			err_handler->error_detected(dev);
 
 		cxl_do_recovery(dev);
 	}
@@ -1070,7 +1071,7 @@ static bool handles_cxl_errors(struct pci_dev *dev)
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
 	else
-		handles_cxl = pcie_is_cxl_port(dev);
+		handles_cxl = pcie_is_cxl(dev);
 
 	return handles_cxl;
 }
-- 
2.34.1


