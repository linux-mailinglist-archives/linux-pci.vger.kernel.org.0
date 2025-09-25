Return-Path: <linux-pci+bounces-37054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470FDBA1D81
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08F53A7E3A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291D322A32;
	Thu, 25 Sep 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zHDUMzxt"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C298322A2F;
	Thu, 25 Sep 2025 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839913; cv=fail; b=pdEzODQcXJuK+V1LZ/R7h1n0F27JcCQCur1CwbfR3cYdJwgStyoIeKhINna/CB2SR5Ae+aFHTF457lAE1QdclZXxtXtNBLBpw4tmgEue3/lbhaDisppasnmCu6y8s0XUta27yRM2sFE+IVhndyusu/KaN/iQECH+ZGbxQ07mVBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839913; c=relaxed/simple;
	bh=NOATxdkd3IZVIcQli+BCr4DCM6S7iTZey3f6cSJzCaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I31bvvMRVvRHMyKYP/pSGuGBcxu42jsBjeD68zrMqMnc3sUyN8Tetke/Hbvgcr8tlIWiqAF4jWjigd4AtY7WL07kyLOd0d/i2hrFYtWOpTArXQV83vOdxV+rnZ7KiekB8NbrCfqmCFQUs8EGzDiKmUDHTN5zzDW5HSAAJisj1Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zHDUMzxt; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYR+cMeiuNJgSuXlu8EgTtKsDH/AzKM4kbCv8bqI7Gv/4O0wV9VxsuCqZJdQbRd7tzyflI51B/6h4bVEAYUWZo0AadZ1/57AM57+oNvgcKBmrKVBNt81IiG286afRUNMqdpzAhoSCVvyHF1LB3bNLPr0smnAnwxqa1bUwfmlPy6vixk1JBNBlpY3GfNhfkeMv9BDtSoUUwmagBthckbDnOA2ZmYVcJgF/h5ZDP55a8WoSmzRcxTonuw/8L1U0hsjZjG+ZsVWKu/bScGn33I6SrBCIzaB+kGoF62rKFHd0Spc8ZKZQa8CVxoTHmF/0EOjqq0axo+dEcpT5ZHbHWbqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y86m/T0LSVDkyWndZJKOHYo4r1uSa9vY2qyrNuZBug0=;
 b=ZIgGh4gX+finv1vfg+a8IeueQyHMbaCbV43G9923gDVJ8PutrLIylAaXfvGlJqSp/0zTlTx18s1a3I8WfJQEd9Y2vbDf9rsaNQRuN/YlwhGN5QnkNnXAtwBxo+tKaujC+pq9lsYyflKCRYtTeFwp15BLBoXQdlrL1FDyARysbcB8jLHO/gqgoo0ia32MsrA3lNg3CmdTfhoErgicZMDLlhcI0WGmuNaTXrKSc6Vpb3m+NxtDZVRP0Wr63c94flXy026N+DlFKaRBz+A26+e7RXUntQXwSRQHGkcAA2/qlv0G4LEkHZZEU2gsFzwGy4HlEIVqDisc5THOPGioWW6JEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y86m/T0LSVDkyWndZJKOHYo4r1uSa9vY2qyrNuZBug0=;
 b=zHDUMzxt1Qy0L5Hs1tJ+HQiVauxIIO37JvBSOBo+Z/gJ95PLv5nKjYeK72XJp1N2ke5CNlxBJTbwBQs00E+sPOnWXRhuMm0HSWWQSSirtvBj+ZIrdYYv2GNc61IV1Rz9UzHy5mTQmkFxDA+gB3C55ym8xFlCnOjH8wWEzHlG5v4=
Received: from PH1PEPF000132E9.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::30)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:38:29 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH1PEPF000132E9.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Thu,
 25 Sep 2025 22:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:38:28 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:38:27 -0700
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
Subject: [PATCH v12 20/25] PCI/AER: Dequeue forwarded CXL error
Date: Thu, 25 Sep 2025 17:34:35 -0500
Message-ID: <20250925223440.3539069-21-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 920f1c72-2cee-4962-8dc1-08ddfc843f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SBDJ6hdWQlKlYVkZdbHBGPSZI6U04WZ3Ama/tvOZTL6/OQUonB7FVA0/86ne?=
 =?us-ascii?Q?1gee3bAevYALhMlBez/t/mpWUvpZLrXCASzcEfU1Y8WwfwnAdRsnrNPLPQTl?=
 =?us-ascii?Q?7DlTbmKw8B6WZe0yjULwJUmBf1br7ZHDUIziYrQtCdYvQnzuZdOwhoBH5VXe?=
 =?us-ascii?Q?gLqyMnJKfY11fJkWjNQfu2kW16jeVvW1tFtoavAKtptXULNpex/ckPAg04pL?=
 =?us-ascii?Q?klj2SFtC+Sksi5uzjjx7zNQ8CELCbnKHeCe7rNaOkZAcoWE76csrQjNCwNsY?=
 =?us-ascii?Q?NEVNJ5najSjymsb9n4w5XLY/N1G9oTbTqowX/9da0lJTduL23/p/jlvsN4Lx?=
 =?us-ascii?Q?M52DaK/NJjUgSl/2NKuwFnth75TTxWut/4ibVg6YnrGWfzN9PBQkAA8aTZAo?=
 =?us-ascii?Q?SuK8SLxByHmFOuNGGyR7JY/PuM+f4o6b+Gj7c8xB9p/1RmVCzMTxNBA0JA4L?=
 =?us-ascii?Q?HieyTiNX5Eo1TwBa4pwlXqU67hY9rkhOlbeAllTR57FCkaqIKLPv/hNRUCU3?=
 =?us-ascii?Q?/O3DEDfPfmSG4E3VFwmQxGpZNU8CKYH4+0WjvcwMCgf9kCCm8iyR5ddUN9/2?=
 =?us-ascii?Q?tgklofx7/KYyB87egJ0D7tBMzVgaZvaO0R6nD5SxVaR68aRf/Yt1j6Bny1r8?=
 =?us-ascii?Q?yz5bFIhg7R5cARM9JFoTg9Qg9aefcngLC3rlbqT3oWycA7butKqJd40oUFwS?=
 =?us-ascii?Q?ivhjdejHhksBwfaSgUR18WCm6M7R66u1Eo8x6mnSavh2hK8ElfKiCK4HrFV5?=
 =?us-ascii?Q?OKSvBEtxDNioUqim156SNuVVtEbxCIF1N5LEcpSgrPJ5n0r/YlyIh8dpNzhM?=
 =?us-ascii?Q?eTwlADbKGIUaPsiBxRzgYWaT2lnoDAQ0IilrWCNtKaPpC45Q/mNnqr7Iey83?=
 =?us-ascii?Q?sS6MVHeZXAHdjI5LLYLOAJEivAC9U+5R57z4hLZNnyIJ9IEUmrC6Fso5QcUQ?=
 =?us-ascii?Q?ZTeIAMWSmGqSDIcNyhm/lgjjky9sj8gs6yzZcv6aldDGYgQznStIvtFPFfHx?=
 =?us-ascii?Q?4sZXpOI7CFH3m+96CRsLygRSWTtFJbyTuno/LErIAV2W2acDmB3Ce04zZcBu?=
 =?us-ascii?Q?+tMizy8hm6UTjvug/zEsWzzfcOoMVCYElZS6K1V5gRDVXH+VmNIVv9tY1gvK?=
 =?us-ascii?Q?GBdNH3qnL1eJFxfzgL+SBB7rq3+Q/45/Gg/A3NLGIAfZM/o43o4FAm7Xqfcu?=
 =?us-ascii?Q?qv9riugI7xlAAhZXnQqSoT7lQgGESt9w/nPwkvLlnnNGAVXF0Be2URxRhM1g?=
 =?us-ascii?Q?yxy/s6GgEMvNzOaRaQB2iiIsMFiaA5AO5Fxm+5tH9w1rN5/e+KyUpEZWzh/g?=
 =?us-ascii?Q?jdtqT6nQuOSAWl2y0vDwQEoikVUXvhfpJ8eBYdVHXc1FKjKFa17+AR1bCeKi?=
 =?us-ascii?Q?xUccUl6isNOTcq/2skyf1Ir3eS9QsZTAxW50IVBCZzHM10f6uejwNiTtfFSk?=
 =?us-ascii?Q?TdCcLhzKUGC9kM8uZ4KNpTzIQX2rRUhGOVcQ6Chw5rSxBb2oz9KIlEbRPHmV?=
 =?us-ascii?Q?grRLmv5U7GMUQDoy3lWK+ar6ZvIghWFdvjgj6ActuChwqAgm0xApK87caw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:38:28.8910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 920f1c72-2cee-4962-8dc1-08ddfc843f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035

The AER driver is now designed to forward CXL protocol errors to the CXL
driver. Update the CXL driver with functionality to dequeue the forwarded
CXL error from the kfifo. Also, update the CXL driver to begin the protocol
error handling processing using the work received from the FIFO.

Update function cxl_proto_err_work_fn() to dequeue work forwarded by the
AER service driver. This will begin the CXL protocol error processing with
a call to cxl_handle_proto_error().

Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
will return a reference counted 'struct pci_dev *'. This will serve as
reference count to prevent releasing the CXL Endpoint's mapped RAS while
handling the error. Use scope base __free() to put the reference count.
This will change when adding support for CXL port devices in the future.

Implement cxl_handle_proto_error() to differentiate between Restricted CXL
Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
Maintain the existing RCH handling. Export the AER driver's pcie_walk_rcec()
allowing the CXL driver to walk the RCEC's secondary bus.

VH correctable error (CE) processing will call the CXL CE handler. VH
uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
and pci_clean_device_status() used to clean up AER status after handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---
Changes in v11->v12:
- Add guard for CE case in cxl_handle_proto_error() (Dave)

Changes in v10->v11:
- Reword patch commit message to remove RCiEP details (Jonathan)
- Add #include <linux/bitfield.h> (Terry)
- is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
- is_cxl_rcd() - Combine return calls into 1  (Jonathan)
- cxl_handle_proto_error() - Move comment earlier  (Jonathan)
- Usse FIELD_GET() in discovering class code (Jonathan)
- Remove BDF from cxl_proto_err_work_data. Use 'struct
pci_dev *' (Dan)
---
 drivers/cxl/core/ras.c  | 72 ++++++++++++++++++++++++++++++++++-------
 drivers/pci/pci.c       |  1 +
 drivers/pci/pci.h       |  7 ----
 drivers/pci/pcie/aer.c  |  1 +
 drivers/pci/pcie/rcec.c |  1 +
 include/linux/aer.h     |  2 ++
 include/linux/pci.h     |  9 ++++++
 7 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 39472d82d586..9acfe24ba3bb 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
-{
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
-}
-
-void cxl_ras_exit(void)
-{
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
-}
-
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 
@@ -331,6 +320,10 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
 
+static void cxl_do_recovery(struct device *dev)
+{
+}
+
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -472,3 +465,60 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
+
+static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
+{
+	struct pci_dev *pdev = err_info->pdev;
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
+
+	if (err_info->severity == AER_CORRECTABLE) {
+		int aer = pdev->aer_cap;
+
+		guard(device)(&pdev->dev);
+
+		if (aer)
+			pci_clear_and_set_config_dword(pdev,
+						       aer + PCI_ERR_COR_STATUS,
+						       0, PCI_ERR_COR_INTERNAL);
+
+		if (!cxl_pci_drv_bound(pdev))
+			return;
+
+		cxl_cor_error_detected(&cxlmd->dev);
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(&cxlmd->dev);
+	}
+}
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+	struct cxl_proto_err_work_data wd;
+
+	while (cxl_proto_err_kfifo_get(&wd))
+		cxl_handle_proto_error(&wd);
+}
+
+static struct work_struct cxl_proto_err_work;
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+int cxl_ras_init(void)
+{
+	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
+		pr_err("Failed to initialize CXL RAS CPER\n");
+
+	cxl_register_proto_err_work(&cxl_proto_err_work);
+
+	return 0;
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cancel_work_sync(&cxl_cper_prot_err_work);
+
+	cxl_unregister_proto_err_work();
+	cancel_work_sync(&cxl_proto_err_work);
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1a4f61caa0db..c8f17233a18e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 22e8f9a18a09..189b22ab2b1b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -692,16 +692,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
 void pcie_link_rcec(struct pci_dev *rcec);
-void pcie_walk_rcec(struct pci_dev *rcec,
-		    int (*cb)(struct pci_dev *, void *),
-		    void *userdata);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) { }
 static inline void pci_rcec_exit(struct pci_dev *dev) { }
 static inline void pcie_link_rcec(struct pci_dev *rcec) { }
-static inline void pcie_walk_rcec(struct pci_dev *rcec,
-				  int (*cb)(struct pci_dev *, void *),
-				  void *userdata) { }
 #endif
 
 #ifdef CONFIG_PCI_ATS
@@ -1081,7 +1075,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ccefbcfe5145..e018531f5982 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index d0bcd141ac9c..fb6cf6449a1d 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
 
 	walk_rcec(walk_rcec_helper, &rcec_data);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
 
 void pci_rcec_init(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 6b2c87d1b5b6..64aef69fb546 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -66,6 +66,7 @@ struct cxl_proto_err_work_data {
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
@@ -73,6 +74,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bc3a7b6d0f94..b8e36bde346c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1825,6 +1825,9 @@ extern bool pcie_ports_native;
 
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt);
+void pcie_walk_rcec(struct pci_dev *rcec,
+		    int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
@@ -1835,8 +1838,14 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void pcie_walk_rcec(struct pci_dev *rcec,
+				  int (*cb)(struct pci_dev *, void *),
+				  void *userdata) { }
 #endif
 
+void pcie_clear_device_status(struct pci_dev *dev);
+
 #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
 #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
 #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
-- 
2.34.1


