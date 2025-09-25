Return-Path: <linux-pci+bounces-37055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12157BA1D85
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88593B3433
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE79324B07;
	Thu, 25 Sep 2025 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E2nNzW+h"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6F322C85;
	Thu, 25 Sep 2025 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839925; cv=fail; b=di7ttZrRjAK7ckHHcQpvGagCpFczlwZzeiYSOK+/4+zNWe/hNrsUatFUpVKQSCWi5i5XdMK35Dl++jkfw7FR/NrhlL+K28hS/UoTa8Q6EkAH5k481qcfMk3Vxv46aGn5VfMWvPXyQQoCTeuxaErf2qUR/k+shXkHzOnpEFRJ3b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839925; c=relaxed/simple;
	bh=a243bz54gaiF+bMy3w5gSXb1GwVxugp0B7Ep8Jvf0mE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQgbOymRhfXmwvA9RG9UZqxC5u2ZTFEghKicTTs6ABu9qpmSI7WMgkf/kxLgqp6m4JYo1P/eAhVr3wBqSZkdqKeom4NijOfoIPATbt+Bap9DY59Gb9S6VN6pqga7xo28oSC1LSLmThuqCXTc8H5Q8Tj3fBwU4xcPbW4CEabjG30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E2nNzW+h; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS5z6NH7ypXriGrpb95fT6Rb0OPEzgVjEL8auhc2HsuDynqCLh6xoULsnXujNMjH9/wrnBFjUVZxrh9lb8MmzBgjGW1cSQcG0T9c+Uz15pK8JWVDWu+MUZMyf9qcXdFTbQhIm/o62u0atTjtxm7I0UcNezCV8schAGOmXOmYU61ZKukK93TosNIOVq8bLb9VXlIXsJgyoqoootbgyxNU9MC3U9JKgeo1bf64cQ7hFXxXOIQ6h8k0fObW9H24RdSWXOI1NCOihi3PSQgDzN7siF6ooOzBEXuVsUT7Xgof74dP/iQ4/7AhSWERFdjtn2R5h4fP6XMkwDgnYcdMZIv7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EfWIn9tBvyU4nU9w/GiBAF1JBP+T1hpTHF5RtkT6m4=;
 b=aMMWv5QhZSPj+0b9vmxV5JhFVmu01XU35qvomTs9WA9LOb+sydaLk717iX755hwU/8Q1f+Ozz0/sJyGkWzkU8T6ILFIcfIKch2nSW8XKQ+HnCtvRIM5x5VVJ42QSAeOlLeELrtp5dpgY/6mybOKWcwhUH2oyDAltmK/ZhXEUjPv5tj6yScXhr+JILK60sCsoHob22vg2XhSQMO/375GJwB3C95GPb/MkxUEfgpgQm/QFNce5WssGATV1rD7SMxC5uZ3+5tyyKmJ3N0FLiKwkCE9U8ZKpMTLqFCdNK8y2OPKn68CAt9en5GsETE82epZHLhTuHkZWYHuEfvpFo03M7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EfWIn9tBvyU4nU9w/GiBAF1JBP+T1hpTHF5RtkT6m4=;
 b=E2nNzW+hVarwNGRM2Lc6Jo/3qR0A0k/xarOhMpWxksQCrmEdwlQ2XfapWUfJDKgWfFTOacGjv2eAobBjBNL1/Yn/aZuFJ18OcBXVhdMquP2N/f/1hMfJFz9P8SWHSfu2+a9gts9H6TRAUuFsFUQ2v7fcA3rONhMphy7B/u4OulM=
Received: from PH7P220CA0087.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::35)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 22:38:40 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::36) by PH7P220CA0087.outlook.office365.com
 (2603:10b6:510:32c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 22:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:38:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:38:38 -0700
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
Subject: [PATCH v12 21/25] CXL/PCI: Introduce CXL Port protocol error handlers
Date: Thu, 25 Sep 2025 17:34:36 -0500
Message-ID: <20250925223440.3539069-22-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9b3a97-0020-41a5-aed4-08ddfc84461a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dCXJ4z/WAoE3hVchjLClE5FZFt1NEBpwVIRcNATnKhDYBn04r90hyCNjkeLv?=
 =?us-ascii?Q?mf7Xszu/ghBotmIh2LFYetQ/6ahTdkBg+wPFpZ2JmCDSRY2UORbKMlUM9a2l?=
 =?us-ascii?Q?y4CMM95s3HtpGWwkLC6copRu8egHjorZRFZCsNgQWe4MsZG6FOa015ykF9N2?=
 =?us-ascii?Q?xhd37zsyFCipfLRLNQB00IupMr0lqoct1QijkZAVjK/7657Amh1aE7I8Y9Dp?=
 =?us-ascii?Q?5+VnYv+CFK4+eET/xq9VXnLighpHoeunBCx8zGASk/uQpEEZfhO3id/YsTQ1?=
 =?us-ascii?Q?O8Aic8+/C8fJAWMIgzbuokq37HV+2fb68I/F0UUAz0NFUfHX1Rz2QKrCJyd6?=
 =?us-ascii?Q?hoQMoYhzbXFLVXGBxIcc78/e65KmFK9DOP2oeCAaKd3V5zr6HqOiuSPrswgZ?=
 =?us-ascii?Q?aFFCgtDxWrrMIu7SgXrsQoIJmNHH43j8Grybj4/lrRpcpX+cCBzVCeAA0YDy?=
 =?us-ascii?Q?TxlKkiA19LRJtxEKWsYmZcX+8EZ/VpMlfbTcHpkOZ3Llc4a5XKTDl9pGY5TX?=
 =?us-ascii?Q?LtV0qO/9X6o3qdwg5tXEcKxthRHmMJSgehWSnE+u0NLClBvw8SGuSRCPpcZM?=
 =?us-ascii?Q?PzM+XoD3tuIxenDCSXtSAsiHNqFqYYsG5JZwBszr3XuS0EkvlRXjERMyfezU?=
 =?us-ascii?Q?sgbKvehDw+gE9QE/+O1Y6gZWKZz+vyvmD0cISvwktEzv/GMzcj5aLfywM0H1?=
 =?us-ascii?Q?whJbaC3bxEEQvlTulBfgiZLc4xAAICuGco/1+0lvG62AkA9W2GeWFHV4/2pZ?=
 =?us-ascii?Q?2hF0nYK63pXC9z1X5cv7ClLBOCfDCEyCzTfgs7c7gDOgh7PE1dLjneT65hUh?=
 =?us-ascii?Q?VHaz0IB5HWgwScjGkqRdSYEQPE5NsJ3c5q11NLok8ufdZJ3ZnxNBLjiNWLer?=
 =?us-ascii?Q?cXOtpSSzTK6Wl/rrFHDmQYMo998uLcj4GjuHPJ9tYL8YGFnuQAoJntvnc6Tb?=
 =?us-ascii?Q?ndo69PtZR4oKViZPQQ1VZohGKwZC+1sdIddjyJFErjhNuTSQKwZvFkp+f5Ax?=
 =?us-ascii?Q?/C1Lx7w3LiAnT/S1wojbSQpHnv3VqENoodIIsxAE6Jrn80gxJmgHtsJPVp8u?=
 =?us-ascii?Q?3PvyAoLR+GF7eiIiZltOWvUetwdQso2O+rrRP4naWVj1ClO/DMHeLbiaf8cq?=
 =?us-ascii?Q?Y4IT7cES2d8065fTwesuT9VttWQgHf4Z8fMQ8PbHviN4TKkGZOmSRSMfoje0?=
 =?us-ascii?Q?pS+K8bJh2xFRrPqy8pHsetad3epMBJwiMEiGbevJ2N0sHz1f7RFNBZlNUy3n?=
 =?us-ascii?Q?uwNGdMnw2/zHnOHmrFpbrcrjMvF+mUOnXh+J+XLsIuaNIb8S8/FylUmVUtwK?=
 =?us-ascii?Q?XknWVMAI3iiDO5JczbBw232XUtuI50hYpyc715iS4qyInJdxvA31Js3X///E?=
 =?us-ascii?Q?066VmThk9jvMwCHUfIlRh1XIqRzr5qeUkZXAeSx8dFUlETRRAtEf6Xfb3/6q?=
 =?us-ascii?Q?xr13zpHTVOAGNfLntJaLhDNALDwt5b1zH3V4J174+V7ITbpD/jJLypC6Sadw?=
 =?us-ascii?Q?ObVF8OL+JA/xlR8lSZm/HmEoRjv3vrpdO/Fa7h0KIGOQHyo3Y14DzZZjfXdM?=
 =?us-ascii?Q?t96NGbo+sgCutLLZlbaxs7G1UzsMZ6HV5InszBDd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:38:39.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b3a97-0020-41a5-aed4-08ddfc84461a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398

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

Changes in v11->v12:
- Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
  pci_to_cxl_dev()
- Change cxl_error_detected() -> cxl_cor_error_detected()
- Remove NULL variable assignments
- Replace bus_find_device() with find_cxl_port_by_uport() for upstream
  port searches.

Changes in v10->v11:
- None
---
 drivers/cxl/core/core.h       |  10 +++
 drivers/cxl/core/port.c       |   7 +-
 drivers/cxl/core/ras.c        | 159 ++++++++++++++++++++++++++++++++--
 drivers/pci/pcie/aer_cxl_vh.c |   5 +-
 4 files changed, 170 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 9ceff8acf844..3197a71bf7b8 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -156,6 +156,8 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 void pci_cor_error_detected(struct pci_dev *pdev);
 void cxl_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_error_detected(struct device *dev);
+void cxl_port_cor_error_detected(struct device *dev);
+pci_ers_result_t cxl_port_error_detected(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -180,9 +182,17 @@ static inline pci_ers_result_t cxl_error_detected(struct device *dev)
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
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 56fa4ac33e8b..f34a44abb2c9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1357,8 +1357,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1561,7 +1561,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 {
 	struct device *dev;
 
@@ -1570,6 +1570,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 		return to_cxl_port(dev);
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");
 
 static int update_decoder_targets(struct device *dev, void *data)
 {
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 9acfe24ba3bb..7e8d63c32d72 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -250,6 +250,129 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 		dev_dbg(dev, "Failed to map RAS capability.\n");
 }
 
+static void __iomem *cxl_get_ras_base(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport || !dport->dport_dev) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		return dport->regs.ras;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
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
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		return dport->dport_dev;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		return port->uport_dev;
+	}
+	case PCI_EXP_TYPE_ENDPOINT:
+	{
+		struct cxl_dev_state *cxlds;
+
+		if (!cxl_pci_drv_bound(pdev))
+			return NULL;
+
+		cxlds = pci_get_drvdata(pdev);
+		return cxlds->dev;
+	}
+	}
+
+	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
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
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		return &port->dev;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		return &port->dev;
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
@@ -399,6 +522,22 @@ static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __io
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
@@ -469,9 +608,8 @@ EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
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
@@ -483,13 +621,20 @@ static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
 						       aer + PCI_ERR_COR_STATUS,
 						       0, PCI_ERR_COR_INTERNAL);
 
-		if (!cxl_pci_drv_bound(pdev))
-			return;
+		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
+
+			if (!cxl_pci_drv_bound(pdev))
+				return;
+
+			cxl_cor_error_detected(dev);
+
+		} else {
+			cxl_port_cor_error_detected(dev);
+		}
 
-		cxl_cor_error_detected(&cxlmd->dev);
 		pcie_clear_device_status(pdev);
 	} else {
-		cxl_do_recovery(&cxlmd->dev);
+		cxl_do_recovery(dev);
 	}
 }
 
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index 8c0979299446..dbd7cb5d1a0a 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -43,7 +43,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
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
2.34.1


