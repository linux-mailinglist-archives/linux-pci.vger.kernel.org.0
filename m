Return-Path: <linux-pci+bounces-40235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B2C3238D
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 314F44EF330
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E4338F4A;
	Tue,  4 Nov 2025 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UK37Bo18"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545A3338F52;
	Tue,  4 Nov 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275831; cv=fail; b=JvCaCDDYhlQ9amr9JlDD92oYHlXII0uae074zN8cSGwYXbaprMGJ+ElHY4hMfWFU3XVJC3dG0cBajcyQteiy8Vrjoj4baFa1O5/dScuXDq8Cr2iwQF/FKl+6IEWb1jDVrROF7rgYh+k+PAgZtf9dS+og3jzZt8ckQLqIgAQJ5oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275831; c=relaxed/simple;
	bh=XPW+2rtyQFTY1dSZcSu+J20BPnB02US8lZ7YUju2nvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1Zl1gpd2jHA3MpDHAKgHVJKwrW1lKQQ9aw6UHrT8vYtmphW1qEUSzwFPrKpQ5BPspR70jR07NKE/UTQwTrEryOzi2vCRXE/AVHYDi7/JpU1yEtk29ZF+6G1q02dd/LItFcFp9yKQErpXZI6SplE8y7bWhxiGwvfkrT9fpYwi4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UK37Bo18; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVGl32N/BIFlU6knZXjo/BKpeZQfoiBFYf0rS1RmgwSYBN68459Os5PpTuXVTLO+ns5/Hl49BFImHEzRVflWVimWFIu0BGFCHJZdWbEKrGtUQ5QV6MVxj/fh1xc5r2VmzECLqeKKbfrNL9Gf3HotFCH6hKcODFPTyne7S1Llv5WZ+qrUTZYIqWcpDrmPQegCyR6C/dVnwGaRV5P6pulXUVdPkZs4qBMqOY7+cpHvJ3P1D/gVOoTl41AmogjDNByEW8xFTypwvugQ9pfaRLuO0E+nGBm9u8V9lKhHGFz2E+k3NgoN8cA+y1FeABVnLfdNiVVT5dbqPe7e41rRNI/zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cb8dJfXSiXk3kt7oeHbShtZ4F4wXIyAww3KxisEyfY=;
 b=bmWewbseOYHKzDSA5+JMxSgsh+xpcqaqdRrwT5aJcZsSDuzZCPrL5KEi7IutOQKYiaPaiZ/w924NSQsjF5Kloh5qUey+Eq7NR5Ss8t3AJOzigRvd+0IW5iEhICJpXLArC9/UeAntrjLAHcCUdzxBAmuQjL5Rea0n3F1xaJpovzi1otYAnnsiuKS70g8gJ6rfoemk51/odckg5s6vsiT64PolJvx5YTAe/2Uk4V3GJEirXhwmlBUnv4nhjNCuP0mUzCqmviQTzI9X+qfsgAlULaL8FGMRBLDwxJLYzcTskV0AH6jmOZxLqX5u3wCsw+co89ivFjb0JDeXCO3PRBYVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cb8dJfXSiXk3kt7oeHbShtZ4F4wXIyAww3KxisEyfY=;
 b=UK37Bo18XOWzXUbf3fSAKbTw7UICTBFJLGjHaV3KvlFbSEGnEQq0++PblvJnj7r39ocsTM33U7pDIKTFqrY04VewYLQZSdnHOjqhJeeq7SacNae+c4eFOkHz5FrwejmPTGFnH4Uhe4ijxvYe5M2epsE92yXUzBveXZEjxoRFc74=
Received: from BLAPR03CA0118.namprd03.prod.outlook.com (2603:10b6:208:32a::33)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:03:45 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::db) by BLAPR03CA0118.outlook.office365.com
 (2603:10b6:208:32a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:03:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:03:44 -0800
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
Subject: [RESEND v13 03/25] cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
Date: Tue, 4 Nov 2025 11:02:43 -0600
Message-ID: <20251104170305.4163840-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: a5495e3d-c7ae-4077-573a-08de1bc41d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdZEAbgmZBJSVHD7h/YIJnyYS7qVuTYcvo7i1ySd8vy27pZpdukaLFtiamHs?=
 =?us-ascii?Q?BNiOGV9s7U7GVMdJeF78JiLMik8kcPM7JqP9G7uuUfkBMnNpCnz2f4ua1upX?=
 =?us-ascii?Q?k3eg30crKXR/wtSV8y5u3QbHsknU8jN3UL+6Y/flMQdwgW2bVN7FZG7LofZf?=
 =?us-ascii?Q?j/5QLRgh70Sk3rMAqE56Od3UlS86I1PPTTfrxlXbnXVwh5XXhpw+6fBMny2W?=
 =?us-ascii?Q?MNp/QhFqO1NGFhyYmFYKrtSKncmQq08bnbChYt3so5Vdb6mj/3SDsdShaHzo?=
 =?us-ascii?Q?51b2Vvp5NLgOAp0D+mBpU5ok5b5yQl9nWGPjmn5iOiydoHntrd5HWnmp/O3L?=
 =?us-ascii?Q?ZCSYwDyAEVZJjnwX1r8DOmddUCPNl8X+cbBu08G5lQ7FFvUTL9YcNVBfG9mm?=
 =?us-ascii?Q?5MEXr1X7DyfVf/IZPKIQAXOOv4yPY+6h02lRLWyocgQo7Ae/Nyq2aG3Wyixw?=
 =?us-ascii?Q?05E+WDYJmWBOoQgGtNxq7BXWbxKEiuGI/SegG6KOQ4YPEe2TuHmnnaCfLjNc?=
 =?us-ascii?Q?AMnut4Okaiumd+JbildKtCk6Vx+D6ogND6e8MZwFV3tx6i3ACqhF5njwwD6c?=
 =?us-ascii?Q?TuSAB7scz0nY2VsifD86gNFcHx+/6kAQyGC2j+j9JBXupxlSUI74NqnkA3r0?=
 =?us-ascii?Q?T15reR20tee/i0lJu3SO2AcmOXM7t4ODqRisPYbZlFONERvemq6K40xeiBRu?=
 =?us-ascii?Q?VA2wARZZ/Yz7bWK7wd9knDL3M904U9G5zWLgrb45mB1Cy+8e7iRmpwxVLZRI?=
 =?us-ascii?Q?VEIU5nBCaEbdPfjWvGLJzEPKXjcdOJk32JHnUDHehjDovn8urlnQpnc8+rtT?=
 =?us-ascii?Q?CVZyY77ZL8IzO8U4T1IZz8oeBqAwTobWmd7X0EYTte0dMU56PsLc9fSzrSR4?=
 =?us-ascii?Q?skWzl90iyA7yhdJJke3UKg1gXWTAzRKsegqG71Cl23V3vTRNMhhoTHiasRPX?=
 =?us-ascii?Q?QxyEjHrOK6x4NGr1/saSg7lUVxTORuc0Uj/9DpXGLncEqZLuJ4KoeYevg/eB?=
 =?us-ascii?Q?MNVKeZOpZmAuc7fHbc3GT37o5x7BPfXo8+WvcXn2nrVgxv+2+X0b4gZauSan?=
 =?us-ascii?Q?HEKrTz6ISXgMfBThOd3Iv9mEqHjQ4RN1H+4jouAYTe+FSx5yw1C94s1tu+Ke?=
 =?us-ascii?Q?xg7b/bqCLnZqf1SpFavw5906MaqHK9IvyvJrIMb+HVweE8tApHt1FA4f9fJ/?=
 =?us-ascii?Q?dbKhhc4RD3bHtN9rAqLRnLm2xJfPu+mvKReljuhMJLhScatRzjTKQHGmd2es?=
 =?us-ascii?Q?kdezMT5YitUJuS1IW7HUasnZyOF6qjCOYJzh0Ls6i/Z8nVQDQhk0pSWsqr1F?=
 =?us-ascii?Q?QIQEUaAEjLjBVSMoZ4vwu8iKO1LzaGlDIvwyHlSYGwy9h9+U4t6qEd/mO7T4?=
 =?us-ascii?Q?MHaTNMsLJu4ZJKklEdPCIPz/0zr37hobi1uaSoBnc8wRuuV/C/tDDm98/lj0?=
 =?us-ascii?Q?EkOu2QIVNtYlSTSPiKInH7SheppcF4nYfkB+I3wfLkS0eP9gmOLA35rA9hZJ?=
 =?us-ascii?Q?m8zEoqsmyUftuSpM7eKCq735UigEUJV7CkptrYM2gGqghe6HwFccHHMvewSS?=
 =?us-ascii?Q?2btiF1U8XF2YF2qGrni45qsLe9SyUD5pTrcYwOT8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:03:45.3592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5495e3d-c7ae-4077-573a-08de1bc41d67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115

The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
are unnecessary helper functions used only for Endpoints. Remove these
functions as they are not common for all CXL devices and do not provide
value for EP handling.

Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
to cxl_handle_cor_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Changes in v12->v13:
- None

Changes in v11->v12:
- Added Dave Jiang's review by
- Moved to front of series

Changes in v10->v11:
- None
---
 drivers/cxl/core/pci.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index cbc8defa6848..3ac90ff6e3d3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -711,8 +711,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-				 void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+			       void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -728,11 +728,6 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	}
 }
 
-static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
-}
-
 /* CXL spec rev3.0 8.2.4.16.1 */
 static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
@@ -754,8 +749,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
+			   void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -788,11 +783,6 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
-}
-
 #ifdef CONFIG_PCIEAER_CXL
 
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -871,13 +861,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 /*
@@ -974,7 +964,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_endpoint_cor_ras(cxlds);
+		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -1003,7 +993,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
+		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
 	}
 
 
-- 
2.34.1


