Return-Path: <linux-pci+bounces-30862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3AAEA9E9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7914E3C84
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5992264D1;
	Thu, 26 Jun 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oKHg1jZn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701BC22ACF3;
	Thu, 26 Jun 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977944; cv=fail; b=djzEPRipKiFfA+AucTYYdMoBLXnhCdElSnUn50vvy0AsPRFVyv0TrmCEHrLZ/nJAl7N77+1yzIqQSdSZCNq6f6smDfT1k8YifLArhfEADlYxsICvtQQVDXEPK5JkW+veAcqAGTwrz5hnCm3eeUcmiey6OtiTgeIyudwiXrUSXhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977944; c=relaxed/simple;
	bh=4mBWI9aWZ/OIMh0b3oM51GIOn21vqKnhsH2A5wM2CNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXA+qBNbmnl54VTXIC4gEhvyRtbrLZbnNJnCMnxm57rC17O7rINII3j9lKJGU7bpE1kbXXXU/W8ZA0qKVZi0ZqXFxiRRFSGXAOYsJI3HJQQe430V+vYyyWEB2TNnx7s0WqaYS/ATcnNuW5YWsIa/6cmE8CYEkqOqynAYw8kb5TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oKHg1jZn; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZBJIZ+bKB6FZXuJunmBJsZxKypDdCbVB0T2XfK+jV+VzHBY+/idRaovUnOL6SU76g3u2PVR+6rEAzSF75M+6Xi7atI3M1UL9YeZFE/Yn30H80P0rfSTAeJIRuv7KYzCG7NaVuS1zi9d3ikVt4aWmvD7e/Inicw+FRSucPmH21MG2ycWyi/oTZ7AWNxWGGdBYKlCVwR6w1p3giiUYrb8rrirWYf+zVgoJZdQNXix7L/9d0Wtj0q57gTlkWptkyrDFrPplunmdalKjBC8Lc3cb55sBfIaliGhXk5a3P/Xwf9twKssLd6uzRbe/rmWaNGK1ojtR9ZsHFmIAOXTmDG9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad60TcXv0zdsuG6dD22xGy2ybLeU8IfcPvi4tJJcBgo=;
 b=gfnHGk8TwjlpFffNSufKDkVp+zs8gjm8HvUkSFqNbt0KmbAwsRekceOS+pcL2K5v26KAlJPvnjxVwrPETsj88BnItihqQkzrdLQGu+ENV1yg2joLGKbBCXjiRooOAjM++hiKIENoJ4YOnCR/8no8o+OtYAZByFdUBPMZ9t/rS/fqM0jwwSIRo9qN5m2hAasJKKYqHPd+WrGZ28g9lPolmzYqAA1Y2RRYaGBt6GNN26HYDK/saUDqTpCROC2f1UC5tf3I9ZazDxJCTYvCyWK+jqgbp3IrroWp/4Hfn+fwxONUaJviV1/Kjx3YUpWRy/NV4tUEsYoce51q5SqlsPi9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad60TcXv0zdsuG6dD22xGy2ybLeU8IfcPvi4tJJcBgo=;
 b=oKHg1jZnxtXADPS2Foh03Php3CvS/crXQ7hDJlrmaZn4GPHgNyK/3cvmD+EjJntMRMaj8qSxHUOlvYuhAUb+z1IBx+JNIrMwLurh/DX6vOC3bBoj++UNg9B5VFt+MbJKvqc1uTLbee4+lgkD1n51c8gYejGvZ5+ClIFmSLtpOWA=
Received: from CH2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610::17) by
 DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Thu, 26 Jun 2025 22:45:35 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::20) by CH2PR05CA0004.outlook.office365.com
 (2603:10b6:610::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.9 via Frontend Transport; Thu,
 26 Jun 2025 22:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:45:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:45:33 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 14/17] cxl/pci: Introduce CXL Endpoint protocol error handlers
Date: Thu, 26 Jun 2025 17:42:49 -0500
Message-ID: <20250626224252.1415009-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 489a07da-9b54-43c4-a076-08ddb50329f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MW0CJR3Gu6WokqRnpk45dVtmdvhyeAP56/+Z1CZyza/+9w/u36LfOQxpYnwM?=
 =?us-ascii?Q?E3mzeX+osNIlfT63I+b+5szcJPts3ASZzOnBQ49QJr9l2TQITAYmNIKZKrMb?=
 =?us-ascii?Q?NwE6Jjkux/1eL2z9XuBy8kfovIQu7XrWV8BhwW6l7VbB1Yu9An3n7w/oddz5?=
 =?us-ascii?Q?2MJItIbf4yrBRIhgmpIpue2PBrOZCm2I1QAtBde133HPk7Jwv4cHNpkU/3tV?=
 =?us-ascii?Q?uzvsgLmtwuWjdWdrQBR1ORnzdh7MUSMJhxUouQsPr1+4g/J/rJ+QN5o+gnR6?=
 =?us-ascii?Q?2eyfALUx2LeuUrkBMZeub8K7R0+iJP+qIU67aCZCtnlRELSmAuuz+34+Afc4?=
 =?us-ascii?Q?+QN+VGvrPZHovRjH2O6+Pwt1i/yqnGMvrCBSpbU7SWJj2ghvqmNPng6vo26z?=
 =?us-ascii?Q?MuZq1snn+mcFSW7aezlo/lEQyogRC+s/yYRlp53drPQFbdBxXAFqFO9FHePh?=
 =?us-ascii?Q?Djrz4VFRyWpM+Jg98LaNgxHSSUaWZikrF8DCmPpoKR6YqwSNpnYm7oBZEdal?=
 =?us-ascii?Q?gG1WqeM27w1twhxQhoAI4TWT1I8gXmQdexCe92Yv5oANExE2mBLr7K4/W+Zf?=
 =?us-ascii?Q?2V2rXyUtljby52aL9pWIciLr0rCBWosjN6DFR62hFmOn1wKiSJfZBfvFd8LI?=
 =?us-ascii?Q?GT9Cd9xaJqQgqGhgW7Wrkz9BXTyQLPYxjRtI4K4b6DlcJlp6zM6siDA5jrj2?=
 =?us-ascii?Q?MfKQtrjrGHYKJYW701SfmGEnwWf1IfMEmNDMK72qIwpILwI3lRcbB7GQYgy8?=
 =?us-ascii?Q?OmAt+79HxUKPwPlq9jbRrmBJfghXWXW2FWbjNUT1XEmVJ7y4N2D5CZ/xbAkE?=
 =?us-ascii?Q?vb3cm1SZOjdEbRS9xcoMW/WcleLVEalE8tCws3Xz5Jlf3ccfSOoaHJ6Z2+3I?=
 =?us-ascii?Q?GaMgMjrfBTmUPfnpEOMWkZpnBp4yz4VCD0nL0puT+au2t3yMquk+VyB6He6e?=
 =?us-ascii?Q?PQbN1Dlwafw31vV8g4Hxg49VTK9K+74XvVjAOEGprqMVczE63/ELPU0u1v4I?=
 =?us-ascii?Q?WXgio+nijVyDIl+AW58XXhTzrvCvBwn985WPNOFgPV94VkxtXSP5woTQezZP?=
 =?us-ascii?Q?dbahuum/OXcoEGgo4aqTROHvjaWeQXoLIlFlwGhRrzwYaXHs3D8fBEz8TBrB?=
 =?us-ascii?Q?LIK6L6XFYyp/ot+47gCcLaMMcdh8lACj7bPL+OBD+Ybnx2zv9IHybVXrm1Ud?=
 =?us-ascii?Q?qF6qT2uFvHL+mq/+dJDSNTEtdsvOVAM2Psit2m6W5VWs6Rw9ds8skSxEpQUT?=
 =?us-ascii?Q?mLIcvsB8356XhUbjy7DHVbM9GnH8PXKcIzdrX5Zr/1nHSghk+7HpkkPqvXqg?=
 =?us-ascii?Q?N3OCqEpEKtyP4ArPtINuMMdeKfH8M8Aw3KQAY5EZelwMpmNCzjGbpWkYBx7k?=
 =?us-ascii?Q?gMm/pMCH7A3keHCThJquaPYjJg+LrChaZNUhlolVFwQi6nsO55SP6JX3RJhn?=
 =?us-ascii?Q?CHfsZNOkWH4JKB9SVZgHpsOTSztVT4x/H+NPUd8As1N08M0rDVPRhFY+dGb3?=
 =?us-ascii?Q?IZgSIFkCv+8YFyvlmKJhwwb4SukstG2LXUsntLj8Vj6pD2Yl5Ne0u4JJgQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:45:34.8828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 489a07da-9b54-43c4-a076-08ddb50329f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

CXL Endpoint protocol errors are currently handled using PCI error
handlers. The CXL Endpoint requires CXL specific handling in the case of
uncorrectable error (UCE) handling not provided by the PCI handlers.

Add CXL specific handlers for CXL Endpoints. Rename the existing
cxl_error_handlers to be pci_error_handlers to more correctly indicate
the error type and follow naming consistency.

The PCI handlers will be called if the CXL device is not trained for
alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
CXL UCE handlers.

The existing EP UCE handler includes checks for various results. These are
no longer needed because CXL UCE recovery will not be attempted. Implement
cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
CXL UCE handler is called by cxl_do_recovery() that acts on the return
value. In the case of the PCI handler path, call panic() if the result is
PCI_ERS_RESULT_PANIC.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/cxl/core/native_ras.c | 15 ++++---
 drivers/cxl/core/pci.c        | 77 ++++++++++++++++++-----------------
 drivers/cxl/cxl.h             |  4 ++
 drivers/cxl/cxlpci.h          |  6 +--
 drivers/cxl/pci.c             |  8 ++--
 5 files changed, 59 insertions(+), 51 deletions(-)

diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
index 19f8f2ac8376..89b65a35f2c0 100644
--- a/drivers/cxl/core/native_ras.c
+++ b/drivers/cxl/core/native_ras.c
@@ -7,18 +7,20 @@
 #include <cxlmem.h>
 #include <core/core.h>
 #include <cxlpci.h>
+#include <core/core.h>
 
 static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
 {
 	pci_ers_result_t vote, *result = data;
+	struct device *dev = &pdev->dev;
 
 	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
 	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
 		return 0;
 
-	guard(device)(&pdev->dev);
+	guard(device)(dev);
 
-	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
+	vote = cxl_error_detected(dev);
 	*result = merge_result(*result, vote);
 
 	return 0;
@@ -82,16 +84,17 @@ static bool is_cxl_rcd(struct pci_dev *pdev)
 static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
 {
 	struct cxl_proto_error_info *err_info = data;
+	struct device *dev = &pdev->dev;
 
-	guard(device)(&pdev->dev);
+	guard(device)(dev);
 
 	if (!is_cxl_rcd(pdev) || !cxl_pci_drv_bound(pdev))
 		return 0;
 
 	if (err_info->severity == AER_CORRECTABLE)
-		cxl_cor_error_detected(pdev);
+		cxl_cor_error_detected(dev);
 	else
-		cxl_error_detected(pdev, pci_channel_io_frozen);
+		cxl_error_detected(dev);
 
 	return 1;
 }
@@ -126,7 +129,7 @@ static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
 						       aer + PCI_ERR_COR_STATUS,
 						       0, PCI_ERR_COR_INTERNAL);
 
-		cxl_cor_error_detected(pdev);
+		cxl_cor_error_detected(&pdev->dev);
 
 		pcie_clear_device_status(pdev);
 	} else {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 887b54cf3395..7209ffb5c2fe 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -705,8 +705,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct device *dev, u64 serial,
-			   void __iomem *ras_base)
+static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
+				       void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -715,13 +715,13 @@ static bool cxl_handle_ras(struct device *dev, u64 serial,
 
 	if (!ras_base) {
 		dev_warn_once(dev, "CXL RAS register block is not mapped");
-		return false;
+		return PCI_ERS_RESULT_NONE;
 	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -738,7 +738,7 @@ static bool cxl_handle_ras(struct device *dev, u64 serial,
 	trace_cxl_aer_uncorrectable_error(dev, serial, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -833,13 +833,14 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+void cxl_cor_error_detected(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *dev = &cxlds->cxlmd->dev;
+	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
+	scoped_guard(device, cxlmd_dev) {
+		if (!cxlmd_dev->driver) {
 			dev_warn(&pdev->dev,
 				 "%s: memdev disabled, abort error handling\n",
 				 dev_name(dev));
@@ -854,20 +855,26 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+void pci_cor_error_detected(struct pci_dev *pdev)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
+	cxl_cor_error_detected(&pdev->dev);
+}
+EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
+pci_ers_result_t cxl_error_detected(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
+	pci_ers_result_t ue;
+
+	scoped_guard(device, cxlmd_dev) {
+
+		if (!cxlmd_dev->driver) {
 			dev_warn(&pdev->dev,
 				 "%s: memdev disabled, abort error handling\n",
 				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
+			return PCI_ERS_RESULT_PANIC;
 		}
 
 		if (cxlds->rcd)
@@ -881,29 +888,23 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
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
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-	return PCI_ERS_RESULT_NEED_RESET;
+	return ue;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error)
+{
+	pci_ers_result_t rc;
+
+	rc = cxl_error_detected(&pdev->dev);
+	if (rc == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
+
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d696d419bd5a..a2eedc8a82e8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <linux/pci.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -797,6 +798,9 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 }
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
+void cxl_cor_error_detected(struct device *dev);
+pci_ers_result_t cxl_error_detected(struct device *dev);
+
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index ed3c9701b79f..e69a47f0cd94 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -133,8 +133,8 @@ struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
-void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
+void pci_cor_error_detected(struct pci_dev *pdev);
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error);
 bool cxl_pci_drv_bound(struct pci_dev *pdev);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index cae049f9ae3e..91fab33094a9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1112,11 +1112,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected = pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
+	.cor_error_detected	= pci_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
@@ -1124,7 +1124,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1


