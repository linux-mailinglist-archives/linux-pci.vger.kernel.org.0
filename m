Return-Path: <linux-pci+bounces-34836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D464EB37735
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1343A3B41A9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CAF21C19E;
	Wed, 27 Aug 2025 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d+QWmMqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD621CA02;
	Wed, 27 Aug 2025 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258764; cv=fail; b=Tm0u6nyuty6gK0ZtlM8eUjT+9RSyc7dU3IdD328vr3gB54wcLw4d9THjRKLPV50VlSssk08mlfIU8wncwawctDbOp/1FKROgfJ+6t9DedLPTSeVqLyW+dpbPQUKbN/3EzPbFXXEpcri10fs/aooJ5DebehtRSVGYMAHa9u3ZQLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258764; c=relaxed/simple;
	bh=+XgSYcvm116gXqEqBjoGly+oZI+Rv8/RAfKdgWt+YTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zouzd8hrURJfx5/NsuEXQWeceoP9LGq6xho2mRDYgVR7iU1m1WlqDx0p6K8bMLosC5PUGm7L3U52L78aE6XUnPRjEF2pTave8yOb2eVV5hZfOCo76GeJrd0h9OCyinB10zARl1EcEn+tIbc0fT4XcaXxDU5A+SBem2rFjgCxku8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d+QWmMqz; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT49ugQ+9Ew4HyK9Rdb1cgMUxzDrq7snYdySJ2JjLx9fz5TFjdnnk594xsKqUmuQU3scvUxmKXLQWr1iMPX20lQ4vGFi42LCi+DDH9Xv6foqbZtzX5yHLsAZaxxd648nqiEFmOdFiPqJJuhx3yeY1PQdk9Bck46RZ2l0ZzDmnYybR57CSYITxVd+5SbENjvanHeYx/qY3k9T7YGNmKlHiJ8MWFdWfm7SL3r/xx2Vr6bYGnfl586ZT6LYAPxcya3fRtfkfm0BATqqDRvJuwPtO7fTOkCFgCLdgzZtd1wLXWfEdC2vxUtM9CtrPXjI86K/T2/AsI+fI6UGCOs+TG9JBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv2OIMtwnIt2ZQXZ6O3nAnhAUMUe4SiCkorAP5UKjmo=;
 b=rP04YA2ocNXnJLtPuWaoeTo8pRXhMtZHRcp0uRW4SoP205xrhJdjDwLpQs2cY8tl4TFWm6UFMYh9xV7w4mTf++jkVTemYYQc+9V09Y5xbm3N/RESDjsJ3MUh7m0aNql4PynzLr5rI88ASgkJZCZedCyMfzQcmEssY13XIBp72Q2VTXkLmvMY5zGQxk2BtFyMkGueCWkCMtW75Z9GdUBA/P4RV/6Yg2tbrc6iKkYTTAQdCB2YPKbxVfp5GHRLvM59pFcocJWrrlOzr1FU3DtJIqWUwUL1oXdxCBTy73SQqifpRc67ddeOMo98sNBP8Ld8U2CuI95uL5OaFghh6dQGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv2OIMtwnIt2ZQXZ6O3nAnhAUMUe4SiCkorAP5UKjmo=;
 b=d+QWmMqzvz6gV4i4gJVEVdhA13jtoPmC7vCbdGpnd87u/QXWxidmoFO7KDjQaqiI+Dk7o4OETpCVLQkwvJtH+7uWpJ4SsBynYToboEKAWdVKR6PjgHfp8dXldrHBAp/g5yboSGah2drecuGKbgFeO9ks9cbKxlY2LCPLGXP0QfE=
Received: from BY5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:180::44)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:39:17 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::74) by BY5PR13CA0031.outlook.office365.com
 (2603:10b6:a03:180::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 01:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:39:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:39:16 -0500
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
Subject: [PATCH v11 19/23] CXL/PCI: Introduce CXL Port protocol error handlers
Date: Tue, 26 Aug 2025 20:35:34 -0500
Message-ID: <20250827013539.903682-20-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8801d9-8da9-4071-2642-08dde50a8973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yuoz8OjTFEEUz+xXDDDBQx9CQ/iR+A2iu+8reo+PFIFvf2efJVm84/nz5RIR?=
 =?us-ascii?Q?5fAp8cjtc96xLFpDUNugOdzycnftZk7SrD1eveT6klYYywEh7UemOhXsDb1I?=
 =?us-ascii?Q?xPZRdMrQ056Ed6CAvsWYpxaCCtt9hGL/Pk1yxxMc+uwsux5merzWcACP3vaH?=
 =?us-ascii?Q?Lq94mQ3hWwuhHxU4N/lwXMYji+pio/Ncqh7f7eD+PKaLnffCbQUROU49PLQs?=
 =?us-ascii?Q?QItv976RLkPhJ+UZxHSK9j69YI0apvTJcDce/Na20gyGOeTx92S4xvAFYyjP?=
 =?us-ascii?Q?l6Z2P5xSWwgG4aZSLjixgTcSBzKt+UONIkBR1K1NFIovrT58JJ6ySU9b5Oub?=
 =?us-ascii?Q?VnSMh+u8zyzCRE1hJWjxZnz0ZpW9e11yNbrSwSNtkzqkVdWjgfQwoq3iwF3d?=
 =?us-ascii?Q?dYP85GceD38m8JFaYvpNUOwsxjsxP2zjt8dk6W57HxlAJ/mN9nsbJ6LWRu8u?=
 =?us-ascii?Q?pKxjtJKV9Dr33MsyBiQOqStnBErdyWhzD8NyxRBVo8WxNNPnmHjd5SrtZuJd?=
 =?us-ascii?Q?4WJP6gv6gV6mWvJQY2TZPGAaYlA7EhsMJ4KaJ0llr66dLjcwAlF4usFKysVu?=
 =?us-ascii?Q?GmUu1LlNh1B3Ne8fbTLo3K8thbR6UoprGF/mQ2uWmW395KpEXDZIY9CXzeUN?=
 =?us-ascii?Q?WneoRZq/m6J2F/GLp8Dt+Ky6JyBNDvuWZcz9r/MyAKAH97+/0ttiDyaR4ARz?=
 =?us-ascii?Q?5qiWUkAesfCqS95hdpCBqhewVJYbbNVGra24KkzbzwHBmKx5u+RaFMpiuEG1?=
 =?us-ascii?Q?IqmnO6m8GK5ZKsagTMqV/h59hYFsmcVsIIZmZI31Q1+1S/JJ++btzDmcCdBr?=
 =?us-ascii?Q?+MC8ete6pf/wt4uoOxlhm2SHSuez/gHwUN7g2VLAdX5/sZ5Huri6WWNdJH9/?=
 =?us-ascii?Q?AaE+MkTQ63pFYF56yoC6AAMifX9OJtzm+GTE/g73BXkDv4k5m/iZ06DY82mI?=
 =?us-ascii?Q?Hmckw5x5i1PVgEanNxqKLg110VLXPRVYNHaduAWwH97OwvvzdTvOuItm5U6s?=
 =?us-ascii?Q?9UZHQSVi9ohMa1jv/He6NVBUbfLsoByo72LT+aTSiZc6YRBd1HhMYkG0W1N8?=
 =?us-ascii?Q?0K/ftEA5LB+YExIQKd/LHeu0GdzdUOroPGpHsUKqaN+44ZfK7DaWMMcNTidx?=
 =?us-ascii?Q?OnaaThToulFGcoDTOvFqjGi0+/wUmrkAPM8isTJElfEx3BhiRgPdt9eakdHS?=
 =?us-ascii?Q?GXZqUfN3dkXt3yuFLupXFORE30y641pN+8btCxDbU7K+Nkit8MhzDDxBLuse?=
 =?us-ascii?Q?ATvI0vg81igMb8uN98XWF/f/RhE0iPCwLwa0zPCZTMtwSuvSxa805ZgG8SR5?=
 =?us-ascii?Q?fkNlhAwC6O4zjAkwgi0dkB0UjbqfHDObIkH0fFgohdHDjd+c5weDmVxGX2bg?=
 =?us-ascii?Q?Q51q4Q0ooozOwiYn9U3WVufwOEg3gC9TzDM8CRfd2c1ceCcsp+3wfAQiYCCp?=
 =?us-ascii?Q?rN5nFmPLPnPRer6FmJN94vQKtEkiwzHnEDM7a5tyaP3KETKcxjb4qcC4v4ZD?=
 =?us-ascii?Q?B+OSDb/W+bVkGrdLL6tVwyumcaoDHw6MXU8nqu1hrdWw484cKtF7Z6ME3g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:39:17.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8801d9-8da9-4071-2642-08dde50a8973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160

Introduce CXL error handlers for CXL Port devices.

Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
These will serve as the handlers for all CXL Port devices. Introduce
cxl_get_ras_base() to provide the RAS base address needed by the handlers.

Update cxl_handle_proto_error() to call the CXL Port or CXL Endpoint
handler depending on which CXL device reports the error.

Implement cxl_get_ras_base() to return the cached RAS register address of a
CXL Root Port, CXL Downstream Port, or CXL Upstream Port.

Introduce get_pci_cxl_host_dev() to return the host responsible for
releasing the RAS mapped resources. CXL endpoints do not use a host to
manage its resources, allow for NULL in the case of an EP. Use reference
count increment on the host to prevent resource release. Make the caller
responsible for the reference decrement.

Update the AER driver's is_cxl_error() PCI type check because CXL Port
devices are now supported.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---
Changes in v10->v11:
- None
---
 drivers/cxl/core/core.h    |   9 ++
 drivers/cxl/core/port.c    |   4 +-
 drivers/cxl/core/ras.c     | 176 +++++++++++++++++++++++++++++++++++--
 drivers/pci/pcie/cxl_aer.c |   5 +-
 4 files changed, 186 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 6e3e7f2e0e2d..7e66fbb07b8a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -155,6 +155,8 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 void pci_cor_error_detected(struct pci_dev *pdev);
 void cxl_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_error_detected(struct device *dev);
+void cxl_port_cor_error_detected(struct device *dev);
+pci_ers_result_t cxl_port_error_detected(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -179,9 +181,16 @@ static inline pci_ers_result_t cxl_error_detected(struct device *dev)
 {
 	return PCI_ERS_RESULT_NONE;
 }
+static inline void cxl_port_cor_error_detected(struct device *dev) { }
+static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	return PCI_ERS_RESULT_NONE;
+}
 #endif // CONFIG_CXL_RAS
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 29197376b18e..758fb73374c1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1335,8 +1335,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
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
index a2e95c49f965..536ca9c815ce 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -251,6 +251,154 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 		dev_dbg(dev, "Failed to map RAS capability.\n");
 }
 
+static int match_uport(struct device *dev, const void *data)
+{
+	const struct device *uport_dev = data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return port->uport_dev == uport_dev;
+}
+
+static void __iomem *cxl_get_ras_base(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
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
+		if (!dport)
+			return NULL;
+
+		return dport->regs.ras;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port;
+		struct device *port_dev __free(put_device) =
+			bus_find_device(&cxl_bus_type, NULL,
+					&pdev->dev, match_uport);
+
+		if (!port_dev || !is_cxl_port(port_dev)) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		port = to_cxl_port(port_dev);
+		if (!port)
+			return NULL;
+
+		return port->uport_regs.ras;
+	}
+	}
+
+	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
+
+static struct device *pci_to_cxl_dev(struct pci_dev *pdev)
+{
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport = NULL;
+		struct cxl_port *port __free(put_cxl_port) =
+			find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		return dport->dport_dev;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port;
+		struct device *port_dev __free(put_device) =
+			bus_find_device(&cxl_bus_type, NULL,
+					&pdev->dev, match_uport);
+
+		if (!port_dev || !is_cxl_port(port_dev)) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		port = to_cxl_port(port_dev);
+		if (!port)
+			return NULL;
+
+		return port->uport_dev;
+	}
+	case PCI_EXP_TYPE_ENDPOINT:
+	{
+		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+		return cxlds->dev;
+	}
+	}
+
+	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
+
+
+/*
+ * Return 'struct device *' responsible for freeing pdev's CXL resources.
+ * Caller is responsible for reference count decrementing the return
+ * 'struct device *'.
+ *
+ * dev: Find the host of this dev
+ */
+static struct device *get_cxl_host_dev(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport = NULL;
+		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
+
+		if (!port)
+			return NULL;
+
+		return &port->dev;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct device *port_dev = bus_find_device(&cxl_bus_type, NULL,
+							  &pdev->dev, match_uport);
+
+		if (!port_dev || !is_cxl_port(port_dev))
+			return NULL;
+
+		return port_dev;
+	}
+	/* Endpoint resources are managed by endpoint itself */
+	case PCI_EXP_TYPE_ENDPOINT:
+		return NULL;
+	}
+
+	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
@@ -399,6 +547,22 @@ static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __io
 	return PCI_ERS_RESULT_PANIC;
 }
 
+void cxl_port_cor_error_detected(struct device *dev)
+{
+	void __iomem *ras_base = cxl_get_ras_base(dev);
+
+	cxl_handle_cor_ras(dev, 0, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	void __iomem *ras_base = cxl_get_ras_base(dev);
+
+	return cxl_handle_ras(dev, 0, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
+
 void cxl_cor_error_detected(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -469,9 +633,8 @@ EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
 static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
 {
 	struct pci_dev *pdev = err_info->pdev;
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
+	struct device *dev = pci_to_cxl_dev(pdev);
+	struct device *host_dev __free(put_device) = get_cxl_host_dev(&pdev->dev);
 
 	if (err_info->severity == AER_CORRECTABLE) {
 		int aer = pdev->aer_cap;
@@ -481,11 +644,14 @@ static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
 						       aer + PCI_ERR_COR_STATUS,
 						       0, PCI_ERR_COR_INTERNAL);
 
-		cxl_cor_error_detected(&cxlmd->dev);
+		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
+			cxl_error_detected(&pdev->dev);
+		else
+			cxl_port_cor_error_detected(dev);
 
 		pcie_clear_device_status(pdev);
 	} else {
-		cxl_do_recovery(&cxlmd->dev);
+		cxl_do_recovery(dev);
 	}
 }
 
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
index 74e6d2d04ab6..6eeff0b78b47 100644
--- a/drivers/pci/pcie/cxl_aer.c
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -68,7 +68,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
 		return false;
 
 	return is_internal_error(info);
-- 
2.51.0.rc2.21.ge5ab6b3e5a


