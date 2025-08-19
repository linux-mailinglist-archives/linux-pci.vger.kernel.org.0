Return-Path: <linux-pci+bounces-34294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0DCB2C25B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379661885E66
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF823314AF;
	Tue, 19 Aug 2025 11:55:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022085.outbound.protection.outlook.com [40.107.75.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB232C313;
	Tue, 19 Aug 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604519; cv=fail; b=nC+tAB4/w4pPke07EhtSAUCEVs+VB+CUNr3M8IkYc1g7isyJUXLh3k4sKAZLi1E7AN3y49AyHO5h5cCyvPkWloG6xwUj8nQltIsFAnPWCIYhwK7qUt/7svlge4uDh3UY0nxUQ2MDrTZNMBnn7HOuOGxsppzocua3E9NzvixWn6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604519; c=relaxed/simple;
	bh=DHKNDskRPu7/NLeCWmhugpRvp8+tNVJtJs1FrGuMm3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEiLHF8STUtn2lFgVuUfXbMxCKJ2KXRoNRUsFBbQrRIG0Lh9GJ6LMyFKD6/oarESv5ef8n62/FqID63R9oaiCnt/nUhfVE7Sr4LlpIyDYeNIYzYf3U3ghzzjUFFeLwpHyESMqQoRNGTEPMOA18fmX44RCgtHLJUmaF+igC+0y7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aILIjFVaSqMdQzeWpAoBVtJo4WU0V2YWHhHWdFgnv4Bd8g+AteqJtDtCl+NwT5U6sVldE+wStPNUYbx/08B93fUlxwnJiKsxvRir55WuH877IGKIDiC5t4yOV9nycl5IIxmCurHi0QzpJlLD0UOYTOKCDwO3c/YwrSF1z8czk7lS9cRmqYdPdfwEvKgAqPi4h+BHuMUEyefFvlfWjE5RrXXRIFLs8FzBHMAVix3XBwhWoL817KbfW2fHeD7+hcWyWVjO21cG9Sd5wP29jyOr4K2/5tN0Eir/WcUc7fojrX3QLD40uERDX8m5uC1/YRqu8rUKzCEfcmIYVXn/dkAKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NEmnshQEVL9mon/o+RCd+ZRG7V7v5Q9QB68O1nVUD8=;
 b=uk0WTg9GxjTO5iRwk68Z3lCXfZ9xGdAVVF+vLaAMLTjhvpqC5USSzqFvMOqtfG92/1xXTWY6GUAk2MgpXvu3Gl8MLwJbwby8qWlM4azAjotSYuzkBxM2kKbJ1KbV6zv+7PkpX72UqUJGa3ZOQmy0D5zcp/diFL3ObAEXtq9Vnsm9V6gJmt8t1zSfmesgbB2SfaR7D5UoPyL9udeh6SkDnQtggQT3FTsZzuwIAeupt7peoChZbH6GiLh9KUEXrugsSMXV1s5CzUCeZmzsO1VXVj4AU+IKGnJwY/7RUAcRnM63mreXkSEiyPrsTV0vvJBzrGnnk62GtyzbNISPLhBONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0088.apcprd02.prod.outlook.com (2603:1096:4:90::28) by
 TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 11:55:12 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:90:cafe::de) by SG2PR02CA0088.outlook.office365.com
 (2603:1096:4:90::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 11:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9E59841604E9;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
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
Subject: [PATCH v8 05/15] PCI: cadence: Move PCIe EP common functions to a separate file
Date: Tue, 19 Aug 2025 19:52:29 +0800
Message-ID: <20250819115239.4170604-6-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|TYZPR06MB6697:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 743ee4cd-3ab0-430f-a7aa-08dddf173fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yUz8POsrxqHM10P6ikd1PHXcmgY0GjPz51pkMDkbNAax9dcjUfnkh1mHOWbP?=
 =?us-ascii?Q?Xy8XRBvVCepL1I4aMXYU7r3aOb44LXgDwkzoSE+m/csx5HWMTuAi0TH0ZjGU?=
 =?us-ascii?Q?LVEDxc8cwn2HiFQNiuVLzS1TIcF6Gf2z7aYb+EOW1MYeAolTNBES7b7HhHBQ?=
 =?us-ascii?Q?R5Hnb8BaslPxhe+IvykbtEKPpEf1F3KJpiA0veYHg+qfMLbY8sqYWrrwfdww?=
 =?us-ascii?Q?27MEz4ynMA8IGqr5LTiWB2kqZLVpprymY6CDrs59x99fdgjdX1cXitzIj2Fa?=
 =?us-ascii?Q?lFs76g1SrlLuVA3us+IBtDpzBhVjcR4iy0l36OX3Ngzyf4/jEzJnuFWghQlp?=
 =?us-ascii?Q?Z/WCLw/Ga4tzlDQpEO4tqfOS+rVIK2dNB+V2ZvPo3Z8LBXzyEvt2WnaKRm/3?=
 =?us-ascii?Q?rrxQmYyBTF8msHsVRBUaWWpXRmWDgEMLisfs4gZ/X2RxI8mdoh712c6+ojZh?=
 =?us-ascii?Q?9qkd9NMwTreoip78eihVRb80+NZESTN7OEw82ng7QiSZob5CGOqQXs+0bLvY?=
 =?us-ascii?Q?MrdRZ0VH6G7K02YVBrKUHnKlBqELXNKIa2ghk5rq/ZE/IM+UrUDI0ZeIwFV/?=
 =?us-ascii?Q?HljJV0SEqHstI0Sz7gUwaieJxcS4QlVnVXRaFa6hgwN4kaDYxPJbFSU/l/M6?=
 =?us-ascii?Q?RzwrLA7/m7xwdYC0ckV5Xr3tp79Kk8U0SeuQWuXffHaVRY52/Da3OvW8sNZY?=
 =?us-ascii?Q?Q2cF4pl9sCvkNuV0N5pL6EzM+Iq9F54w0eqBvHpxlnHBvd7SeRITEyvOMl4S?=
 =?us-ascii?Q?hTbO1fLqcnhpvW8tGM+oVBs96RaQN/LC5ZooS6Jo2hro4TYpi9bi1n1LKNpC?=
 =?us-ascii?Q?kyOn1Ebzlprw50ePxA1cwqPV1teXQ1DKG0c1syXidhoBEu8s77F/oHbi14am?=
 =?us-ascii?Q?xozI8Y4SJ+Kr3Kvy8Mphkwo3mcio6w/3ADWRq+UgtpIYZEPgP9/dOw3G9ZHL?=
 =?us-ascii?Q?Y5w+roOSXZRkKXd0oS1EG3PQRSF0WzPMPdjz/RtfZeB6f8P61A+UaYDP+wKC?=
 =?us-ascii?Q?3SXVeSiraCVir/ukDz3jY/he0QMvnSdqxPDj4+7J9i7H26unBOid7GZlL6pr?=
 =?us-ascii?Q?tWn4o1MXKgs9yGOfBCrNuHcp5bi14EIha3F3OQV1i2JZnrvRf2WOlPnvwYVH?=
 =?us-ascii?Q?KPASmtdt79/miLpof+uqL/ovpa5WUbfHWj0w60LJLnvNc5nPW3ofA/byRkhH?=
 =?us-ascii?Q?ey8dTtY0wRAnl4S/akOjjhU922LmhXpLvExzLeR8Tr3w3F6FDqpXB/J5m4mH?=
 =?us-ascii?Q?FBHmvTlEka4JPRwuJWqYIN/U73350gVcpQbYYJr1hc0AcaPPJAUxL7pqndqg?=
 =?us-ascii?Q?E6tZC696CtBkXf1Aa3bcccdjdvE7MJ/sZp3WqmDtcJI9ZPk4UKthV6oiKwn6?=
 =?us-ascii?Q?UnwNw/WMfplBLwlUoo3+FuYzeRg0XwgCbrxnlrGtbG3kT4dgrkUAUNqotSSQ?=
 =?us-ascii?Q?ZXusiVyVNxZPZpEWNb2m45p21hSLweBaWeKN03Hzsk1+kwL2iKXrKNteANBM?=
 =?us-ascii?Q?ZNSlR4j+SOLtBRwYI/NooGEn/UsHWBz1ypns?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:10.2316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743ee4cd-3ab0-430f-a7aa-08dddf173fcd
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6697

From: Manikandan K Pillai <mpillai@cadence.com>

Move the Cadence PCIe controller EP common functions into a separate
file. The common library functions are split from legacy PCIe EP controller
functions.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../cadence/pcie-cadence-ep-common.c          | 251 ++++++++++++++++++
 .../cadence/pcie-cadence-ep-common.h          |  36 +++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 233 +---------------
 4 files changed, 289 insertions(+), 233 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.h

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 9bac5fb2f13d..80c1c4be7e80 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
-obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
+obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-common.c b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
new file mode 100644
index 000000000000..2a3f01aacc46
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe endpoint controller driver common
+// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+
+#include "pcie-cadence.h"
+#include "pcie-cadence-ep-common.h"
+
+u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn)
+{
+	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
+	u32 first_vf_offset, stride;
+
+	if (vfn == 0)
+		return fn;
+
+	first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_OFFSET);
+	stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +  PCI_SRIOV_VF_STRIDE);
+	fn = fn + first_vf_offset + ((vfn - 1) * stride);
+
+	return fn;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_get_fn_from_vfn);
+
+int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
+			      struct pci_epf_header *hdr)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 reg;
+
+	if (vfn > 1) {
+		dev_err(&epc->dev, "Only Virtual Function #1 has deviceID\n");
+		return -EINVAL;
+	} else if (vfn == 1) {
+		reg = cap + PCI_SRIOV_VF_DID;
+		cdns_pcie_ep_fn_writew(pcie, fn, reg, hdr->deviceid);
+		return 0;
+	}
+
+	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
+	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
+	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CLASS_PROG, hdr->progif_code);
+	cdns_pcie_ep_fn_writew(pcie, fn, PCI_CLASS_DEVICE,
+			       hdr->subclass_code | hdr->baseclass_code << 8);
+	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CACHE_LINE_SIZE,
+			       hdr->cache_line_size);
+	cdns_pcie_ep_fn_writew(pcie, fn, PCI_SUBSYSTEM_ID, hdr->subsys_id);
+	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_INTERRUPT_PIN, hdr->interrupt_pin);
+
+	/*
+	 * Vendor ID can only be modified from function 0, all other functions
+	 * use the same vendor ID as function 0.
+	 */
+	if (fn == 0) {
+		/* Update the vendor IDs. */
+		u32 id = CDNS_PCIE_LM_ID_VENDOR(hdr->vendorid) |
+			 CDNS_PCIE_LM_ID_SUBSYS(hdr->subsys_vendor_id);
+
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_write_header);
+
+int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	u16 flags;
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+
+	/*
+	 * Set the Multiple Message Capable bitfield into the Message Control
+	 * register.
+	 */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
+	flags = (flags & ~PCI_MSI_FLAGS_QMASK) | (mmc << 1);
+	flags |= PCI_MSI_FLAGS_64BIT;
+	flags &= ~PCI_MSI_FLAGS_MASKBIT;
+	cdns_pcie_ep_fn_writew(pcie, fn, cap + PCI_MSI_FLAGS, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_set_msi);
+
+int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	u16 flags, mme;
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+
+	/* Validate that the MSI feature is actually enabled. */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
+	if (!(flags & PCI_MSI_FLAGS_ENABLE))
+		return -EINVAL;
+
+	/*
+	 * Get the Multiple Message Enable bitfield from the Message Control
+	 * register.
+	 */
+	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
+
+	return mme;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_get_msi);
+
+int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
+	u32 val, reg;
+
+	func_no = cdns_pcie_get_fn_from_vfn(pcie, func_no, vfunc_no);
+
+	reg = cap + PCI_MSIX_FLAGS;
+	val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
+	if (!(val & PCI_MSIX_FLAGS_ENABLE))
+		return -EINVAL;
+
+	val &= PCI_MSIX_FLAGS_QSIZE;
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_get_msix);
+
+int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
+			  u16 interrupts, enum pci_barno bir,
+			  u32 offset)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
+	u32 val, reg;
+
+	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+
+	reg = cap + PCI_MSIX_FLAGS;
+	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
+	val &= ~PCI_MSIX_FLAGS_QSIZE;
+	val |= interrupts;
+	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
+
+	/* Set MSI-X BAR and offset */
+	reg = cap + PCI_MSIX_TABLE;
+	val = offset | bir;
+	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
+
+	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
+	reg = cap + PCI_MSIX_PBA;
+	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_set_msix);
+
+int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
+			     phys_addr_t addr, u8 interrupt_num,
+			     u32 entry_size, u32 *msi_data,
+			     u32 *msi_addr_offset)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	struct cdns_pcie *pcie = &ep->pcie;
+	u64 pci_addr, pci_addr_mask = 0xff;
+	u16 flags, mme, data, data_mask;
+	u8 msi_count;
+	int ret;
+	int i;
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
+	data = data & ~data_mask;
+
+	/* Get the PCI address where to write the data into. */
+	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
+	pci_addr <<= 32;
+	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
+	pci_addr &= GENMASK_ULL(63, 2);
+
+	for (i = 0; i < interrupt_num; i++) {
+		ret = epc->ops->map_addr(epc, fn, vfn, addr,
+					 pci_addr & ~pci_addr_mask,
+					 entry_size);
+		if (ret)
+			return ret;
+		addr = addr + entry_size;
+	}
+
+	*msi_data = data;
+	*msi_addr_offset = pci_addr & pci_addr_mask;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_map_msi_irq);
+
+static const struct pci_epc_features cdns_pcie_epc_vf_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = true,
+	.align = 65536,
+};
+
+static const struct pci_epc_features cdns_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = true,
+	.align = 256,
+};
+
+const struct pci_epc_features*
+cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
+{
+	if (!vfunc_no)
+		return &cdns_pcie_epc_features;
+
+	return &cdns_pcie_epc_vf_features;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_ep_get_features);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe controller driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-common.h b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
new file mode 100644
index 000000000000..9bc9f4b52427
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2017 Cadence
+// Cadence PCIe Endpoint controller driver
+// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+
+#ifndef _PCIE_CADENCE_EP_COMMON_H
+#define _PCIE_CADENCE_EP_COMMON_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-epc.h>
+#include "../../pci.h"
+
+#define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
+#define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
+#define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
+
+u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn);
+int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
+			      struct pci_epf_header *hdr);
+int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc);
+int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn);
+int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
+			  u16 interrupts, enum pci_barno bir,
+			  u32 offset);
+int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
+			     phys_addr_t addr, u8 interrupt_num,
+			     u32 entry_size, u32 *msi_data,
+			     u32 *msi_addr_offset);
+const struct pci_epc_features *cdns_pcie_ep_get_features(struct pci_epc *epc,
+							 u8 func_no,
+							 u8 vfunc_no);
+
+#endif /* _PCIE_CADENCE_EP_COMMON_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 77c5a19b2ab1..747d83ed2ad3 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -13,68 +13,7 @@
 #include <linux/sizes.h>
 
 #include "pcie-cadence.h"
-#include "../../pci.h"
-
-#define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
-#define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
-#define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
-
-static u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn)
-{
-	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
-	u32 first_vf_offset, stride;
-
-	if (vfn == 0)
-		return fn;
-
-	first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_OFFSET);
-	stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +  PCI_SRIOV_VF_STRIDE);
-	fn = fn + first_vf_offset + ((vfn - 1) * stride);
-
-	return fn;
-}
-
-static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
-				     struct pci_epf_header *hdr)
-{
-	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
-	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
-	struct cdns_pcie *pcie = &ep->pcie;
-	u32 reg;
-
-	if (vfn > 1) {
-		dev_err(&epc->dev, "Only Virtual Function #1 has deviceID\n");
-		return -EINVAL;
-	} else if (vfn == 1) {
-		reg = cap + PCI_SRIOV_VF_DID;
-		cdns_pcie_ep_fn_writew(pcie, fn, reg, hdr->deviceid);
-		return 0;
-	}
-
-	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
-	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
-	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CLASS_PROG, hdr->progif_code);
-	cdns_pcie_ep_fn_writew(pcie, fn, PCI_CLASS_DEVICE,
-			       hdr->subclass_code | hdr->baseclass_code << 8);
-	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CACHE_LINE_SIZE,
-			       hdr->cache_line_size);
-	cdns_pcie_ep_fn_writew(pcie, fn, PCI_SUBSYSTEM_ID, hdr->subsys_id);
-	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_INTERRUPT_PIN, hdr->interrupt_pin);
-
-	/*
-	 * Vendor ID can only be modified from function 0, all other functions
-	 * use the same vendor ID as function 0.
-	 */
-	if (fn == 0) {
-		/* Update the vendor IDs. */
-		u32 id = CDNS_PCIE_LM_ID_VENDOR(hdr->vendorid) |
-			 CDNS_PCIE_LM_ID_SUBSYS(hdr->subsys_vendor_id);
-
-		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
-	}
-
-	return 0;
-}
+#include "pcie-cadence-ep-common.h"
 
 static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				struct pci_epf_bar *epf_bar)
@@ -222,100 +161,6 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	clear_bit(r, &ep->ob_region_map);
 }
 
-static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 nr_irqs)
-{
-	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
-	struct cdns_pcie *pcie = &ep->pcie;
-	u8 mmc = order_base_2(nr_irqs);
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
-	u16 flags;
-
-	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
-
-	/*
-	 * Set the Multiple Message Capable bitfield into the Message Control
-	 * register.
-	 */
-	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
-	flags = (flags & ~PCI_MSI_FLAGS_QMASK) | (mmc << 1);
-	flags |= PCI_MSI_FLAGS_64BIT;
-	flags &= ~PCI_MSI_FLAGS_MASKBIT;
-	cdns_pcie_ep_fn_writew(pcie, fn, cap + PCI_MSI_FLAGS, flags);
-
-	return 0;
-}
-
-static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
-{
-	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
-	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
-	u16 flags, mme;
-
-	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
-
-	/* Validate that the MSI feature is actually enabled. */
-	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
-	if (!(flags & PCI_MSI_FLAGS_ENABLE))
-		return -EINVAL;
-
-	/*
-	 * Get the Multiple Message Enable bitfield from the Message Control
-	 * register.
-	 */
-	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
-
-	return 1 << mme;
-}
-
-static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
-{
-	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
-	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
-	u32 val, reg;
-
-	func_no = cdns_pcie_get_fn_from_vfn(pcie, func_no, vfunc_no);
-
-	reg = cap + PCI_MSIX_FLAGS;
-	val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
-	if (!(val & PCI_MSIX_FLAGS_ENABLE))
-		return -EINVAL;
-
-	val &= PCI_MSIX_FLAGS_QSIZE;
-
-	return val + 1;
-}
-
-static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
-				 u16 nr_irqs, enum pci_barno bir, u32 offset)
-{
-	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
-	struct cdns_pcie *pcie = &ep->pcie;
-	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
-	u32 val, reg;
-
-	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
-
-	reg = cap + PCI_MSIX_FLAGS;
-	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
-	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= nr_irqs - 1; /* encoded as N-1 */
-	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
-
-	/* Set MSI-X BAR and offset */
-	reg = cap + PCI_MSIX_TABLE;
-	val = offset | bir;
-	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
-
-	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
-	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
-	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
-
-	return 0;
-}
-
 static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 				     bool is_asserted)
 {
@@ -426,59 +271,6 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 	return 0;
 }
 
-static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
-				    phys_addr_t addr, u8 interrupt_num,
-				    u32 entry_size, u32 *msi_data,
-				    u32 *msi_addr_offset)
-{
-	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
-	struct cdns_pcie *pcie = &ep->pcie;
-	u64 pci_addr, pci_addr_mask = 0xff;
-	u16 flags, mme, data, data_mask;
-	u8 msi_count;
-	int ret;
-	int i;
-
-	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
-
-	/* Check whether the MSI feature has been enabled by the PCI host. */
-	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
-	if (!(flags & PCI_MSI_FLAGS_ENABLE))
-		return -EINVAL;
-
-	/* Get the number of enabled MSIs */
-	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
-	msi_count = 1 << mme;
-	if (!interrupt_num || interrupt_num > msi_count)
-		return -EINVAL;
-
-	/* Compute the data value to be written. */
-	data_mask = msi_count - 1;
-	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
-	data = data & ~data_mask;
-
-	/* Get the PCI address where to write the data into. */
-	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
-	pci_addr <<= 32;
-	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
-	pci_addr &= GENMASK_ULL(63, 2);
-
-	for (i = 0; i < interrupt_num; i++) {
-		ret = cdns_pcie_ep_map_addr(epc, fn, vfn, addr,
-					    pci_addr & ~pci_addr_mask,
-					    entry_size);
-		if (ret)
-			return ret;
-		addr = addr + entry_size;
-	}
-
-	*msi_data = data;
-	*msi_addr_offset = pci_addr & pci_addr_mask;
-
-	return 0;
-}
-
 static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				      u16 interrupt_num)
 {
@@ -607,29 +399,6 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
-static const struct pci_epc_features cdns_pcie_epc_vf_features = {
-	.linkup_notifier = false,
-	.msi_capable = true,
-	.msix_capable = true,
-	.align = 65536,
-};
-
-static const struct pci_epc_features cdns_pcie_epc_features = {
-	.linkup_notifier = false,
-	.msi_capable = true,
-	.msix_capable = true,
-	.align = 256,
-};
-
-static const struct pci_epc_features*
-cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
-{
-	if (!vfunc_no)
-		return &cdns_pcie_epc_features;
-
-	return &cdns_pcie_epc_vf_features;
-}
-
 static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.write_header	= cdns_pcie_ep_write_header,
 	.set_bar	= cdns_pcie_ep_set_bar,
-- 
2.49.0


