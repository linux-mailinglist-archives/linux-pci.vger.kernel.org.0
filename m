Return-Path: <linux-pci+bounces-20997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7AAA2D22E
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9081635A7
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74E137C35;
	Sat,  8 Feb 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LVx4tYKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105A1E492;
	Sat,  8 Feb 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974650; cv=fail; b=ZPsC9LGtjyGl4yOxVFU9QYLuZoEBosGp2rsyOwFHZqw4bZzAQlFpedJl91UYLJtowavj606zJdeIqPsLTrJbhLCgbhBkGJFbMdYDJCzl/B+Sye7MbfzfPw2goWJuhY0rE3YRMHpPxXB4GRLdaaLJW7PhnESQgXzo5nuUeIpV2eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974650; c=relaxed/simple;
	bh=tt4+Ph7XgRRfS/J4IOigFER6C4kRakQrEChv6Jg8HiQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXKR6iHeUX0T0zekkClZabPuGCoK8SrPW2sZ3SwES+oDc1hoeOWdmA0wDEAumuP4nJIntYY++sclXfrIn2KGFNdlGmzxjCXs5pPka2dIKNP+fal0kapafk7toKNIpAUdkHEWmKMm5yAneOvKmMqi6JsJWdEhMTpo7NdCXqqhDsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LVx4tYKd; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FECo0yaUS0G/H/CE7B+ry6bBESJLG+ZiwtUKJb1LP3CCbb4jxR31KlnscGXJW0t8CVATL+YarLsoH9ZIql4LHg9pcYGjGZrx4wwhEfeDN4UzS26Jai/XseGAgtydzK9144mQmlnevAnc4zSzDoQ1fGiaM0GYCspIFPhAuvw2cVDk3LIG/F7cbBaV3bJ68LDoDsc5kEMeg3ZMJdL6xxhsdCvsgGf0LxWp37xYv/iMqfeFrq56ICuGXk4GBgEecb2RSDrLoYXIPqJr028Sf8YyECWZWGEV5iPeB7UVMUWfN2FerwQ+aD/GrAKgPZzgTevtE4sFHFh/mod5hs/BRc1oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6AKQGBgaJyGC9PQIbpbiJYljVs9RjLe9t6VgyBsiYY=;
 b=x+2/SiecP+yJsnd+5xao5vHzKimWDW2c5TXccmxisozrYWySlRKmpG40rQKD9l1tADF+00SX7Vj7g5jyaYumomCaVsh/NIF6gqK7/bzoUw4zwZeRBX71dRKtNJvyy6MGZnjj5stkxwEwa06N/oxDlmtiOWfi7oXYoruGjDCeafiZEgmRD/Cuto9zmYMusgnCBrPYbxCZ7UN0pswzJZekwE9xmRg41mdLUFXpBnGeYZAN2IYf9J122FLVx0HapfjtwxzPf9OfNzJlDnKwMhQO/NBhZuIPaGxbPTkhRqbgeTBoz28R1ZidXvQze9HNnNaN/TI/ufe/6qbwVxgs6ekaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6AKQGBgaJyGC9PQIbpbiJYljVs9RjLe9t6VgyBsiYY=;
 b=LVx4tYKd1l+cpyDDoA9H5+A6BFe2Y5NWR5ikc9dffEZOQ58OyHX2z4HlvvzdGWEp3Qaef0BVQSuA+VdYxvvMNfXxqzYaWVhpVIN9oJrAkbjOEphRbzbSb8+uLsbORWx3PJDPTlK7Ibq3Qr5dvrsQKokjmAvwWWl5swM7g86nJaU=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 00:30:44 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a8) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Sat,
 8 Feb 2025 00:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:30:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:30:42 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v6 05/17] PCI/AER: Add CXL PCIe Port correctable error support in AER service driver
Date: Fri, 7 Feb 2025 18:29:29 -0600
Message-ID: <20250208002941.4135321-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a1d8f0-b1ac-4e98-8347-08dd47d7d311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qql0Q+EeuWyJmlPsaBFBSVjHlKc+9iimWsF3YIVvEfsF+JUrlCdl9Mc+6ZhE?=
 =?us-ascii?Q?G5iXtNKjaL6ieyhnTIJg/nxKuPBg4IKmW/M/EaROxwfFo164q66J6hnI8/lX?=
 =?us-ascii?Q?1EDNc3YX1Np98At1oTWlmSf5GsvgmHPcp3uFAhuRw8QljjMeqpGcIKrU6SwG?=
 =?us-ascii?Q?FCsPpFyc2e1VkQxPZRATgxnNCCpwc7AOjH90dfMtbKtEhHXmDm+ZnDbRlhna?=
 =?us-ascii?Q?tm2fWpfD39ij5Gk4J4CBJNhZqEgJHjEYKK2UeAP7b7S3seQHZJ8EDnq55ZA8?=
 =?us-ascii?Q?sszvnp2wMm5NgPn+wuejIGtHXrXHZ6MyG32Eln4NjgbinpWqaBZMxRRRUV6e?=
 =?us-ascii?Q?G3Xz9WJEmnWOed8pduihP5is7m6JoKMPwnlEbMd/9bsW9URyEZefXqmoDTY7?=
 =?us-ascii?Q?U9GrJcYaSUfAArKCDTcHQvK/cxRtfDrWiwmYXFawtZUOYrgUF5dX0YBQlO15?=
 =?us-ascii?Q?QKXPIeJQEL7lTZFj9kY4swPLd4UbidKKAh+ZZDFiaKCqy0Z+XUBIClPRb4GM?=
 =?us-ascii?Q?7LynqR+ElB2XT5+nPq8QVOAhdtxSoeCptNmce51aecsCWHYkBo5/csVkTnzS?=
 =?us-ascii?Q?RGzTc3KQN6HLN23alVn0KQ4phEb8fMt3lj0elcb3JeHAi6elgI4+3PK5h+Aq?=
 =?us-ascii?Q?yv0hvrRBETifwBMsP7wT0yB39gD3fi5xk4KPM4VOMDElJJQ/tqyNI+VsYq1C?=
 =?us-ascii?Q?3wJ7FmO1XKWHZ4RAKYkG6D6Jn0Uj+/YvsyEY7bH79D/ubWQULjbOhXUxtMac?=
 =?us-ascii?Q?WQLoAPwEyIAz2PSoF2zZPBMKqf+r0/dm8GJ+d+we99UtsncxM2ec3xDsIXfH?=
 =?us-ascii?Q?Tff/OV1JkiXt4nQX6mqA9k6v2340qpyQqfXHs5k79pyc/PxEu0fh6m4c6ZDY?=
 =?us-ascii?Q?KttRxThkjGrnB3RqExuY8wZZYNVMponD2JLHBhoQrwJjQrdpU4vo66E8mBVG?=
 =?us-ascii?Q?+eklKVj0bcsLjPD50GRC/1DbTRjotsRp3bdLmZSznsCZ95Ny75GdYGxwhIc1?=
 =?us-ascii?Q?uxeHYRf9Jno7TDHrldOCwxbYUcnvgE/lEegm1ABZF8H48/+x08q9yASYJSDN?=
 =?us-ascii?Q?J8HCkzOykXo7SlWhyRD9OqgOVAei7gPg/TGYbrD7k3JvRGMNJZZ6lvT0zC/e?=
 =?us-ascii?Q?1183vOVDdpd7JROHHnz7SSLVgk/0IOF0/wHPjrzYzF1QM53fvOKmCVSBVAZc?=
 =?us-ascii?Q?tNSrq4ilEiZHga+K0UcEP+yD1We3EU6J00tw4vcibLjcQOzMF2z44pqqHOP7?=
 =?us-ascii?Q?C6qEwqp9861vNMvv/WVfNfNkefkZVPbs6+o+2nExzN/+iyJ3AebNkPH2ej/F?=
 =?us-ascii?Q?baRnJmsldlZ6HfH7sU05vq5GAqxCySMPbMu3naEl0Tld5JdrkpvXbM7y0WSs?=
 =?us-ascii?Q?lWatdbq5tektspENgbDGAAAKueBci1a+mNyiPi80wZaBI4kh4YwJhzejwq0s?=
 =?us-ascii?Q?YXc8JNVxwYgfV4vz8utwNeqIJ8L8+81LBc/Oho488DWh0OLN8lhtEalFUYfZ?=
 =?us-ascii?Q?9ea14n14bd43JZncevepYuwvx/trpTnxq9BM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:30:43.9596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a1d8f0-b1ac-4e98-8347-08dd47d7d311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

The AER service driver supports handling Downstream Port Protocol Errors in
Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
mode.[1]

CXL and PCIe Protocol Error handling have different requirements that
necessitate a separate handling path. The AER service driver may try to
recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
suitable for CXL PCIe Port devices because of potential for system memory
corruption. Instead, CXL Protocol Error handling must use a kernel panic
in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
Error handling does not panic the kernel in response to a UCE.

Introduce a separate path for CXL Protocol Error handling in the AER
service driver. This will allow CXL Protocol Errors to use CXL specific
handling instead of PCIe handling. Add the CXL specific changes without
affecting or adding functionality in the PCIe handling.

Make this update alongside the existing Downstream Port RCH error handling
logic, extending support to CXL PCIe Ports in VH mode.

Remove is_internal_error(). is_internal_error() was used to determine if
an AER error was a CXL error. Instead, now rely on pcie_is_cxl() to
indicate the error is a CXL error.

The uncorrectable error (UCE) handling will be added in a future patch.

[1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
Upstream Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/pcie/aer.c | 47 ++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f99a1c6fb274..34ec0958afff 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -989,14 +989,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 	return (pcie_ports_native || host->native_aer);
 }
 
-static bool is_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
@@ -1033,9 +1025,23 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 	 * RCH's downstream port. Check and handle them in the CXL.mem
 	 * device driver.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+
+	if (info->severity == AER_CORRECTABLE) {
+		struct pci_driver *pdrv = dev->driver;
+		int aer = dev->aer_cap;
+
+		if (aer)
+			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
+					       info->status);
+
+		if (pdrv && pdrv->cxl_err_handler &&
+		    pdrv->cxl_err_handler->cor_error_detected)
+			pdrv->cxl_err_handler->cor_error_detected(dev);
+
+		pcie_clear_device_status(dev);
+	}
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
@@ -1053,9 +1059,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(dev))
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
+	else
+		handles_cxl = pcie_is_cxl_port(dev);
 
 	return handles_cxl;
 }
@@ -1073,6 +1083,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
 static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
 static inline void cxl_handle_error(struct pci_dev *dev,
 				    struct aer_err_info *info) { }
+static bool handles_cxl_errors(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 /**
@@ -1110,8 +1124,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (handles_cxl_errors(dev))
+		cxl_handle_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
-- 
2.34.1


