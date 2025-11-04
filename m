Return-Path: <linux-pci+bounces-40182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D247FC2E9F7
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8DB421777
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB019D8A8;
	Tue,  4 Nov 2025 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GcS5vVau"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB61A256E;
	Tue,  4 Nov 2025 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216163; cv=fail; b=awKbfE+Cp3omQ/WohrSbBI2/UpOJIuLW47oCcmiY5lbXiUzP7sgBC99xzvQkpmLb9Sx+KcnVn752ZVMTPnAdiXfUh0zE37A2xSvNw8hJ0Z15QeUwtOC7aSY6yIXWBCY7c11n9UAqKrSwwGvG4vNYyPlv3V0W2e7JjWwiLDuS+o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216163; c=relaxed/simple;
	bh=SkNdiXaGS73zw0aEKz3TDPByCzvXD4RAcUm9Hn5htJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TB0jE7ynr/3LaWt7e5liTdMbMk5R5A7Au/llFUXO7PeIR5xBa4Of2O3Mv79ZLxm2uKoND2Ky1B0hxQB+E+KnED7IVupt9ICOFXlDM8f8Jfnln7pds02v12SekplcR4Bjc4Pns2PK8qXRuyiqg4cmfL+RwyI/8x/2WBIxE/NkbaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GcS5vVau; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIKVePtGsjvOHPqnzqjx65xqtW008WnzxAAdYRAgO7/CBp6TWiAb3hLUv2fi2x5FPE7DrmSpl6CIMXUL0xclxB/6nqICkFtYUFCYdBLii18ghAR75x5CUlBou6u004M1sYCwf7OaxKhd3yixviZR06qzr369N0gObQZ6RLk9GPbCb+dFrHGXEtHdMhuM6SPJKXI1V4tFEHv9uBHsY9dvcxNkQIsr+8Ba9JW28LVc7q4IViBxgNkVJIaDgse6xhj64ABszrgP8/Erg7Pp6phtUwQdNo6Ga53ptK572hjFgXrOBBYXeFL5zI2Z5sJL2701FL9GB7RECMgknt3LPZU5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu9rAifQXi7meiqrmxr8Qum1moIc+lVMjh2BAosSQiU=;
 b=LD4XVpjC0Q6GdHYq7rAwjfDEKY0V0geV9RR1jhjwrtan5dd8PJ1aibm4r9jN4l2cSerJqr8FbQkVvSMWTjTXIyS3O1OU04yZ0aoDIzV+/ShWVmJMIln4HM6Pgw9W685yszk5FsQvH3Q45mW/lVPL3QRLjx5q/uEP6/AOJ7wgjbnBhjzBbDSxUg+Sf3vPKuAYOhIzsjJIGq8x2e+FbTb1/+4nf137Nm4TWs9uXPYgSdD9jmbvnnClibSMFKWwkDDSb1t1IQfiulETwf7ke5qgYqpDiZ0zKdSupeH4xd7TC9FiRuJbIeGiCZobwX6xqqsEFS/pJssEE1RLKZJTiIEAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu9rAifQXi7meiqrmxr8Qum1moIc+lVMjh2BAosSQiU=;
 b=GcS5vVauWnf4uX2ANKcN152IeREObiHVpW8QyJcNednlLKpnvjXFwn9zKKSFcHfYhBZUYGf7Q/XuJpprZDscXsqzX0CZ4upqSfQb/WNpmsgXpaX5AFLiH4ixbaPsmVy75FMxmMdKWuAWTL6CrAH2+K+PwPTyK0DLAUd9MGPnZuw=
Received: from SA1P222CA0098.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::8)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 00:29:18 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::17) by SA1P222CA0098.outlook.office365.com
 (2603:10b6:806:35e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:29:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:29:16 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 24/25] CXL/PCI: Enable CXL protocol errors during CXL Port probe
Date: Mon, 3 Nov 2025 18:29:09 -0600
Message-ID: <20251104002910.3888595-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c613c2-b3b5-4c23-2f76-08de1b393094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6zvZFCmlPzTVIDvOfltLym505mK4X5/7xNm46SO4IKSRdWU4K5ZKegclD7vT?=
 =?us-ascii?Q?noxicG3oDUXo3oazssDxgeWI29nZe2XZA2am+hlxWfIHPmrAXY34FKPhD4nc?=
 =?us-ascii?Q?jC6329g5ofFissZX6KSU0AbgbS4jlccRyiPrrMvbm5UF9jiLsTtWdmhBsROF?=
 =?us-ascii?Q?5bFisBLXCkakwxeRQ5DJ2ToDdBsX1oWLo1D8fpRe+jCzx5/o+kmLN+lRoa4I?=
 =?us-ascii?Q?OJf0AnhHicPf2MFtqoLOJph+/5x77qMwqf0b5WiWMz9FWh9hCUdsZQ++WwsD?=
 =?us-ascii?Q?xgwQzLlmyJoTXTen3c83hPjC9gPr6Nw8rTkWgIOn1tOs+Bets0KfiZnNwPt6?=
 =?us-ascii?Q?AcKs8utrUG7vWBI/qyEJ2g9FDosM1CZM+RlSl/qTqC5SY/9v5Vo3QA/0WLN/?=
 =?us-ascii?Q?YC4E7QymZsRhOoglpckjGSFL9CGvQQZoGwWR2CnEhPN+Z2F79A5BbcVY4xIc?=
 =?us-ascii?Q?AoDRPGEItge5uDEztm8bbbasEbbmuU68ayR+YCJd/JMS7n4lx16jgWCwXX7v?=
 =?us-ascii?Q?0JMBPWPmlujRgLeNHGTXdu5Sz4T8OfYenjdx59rsDhGs61JbP8wqorGDS1Rt?=
 =?us-ascii?Q?p0iNsLnFLtjPJOE/fKfyg6um9fCVYFG9lxSxgl5grFYSE7Fc2pyK9SO0gQGr?=
 =?us-ascii?Q?oFBXfyOJ/mGpqA2maN1xcFW4fVcbu3uOQBvc/1EYQFke3tW3VTiP+XTBoxOn?=
 =?us-ascii?Q?QGrftnTelYHEc8QNC9bMpFcb455xngKA92xEeGfljeg5w63auHOe5q4U0DER?=
 =?us-ascii?Q?z7uOkGaSmDTB4aagpJpyHn5/Ixb+9TRTvHYoIgG2cAnBUhzsyzk/D9FbSCcB?=
 =?us-ascii?Q?ZeLorMPSUr98mNeE4SjteuGs+U1pc9bIxxElUwNO5coJm66mp20wGF9IgFT3?=
 =?us-ascii?Q?tWcnAijN3tP7vYDALK1e0TrC3zY34iWL59Hlxl4oWp7lc71Qehc/BKnQt9F7?=
 =?us-ascii?Q?BwFKBUggDaMpENdk2G+fRAaD4T9zmqBZcAKusRMTbPYnZe/odsRctpIZgh8s?=
 =?us-ascii?Q?o42++9uEql1sEe2qzZRZXN61sgtPKVR6LRHwt2fjL4EO5FUxSN9RmXjYDX1T?=
 =?us-ascii?Q?W4eUXFbm3XtaYEmMbpZf+dL8ZbR/vE9wZoED5oI01ogH87O6ahuQte6szFbn?=
 =?us-ascii?Q?vl9LBLvVWWPPvcKTAa5UUwP67raGDWE7jfRHZqyh+VGdxR5HLkLTGQ5c5gbv?=
 =?us-ascii?Q?xJLqvWfOFv7ZBjZFuMKL6I+j8cq0+H0lgcunEJUtUmHT69jJKjvu6T3T25k1?=
 =?us-ascii?Q?p7rFERTc77xk+Oei8AY7rt/upTNuTrUYJAkAObWGS5TLawaBsVQ+zINE7iaY?=
 =?us-ascii?Q?oecbQUFPKOnKO1bbZdRzdujdINjtY3IA50jDVgyhql2UlBEJR9J+tNLWXtPR?=
 =?us-ascii?Q?cxugrEmnizSyLPAGnS4umWAwMD27hwo6Ou/G4bLbnb/f5gUK0HptUKDHkpgc?=
 =?us-ascii?Q?dgJQMgq12AnukipvlfPQC7rfEvQpsNovkQm/WJiSWR/Abt05tAZMDCzjj6N0?=
 =?us-ascii?Q?t2BfxrfCv748dgrN4O6VRTAmao1FHjZZUFW9ixJ2I8M2vEyMNFQc4thnfVdV?=
 =?us-ascii?Q?XMHOctXAxAVzgOpVw8d1kMspYPuJ9CJj+eSNMAPJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:29:17.4632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c613c2-b3b5-4c23-2f76-08de1b393094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240

CXL protocol errors are not enabled for all CXL devices after boot. These
must be enabled inorder to process CXL protocol errors.

Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes in v12->v13:
- Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
- Add Dave Jiang's and Ben's review-by

Changes in v11->v12:
- None

Changes in v10->v11:
- Added check for valid PCI devices in is_cxl_error() (Terry)
- Removed check for RCiEP in cxl_handle_proto_err() and
  cxl_report_error_detected() (Terry)
---
 drivers/cxl/core/core.h |  4 ++++
 drivers/cxl/core/port.c |  4 ++++
 drivers/cxl/core/ras.c  | 26 +++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 046ec65ed147..a7a0838c8f23 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -159,6 +159,8 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 void pci_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_port_error_detected(struct device *dev);
 void cxl_port_cor_error_detected(struct device *dev);
+void cxl_mask_proto_interrupts(struct device *dev);
+void cxl_unmask_proto_interrupts(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -183,6 +185,8 @@ static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
 {
 	return PCI_ERS_RESULT_NONE;
 }
+static inline void cxl_unmask_proto_interrupts(struct device *dev) { }
+static inline void cxl_mask_proto_interrupts(struct device *dev) { }
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d060f864cf2e..a23c742eb670 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1747,6 +1747,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		rc = -ENXIO;
 	}
 
+	cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
+
 	return rc;
 }
 
@@ -1833,6 +1835,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
+			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
+
 			/*
 			 * If the endpoint already exists in the port's list,
 			 * that's ok, it was added on a previous pass.
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 52c6f19564b6..101e55723785 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -122,6 +122,23 @@ static bool is_pcie_endpoint(struct pci_dev *pdev)
 	return pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT;
 }
 
+void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev,
+							PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -230,7 +247,10 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
+		return;
 	}
+
+	cxl_unmask_proto_interrupts(dport->dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
@@ -241,8 +261,12 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port,
 
 	map->host = host;
 	if (cxl_map_component_regs(map, &port->uport_regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+		return;
+	}
+
+	cxl_unmask_proto_interrupts(port->uport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
 
-- 
2.34.1


