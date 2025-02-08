Return-Path: <linux-pci+bounces-21007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A2A2D244
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CA23ADC01
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072442AE7F;
	Sat,  8 Feb 2025 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LYqhZmFW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2F145FE8;
	Sat,  8 Feb 2025 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974762; cv=fail; b=iAq8H4bJ1fuZXs0OurwxRZGfHvdpy2AS86H86QtCrNf6tFeHS+pVpFq3Pf4ZTk2M6gqb3MXUv97G/nSI2ticgi5PSkNKrSPrmx6UDCJLdQwuqtXU+eGPXgfxZne9nGSRAnzX9JV/0Xt58HDWJQxnsuNJkvz/sCThobe5rQIqb+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974762; c=relaxed/simple;
	bh=0ntoOUn+r6Po/Gqrl52ELdIZ5Du3B0P/l7LgzwvZbFg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1SodHfeDsfdzZh8xqzbpXS7Re/JZv+InOaoerOmqR1P+U2No0PMdJK5KP7y2ebOr47R0pzBpWt5h8Z0LMmDUBsFyYAcu3KlG5Taez34/kyfabBBrpb2t6ljDxHaiKW1uCDgnNB9GSGxXxbGiQ5+DNhOTybE/Be55F9mHNmuVs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LYqhZmFW; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ne/b5qPt4LgtsagGsrTuEGaY3Xw5kpmg5It3EhDMBFYwzkr0VCYQ7tRXpGxlodnxPjFOzi08kN8ODYMlr1g/aeH+uO1eMBHsAl198EqJ0rPCjbeaRxeM8pVTlA6y/qYHwLQxWgPY/nbOVDTBUg4mO4ijKKkiFYbCU4QrODTSC39rcurcpp0Ena8Joi0cgSu9O97+nmUBFfmrlPTZkTtCUoVc8Vg9cbrdtBBvY+AVwiR3tFqNb/kOZNB/Gf9GiiUjl0t+hE5ixpGYVzkN+NtGUjneYi/pJ1ymaWyhOQtMaoasLyyQVC6/90cqYgvZBt9AnrpwgaQrr92JaBBc+FqRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvhTLc+jPoHYjGbJCgrTb2mvlZY993cTERpJ22pq16U=;
 b=jdI0l9qx+VQ/GcSh3elG/S1VoQuISQFlfVVwQzCdgJeehXSsxUChv25SZj1nfl8t5pZ4Dg2i4TV2TRG6t4qm+RYkUGjFgqI6YfqhLSB4bpN1TiIiU1GqoMDKl1wxxF6lDsy3T4Ho12X1pf1cQHqZawAlZx5y18A71mBGhkyc7/LmZv2JTKkOTOS+9X74wwpmDNXH7z37vPwPTDseRSCVa2un4Jl68GLrkOmJjOxBhmHnM2OQHLQIFVBfZUtgXQkYKeMrt3BGRJT5yfQrnCs2kqSA23MZzyRo7NK0pJbGZy63cS8jxZsC0gjF7dSk4cqsWyz9O7QCwY0jaPFLpoBM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvhTLc+jPoHYjGbJCgrTb2mvlZY993cTERpJ22pq16U=;
 b=LYqhZmFWjQnAR4XAlYG8x2Pn5+o301ps4az3yQdz3trhFDxozKEHpkk9+xy0epyW4sAj6fgJbwAuFiT06CQnlRFPc0O1Y0ubNpdNHKFqtd82vFgT5SuNpN5PKl1vq1p0JG4/0GFtPfJjQT5vUh5E9zWZY46KFXNNtkw2VL7nlzc=
Received: from SJ0PR13CA0139.namprd13.prod.outlook.com (2603:10b6:a03:2c6::24)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 00:32:36 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::34) by SJ0PR13CA0139.outlook.office365.com
 (2603:10b6:a03:2c6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.8 via Frontend Transport; Sat, 8
 Feb 2025 00:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:32:36 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:32:34 -0600
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
Subject: [PATCH v6 15/17] cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
Date: Fri, 7 Feb 2025 18:29:39 -0600
Message-ID: <20250208002941.4135321-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4d15ae-73f1-4b14-23ee-08dd47d815e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUrbUzpb0fSjXh/wztaKBZOVyaePvOlGIYwD8ZHlhy0sjYsyjjnWfehDLTk2?=
 =?us-ascii?Q?8ygAbRdidOosHrgPzRax7TcMXsf9pXa3Vh936HdVfF3adf6iiiEEeTv1UB4v?=
 =?us-ascii?Q?vLRjxZZmTLmPfKbXEhvIZSEnpD1tww9E4Xw63UUWxcug+ERMwnRRWZw/sFD9?=
 =?us-ascii?Q?kKtFnJFPyDi2MbQKoVuXR+OwJYhmByquHWkQJR/ihCsRUmpzLDV1NeeHQzAi?=
 =?us-ascii?Q?DI7jY+Z50Xp9Ld6ZF1YT/mmUtv4BW8wcfF5YOeYEtvxbkaTCt5VaFywIjQ1c?=
 =?us-ascii?Q?Cs1Owsa43w+8fWGzTtAh/8yZgAt+vqgmgIxypk6BWQPkJPHaqlxi00JuDpgW?=
 =?us-ascii?Q?0DRznfUWi5u1oYhayMcK30nMzlFtVBmefjoNuUCEe+jbdQ6VG8FSnwJBy+ap?=
 =?us-ascii?Q?kSXNO/FkiJoi3QkGUQFo/SAatHgC7h14z2JBkmo46H7t4ZCEgCBxEe/gDAg+?=
 =?us-ascii?Q?eU+lUNV/Z6u4jrG5DigMMquZvg13RpdIkmJm7xxESM/aRi1M50VU4hZEPrJa?=
 =?us-ascii?Q?z0JnaTg7f9/f2O1zACA+1D1zWy2N8vPaFOKfiCqQMlMkQLKyekn7TGSx98tb?=
 =?us-ascii?Q?ezPV90OFnHCRV2v84MlT1LcTXOdOrSi/kZjPTI9obSTEukp+MeXF+uTdlZRe?=
 =?us-ascii?Q?xNYDhZBsboPV44rpxW5A28v7mE9N8V4JR39cw9mRIpY7Xz3BeAIH+dYO0J4M?=
 =?us-ascii?Q?zxBiAvftvDyXFN38SIxO2wiaQ7yDxsRfj67SIw1KkRg9sngCbQbl8sHdAUpX?=
 =?us-ascii?Q?L7khsp4ZlrW17Zs0N5Fpv2p+cvpFYvQxI9nixlEy4BU0plBG95VPTv1tRxO5?=
 =?us-ascii?Q?pMXAqg2c6NFl/he6ZzFzKCBl8XZPCSFD1roFHgzpT1gskPtD7mMGB1W0hsA6?=
 =?us-ascii?Q?F4IoCZ2r+mcPHrxm8Z5EvZcEMtukZK705A1H8tDodLKmSQ5obj1N9CJmtI/x?=
 =?us-ascii?Q?45Rl9FWVrETXxUGAfIy/VvajnyAqi4tNzSPTOkYGNcXtFG5vSoLicOGO+gc4?=
 =?us-ascii?Q?ADliaeEb+mAhE0fMdChZPzDWPCaDl2TMOuOkAJ0+dqO69sJab58XQh3LkD26?=
 =?us-ascii?Q?UgY+Xk8BrVabbzTMtJREdpl0RI4URPRuBpBsdzVYMdaET3ZgqFeHJcUUjepI?=
 =?us-ascii?Q?Xz45WTCxWN0zCcbqcmrpWfmCPp8WxGH2GUETv6ouXBQPc0+suLo/I+BtoMIu?=
 =?us-ascii?Q?cDYHTuosUC5299HUBtmhOim9inPVj4QBi1z1laLCVMZDkJPBq+PvVjFb0hyX?=
 =?us-ascii?Q?h/CZfmxPylJy8gm2G1ZJR8EQAEbvRSS4fdVDfte5yRJxqBl5uo3tK8pJFW1M?=
 =?us-ascii?Q?CM9PyZehjS4/vD8DNMQNTC+QZ6sEhZbhPDyJC4tklTL4vmIacTrpHHmXNLp0?=
 =?us-ascii?Q?NGvDOk61Rru0OXrxWJJopIBVQtq9ivD3Xc4Lf1xnW2OJHA4SvSE3701fY6Cv?=
 =?us-ascii?Q?UcjiRe/7X9xWeBlS0bmqbUw7L3xnbS/n1SCRoAjIyPe6ZZ4HX6iRgCBCsDrw?=
 =?us-ascii?Q?RoPKgtOxCq3iZcG9NKLw9hiX6yFxEAR/Gv3o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:32:36.0959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4d15ae-73f1-4b14-23ee-08dd47d815e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
The handlers can't be set in the pci_driver static definition because the
CXL PCIe Port devices are bound to the portdrv driver which is not CXL
driver aware.

Add cxl_assign_port_error_handlers() in the cxl_core module. This
function will assign the default handlers for a CXL PCIe Port device.

When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
pci_driver::cxl_err_handlers must be set to NULL indicating they should no
longer be used.

Create cxl_clear_port_error_handlers() and register it to be called
when the CXL Port device (cxl_port or cxl_dport) is destroyed.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 59 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f154dcf6dfda..03ae21a944e0 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -860,8 +860,39 @@ static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
 	return __cxl_handle_ras(dev, &pdev->dev, ras_base);
 }
 
+static const struct cxl_error_handlers cxl_port_error_handlers = {
+	.error_detected	= cxl_port_error_detected,
+	.cor_error_detected = cxl_port_cor_error_detected,
+};
+
+static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
+{
+	struct pci_driver *pdrv;
+
+	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
+		return;
+
+	pdrv = pdev->driver;
+	pdrv->cxl_err_handler = &cxl_port_error_handlers;
+	put_device(&pdev->dev);
+}
+
+static void cxl_clear_port_error_handlers(void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pci_driver *pdrv;
+
+	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
+		return;
+
+	pdrv = pdev->driver;
+	pdrv->cxl_err_handler = NULL;
+	put_device(&pdev->dev);
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
 
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
 	mutex_lock(&ras_init_mutex);
@@ -872,9 +903,15 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 
 	port->reg_map.host = &port->dev;
 	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_err(&port->dev, "Failed to map RAS capability\n");
+		mutex_unlock(&ras_init_mutex);
+		return;
+	}
 	mutex_unlock(&ras_init_mutex);
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
 
@@ -886,6 +923,8 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
 	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
+	struct pci_dev *pdev = to_pci_dev(dport_dev);
+	struct cxl_port *port;
 
 	dport->reg_map.host = dport_dev;
 	if (dport->rch && host_bridge->native_aer) {
@@ -901,9 +940,25 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 	}
 
 	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_err(dport_dev, "Failed to map RAS capability\n");
+		mutex_unlock(&ras_init_mutex);
+		return;
+	}
 	mutex_unlock(&ras_init_mutex);
+
+	if (dport->rch)
+		return;
+
+	port = find_cxl_port(dport_dev, NULL);
+	if (!port) {
+		dev_err(dport_dev, "Failed to find upstream port\n");
+		return;
+	}
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
+	put_device(&port->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-- 
2.34.1


