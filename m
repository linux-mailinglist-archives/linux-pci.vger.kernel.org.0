Return-Path: <linux-pci+bounces-25665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D7A85A35
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78881BA5C63
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F38238C18;
	Fri, 11 Apr 2025 10:37:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2102.outbound.protection.outlook.com [40.107.215.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7F1E8356;
	Fri, 11 Apr 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367830; cv=fail; b=Tc1x6vf8gLVEh57/1rZqHN9Vmr2ZjY76KmQ2o/Kz1s9mT0ZrOQRF1ot0OT90yTfN8oZFptfr7VctbfiTGEgqemv40gRpAAnV2FubaNyaxK4qOPixSleI/T71aBPujhshO9bWn+TdsVnLP6icQThli8/vueXka8OMEaIFsUeB7lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367830; c=relaxed/simple;
	bh=eDYm0vQfscaTszrmT1L2rwls4lKycy6wmtg+ZMziMMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSLMmARTx+i2v6HnGZJvZsWdZR/I7LsOF6XzNKFZJ1I7xDhwpV94Mf9u9am2FhjGGDBksAakmAk5cmD45gfYLysqiP8Xp15VZF0n0UA53rQgo4op/bKOeqET09vyiaxl/45XwyQrNXbdfJmGlWwWa8WMFD2lyS/msvziEdJNSm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFrt/+Dsv05rkb+BhpikcPgH0mBWLwMTg7FOgX2HxvuXEix+zHv7wDwpstGOF/CYYboq9siwrQJ6A1IgjxNaOcA6Gtp7z/fCXkNKAZW7cObgoUOkm4shwVAp9bwfu6DJgsLNTtI1prCFw6hVXkTjHiWPkRr0PDgplxc8e83T77FXGplRZhNp7jKbNR5C0T6GqybJ+eQVGEQJrKfaOuHZTW6U2McQtrioKG6mUTpUMyQEsn3LjoORmeXskd/K1X6BYWL3G7GugGNBl5cfvrs2GgoPqv/Y0Da/kopYLx2vcHEzUDEHdquAbwQ39lXNkpozNjHyuirCHtDA7gwXT+F0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYy9y/HiIAQZ5HCmUE5jeNbHow/RCSnS/c+4tHh7vVw=;
 b=Aup3Gsq9S1EGkwBDNgFCn/Pf0jyeuQtqn4EZGhHKsYVhcfK6bGztbuRsYlV0fy5Zgjfn7S9/FNHTROve+zz+mcLt+JTq/2WXyPnmiSCjzUCvzCSdWVlslgbywRb6OCzNRfDyQIJAGM6j3pQ/2yMlHDZF1rxGSpmEUn9HKFMv9pwPwYtnj6zlIAdmK9JeWRmQM2wNAOY8ovtVS2LrfYoq746voWRPP/cu2Taxjn8rv20nB8F46mcv46oUTw6NNOnipa3s1A76IcAeNdyKZITiOZGMccDBQXeF1/SUu2TsacDJv4G7kfKum6Zvj69mAjyF9xoKF2FN0iDxF0fJfZCZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::33) by SE1PPF54561D20A.apcprd06.prod.outlook.com
 (2603:1096:108:1::416) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 10:37:01 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::bb) by PS2PR01CA0045.outlook.office365.com
 (2603:1096:300:58::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 10:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 10:36:59 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5D1194160CA4;
	Fri, 11 Apr 2025 18:36:58 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v3 3/6] PCI: cadence: Add header support for PCIe HPA controller
Date: Fri, 11 Apr 2025 18:36:53 +0800
Message-ID: <20250411103656.2740517-4-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411103656.2740517-1-hans.zhang@cixtech.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|SE1PPF54561D20A:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a7ab50c-e452-4e1b-0614-08dd78e4ca2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnrhDV64UTyI1dgkjooQcrLJXWCZJsCM1LTtVBQwKykc81tEeUGG54Sm5NSF?=
 =?us-ascii?Q?mRergCmmOpQrGygDc/V603/E/sdIa5l7fvg5AYsUfdivQvIRmoRcZL3pelr1?=
 =?us-ascii?Q?GcLF/+alDOylBAe7UZ0nv+QWJzGhwRu9Ssa6MmVMTwqLYwNbTauwem1gIrne?=
 =?us-ascii?Q?rhq5K4Qs0Lfvch2PO5E74ziXHZEPKgsSSGzCd/4HfCFpswLLaEYmZeK/onNr?=
 =?us-ascii?Q?/vKzPJGwiBekU7+nN1gNgtclC6ktAFIb03bZr63TACM9c/Ve8pafezlZilO2?=
 =?us-ascii?Q?GlMsPMuD2Ty+9zKuZq9LgpWxZ8mv0Ig15olyXimwYGy7IfnqRsfCTA7nNNQn?=
 =?us-ascii?Q?lwJ8dyjPSRiHeNofN2yBIFO32MY5p2eR6Tm6hvIdVEPDtSm4UiLLOPODRTSm?=
 =?us-ascii?Q?PZBrF28jT6CCBmtY/XKT5V0liml2kVt0J6CgJmlFcS93pZlSNTRIJKpGPqBU?=
 =?us-ascii?Q?N/9Oj+92TLO2IyvlMnVaTjD2RUab1fShcst7cMgb0Ao0Ujjra5jseKQsVJt8?=
 =?us-ascii?Q?mley0j1efdZkR6/hgKc/07MVzZwIHURVbdzsdCEtLC5Yfwv7yh0x2OTGnLmx?=
 =?us-ascii?Q?iQ5GxJlfmAoOiNxSMdVg8JzYSdljds2uofJJ4YkzR4iwvglSQB5BmAFKnWU8?=
 =?us-ascii?Q?Z+ENhdlisgOuHMI8T4406GGO0+r8F1b/1seuvo1Pi+gudiAWudNPq8eGojLD?=
 =?us-ascii?Q?5ND1T9u6Q3Kpqmr3J0pDPyKDDByJUAWzZfJ48kzFeOC2OcqAYSTK4Yubd0jI?=
 =?us-ascii?Q?adV7BpFAXcssd2fkiKCm929E13wGTNkPe+nqsrrHEzDrJ4tUEQGE6TDD+3Oy?=
 =?us-ascii?Q?uLlzl6k7DR9Q7L2VDY/jLPQSPW6nxtgqwEZeevmxQWbKT8X0oIswOh4i5l5Q?=
 =?us-ascii?Q?tv3+XoZUZwzbzGzLMMaMYr7WI7bLn7X8Xq/RWsFwinAQmWaQ/XU4jFjYkTu2?=
 =?us-ascii?Q?MEuihwUso7zVNGZwOp+igncwOFV25r1eE9RdxnqpP6XOTqrjmxQLcmUdFkCH?=
 =?us-ascii?Q?51CYgUK0XILlMsht4P1p4/DyKrByP/FGnq8OSCMvsMHWCgg4VybKsgTmHsDI?=
 =?us-ascii?Q?ZhR+MAnQSFKjaRAj4dOO1iVvUa04aa2tr9M9Ndt9w0XyHYg5x3msnOtT9Sf7?=
 =?us-ascii?Q?lFqH7G6xZXsR1Rr9s6lDqLif8ShHNj0rPMJyLYFSj/K9lpmV0NXIEfipH+Sn?=
 =?us-ascii?Q?aPHaOkJaTS4Lyh793vopZ4l2Nvj+ID6Tabi6jK7VLEpI0Ow2CRSuiRhfQri1?=
 =?us-ascii?Q?WG6UVxrNFH+BSWIcSI5yjfl+PMX+NMVUJK1rFVVNmVvsVCh2oUzl2O6dYgZz?=
 =?us-ascii?Q?qzO4hI2SKm5Diz2hEWAzwhycE8Mhc0B2NAME+rLCors21u3XQeLKYcry+Z19?=
 =?us-ascii?Q?c2FGQsZbPOx4NDzIH7m0u/G6hbT6BMyQj7OzjPyDVYjf/N/oGbpW0HATCxLW?=
 =?us-ascii?Q?3RcGZR7fUEdVIdHGzHlsW6SNlAsriie31nAgMzBIqhIZedch8ScISBRsgQRY?=
 =?us-ascii?Q?pwx8f7M/gY7NNMVNFSyYXO7AuLt8vEapVhfp?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:36:59.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7ab50c-e452-4e1b-0614-08dd78e4ca2a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF54561D20A

From: Manikandan K Pillai <mpillai@cadence.com>

Add the required definitions for register addresses and register bits
for the  Cadence PCIe HPA controllers. Add the register bank offsets
for different platform architecture and update the global platform
data - platform architecture, EP or RP configuration and the correct
values of register offsets for different register banks during the
platform probe.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../controller/cadence/pcie-cadence-host.c    |  13 +-
 .../controller/cadence/pcie-cadence-plat.c    |  87 +++++
 drivers/pci/controller/cadence/pcie-cadence.h | 320 +++++++++++++++++-
 3 files changed, 410 insertions(+), 10 deletions(-)

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
index 0456845dabb9..b24176d4df1f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -24,6 +24,15 @@ struct cdns_plat_pcie {
 
 struct cdns_plat_pcie_of_data {
 	bool is_rc;
+	bool is_hpa;
+	u32  ip_reg_bank_off;
+	u32  ip_cfg_ctrl_reg_off;
+	u32  axi_mstr_common_off;
+	u32  axi_slave_off;
+	u32  axi_master_off;
+	u32  axi_hls_off;
+	u32  axi_ras_off;
+	u32  axi_dti_off;
 };
 
 static const struct of_device_id cdns_plat_pcie_of_match[];
@@ -72,6 +81,19 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
+		rc->pcie.is_hpa = data->is_hpa;
+		rc->pcie.is_rc = data->is_rc;
+
+		/* Store all the register bank offsets */
+		rc->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off = data->ip_reg_bank_off;
+		rc->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off = data->ip_cfg_ctrl_reg_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off = data->axi_mstr_common_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_master_off = data->axi_master_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_slave_off = data->axi_slave_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_hls_off = data->axi_hls_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_ras_off = data->axi_ras_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_dti_off = data->axi_dti_off;
+
 		cdns_plat_pcie->pcie = &rc->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -99,6 +121,19 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
+		ep->pcie.is_hpa = data->is_hpa;
+		ep->pcie.is_rc = data->is_rc;
+
+		/* Store all the register bank offset */
+		ep->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off = data->ip_reg_bank_off;
+		ep->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off = data->ip_cfg_ctrl_reg_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off = data->axi_mstr_common_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_master_off = data->axi_master_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_slave_off = data->axi_slave_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_hls_off = data->axi_hls_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_ras_off = data->axi_ras_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_dti_off = data->axi_dti_off;
+
 		cdns_plat_pcie->pcie = &ep->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -150,10 +185,54 @@ static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
 
 static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data = {
 	.is_rc = true,
+	.is_hpa = false,
+	.ip_reg_bank_off = 0x0,
+	.ip_cfg_ctrl_reg_off = 0x0,
+	.axi_mstr_common_off = 0x0,
+	.axi_slave_off = 0x0,
+	.axi_master_off = 0x0,
+	.axi_hls_off = 0x0,
+	.axi_ras_off = 0x0,
+	.axi_dti_off = 0x0,
 };
 
 static const struct cdns_plat_pcie_of_data cdns_plat_pcie_ep_of_data = {
 	.is_rc = false,
+	.is_hpa = false,
+	.ip_reg_bank_off = 0x0,
+	.ip_cfg_ctrl_reg_off = 0x0,
+	.axi_mstr_common_off = 0x0,
+	.axi_slave_off = 0x0,
+	.axi_master_off = 0x0,
+	.axi_hls_off = 0x0,
+	.axi_ras_off = 0x0,
+	.axi_dti_off = 0x0,
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
+	.axi_hls_off = 0,
+	.axi_ras_off = 0,
+	.axi_dti_off = 0,
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
+	.axi_hls_off = 0,
+	.axi_ras_off = 0,
+	.axi_dti_off = 0,
 };
 
 static const struct of_device_id cdns_plat_pcie_of_match[] = {
@@ -165,6 +244,14 @@ static const struct of_device_id cdns_plat_pcie_of_match[] = {
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
index 39ee9945c903..a39077d64d1d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -218,6 +218,172 @@
 	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
 	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
 
+/* HPA (High Performance Architecture) PCIe controller register */
+#define CDNS_PCIE_HPA_IP_REG_BANK 0x01000000
+#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK 0x01003c00
+#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON 0x01020000
+
+/* Address Translation Registers (HPA) */
+#define CDNS_PCIE_HPA_AXI_SLAVE 0x03000000
+#define CDNS_PCIE_HPA_AXI_MASTER 0x03002000
+
+/* Root port register base address */
+#define CDNS_PCIE_HPA_RP_BASE 0x0
+
+#define CDNS_PCIE_HPA_LM_ID 0x1420
+
+/* Endpoint Function BARs (HPA) Configuration Registers */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn)			\
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) :	\
+			   CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) + 0x04)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn)			\
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) :	\
+			   CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) + 0x08)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) + 0x0c)
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) (GENMASK(9, 4) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b)))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) (GENMASK(3, 0) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 10)) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
+
+/* Endpoint Function Configuration Register */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG 0x02c0
+
+/* Root Complex BAR Configuration Register */
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG 0x14
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK GENMASK(9, 4)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK GENMASK(3, 0)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK GENMASK(19, 14)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK GENMASK(13, 10)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
+
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE BIT(20)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS BIT(21)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE BIT(22)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS BIT(23)
+
+/* BAR control values applicable to both Endpoint Function and Root Complex */
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED 0x0
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS 0x3
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS 0x1
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS 0x9
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS 0x5
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS 0xD
+
+#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar) \
+	(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar) \
+	(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) \
+	(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
+	(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) \
+	(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
+	(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture) \
+	(((aperture) - 7) << ((bar) * 10))
+
+#define CDNS_PCIE_HPA_LM_PTM_CTRL 0x0520
+#define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN BIT(17)
+
+/* Root Port Registers PCI config space (HPA) for root port function */
+#define CDNS_PCIE_HPA_RP_CAP_OFFSET 0xC0
+
+/* Region r Outbound AXI to PCIe Address Translation Register 0 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r) (0x1010 + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits)           \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, \
+		   ((nbits) - 1))
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
+
+/* Region r Outbound AXI to PCIe Address Translation Register 1 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r) (0x1014 + ((r) & 0x1f) * 0x0080)
+
+/* Region r Outbound PCIe Descriptor Register 0 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r) (0x1008 + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK GENMASK(28, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0 \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1 \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
+
+/* Region r Outbound PCIe Descriptor Register 1 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r) (0x100c + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
+
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r) (0x1018 + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
+
+/* Region r AXI Region Base Address Register 0 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r) (0x1000 + ((r) & 0x1f) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) - 1))
+
+/* Region r AXI Region Base Address Register 1 */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r) (0x1004 + ((r) & 0x1f) * 0x0080)
+
+/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar) (((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar) (0x04 + ((bar) * 0x0008))
+
+/* AXI link down register */
+#define CDNS_PCIE_HPA_AT_LINKDOWN 0x04
+
+/*
+ * Physical Layer Configuration Register 0
+ * This register contains the parameters required for functional setup
+ * of Physical Layer.
+ */
+#define CDNS_PCIE_HPA_PHY_LAYER_CFG0 0x0400
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK GENMASK(26, 24)
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
+	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
+#define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK GENMASK(27, 27)
+
+#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0 0x0420
+
+#define CDNS_PCIE_HPA_RP_MAX_IB 0x3
+#define CDNS_PCIE_HPA_MAX_OB 15
+
+/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register (HPA) */
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) (((fn) * 0x0040) + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) (0x4 + ((fn) * 0x0040) + ((bar) * 0x0008))
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
 	RP_BAR0,
@@ -249,6 +415,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_MSG_DATA			BIT(16)
 
 struct cdns_pcie;
+struct cdns_pcie_rc;
 
 enum cdns_pcie_msg_code {
 	MSG_CODE_ASSERT_INTA	= 0x20,
@@ -281,11 +448,60 @@ enum cdns_pcie_msg_routing {
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
+ * struct cdns_pcie_reg_offset - Register bank offset for a platform
+ * @ip_reg_bank_off: ip register bank start offset
+ * @ip_cfg_ctrl_reg_off: ip config control register start offset
+ * @axi_mstr_common_off: AXI master common register start
+ * @axi_slave_off: AXI slave offset start
+ * @axi_master_off: AXI master offset start
+ * @axi_hls_off: AXI HLS offset start
+ * @axi_ras_off: AXI RAS offset
+ * @axi_dti_off: AXI DTI offset
+ */
+struct cdns_pcie_reg_offset {
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
@@ -294,21 +510,25 @@ struct cdns_pcie_ops {
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
+	struct cdns_pcie_reg_offset cdns_pcie_reg_offsets;
 };
 
 /**
@@ -386,6 +606,41 @@ struct cdns_pcie_ep {
 	unsigned int		quirk_disable_flr:1;
 };
 
+static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie,
+				       enum cdns_pcie_reg_bank bank)
+{
+	u32 offset = 0x0;
+
+	switch (bank) {
+	case REG_BANK_IP_REG:
+		offset = pcie->cdns_pcie_reg_offsets.ip_reg_bank_off;
+		break;
+	case REG_BANK_IP_CFG_CTRL_REG:
+		offset = pcie->cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off;
+		break;
+	case REG_BANK_AXI_MASTER_COMMON:
+		offset = pcie->cdns_pcie_reg_offsets.axi_mstr_common_off;
+		break;
+	case REG_BANK_AXI_MASTER:
+		offset = pcie->cdns_pcie_reg_offsets.axi_master_off;
+		break;
+	case REG_BANK_AXI_SLAVE:
+		offset = pcie->cdns_pcie_reg_offsets.axi_slave_off;
+		break;
+	case REG_BANK_AXI_HLS:
+		offset = pcie->cdns_pcie_reg_offsets.axi_hls_off;
+		break;
+	case REG_BANK_AXI_RAS:
+		offset = pcie->cdns_pcie_reg_offsets.axi_ras_off;
+		break;
+	case REG_BANK_AXI_DTI:
+		offset = pcie->cdns_pcie_reg_offsets.axi_dti_off;
+		break;
+	default:
+		break;
+	};
+	return offset;
+}
 
 /* Register access */
 static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
@@ -398,6 +653,27 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
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
@@ -444,6 +720,9 @@ static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
 {
 	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
 
+	if (pcie->is_hpa)
+		addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
 	cdns_pcie_write_sz(addr, 0x1, value);
 }
 
@@ -452,6 +731,9 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 {
 	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
 
+	if (pcie->is_hpa)
+		addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
 	cdns_pcie_write_sz(addr, 0x2, value);
 }
 
@@ -459,6 +741,9 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
 {
 	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
 
+	if (pcie->is_hpa)
+		addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
 	return cdns_pcie_read_sz(addr, 0x2);
 }
 
@@ -523,29 +808,52 @@ static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
+int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
+int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc);
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr, u64 size,
+				 unsigned long flags);
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
@@ -571,6 +879,12 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
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


