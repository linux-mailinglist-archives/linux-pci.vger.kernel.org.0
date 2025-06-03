Return-Path: <linux-pci+bounces-28900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 193ADACCC29
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA631898380
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A2242D61;
	Tue,  3 Jun 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K1vn3f43"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BE24291C;
	Tue,  3 Jun 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971521; cv=fail; b=eteO/SFEa+gVebY+qMPem2kCutmv18tx5EGV4RoZb/JKCFtr9Yv8t7aJboaUEvQTujr4Ufxit60/M53fUy83IH5ojRkDI3uJjU5nBpgj2oT6Vn7SqWMYE13arf28vStF5CKpCOWnbpm3nhJKEbPBYyZsxSPyZBUvLicFtX5DFUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971521; c=relaxed/simple;
	bh=3d628hLQu69+xLbkVnQiNnTERMTtqWwRhXWVdvcZAAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMtNT8OtAC20NkQKHU3+FzbRJh9vj+FxY7HfS8BxpzpW51Scv1pkJtZFkGuWgb1hZyZoRyUp/skwekuGtem1FSa0lJnYKZA8QbgneHdVTvCn0nZrOja7XEP92Q3x7nsXthPX9x0pJv/MPl3sMa02Y460GTdvCn9jIh59blMdNfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K1vn3f43; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPHmdf/MNoiRvsGJEXz+PRi96YxUYLaKeq8W8y3ZurZqhcrb3DYjzGXRiwWlJllz4j701yd4wF9C3gzRpNmBm+y1mL0CdDW/JmR2BV/DnioY/thycelxXFNlJzE0GJf6a4jX4d5Goo+zfUo+kuEmARG9aeeHWIRzUFCJcVDIaXImPPeTtY8PQKu/Q1eJnw6kQF09Y8e8MegvCA+sRciNn4cDYqHnU4HWjx+P5NWRoCaIfoTS2bpFoNOw4mXB2TzREd/2zvhQ9tZUTuk6R4ss0XfAI49j2aYTpCVCMnxXEr/7fmeC6Go4LBE6NJZPhgLaWKoOEeVQgyjIaWku0tzWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPD80tG7FgwYOB9ot4RNZJ/WPPDkfSKnQwJEYybNJeQ=;
 b=oWIdIUobZAtQgSKBKkFv8yj/akNVOuwV5neAjSLyYI4Uqij8DPo8x0kBPPkNWXpzbqBbrmOem0pmLa0pkvnuH2dtPUHwS7P4QPuWG0nqJzmVjXBggwA6txBkPWrI5K8Ng5i+cfDXE5eufjScGcYb0oLkjgjLqGDqBOstXPV83LfsGrrcMcQfiskQyfggL+50WW0vz5Dl23LEIgr/36VygLZwRr/3Y9FKwVh4DGKNmEwnK64/1mANJVfcf+nTfVj3q1emVMkNEGZc7Th0g7qdkh4QI2WwqWcRBhbuQvtJbkJ4q+0wPWtYI+3IAbDXfbg2Y4Qzqkg8OURiSXhcIZAyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPD80tG7FgwYOB9ot4RNZJ/WPPDkfSKnQwJEYybNJeQ=;
 b=K1vn3f43sutZwuxxB+oYIuZ3bgce88Ij+wbQMyO/hcNCioksFEksRgGOrd/kOQrYLHmUuIu7TisSMhkGJwtUrt6yMTPGy8Sf9rQCKAjYO7dwI+7CCJRcTpXSeAJUnsjge159itjgWQT/2XCBELPqwwK5qfAOApCVK3GdCOfVzqs=
Received: from BL1PR13CA0234.namprd13.prod.outlook.com (2603:10b6:208:2bf::29)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 3 Jun
 2025 17:25:13 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::98) by BL1PR13CA0234.outlook.office365.com
 (2603:10b6:208:2bf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Tue,
 3 Jun 2025 17:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:25:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:25:11 -0500
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
Subject: [PATCH v9 13/16] cxl/pci: Introduce CXL Port protocol error handlers
Date: Tue, 3 Jun 2025 12:22:36 -0500
Message-ID: <20250603172239.159260-14-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d6df14-bbac-4111-89af-08dda2c3993c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OaCOOJ7+/aoL6+Yry/RmS/Fig5n0kbVTkVYzg4HX9pj3TJWTwxbnxHjWXEOL?=
 =?us-ascii?Q?RjSgIFktk1M7ltmp32RP2WOvfB1QiDA9xISW7U23wgz3wXvu5R3F40iwfZI+?=
 =?us-ascii?Q?sQw0nNY7yPlH3VpWrPl7eJ/V43UOxl+dg5gQIY3r00nA1hzTe0d7VbDbIkfQ?=
 =?us-ascii?Q?FUe3m2/hKApqjuKGSvCvL61z0mk0OUPqTdwjpcfJdse4KRSTtSVyN1U7nZkj?=
 =?us-ascii?Q?Cq61o63IiKkVMU2wW0iAIYHjVWekJ+afzN0DMEE+Jvpoa5E+7xnDE0P2m1yr?=
 =?us-ascii?Q?sHnWqEfe24FCjiM5rqSmyufo0tVPJsU9HNQtIgvSCFlOvY0UZjLRuQONO/pm?=
 =?us-ascii?Q?E4urAsmctjiYWXLh6oIQMFs0qf92OTq6Csk8OKFBAf8O1Vbayd3rJJGK/CFz?=
 =?us-ascii?Q?uyNucRcs+H6rWoDqEbSTXHUUHdv9yp07PredaOyBYUcYsNjOmdcJkIq1oXYM?=
 =?us-ascii?Q?LYXzkCczwo3ttwpAaKFPGiupf/UuD00dUqZ4c3uOsbAhIzI0xZPkwmfpuPm3?=
 =?us-ascii?Q?pVxh9w6UFWsVNXpPVOCUMPx9GykmHosoZOpjopupOi0VkFdHb/iwKwzrgHGU?=
 =?us-ascii?Q?Tl1CuZh+BLgvnGD44lnUdAIzY/IfSZloKkq+nSi4fuXy25s+AJJ3MrWChM8Z?=
 =?us-ascii?Q?CQDX1R7SyPqtsbrUs6QrawSsoFHpS1jCXW/YlkvzQD1Pm4/xBUu6ZSixJn0x?=
 =?us-ascii?Q?qIOpkdwDWv0DRsxJdXL+tUcwiZ5too1EcmwcCEiKF/37YxrXlpQYrHruzcpo?=
 =?us-ascii?Q?v1nARDK66t0UYF9JquZ43qdwvHiiQJvbCKA7LrkX+AWmXyvYOh9lpQdfKxeU?=
 =?us-ascii?Q?mP6BBUaHkLz1O9Lc8h9vxQUR0SyOXdZSgQRlx8tJjnb4BK7l6JAcErKC4c4z?=
 =?us-ascii?Q?FDWc1MPfOtpPqGfQ97LVOfvtdPtx49ASCQv6GhKMYct49BNJEwrH8ACN7ZB8?=
 =?us-ascii?Q?58w/AuH2urvddDDEzaiiY+h0LjrofMNXjOZMfXjrCSwkT62EbeZbgX1eYc/E?=
 =?us-ascii?Q?iQTB1tpBhnumdsrjGpKkdpvmlZaEYGSIr7+4kNovjw5BJPdJRZsccBPJmFlU?=
 =?us-ascii?Q?0Za+LQQUoIopmldUPz11LqsSDa4iyiGXVZh91VjE1ganj0PCo4Ush7A2aoTv?=
 =?us-ascii?Q?4KqpanYOSinLG/vndcSDumnXjENS1P5Fr5UXxAGKYGd2VFin/tfhqXpeQGAY?=
 =?us-ascii?Q?rd0iYOb83ScTGzBwyPktaB4GucAZw9NDJ37vCB1D1c6Q2wcNTB6TLUCMu+fB?=
 =?us-ascii?Q?NqjqMWNMQCecJHmSCmgiVSFfxB5Chu6hSVijgmuqLuayw5SrSjMkcsbTYgFO?=
 =?us-ascii?Q?C5EKRc8caXPP5bhtQDyYerrAyfTe4N79QI7RMV6Uvz6qtb/bZlxrhqx6gzGD?=
 =?us-ascii?Q?vmQ/IphPZ1ww4k0vG8MP0zvIM+E/3aLdDPmx3gAtmiYU8qI2DByyYgcn8UT9?=
 =?us-ascii?Q?wIFu0PEBMesMjZ/7v2IHw90VVUoQT9atJkXa1cmyAcjUpsC5lOQN0j9ti+Dt?=
 =?us-ascii?Q?wkDuXJF7aiuDaQRg/dUfxJLNWNKdPZZh0kFnYppIGMfok2w1iDP/Vgagug?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:25:12.9236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d6df14-bbac-4111-89af-08dda2c3993c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859

Introduce CXL error handlers for CXL Port devices.

Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
These will serve as the handlers for all CXL Port devices. Introduce
cxl_get_ras_base() to provide the RAS base address needed by the handlers.

Update cxl_handle_prot_error() to call the CXL Port or CXL Endpoint handler
depending on which CXL device reports the error.

Implement pci_get_ras_base() to return the cached RAS register address of a
CXL Root Port, CXL Downstream Port, or CXL Upstream Port.

Update the AER driver's is_cxl_error() to remove the filter PCI type check
because CXL Port devices are now supported.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h |  2 +
 drivers/cxl/core/pci.c  | 61 ++++++++++++++++++++++++++
 drivers/cxl/core/port.c |  4 +-
 drivers/cxl/core/ras.c  | 96 ++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h       |  5 +++
 drivers/pci/pcie/aer.c  |  5 ---
 6 files changed, 155 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c73f39d14dd7..23d15eef01d2 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -122,6 +122,8 @@ void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
 
 #ifdef CONFIG_CXL_FEATURES
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e094ef518e0a..b6836825e8df 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -753,6 +753,67 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static void __iomem *cxl_get_ras_base(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	void __iomem *ras_base;
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport = NULL;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport || !dport->dport_dev) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		ras_base = dport ? dport->regs.ras : NULL;
+		break;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port;
+		struct device *dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL,
+									&pdev->dev, match_uport);
+
+		if (!dev || !is_cxl_port(dev)) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		port = to_cxl_port(dev);
+		ras_base = port ? port->uport_regs.ras : NULL;
+		break;
+	}
+	default:
+	{
+		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+		return NULL;
+	}
+	}
+
+	return ras_base;
+}
+
+void cxl_port_cor_error_detected(struct device *dev)
+{
+	void __iomem *ras_base = cxl_get_ras_base(dev);
+
+	__cxl_handle_cor_ras(dev, 0, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	void __iomem *ras_base = cxl_get_ras_base(dev);
+
+	return  __cxl_handle_ras(dev, 0, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
+
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eb46c6764d20..07b9bb0f601f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1341,8 +1341,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 664f532cc838..6093e70ece37 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -140,20 +140,85 @@ static pci_ers_result_t cxl_merge_result(enum pci_ers_result orig,
 	return orig;
 }
 
-static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
+int match_uport(struct device *dev, const void *data)
 {
-	pci_ers_result_t vote, *result = data;
-	struct cxl_dev_state *cxlds;
+	const struct device *uport_dev = data;
+	struct cxl_port *port;
 
-	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
+	if (!is_cxl_port(dev))
 		return 0;
 
-	cxlds = pci_get_drvdata(pdev);
-	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
+	port = to_cxl_port(dev);
+
+	return port->uport_dev == uport_dev;
+}
+EXPORT_SYMBOL_NS_GPL(match_uport, "CXL");
+
+/* Return 'struct device*' responsible for freeing pdev's CXL resources */
+static struct device *get_pci_cxl_host_dev(struct pci_dev *pdev)
+{
+	struct device *host_dev;
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport = NULL;
+		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport || !dport->dport_dev)
+			return NULL;
+
+		host_dev = &port->dev;
+		break;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port;
+		struct device *cxl_dev = bus_find_device(&cxl_bus_type, NULL,
+							 &pdev->dev, match_uport);
+
+		if (!cxl_dev || !is_cxl_port(cxl_dev))
+			return NULL;
+
+		port = to_cxl_port(cxl_dev);
+		host_dev = &port->dev;
+		break;
+	}
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_RC_END:
+	{
+		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+		if (!cxlds)
+			return NULL;
+
+		host_dev = get_device(&cxlds->cxlmd->dev);
+		break;
+	}
+	default:
+	{
+		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+		return NULL;
+	}
+	}
+
+	return host_dev;
+}
+
+static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
+{
+	struct device *dev = &pdev->dev;
+	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
+	pci_ers_result_t vote, *result = data;
 
 	device_lock(&pdev->dev);
-	vote = cxl_error_detected(&pdev->dev);
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
+		vote = cxl_error_detected(dev);
+	} else {
+		vote = cxl_port_error_detected(dev);
+	}
 	*result = cxl_merge_result(*result, vote);
 	device_unlock(&pdev->dev);
 
@@ -244,14 +309,18 @@ static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
 static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
 {
 	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
 
 	if (!pdev) {
 		pr_err("Failed to find the CXL device\n");
 		return;
 	}
 
+	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
+	if (!host_dev) {
+		pr_err("Failed to find the CXL device's host\n");
+		return;
+	}
+
 	/*
 	 * Internal errors of an RCEC indicate an AER error in an
 	 * RCH's downstream port. Check and handle them in the CXL.mem
@@ -261,6 +330,7 @@ static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
 		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
 
 	if (err_info->severity == AER_CORRECTABLE) {
+		struct device *dev = &pdev->dev;
 		int aer = pdev->aer_cap;
 
 		if (aer)
@@ -268,7 +338,11 @@ static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
 						       aer + PCI_ERR_COR_STATUS,
 						       0, PCI_ERR_COR_INTERNAL);
 
-		cxl_cor_error_detected(&pdev->dev);
+		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
+		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END))
+			cxl_cor_error_detected(dev);
+		else
+			cxl_port_cor_error_detected(dev);
 
 		pcie_clear_device_status(pdev);
 	} else {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6fd9a42eb304..2c1c00466a25 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -801,6 +801,9 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 void cxl_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_error_detected(struct device *dev);
 
+void cxl_port_cor_error_detected(struct device *dev);
+pci_ers_result_t cxl_port_error_detected(struct device *dev);
+
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
@@ -915,6 +918,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int match_uport(struct device *dev, const void *data);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6e88331c6303..5efe5a718960 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1018,11 +1018,6 @@ static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	/* Only CXL Endpoints are currently supported */
-	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
-		return false;
-
 	return is_internal_error(info);
 }
 
-- 
2.34.1


