Return-Path: <linux-pci+bounces-26629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F763A99DAD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C844D3B94D8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09C148FE6;
	Thu, 24 Apr 2025 01:04:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023137.outbound.protection.outlook.com [40.107.44.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFF22615;
	Thu, 24 Apr 2025 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456697; cv=fail; b=O/rD2gByAP1V1eDZ7U7tVZ+T1avVZy4WUuvw59b4VoMEA6JFds2crdt36NlN9Ws4CK+59acpr2a7xVAFVaazvhXNuolZwNWW2Clzn13AJF2NdHATvtPcxKLdVK8NoLHi8d0eK/vlCFA0sVccFReR3ijSFdJjBt04uaP//lj59tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456697; c=relaxed/simple;
	bh=bVoWCVEVwQCkUL9iDbxMWz9kBNYqOh862j8hYdke/9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVTAJmNqXHD+zVac8e1XhGxhVe+HW3y7d2gRXt4b7HARyG8zN2JWXxa5JRrPez/XP8U1Fa+fyQ7zdyDr0oVcQviwBQh9HqFj1zUaDATSxJHwiVsz4X7YPDgn3igjON0rn1+0ZGB7Xr5oM0k0TENqP6uSVQteo3cRIvfA/k2c9zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDMOhqu//z9uf/xOH461M646EKuh8E1E/jYfbbyXbAC1lE7CgV/b7MmZivcB1LCJ94mE/n6uPCw61dnCiPVpC135usf4G2wl2oC68KZRy1YkpD8TjTzzLYfwJr1AobVEIBz/GCnz0N1wfG/G3LvB5n7feUUWniLnlNIy0cSIEzCl9lTqgxI7plFoi3KJvH8Wd5RJABkxPXp4TSE+LAM1nep2LBKl7curoaFehuCaU+zul4DHOD06Q6cvFQqz58Ei+LI9I0OHeq5lN/cgVgaSwuEkip64abIrbh4Umb3wOKsScyRdnuCWdPeIGblKSIgH4AqoNgrIG+8yeoko4hqgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfRRrYvwVlOXMZ8TB64tW8b2ZV4+NOuG+xo0KkFPK0k=;
 b=FGzYx5X84se8dszfEpu4druYmCDkuNMQ7N7UGocwdAtvo8dbRWVAJvJxusOjb1lIpLreBARwHOqyk/VFNdXcGbT0W0XhbBIxL/ylENdOm+IPjskAumcoWFlJ7N8GZM6ah2PMfVab3h0qPXYkPGgmVJdEfl61N1HOBMNMtnWYu0608IAfMzq+uAbIs9JT+qj3/Vvx1kg0gwZnCsFwvtDjJRatYoO4zbyLnAjHh6DJX4leWYjY+QIMsr7PSERqoPvrDrwC7oBgR6nG16GWCrxhkdby7AXp25diSg3VFj4qTY8NSmaevPVLR0bPqs6Mse8ve9RalxQcIoa/6AdykWP3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0038.apcprd02.prod.outlook.com (2603:1096:4:196::22)
 by SEYPR06MB6539.apcprd06.prod.outlook.com (2603:1096:101:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 01:04:50 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:4:196:cafe::a0) by SI2PR02CA0038.outlook.office365.com
 (2603:1096:4:196::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 01:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 01:04:47 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BE8E94160510;
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
Subject: [PATCH v4 3/5] PCI: cadence: Add header support for PCIe HPA controller
Date: Thu, 24 Apr 2025 09:04:42 +0800
Message-ID: <20250424010445.2260090-4-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|SEYPR06MB6539:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 38005c7f-d883-481d-3de9-08dd82cc0247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ggQobnMevr5a4q4bAlbN6d1wkZiFTciHBgCTx7U0OKjc0+EmYyJRO6oGg0cY?=
 =?us-ascii?Q?bo5grfrVmn23WJVc15atxhYSPiRmFOj7KsLHDfOkHNcAeYjOwmrCLRCvbMPT?=
 =?us-ascii?Q?KhkkXiFZ8BigT1ePwmF6g1kX5cNxA0JmucHdAw27KQwiYwTGDFsxV1GRx6Lj?=
 =?us-ascii?Q?UZsgYoa2EYAWGnSe0mY/Kf6GaFCl5P+HNdU5Qb9G1bzgBFLbRENKHBErfb/V?=
 =?us-ascii?Q?ZeIJydAIBvI37roRdmUEi09Vo0biNnrfr611JLobsI4twY5WqpM06QT7mtBz?=
 =?us-ascii?Q?73t+YrXUjRRqXr+w9SnDJ+8rtJUhPjyc89ECivgA8ykBdrd0BesC3g/Ha+FQ?=
 =?us-ascii?Q?UCjqL41MkZ+u/Wizb71JJh9UEA4j8ocuMO+B4vmreRCqDUStCl3eCVSMtwLO?=
 =?us-ascii?Q?3TUiH8xsCxWSSrVSKXxzSK7NmaCZEZe6eegvC1fSBCwMX0DHZnBJoJwj0KJC?=
 =?us-ascii?Q?7PAfCqOWzDj6Pd5EyvpS0G4G8hEb1UVVjFAfiTr3cANSKgo/HzR4mVeDfn2+?=
 =?us-ascii?Q?p2vHOO8faaahEFDtHvPEb9xOYLaR38rhJ0hG3rZdlONC+QK32LGCEcscuvYb?=
 =?us-ascii?Q?ZIt5U/g1epxG3mgVjuc4RRHY05nSxAigOXVo0e6yoDWaKaurysfkP3l4JuZo?=
 =?us-ascii?Q?ov0exWGzEay5b3q5+xzvx8SSq/lpeOaZdX/ntbNw99iJotwYUsqxtO9/Zbjk?=
 =?us-ascii?Q?MkBPJQEKyGQ9hMOnk9BrXBUYgL0iWyh8ATxqs4J/WT/TWKL7X/A6SrJx2lmi?=
 =?us-ascii?Q?FRnPPKVQNqqUKAkelxko7SX81tuBAWanOiOVPXwaRpgyUWmb6bFLd0W21U9e?=
 =?us-ascii?Q?AVtXCW/39o4u0NFv1VArnC/x3d93xb5yeKvM0e8xU/QPvTr2Wc2gh3jt/pzg?=
 =?us-ascii?Q?DzMEZbxb8pxYDuhXKkn6zQwl1fDCretQaH4I6fQod85lfSWCaDtR5PZraSRe?=
 =?us-ascii?Q?qljP/ROIeJbUJqKWol0gY5I0fBXESZFyZly2kBUbA40esfko4Ehosy9cAh8E?=
 =?us-ascii?Q?ayMJo/Dv6qTiGqegIaQjxAeN+Iq5d+zWr4Ra3Xja9PFE8ef6qc9zFtSAt1Ho?=
 =?us-ascii?Q?9lWLXMXG6jANjgcsaR5tBo2G8oDX2sjg1/HgnObmsU3NmVIAAKgKIAMSXzY8?=
 =?us-ascii?Q?iyhCWDbeIn8KxKf68vuU2/wbGC+iM0fciXygpwSrlYmNz1DsEpojH3Zsc8y2?=
 =?us-ascii?Q?iENDJUGVN2j91zhIpUajvu0MoUkTEkaTPXDuI1hPkEb0FHSerHMDZf08n5kD?=
 =?us-ascii?Q?VN8ZuTsowBjs6NQqhChYT0YwateWXU+F7+qv/CkaBNG/sCGHzMK5mLYSqo/d?=
 =?us-ascii?Q?cd//rAD4hn+u7Ftijn53kw/BFCaszQ181FK2DMn5pD9Wenw+8OvWHG9zRpEj?=
 =?us-ascii?Q?Kg/82jZyQ96vbdO2Gg/EI++hu2bjtIODIW/CpYkVCY+wkt7tw1hORtZgpywS?=
 =?us-ascii?Q?b5Ka7H75yV2M39F1YbR4X83xoDnozV2/D0BkXCTuTolp2J0X3UpJQxgm9fhN?=
 =?us-ascii?Q?FmStErR8RktQ8H7XCt3Hd+sR1F5U/8/ICdFk?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:04:47.7453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38005c7f-d883-481d-3de9-08dd82cc0247
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6539

From: Manikandan K Pillai <mpillai@cadence.com>

Add the required definitions for register addresses and register bits
for the Cadence PCIe HPA controllers. Add the register bank offsets
for different platform architecture and update the global platform
data - platform architecture, EP or RP configuration and the correct
values of register offsets for different register banks during the
platform probe.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../controller/cadence/pcie-cadence-host.c    |  13 +-
 .../controller/cadence/pcie-cadence-plat.c    |  46 ++-
 drivers/pci/controller/cadence/pcie-cadence.h | 331 +++++++++++++++++-
 3 files changed, 373 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..ce035eef0a5c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -175,7 +175,7 @@ static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
 	return ret;
 }
 
-static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
+int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
 	u32 value, ctrl;
@@ -215,10 +215,10 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
-static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
-					enum cdns_pcie_rp_bar bar,
-					u64 cpu_addr, u64 size,
-					unsigned long flags)
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr, u64 size,
+				 unsigned long flags)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
 	u32 addr0, addr1, aperture, value;
@@ -428,7 +428,7 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
-static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
+int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
@@ -536,7 +536,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		return -ENOMEM;
 
 	pcie = &rc->pcie;
-	pcie->is_rc = true;
 
 	rc->vendor_id = 0xffff;
 	of_property_read_u32(np, "vendor-id", &rc->vendor_id);
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..93c21c899309 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -22,10 +22,6 @@ struct cdns_plat_pcie {
 	struct cdns_pcie        *pcie;
 };
 
-struct cdns_plat_pcie_of_data {
-	bool is_rc;
-};
-
 static const struct of_device_id cdns_plat_pcie_of_match[];
 
 static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
@@ -72,6 +68,12 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
+		rc->pcie.is_hpa = data->is_hpa;
+		rc->pcie.is_rc = data->is_rc;
+
+		/* Store the register bank offsets pointer */
+		rc->pcie.cdns_pcie_reg_offsets = data;
+
 		cdns_plat_pcie->pcie = &rc->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -99,6 +101,12 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
+		ep->pcie.is_hpa = data->is_hpa;
+		ep->pcie.is_rc = data->is_rc;
+
+		/* Store the register bank offsets pointer */
+		ep->pcie.cdns_pcie_reg_offsets = data;
+
 		cdns_plat_pcie->pcie = &ep->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -150,10 +158,32 @@ static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
 
 static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data = {
 	.is_rc = true,
+	.is_hpa = false,
 };
 
 static const struct cdns_plat_pcie_of_data cdns_plat_pcie_ep_of_data = {
 	.is_rc = false,
+	.is_hpa = false,
+};
+
+static const struct cdns_plat_pcie_of_data cdns_plat_pcie_hpa_host_of_data = {
+	.is_rc = true,
+	.is_hpa = true,
+	.ip_reg_bank_off = CDNS_PCIE_HPA_IP_REG_BANK,
+	.ip_cfg_ctrl_reg_off = CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK,
+	.axi_mstr_common_off = CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON,
+	.axi_slave_off = CDNS_PCIE_HPA_AXI_SLAVE,
+	.axi_master_off = CDNS_PCIE_HPA_AXI_MASTER,
+};
+
+static const struct cdns_plat_pcie_of_data cdns_plat_pcie_hpa_ep_of_data = {
+	.is_rc = false,
+	.is_hpa = true,
+	.ip_reg_bank_off = CDNS_PCIE_HPA_IP_REG_BANK,
+	.ip_cfg_ctrl_reg_off = CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK,
+	.axi_mstr_common_off = CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON,
+	.axi_slave_off = CDNS_PCIE_HPA_AXI_SLAVE,
+	.axi_master_off = CDNS_PCIE_HPA_AXI_MASTER,
 };
 
 static const struct of_device_id cdns_plat_pcie_of_match[] = {
@@ -165,6 +195,14 @@ static const struct of_device_id cdns_plat_pcie_of_match[] = {
 		.compatible = "cdns,cdns-pcie-ep",
 		.data = &cdns_plat_pcie_ep_of_data,
 	},
+	{
+		.compatible = "cdns,cdns-pcie-hpa-host",
+		.data = &cdns_plat_pcie_hpa_host_of_data,
+	},
+	{
+		.compatible = "cdns,cdns-pcie-hpa-ep",
+		.data = &cdns_plat_pcie_hpa_ep_of_data,
+	},
 	{},
 };
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 39ee9945c903..72cb27c6f9e4 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -6,6 +6,7 @@
 #ifndef _PCIE_CADENCE_H
 #define _PCIE_CADENCE_H
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-epf.h>
@@ -218,6 +219,173 @@
 	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
 	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
 
+/* HPA (High Performance Architecture) PCIe controller register */
+#define CDNS_PCIE_HPA_IP_REG_BANK		0x01000000
+#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK	0x01003c00
+#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON	0x01020000
+
+/* Address Translation Registers (HPA) */
+#define CDNS_PCIE_HPA_AXI_SLAVE                 0x03000000
+#define CDNS_PCIE_HPA_AXI_MASTER                0x03002000
+
+/* Root port register base address */
+#define CDNS_PCIE_HPA_RP_BASE			0x0
+
+#define CDNS_PCIE_HPA_LM_ID			0x1420
+
+/* Endpoint Function BARs (HPA) Configuration Registers */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) + 0x04)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) + 0x08)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) + 0x0c)
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
+	(GENMASK(9, 4) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b)))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
+	(GENMASK(3, 0) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 10)) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
+
+/* Endpoint Function Configuration Register */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		0x02c0
+
+/* Root Complex BAR Configuration Register */
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG                        0x14
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK     GENMASK(9, 4)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK         GENMASK(3, 0)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK     GENMASK(19, 14)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK         GENMASK(13, 10)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
+
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE BIT(20)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS BIT(21)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE           BIT(22)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS           BIT(23)
+
+/* BAR control values applicable to both Endpoint Function and Root Complex */
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED              0x0
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS             0x3
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS            0x1
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS   0x9
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS            0x5
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS   0xd
+
+#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
+		(((aperture) - 7) << ((bar) * 10))
+
+#define CDNS_PCIE_HPA_LM_PTM_CTRL		0x0520
+#define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN	BIT(17)
+
+/* Root Port Registers PCI config space (HPA) for root port function */
+#define CDNS_PCIE_HPA_RP_CAP_OFFSET	0xc0
+
+/* Region r Outbound AXI to PCIe Address Translation Register 0 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r)            (0x1010 + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, ((nbits) - 1))
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK      GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
+
+/* Region r Outbound AXI to PCIe Address Translation Register 1 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r)            (0x1014 + ((r) & 0x1f) * 0x0080)
+
+/* Region r Outbound PCIe Descriptor Register 0 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r)                (0x1008 + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK         GENMASK(28, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
+
+/* Region r Outbound PCIe Descriptor Register 1 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r)        (0x100c + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK  GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
+
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r)         (0x1018 + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
+
+/* Region r AXI Region Base Address Register 0 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r)     (0x1000 + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) - 1))
+
+/* Region r AXI Region Base Address Register 1 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r)     (0x1004 + ((r) & 0x1f) * 0x0080)
+
+/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar)              (((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK        GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar)              (0x04 + ((bar) * 0x0008))
+
+/* AXI link down register */
+#define CDNS_PCIE_HPA_AT_LINKDOWN 0x04
+
+/*
+ * Physical Layer Configuration Register 0
+ * This register contains the parameters required for functional setup
+ * of Physical Layer.
+ */
+#define CDNS_PCIE_HPA_PHY_LAYER_CFG0               0x0400
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
+	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
+#define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK  GENMASK(27, 27)
+
+#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0             0x0420
+
+#define CDNS_PCIE_HPA_RP_MAX_IB     0x3
+#define CDNS_PCIE_HPA_MAX_OB        15
+
+/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register (HPA) */
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) (((fn) * 0x0040) + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) (0x4 + ((fn) * 0x0040) + ((bar) * 0x0008))
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
 	RP_BAR0,
@@ -249,6 +417,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_MSG_DATA			BIT(16)
 
 struct cdns_pcie;
+struct cdns_pcie_rc;
 
 enum cdns_pcie_msg_code {
 	MSG_CODE_ASSERT_INTA	= 0x20,
@@ -281,11 +450,64 @@ enum cdns_pcie_msg_routing {
 	MSG_ROUTING_GATHER,
 };
 
+enum cdns_pcie_reg_bank {
+	REG_BANK_RP,
+	REG_BANK_IP_REG,
+	REG_BANK_IP_CFG_CTRL_REG,
+	REG_BANK_AXI_MASTER_COMMON,
+	REG_BANK_AXI_MASTER,
+	REG_BANK_AXI_SLAVE,
+	REG_BANK_AXI_HLS,
+	REG_BANK_AXI_RAS,
+	REG_BANK_AXI_DTI,
+	REG_BANKS_MAX,
+};
+
 struct cdns_pcie_ops {
 	int	(*start_link)(struct cdns_pcie *pcie);
 	void	(*stop_link)(struct cdns_pcie *pcie);
 	bool	(*link_up)(struct cdns_pcie *pcie);
 	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
+	int	(*host_init_root_port)(struct cdns_pcie_rc *rc);
+	int	(*host_bar_ib_config)(struct cdns_pcie_rc *rc,
+				      enum cdns_pcie_rp_bar bar,
+				      u64 cpu_addr, u64 size,
+				      unsigned long flags);
+	int	(*host_init_address_translation)(struct cdns_pcie_rc *rc);
+	void	(*detect_quiet_min_delay_set)(struct cdns_pcie *pcie);
+	void	(*set_outbound_region)(struct cdns_pcie *pcie, u8 busnr, u8 fn,
+				       u32 r, bool is_io, u64 cpu_addr,
+				       u64 pci_addr, size_t size);
+	void	(*set_outbound_region_for_normal_msg)(struct cdns_pcie *pcie,
+						      u8 busnr, u8 fn, u32 r,
+						      u64 cpu_addr);
+	void	(*reset_outbound_region)(struct cdns_pcie *pcie, u32 r);
+};
+
+/**
+ * struct cdns_plat_pcie_of_data - Register bank offset for a platform
+ * @is_rc: controller is a RC
+ * @is_hpa: Controller architecture is HPA
+ * @ip_reg_bank_off: ip register bank start offset
+ * @ip_cfg_ctrl_reg_off: ip config control register start offset
+ * @axi_mstr_common_off: AXI master common register start
+ * @axi_slave_off: AXI slave offset start
+ * @axi_master_off: AXI master offset start
+ * @axi_hls_off: AXI HLS offset start
+ * @axi_ras_off: AXI RAS offset
+ * @axi_dti_off: AXI DTI offset
+ */
+struct cdns_plat_pcie_of_data {
+	u32 is_rc:1;
+	u32 is_hpa:1;
+	u32 ip_reg_bank_off;
+	u32 ip_cfg_ctrl_reg_off;
+	u32 axi_mstr_common_off;
+	u32 axi_slave_off;
+	u32 axi_master_off;
+	u32 axi_hls_off;
+	u32 axi_ras_off;
+	u32 axi_dti_off;
 };
 
 /**
@@ -294,21 +516,25 @@ struct cdns_pcie_ops {
  * @mem_res: start/end offsets in the physical system memory to map PCI accesses
  * @dev: PCIe controller
  * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
+ * @is_hpa: indicates if the architecture is HPA
  * @phy_count: number of supported PHY devices
  * @phy: list of pointers to specific PHY control blocks
  * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
+ * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
  */
 struct cdns_pcie {
 	void __iomem		*reg_base;
 	struct resource		*mem_res;
 	struct device		*dev;
 	bool			is_rc;
+	bool			is_hpa;
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
 	const struct cdns_pcie_ops *ops;
+	const struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 };
 
 /**
@@ -386,6 +612,40 @@ struct cdns_pcie_ep {
 	unsigned int		quirk_disable_flr:1;
 };
 
+static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_reg_bank bank)
+{
+	u32 offset = 0x0;
+
+	switch (bank) {
+	case REG_BANK_IP_REG:
+		offset = pcie->cdns_pcie_reg_offsets->ip_reg_bank_off;
+		break;
+	case REG_BANK_IP_CFG_CTRL_REG:
+		offset = pcie->cdns_pcie_reg_offsets->ip_cfg_ctrl_reg_off;
+		break;
+	case REG_BANK_AXI_MASTER_COMMON:
+		offset = pcie->cdns_pcie_reg_offsets->axi_mstr_common_off;
+		break;
+	case REG_BANK_AXI_MASTER:
+		offset = pcie->cdns_pcie_reg_offsets->axi_master_off;
+		break;
+	case REG_BANK_AXI_SLAVE:
+		offset = pcie->cdns_pcie_reg_offsets->axi_slave_off;
+		break;
+	case REG_BANK_AXI_HLS:
+		offset = pcie->cdns_pcie_reg_offsets->axi_hls_off;
+		break;
+	case REG_BANK_AXI_RAS:
+		offset = pcie->cdns_pcie_reg_offsets->axi_ras_off;
+		break;
+	case REG_BANK_AXI_DTI:
+		offset = pcie->cdns_pcie_reg_offsets->axi_dti_off;
+		break;
+	default:
+		break;
+	};
+	return offset;
+}
 
 /* Register access */
 static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
@@ -398,6 +658,27 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
 	return readl(pcie->reg_base + reg);
 }
 
+static inline void cdns_pcie_hpa_writel(struct cdns_pcie *pcie,
+					enum cdns_pcie_reg_bank bank,
+					u32 reg,
+					u32 value)
+{
+	u32 offset =  cdns_reg_bank_to_off(pcie, bank);
+
+	reg += offset;
+	writel(value, pcie->reg_base + reg);
+}
+
+static inline u32 cdns_pcie_hpa_readl(struct cdns_pcie *pcie,
+				      enum cdns_pcie_reg_bank bank,
+				      u32 reg)
+{
+	u32 offset =  cdns_reg_bank_to_off(pcie, bank);
+
+	reg += offset;
+	return readl(pcie->reg_base + reg);
+}
+
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
@@ -444,6 +725,9 @@ static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
 {
 	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
 
+	if (pcie->is_hpa)
+		addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
 	cdns_pcie_write_sz(addr, 0x1, value);
 }
 
@@ -452,6 +736,9 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 {
 	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
 
+	if (pcie->is_hpa)
+		addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
 	cdns_pcie_write_sz(addr, 0x2, value);
 }
 
@@ -459,6 +746,9 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
 {
 	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
 
+	if (pcie->is_hpa)
+		addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
 	return cdns_pcie_read_sz(addr, 0x2);
 }
 
@@ -525,27 +815,58 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
+int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc);
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr, u64 size,
+				 unsigned long flags);
+int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc);
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn, int where);
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc);
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags);
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc);
+int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc);
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
 	return 0;
 }
-
 static inline int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
 {
 	return 0;
 }
-
 static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	return 0;
 }
-
 static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 					     int where)
 {
 	return NULL;
 }
+static inline void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn
+						 int where)
+{
+	return NULL;
+}
+static inline int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+static inline int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+						   enum cdns_pcie_rp_bar bar,
+						   u64 cpu_addr, u64 size,
+						   unsigned long flags)
+{
+	return 0;
+}
+static inline int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCIE_CADENCE_EP
@@ -558,19 +879,17 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 #endif
 
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
-
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size);
-
 void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 						  u8 busnr, u8 fn,
 						  u32 r, u64 cpu_addr);
-
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.47.1


