Return-Path: <linux-pci+bounces-25668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B20BA85A40
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202183BC14A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51629898C;
	Fri, 11 Apr 2025 10:37:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6A221282;
	Fri, 11 Apr 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367831; cv=fail; b=l3axsYf2mKjA2P0SmeMRgcJyh6+N+G8ZsA2g7u9/zNbL7SrdCXtyUm38u7Ls6Z7BxVg6ttGCKs+pz6YbJWqHUghOZNu5WNdwpzexVhSKMV7KfGap3g11GyCqWJoJbIEg1jlCEUcAONw9Qv6eUTUWhp4dEjqbuLGIlVtqvVsU0KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367831; c=relaxed/simple;
	bh=zFHjhej9B/mjQ2aTEmoHt4x1RzX9EmZeGqFMjBoBUlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqRC7Clr2wVOZGJ+qB/Mequayf3kW3j3j1WL0ZytkVpXE/eocyw+fgvC9iNmv19IE6FrTmHzmdFQoJDQO8zkP2SjCZw6hpVkrNqlIlgIUqEf6Icz6jFc6H9w05NPzn7QD7JO0IQf3ZB4nqty070oLs02hjhUbsNXfWcad805rDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIXYU0kTdw8WHhijoSj73t2Kide/BC+yzX0KVk9M4908kjbcccfjDBeiHou6IF1J95zRMHgP++KUNxLfE6lhPBHsUFO0G/3efTiA5giY/Sg4mAHKZ1WPcdRP1TpKcQ7HXiW1IpcST1I9KSO5OxCMsCMgDkyjDNELgF8rciZCmH6Lv31LE8GEI/F3/huNDZko57bh0jtimTISUXd1ZjooD0QiZSNAtT/apxCpWZAkDiuSvboLZTmR6gXcbvl25Q421tnJz5l7rmiEc5Xj25gOAnfmdnFPEe4mfEIon8tyR/cHg0XVKo621PtgbYAEKYysruw87FDrMthgb8rH8tyMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPzVup3QHJtUyBDpX84qqgk7DIMFX294sqsqVqWjh8Q=;
 b=lRBj6fm3WSSuk4Dh4bw3nQtA5zmfJotS6Zsuq+APVKhyyizBz/l5PNi62gkwbKQeBljTD9SQR3IvDieFHR9j2elbmVMwMGwlXPwJkdq3Cua/jOgsAvndYDG5pSAgkq/NvVRJxiD21ngwb6MtoOQvqOo1nyJ2IvppQ9PsHkBvc5AHtJ0tHb/oMXzb1kSMqB5IvpZTdSGsKQu0QvBOUfx+zS8c4RiQQyQNVB+h4iA06r2+NzibQyBzvXEJW24M6a7kVGxXz05+bpMgNznHY+qlaICx2ZftP1Szu8z+zbNWSkrZTaWmL55D6863hXY/Bf9YE+uaLTp235n21nkxwF3Svg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR0101CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::16) by KL1PR06MB6017.apcprd06.prod.outlook.com
 (2603:1096:820:d3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Fri, 11 Apr
 2025 10:37:05 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:404:8000:cafe::fd) by TY2PR0101CA0030.outlook.office365.com
 (2603:1096:404:8000::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Fri,
 11 Apr 2025 10:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 10:37:03 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 818524160CA7;
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
Subject: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP controller
Date: Fri, 11 Apr 2025 18:36:55 +0800
Message-ID: <20250411103656.2740517-6-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|KL1PR06MB6017:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a01c1f7-47da-4cf7-ff5e-08dd78e4cc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OdxgLZbijCux4iYC10BbjhIqKB3LtrfTCRr5rBYKVf6AnNW/YLieRJDj0G8L?=
 =?us-ascii?Q?vHCbkHNAjbtMK0xySt07vTUXZYn5CGsjAlpGkVo8tmAiDZ86Cg9qeNn+jwL6?=
 =?us-ascii?Q?/i/4z2INoLoJv54OhR9VRx4libOlxxvB4k7JJwggM5/UgzSDhG8PBBdPdmrs?=
 =?us-ascii?Q?P33fP/8fUvoHck+P748mr8aWPpVw8LAfQdDhZ8nw/Q8ZKTCoz258xnRykAyD?=
 =?us-ascii?Q?Mb8M14/U/zru2X5bdNeStRE99H9TyqlOpeXTxzRFYCxwi7uXARE3ehb8gkqy?=
 =?us-ascii?Q?F62N8enCzKpBDaoLZ9XER+YagJa3YR1uoRV56kp94Dq+sTNOuKb8IdhO22BR?=
 =?us-ascii?Q?lXg0OmmySjtu9JCbmtJtGiatlX014iSdSUwrXC3VgZWMJ1xHcnO0n/Vymy5V?=
 =?us-ascii?Q?wbkicnop5eX3YbYcZWoyRnEkR3SSitoRQ0rbCeLPtKrj8S9IDVBOIuPmnwmE?=
 =?us-ascii?Q?LEP0nDq5lkgCztQ4XAgEA27A0vOQk9qpyTRPkW13jmk6kwOC3l3umzWPu5/y?=
 =?us-ascii?Q?FT0rb1SclIiUsqYWKeuux3iCeteZDW3Zb4F640SzX1y9L2N+RkRc7ETSbNlJ?=
 =?us-ascii?Q?08yU8i9lDAYVwfWlbM9374lOM2bgepY39Myaipezfl/BFZVg8CmRJhjHcAzx?=
 =?us-ascii?Q?fhwM+SEK1EBJrVa4L5FB2wMHjf3oHJPxt7AWZRhcB0QbPSDL41UE65Rk6NR/?=
 =?us-ascii?Q?IgFQBD8um6hOvII1HusGhb/oiCdNJCsbswgH9dCXEjHaKcxHCQRW654Z5mYx?=
 =?us-ascii?Q?LDgN5wxpNTh8OmeIahadxVnc50JKY/ZzdK4YXoH0BN8YyGdwrGYV/SIwLesk?=
 =?us-ascii?Q?qq16D8qu2Gud9DdstHrwj/bWSyn1aGKK46uNV1/OyzorEfnAR4PugjFHtDDa?=
 =?us-ascii?Q?YwxwGLHcumCyvsbSzjDHgZKzpCznpHmj4+ZHy5DIc5Qiv0hIyw6Kxm5RVuH3?=
 =?us-ascii?Q?C46BdoYR0gorZBvUQCJNCe6h6sKRAdPOj2ZcAB9Xav86gSfWyYKjX5KDjmUF?=
 =?us-ascii?Q?OTWBZwEldXrKokNd+ToHzmqF4z6h0LVrLAC1jteqdfiavIrHH8rZ5IlzYC1p?=
 =?us-ascii?Q?B26tuVBus8MIXtOlezLfhGLA3Z//C8bvSYWSDU5JHQJD0gl7HQDfwMAwWG98?=
 =?us-ascii?Q?cyuPPCTxyK0cqlv0nRhj1FEmNZCzVjg+psLF1NdJJrFQx1sOi79uqhj7Wy5J?=
 =?us-ascii?Q?NGqV4EXDcGh0tNBSqb3VNj8uOCsBCsrgK7+xTH8x7jYGjrucIsuKzZRvY+K8?=
 =?us-ascii?Q?yAywG7ozH6iHTHhKCx7Sh6uDkwg1ATuieE9rUH+SLOwDqxzikbmdD09RjXbR?=
 =?us-ascii?Q?h7qpw/UVl2pITcpoirOwOQLb6+lhrTJMY3qjY8xekL3Df5OCinen++IeAWK8?=
 =?us-ascii?Q?JdLjUOOphJI6RxelTlz6bVwd0tL154/CzWJowXUpf+4yK6j2yFLbYC9OdkNC?=
 =?us-ascii?Q?MfQn/uPm84W83o+J5MZWrg7tGmQ+AtRCu8OrdIizzf+up6tsHL2UgLdyUY+8?=
 =?us-ascii?Q?qsuGdR3ru3aqfzOBZ0ne8ZuaCDWcWyG+uq0c?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:37:03.1513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a01c1f7-47da-4cf7-ff5e-08dd78e4cc75
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6017

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for the Cadence PCIe HPA controller by adding
the required callback functions. Update the common functions for
RP and EP configuration. Invoke the relevant callback functions
for platform probe of PCIe controller using the callback function.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  29 +-
 .../controller/cadence/pcie-cadence-host.c    | 271 ++++++++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    |  23 ++
 drivers/pci/controller/cadence/pcie-cadence.c | 196 ++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h |  12 +
 5 files changed, 488 insertions(+), 43 deletions(-)

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
index ce035eef0a5c..c7066ea3b9e8 100644
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
@@ -73,12 +70,81 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
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
+	/*
+	 * Clear AXI link-down status
+	 */
+	regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
+			     (regval & GENMASK(0, 0)));
+
+	desc1 = 0;
+	ctrl0 = 0;
+
+	/*
+	 * Update Output registers for AXI region 0.
+	 */
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
@@ -154,8 +220,14 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
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
@@ -340,8 +412,8 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 		 */
 		bar = cdns_pcie_host_find_min_bar(rc, size);
 		if (bar != RP_BAR_UNDEFINED) {
-			ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
-							   size, flags);
+			ret = pcie->ops->host_bar_ib_config(rc, bar, cpu_addr,
+							    size, flags);
 			if (ret)
 				dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -366,8 +438,7 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 		}
 
 		winsize = bar_max_size[bar];
-		ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
-						   flags);
+		ret = pcie->ops->host_bar_ib_config(rc, bar, cpu_addr, winsize, flags);
 		if (ret) {
 			dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -408,8 +479,8 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
 	if (list_empty(&bridge->dma_ranges)) {
 		of_property_read_u32(np, "cdns,no-bar-match-nbits",
 				     &no_bar_nbits);
-		err = cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
-						   (u64)1 << no_bar_nbits, 0);
+		err = pcie->ops->host_bar_ib_config(rc, RP_NO_BAR, 0x0,
+						    (u64)1 << no_bar_nbits, 0);
 		if (err)
 			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
 		return err;
@@ -467,17 +538,159 @@ int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
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
@@ -489,11 +702,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
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
@@ -503,7 +716,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 	int ret;
 
 	if (rc->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
+		pcie->ops->detect_quiet_min_delay_set(&rc->pcie);
 
 	cdns_pcie_host_enable_ptm_response(pcie);
 
@@ -566,8 +779,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
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
index b24176d4df1f..8d5fbaef0a3c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -43,7 +43,30 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
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
+	.start_link = cdns_pcie_hpa_startlink,
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
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..c0d3ab3c363f 100644
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
@@ -147,6 +186,161 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
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
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
+				       u32 r, bool is_io,
+				       u64 cpu_addr, u64 pci_addr, size_t size)
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
index a39077d64d1d..c317fc10f5d1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -816,6 +816,14 @@ int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
 				 enum cdns_pcie_rp_bar bar,
 				 u64 cpu_addr, u64 size,
 				 unsigned long flags);
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
+				   int where);
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc);
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags);
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc);
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
@@ -865,6 +873,10 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 }
 #endif
 
+bool cdns_pcie_linkup(struct cdns_pcie *pcie);
+bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie);
+int cdns_pcie_hpa_start_link(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie);
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
-- 
2.47.1


