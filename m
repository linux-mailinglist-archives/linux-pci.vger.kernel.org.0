Return-Path: <linux-pci+bounces-33904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5690BB23F8F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FE734E2DB0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DBA2BF011;
	Wed, 13 Aug 2025 04:27:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023135.outbound.protection.outlook.com [52.101.127.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036828C871;
	Wed, 13 Aug 2025 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059237; cv=fail; b=DYFQzrQWDDU83/fcChJLaEufrQ44XBpZysgPxPXj7N6MosdjNvlU0rdfQxndjnEckbJpOTi/Cd1mGmLBlJ6db+RNOCwXF7XYKQ7zRNH567/TEKaowjgnkF77+doeORDkwgBlEqGt4V/YiJRlAB6EEoIrKig1uzOVZ6cxbFXGcIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059237; c=relaxed/simple;
	bh=69V2T7uRcil22mBSdkQiuCXJDCzRdxErdVkV5vPIVTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YA5obct8a5P/Nk5RQ/TSk7iCRC1jcSpc+BLJhXAPl5FrxHcUSWfOhCsuMac0UFJyGkjeBGeXt4KxRmgwuFIil/58bMvd66SPwkMuSl8ebJu/fVoqIjkt5vLHZgCWWIsnwk4MFOouAnhSZkFAsCSV8T5aedW6cxLhmN8/VzBECX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPuzakptiGoEpcPcvBBQKR75Mmd3xXFL0mM9Mifm+mfR2/k882rtGiiBPJvrd1jpM3YNf7/t7UixNAD92VAwo/Jc+dC45FsT8cmC/57tvqbvM+dzQTeHZ/UkiHaxhWtav8GfVw/8yE1WzgyLVsj3hjiE9T1R1ZrrtEPWmKr17f/cnahQBM+7RruilVbZ17G1VtiCguHvF62jWRu6Hu06mLSJlg4K5sk52iER98tlc6fXTcQOxdcz0GhrczAoSL6X9j9Tq28YClynS9VCJbKZ+1A/uY+dfVRDcValhQcoC7L90upfyhCU2c4Md4Xf4sq1d1HtS6Mswg7/XUI+iY7MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrWw86E33GNNTsWj5dnhdCBZLqZc0QrsSj3x7cqOuMw=;
 b=wXDRBCgplwmJfDm60rI8C+eMPMD3jA4eNOHc5F3i8+UJVfytIWLrWm4avJznXvydmXbNZK+umNN7s8ghjkdwREyiW7dRrk1dLcYsAQOdj90iEBymoRAjLSaOOMoNCglktYzgEQf8Uzw/n+abZmLMMZQe74zoV85Gd4sb3dcXLl+CQdBVmIsRgDrt6rz70B8nhDraOXKfZ1/C09V+MXs7aOHJ+mC52G31z5K/p1dZFrXfomynloU44Ne6wse5NnNuhFAy4vQMLoQ4ILFpa9K64qfavE/5HAKLYi6HctAvpL6b9isBeFW+zTQzHJO+s0fT11h6ESylOINVmelvlPiDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR04CA0006.apcprd04.prod.outlook.com (2603:1096:4:197::13)
 by SE2PPF3C2682CAB.apcprd06.prod.outlook.com (2603:1096:108:1::7cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 04:27:07 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:197:cafe::24) by SI2PR04CA0006.outlook.office365.com
 (2603:1096:4:197::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:05 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 983DB4115DE4;
	Wed, 13 Aug 2025 12:27:04 +0800 (CST)
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
Subject: [PATCH v7 04/13] PCI: cadence: Split PCIe EP support into common and specific functions
Date: Wed, 13 Aug 2025 12:23:22 +0800
Message-ID: <20250813042331.1258272-5-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813042331.1258272-1-hans.zhang@cixtech.com>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|SE2PPF3C2682CAB:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b2855d4f-f596-4ec0-0eb4-08ddda21a8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7VjKr8uXiZuzVZY4Ivw3QpQz4XNyY3qMjTcdb961BZUkY2dk+v4Zdl0kgEg?=
 =?us-ascii?Q?z5sexk4WeCF3VG82NhpYWrdA98fbz3F9QILD1n8kTk0ot+pQc4xH/yU9xidB?=
 =?us-ascii?Q?SKXRZCMAtz1zV3ZwTw2N/PhktleDb/ayGmFsTD+IkWbkKdcUvyGlv5gfRRyT?=
 =?us-ascii?Q?wM4Eto6Iz9/rpRYzthSfe/10QtxHCv/8BCdvLkc9jiLLvUTsbaTILKhg284u?=
 =?us-ascii?Q?+bgChHJXiRKxifLGUURt1aC4Bk5izRSYElEqlgIA8SN0OwZCo8xdW1cZVnmR?=
 =?us-ascii?Q?kXrATZww7ZGjzgWrGMng7gVF4omgkPHFFpNvooxzwbZyUlXhXXUYG7kJMdjU?=
 =?us-ascii?Q?vec4AUfXf2Q4J7UBysapkIjtBLclnS8SSD2p8AC1CuoKTqxHGDAjd8JLoo/U?=
 =?us-ascii?Q?2lX9+JcddkNVqBcC4VUf+vVZD+ieX6oYD0HjpaTWpmBSEJmq0sdp2iffCazx?=
 =?us-ascii?Q?n3Q/xKVRjibD2thAMsNRwglgzA4iTfPJMpB0lZL3x3LdAbwenNriSGnPSJkt?=
 =?us-ascii?Q?juL/Nri0rBbzjvGZOLVX0L/NkOtgi5/eeQ8KtALFvSXOoIMEDYzTZXz+ieL2?=
 =?us-ascii?Q?wu0wdD4cIHjmsIgnRdEXMw9sb6n3HQxrcqBqryA+uI97UMTr/bcjxTZwCm5a?=
 =?us-ascii?Q?9cTDPGhDiEgghIClKkHrsD7bgOIsgEey+txkwimhPvzhi9UiMT3EnE+2M33A?=
 =?us-ascii?Q?63PV0Cu/ZzTRpEBkiDnIiRdRu12gz18wbHdTaMK4A0LJ5NfclDyGPVtYnCUU?=
 =?us-ascii?Q?DCUbflvq/vnhNSF2r76mxb4FmcecLlJJVfw2M19Q5TrjH/DCSDWNgIJWKuuI?=
 =?us-ascii?Q?NgrKb6tT3giuuWnNlF4X9vB0kolfxdCZEB1McOYQ8jLYBsHBqwzSQYKAczHN?=
 =?us-ascii?Q?FVaJTLwp3sAFrK+xdOIlnhcfIHXDJ/z5vvo/TmIOmc7AXDTxAPwLfvVJyO5J?=
 =?us-ascii?Q?U4UlOXb+NfFXUYvokR1Ai6VXszm8n7BJq3qIz4KSt0cHjj/wXCQtqmOiRaYD?=
 =?us-ascii?Q?JXnoCp4rfvK5whJ1tt7MOgrBIi3gSgRCKVvZ4TBYv9UHLZN87gqzoA11/w6b?=
 =?us-ascii?Q?4lJA5/p+TpJ0eizQOHH8PLIBffIt06qCWGaxj8ugl1f25VHNhXKuYNMtydV9?=
 =?us-ascii?Q?Y4dcF6dwUPS7eu7a5hwhyfGkrZ7rWvxigDLa/rCGuDykaOKhkH85S1WxP0qY?=
 =?us-ascii?Q?LFbZdes3q2imOVK7WPPnQVawXfysTCHen+EeMrQQ2jBRmdPSg5nfHX9f7lYp?=
 =?us-ascii?Q?BsDGxQGCovHeILu2H+hRpISE2wXHmVVcnR1b8EISQZH9O3NBQa35OZCcuyW9?=
 =?us-ascii?Q?6plyhJgYgYO7ZJGCyKqtJvNtN4F9x0pbnJ4K2r1NQKKpJGf6RXqP6HGm4YB/?=
 =?us-ascii?Q?EYQ8tAjyeBNIEkYOEYPGsxPxBt094Raa7rg8jLwLu67aA5HlWb+TY1Z568KF?=
 =?us-ascii?Q?pXups3VcpaIkQGdbwe0gJyq6D1ypB5RGXAOkprUQZUmUsSVW4vSAeOZxACSy?=
 =?us-ascii?Q?8ZO5o4op07XIaG6eLBJn9Nn1xVwfHjPD4SIT?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:05.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2855d4f-f596-4ec0-0eb4-08ddda21a8bb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF3C2682CAB

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe controller EP functionality into common
ibrary functions and functions for legacy PCIe EP controller.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../cadence/pcie-cadence-ep-common.c          | 252 ++++++++++++++++++
 .../cadence/pcie-cadence-ep-common.h          |  36 +++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 243 +----------------
 4 files changed, 295 insertions(+), 238 deletions(-)
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
index 000000000000..46a1631e54e5
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe endpoint controller driver common
+// Author: Manikandan K Pillai <mpillai@cadence.com>
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
+MODULE_AUTHOR("Manikandan K Pillai <mpillai@cadence.com>");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-common.h b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
new file mode 100644
index 000000000000..a91084bdedd5
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2017 Cadence
+// Cadence PCIe Endpoint controller driver.
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#ifndef _PCIE_CADENCE_EP_COMMON_H_
+#define _PCIE_CADENCE_EP_COMMON_H_
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
+#endif /* _PCIE_CADENCE_EP_COMMON_H_ */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 77c5a19b2ab1..83204efaea3f 100644
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
@@ -589,12 +381,12 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 				continue;
 
 			value = cdns_pcie_ep_fn_readl(pcie, epf,
-					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
-					PCI_EXP_DEVCAP);
+						      CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
+						      PCI_EXP_DEVCAP);
 			value &= ~PCI_EXP_DEVCAP_FLR;
 			cdns_pcie_ep_fn_writel(pcie, epf,
-					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
-					PCI_EXP_DEVCAP, value);
+					       CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
+					       PCI_EXP_DEVCAP, value);
 		}
 	}
 
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
@@ -759,7 +528,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 
 	return 0;
 
- free_epc_mem:
+free_epc_mem:
 	pci_epc_mem_exit(epc);
 
 	return ret;
-- 
2.49.0


