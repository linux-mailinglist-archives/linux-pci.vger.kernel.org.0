Return-Path: <linux-pci+bounces-24811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F34CA7286F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBDB16A270
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4989B7DA95;
	Thu, 27 Mar 2025 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="see/Vo3j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3B2E3392;
	Thu, 27 Mar 2025 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040181; cv=fail; b=l07Qm3u6ljCRIO41qwOJXofGDhOppz4erpRUq+NMpudzg3RC7Z/9oK/TwAbrgIbyXWt57Ej/6xx+rZaABoVBgo5HpAA3Cd2WMSvmiN1Zouxti2O/SspNFweDkFG2F0tLzrWT9mhEJ3S4gGrsf+YV5UHXtcTDKW3A8flLxYejvV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040181; c=relaxed/simple;
	bh=RtjahhEuyI2PEtZ/8x2v3UGI3uNUDt27Q3nWlHboTyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7O2SIEqxoX0riulwJVVP17h8J2j0d6SO4ZCbH7RIGRUZeI5FSvvgwVW8Kb4Pb25DKQ9QicZP+da9kF9RkZvMl0BQFgCfKDgft8OJ6PusxGTDHaT//vrp5F4BxyKnFbEprHFiqEHQar2VH/2rbgiqyf+cVvTVbxeJGtQBSWGRCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=see/Vo3j; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTVQC8LQ4GWcXXnIsU7zl2xrPrIHDQyfZJ+/XM8NEfEahRcyabPZe9+/No+KUpKxlF7aElGy4HHLZgA20mEHy60TyFm+FCYSrQpwRwe8MjCBwox6oEUtjLdVGiruwAQmNEsD20XOGSrQY81i73pynTrxJvQeOBEnVzQErt9zj0j7zSfIn7JcN6SyzR6ioQslW1L3f1Vq0glFLXQ3CX8pklhR42Db95mcsMuzvWJAXIWWSD4/DTsOQmdCRgJd8XcNJkHdZa1uAc+h7D7SiOm9M8XXbzzNL1d6HneHG2TvpVT1oPXOCDuXbwjmcLUNp8S9sTx+JCdlfgNGG7isYA4bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBN3Uvr6gqdDkhua96mIzBLs8tNfyPNw8AmSDhaN8bw=;
 b=xV5wEgA9MATFRm708jAAjDSFkgHiSW9IJoZmrRgsaCRp2vfFCfLXRNbziGjPTlK/dzYS/K8wIDPDdcA/ChsiWuoJk55S4Yof0z4yNsNNOmzMIYC6/q07/Kx+fUN4F9Prm6UxWnEt7JYBE6rfpcGJveboEucrhFGAUQrFEJFF987Pu1wZqfO7zfYXfnrMejJI6+DAs1W5VHZvnkMswFn5hJZeYH1LqOVpDqjp+0nbufy6EiLzC3fxkTfShOtEr4XC2psXj7nU0X29d0UezMH2WMAW0pfrUN8sZjkAbkT3xpTJMyBNABwL88dBC8O3jUu/vNnnT/ndMyk4FNpPn4ELQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBN3Uvr6gqdDkhua96mIzBLs8tNfyPNw8AmSDhaN8bw=;
 b=see/Vo3jTGXcpMLp6ig0dy93ZkAVzLPoyIYT5J5beiUc88w8AMZnCJHSEbU0mMwQ6FukZgh+AxpS8KSAMZ8rth+iUHf4eyfbqX2q2Rt1Z3mLTkKF2FX5mLg0VHXkuRC7r6VWkQHFEBdMwuKnF6ro7pdKWEEAD0gw8bm8ZWrk1MQ=
Received: from BN9PR03CA0261.namprd03.prod.outlook.com (2603:10b6:408:ff::26)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:49:31 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::d6) by BN9PR03CA0261.outlook.office365.com
 (2603:10b6:408:ff::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 01:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:49:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:49:28 -0500
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
Subject: [PATCH v8 11/16] cxl/pci: Unifi CXL trace logging for CXL Endpoints and CXL Ports
Date: Wed, 26 Mar 2025 20:47:12 -0500
Message-ID: <20250327014717.2988633-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8451d0-bf38-47f8-1495-08dd6cd19dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nKH+8CQQTXpl7Yr+fwNpwGeBIYUpR7dQs4Qo+Qg9OQ9JjhGxQfEaLNYJX3WM?=
 =?us-ascii?Q?Gt66DX3cLnUIRd/w7+qzjTJhQ4xeMXDqdS3lkCiVbra3uHDp6VHeWIm+Dh9y?=
 =?us-ascii?Q?/kaTQnLhv1K0J0ev0n7LYP/Z03vjZg/iLsYpRNmrxtsKGqh/ja17TR64Qkzs?=
 =?us-ascii?Q?CbT/LUjaaLUO4EHJbAHFOSgjKv9kdvCKeWijUFuZTghWl6B2nBkTNB4nzDDK?=
 =?us-ascii?Q?mCYLSDarGZyGfo2yq1Mfh7Hdt2KSubs3m+Eb5B085nmmgk3WdJvmFrC8z/Td?=
 =?us-ascii?Q?OL1re445DFisDLFxHYKfyEeC1GzBaSfpOqokQapbBw2cUncS4d24jMR/CrGm?=
 =?us-ascii?Q?BAWG9a59Z7FPlp68r+B9UFkx1ip1XWJvvpkVrGe24yQGdsONfw6cXXbxMPVP?=
 =?us-ascii?Q?P/Wxr8jKjpG63j70QtGrrtnCJ6Cas2dvtrYpx112Y4m/6ZiMhWiOa6mX5J9l?=
 =?us-ascii?Q?LOIt9LvFA0LLyom9CikkEZfKT+S2Ao6ybsKkiL5Fjz7GW5I9X8i4Sb6Yr4B8?=
 =?us-ascii?Q?BkZGSmwBYX4sBwnMBMlRTrQxxmun1skRaZ+UuifqnJuztboYPqqoc+bAaaYJ?=
 =?us-ascii?Q?vSxGlnkeEvvX0CykiV95rCzmb6UjF+RV3f1av7NzrH1KJzguayJ3F9SzTyHi?=
 =?us-ascii?Q?L/yGJJfKEtYcMztFdhY+I0AQmMqdLc6L+n1/MYdA2Z8ISqn5/au2JHrpnbwg?=
 =?us-ascii?Q?nmOETtzc5GOY2FKrT5rra3cTUauo28PvtbpbpfAdfX1V1kS8Sib3UefVttnQ?=
 =?us-ascii?Q?hat8n+g4lCz3WP5ZLW2nsqJnK3Gds6lrpWDSfeA9JzDEDThfYCwaykQIBXct?=
 =?us-ascii?Q?qkjoY/0uCy00XVb5l+mS+hj+WMylyf3f6598MlaZGsIxzpR6pcyOaNIrhyWM?=
 =?us-ascii?Q?CliFnRorwivxg6QSzL6KD8nvzzeNI8KeNIg/nmF1PhFpntxqltIin0yohp1A?=
 =?us-ascii?Q?MD4B3G6u09TKqI8sqVnuRrBdBCwklYy0prdqNfGcFBUJriUrvi3HQOcf6yvT?=
 =?us-ascii?Q?pkIMv8RgnMbDa0o95dUg8Gx2t/Grv1nNnojLkvrQRvByBtj2jZVUQgzMtx6i?=
 =?us-ascii?Q?+xoB5a1h6VmfuzPY5md+s9Evk5fCvqirgsPWS7Mz2RocEe5dJjMCImQDggF2?=
 =?us-ascii?Q?GtPjv+st85V+tA4HEAzmfipDCVPFzB2VqlI7zsqzprtJCCUiaGrcfcyk2faa?=
 =?us-ascii?Q?BUopfewM2wKx6DjA6qTKFL9G5m0SVMuZpezZj82fgpNupQh7/Jq1/UHjh5l/?=
 =?us-ascii?Q?cGe4s7c9r/vOwQ67FFH+e+m3J8HKEnYbGrn8Adb8Z1rZbGdtskzUV0tIFs26?=
 =?us-ascii?Q?olu1rFfony9nqZeZeDVozpfNKN2R5iPzh2VR8e+lwXoooduA1iS6r1XkUorg?=
 =?us-ascii?Q?yibW4gIuc/dmjsKlvjVnmJAUPuxMpFuuGkGdIJ+elGG2P9d9zuHfxZ5TqWds?=
 =?us-ascii?Q?B3kIORAk0CrfX7AszgUge+xVhZfOlPc71hwSsODoCTC+5CfX85s1LCACLGpf?=
 =?us-ascii?Q?19n7WOizQ14VoiakXIz4hcbJPRoD4fnKvXFX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:49:30.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8451d0-bf38-47f8-1495-08dd6cd19dd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

CXL currently has separate trace routines for CXL Port errors and CXL
Endpoint errors. This is inconvnenient for the user because they must
enable 2 sets of trace routines. Make updates to the trace logging such
that a single trace routine logs both CXL Endpoint and CXL Port protocol
errors.

Also, CXL RAS errors are currently logged using the associated CXL port's
name returned from devname(). They are typically named with 'port1',
'port2', etc. to indicate the hierarchial location in the CXL topology.
But, this doesn't clearly indicate the CXL card or slot reporting the
error.

Update the logging to also log the corresponding PCIe devname. This will
give a PCIe SBDF or ACPI object name (in case of CXL HB). This will provide
details helping users understand which physical slot and card has the
error.

Below is example output after making these changes.

Correctable error example output:
cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status='Received Error From Physical Layer'

Uncorrectable error example output:
cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c   |  29 ++++++------
 drivers/cxl/core/ras.c   |  14 +++---
 drivers/cxl/core/trace.h | 100 +++++++++++++--------------------------
 3 files changed, 55 insertions(+), 88 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4770810b2138..10b2abfb0e64 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,14 +650,14 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct device *dev,
-				 void __iomem *ras_base)
+static void __cxl_handle_cor_ras(struct device *cxl_dev, struct device *pcie_dev,
+				 u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
 
 	if (!ras_base) {
-		dev_warn_once(dev, "CXL RAS register block is not mapped");
+		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
 		return;
 	}
 
@@ -667,12 +667,12 @@ static void __cxl_handle_cor_ras(struct device *dev,
 		return;
 	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
 
-	trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+	trace_cxl_aer_correctable_error(cxl_dev, pcie_dev, serial, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -696,7 +696,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static pci_ers_result_t __cxl_handle_ras(struct device *cxl_dev, struct device *pcie_dev,
+					 u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -704,14 +705,14 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 fe;
 
 	if (!ras_base) {
-		dev_warn_once(dev, "CXL RAS register block is not mapped");
-		return false;
+		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
+		return PCI_ERS_RESULT_NONE;
 	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -725,15 +726,15 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(cxl_dev, pcie_dev, serial, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -741,13 +742,13 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, dport->regs.ras);
 }
 
 /*
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 1f94fc08e72b..f18cb568eabd 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+	trace_cxl_aer_correctable_error(&pdev->dev, &pdev->dev, 0, status);
 }
 
 static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
@@ -28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
-					       ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&pdev->dev, &pdev->dev, 0,
+					  status, fe, ras_cap.header_log);
 }
 
 static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
@@ -42,7 +42,8 @@ static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
 	if (!cxlds)
 		return;
 
-	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	trace_cxl_aer_correctable_error(&cxlds->cxlmd->dev, &pdev->dev,
+					cxlds->serial, status);
 }
 
 static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
@@ -62,8 +63,9 @@ static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
-					  ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&cxlds->cxlmd->dev, &pdev->dev,
+					  cxlds->serial, status,
+					  fe, ras_cap.header_log);
 }
 
 static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 25ebfbc1616c..399e0b8bf0f2 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,49 +48,26 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
-TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-		__entry->first_error = fe;
-		/*
-		 * Embed the 512B headerlog data for user app retrieval and
-		 * parsing, but no need to print this in the trace buffer.
-		 */
-		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
-	),
-	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
-		  __get_str(device), __get_str(host),
-		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
-	)
-);
-
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
+	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u64 serial,
+		 u32 status, u32 fe, u32 *hl),
+	TP_ARGS(cxl_dev, pcie_dev, serial, status, fe, hl),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(cxl_name, dev_name(cxl_dev))
+		__string(cxl_parent_name, dev_name(cxl_dev->parent))
+		__string(pcie_name, dev_name(pcie_dev))
+		__string(pcie_parent_name, dev_name(pcie_dev->parent))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
-		__assign_str(memdev);
-		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__assign_str(cxl_name);
+		__assign_str(cxl_parent_name);
+		__assign_str(pcie_name);
+		__assign_str(pcie_parent_name);
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -99,10 +76,11 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
-		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
+	TP_printk("device=%s (%s) parent=%s (%s) serial: %lld status: '%s' first_error: '%s'",
+		__get_str(cxl_name), __get_str(pcie_name),
+		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
+		__entry->serial, show_uc_errs(__entry->status),
+		show_uc_errs(__entry->first_error)
 	)
 );
 
@@ -124,43 +102,29 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
-TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-	),
-	TP_printk("device=%s host=%s status='%s'",
-		  __get_str(device), __get_str(host),
-		  show_ce_errs(__entry->status)
-	)
-);
-
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
+	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u64 serial, u32 status),
+	TP_ARGS(cxl_dev, pcie_dev, serial, status),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(cxl_name, dev_name(cxl_dev))
+		__string(cxl_parent_name, dev_name(cxl_dev->parent))
+		__string(pcie_name, dev_name(pcie_dev))
+		__string(pcie_parent_name, dev_name(pcie_dev->parent))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(memdev);
-		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__assign_str(cxl_name);
+		__assign_str(cxl_parent_name);
+		__assign_str(pcie_name);
+		__assign_str(pcie_parent_name);
+		__entry->serial = serial;
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
-		  show_ce_errs(__entry->status)
+	TP_printk("device=%s (%s) parent=%s (%s) serieal=%lld status='%s'",
+		__get_str(cxl_name), __get_str(pcie_name),
+		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
+		__entry->serial, show_ce_errs(__entry->status)
 	)
 );
 
-- 
2.34.1


