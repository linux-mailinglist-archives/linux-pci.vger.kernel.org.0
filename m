Return-Path: <linux-pci+bounces-34839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0F0B3773C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7561A4E308F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0763C201033;
	Wed, 27 Aug 2025 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JRw2O4Df"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E51CBEAA;
	Wed, 27 Aug 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258798; cv=fail; b=jnLSWTT26yN2fZZCfvysr0g5LSBT7ZKLpWhuw6N/1JCBBVBV+ucrIszf8vCSSq/cerVIEH+lFZFixyqz3osn2CAnQGo3m2V+FT+wzrVWHzMeAe9IbceN6HK/FQgFVf6O7dWCdKo2Huqu4qkD+rmQLf6IYdzWMQvoycgLc5JiZRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258798; c=relaxed/simple;
	bh=ixXx7cYJjwr7MSQWsVbEyOCa+MU9E6mlO/NTHQu/ZXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXXa+4pyhJc4OKCY/KMmaoVQOweVSlmGJ0qhvEIvx7CI2za+ysUayfw3sFayA8Ag0YJjU6zatlzhJx8pSaMXR7/doDyHeGNSEFRx56X6wMNC8hzAm0prBXURMSNKKNLTJOGKbWP/UtBbbNKznUeAdrl29BCv8hPwFHHoHjk3fw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JRw2O4Df; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSym97gUKVHch24GD8IwJFB5DAE0vNZ/8TVB/oKiWTD3CA8h4rtZwdIZca6IALJCh+oiG+eaqZB7TRTHqcBfY8GEQhzVX+pKEr51KVctGxvJCqEw9a/itsriI4Qh4jpGdkCXTOcsSWfdrI96NGhX1/gAW1FSqiBmNo3AUhgV5lz3NI8Vs/Zqyz/nqUfq2wFpzvAchRiKABYVpldU2CaAwOfN4bebF0uRGD8kpedxmM6d4hO8iv341D99BxZZwuXiKOaPQpPoA5NKvusfNq3SkEEjEcf5Mz5AkaRTQo9+PfRUjLtpvyaczjwJNj/vtZnftaDzkp+fyItP8Q0Ie+NWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZBRKJ1eMd3a671DL8ElhmO440d81kl/wSrH2x9qwls=;
 b=KqAt7dAsCM60dTxtWwT3H5gtnleW6wT6Y12vWzIaEGgjISmwKBTpo9VrOnbXh9OTBEQs9djPk2ox2XKGT469kjTS1IdkEaWQriFPYxjVNW0qKyMm7IqmGt6A7mUR5J0m7d/C2adXEgr3NifaVhuDOMkjZQdREfm8MlGTkK2DGpLNjNxIYN6ibLfbepuu9ciWNqVIzhJsH1wWp/Dk3AXQRvMf79JE97XNaCaLHvAWjW1GQnFiFd9qaTJJSzog0QN/Abar0DqBgNAAKQDMtd4s5GtMue/0CvrJFIluZ38dmEMJDaFUuar4Zfs0VwAjJVdPVpy8i0edwCqsU8aN8ZsKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZBRKJ1eMd3a671DL8ElhmO440d81kl/wSrH2x9qwls=;
 b=JRw2O4Dfq24rQM+SqCpYs8nfjryS72HcHIhz1SgVbDdyBwxZ1isBFBu8g3tISJJYN2OwMTvWbp8osMXkawkVkHD5ckHABjimB+zzjQmBZ9z6u1UMjVWKMZQVdCRR+4/54HJqhoYi1lisoFWwGtP4tOql79Z3D/eREMZaQ0w0wHw=
Received: from BY5PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:180::46)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 01:39:51 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::c0) by BY5PR13CA0033.outlook.office365.com
 (2603:10b6:a03:180::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 01:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:39:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:39:49 -0500
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
Subject: [PATCH v11 22/23] CXL/PCI: Enable CXL protocol errors during CXL Port probe
Date: Tue, 26 Aug 2025 20:35:37 -0500
Message-ID: <20250827013539.903682-23-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0885c2-24cd-4b26-877f-08dde50a9d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqKf6cJ+w4MvGu10Bn0L/HigBNxnWL4t5pTvEOMNLdDbg4ljHfmdwCZZ6B63?=
 =?us-ascii?Q?XCsydi+v2j232P8gbJoibB+ZDjYQvXKvE/JsEC4vxDzyOdNsBgK2n52wBuP/?=
 =?us-ascii?Q?AdC7rOcxH1o0gIpWrIEFlBJWJ5qt1HnLc5PrAK2b43XHOti9M4t8TXK403DL?=
 =?us-ascii?Q?s8Ct2TjBlWejbtkK/EciBDFDrUaEQkAKnOIzg5bgZTo5Cf1dnoHXTtgQxl+s?=
 =?us-ascii?Q?zAeYZwzaarQ7DUPJTcr+2J8Du3rn7cyMmrMwt58ZCRyBkubstUKCGrRy+NlP?=
 =?us-ascii?Q?vfkTuTdkOq4Ozs9wl/3YryZtJ9CnxYNx3v9R2/HtAG21OY+yzvToOK4gye8y?=
 =?us-ascii?Q?ElvhNOOQHK69+LCMwnawOhrbNsMB9cacanOOCQxmjUKqaw2RjBSKtDdO0YQ8?=
 =?us-ascii?Q?wAOa2oVoelJoKl7gd2NwdJsy34Mxv3NPLBB9mBg3zJwkb9JDg+RPXRVIUvB7?=
 =?us-ascii?Q?lWHGydHLLSiFdfQ61fw+qO9WPU6h04cetW5Spbnh/wIPlnqfxYskr+WQnZxi?=
 =?us-ascii?Q?EdJrEiSKVbe5yAfEgwmZcH8y4yxcCXK4xru9VaZ+0SvmIOZ4QbeM4ffea34a?=
 =?us-ascii?Q?xdXSLSPKdZ+Wq800uvVDGRK5nZDO4SWZpJkkRjuw/FEDJuHVRdvv1YzGy1ld?=
 =?us-ascii?Q?I37jXsZR4RmWVqsmKLKnmLCkmsSN1lkKeQHBMugSydhg1rH6wFM1zzWlZ7D1?=
 =?us-ascii?Q?PMcQqbWOR49vMRMMA6Pw29WNnU/b2fkBqgSSEOSYnYS7tjlwYX80oo+Ehq2n?=
 =?us-ascii?Q?vjYwbYVAcI9Iggfz/6sqax8XF9OOcbdnMmX8SFCeGrlyS+M8yq8KRZhpaock?=
 =?us-ascii?Q?O42FRzc8O+kR/Ska3YBtqw1L/5MO0qP9iFyjMVo5KiZKD2etQ55lEVr6eLv8?=
 =?us-ascii?Q?0UliFWxxDgQnqkW79sR2ZQMtNhgFK0SX6K+qWnroWJJBYtkicLfYtYTIuMbq?=
 =?us-ascii?Q?HCWVIk285dxDJJjrmITUvmb53vXzSbbcmizkPaP+rhKT7763qACOnJOABwda?=
 =?us-ascii?Q?69GrJ6lij+ZIX7NlKWaE7YxYKDjf+6Ba1Cjyyef97rzMc0Bi89jbaKQR2zdT?=
 =?us-ascii?Q?xDcPCklmyUQ0VFExL2Ck0sSsDZ78vovkP4OL8QsesBNy27zMCevH2CXH3dwO?=
 =?us-ascii?Q?1lviCUZLS3/BlFStGdR0hDEMSWIOr9OaQ56FHmyEHH+h7nM6cMjeiPFVYop9?=
 =?us-ascii?Q?V9GOMs60flwAAnggwD6xxDAKe49cVO5PvTutEi16WzwDaed7GmRVpzdOSYV+?=
 =?us-ascii?Q?ZM1GKyTc0Rj54F166jVyr4qqazSqSjuvUIzdTayiPkz1Qb282ks5Z/sXqvvb?=
 =?us-ascii?Q?3RM9GP5rTamf2fMGgt7BGy2zjCQ0yyIO4Y4rZ8bH2yvJ41EsID7MDdfNHs/y?=
 =?us-ascii?Q?Th/zFXFuNUtaQRBaZafHT4k3QYX1aQPuwrUZK73g/zDsUWBoCkjGO4HuAXpX?=
 =?us-ascii?Q?KnPCwRUewZ+2n3ZGKmpGu7zpU9s9lMoVeg9mPtuZ0wdC62bzyRzaBFDkqoVZ?=
 =?us-ascii?Q?93MZIMLA1VRbg2U/68+XFnsAJI0BhDMPZODCq4fhRiPyAJMDuBv+znEAiA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:39:50.6082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0885c2-24cd-4b26-877f-08dde50a9d44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694

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

---
Changes in v10->v11:
- Added check for valid PCI devices in is_cxl_error() (Terry)
- Removed check for RCiEP in cxl_handle_proto_err() and
  cxl_report_error_detected() (Terry)
---
 drivers/cxl/core/ras.c | 26 +++++++++++++++++++++++++-
 drivers/pci/pci.h      |  2 --
 include/linux/aer.h    |  2 ++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 3da675f72616..90ea0dfb942f 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -122,6 +122,21 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 
+static void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_dev_get(to_pci_dev(dev));
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
 #ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
@@ -418,7 +433,10 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
+		return;
 	}
+
+	cxl_unmask_proto_interrupts(dport->dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
@@ -429,8 +447,12 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
 
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
 
 void cxl_switch_port_init_ras(struct cxl_port *port)
@@ -466,6 +488,8 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
 	}
 
 	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
+
+	cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0c4f73dd645f..090b52a26862 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1169,12 +1169,10 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
 #endif
 
 #ifdef CONFIG_CXL_RAS
-void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 bool is_internal_error(struct aer_err_info *info);
 bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
 void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 #else
-static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 static inline bool is_internal_error(struct aer_err_info *info) { return false; }
 static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
 static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 751a026fea73..4e2fc55f2497 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -82,11 +82,13 @@ int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
 void cxl_register_proto_err_work(struct work_struct *work);
 void cxl_unregister_proto_err_work(void);
 bool cxl_error_is_native(struct pci_dev *dev);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
 static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
 static inline void cxl_register_proto_err_work(struct work_struct *work) { }
 static inline void cxl_unregister_proto_err_work(void) { }
 static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
+static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.51.0.rc2.21.ge5ab6b3e5a


