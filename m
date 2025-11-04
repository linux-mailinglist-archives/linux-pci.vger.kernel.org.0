Return-Path: <linux-pci+bounces-40256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923AC3245A
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2BF94EA5A0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF833B6ED;
	Tue,  4 Nov 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eN3I84OI"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC8242D88;
	Tue,  4 Nov 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276065; cv=fail; b=FcpTO3ekaS6lFNhuiHSa4ZGIOWl1hy0VSJNZpTZdUI3d+9dwFsEjkNT9JWPXUuYnZYtSQE0jSu2H8nDf33sEyh2WJpOzjwW2gKzTXVv/+hsd/370+DOAm0ffYnEyZGFVvDz649go+zb77aKkDzaTFbO2xbGxhmSiY8rLb64WDr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276065; c=relaxed/simple;
	bh=SkNdiXaGS73zw0aEKz3TDPByCzvXD4RAcUm9Hn5htJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAOP0EOYIfQ/NKkLSk+YG/2c+TidN3ijWxeWsMXB7T712afJnkPvi2by6lkhxfhGfff7eQbOkKJDQ3CE55YtiMtSuqGDpBnqAwcYWoXJpuWSUUGfjAwGupnc0TS4Cvxp8CY32FP0G9oop4gYrtIneB7vuzugelXzEQUq551msLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eN3I84OI; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4trAGf8zzeIiV8DWJOGY24i7mR+F8fzhEoL5Wg302+jeuz/UVlfUqGE+GSMs99v/cdrf+78vJRQkIBA3y+dmwydEGKHALCnrgSiF/qA4qSC5/9CEZbC5N9ZiZ0qJa8odTbqmGDWbGZMDLVLfj/slvkomp5ZeojXIfvLVsW+nPb/Wajl5DVdzTNATmJJtpdqHzhIJpHFq28fY8hEG+DrQ6yWwel9whM5lQPlJieizAux4wetNMLlOf9/jXa1hBpunpcaPxT2vxjE/F5m9itlAVwVFvt1QDKeufb9C0CKNmUmESf86HmJ+sD0QNxGaG8WIcNXBvw8BRbdutUHY8bQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu9rAifQXi7meiqrmxr8Qum1moIc+lVMjh2BAosSQiU=;
 b=mjdd1ktrmPaDL3rXaW3RLiKx360gA8kbyUEDzOJrbbwLz8eFc4if/cKdB9ZlnjWzfndA+X8MAPtDY8vSii+Olnlsgm4y9E3qJBX6aQDZ4+JbKjvs6OaNYTQLKrOXXuyXCnHeiTwN5eYUF8cMaCY7IBHDVHFsAvgHdg6AocBzU0edGQdmLxx+qaEJBSqxGGYnXwsJ1x3e4nWI9uQpOXJNoC3PSKm5SXsCtPRLlWYz/STpI2ZnXzOg/U3coYQFooS6KH6ibepp/vBQroALDVOdWXUydX+MK8ueIwR8W3MBXFCjri5E0eonD7sfdmsz7oFey8GoG99XbA0mskVcvDjvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu9rAifQXi7meiqrmxr8Qum1moIc+lVMjh2BAosSQiU=;
 b=eN3I84OImndlOEkfBKQDEmBf4OFP450XI/S2D94XLsKjOr35vjC3FOfaRmKKQANWzNz5B0r4niIHLGSZFvNbM/6mwDKNZaFmsD039emeLXvVGi/fNEcjYMe1wo8yckDfmmbuuOb7icNPOGFlmkduKumjKLFBplE+6Nf832vbzNQ=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by SA5PPFE494AA682.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:07:38 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::7) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Tue, 4
 Nov 2025 17:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:07:38 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:07:37 -0800
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
Subject: [RESEND v13 24/25] CXL/PCI: Enable CXL protocol errors during CXL Port probe
Date: Tue, 4 Nov 2025 11:03:04 -0600
Message-ID: <20251104170305.4163840-25-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: 995a63d4-ce9d-4966-8ad2-08de1bc4a87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpLKJiJ44sdosC76/u8Maooyo+dizlGNwW7s2eLuB56NtcVMMeAWrOunbni+?=
 =?us-ascii?Q?+d9GQfdIWC1aPUwFm17iWIxR1EbzqqdJofbdHj5ZojKg8jXFc/leDvyz47zW?=
 =?us-ascii?Q?5Qa2q+6hvg9/TpN6DDEcR8BqtlMJcTsKdM3/STNFDJV+s9CGCE0VKrpLD5w7?=
 =?us-ascii?Q?94ThTa4msD86O60StIWxuOqLXvK7hfU5spBa0KbfAUxxIdJ3ng4Mf+zWNYD3?=
 =?us-ascii?Q?50tmgAwwq54iRvC5lXfjv4K5vDGNbrWnL4W5Hl4vY1JH6ChMoZ9N9uH6kCta?=
 =?us-ascii?Q?x6lVeRVJbxAOhZwrxrKLTJshQccG6ItGMv7au4pAIZ58mmvvafZYH5yJWrrX?=
 =?us-ascii?Q?M3y+9OG77/od8Nztb0InM4fY7I1dhDTW82sU5RkZOm3nmojSKyumdvN908DV?=
 =?us-ascii?Q?boN7EsydFmY/jUqRuF5S8Txm85coMKWHXFpR0Etq2jpNP3EFSuGqK6ykR3lK?=
 =?us-ascii?Q?HumvaOgcPgVUNM0UEWJFNViL/clf0sAEos9HODL/lrT59ztMdjaNUN4qoA5n?=
 =?us-ascii?Q?8PT/oHGrDh1vgXB5UF07dw73PWtLen+kETk/Wgv1666xpEamk2VAlEtpdD+H?=
 =?us-ascii?Q?cL3uDOYSCiWv8g3YstDWUHq1eNJqqdA2C0roAKa9mHD1bkEHYPezEdnuO6M6?=
 =?us-ascii?Q?gTnRHVp2ADORiZWG73GxJWx/kYtZ+WiiyC2NvPsjlkjY+r7YV2PgzLNbop1r?=
 =?us-ascii?Q?5IOj0CXwG421OZAUe/GZs7CUCXajiSgfJkjfur9d50/dv5UuxFFQyQ6QI3Pk?=
 =?us-ascii?Q?afBsGymo8XZCVU6Duu50MGQew7/AmHWi7rOJ0HslRFZMQP59OkiHLjBNhoNV?=
 =?us-ascii?Q?pxWaWCJqJ7ChIh8enwbumJaU1LV7rPfn2nYJ//O9wTnUb7TDxKQLVy0r8Qc6?=
 =?us-ascii?Q?aORaCrjAUv8gMLhc70FuDs2OUzvVewuoFmWprD2UzOETr8e0e37muAsodiSb?=
 =?us-ascii?Q?8Do1iU/XCj4+Z2wdJ1Oc4NhS1cYfM+uHRcwNPA1Dkcum0YhdsLK9UHzYtnBK?=
 =?us-ascii?Q?UxtYKYMpgy7qeS9PDwTnIuiBr3FwcnnKIvJn007d+OsNr1r94u0JFveOcBUO?=
 =?us-ascii?Q?SUC8TmjH2kJSUN9+Xl3ha4uJ8/UP+77dx+j5vViMa39+IOLcacZSiZv7KNyH?=
 =?us-ascii?Q?ASF4kpPQ0+Ix6JlTKInBy85ZYj3/ax+b3+wckilkoUA4RIQi2kAfMCj+cb+v?=
 =?us-ascii?Q?x6/ZLgaw5WipdhJFYCe4LOpHhpaxzqjeZOSqV/rH7zGEDRr8LGAwQD4PsqgR?=
 =?us-ascii?Q?lEZ517s0fRSfSX4ac3jAmdM/8INgxPPOLB9WaS1r0jAPkvliCBCPK6Sm7PSs?=
 =?us-ascii?Q?y4B4JmhcsiRu6sRK5bo4545DMme0ostwtCT8TQCIxhYXIq4HnF9t9EsxiyNJ?=
 =?us-ascii?Q?osVXx/Ho53HOlNxEqXbwunT2xHGjJdlWPEO6yoqvfwxZmM0o0ZUV0ngVvpxc?=
 =?us-ascii?Q?iNrkDcAV5BjeGhoAZeX8ZusAFo0PYuXrUn9c0/ONmi37AzQuVsXufDcGQnPk?=
 =?us-ascii?Q?XG/5a5q38YeIMDnM4eTQhX0RbVZ6xfKJ7jLkHlpi6zrgQAG0rIAb3BqxuD5U?=
 =?us-ascii?Q?M4FU9WzatF0JRPxdcpgaO35UDxvaCjxk9gH0QROC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:07:38.5986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a63d4-ce9d-4966-8ad2-08de1bc4a87a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682

CXL protocol errors are not enabled for all CXL devices after boot. These
must be enabled inorder to process CXL protocol errors.

Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes in v12->v13:
- Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
- Add Dave Jiang's and Ben's review-by

Changes in v11->v12:
- None

Changes in v10->v11:
- Added check for valid PCI devices in is_cxl_error() (Terry)
- Removed check for RCiEP in cxl_handle_proto_err() and
  cxl_report_error_detected() (Terry)
---
 drivers/cxl/core/core.h |  4 ++++
 drivers/cxl/core/port.c |  4 ++++
 drivers/cxl/core/ras.c  | 26 +++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 046ec65ed147..a7a0838c8f23 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -159,6 +159,8 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 void pci_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_port_error_detected(struct device *dev);
 void cxl_port_cor_error_detected(struct device *dev);
+void cxl_mask_proto_interrupts(struct device *dev);
+void cxl_unmask_proto_interrupts(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -183,6 +185,8 @@ static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
 {
 	return PCI_ERS_RESULT_NONE;
 }
+static inline void cxl_unmask_proto_interrupts(struct device *dev) { }
+static inline void cxl_mask_proto_interrupts(struct device *dev) { }
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d060f864cf2e..a23c742eb670 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1747,6 +1747,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		rc = -ENXIO;
 	}
 
+	cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
+
 	return rc;
 }
 
@@ -1833,6 +1835,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
+			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
+
 			/*
 			 * If the endpoint already exists in the port's list,
 			 * that's ok, it was added on a previous pass.
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 52c6f19564b6..101e55723785 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -122,6 +122,23 @@ static bool is_pcie_endpoint(struct pci_dev *pdev)
 	return pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT;
 }
 
+void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev,
+							PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -230,7 +247,10 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
+		return;
 	}
+
+	cxl_unmask_proto_interrupts(dport->dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
@@ -241,8 +261,12 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port,
 
 	map->host = host;
 	if (cxl_map_component_regs(map, &port->uport_regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+		return;
+	}
+
+	cxl_unmask_proto_interrupts(port->uport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
 
-- 
2.34.1


