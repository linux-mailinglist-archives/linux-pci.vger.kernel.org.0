Return-Path: <linux-pci+bounces-16703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386D9C7DEF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032E91F21DA3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BAF18C030;
	Wed, 13 Nov 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PChsWU5n"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F018C913;
	Wed, 13 Nov 2024 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534940; cv=fail; b=Rw2l3KPWucKGGWdywPSODTs6k+5fr6Crq3O0a3YWNC5c5TxgLmvmKOz/qhrWa1fOBdzmeEkEy2l9wEO1GKqVdcrSJrPilTqgMqIyC+sAaiJLpeizvqtoiRuhjxwF70qohJwUBGQDHklERkt0aV7ZApLl49ZK3bE2PrbJmuUOBJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534940; c=relaxed/simple;
	bh=yUIGONYYPzNiyoJbu244bm9uRibJ0hqWY1OjS4XiKYk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hi30NJIgpjjPsx8v1IZKuZOZMJ0cuyC3294jFOglZhh/hsS8TA9m2oYtU1zgc9t0ZNY59RFufDhJXmMFSS+HNQB0NFzHfFxvzSGfBZCnWSIIZ2xxND4uRr0LlnoMfKZdaukiYesKYXN5A41sf7mqX2KA5fQ9JBE7G4sm5ll7iIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PChsWU5n; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvR0op2eFpFk5bw7rYYzIa2gd+odOe6RCzyUZZfV0BGRs/NBvvIDh+p4sCqkfRwLklQ5YM0S1o4YJYqCUv132k5lQEgEBV7wfzTN+0FHzuu8QeC6kSlRHQCdx0MleUOBK/v04+WM3lII1VEuJXN55pKQsaDHnN1m7sE2L6H93qUJ3nBinWJa8Lh+4FXUWKRDGTZelbHOSw/dXr5BVfvKtSqn44G/UgzKQf30sl2M9JvuhQjgdKHShIUSClrHpUyv7cUnUY/q6pl3KN49jb2C0bbBNuvql9FUaaV1Cyhp5MTRmlV4S/vvvVCqfHFsYvo0kDBUzNRwMHcs5auRH9hwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlpmRuCFNtbwfxxBVzrXEyYQlFKkvkIXMaBN4kHvQxM=;
 b=hcNAtbdO62NarbvvlF3O5FujQ739cwmIuNFeY//SaRlTj98aoHfflcHNQojSVax3nr7woTSE9iMDDPZa+zegSDvfXcaq3rEgiz2a7hUAVe6b+oVhXFZtdQ9CTfdO/xn/aoUvKTVgfRSd+M7J6Hx3DA8DLvu5lmtAN5NMi3uMms/D3Ax4jaX2WXJyDdrtkXYrWecoKsWcky8lo2pHano8nc4nC8OymQkDf8kXBHyptd0MUEXW1B1/aoSwc7x1wwgPTgll6oJD2VSBsD8zjxfJWmN6utmZz46XtpB4jC7Kln3SiBNbn2TRNU8TvHLE1l9+h1/0ZECUhYi/t9+KWgVG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlpmRuCFNtbwfxxBVzrXEyYQlFKkvkIXMaBN4kHvQxM=;
 b=PChsWU5nNdwz9x6qoYAe27Z1tRg8RItanbYQzZwC0fN66VUFnKTrP4ZtXw/TL+ZPmzq7VYxnIPSP1VjgML2Shsui6VEX2dQAqKGBHIHl/zJTN23HxXTu2bS2Pe6ix9jyTEk8WEdcA+UIl7RPsw7rx2ZkXW01GrFalFMSJpx4pUo=
Received: from DM6PR06CA0066.namprd06.prod.outlook.com (2603:10b6:5:54::43) by
 SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:55:34 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::27) by DM6PR06CA0066.outlook.office365.com
 (2603:10b6:5:54::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 21:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:55:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:55:30 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error support in AER service driver
Date: Wed, 13 Nov 2024 15:54:19 -0600
Message-ID: <20241113215429.3177981-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 09de33e9-429b-4a70-61e7-08dd042de678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6q5YSUrtP1pkiBxbUwMoa/ygxdmNzHN/Puy/Vgmd+ktzcaUaqgpCdbsgaIdb?=
 =?us-ascii?Q?hR2AH0gadXNTLLbNaLWW5KNSLhRyn+cVBcwFrXlmTnWRR/WdO1+dkxNC9wc+?=
 =?us-ascii?Q?kDY0vbCuXLtzxtyGpTBtYq8ZBzYgia+M6zsgm8j4AIe7mrJIcM+K1GLD4GHb?=
 =?us-ascii?Q?BMEugM5zvSLLNDt8r/DfItiQ2pODA4OQxYGqrmCUyLKaSeNmlksdNub0G5Hn?=
 =?us-ascii?Q?Ph1KayIVjSyK1+Ex79TpjlZ7HOYis2qiwTAucEJ1UtAtuFBZcpuKdevVMmH8?=
 =?us-ascii?Q?pKmwEL7MyYhq9iBF8bULRCbfDPB+xEwnjQGsiBjb17BUv7eVeCbgwIjVFLGE?=
 =?us-ascii?Q?5sAROacXavP/UeyzmcnfVNgQWajPEymwzl+71ilTGgisDTDGjItxHjvVv8wD?=
 =?us-ascii?Q?UzZIEVU6+tbWl1iWKWMJ8hRtTG9syuDuCv6/MvcZyiMNxmCS6CVaOA9uWnZp?=
 =?us-ascii?Q?clyLP+FpM7/G1E/yj5HSB51E/lqVXEJPQb3eByehFem20wfekkKdOHOnz8CT?=
 =?us-ascii?Q?b1j6jjl6tZksimOw6VZnVYn2oNTTFxFw8b5smZ+g9f/d2vqTvTUEGiMlpflK?=
 =?us-ascii?Q?aL+bDRqoSw4FDkQSwhujdSzeoZ+H1AWpSgCOeE3ZeqO90mBB8XdQkIYGY7vj?=
 =?us-ascii?Q?O6ON6HvyzK5Bh/HsSBhkweprhrZkw3Qq1pK4Ho0sLthGBby8zdjf5jMfrH+t?=
 =?us-ascii?Q?5+C8IfPFgLKByvND1PmER80I4dSvS1wFknaHfdVAKnN/5kFEz0EvaT2Ixnyp?=
 =?us-ascii?Q?XYEM1qI523xp+HQvwlNlFdjUBx1h8++X/6r07i0woowRfeAAeoePLH1MxN0w?=
 =?us-ascii?Q?HTzPI4/Fi7oN/ipuvfB6dXTIo2UViPjlwiunE+4uRyKEOUziTCitLYuldv6m?=
 =?us-ascii?Q?WuPtgxc23L0LbiOQnQFYsYDO66EasF6vVl2gBGrEv9HSqwfH71bEaw61ZFHq?=
 =?us-ascii?Q?g2DNilbFeIK+3Uehdlnq7KolM/YKc9a8prLod/JCgkwDVb6yJGqVJtPu1SiP?=
 =?us-ascii?Q?TqmhFV0MnVsSk6D0e5ooErFMIIIxZn68D22N/QPjKRsqAJNI8yiuAEFUnM6n?=
 =?us-ascii?Q?mpN9gf3srneoPBYJPGrEncHqHbwl99lSVjSms7Y5G40aVJ0tDfyOoii29zUd?=
 =?us-ascii?Q?1CPpBS32aC+58ZqfA0+TKZPVRmmWce2wljV1M4e4Cn0onyPQ+LMx6tdIQiuf?=
 =?us-ascii?Q?XvuN6gmeHf0+h3Tu10BrGDE6vbaM/STuA36uHh1yiOiGUuZ7egWSTR2tdjtC?=
 =?us-ascii?Q?V2dOTqCINpVqoaCCM3hb7zILaDlwRmRKcOhQKzoRECzXOPyagQBD7HtA3zDc?=
 =?us-ascii?Q?EP1WzMQ7g0p4D29MRrMXW2KY60WwZcxr/VeKHEBHJWoNFt3RfTrNYZoh8eA0?=
 =?us-ascii?Q?HDLD7IYKaJbQ1/7FLP53OuloAoBPkRkrJ3PzDLEBVxrlR9DHhlYoCwjvVS52?=
 =?us-ascii?Q?u4brsKpvpnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:55:34.0666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09de33e9-429b-4a70-61e7-08dd042de678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

The AER service driver supports handling downstream port protocol errors in
restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
functionality for CXL PCIe ports operating in virtual hierarchy (VH)
mode.[1]

CXL and PCIe protocol error handling have different requirements that
necessitate a separate handling path. The AER service driver may try to
recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
suitable for CXL PCIe port devices because of potential for system memory
corruption. Instead, CXL protocol error handling must use a kernel panic
in the case of a fatal or non-fatal UCE. The AER driver's PCIe error
handling does not panic the kernel in response to a UCE.

Introduce a separate path for CXL protocol error handling in the AER
service driver. This will allow CXL protocol errors to use CXL specific
handling instead of PCIe handling. Add the CXL specific changes without
affecting or adding functionality in the PCIe handling.

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


