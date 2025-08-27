Return-Path: <linux-pci+bounces-34840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0B7B3773F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4D6F4E311E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A80D19F40A;
	Wed, 27 Aug 2025 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bwF0YNug"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329B1DB95E;
	Wed, 27 Aug 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258811; cv=fail; b=Mc26fhKc76Bq0Rqpl3YG/W2lXY53WKIgyPE2f0lmWKC7V7WX4O/98WM1T9ErXYiPwaacIPD269yOY4f3T0Ed37zbdnQ99cMhe+XlS08gt2xzmhgjDt7RtsIw+ezEk2coak0UeLJAcsr6qhM9MMx6PgycjEjn/SZyemOX+nWdenw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258811; c=relaxed/simple;
	bh=9Nxhsq3n+wFPjUQyOk0dp5ReBs3Be+dvk9df4c9O+MI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwywznJxyfT2/N7ZKBmmDxz08lPZcARYUlITwbxOBC8f7ecDa2hMb5p1LujgVEES1P6/YkdpVRjbPCYVVvw8+PE00tctgHUfJQCD47IF30H3sHkSRHDf/xPr+ND1nHpyUSigyjJ0B/1DSYQSq+QP86HDYUcSp4rsDUVMGNTvCX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bwF0YNug; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1VmuuE/UI/827/mF5kO6PEGQwaogOoGpcQZsfbRleXczR8Tjc1+gJ+lLiCWdb0USRqc5cPgO7t5XbB7r2oDMtLDvYRiTeZ9rQFqqOjO/wRQkmCNf8CLmKTPsGG00vHFM2+fgvTomEG0K/j9ReWqPbMClg/8zAr5Uoak0wCRY0kH4l/WpZw4kbNxGKHLkFS8Ndpa1y3rEBTnXyMnVx2l6iYWCObiA3/Mu++IjFoue8GsfvZopVhNRKfeE7uB6fU4spsidzP2TBBX1W58WsBwqbg3/yVDlNnE2DSQOEYyNb4w+dBX3Ik7nBaWmLdaOAcqMgNROgV0XcwUDtj0IdkJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV35K+bZrnXhXkPR1L/VtfJHxpsAt15a1cWjLz0XtBA=;
 b=Mpp7DphYNBEv7v58nE2+xGrwfz4W79c8bts+I8r05bYjMhlRJRjnH9LWFxQh9KJxEf2pBpzr78Ie8XE5mftks2sDC4qEqjQBTfNLuNk5apP1fhHrfJoZrzWsnYj7Vugf9JoLT2HFj/BnBSIGWtC6aeuucA0Pcs0jr6DeWUYfSeEImh3Kd58DV2Zzy70G2dF/VJwSPs9omr0wJ5Xz2m9qkYRbz7C39TTCwkKxP/0TN91rxTrpfGzTHXcAQ/ZxtgtmAUADlnDPQr8Zizuccl18+f3uuO2GN2m6Rbr5Ydj7H6Opf+V76SmyrCTZtdYaWQ6GqgfVDhrReH5C4BIXF5UrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV35K+bZrnXhXkPR1L/VtfJHxpsAt15a1cWjLz0XtBA=;
 b=bwF0YNugYeqXMcMQB56sprAEW73gbCi1D1euljaUUmLai2il0Wi9kOGF3WYN8cU4OV8ZeJgrL3uuhvS9NlF6LJiiMrWh4KErYv/jGt7jR8LMW97YkPEE7S+HoeJ31/gI5Adl1U/SeRfOXNKiUEi2izJB7R+039smFPB4WFredo8=
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 01:40:02 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2d) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Wed,
 27 Aug 2025 01:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:40:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:40:00 -0500
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
Subject: [PATCH v11 23/23] CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
Date: Tue, 26 Aug 2025 20:35:38 -0500
Message-ID: <20250827013539.903682-24-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 73034174-0a8d-486f-eb5a-08dde50aa3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/lH9Jp2fl3PPHBtp/MzaTz4LE4pxRiOEb+bqEEfAICGf+GdNtsk4EqgTGRc?=
 =?us-ascii?Q?Vo7+v1/hSVeb9Ki5tsQ5O+O5s5dMTYptg8+KPqCKoBPrt0vEtRtX/E+k1a1t?=
 =?us-ascii?Q?KdMbM8sZin4LSQwNx9fvjzitXzl/kYE7MuOeBryHMAawuEeS57DtVtEE2WBh?=
 =?us-ascii?Q?ZqzTYODRITnZD37VfmZoYSZIs+GcytUSqARr4j+HhIVVm7gy9eygJh29xxGz?=
 =?us-ascii?Q?ZwiEvPOOi3cUD5th10fRVW/UEdOg6RQ6yXV1kxJh7p+U3zCHFXT0W8gfFu8p?=
 =?us-ascii?Q?MAEh/TFsGx4meTzCrybs/rpfQ7ii165xio9H3KazGZS1wam2JHtS+O6HUvsm?=
 =?us-ascii?Q?6v0u83VzSHogHrvSb2qY64TMavu1TdyeWoU94K7UguuWhGCsc9BnDTeVH4JQ?=
 =?us-ascii?Q?xEcdzmHP6SjI45aOGPoumOJJsuXFjdxzgv6VHq2/IW7k/5RwLjU6Zy18WzSo?=
 =?us-ascii?Q?Si0pDItO6Am4myzysiuouJc8W0IkjEtYfyAt8qqxoRuJOkv4uQpcVaZxvWPx?=
 =?us-ascii?Q?sRdFO5oJNH12G0c5d2iDx1JVONRQ9Qb2KQj2O3xzQvZrDzbhQlyydK3/soVg?=
 =?us-ascii?Q?QN5xY6VZMTgamRCtchveJdatj/glWnKNlp7jiMRdhIFU7/j1bCc61ME+cacj?=
 =?us-ascii?Q?YJhniJcfc7GACNHI/pF8Tcp8dqmPOOZq/An3OgOQyBgcJszOcTysG7CTqYS+?=
 =?us-ascii?Q?8EjzJX1NSR0Dpa5/AuoI6EnNKfBsvBsTgp0iR/TnOUU0gc90tTX9tSn7jqn2?=
 =?us-ascii?Q?B2EmW5WPAl6a7F6ikYujGiG1A56NTXKtmRSuTRj+wIM9zDu2LkKpN23GsBcU?=
 =?us-ascii?Q?kokPnDU55WXYLgneSuLRTvo0ZpupZF1IifMrj0ov3iIkYggVqQ8SiRFKf+dx?=
 =?us-ascii?Q?Z1hIW+ZDvkwA2g8iqPIBuYUO4VcI0P0GqgLO6pGEK21BN/ZYXbi0oQjsFiaK?=
 =?us-ascii?Q?+hc0qcr0LOVV0d0cYZjQQINZxmw3+J5mt2Fwusv1aTVR2ROVXgjknW6+y5H4?=
 =?us-ascii?Q?paFO3/TWRroYDwfNgbytworjnKcCAkLxbr+/oyn0ntCGtE+T3iz92eneY0eV?=
 =?us-ascii?Q?CQ4TtY7snwiIw+80go4Ruq2zsr2P/nv5TZzlw53bYdz5cJJ3k3ZQzHUwNmia?=
 =?us-ascii?Q?Q2JSQ/dZ8LBO9tilP2hC4qYmE13PsnpXHQg5AkhVWzOYKTvMoCiErCQWL9JJ?=
 =?us-ascii?Q?xLVJ4cLd+SnmczRRYhSrHaMnoiTJ6kaoWsPtJC5f1oOBO8JbKk/dcKMJH8t9?=
 =?us-ascii?Q?kblQgKUsjKmIDrts/5KUf8uu5HuUDRUXRRU7ILa7SKAGq39eWuZBzNsSeOqX?=
 =?us-ascii?Q?dUpboJ+EGWdTke8WuB5ndjBsK87RvQLiN/gWhklprEg0BwNcH+1EQRWdfPEL?=
 =?us-ascii?Q?IgPrWvJ9+oL2kzElyoKJLe1e2EQSe2rSvdJmdjsdx06mRbMXkDFhn+93fMFH?=
 =?us-ascii?Q?zgDS2315+n0O8t+1CMFTnVwEIBi6JwFlGvj84rdXvS0+ZZJSy116K4U0OEzr?=
 =?us-ascii?Q?c3oQgs2iZUmGn4Hj5PJ6zXaB5KoEAXuF0i2o5pAiAfOOnP7ApvdOpISBqA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:40:01.7060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73034174-0a8d-486f-eb5a-08dde50aa3e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

During CXL device cleanup the CXL PCIe Port device interrupts remain
enabled. This potentially allows unnecessary interrupt processing on
behalf of the CXL errors while the device is destroyed.

Disable CXL protocol errors by setting the CXL devices' AER mask register.

Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().

Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
Endpoints. Follow the same "bottom-up" approach used during CXL Port
teardown.

Implement cxl_mask_proto_interrupts() in a header file to avoid introducing
Kconfig ifdefs in cxl/core/port.c.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---
Changes in v10->v11:
- Removed guard() cxl_mask_proto_interrupts(). RP was blocking during
  testing. (Terry)
---
 drivers/cxl/core/core.h    |  2 ++
 drivers/cxl/core/port.c    |  6 ++++++
 drivers/cxl/core/ras.c     |  8 ++++++++
 drivers/pci/pcie/cxl_aer.c | 21 +++++++++++++++++++++
 include/linux/aer.h        |  2 ++
 5 files changed, 39 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 7e66fbb07b8a..385bfd38b778 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -157,6 +157,7 @@ void cxl_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_error_detected(struct device *dev);
 void cxl_port_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_port_error_detected(struct device *dev);
+void cxl_mask_proto_interrupts(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -186,6 +187,7 @@ static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
 {
 	return PCI_ERS_RESULT_NONE;
 }
+static inline void cxl_mask_proto_interrupts(struct device *dev) { }
 #endif // CONFIG_CXL_RAS
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 085c8620a797..bb326dc95d5f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1428,6 +1428,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
  */
 static void delete_switch_port(struct cxl_port *port)
 {
+	cxl_mask_proto_interrupts(port->uport_dev);
+	cxl_mask_proto_interrupts(port->parent_dport->dport_dev);
+
 	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
 	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
 	devm_release_action(port->dev.parent, unregister_port, port);
@@ -1441,6 +1444,7 @@ static void reap_dports(struct cxl_port *port)
 	device_lock_assert(&port->dev);
 
 	xa_for_each(&port->dports, index, dport) {
+		cxl_mask_proto_interrupts(dport->dport_dev);
 		devm_release_action(&port->dev, cxl_dport_unlink, dport);
 		devm_release_action(&port->dev, cxl_dport_remove, dport);
 		devm_kfree(&port->dev, dport);
@@ -1471,6 +1475,8 @@ static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 
+	cxl_mask_proto_interrupts(cxlmd->cxlds->dev);
+
 	for (int i = cxlmd->depth - 1; i >= 1; i--) {
 		struct cxl_port *port, *parent_port;
 		struct detach_ctx ctx = {
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 90ea0dfb942f..564144c2d23f 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -137,6 +137,14 @@ static void cxl_unmask_proto_interrupts(struct device *dev)
 	pci_aer_unmask_internal_errors(pdev);
 }
 
+void cxl_mask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_aer_mask_internal_errors(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mask_proto_interrupts, "CXL");
+
 #ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
index 6eeff0b78b47..2de2d9e7934b 100644
--- a/drivers/pci/pcie/cxl_aer.c
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -46,6 +46,27 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
+/**
+ * pci_aer_mask_internal_errors - mask internal errors
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Masks internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+void pci_aer_mask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+				       0, PCI_ERR_UNC_INTN);
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
+				       0, PCI_ERR_COR_INTERNAL);
+}
+EXPORT_SYMBOL_NS_GPL(pci_aer_mask_internal_errors, "CXL");
+
 bool cxl_error_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4e2fc55f2497..82264221ad09 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -83,12 +83,14 @@ void cxl_register_proto_err_work(struct work_struct *work);
 void cxl_unregister_proto_err_work(void);
 bool cxl_error_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+void pci_aer_mask_internal_errors(struct pci_dev *dev);
 #else
 static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
 static inline void cxl_register_proto_err_work(struct work_struct *work) { }
 static inline void cxl_unregister_proto_err_work(void) { }
 static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
+static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.51.0.rc2.21.ge5ab6b3e5a


