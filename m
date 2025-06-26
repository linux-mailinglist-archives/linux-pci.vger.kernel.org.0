Return-Path: <linux-pci+bounces-30855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA736AEA9DD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046BE1C45CBC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986F26FA70;
	Thu, 26 Jun 2025 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qihB63Mq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130226FA4C;
	Thu, 26 Jun 2025 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977864; cv=fail; b=FbVBT9VUOtHMijIyDb+yeCaQNv1CnQANsE8uzGdUUuxT+F924iiD2oA71pC2g8mBhUEtIBfeHvivQAweobQNDIR6lKevlKklRUyjwo11EcgKH/1wD4/a8IWnqy9wPq/N1YBYYgpPFNEBsr+jVIEf1xLAVibNzJVuJ3HeKB7bcZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977864; c=relaxed/simple;
	bh=mw27ytZiBHmqsLyW/EGXTXJncr3HxbuLsrOr/2mtRr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVLCAwdZum0mgUEas2ydwiXBpB2LdovVZu4tY309NPbZh1P5qHYXpT/EJFgrnzIQjW3PZLa1r0uKQMb1wMSS2MC4ZmdwPTimMVZb8+xQeEwsg4JS9X85x2ExPB8F33cLkGDZJMELTsi2ATOfTknbbpKAJwHmHDFfZRIanDKr7Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qihB63Mq; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf+svtcwHvO21TS5S0ONrQR7b0KGPCmuoW0PLwxbt9ze4ZZEAPINNWMZF8pO/IYJQcBVA3WsF0dN4/Lw2ND2OeHGu8yucywBalOT5MJK1DfADiKeXYygD3stkiBi+3O4NNz5nI/IkYBhYzWl9OtBcZgnAbC3oRtj0k6ZQpKump0WIFdrxJ+eTXBVG+YKwAIMTWZJvZ7q6EnFiS+UsyTGI6jNpDvBAsKuTfEhGMH+Cnl8x7vyfjSoeKCFjAJsdvZ5FYoRIIor5uifSEBhRbjJxrALmwMKnU92LkhGd6J+yzhLkciKTpiPA9fj8YRzCrxACvX/L42K7Y16YpUU8+7WZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V50b9n2swUlea7GFv1mO0hqOHhTzp0ZGsii2tE04hs=;
 b=lWwAVHuZWCSsm5IvnX4eC/l9Hsqd1c60MhEsaYqfUM8zc4c4yc1j8vk48ywBndNSSJgwjULc2qJ3WwbXfZkjTYx6X8ORXlyyDhQN3/oXm+rlHAMdywY9MpV8ia8CJcKd4de6EPBcuYa6g7Ya9GySKcdSvELC8t0c2MbAHm/DINnyi1q1BbB9w7Z3x+wKnZX4Ofp8QL2gZoHxoUList5geA9VBquqrgyBy1oVJ6PTTgp2b3vARCOnooqSwNTGcSv1JpwcINzS6VktVCaFBqeKPnPd5SDuYtQaQThX2W0CvZX1lWdNHP1U/Zb/geIn2uqRxfK2CwwOPHlR2dXoVUoUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V50b9n2swUlea7GFv1mO0hqOHhTzp0ZGsii2tE04hs=;
 b=qihB63MqqSE+2f2W/eSRqyOlKx2k8L5ZAoPCHZF3h0vwp1rYko8VbAVZnDFc0XbSxI6isTGcFiW2v4Xrpnfhj/xuVIvKm/iEVlYw2kQu97P9pE43JPDP5QGlYMbxGI94shCNgjyN+6c/aJFlGXmXqpZpx33vVTGG8oXLVQqQcRw=
Received: from DM6PR18CA0017.namprd18.prod.outlook.com (2603:10b6:5:15b::30)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 22:44:17 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::c9) by DM6PR18CA0017.outlook.office365.com
 (2603:10b6:5:15b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 22:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:44:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:44:16 -0500
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
Subject: [PATCH v10 07/17] CXL/PCI: Introduce CXL uncorrectable protocol error recovery
Date: Thu, 26 Jun 2025 17:42:42 -0500
Message-ID: <20250626224252.1415009-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 551fd707-0efd-4405-4aa1-08ddb502fb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JssPr7CmVGviN2XrhWr5SsSH1ZiDOvDN2nxbXhIqoModa/YtgatK8NNkfM+p?=
 =?us-ascii?Q?CVrpcO0pEgwmbpjxdC8eJ5JMfWqVI8sb0dqYUEfjprHxbeQfEF2drIs1pywo?=
 =?us-ascii?Q?C5xTnYVeGLZgCxOgvxe5PvxVQm091DNDlXMFQKKdN3mN4I4iqTzku8W03zRQ?=
 =?us-ascii?Q?DSqPN89qqYnxV/Qw/MuuumyK/60uQ6RMZ+9SF/6+00gzPCSvnrJ5975vH6Zb?=
 =?us-ascii?Q?mR7Lhd6BftPJs+vFc0f0Flp/Yz+tkUHYprNWuGDooYVkGtfdwXZ8RzguapoR?=
 =?us-ascii?Q?qPiwRRBUh9bnlxcZLmYYKMV8Rh8eDeJYw5uAOjvspanF0t/bGAc4/jbuDqtn?=
 =?us-ascii?Q?xTtWp7VbEaFS10K3+jYVCROhnfL33uLXOsz+ztJkCwgTK2VH5IgT+JdCYsyS?=
 =?us-ascii?Q?Bodp1IsLaadWm+e3WGnllPAfNunsI7pC7I7gTFDaQMxmT2keTKm5UYOt73hP?=
 =?us-ascii?Q?ThRpJR3oQdd1M+zk5GKHIY3kxKAfIqLAghDBaSaIMO/sp6yFSahNiNYhP8rW?=
 =?us-ascii?Q?3td0ADY5e+ZCWvh5QN87hPkXR9EGrflw4bkMQKdTlOMChcx7rPWrfjAE1DaK?=
 =?us-ascii?Q?0J5nzgJLu9AjfTKdAzQfRkp1OdWIi6eqrnSq9TsExsrR5lKS0vt3wWJ0RFzQ?=
 =?us-ascii?Q?UVNrGqEF+MEHZKL1jKE2XHhkHmwdebxeDQb/+m10XVTWOCjaV7FgfYQVV73l?=
 =?us-ascii?Q?53gH9II5wyYCIqcf6xvkbNAn0CoEBnOxeImWElQUlDGeD5zoN12ZyMcKY78c?=
 =?us-ascii?Q?vsiDikQgwIBFkqGUilvX8aNNyGuSVGkRue6ZTmHvvcWPXjFb7r/rL2wQDjmU?=
 =?us-ascii?Q?RjNmos422FYT8OjUmmmqrrkI/3rgE8ROKfMYZ8IcMVjuuC0dLrFpWiFaDXM8?=
 =?us-ascii?Q?UBrl7VU5AJd8wbFCBTm5SMp98W3p6658VrXvha73iFoj+Krq9tJ4qRlsX1Xv?=
 =?us-ascii?Q?WjHV1EgV+vWGfyZYtXJ0XTzgHuUEM9Bp364Sdd0q467PgpsADNpDkU/scWwS?=
 =?us-ascii?Q?N/YnQhsPqP9nXKaAe4KpoGBLMO7blMK4ecuMpRCZe2hi1MOmZUPVQu9ztwmP?=
 =?us-ascii?Q?Q5+1UOhOw2L74MytXEaLL38vWo+waYmSr2GcMSRmdHlDcOl24oDJO/rBnyAv?=
 =?us-ascii?Q?/dkIT5ic22Cd/WtQD4G5vp9x/T6jr6DTrcT0pmfai8rN/oOGENZ/lfOfAg3Y?=
 =?us-ascii?Q?71YLwfkO83DgE0TSc04xkyZHTHM+0d0uxHRfh5lcslpl/x9RvqMBLdBCV+rK?=
 =?us-ascii?Q?VlQpCKzEnXutl4p6HfTuM76XYgLhSug2G0MnqiKTyLDPQ/EizTpgLoj8e2Sj?=
 =?us-ascii?Q?Scqr0p2AJjUt80aSrOh2pOu3RtNUxiiwYAKcYNb+d9m8bWsM2WL7OrR0bArv?=
 =?us-ascii?Q?FdR6pX5NLdFC9ZS57cfGL/jprzqSP35/SAH2wbgMyceBJKCWLFhI8v0piQ9U?=
 =?us-ascii?Q?5ShnAV6ZBhEIrv0ujwL/KJXNy3lHqPE95Vz38ujT+wVdMko3HTt257zwCbGY?=
 =?us-ascii?Q?hT97PgPJWDF2loygzgOteE2Ps2a8wcJ2bxMy5ctbNyCU1QQAleoI9H6lhA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:44:17.0562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551fd707-0efd-4405-4aa1-08ddb502fb8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783

Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
handling. Follow similar design as found in PCIe error driver,
pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
as fatal with a kernel panic. This is to prevent corruption on CXL memory.

Export the PCI error driver's merge_result() to CXL namespace. Introduce
PCI_ERS_RESULT_PANIC and add support in merge_result() routine. This will
be used by CXL to panic the system in the case of uncorrectable protocol
errors. PCI error handling is not currently expected to use the
PCI_ERS_RESULT_PANIC.

Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
first device in all cases.

Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
Note, only CXL Endpoints and RCH Downstream Ports(RCH DSP) are currently
supported. Add locking for PCI device as done in PCI's report_error_detected().
This is necessary to prevent the RAS registers from disappearing before
logging is completed.

Call panic() to halt the system in the case of uncorrectable errors (UCE)
in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
if a UCE is not found. In this case the AER status must be cleared and
uses pci_aer_clear_fatal_status().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/native_ras.c | 44 +++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/cxl_aer.c    |  3 ++-
 drivers/pci/pcie/err.c        |  8 +++++--
 include/linux/aer.h           | 11 +++++++++
 include/linux/pci.h           |  3 +++
 5 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
index 5bd79d5019e7..19f8f2ac8376 100644
--- a/drivers/cxl/core/native_ras.c
+++ b/drivers/cxl/core/native_ras.c
@@ -8,8 +8,52 @@
 #include <core/core.h>
 #include <cxlpci.h>
 
+static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
+{
+	pci_ers_result_t vote, *result = data;
+
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
+		return 0;
+
+	guard(device)(&pdev->dev);
+
+	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
+	*result = merge_result(*result, vote);
+
+	return 0;
+}
+
+static void cxl_walk_bridge(struct pci_dev *bridge,
+			    int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	if (cb(bridge, userdata))
+		return;
+
+	if (bridge->subordinate)
+		pci_walk_bus(bridge->subordinate, cb, userdata);
+}
+
 static void cxl_do_recovery(struct pci_dev *pdev)
 {
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+
+	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (cxl_error_is_native(pdev)) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
 }
 
 static bool is_cxl_rcd(struct pci_dev *pdev)
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
index 939438a7161a..b238791b7101 100644
--- a/drivers/pci/pcie/cxl_aer.c
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -52,12 +52,13 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
 	return true;
 }
 
-static bool cxl_error_is_native(struct pci_dev *dev)
+bool cxl_error_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
 	return (pcie_ports_native || host->native_aer);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
 
 static bool is_internal_error(struct aer_err_info *info)
 {
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index de6381c690f5..63fceb3e8613 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -21,9 +21,12 @@
 #include "portdrv.h"
 #include "../pci.h"
 
-static pci_ers_result_t merge_result(enum pci_ers_result orig,
-				  enum pci_ers_result new)
+pci_ers_result_t merge_result(enum pci_ers_result orig,
+			      enum pci_ers_result new)
 {
+	if (new == PCI_ERS_RESULT_PANIC)
+		return PCI_ERS_RESULT_PANIC;
+
 	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
 		return PCI_ERS_RESULT_NO_AER_DRIVER;
 
@@ -45,6 +48,7 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig,
 
 	return orig;
 }
+EXPORT_SYMBOL_NS_GPL(merge_result, "CXL");
 
 static int report_error_detected(struct pci_dev *dev,
 				 pci_channel_state_t state,
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 0aafcc678e45..f14db635ef90 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -10,6 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/pci.h>
 #include <linux/workqueue_types.h>
 
 #define AER_NONFATAL			0
@@ -78,6 +79,8 @@ struct cxl_proto_err_work_data {
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+pci_ers_result_t merge_result(enum pci_ers_result orig,
+			      enum pci_ers_result new);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
@@ -85,16 +88,24 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline pci_ers_result_t merge_result(enum pci_ers_result orig,
+					    enum pci_ers_result new)
+{
+	return PCI_ERS_RESULT_NONE;
+}
+
 #endif
 
 #if defined(CONFIG_PCIEAER_CXL)
 void cxl_register_proto_err_work(struct work_struct *work);
 void cxl_unregister_proto_err_work(void);
 int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
+bool cxl_error_is_native(struct pci_dev *dev);
 #else
 static inline void cxl_register_proto_err_work(struct work_struct *work) { }
 static inline void cxl_unregister_proto_err_work(void) { }
 static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
+static inline bool cxl_error_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 79326358f641..16a8310e0373 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -868,6 +868,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic. Is CXL specific  */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1


