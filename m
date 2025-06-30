Return-Path: <linux-pci+bounces-31049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF299AED362
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE68173E16
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718C218AD4;
	Mon, 30 Jun 2025 04:16:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023099.outbound.protection.outlook.com [40.107.44.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D51B87F0;
	Mon, 30 Jun 2025 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256981; cv=fail; b=is0my4ON4FEpHtbdyBsS237yMzPyVYw3dRM3j8UiDH8+LHx/SpspFJ1QhIp7hs+IetmyB730cUhRZx7iDcd13EvlyFxX3Yv1+qDm88O3ZzC3LewxZgV5EE8GlG+G5KgWuGzus8nAy9tthC0o2WJC/qinxCT9JYIrgkZPJk6BN+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256981; c=relaxed/simple;
	bh=e4FvnxCh/JVJnhgk3odvVSzp3qCpOBkzx0qh2RtDt6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyeHilDOtGQFUVykqp5ghiv9km//Ersxe8Eu9wKmrHml+2Sl170pMxNvWQ1Ff4JxxcrnnoN2CGvyfupNCiUIUjC+Z86OGrdnEvoqznDPmNwuxtgE4U+OEfyRZQc+FyyKXASIVqfCM0NnOX8fRHCd5NtjS/EgZZpBiVz9ICcZo0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIu7M6RI8VB/RYZd1fy4cBjPDah3PoPu6OK5sERonNwpblN5SquERwflcY8SwiqnEtE4BHqaDwPqK04KWVfE3OfLdeiJLLrzSs3j6JA0ASjOlPotH5ZeCegIC7u3ORUoNUt1iOX2Au1wiRl6BGoScBCmW0NNWax+kkMv081ImtgVnUKd82KVwgrTltMikbkDL/BMtEfx8KNk2SjM2WxI/QLCbm7xL/HPUiveR4Qpg/zbLUpqz0bpRCD9KMY3/kzJuoksITmBRPjvT7GJmhvlroBh+BZVV8lW1Aa+HOAJ9Lqts5CwmXO07GxV5FiQQRBQFuLHQ7n5q7eGWWeHWbV5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47U9PDjWTP0IJ6+hutG3ZM1cKkf/Db0P3/LcXD3ABi0=;
 b=twL0WaJFLxOoWKZjLpwUNXZhlwyGYGRMxvPSiYWsN2LqnYCYEDhCRRZZ+djs8OU9iNvjiemuyWC87noGmE5S5icI6vNj1x0yzz9vxU/w2Yxn69MnFnfqQS6rT+0AjFgxGmKmF3x0qImFDSvZfrPAUt2Z1g4bb2y4gNmfYgBy3hQ6rNZjm1PvXXbk+oU9upU9lFux88vIlxAO7Z6qGMWrqjaCjEqg66zf9DCaa0t0zbWUH4NTMet+2r4pc1ZjuLgkXPQX333WFxbi94Mtdt1kaE0uktlRacjPuDHcNqi46b/8q/RY/b0XM9Cgklw+lEVTXdWuKLJnxjeGMuZmFiTcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::10) by
 SEZPR06MB7137.apcprd06.prod.outlook.com (2603:1096:101:232::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.25; Mon, 30 Jun 2025 04:16:10 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:190:cafe::c3) by SI2P153CA0019.outlook.office365.com
 (2603:1096:4:190::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.13 via Frontend Transport; Mon,
 30 Jun 2025 04:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B965D41604F5;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v5 08/14] PCI: cadence: Add support for High Performance Arch(HPA) controller
Date: Mon, 30 Jun 2025 12:15:55 +0800
Message-ID: <20250630041601.399921-9-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR06MB7137:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bc684230-5e55-4fb6-2298-08ddb78cd79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/whj6Hvevc74aPw0Gi4gK6HGe23OqAwrYmEA8oFhiqYTiORl58B0zl2Lougz?=
 =?us-ascii?Q?OfFBfzQgKWNJAgO4KvEkCPPrz0VYaGAEbfKh8COeOmsi4xals17d/rBGizST?=
 =?us-ascii?Q?7Ki7Vug75jWcMOGwa/L+296NU7oGeBPGPc7TYw4sGjFkK6um1PnCS5annoSa?=
 =?us-ascii?Q?hv9TbUlJaFMxcRDgvgHcRsAV/gDziKGMDWqJgF380OaAin9mgei0NJOM5o8J?=
 =?us-ascii?Q?6YLXkhVrc82P5i1CDIuhcYD9Pt9M6J+4OlhN1IUTUa4be97EmjYBLeF/slwy?=
 =?us-ascii?Q?odHsox5B//a9b6zgC9ROTTAeGhjevL1d/CwVwVSJ342nzWkYfY4Btm3fbMJc?=
 =?us-ascii?Q?a4iBAlHQoFoUzylAipRapXzlRH+mP7EjeVuam8RycdR0wnoGDkJWUqDgJ3Ah?=
 =?us-ascii?Q?k0dAFEb4b/Xf4I7ZtdZAVUsVKrTZA53mznSnxI+rowQiQ6mNJgMqlVW9B2C5?=
 =?us-ascii?Q?AKWTPeS/o4OzoxGGNLvyNkJimYRg/pw72TYLjssRchcsZMbDnsukic8qnb1o?=
 =?us-ascii?Q?5exyUKaji6T1kYHk0dazGMz+X4yO284n0gcENHkKN2w1As6uxBBY/su2MvS5?=
 =?us-ascii?Q?HeKQ1hzBvD0jiNZVDZCWjugGSsQeSyAT13D1P63WhLWfuFxgzdXjk3VyxJBb?=
 =?us-ascii?Q?oODq8mb5iEMFnwJo9tr/+aSA0K7F1fdgfOKcSGUqJhc63ikx4rhakAyWRxbA?=
 =?us-ascii?Q?H3N+h0FDIM5vkyxQdtGpM+ZPSJjEcU5U4gYHRDnz+dCEOs8jHEaXKULF1gPt?=
 =?us-ascii?Q?txJyurddULKtfzWqg/Z0K3gk2pwaVHiWByNTR6Hm1DTVYEDvxYXUWWSGB0lX?=
 =?us-ascii?Q?0xNpNH6MHTUgSc1pglqwiqda718nTb7xUiOZSmedFVbPQB/QRhpE0ZoVrJxP?=
 =?us-ascii?Q?xOZFPTZXIjCns+g+ZdNzzBM3mpIiKTyVnjAQ7byPeuRIsqEYM88cNpoprKR6?=
 =?us-ascii?Q?jni9Ms11+Hy3kyTIiC9OOfRNNJb6NiqYKo+bZrf4wa3cPAVixftXzTCuCiQT?=
 =?us-ascii?Q?upBypF2JkRKn1AlJPixh0Zpf6hPj1lrUIgfn6zXGCsu+cyXtzJKBDCHfQfVB?=
 =?us-ascii?Q?med9KjwVNyhP8s4sI69+vhSBJkHOsp070DgkpWDzvU00PLwP8nPcPwkzaS2L?=
 =?us-ascii?Q?co7xBbe6+vVN635DcuYf1iXMGr039EV/HXT7G7LLxWEcuxujkMjjNmE58Mgt?=
 =?us-ascii?Q?KnolPsp9F7dkGky5ZPulG4ypN4er5x8rYs5GFwo7qyyn6J9gq1zzAviZKPG8?=
 =?us-ascii?Q?/UwsxiT9zE5uc1v2Pi8jVLBLtlG5MSMRCS1KG0S3CAywUSniX5/HO5WxH8/R?=
 =?us-ascii?Q?OqU4kVglPtoqM3X/FRhmbi638y/B0o6OsuTCWzhO33Ef17eNiFVGa9tDOXKd?=
 =?us-ascii?Q?eOYwHBn4n2aiu2rKwPYqSLhTdATd3z+JP/KkjOyAvr44DKi4/Qn0UDrCwVwj?=
 =?us-ascii?Q?3Tlgr00M/cUaMs7pmYZTTlSP+/IwJvfyxZnaqNHickmQZTxJ91eUxL+4rNE8?=
 =?us-ascii?Q?B4M3YpUGcXQ0pzbgJLcs+Jrxtt/vYEqOfKwg?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:09.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc684230-5e55-4fb6-2298-08ddb78cd79a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7137

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for Cadence PCIe RP and EP configuration for High
Performance Architecture(HPA) controllers.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   6 +-
 .../controller/cadence/pcie-cadence-ep-hpa.c  | 523 ++++++++++++++++
 .../cadence/pcie-cadence-host-hpa.c           | 584 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-hpa.c | 199 ++++++
 .../controller/cadence/pcie-cadence-plat.c    |  19 +-
 drivers/pci/controller/cadence/pcie-cadence.c |  10 +
 drivers/pci/controller/cadence/pcie-cadence.h |  69 ++-
 7 files changed, 1395 insertions(+), 15 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 3fe5dd2bbd5b..e2df24ff4c33 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-common.o pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-common.o pcie-cadence.o pcie-cadence-hpa.o
 obj-$(CONFIG_PCIE_CADENCE_EP_COMMON) += pcie-cadence-ep-common.o
 obj-$(CONFIG_PCIE_CADENCE_HOST_COMMON) += pcie-cadence-host-common.o
-obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
-obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
+obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o pcie-cadence-host-hpa.o
+obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o pcie-cadence-ep-hpa.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c
new file mode 100644
index 000000000000..5d769a460d76
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe endpoint controller driver.
+// Author: Manikandan K Pillai  <mpillai@cadence.com>
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/pci-epc.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+
+#include "pcie-cadence.h"
+#include "pcie-cadence-ep-common.h"
+
+static int cdns_pcie_hpa_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
+				     phys_addr_t addr, u64 pci_addr, size_t size)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 r;
+
+	r = find_first_zero_bit(&ep->ob_region_map, BITS_PER_LONG);
+	if (r >= ep->max_regions - 1) {
+		dev_err(&epc->dev, "no free outbound region\n");
+		return -EINVAL;
+	}
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_hpa_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size);
+
+	set_bit(r, &ep->ob_region_map);
+	ep->ob_addr[r] = addr;
+
+	return 0;
+}
+
+static void cdns_pcie_hpa_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
+					phys_addr_t addr)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 r;
+
+	for (r = 0; r < ep->max_regions - 1; r++)
+		if (ep->ob_addr[r] == addr)
+			break;
+
+	if (r == ep->max_regions - 1)
+		return;
+
+	cdns_pcie_hpa_reset_outbound_region(pcie, r);
+
+	ep->ob_addr[r] = 0;
+	clear_bit(r, &ep->ob_region_map);
+}
+
+static void cdns_pcie_hpa_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
+					 bool is_asserted)
+{
+	struct cdns_pcie *pcie = &ep->pcie;
+	unsigned long flags;
+	u32 offset;
+	u16 status;
+	u8 msg_code;
+
+	intx &= 3;
+
+	/* Set the outbound region if needed. */
+	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
+		     ep->irq_pci_fn != fn)) {
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_hpa_set_outbound_region_for_normal_msg(pcie, 0, fn, 0, ep->irq_phys_addr);
+		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
+		ep->irq_pci_fn = fn;
+	}
+
+	if (is_asserted) {
+		ep->irq_pending |= BIT(intx);
+		msg_code = PCIE_MSG_CODE_ASSERT_INTA + intx;
+	} else {
+		ep->irq_pending &= ~BIT(intx);
+		msg_code = PCIE_MSG_CODE_DEASSERT_INTA + intx;
+	}
+
+	spin_lock_irqsave(&ep->lock, flags);
+	status = cdns_pcie_ep_fn_readw(pcie, fn, PCI_STATUS);
+	if (((status & PCI_STATUS_INTERRUPT) != 0) ^ (ep->irq_pending != 0)) {
+		status ^= PCI_STATUS_INTERRUPT;
+		cdns_pcie_ep_fn_writew(pcie, fn, PCI_STATUS, status);
+	}
+	spin_unlock_irqrestore(&ep->lock, flags);
+
+	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
+		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
+	writel(0, ep->irq_cpu_addr + offset);
+}
+
+static int cdns_pcie_hpa_ep_send_intx_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
+					  u8 intx)
+{
+	u16 cmd;
+
+	cmd = cdns_pcie_ep_fn_readw(&ep->pcie, fn, PCI_COMMAND);
+	if (cmd & PCI_COMMAND_INTX_DISABLE)
+		return -EINVAL;
+
+	cdns_pcie_hpa_ep_assert_intx(ep, fn, intx, true);
+
+	/* The mdelay() value was taken from dra7xx_pcie_raise_intx_irq() */
+	mdelay(1);
+	cdns_pcie_hpa_ep_assert_intx(ep, fn, intx, false);
+	return 0;
+}
+
+static int cdns_pcie_hpa_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
+					 u8 interrupt_num)
+{
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	u16 flags, mme, data, data_mask;
+	u8 msi_count;
+	u64 pci_addr, pci_addr_mask = 0xff;
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+
+	/* Check whether the MSI feature has been enabled by the PCI host. */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
+	if (!(flags & PCI_MSI_FLAGS_ENABLE))
+		return -EINVAL;
+
+	/* Get the number of enabled MSIs */
+	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
+	msi_count = 1 << mme;
+	if (!interrupt_num || interrupt_num > msi_count)
+		return -EINVAL;
+
+	/* Compute the data value to be written. */
+	data_mask = msi_count - 1;
+	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
+	data = (data & ~data_mask) | ((interrupt_num - 1) & data_mask);
+
+	/* Get the PCI address where to write the data into. */
+	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
+	pci_addr <<= 32;
+	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
+	pci_addr &= GENMASK_ULL(63, 2);
+
+	/* Set the outbound region if needed. */
+	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
+		     ep->irq_pci_fn != fn)) {
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_hpa_set_outbound_region(pcie, 0, fn, 0,
+						  false,
+						  ep->irq_phys_addr,
+						  pci_addr & ~pci_addr_mask,
+						  pci_addr_mask + 1);
+		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
+		ep->irq_pci_fn = fn;
+	}
+	writel(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
+
+	return 0;
+}
+
+static int cdns_pcie_hpa_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
+					  u16 interrupt_num)
+{
+	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
+	u32 tbl_offset, msg_data, reg;
+	struct cdns_pcie *pcie = &ep->pcie;
+	struct pci_epf_msix_tbl *msix_tbl;
+	struct cdns_pcie_epf *epf;
+	u64 pci_addr_mask = 0xff;
+	u64 msg_addr;
+	u16 flags;
+	u8 bir;
+
+	epf = &ep->epf[fn];
+	if (vfn > 0)
+		epf = &epf->epf[vfn - 1];
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+
+	/* Check whether the MSI-X feature has been enabled by the PCI host. */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSIX_FLAGS);
+	if (!(flags & PCI_MSIX_FLAGS_ENABLE))
+		return -EINVAL;
+
+	reg = cap + PCI_MSIX_TABLE;
+	tbl_offset = cdns_pcie_ep_fn_readl(pcie, fn, reg);
+	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
+	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
+
+	msix_tbl = epf->epf_bar[bir]->addr + tbl_offset;
+	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
+	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
+
+	/* Set the outbound region if needed. */
+	if (ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||
+	    ep->irq_pci_fn != fn) {
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_hpa_set_outbound_region(pcie, 0, fn, 0,
+						  false,
+						  ep->irq_phys_addr,
+						  msg_addr & ~pci_addr_mask,
+						  pci_addr_mask + 1);
+		ep->irq_pci_addr = (msg_addr & ~pci_addr_mask);
+		ep->irq_pci_fn = fn;
+	}
+	writel(msg_data, ep->irq_cpu_addr + (msg_addr & pci_addr_mask));
+
+	return 0;
+}
+
+static int cdns_pcie_hpa_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
+				      unsigned int type, u16 interrupt_num)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	struct device *dev = pcie->dev;
+
+	switch (type) {
+	case PCI_IRQ_INTX:
+		if (vfn > 0) {
+			dev_err(dev, "Cannot raise INTX interrupts for VF\n");
+			return -EINVAL;
+		}
+		return cdns_pcie_hpa_ep_send_intx_irq(ep, fn, vfn, 0);
+
+	case PCI_IRQ_MSI:
+		return cdns_pcie_hpa_ep_send_msi_irq(ep, fn, vfn, interrupt_num);
+
+	case PCI_IRQ_MSIX:
+		return cdns_pcie_hpa_ep_send_msix_irq(ep, fn, vfn, interrupt_num);
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int cdns_pcie_hpa_ep_start(struct pci_epc *epc)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	struct device *dev = pcie->dev;
+	int max_epfs = sizeof(epc->function_num_map) * 8;
+	int ret, epf, last_fn;
+	u32 reg, value;
+
+	/*
+	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
+	 * and can't be disabled anyway.
+	 */
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
+			     CDNS_PCIE_HPA_LM_EP_FUNC_CFG, epc->function_num_map);
+
+	/*
+	 * Next function field in ARI_CAP_AND_CTR register for last function
+	 * should be 0.  Clear Next Function Number field for the last
+	 * function used.
+	 */
+	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
+	reg = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
+	value = cdns_pcie_readl(pcie, reg);
+	value &= ~CDNS_PCIE_ARI_CAP_NFN_MASK;
+	cdns_pcie_writel(pcie, reg, value);
+
+	if (ep->quirk_disable_flr) {
+		for (epf = 0; epf < max_epfs; epf++) {
+			if (!(epc->function_num_map & BIT(epf)))
+				continue;
+
+			value = cdns_pcie_ep_fn_readl(pcie, epf,
+						      CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
+						      PCI_EXP_DEVCAP);
+			value &= ~PCI_EXP_DEVCAP_FLR;
+			cdns_pcie_ep_fn_writel(pcie, epf,
+					       CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
+					       PCI_EXP_DEVCAP, value);
+		}
+	}
+
+	ret = cdns_pcie_start_link(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to start link\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cdns_pcie_hpa_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				    struct pci_epf_bar *epf_bar)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie_epf *epf = &ep->epf[fn];
+	struct cdns_pcie *pcie = &ep->pcie;
+	dma_addr_t bar_phys = epf_bar->phys_addr;
+	enum pci_barno bar = epf_bar->barno;
+	int flags = epf_bar->flags;
+	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
+	u64 sz;
+
+	/* BAR size is 2^(aperture + 7) */
+	sz = max_t(size_t, epf_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
+
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values.
+	 */
+	sz = 1ULL << fls64(sz - 1);
+
+	/* 128B -> 0, 256B -> 1, 512B -> 2, ... */
+	aperture = ilog2(sz) - 7;
+
+	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
+		ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS;
+	} else {
+		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
+		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+
+		if (is_64bits && (bar & 1))
+			return -EINVAL;
+
+		if (is_64bits && is_prefetch)
+			ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
+		else if (is_prefetch)
+			ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
+		else if (is_64bits)
+			ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS;
+		else
+			ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS;
+	}
+
+	addr0 = lower_32_bits(bar_phys);
+	addr1 = upper_32_bits(bar_phys);
+
+	if (vfn == 1)
+		reg = CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn);
+	else
+		reg = CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b = (bar < BAR_4) ? bar : bar - BAR_4;
+
+	if (vfn == 0 || vfn == 1) {
+		cfg = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, reg);
+		cfg &= ~(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+		cfg |= (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, reg, cfg);
+	}
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), addr1);
+
+	if (vfn > 0)
+		epf = &epf->epf[vfn - 1];
+	epf->epf_bar[bar] = epf_bar;
+
+	return 0;
+}
+
+static void cdns_pcie_hpa_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				       struct pci_epf_bar *epf_bar)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie_epf *epf = &ep->epf[fn];
+	struct cdns_pcie *pcie = &ep->pcie;
+	enum pci_barno bar = epf_bar->barno;
+	u32 reg, cfg, b, ctrl;
+
+	if (vfn == 1)
+		reg = CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn);
+	else
+		reg = CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b = (bar < BAR_4) ? bar : bar - BAR_4;
+
+	if (vfn == 0 || vfn == 1) {
+		ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
+		cfg = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, reg);
+		cfg &= ~(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+		cfg |= CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, reg, cfg);
+	}
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), 0);
+
+	if (vfn > 0)
+		epf = &epf->epf[vfn - 1];
+	epf->epf_bar[bar] = NULL;
+}
+
+static const struct pci_epc_ops cdns_pcie_hpa_epc_ops = {
+	.write_header	= cdns_pcie_ep_write_header,
+	.set_bar	= cdns_pcie_hpa_ep_set_bar,
+	.clear_bar	= cdns_pcie_hpa_ep_clear_bar,
+	.map_addr	= cdns_pcie_hpa_ep_map_addr,
+	.unmap_addr	= cdns_pcie_hpa_ep_unmap_addr,
+	.set_msi	= cdns_pcie_ep_set_msi,
+	.get_msi	= cdns_pcie_ep_get_msi,
+	.set_msix	= cdns_pcie_ep_set_msix,
+	.get_msix	= cdns_pcie_ep_get_msix,
+	.raise_irq	= cdns_pcie_hpa_ep_raise_irq,
+	.map_msi_irq	= cdns_pcie_ep_map_msi_irq,
+	.start		= cdns_pcie_hpa_ep_start,
+	.get_features	= cdns_pcie_ep_get_features,
+};
+
+int cdns_pcie_hpa_ep_setup(struct cdns_pcie_ep *ep)
+{
+	struct device *dev = ep->pcie.dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev->of_node;
+	struct cdns_pcie *pcie = &ep->pcie;
+	struct cdns_pcie_epf *epf;
+	struct resource *res;
+	struct pci_epc *epc;
+	int ret;
+	int i;
+
+	pcie->is_rc = false;
+
+	pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
+	if (IS_ERR(pcie->reg_base)) {
+		dev_err(dev, "missing \"reg\"\n");
+		return PTR_ERR(pcie->reg_base);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
+	if (!res) {
+		dev_err(dev, "missing \"mem\"\n");
+		return -EINVAL;
+	}
+	pcie->mem_res = res;
+
+	ep->max_regions = CDNS_PCIE_MAX_OB;
+	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
+
+	ep->ob_addr = devm_kcalloc(dev,
+				   ep->max_regions, sizeof(*ep->ob_addr),
+				   GFP_KERNEL);
+	if (!ep->ob_addr)
+		return -ENOMEM;
+
+	epc = devm_pci_epc_create(dev, &cdns_pcie_hpa_epc_ops);
+	if (IS_ERR(epc)) {
+		dev_err(dev, "failed to create epc device\n");
+		return PTR_ERR(epc);
+	}
+
+	epc_set_drvdata(epc, ep);
+
+	if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
+		epc->max_functions = 1;
+
+	ep->epf = devm_kcalloc(dev, epc->max_functions, sizeof(*ep->epf),
+			       GFP_KERNEL);
+	if (!ep->epf)
+		return -ENOMEM;
+
+	epc->max_vfs = devm_kcalloc(dev, epc->max_functions,
+				    sizeof(*epc->max_vfs), GFP_KERNEL);
+	if (!epc->max_vfs)
+		return -ENOMEM;
+
+	ret = of_property_read_u8_array(np, "max-virtual-functions",
+					epc->max_vfs, epc->max_functions);
+	if (ret == 0) {
+		for (i = 0; i < epc->max_functions; i++) {
+			epf = &ep->epf[i];
+			if (epc->max_vfs[i] == 0)
+				continue;
+			epf->epf = devm_kcalloc(dev, epc->max_vfs[i],
+						sizeof(*ep->epf), GFP_KERNEL);
+			if (!epf->epf)
+				return -ENOMEM;
+		}
+	}
+
+	ret = pci_epc_mem_init(epc, pcie->mem_res->start,
+			       resource_size(pcie->mem_res), PAGE_SIZE);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize the memory space\n");
+		return ret;
+	}
+
+	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
+						  SZ_128K);
+	if (!ep->irq_cpu_addr) {
+		dev_err(dev, "failed to reserve memory space for MSI\n");
+		ret = -ENOMEM;
+		goto free_epc_mem;
+	}
+	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
+	/* Reserve region 0 for IRQs */
+	set_bit(0, &ep->ob_region_map);
+
+	if (ep->quirk_detect_quiet_flag)
+		cdns_pcie_hpa_detect_quiet_min_delay_set(&ep->pcie);
+
+	spin_lock_init(&ep->lock);
+
+	pci_epc_init_notify(epc);
+
+	return 0;
+
+ free_epc_mem:
+	pci_epc_mem_exit(epc);
+
+	return ret;
+}
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
new file mode 100644
index 000000000000..94cba8ec4860
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe host controller driver.
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/list_sort.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-cadence.h"
+#include "pcie-cadence-host-common.h"
+
+static u8 bar_aperture_mask[] = {
+	[RP_BAR0] = 0x1F,
+	[RP_BAR1] = 0xF,
+};
+
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
+int cdns_pcie_hpa_host_wait_for_link(struct cdns_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_link_up(pcie)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+	return -ETIMEDOUT;
+}
+
+int cdns_pcie_hpa_host_start_link(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	int ret;
+
+	ret = cdns_pcie_host_wait_for_link(pcie);
+
+	/*
+	 * Retrain link for Gen2 training defect
+	 * if quirk flag is set.
+	 */
+	if (!ret && rc->quirk_retrain_flag)
+		ret = cdns_pcie_retrain(pcie);
+
+	return ret;
+}
+
+static struct pci_ops cdns_pcie_hpa_host_ops = {
+	.map_bus	= cdns_pci_hpa_map_bus,
+	.read		= pci_generic_config_read,
+	.write		= pci_generic_config_write,
+};
+
+static void cdns_pcie_hpa_host_enable_ptm_response(struct cdns_pcie *pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL,
+			     val | CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN);
+}
+
+static int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+					    enum cdns_pcie_rp_bar bar,
+					    u64 cpu_addr, u64 size,
+					    unsigned long flags)
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
+static int cdns_pcie_hpa_host_bar_config(struct cdns_pcie_rc *rc,
+					 struct resource_entry *entry)
+{
+	u64 cpu_addr, pci_addr, size, winsize;
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	enum cdns_pcie_rp_bar bar;
+	unsigned long flags;
+	int ret;
+
+	cpu_addr = entry->res->start;
+	pci_addr = entry->res->start - entry->offset;
+	flags = entry->res->flags;
+	size = resource_size(entry->res);
+
+	if (entry->offset) {
+		dev_err(dev, "PCI addr: %llx must be equal to CPU addr: %llx\n",
+			pci_addr, cpu_addr);
+		return -EINVAL;
+	}
+
+	while (size > 0) {
+		/*
+		 * Try to find a minimum BAR whose size is greater than
+		 * or equal to the remaining resource_entry size. This will
+		 * fail if the size of each of the available BARs is less than
+		 * the remaining resource_entry size.
+		 * If a minimum BAR is found, IB ATU will be configured and
+		 * exited.
+		 */
+		bar = cdns_pcie_host_find_min_bar(rc, size);
+		if (bar != RP_BAR_UNDEFINED) {
+			ret = cdns_pcie_hpa_host_bar_ib_config(rc, bar, cpu_addr,
+							       size, flags);
+			if (ret)
+				dev_err(dev, "IB BAR: %d config failed\n", bar);
+			return ret;
+		}
+
+		/*
+		 * If the control reaches here, it would mean the remaining
+		 * resource_entry size cannot be fitted in a single BAR. So we
+		 * find a maximum BAR whose size is less than or equal to the
+		 * remaining resource_entry size and split the resource entry
+		 * so that part of resource entry is fitted inside the maximum
+		 * BAR. The remaining size would be fitted during the next
+		 * iteration of the loop.
+		 * If a maximum BAR is not found, there is no way we can fit
+		 * this resource_entry, so we error out.
+		 */
+		bar = cdns_pcie_host_find_max_bar(rc, size);
+		if (bar == RP_BAR_UNDEFINED) {
+			dev_err(dev, "No free BAR to map cpu_addr %llx\n",
+				cpu_addr);
+			return -EINVAL;
+		}
+
+		winsize = bar_max_size[bar];
+		ret = cdns_pcie_hpa_host_bar_ib_config(rc, bar, cpu_addr, winsize, flags);
+		if (ret) {
+			dev_err(dev, "IB BAR: %d config failed\n", bar);
+			return ret;
+		}
+
+		size -= winsize;
+		cpu_addr += winsize;
+	}
+
+	return 0;
+}
+
+static int cdns_pcie_hpa_host_map_dma_ranges(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge;
+	struct resource_entry *entry;
+	u32 no_bar_nbits = 32;
+	int err;
+
+	bridge = pci_host_bridge_from_priv(rc);
+	if (!bridge)
+		return -ENOMEM;
+
+	if (list_empty(&bridge->dma_ranges)) {
+		of_property_read_u32(np, "cdns,no-bar-match-nbits",
+				     &no_bar_nbits);
+		err = cdns_pcie_hpa_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
+						       (u64)1 << no_bar_nbits, 0);
+		if (err)
+			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
+		return err;
+	}
+
+	list_sort(NULL, &bridge->dma_ranges, cdns_pcie_host_dma_ranges_cmp);
+
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		err = cdns_pcie_hpa_host_bar_config(rc, entry);
+		if (err) {
+			dev_err(dev, "Fail to configure IB using dma-ranges\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
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
+		cdns_pcie_hpa_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
+
+	if (rc->device_id != 0xffff)
+		cdns_pcie_hpa_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
+
+	cdns_pcie_hpa_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
+	cdns_pcie_hpa_rp_writeb(pcie, PCI_CLASS_PROG, 0);
+	cdns_pcie_hpa_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
+
+	return 0;
+}
+
+static void cdns_pcie_hpa_create_region_for_ecam(struct cdns_pcie_rc *rc)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
+	struct resource *cfg_res = rc->cfg_res;
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 value, root_port_req_id_reg, pcie_bus_number_reg;
+	u32 ecam_addr_0, region_size_0, request_id_0;
+	int busnr = 0, secbus = 0, subbus = 0;
+	struct resource_entry *entry;
+	resource_size_t size;
+	u32 axi_address_low;
+	int nbits;
+	u64 sz;
+
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (entry) {
+		busnr = entry->res->start;
+		secbus = (busnr < 0xff) ? (busnr + 1) : 0xff;
+		subbus = entry->res->end;
+	}
+	size = resource_size(cfg_res);
+	sz = 1ULL << fls64(size - 1);
+	nbits = ilog2(sz);
+	if (nbits < 8)
+		nbits = 8;
+
+	root_port_req_id_reg = ((busnr & 0xff) << 8);
+	pcie_bus_number_reg = ((subbus & 0xff) << 16) | ((secbus & 0xff) << 8) |
+			      (busnr & 0xff);
+	ecam_addr_0 = cfg_res->start;
+	region_size_0 = nbits - 1;
+	request_id_0 = ((busnr & 0xff) << 8);
+
+#define CDNS_PCIE_HPA_TAG_MANAGEMENT (0x0)
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_TAG_MANAGEMENT, 0x200000);
+
+	/* Taking slave err as OKAY */
+#define CDNS_PCIE_HPA_SLAVE_RESP (0x100)
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_SLAVE_RESP,
+			     0x0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_SLAVE_RESP + 0x4, 0x0);
+
+	/* Program the register "i_root_port_req_id_reg" with RP's BDF */
+#define I_ROOT_PORT_REQ_ID_REG (0x141c)
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, I_ROOT_PORT_REQ_ID_REG,
+			     root_port_req_id_reg);
+
+	/**
+	 * Program the register "i_pcie_bus_numbers" with Primary(RP's bus number),
+	 * secondary and subordinate bus numbers
+	 */
+#define I_PCIE_BUS_NUMBERS (CDNS_PCIE_HPA_RP_BASE + 0x18)
+	cdns_pcie_hpa_writel(pcie, REG_BANK_RP, I_PCIE_BUS_NUMBERS,
+			     pcie_bus_number_reg);
+
+	/* Program the register "lm_hal_sbsa_ctrl[0]" to enable the sbsa */
+#define LM_HAL_SBSA_CTRL (0x1170)
+	value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, LM_HAL_SBSA_CTRL);
+	value |= BIT(0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, LM_HAL_SBSA_CTRL, value);
+
+	/* Program region[0] for ECAM */
+	axi_address_low = (ecam_addr_0 & 0xfff00000) | region_size_0;
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0),
+			     axi_address_low);
+
+	/* rc0-high-axi-address */
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), 0x0);
+	/* Type-1 CFG */
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), 0x05000000);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0),
+			     (request_id_0 << 16));
+
+	/* All AXI bits pass through PCIe */
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), 0x1b);
+	/* PCIe address-high */
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), 0x06000000);
+}
+
+static void cdns_pcie_hpa_create_region_for_cfg(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
+	struct resource *cfg_res = rc->cfg_res;
+	struct resource_entry *entry;
+	u64 cpu_addr = cfg_res->start;
+	u32 addr0, addr1, desc1;
+	int busnr = 0;
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
+}
+
+static int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = pcie->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
+	struct resource_entry *entry;
+	int r = 0, busnr = 0;
+
+	if (rc->ecam_support_flag)
+		cdns_pcie_hpa_create_region_for_ecam(rc);
+	else
+		cdns_pcie_hpa_create_region_for_cfg(rc);
+
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (entry)
+		busnr = entry->res->start;
+
+	r++;
+	if (pcie->msg_res)
+		cdns_pcie_hpa_set_outbound_region_for_normal_msg(pcie, busnr, 0, r,
+								 pcie->msg_res->start);
+
+	r++;
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		struct resource *res = entry->res;
+		u64 pci_addr = res->start - entry->offset;
+
+		if (resource_type(res) == IORESOURCE_IO)
+			cdns_pcie_hpa_set_outbound_region(pcie, busnr, 0, r,
+							  true,
+							  pci_pio_to_address(res->start),
+							  pci_addr,
+							  resource_size(res));
+		else
+			cdns_pcie_hpa_set_outbound_region(pcie, busnr, 0, r,
+							  false,
+							  res->start,
+							  pci_addr,
+							  resource_size(res));
+
+		r++;
+	}
+
+	if (device_property_read_bool(dev, "cdns,no-inbound-bar"))
+		return 0;
+	else
+		return cdns_pcie_hpa_host_map_dma_ranges(rc);
+}
+
+int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc)
+{
+	int err;
+
+	err = cdns_pcie_hpa_host_init_root_port(rc);
+	if (err)
+		return err;
+
+	return cdns_pcie_hpa_host_init_address_translation(rc);
+}
+
+int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct device *dev = rc->pcie.dev;
+	int ret;
+
+	if (rc->quirk_detect_quiet_flag)
+		cdns_pcie_hpa_detect_quiet_min_delay_set(&rc->pcie);
+
+	cdns_pcie_hpa_host_enable_ptm_response(pcie);
+
+	ret = cdns_pcie_start_link(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to start link\n");
+		return ret;
+	}
+
+	ret = cdns_pcie_host_start_link(rc);
+	if (ret)
+		dev_dbg(dev, "PCIe link never came up\n");
+
+	return ret;
+}
+
+int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
+{
+	struct device *dev = rc->pcie.dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge;
+	enum cdns_pcie_rp_bar bar;
+	struct cdns_pcie *pcie;
+	struct resource *res;
+	int ret;
+
+	bridge = pci_host_bridge_from_priv(rc);
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie = &rc->pcie;
+	pcie->is_rc = true;
+
+	rc->vendor_id = 0xffff;
+	of_property_read_u32(np, "vendor-id", &rc->vendor_id);
+
+	rc->device_id = 0xffff;
+	of_property_read_u32(np, "device-id", &rc->device_id);
+
+	if (!pcie->reg_base) {
+		pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
+		if (IS_ERR(pcie->reg_base)) {
+			dev_err(dev, "missing \"reg\"\n");
+			return PTR_ERR(pcie->reg_base);
+		}
+	}
+
+	/* ECAM config space is remapped at glue layer */
+	if (!rc->cfg_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+		rc->cfg_base = devm_pci_remap_cfg_resource(dev, res);
+		if (IS_ERR(rc->cfg_base))
+			return PTR_ERR(rc->cfg_base);
+		rc->cfg_res = res;
+	}
+
+	ret = cdns_pcie_hpa_host_link_setup(rc);
+	if (ret)
+		return ret;
+
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
+		rc->avail_ib_bar[bar] = true;
+
+	ret = cdns_pcie_hpa_host_init(rc);
+	if (ret)
+		return ret;
+
+	if (!bridge->ops)
+		bridge->ops = &cdns_pcie_hpa_host_ops;
+
+	return pci_host_probe(bridge);
+}
diff --git a/drivers/pci/controller/cadence/pcie-cadence-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-hpa.c
new file mode 100644
index 000000000000..7982b40dcfe6
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-hpa.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe controller driver
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include "pcie-cadence.h"
+
+bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie)
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
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
+{
+	u32 delay = 0x3;
+	u32 ltssm_control_cap;
+
+	/*
+	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
+	 */
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
+	/*
+	 * See cdns_pcie_set_outbound_region() comments above.
+	 */
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
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index e09f23427313..882c4aef7ac5 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -12,8 +12,6 @@
 #include <linux/pm_runtime.h>
 #include "pcie-cadence.h"
 
-#define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
-
 /**
  * struct cdns_plat_pcie - private data for this PCIe platform driver
  * @pcie: Cadence PCIe controller
@@ -24,13 +22,8 @@ struct cdns_plat_pcie {
 
 static const struct of_device_id cdns_plat_pcie_of_match[];
 
-static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
-{
-	return cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR;
-}
-
 static const struct cdns_pcie_ops cdns_plat_ops = {
-	.cpu_addr_fixup = cdns_plat_cpu_addr_fixup,
+	.link_up = cdns_pcie_linkup,
 };
 
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
@@ -68,6 +61,11 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
+		rc->pcie.is_rc = data->is_rc;
+
+		/* Store the register bank offsets pointer */
+		rc->pcie.cdns_pcie_reg_offsets = data;
+
 		cdns_plat_pcie->pcie = &rc->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -95,6 +93,11 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
+		ep->pcie.is_rc = data->is_rc;
+
+		/* Store the register bank offset pointer */
+		ep->pcie.cdns_pcie_reg_offsets = data;
+
 		cdns_plat_pcie->pcie = &ep->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 51c9bc4eb174..f86a44efc510 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -9,6 +9,16 @@
 
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
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay = 0x3;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 5c0ea49551c8..3215d4665d89 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -29,6 +29,8 @@ struct cdns_pcie_rp_ib_bar {
 struct cdns_pcie;
 struct cdns_pcie_rc;
 
+bool cdns_pcie_linkup(struct cdns_pcie *pcie);
+
 enum cdns_pcie_msg_routing {
 	/* Route to Root Complex */
 	MSG_ROUTING_TO_RC,
@@ -63,9 +65,9 @@ enum cdns_pcie_reg_bank {
 };
 
 struct cdns_pcie_ops {
-	int	(*start_link)(struct cdns_pcie *pcie);
-	void	(*stop_link)(struct cdns_pcie *pcie);
-	bool	(*link_up)(struct cdns_pcie *pcie);
+	int     (*start_link)(struct cdns_pcie *pcie);
+	void    (*stop_link)(struct cdns_pcie *pcie);
+	bool    (*link_up)(struct cdns_pcie *pcie);
 	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
 };
 
@@ -97,6 +99,7 @@ struct cdns_plat_pcie_of_data {
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
  * @mem_res: start/end offsets in the physical system memory to map PCI accesses
+ * @msg_res: Region for send message to map PCI accesses
  * @dev: PCIe controller
  * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
  * @phy_count: number of supported PHY devices
@@ -109,6 +112,7 @@ struct cdns_plat_pcie_of_data {
 struct cdns_pcie {
 	void __iomem		             *reg_base;
 	struct resource		             *mem_res;
+	struct resource                      *msg_res;
 	struct device		             *dev;
 	bool			             is_rc;
 	int			             phy_count;
@@ -131,6 +135,7 @@ struct cdns_pcie {
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
+ * @ecam_support_flag: Whether the ECAM flag is supported
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -141,6 +146,7 @@ struct cdns_pcie_rc {
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	unsigned int		quirk_retrain_flag:1;
 	unsigned int		quirk_detect_quiet_flag:1;
+	unsigned int            ecam_support_flag:1;
 };
 
 /**
@@ -324,6 +330,29 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
 	return cdns_pcie_read_sz(addr, 0x2);
 }
 
+static inline void cdns_pcie_hpa_rp_writeb(struct cdns_pcie *pcie,
+					   u32 reg, u8 value)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
+	cdns_pcie_write_sz(addr, 0x1, value);
+}
+
+static inline void cdns_pcie_hpa_rp_writew(struct cdns_pcie *pcie,
+					   u32 reg, u16 value)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
+	cdns_pcie_write_sz(addr, 0x2, value);
+}
+
+static inline u16 cdns_pcie_hpa_rp_readw(struct cdns_pcie *pcie, u32 reg)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
+
+	return cdns_pcie_read_sz(addr, 0x2);
+}
+
 /* Endpoint Function register access */
 static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u8 value)
@@ -388,6 +417,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
 void cdns_pcie_host_disable(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
+int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc);
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
@@ -404,6 +434,11 @@ static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
+static inline int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+
 static inline void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
 {
 }
@@ -418,17 +453,24 @@ static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int d
 #if IS_ENABLED(CONFIG_PCIE_CADENCE_EP)
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
 void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep);
+int cdns_pcie_hpa_ep_setup(struct cdns_pcie_ep *ep);
 #else
 static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
 	return 0;
 }
 
+static inline int cdns_pcie_hpa_ep_setup(struct cdns_pcie_ep *ep)
+{
+	return 0;
+}
+
 static inline void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
 {
 }
 #endif
-
+int  cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie);
+int  cdns_pcie_host_start_link(struct cdns_pcie_rc *rc);
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
@@ -441,6 +483,25 @@ void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int  cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int  cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
 
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
+				       u32 r, bool is_io,
+				       u64 cpu_addr, u64 pci_addr, size_t size);
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
+						      u8 busnr, u8 fn,
+						      u32 r, u64 cpu_addr);
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+int  cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc);
+int  cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc);
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
+				   int where);
+int  cdns_pcie_hpa_host_wait_for_link(struct cdns_pcie *pcie);
+int  cdns_pcie_hpa_host_start_link(struct cdns_pcie_rc *rc);
+
+int  cdns_pcie_hpa_start_link(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie);
+bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie);
+
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.49.0


