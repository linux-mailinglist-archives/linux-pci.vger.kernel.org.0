Return-Path: <linux-pci+bounces-26631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B076A99DB5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5361E447A18
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288855E69;
	Thu, 24 Apr 2025 01:05:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023084.outbound.protection.outlook.com [52.101.127.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C514830A;
	Thu, 24 Apr 2025 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456701; cv=fail; b=BnT30SXu+tBXQZRX48c9W6fPNalQhp7XKiur6wiRVonD0/miNwH4gLwMPdlo2+3qE4ehuH1vbNR1JIjErhNL7dRvgxr02hQ8oUPu6ikzmSpmUpHUsQd5U13W7EpyhjjmuNMj5umeE7b/8RG4rSIHf2jwX0RypNcogXnDaQLAH3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456701; c=relaxed/simple;
	bh=yiQmHltr95O6tjIh18B+Gjw4K5FmKmtOp60bZhQpuRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARV/p7MmkzJIS29mIagvniSGa4+W0k25/Obr7xqiPpVcZjvoio9BkKrsVHQNolzi+Q1hWZ3RuADfhHWcNwVNHF3feekjYFG0dDb+slSMRZBPPb4XvgoBmI5IVUX5ylZTDTO+Je4mwosIGLBTwnRJLbVZyuTVc4Mi9IesJLJxbQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR55fWz6NJokLvOhwHyY6RuU44w7bdAA/XT/2sOATSdAUvIvIKaDirx6PmZPM15Mw5/tfjjTA6uEJwJCfA+b0OZtcKA1LG91bTZUg/f1YAYf3wFNvlMORSLY+FWXsP6NI0EzbtjrzhUrD+gwXpVCwdq4etKfy2c0fpkYdmVipeRVS4MX/lvckr1Hip+ziii009ygZ1yun11PyuR9rryekRD0r41z/10Xn8QiF/ec9bUs2Nz9GAuBp5j8bZ77OixQvWLY60qzXtri9/DtkTxgx12yK/f5UFEVgtYyMHTKoZwa0cNkovcKbIXJVwR5/OJeVWzmGzBusigrpT/kCitC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rthQcY8LStxRBl8HAVoHoTGSLz1ZZw7G63eQ+v2Umo=;
 b=ZzO87g7l5F9mlC7VUDt9ekJ0yxt08GTjqoch4tzo8+IHfvUcMEEfT4N+V6m2S/eo5pB7ioBZ0r2VutJ0T8QWR3zqDE3JzGL/DTdXF1j7XHR6Zz/72YWk8hoO5DMDClzyOEYFyiHqRMVfOsGs58nejDCJC+YVFV3nOSTBCu6RldGYFNRPb1XqBnhx+FJ91sbwA4ZSrIMxbDU8P4fNBXyK7HjneLR7GYTVqjb6k8WUtxUiobVVnXT5p2L1g2u6vMmt4/nt6ctJ26CaDkihwaE4vOIKC7fVPL6G6QPm5qgztNU5J7BpBE9q7IIPZuFwM1VVPbf+tGSBM/tGnEBzjRffZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16) by
 SEZPR06MB6038.apcprd06.prod.outlook.com (2603:1096:101:e7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Thu, 24 Apr 2025 01:04:51 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:b6:cafe::3e) by SGAP274CA0004.outlook.office365.com
 (2603:1096:4:b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 01:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 01:04:49 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id E47304160512;
	Thu, 24 Apr 2025 09:04:46 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: peter.chen@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v4 5/5] PCI: cadence: Add callback functions for RP and EP controller
Date: Thu, 24 Apr 2025 09:04:44 +0800
Message-ID: <20250424010445.2260090-6-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424010445.2260090-1-hans.zhang@cixtech.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR06MB6038:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3f5e0f4a-3d2e-409d-4b32-08dd82cc0325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9mOka00GEUWDqr6jX8tFrefrSAlk6WH60qNO0Gn+KyLKQUkdyfM/px6pydMr?=
 =?us-ascii?Q?J/eiP5cAzsJRmGNdOFdJGRWdjwk14agw83D/nrpduB9RYgRhr2mtjdI9riGZ?=
 =?us-ascii?Q?G11i88/tH5EG5iyac/CwD6udw4/xGUIA+ipYVGzzK9sTA3prPUBmvVitvBOo?=
 =?us-ascii?Q?J0jmSIQwDYwe3K/gRECZgZQK1M7Pyt51t3WJETrWu6RjBMYQO26i72urtokZ?=
 =?us-ascii?Q?vQpXqRQsqDGU18suYBKa2BhtVlgffgaZpAO8XbMVwfrymCpVf40hEfq9O9o1?=
 =?us-ascii?Q?37X5a5yXHeHHmUVmoX9CzOlU2+yTLd1xHDbRWYfNhlstogyAfyjkhvtPUwh1?=
 =?us-ascii?Q?yq18U37F9iOo9/o/ywIRdcFaCNGBdLTeTqZQl8FhlqU0obnpsOCioS9F1ojt?=
 =?us-ascii?Q?+0pfHyecN5x3oOxUrMGLY63eENid12DK6Y8NFBGGTF3nRL1oobzVRM67tswy?=
 =?us-ascii?Q?P66KVP+y5KOHCvwVnIFJlPYdi4rQvQyeFPqaQ23KSLVIfgQJMmfvN8rVeByQ?=
 =?us-ascii?Q?iV2bPY4fhd3WA8Sk6XFdvYSiE1eA15gJV710p8DJOuKdKALT1+lW/rEpJgSy?=
 =?us-ascii?Q?r5JxQkcgfMrSlASZvGasi6PXb0hahF2/fFrGVyxhK5an+H5t5/kahDRe/iZy?=
 =?us-ascii?Q?sXjk4UxF2GI3pJepgcj9T1K8vJF0bX5LpS1ocAlcIGqXNBgn3QUQenpIHjZ0?=
 =?us-ascii?Q?wL16tMcUBYHt8aZbwHVpOPthp+Gf6uxS+uyJJRINXu84JCBP440N5UcDcpkE?=
 =?us-ascii?Q?U6UFE15JFmptQ/FZLWIV56idNyroM4w3duunNYu0aY6vc5cjTetDEBhNUvTV?=
 =?us-ascii?Q?bbBp38ty+NspOdUp7HOsJS8hZdvCx3PItUcmKwVyORy5IEfXDdJFTDJw0UtQ?=
 =?us-ascii?Q?nV4lr++7mPixOxsf3jWf41v+VPbJybE/oqUXN1aeDsYYyTALWV4laiee4hjb?=
 =?us-ascii?Q?lFgMXG2eHy7KTwV7KPoqWnWTBZ5fIMldPGNCbUIbbJRnn4gs6BC4Xqix3ghH?=
 =?us-ascii?Q?sHe/SfHUIJlt9otmPkWiMHOIxamPcpLon58Lx29gV+spuRARvWoh7NKXKWpY?=
 =?us-ascii?Q?wNdSv0b08E3uGxMKHJHiaHicCXflhNcBkdtrzC7y6xkZehr6mAn8R8lXL+h+?=
 =?us-ascii?Q?vpzTY8BSEne0l4u7tZppjQFSV3pErJZvs8QAWm44AreBphs+Bear6GyIriCD?=
 =?us-ascii?Q?1fSb4AG7yQWpC71plAEOhpNxkQQyrZpKa8NmuQ/2PMmaEOIuZ7+TCIx/V6gU?=
 =?us-ascii?Q?LtYdfobthgV8QXOZaEEFXKZJEXHHAAVnvYYVP4hl4F1+kLS3xsq1Wyz0sl2H?=
 =?us-ascii?Q?EDPscYFOx2bzLwb4UQ8aqP/PsLLo1CXi64iCTnlFM13xLVSpJizNDSRR3lHl?=
 =?us-ascii?Q?/wg2YgbjwYWEdUKboYyYr1eGxh26PpEZtk/I51kkO4S9X/8dYcCadL1vvCh8?=
 =?us-ascii?Q?VXcY4hWyvoE2XqsdDoVZsdo4FB/9rO3ISvXpnE2o12VzGOIGzhb/9rLegSzp?=
 =?us-ascii?Q?Z6ae362/r6E9jp5qxT30+m4OchcYZi6CBNeZ?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:04:49.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5e0f4a-3d2e-409d-4b32-08dd82cc0325
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6038

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for the Cadence PCIe HPA controller by adding
the required callback functions. Update the common functions for
RP and EP configuration. Invoke the relevant callback functions
for platform probe of PCIe controller using the callback function.
Update the support for TI J721 boards to use the updated Cadence
PCIe controller code.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/pci-j721e.c    |  12 +
 .../pci/controller/cadence/pcie-cadence-ep.c  |  29 +-
 .../controller/cadence/pcie-cadence-host.c    | 263 ++++++++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    |  27 +-
 drivers/pci/controller/cadence/pcie-cadence.c | 197 ++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h |  11 +-
 6 files changed, 495 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ef1cfdae33bb..154b36c30101 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -164,6 +164,14 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
 	.start_link = j721e_pcie_start_link,
 	.stop_link = j721e_pcie_stop_link,
 	.link_up = j721e_pcie_link_up,
+	.host_init_root_port = cdns_pcie_host_init_root_port,
+	.host_bar_ib_config = cdns_pcie_host_bar_ib_config,
+	.host_init_address_translation = cdns_pcie_host_init_address_translation,
+	.detect_quiet_min_delay_set = cdns_pcie_detect_quiet_min_delay_set,
+	.set_outbound_region = cdns_pcie_set_outbound_region,
+	.set_outbound_region_for_normal_msg =
+					    cdns_pcie_set_outbound_region_for_normal_msg,
+	.reset_outbound_region = cdns_pcie_reset_outbound_region,
 };
 
 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
@@ -479,6 +487,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
+		cdns_pcie->is_rc = true;
+		cdns_pcie->is_hpa = false;
 		cdns_pcie->ops = &j721e_pcie_ops;
 		pcie->cdns_pcie = cdns_pcie;
 		break;
@@ -495,6 +505,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		cdns_pcie = &ep->pcie;
 		cdns_pcie->dev = dev;
+		cdns_pcie->is_rc = false;
+		cdns_pcie->is_hpa = false;
 		cdns_pcie->ops = &j721e_pcie_ops;
 		pcie->cdns_pcie = cdns_pcie;
 		break;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index f3f956fa116b..f4961c760434 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -192,7 +192,7 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	}
 
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
-	cdns_pcie_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size);
+	pcie->ops->set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size);
 
 	set_bit(r, &ep->ob_region_map);
 	ep->ob_addr[r] = addr;
@@ -214,7 +214,7 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	if (r == ep->max_regions - 1)
 		return;
 
-	cdns_pcie_reset_outbound_region(pcie, r);
+	pcie->ops->reset_outbound_region(pcie, r);
 
 	ep->ob_addr[r] = 0;
 	clear_bit(r, &ep->ob_region_map);
@@ -329,8 +329,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
 		     ep->irq_pci_fn != fn)) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region_for_normal_msg(pcie, 0, fn, 0,
-							     ep->irq_phys_addr);
+		pcie->ops->set_outbound_region_for_normal_msg(pcie, 0, fn, 0, ep->irq_phys_addr);
 		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
 		ep->irq_pci_fn = fn;
 	}
@@ -411,11 +410,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
 		     ep->irq_pci_fn != fn)) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
-					      false,
-					      ep->irq_phys_addr,
-					      pci_addr & ~pci_addr_mask,
-					      pci_addr_mask + 1);
+		pcie->ops->set_outbound_region(pcie, 0, fn, 0,
+					       false,
+					       ep->irq_phys_addr,
+					       pci_addr & ~pci_addr_mask,
+					       pci_addr_mask + 1);
 		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
 		ep->irq_pci_fn = fn;
 	}
@@ -514,11 +513,11 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 	if (ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||
 	    ep->irq_pci_fn != fn) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
-					      false,
-					      ep->irq_phys_addr,
-					      msg_addr & ~pci_addr_mask,
-					      pci_addr_mask + 1);
+		pcie->ops->set_outbound_region(pcie, 0, fn, 0,
+					       false,
+					       ep->irq_phys_addr,
+					       msg_addr & ~pci_addr_mask,
+					       pci_addr_mask + 1);
 		ep->irq_pci_addr = (msg_addr & ~pci_addr_mask);
 		ep->irq_pci_fn = fn;
 	}
@@ -869,7 +868,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	set_bit(0, &ep->ob_region_map);
 
 	if (ep->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
+		pcie->ops->detect_quiet_min_delay_set(&ep->pcie);
 
 	spin_lock_init(&ep->lock);
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index ce035eef0a5c..c191c887a93b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -60,10 +60,7 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 	/* Configuration Type 0 or Type 1 access. */
 	desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
 		CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
-	/*
-	 * The bus number was already set once for all in desc1 by
-	 * cdns_pcie_host_init_address_translation().
-	 */
+
 	if (busn == bridge->busnr + 1)
 		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
 	else
@@ -73,12 +70,77 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 	return rc->cfg_base + (where & 0xfff);
 }
 
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
+				   int where)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
+	struct cdns_pcie *pcie = &rc->pcie;
+	unsigned int busn = bus->number;
+	u32 addr0, desc0, desc1, ctrl0;
+	u32 regval;
+
+	if (pci_is_root_bus(bus)) {
+		/*
+		 * Only the root port (devfn == 0) is connected to this bus.
+		 * All other PCI devices are behind some bridge hence on another
+		 * bus.
+		 */
+		if (devfn)
+			return NULL;
+
+		return pcie->reg_base + (where & 0xfff);
+	}
+
+	/* Clear AXI link-down status */
+	regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
+			     (regval & ~GENMASK(0, 0)));
+
+	desc1 = 0;
+	ctrl0 = 0;
+
+	/* Update Output registers for AXI region 0. */
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
+
+	desc1 = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
+				    CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
+	desc1 &= ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
+	desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+	ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+		CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+
+	if (busn == bridge->busnr + 1)
+		desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
+	else
+		desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
+
+	return rc->cfg_base + (where & 0xfff);
+}
+
 static struct pci_ops cdns_pcie_host_ops = {
 	.map_bus	= cdns_pci_map_bus,
 	.read		= pci_generic_config_read,
 	.write		= pci_generic_config_write,
 };
 
+static struct pci_ops cdns_pcie_hpa_host_ops = {
+	.map_bus	= cdns_pci_hpa_map_bus,
+	.read           = pci_generic_config_read,
+	.write		= pci_generic_config_write,
+};
+
 static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
 {
 	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
@@ -154,8 +216,14 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
 {
 	u32 val;
 
-	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
+	if (!pcie->is_hpa) {
+		val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
+	} else {
+		val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL);
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL,
+				     val | CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN);
+	}
 }
 
 static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
@@ -340,7 +408,7 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 		 */
 		bar = cdns_pcie_host_find_min_bar(rc, size);
 		if (bar != RP_BAR_UNDEFINED) {
-			ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
+			ret = pcie->ops->host_bar_ib_config(rc, bar, cpu_addr,
 							   size, flags);
 			if (ret)
 				dev_err(dev, "IB BAR: %d config failed\n", bar);
@@ -366,8 +434,7 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 		}
 
 		winsize = bar_max_size[bar];
-		ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
-						   flags);
+		ret = pcie->ops->host_bar_ib_config(rc, bar, cpu_addr, winsize, flags);
 		if (ret) {
 			dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -408,7 +475,7 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
 	if (list_empty(&bridge->dma_ranges)) {
 		of_property_read_u32(np, "cdns,no-bar-match-nbits",
 				     &no_bar_nbits);
-		err = cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
+		err = pcie->ops->host_bar_ib_config(rc, RP_NO_BAR, 0x0,
 						   (u64)1 << no_bar_nbits, 0);
 		if (err)
 			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
@@ -467,17 +534,159 @@ int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 		u64 pci_addr = res->start - entry->offset;
 
 		if (resource_type(res) == IORESOURCE_IO)
-			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
-						      true,
-						      pci_pio_to_address(res->start),
-						      pci_addr,
-						      resource_size(res));
+			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
+						       true,
+						       pci_pio_to_address(res->start),
+						       pci_addr,
+						       resource_size(res));
+		else
+			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
+						       false,
+						       res->start,
+						       pci_addr,
+						       resource_size(res));
+
+		r++;
+	}
+
+	return cdns_pcie_host_map_dma_ranges(rc);
+}
+
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 value, ctrl;
+
+	/*
+	 * Set the root complex BAR configuration register:
+	 * - disable both BAR0 and BAR1.
+	 * - enable Prefetchable Memory Base and Limit registers in type 1
+	 *   config space (64 bits).
+	 * - enable IO Base and Limit registers in type 1 config
+	 *   space (32 bits).
+	 */
+
+	ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
+	value = CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS;
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
+			     CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	if (rc->vendor_id != 0xffff)
+		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
+
+	if (rc->device_id != 0xffff)
+		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
+
+	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
+	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
+	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
+
+	return 0;
+}
+
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 addr0, addr1, aperture, value;
+
+	if (!rc->avail_ib_bar[bar])
+		return -EBUSY;
+
+	rc->avail_ib_bar[bar] = false;
+
+	aperture = ilog2(size);
+	addr0 = CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
+			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
+			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar), addr1);
+
+	if (bar == RP_NO_BAR)
+		return 0;
+
+	value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_BAR_CFG);
+	value &= ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
+	if (size + cpu_addr >= SZ_4G) {
+		if (!(flags & IORESOURCE_PREFETCH))
+			value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
+		value |= HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
+	} else {
+		if (!(flags & IORESOURCE_PREFETCH))
+			value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
+		value |= HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
+	}
+
+	value |= HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
+	struct resource *cfg_res = rc->cfg_res;
+	struct resource_entry *entry;
+	u64 cpu_addr = cfg_res->start;
+	u32 addr0, addr1, desc1;
+	int r, busnr = 0;
+
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (entry)
+		busnr = entry->res->start;
+
+	/*
+	 * Reserve region 0 for PCI configure space accesses:
+	 * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated dynamically by
+	 * cdns_pci_map_bus(), other region registers are set here once for all.
+	 */
+	addr1 = 0;
+	desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), addr1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), addr1);
+
+	r = 1;
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		struct resource *res = entry->res;
+		u64 pci_addr = res->start - entry->offset;
+
+		if (resource_type(res) == IORESOURCE_IO)
+			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
+						       true,
+						       pci_pio_to_address(res->start),
+						       pci_addr,
+						       resource_size(res));
 		else
-			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
-						      false,
-						      res->start,
-						      pci_addr,
-						      resource_size(res));
+			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
+						       false,
+						       res->start,
+						       pci_addr,
+						       resource_size(res));
 
 		r++;
 	}
@@ -489,11 +698,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
 {
 	int err;
 
-	err = cdns_pcie_host_init_root_port(rc);
+	err = rc->pcie.ops->host_init_root_port(rc);
 	if (err)
 		return err;
 
-	return cdns_pcie_host_init_address_translation(rc);
+	return rc->pcie.ops->host_init_address_translation(rc);
 }
 
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
@@ -503,7 +712,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 	int ret;
 
 	if (rc->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
+		pcie->ops->detect_quiet_min_delay_set(&rc->pcie);
 
 	cdns_pcie_host_enable_ptm_response(pcie);
 
@@ -566,8 +775,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (ret)
 		return ret;
 
-	if (!bridge->ops)
-		bridge->ops = &cdns_pcie_host_ops;
+	if (!bridge->ops) {
+		if (pcie->is_hpa)
+			bridge->ops = &cdns_pcie_hpa_host_ops;
+		else
+			bridge->ops = &cdns_pcie_host_ops;
+	}
 
 	ret = pci_host_probe(bridge);
 	if (ret < 0)
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 93c21c899309..21ca3d1b07e2 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -30,7 +30,30 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
 }
 
 static const struct cdns_pcie_ops cdns_plat_ops = {
+	.link_up = cdns_pcie_linkup,
 	.cpu_addr_fixup = cdns_plat_cpu_addr_fixup,
+	.host_init_root_port = cdns_pcie_host_init_root_port,
+	.host_bar_ib_config = cdns_pcie_host_bar_ib_config,
+	.host_init_address_translation = cdns_pcie_host_init_address_translation,
+	.detect_quiet_min_delay_set = cdns_pcie_detect_quiet_min_delay_set,
+	.set_outbound_region = cdns_pcie_set_outbound_region,
+	.set_outbound_region_for_normal_msg =
+					    cdns_pcie_set_outbound_region_for_normal_msg,
+	.reset_outbound_region = cdns_pcie_reset_outbound_region,
+};
+
+static const struct cdns_pcie_ops cdns_hpa_plat_ops = {
+	.start_link = cdns_pcie_hpa_start_link,
+	.stop_link = cdns_pcie_hpa_stop_link,
+	.link_up = cdns_pcie_hpa_linkup,
+	.host_init_root_port = cdns_pcie_hpa_host_init_root_port,
+	.host_bar_ib_config = cdns_pcie_hpa_host_bar_ib_config,
+	.host_init_address_translation = cdns_pcie_hpa_host_init_address_translation,
+	.detect_quiet_min_delay_set = cdns_pcie_hpa_detect_quiet_min_delay_set,
+	.set_outbound_region = cdns_pcie_hpa_set_outbound_region,
+	.set_outbound_region_for_normal_msg =
+					    cdns_pcie_hpa_set_outbound_region_for_normal_msg,
+	.reset_outbound_region = cdns_pcie_hpa_reset_outbound_region,
 };
 
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
@@ -67,7 +90,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
-		rc->pcie.ops = &cdns_plat_ops;
+		rc->pcie.ops = data->is_hpa ? &cdns_hpa_plat_ops : &cdns_plat_ops;
 		rc->pcie.is_hpa = data->is_hpa;
 		rc->pcie.is_rc = data->is_rc;
 
@@ -100,7 +123,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 			return -ENOMEM;
 
 		ep->pcie.dev = dev;
-		ep->pcie.ops = &cdns_plat_ops;
+		ep->pcie.ops = data->is_hpa ? &cdns_hpa_plat_ops : &cdns_plat_ops;
 		ep->pcie.is_hpa = data->is_hpa;
 		ep->pcie.is_rc = data->is_rc;
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..a7ec0b96c19f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -8,6 +8,45 @@
 
 #include "pcie-cadence.h"
 
+bool cdns_pcie_linkup(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
+	if (pl_reg_val & GENMASK(0, 0))
+		return true;
+	return false;
+}
+
+bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
+	if (pl_reg_val & GENMASK(0, 0))
+		return true;
+	return false;
+}
+
+int cdns_pcie_hpa_start_link(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0);
+	pl_reg_val |= CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0, pl_reg_val);
+	return 0;
+}
+
+void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0);
+	pl_reg_val &= ~CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0, pl_reg_val);
+}
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay = 0x3;
@@ -55,7 +94,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 	desc1 = 0;
 
 	/*
-	 * Whatever Bit [23] is set or not inside DESC0 register of the outbound
+	 * Whether Bit [23] is set or not inside DESC0 register of the outbound
 	 * PCIe descriptor, the PCI function number must be set into
 	 * Bits [26:24] of DESC0 anyway.
 	 *
@@ -147,6 +186,162 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
 }
 
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
+{
+	u32 delay = 0x3;
+	u32 ltssm_control_cap;
+
+	/* Set the LTSSM Detect Quiet state min. delay to 2ms. */
+	ltssm_control_cap = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
+						CDNS_PCIE_HPA_PHY_LAYER_CFG0);
+	ltssm_control_cap = ((ltssm_control_cap &
+			    ~CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
+			     CDNS_PCIE_HPA_PHY_LAYER_CFG0, ltssm_control_cap);
+}
+
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn, u32 r,
+				       bool is_io, u64 cpu_addr, u64 pci_addr, size_t size)
+{
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values.
+	 */
+	u64 sz = 1ULL << fls64(size - 1);
+	int nbits = ilog2(sz);
+	u32 addr0, addr1, desc0, desc1, ctrl0;
+
+	if (nbits < 8)
+		nbits = 8;
+
+	/* Set the PCI address */
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
+		(lower_32_bits(pci_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(pci_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), addr1);
+
+	/* Set the PCIe header descriptor */
+	if (is_io)
+		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO;
+	else
+		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM;
+	desc1 = 0;
+	ctrl0 = 0;
+
+	/*
+	 * Whether Bit [26] is set or not inside DESC0 register of the outbound
+	 * PCIe descriptor, the PCI function number must be set into
+	 * Bits [31:24] of DESC1 anyway.
+	 *
+	 * In Root Complex mode, the function number is always 0 but in Endpoint
+	 * mode, the PCIe controller may support more than one function. This
+	 * function number needs to be set properly into the outbound PCIe
+	 * descriptor.
+	 *
+	 * Besides, setting Bit [26] is mandatory when in Root Complex mode:
+	 * then the driver must provide the bus, resp. device, number in
+	 * Bits [31:24] of DESC1, resp. Bits[23:16] of DESC0. Like the function
+	 * number, the device number is always 0 in Root Complex mode.
+	 *
+	 * However when in Endpoint mode, we can clear Bit [26] of DESC0, hence
+	 * the PCIe controller will use the captured values for the bus and
+	 * device numbers.
+	 */
+	if (pcie->is_rc) {
+		/* The device and function numbers are always 0. */
+		desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		/*
+		 * Use captured values for bus and device numbers but still
+		 * need to set the function number.
+		 */
+		desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
+}
+
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
+						      u8 busnr, u8 fn,
+						      u32 r, u64 cpu_addr)
+{
+	u32 addr0, addr1, desc0, desc1, ctrl0;
+
+	desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
+	desc1 = 0;
+	ctrl0 = 0;
+
+	/* See cdns_pcie_set_outbound_region() comments above. */
+	if (pcie->is_rc) {
+		desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+
+	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
+}
+
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
+{
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), 0);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), 0);
+}
+
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 {
 	int i = pcie->phy_count;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 72cb27c6f9e4..39f6a12aef8d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -878,6 +878,10 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 }
 #endif
 
+bool cdns_pcie_linkup(struct cdns_pcie *pcie);
+bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie);
+int cdns_pcie_hpa_start_link(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie);
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
@@ -889,7 +893,12 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
-
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn, u32 r,
+				       bool is_io, u64 cpu_addr, u64 pci_addr, size_t size);
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
+						      u8 busnr, u8 fn, u32 r, u64 cpu_addr);
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.47.1


