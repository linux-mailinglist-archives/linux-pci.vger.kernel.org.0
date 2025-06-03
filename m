Return-Path: <linux-pci+bounces-28901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B1ACCC1F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E4177655
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A681E5B97;
	Tue,  3 Jun 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dLYs0v5n"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553F1E833C;
	Tue,  3 Jun 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971530; cv=fail; b=JVLHY8K1BC7MboiyM2rwOGOWpDrS9rY5rDYpIohbcGGDTjlvs+LqeWjfW5dU9SasuEtWk30v3B2oEHSxVWS6YggoM3PpEApJ4bCjILYRSAnCyU8+v+yxOD1JB0flaLGzDM3vYlS8wtemHfYEKJ6CrVsy6JWrWcGE2uNJw/fJSbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971530; c=relaxed/simple;
	bh=8yCGrYGcmLH9vVi42NF+bZdrjlrvoeLmtbTIncjlxkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1Kvi4XGiahNFwqiDh+eKyJmZ4sTlbprzH7Z9FH8J8mJCieQgcAVcyh8krabQnJfldTjyWHx4ylMzfetf/u2GnLGXm0f2RuuoQJYkuSNLwWkIokjnjNYLoXtvr9ixZrWmEYfYv9rMQxC7uunKoDQ5lEt6CDae+TFTKKVr86Y3/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dLYs0v5n; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMz5zJAdm+MUJP03dJlcyHUmiv5q/2wkK4Sb8yAA8OvdKnWK9h4FL/3tvtobEnW4IdX8FygXoHXODEi6vaMf59FmBNLOIkPIgPBqQ0bprrnUMysdMC4rYEsmz23ul17ayplO1qdVkuUfMcPcgux8RKjrcrWUbg72j02zmB+UMAF91Sp9PsWWmrT1h1MDZTQNufPv4ASMle24ygNm0+ah+/ssOWdpGxfv4D1OgyOfJysW+JnbaUIWyrPNufeSJYDKaPQrvOTLnbjvGZuaOfoIrYQoi0PxB1A7Cp3Woa6J1zZ3sT2LEjqX8V393JsxK+BkGClFMWGMq9sM/82mGzjogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDu+6RLQEiKG04plK7SaifLx1c5fAM+24Bll3AveRvQ=;
 b=ndk2peRhWzEnWv5aUFVg8jS8jpiCQrFoNzow1FBJZkhUwLEokP4teN9hDWm5L/zcz5ZuHIm8ofxdlvI8CVqT1Zn7LwDsdAUSXtWU1eZXbgp499wg8kp8olekeU2Je/LGTcZveVDalW9IeQ3fAR9z6ZjMz8do8IfgxhNwzsNfCJVS9nc/xOxbr38XSC95dhi8o81/kF2J4PZSxkeBArc/Zmf6r4lU+FEAXs8gHi3jUtCyUlanirJspnuUHj5naYb/0+TY/XcyqoHY+W+mr1w9wUzYBxYIrl1sYAxBokJ97as1kFx1lypU7jLps6Ix11iGhqvI4YhQhot/CKQHfG9q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDu+6RLQEiKG04plK7SaifLx1c5fAM+24Bll3AveRvQ=;
 b=dLYs0v5nfYd5L7UIfBCRY0i2s8mN1IUonbigo1OiFWnx4GXtZTd7P/exKrndjmRziaX9GC/BKgNW0G5OlrbcdNcsF7ykgzBWO36hubRatiPHFgjMh33NP1AfU/MCcCjJN7TJ1FovKMi/xxlXBBzxpwI3VCmBz84ZadbdA4Sm7wc=
Received: from BLAPR03CA0114.namprd03.prod.outlook.com (2603:10b6:208:32a::29)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 17:25:26 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::c6) by BLAPR03CA0114.outlook.office365.com
 (2603:10b6:208:32a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 3 Jun 2025 17:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:25:26 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:25:22 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 14/16] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Tue, 3 Jun 2025 12:22:37 -0500
Message-ID: <20250603172239.159260-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: c8772dd3-b6d3-46a8-c9ef-08dda2c3a127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZvflKEs11pwaB85MHzCTXCLAbAE7fZXRGn3ksfPSm32iaBewytF0mDPpeCrI?=
 =?us-ascii?Q?wNaWubE4+9bm2JakopFyRtB08ovKCiFnqhK+U0KrlnDGA0TBRF5nfflkF0Rv?=
 =?us-ascii?Q?yaniLlxMOhDGLu2a81Po/MXYM9f+rNEDomY3z/uI3EVWTXBQ27MOJf7GAum5?=
 =?us-ascii?Q?bc+wVjVqv3EEpRsVO6lKd+7+OTbXW50irIiWADeEG0qYvdcuF4Dpo5odV3UB?=
 =?us-ascii?Q?ZL8nOQmiK0RhJqmTwdocTO1pYOhGTdqOCQ1w58SX3sEtcBZzmts3LwEKOVxd?=
 =?us-ascii?Q?sMGXbnoAJ1bwj6N7nDF2UzEl8uqsLVrn0G9qymEhAm9IiHU/s8Y1XbCx1kVX?=
 =?us-ascii?Q?HqTKpLn+erjH3oczjF4p+RtIYbCJKLGNX+12nfA3OeAvnt+2rwGRXDyA7/db?=
 =?us-ascii?Q?jiLLVfCq0mpvk7jQWr72cPsvjrFvkNk3pLSpU8h/7G4Qc4MDhQIAp4oCesWA?=
 =?us-ascii?Q?TcXoi1TH+08OQmpBYt9y5iS4LBURH4WvKkPqikjPDIyG7ogaIDcm/D4XinEz?=
 =?us-ascii?Q?B3vk0+tn6QWQyza0cOpHVIKYHQkBQ8VRMJWD7Ef9rVotkfT9ifw1Zs16GOFK?=
 =?us-ascii?Q?t3GcJJW7XiN6RfAy5Jv9+eV8wUCszD3JI0mQCIco1tuOkaI1O24HBFYL3Y2I?=
 =?us-ascii?Q?qIwAYDhKCAiWDzGaBsR2uhowBnvLOXXLE/Jyjy2Ue4NGuwB3lGSZj0aKzwmc?=
 =?us-ascii?Q?enhwDeQJlM9fcpUQNm5boJ1BIo7HO8JAqy2DHrcjnZL+cMnZTAX3PbzVtXrH?=
 =?us-ascii?Q?ptjIJTJs8vXBsDTu2mMOao2GgyVge9k09P3QeE1/mjNxIQvvC7h9ftrCDHMO?=
 =?us-ascii?Q?SLyTAfBy5ReYkU1BMhmgY3EkGkKc5w0DgisYesi3ZueAfHcefa9ojYxYOjBv?=
 =?us-ascii?Q?/F0/YGwUDLtVGBNIPhZ90CHeD4rJy1Ktudc99nbQaSLUusSUy5uBA+AG6oXW?=
 =?us-ascii?Q?h5bj2KPa4vCNfhS1dDFBIYxIhHvTXTxB95u8Ge2MP8sFALPFEc/Q5/ogRfsN?=
 =?us-ascii?Q?hkmnSIj7IgYmNEW0mFKlQR1Rdx47DXWdRndnZC80aUQOLqFK9zpA3ryptN2W?=
 =?us-ascii?Q?QKRtGMP9on4IYAqE+uNMdp0blgqsRm4N8c1t2YrwOPu0/ZVGwUswrcTHwysi?=
 =?us-ascii?Q?KBHdG1JFmf2ipQ7GDF+ugBaC3a5OdxeV2nQvfHBrlCPzasrh/IAQ3qZby15/?=
 =?us-ascii?Q?ngoCwEppSUbuR1SSidsfLelcaFAErKXaP9JIERQWh6r4lPU/njKcdNDWaR1L?=
 =?us-ascii?Q?+xbikAuXGRpuQsW/jGm7blySLVJaSpOQZ4vm86bdp7t5gi2+TGDJb7jZN4cC?=
 =?us-ascii?Q?1InLUdu+Zkens6pVlCZPqee6aNEQ02CK02lAX8idOD6l8hVwzzWcI4s1wtdU?=
 =?us-ascii?Q?jcCch/HIh543zJAw21l01q1VyeDvj6hH1c2Gl5WX2CFjKi5LgsLU3iyhqDlJ?=
 =?us-ascii?Q?udl5+ESfLN+Qq843cYXI5iR9qg4Kvn5QksAtUMlpkntiCeTGRGEn1RyHK9NO?=
 =?us-ascii?Q?JgBGryCATfI675ATQBOePl0Y5olgjkBLYuaQCRtA+HawUxu+u16F8zUo0Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:25:26.2097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8772dd3-b6d3-46a8-c9ef-08dda2c3a127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688

The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
are unnecessary helper functions used only for Endpoints. Remove these
functions as they are not common for all CXL devices and do not provide
value for EP handling.

Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
to cxl_handle_cor_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b6836825e8df..b36a58607041 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -664,8 +664,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
-				 void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct device *dev, u64 serial,
+			       void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -684,11 +684,6 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
 	trace_cxl_aer_correctable_error(dev, serial, status);
 }
 
-static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
-}
-
 /* CXL spec rev3.0 8.2.4.16.1 */
 static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
@@ -710,8 +705,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static pci_ers_result_t __cxl_handle_ras(struct device *dev, u64 serial,
-					 void __iomem *ras_base)
+static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
+				       void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -746,11 +741,6 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, u64 serial,
 	return PCI_ERS_RESULT_PANIC;
 }
 
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
-}
-
 #ifdef CONFIG_PCIEAER_CXL
 
 static void __iomem *cxl_get_ras_base(struct device *dev)
@@ -802,7 +792,7 @@ void cxl_port_cor_error_detected(struct device *dev)
 {
 	void __iomem *ras_base = cxl_get_ras_base(dev);
 
-	__cxl_handle_cor_ras(dev, 0, ras_base);
+	cxl_handle_cor_ras(dev, 0, ras_base);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
 
@@ -810,20 +800,20 @@ pci_ers_result_t cxl_port_error_detected(struct device *dev)
 {
 	void __iomem *ras_base = cxl_get_ras_base(dev);
 
-	return  __cxl_handle_ras(dev, 0, ras_base);
+	return  cxl_handle_ras(dev, 0, ras_base);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
 
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
+	return cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
+	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
 }
 
 /*
@@ -921,7 +911,8 @@ void cxl_cor_error_detected(struct device *dev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
+				   cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -958,7 +949,8 @@ pci_ers_result_t cxl_error_detected(struct device *dev)
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
+				    cxlds->regs.ras);
 	}
 
 	return ue;
-- 
2.34.1


