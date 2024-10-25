Return-Path: <linux-pci+bounces-15356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EE9B1156
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8272845CB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684AA2161FC;
	Fri, 25 Oct 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jFJ4RWXA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5554215C6D;
	Fri, 25 Oct 2024 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890253; cv=fail; b=ucqyxq8iHoPlSd/GxbGlAlQhqABW46on3+fN2uKAmqntBKRcsPGkXEqeBWTV7S08OwTjya6WVF+LPK+j9U6cdedrf4mYLuTQtRbGwornr8V5kTvXfGKVF82YD9QTMflCdtLphC6M1Re3PM0+E5d4AuYmTqRyfl3j74gfTEoPwQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890253; c=relaxed/simple;
	bh=zioKQcmyJmQH1sfE0C1M7XlIbWrM3m4HjYOQW2PS6VY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PC3r7yBjMLDpgqSXKr58K7h/O4XiCx3p5SjNKHgFiqFBIeVqG6svmyaUZ66Ej0tH6XxRXOyvCllXKAX8vewDEgZpEygpoppaH39lmfLQ/crOPrSw3WXW97qcWQanNARarWIZG2lzE0RX62bKJGyJ+f3qSaVs/cGROFHFNUmM4Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jFJ4RWXA; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT7XFednMwOkObU+Qg5qSKjXcdDIwPCaeGvKOM9f1YpkvHG1izPSeMhWh7yGWaD0wMYpH9XBFYObxLMojx2szoFFRYbGVlWZ1xTuYDsNTzBuUUrN0TTLf2hPYzaW3H7HlUfa9K1gOV3gRpAIXR7pKslxCQ52sTMRFfXw2vkeIKlIaG2UZmTSQJVA8Fm+YX950VflpeQ+ZbBtWhqV3lk+l0k74ZPgxtEwtDEA/V29mqanDHW2bUR7LqzsCSCwwmBgoNab5RGMtlVIJhRZ+7s6BOoBOkLr1k0vpQwypWTBAOGlVP9eflr8oWKZoYT2yU2vqckMXxalshwREAUw622btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sVN2+sDwK+dHIO8CQZ8X/cG8jAf/ZsFUGUTpUSuU64=;
 b=iGNrkO08NoijZ2DqGuUCx0sCN++4VTbTIfeOY+OHCVlqAUOuSdbzadxAreBSWMluZrBfQS4FRp7EPealtcO69ne1eaIYMbC8mX6iZmeWPNIcVZH5OSrqV0ydQN2uLmLzNa2SXGajwB+cLREOCSAmy/72naq3/kcMOFuFGM0uhFb1qcMME1DEYido0vIY5IJZza+fkP30qrr0GeiQuTjbp7REMTFuHIKZnaV9ifExPgxOwfqZqChKqjXO08y3iwJf5KWPm4OWnVkJZh9GDfcd6PiuNdpT3DJjUkoU6FLeww39PijLHq/JPN4vYvNc2f0jLCFCG6nIwdBgddZZqhA38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sVN2+sDwK+dHIO8CQZ8X/cG8jAf/ZsFUGUTpUSuU64=;
 b=jFJ4RWXA2OJWYkQoNd3vk294nSqKXIojnQklnlnomS2RZBL5tzv0q/mbDeL+jSi/tBXJ0qXskK1yXhuZbLJc0WIdnN+PQ3nrB+a1aSNHrcHQaDN/OzCbyVR6ClxN34Wm7jQz8awlfqqX4X/7U0jNpHmqfCwMpU/Ek4yGjfST+fE=
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 21:04:07 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:334:cafe::bf) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Fri, 25 Oct 2024 21:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:04:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:04:05 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 05/14] PCI/AER: Add CXL PCIe port correctable error support in AER service driver
Date: Fri, 25 Oct 2024 16:02:56 -0500
Message-ID: <20241025210305.27499-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bcb1cf-5133-4ab8-0c85-08dcf53890a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?19lgCxpxFzmylj82m1uDieAUxfQDQMm9FNoiJUMLP64f5PFy/EAmD+54RlBG?=
 =?us-ascii?Q?5ATEcfPUcwzHvsSiSdjkhg9WwnBcX52KraCMOpAxKFKytdmwzUd2QwnJrVGU?=
 =?us-ascii?Q?Ll0IFw+FK/Ax+c4y1RM7+PK8GXiUyvDY5Y731+837nXzZY9ubNmZOxiiWgxO?=
 =?us-ascii?Q?d7nMBIa3BTeYJSKIN2yvyYBSPz2C9Tha7x8ijOXIl60Mt8BtgsjxWRoZQcEy?=
 =?us-ascii?Q?QSfvVGefoCxT6pUbSHx3e8+OYeIQZdYiwGGW8wVc3aa2p2aymJi1pAWIECmE?=
 =?us-ascii?Q?juuS+g2UpFjBLOe/m5izugZ1z00WWyrXqaxcSt0Ln22cBlM58okYTUW5rnKf?=
 =?us-ascii?Q?wKQ+YTnUGYKxoF0tn2kOZPWh0ul7DPiE9xiO6ARRc9+HhOq/jo2VzDpdLUhj?=
 =?us-ascii?Q?twyfo498ZkM7qxLu4Xhz6+I3jX6079au562dKdfeym7b80jbaMmiBiRxYFMU?=
 =?us-ascii?Q?vuafCXlM/6BtNRg4n58n0fN974kC1MwAOHa1yKkH/OAiAKli27nXYig0T5jZ?=
 =?us-ascii?Q?qYZpJurTjqENvC9SREBg38CVi0vsa1EoyDtxbu6FyzfK8SAb5vNkRI4tdHdK?=
 =?us-ascii?Q?atgNUGuBr2CXp7xSBNjz6vsq4OgYn/un+bSB7HWNImNxLwuky4riF7I0dgK0?=
 =?us-ascii?Q?uLBEiKvY7Rc/PvWt9NNueSAfUrXJOXmBHqwbqdO3WtONrXx/Xxu/HykfffJO?=
 =?us-ascii?Q?u5uM9EOdKc5fBwzed11ROFAk3Zw0efVsBeZYoDm5VIE6PPsAW0EiCRo8k7em?=
 =?us-ascii?Q?Jj1G/wsenFDrplMhuIy/TacRVdUeAcs+7qh0tryBiH0XPdMvoDCVn9sJkoPb?=
 =?us-ascii?Q?h4V7SYZKUfMbLde/U2LWHD7VSswvC8PrZhuF9BvkCqQuOY6lh5jz1uL1mZLY?=
 =?us-ascii?Q?da3xxYugG+WZzO3BaTTSXNA+Y1xpUuZmoMqBhmnInNHFZPbQQBKi864zlejc?=
 =?us-ascii?Q?mjKsEL8g1FI28JgPUGrBRWs47TMIf9YPox6QENH1BR035vm+vvt5+V2/yYTJ?=
 =?us-ascii?Q?zpT3K/sK7Qr1TQiUsSlDEWI0cisjNDNskE5WVROTkuOMMlu28TczdxDZTInl?=
 =?us-ascii?Q?47UVwVl35UIpxMGVjr+6ngMB+UgOSe6TGpjsAE8u10k3WOs1w6jxhpRVkz/w?=
 =?us-ascii?Q?oyOLeH31DprX4pXZsTWQk+aTUnirnI8I6J49XfkB3gzD5LypwAnY5AG1ryjZ?=
 =?us-ascii?Q?IueAswC9M8u4irN7E+IZSdZnFTwL9/E1Jgd75/H7JhfA3XKiNckSLQrWF9R9?=
 =?us-ascii?Q?5/r/7D5kwA0ZG4VeR0cxxSPWdB/MFgJkFOSduwmOmbaBwNx16wK8IdqMLRzJ?=
 =?us-ascii?Q?PuDU3g4gMaNRdC1uQp23mz4/i3qRXOOZyIuqmjUFftai8AwbshBzoDjRAMD1?=
 =?us-ascii?Q?JBzkykhDt88MdxV4KeVTUWtEY9J0BSSNJZbrt7mGHA2EOqVgqYVyjYip2VXg?=
 =?us-ascii?Q?8RrAecKddk4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:04:07.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bcb1cf-5133-4ab8-0c85-08dcf53890a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041

The AER service driver doesn't currently handle CXL protocol errors
reported by CXL root ports, CXL upstream switch ports, and CXL downstream
switch ports. Consequently, RAS protocol errors from CXL PCIe port devices
are not properly logged or handled.

These errors are reported to the OS via the root port's AER correctable
and uncorrectable internal error fields. While the AER driver supports
handling downstream port protocol errors in restricted CXL host (RCH) mode
also known as CXL1.1, it lacks the same functionality for CXL PCIe ports
operating in virtual hierarchy (VH) mode.

To address this gap, update the AER driver to handle CXL PCIe port device
protocol correctable errors (CE).

Make this update alongside the existing downstream port RCH error handling
logic, extending support to CXL PCIe ports in VH mode.

is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
config. Update is_internal_error()'s function declaration such that it is
always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
or disabled.

The uncorrectable error (UCE) handling will be added in a future patch.

[1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
Upstream Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 59 ++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 53e9a11f6c0f..1d3e5b929661 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -941,8 +941,15 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
+static bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
 
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+#ifdef CONFIG_PCIEAER_CXL
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -994,14 +1001,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
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
@@ -1033,14 +1032,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 
 static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
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
@@ -1058,9 +1066,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
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
@@ -1078,6 +1090,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
 static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
 static inline void cxl_handle_error(struct pci_dev *dev,
 				    struct aer_err_info *info) { }
+static bool handles_cxl_errors(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 /**
@@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_internal_error(info) && handles_cxl_errors(dev))
+		cxl_handle_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
-- 
2.34.1


