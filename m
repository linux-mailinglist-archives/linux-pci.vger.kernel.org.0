Return-Path: <linux-pci+bounces-40176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E63C4C2E8EB
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 765A64F5237
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87E1DA55;
	Tue,  4 Nov 2025 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DrrHdJCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043FA214228;
	Tue,  4 Nov 2025 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215237; cv=fail; b=bvVsVRMEyIaB+9dfbYwSF69+iS5cpW11GgawV6i6GZlIIzR57zvKTmxx/cc9+qvrhYijqF/3Y1Acbr2Fd1lee8YDhAbyN2ORcB8sBMdJSLrhwdI42QWtKgY/8hHuv0UWjIXX2JRH8IHCOp0CZo9WpUfgoLPdMzfPnb0BqNNG6Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215237; c=relaxed/simple;
	bh=hbgh/iMgRb0flUlGfGuSyztVIg+IEU2HEd0N7kOb+fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3aLS1kNqiZickIY1PX0M1+S2pdwIVaAm3+R6X6femmfXVdNwxfgHz6jzVLqZ3O/8pm3J81ZljZsJQQ554vF53iQnyO0K7Jfb9tW58nxft2dR4Bb8qKKpaNMAT9qcTbeJnux1v3ZyAwgqRqDLJr1yfKIQbU9oCvQwPjeWd6Of/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DrrHdJCv; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTbPYpecIY9iTjnsL+R4JzIlk8J0LwlCAr3T2X8kZO4AF6ZhL0rVBW4ogtAH8gLoW4q5V3urst+s7drvFTjqTOoHHfGTqKd4izCn7NtjOiYPtl+yjizeWwLY40kqe5bK+Zg8hmb3PIboIQUHzqKyAfrC0uyoshu5zmwWEVdJ3/P+SGMFxHZKAe74PitH3shQiMyux/zNFzqp2BrcA/IWLNvI77RYKvucyGSAdOl+z1sE7w+0xpI7QSOxCdPpVoAMIfg+Fms0S1AjQTm2sagbIm16otWzDb4hyheyGEh6Lpa9277PojnHPvapUlgQGOt+StMF7iXTrcJRY54pSFYXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6B7CbI7ujuW3DEPbsRDKhPd/KQK1oc5Bj9pexPwRGo=;
 b=SDFNfbss/azQgHiIvq6P5kBqxUaHy/rNKO0zoj4yIJvL046mYjwLo+1QmlCvagvYno9cH7mjN08XEvIZ458BfMansoDTlToZs68GBrOJSVQ8/p1RvYPgyN6t8cOT5vq3jdHxbrjW14cM6/myxeFTJ4gJ/U3t0orzlQd8qh8GH7NMZ13my5NIvjvDCnw8yVP7DMtvHM9KdXE3+NLuILjKJh2YkFom206kJjIrsIRIWV9W02Y/rLzpIGUjloDLVJLOvQDbqE2pBytWqAUX2oNj9/xoKOLx/8mGV9wJ0pNsL6VeFJpsjqv3ZO+gITTihHLsSoIkSTZIxDhYawWKJqY7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6B7CbI7ujuW3DEPbsRDKhPd/KQK1oc5Bj9pexPwRGo=;
 b=DrrHdJCvQkKomQdj/O2aUb83OZuRiqS2rYtxVnHChS+JvYRzjRdux6w1JUCOF5iIZJWHtlz8Ux3gefwJg9Q7xpG0KmSUmdX9NkTCzYvSg8N9LJ4O5HTvdG1qlCgCbuGfPKjATC7sU05MZIvl8B+csaVcOAzapE6Q1vSFJxywLOg=
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:13:51 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ec) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 00:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:13:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:13:49 -0800
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
Subject: [PATCH v13 20/25] CXL/PCI: Introduce CXL Port protocol error handlers
Date: Mon, 3 Nov 2025 18:09:56 -0600
Message-ID: <20251104001001.3833651-21-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c13c865-5508-4cf3-557d-08de1b370874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mN/E/zeGlL5+DoyKN11EJ49ExLvJ3AtSXke1TltKdKQvzL1g2B6epZC41WLN?=
 =?us-ascii?Q?0M6+8IaTQsIPrib7GZ/69sZubNdlg2QpTLWASHs6Lp48W/n2ONpAtH4hzBH9?=
 =?us-ascii?Q?txn6EiAWhc22ShSgLdzhR55riylSgCQ7ZdBncyvl6+9iXQ1zKtp6fiORZgSy?=
 =?us-ascii?Q?800cMrZvFEeSBnWuYKxTiOD8mbHVBZHy2pf1pUVdMd+/83vbhXKqZu+SNp0+?=
 =?us-ascii?Q?B0JIscxf5GYmqkzG6w9fQRX7590JIW4OF+bU48b6mC6m5A/BJHrW75Emdkoq?=
 =?us-ascii?Q?e/gyjqHBLbUTnm0NJeUT/CvZJh/CKtKR7aStscm0h/ZRsfFPqSha4ukdbaqx?=
 =?us-ascii?Q?QcvcjFPD23MxVAlRvuB2EO8NoTkbwYK6vX1i6wfLVvuLyt51VODSAiu7KrT7?=
 =?us-ascii?Q?6aLnwefZrgV4Sb7NYV5uuN7aRlQCz3xvadKrSIx8+Aw7pBuQDTzwHjM+yT2H?=
 =?us-ascii?Q?9AQYWZk6huRoU+L6VAvYLpujXSNzHsWw02XcVF8pnl13mMRthhEDdQrT+smT?=
 =?us-ascii?Q?N4D4Kn0oyjlkT34fQfKB6WCJ1quBMlUQVfeEnZkxzM15cXv8GE0DYAOpASZt?=
 =?us-ascii?Q?3B6fUY1HGaMeAQ7YFMA+r2MBmcV8R3WO78+KuJ4nOQgwLg92UJvtfCRmfgLd?=
 =?us-ascii?Q?g3fr7DmvUobifYKFMeIjVCqunKF8bMrZ2WRXCQVpjbC4OGW6ArC0DPPTaWJv?=
 =?us-ascii?Q?cji43ifawUc9adXArvQpKU+4svgnwbgmzAaHttLn+X9IGFvbMq3kljlPMt0J?=
 =?us-ascii?Q?xiAvDMTQdLJGjMhLTMaTSFTTD1JRCgmTo5swgBmHtuXw0YkCNXV2Gy8u+TcF?=
 =?us-ascii?Q?NE8AtR+sxmrH4IUL/xjraCT4/nz4g9610DzcHmMpLdjKv4RcD+yQ5ypxyirc?=
 =?us-ascii?Q?SDDfGX3v3ETwQnfRrwuXS4Qsgld36cqqMfmzpd900aj5IF5JSLd8KmOXSa07?=
 =?us-ascii?Q?Q+J0KsUROf0uyZgwLjKqacNYCG6k54JzoFE/eGQi2RWQJwZcJQCt8nUS2HdT?=
 =?us-ascii?Q?c86rke1elEGOPX1yeiyT9pzaMCRJQGaZdsiHQ65xT4A9xEe+pJoTqL/gR73S?=
 =?us-ascii?Q?Q7VCxKswB2JDQuLgm+1hsDJAORdaYQ9JhDyPsCcmP/soS6yiL2W8T7JnVSof?=
 =?us-ascii?Q?MQBXwlp1TyAdtV8nTDp5w5k4us/9+DCZZkwgMdT4JM8rd4sxXwnpfN71AK1Y?=
 =?us-ascii?Q?Aw2VdbgDmhYNPRMG99+iNx+gsLB4x6c0lnH24zxuZ63V2RC8B8ArdOPXJgAo?=
 =?us-ascii?Q?JaiyTwOIo4CUWyhU8+DBMKpBH3K8QJcQvgc8rjIhcnyDAwa8uppkPdKUCBi5?=
 =?us-ascii?Q?FxPclDE5baZZVIXHPVGIGGo7YcOro4mVfMlWiDvcREIRDhRZl7XKoyShW4Kl?=
 =?us-ascii?Q?ALIEm1V7o2zli46St8WeTz/03JmE9W7Z7xoF4TZMaKvKNdtz41Dk5hSMYlRb?=
 =?us-ascii?Q?4Jy6+g3imNNnFjcf8moam+3tfyEU/ZDKPuWw8LrHfN98ogXxEjZcu6JWyVnn?=
 =?us-ascii?Q?68DuLR5QrIXZhb5FSirK0SeB+uRIWv3XwxdN9skTvoz77aqN0an4Q4gzN/5g?=
 =?us-ascii?Q?RsDv8arTaOj38ls6uPfaE1yq4/17b9D+VDqPA+03?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:13:51.1388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c13c865-5508-4cf3-557d-08de1b370874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479

Add CXL protocol error handlers for CXL Port devices (Root Ports,
Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
and cxl_port_error_detected() to handle correctable and uncorrectable errors
respectively.

Introduce cxl_get_ras_base() to retrieve the cached RAS register base
address for a given CXL port. This function supports CXL Root Ports,
Downstream Ports, and Upstream Ports by returning their previously mapped
RAS register addresses.

Add device lock assertions to protect against concurrent device or RAS
register removal during error handling. The port error handlers require
two device locks:

1. The port's CXL parent device - RAS registers are mapped using devm_*
   functions with the parent port as the host. Locking the parent prevents
   the RAS registers from being unmapped during error handling.

2. The PCI device (pdev->dev) - Locking prevents concurrent modifications
   to the PCI device structure during error handling.

The lock assertions added here will be satisfied by device locks introduced
in a subsequent patch.

Introduce get_pci_cxl_host_dev() to return the device responsible for
managing the RAS register mapping. This function increments the reference
count on the host device to prevent premature resource release during error
handling. The caller is responsible for decrementing the reference count.
For CXL endpoints, which manage resources without a separate host device,
this function returns NULL.

Update the AER driver's is_cxl_error() to recognize CXL Port devices in
addition to CXL Endpoints, as both now have CXL-specific error handlers.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---

Changes in v12->v13:
- Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
  patch (Terry)
- Remove EP case in cxl_get_ras_base(), not used. (Terry)
- Remove check for dport->dport_dev (Dave)
- Remove whitespace (Terry)

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
 drivers/cxl/core/core.h       | 10 +++++++
 drivers/cxl/core/port.c       |  7 ++---
 drivers/cxl/core/ras.c        | 49 +++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer_cxl_vh.c |  5 +++-
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index b2c0ccd6803f..046ec65ed147 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -157,6 +157,8 @@ void cxl_cor_error_detected(struct device *dev);
 pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t error);
 void pci_cor_error_detected(struct pci_dev *pdev);
+pci_ers_result_t cxl_port_error_detected(struct device *dev);
+void cxl_port_cor_error_detected(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -176,6 +178,11 @@ static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NONE;
 }
 static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
+static inline void cxl_port_cor_error_detected(struct device *dev) { }
+static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	return PCI_ERS_RESULT_NONE;
+}
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
@@ -190,6 +197,9 @@ static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif /* CONFIG_CXL_RCH_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b70e1b505b5c..d060f864cf2e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1360,8 +1360,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1564,7 +1564,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 {
 	struct device *dev;
 
@@ -1573,6 +1573,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 		return to_cxl_port(dev);
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");
 
 static int update_decoder_targets(struct device *dev, void *data)
 {
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index beb142054bda..142ca8794107 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -145,6 +145,39 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
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
+		if (!dport) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
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
+		return port->uport_regs.ras;
+	}
+	}
+
+	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
@@ -254,6 +287,22 @@ pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ra
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
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index 5dbc81341dc4..25f9512b57f7 100644
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


