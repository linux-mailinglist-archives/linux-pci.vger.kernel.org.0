Return-Path: <linux-pci+bounces-35255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19071B3DE53
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4894F16360F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ACB30F559;
	Mon,  1 Sep 2025 09:21:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023127.outbound.protection.outlook.com [40.107.44.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423030E849;
	Mon,  1 Sep 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718478; cv=fail; b=goDRFsO8ole1xlUW6D0+c0st02wlJCuk/JqEzFomPJoru+ToJbO/np6jB8jlqoA7mxAsQPpIyv/nBOro3AAEv5PadmOr+CX07KRBM0fR6GdkFHhuHFf5OMJiUjtgUxv/287TokglUOjp344XANVKPrEg7gkv/8MSzVHNDmFDiys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718478; c=relaxed/simple;
	bh=MsnvHc84uA1wRSETvL0D3T+LHadK1bsj8W4j+hHwcSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoDbVfZkRgmqiA9VDau1iGtLcbE3W6d866lKTSPzgVYfWIYEp2I5fAy8F/TYtguBAPMbs4s+5p6aESNuRAHD6UGCHJpia48Gr2Pn1DsRupfFXeMfj5F9/gYx3FtCPf8jmEFn8SxpUGoeAnErcZZUxyca1/YscAwGs2pxpTMI8gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB78Nhk/MBo9Znph1AhXXi7cbEScFUvxxxdXz/eP5rNXo+1O0yxIKJAK5iUoDkQXZwFwstNVjQMb9L9t2zoiAR3RIW+z3ETSF1HEdobix5HpKNJk8FJjLsJZe98FRXoeLLKu0D8iynHrW0ekf1/BNunYbxTr+MQ5X1eJ2iVlKK+6MS3n3AuiYAGTDXHamlb3VhCdNTzP639tOnkVD/h1ijtWO7tgNsEOz0ZKsOlEgllYmNWLG2T2s+rKkvqVdtaVNpinj8eUNJbppUaZEGdZbxZ4i7cD5DcjVlCicWkIXmtmhyMqXSQez238rLQ6d1oVmQH+5uROuLH7UQUEBDSdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlK70XO8cRcdZLOQ9rLaj21Ryn4SabnlA9DObBcktoU=;
 b=XF10EEbN2LC8J+x8lPVBz3Cxs0y+nC7jr9VTxbHtGxoOBH3Uc+LcYcXGlnzCpYFOWW4b39VQaPHZiXhHDai/2mF73Whz6tadEHOTnLP9/XWd1h3FwZbajCia7xTSiT2mwBx8lglSLGns0KJB1/TFO5oc0TYZ/qTjuzW+I7P2+8XlkKbwwaFVGfxmTMxgquelZg/R7AOKsD5H7hnsxOWSyNvx4rwM7NMll0VCqWDl7RfWnOzM5cjSlGjhNtT6gVecqPHGXOC4WWpr8qoKtnRA4q6Uor+GiDXN4NPSp8xASTXpZPaDVuC+waWPwCSlUQqRFhaFY3GWkhTYMihSuYHv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SEWP216CA0001.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2b4::16)
 by SI2PR06MB5266.apcprd06.prod.outlook.com (2603:1096:4:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 09:21:10 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:101:2b4:cafe::ca) by SEWP216CA0001.outlook.office365.com
 (2603:1096:101:2b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:08 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 249DF41C0155;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
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
Subject: [PATCH v9 05/14] PCI: cadence: Move PCIe EP common functions to a separate file
Date: Mon,  1 Sep 2025 17:20:43 +0800
Message-ID: <20250901092052.4051018-6-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|SI2PR06MB5266:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 07433ac6-5f87-42dd-aebf-08dde938e2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1QGvr5QzJbWY3WdtayrBzBqC8DOt0d772OkJ7RUcqPQ3yEjggyr2t9wrbvTq?=
 =?us-ascii?Q?vos5ogc3hbUgNeTr6nsetW+oSr14/rvywHgttEDeQDW88gxPG2Qnt/sRmGRa?=
 =?us-ascii?Q?Ji375pKIdJcOh77PSPy5FO7uk+qLJnJgN35B4Zj/V5iSpHSwxjITn1okY+Ud?=
 =?us-ascii?Q?uBj1OhUu3wku0rhWUX8SgNXpUOkFzbQYK3v8ShMRwK2n4y0AyCeF8p/baTCx?=
 =?us-ascii?Q?dSHeaemPusA5FdLA73aIEHnL+GthIk5vk//zZv0MgbTpbDySIQVB6THGWLeP?=
 =?us-ascii?Q?Y9z7RvSR+o9Qg1R+SENBTretkjOHy/CDiAMc0zwIaNKbk2uaimNvWwYhhlrQ?=
 =?us-ascii?Q?bcx4dg1wG7QZ9RcY6gLKVXECKIRNUjIH8UjkrOCZ8AOFUKo6JV1rN7bGUjVP?=
 =?us-ascii?Q?HCIyLzG3DBQ7Y0BcDaTowpdB0fCQVKJPv3adB0Am5glv1ijN/ZDFEIetF7xv?=
 =?us-ascii?Q?cpNFu/+lvtWee7gSHrGWACIoZ3r0Yr0DYirJHp4jon/qxe1Yfv9FqVSiGlJB?=
 =?us-ascii?Q?wcdHh33TOkRKNZM6N+IKD2+Ri3g477Hf3Xa8OZSbUyKBULaRkBzg6EDw7acV?=
 =?us-ascii?Q?55YVmfPO25AgviBhucnIXDLDwpQ1F243WnUcmriyLAzt3RrQM5U44qPq8yew?=
 =?us-ascii?Q?oRHGGa+pvAcH5FJ9/w/Fe0WjcJ5Kj4uNjhQGAV4woUzB6CXXbznmLDCj6MsX?=
 =?us-ascii?Q?zCXmkre/WBuAcf2hQkvPtxq07vbJU+mOHDCcQ7WD+iir96WHT4ff1nUxMPQB?=
 =?us-ascii?Q?DoXKmrvPpc43u92DUdkPkGZ1+PM1mjyHmNwsuQMicv96HGmcZzlISWtAqiIS?=
 =?us-ascii?Q?5aiQvqwoCCJ3HaBl2CwakVxee2U8d9InOKpMHL4KzJh1judz3Xbew6TI+fYn?=
 =?us-ascii?Q?DNpCjP5nXGAooik/wJkdLdthdqAXChYWczRh4tB3ysVXueQ3uT/SNq7s/0kn?=
 =?us-ascii?Q?k8TEirCD4fzkiV4mRfO8vLIuX1Aed3yw9s1Z0odoOTCTPk6mSHlkOKlTQDDa?=
 =?us-ascii?Q?FIJR1k8Z+AlXQTGuK0TmqgedpqPo/R7uAo+h8LnMWucAO0bgpljyoqodJzeI?=
 =?us-ascii?Q?nekG6YTDK/Vi/Qremnyq+N+Ki+hlL+kHLRx7deF2F+H8AeMAZKL5XS2Ggz7K?=
 =?us-ascii?Q?Uv440PNvKNSr3pEejQD+q3VM9Hnvx66NjNTognN6yuQOEnL7yGF4pdNXYtDj?=
 =?us-ascii?Q?nIWjUVCh8QhbgPIdudRoogQTF6YtFVrESuc5RfNj5M4sUsx6ny4EDkg0O3lO?=
 =?us-ascii?Q?20NUvlKcbzapB0gbL/qUxibXuydUnLg2kyrqazkeEDtU4X3I5iINJEWQRvDR?=
 =?us-ascii?Q?/JTVjrP8xQN6CFt1/6YyMCrHz8s+olsXFMdFLSOtoNByOc2NFqhLscCWuq1/?=
 =?us-ascii?Q?mfwbulbY5J6L05kVTjH8oYbkfn1VravEdHCGkfZVaM/o1t2nojd++yjOJrDj?=
 =?us-ascii?Q?5lEHz0t+omEju95wrw8Z1VEOnruSvowNI9XlE0hwUpiUXaoeVTts6GQIPOhl?=
 =?us-ascii?Q?kJJmuH7DTShRN5eh3znmBViEF2uB7nfcLKZZ?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:08.6984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07433ac6-5f87-42dd-aebf-08dde938e2cc
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5266

From: Manikandan K Pillai <mpillai@cadence.com>

Move the Cadence PCIe controller EP common functions into a separate
file. The common library functions are split from legacy PCIe EP
controller functions.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../cadence/pcie-cadence-ep-common.c          | 253 ++++++++++++++++++
 .../cadence/pcie-cadence-ep-common.h          |  38 +++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 233 +---------------
 4 files changed, 293 insertions(+), 233 deletions(-)
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
index 000000000000..efdab21fd2b5
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe endpoint controller driver common
+ *
+ * Copyright (c) 2017 Cadence
+ * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+ */
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
+	stride = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_STRIDE);
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
+MODULE_DESCRIPTION("Cadence PCIe endpoint controller driver common");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-common.h b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
new file mode 100644
index 000000000000..7363031b5398
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence PCIe Endpoint controller driver
+ *
+ * Copyright (c) 2017 Cadence
+ * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+ */
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


