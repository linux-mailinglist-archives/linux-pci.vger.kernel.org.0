Return-Path: <linux-pci+bounces-31048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E3AAED360
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DFB1738DF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD220D4E1;
	Mon, 30 Jun 2025 04:16:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023081.outbound.protection.outlook.com [40.107.44.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176621D61A3;
	Mon, 30 Jun 2025 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256980; cv=fail; b=nSaAz/mgPlmKmt/U053hBPgAWElzaQyF5l6jTjMjnWD0flxhwBvBJTMXn5FvkpJ23ZTA/IAFKb9ptB2tlP3NyoEkWaBKOZ69VN6uCnPeEQ2/7wNOq5vLXcnoXALiQFF5ioqshcSmbzvSRnE0W0/lO1guqrPH+m/O5QVLIemipEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256980; c=relaxed/simple;
	bh=84bOQyemE+UedLTcn0zHxX98ghwtn2qslcjcSEB0GN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0fl6aKGkFlX9J5AWOm2q6nvA2oPSOG4ZFO41VV/2PqC3k6VORib3cag97jhr9qx2LtgnuB/J+bYVKqvvbXKwI0Vypz7PhbIhnvvx2cbWa2zYxhPH9TfTQ0isJXGMVMnnnkHrUtmZFaky5bOsDAs2wW1tu7x/D2Xdgp79YRCV0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBKbw/JGbVniZ6Co0vW2vqyq1kJ5UsjlO4HxgOARBNrj0L+siasIcOD5y69lMNANxM9/PL2QOPiqnh7OQ8XeOUZ2saHior9BdMI/Y0ASJMNlLJFgHtqK1HDdH4VN7/yjEg6NbdOmo9vt/QX78PFWwFllFWQ/IwihzNV7vzZxOS/LczEpKUTxwDZ25wVc/r7WX4ajQRcRHGQvuyk/FP4ivvXkpyvlGcPDo5DPUos4koanI7Y1dYpRbkaOiHHmB6pitg2x73enRP4LyH7nkLgnKnHlgFFTrER5+zKHDbYbU49up5ZeNcgINu/feDSTqALHgAP+pUdet8+c302l85XAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+leCgYfc/yOhGWZlyaTSwxtsxLqzKmRcRSb1PJp4KC0=;
 b=nwtsY0KVgmX7/cfVjZkA1WQfUfaBXXVcjJY3hs9CwnhSjN2dbnaGGe6Fp0o7VnAeeluE+4FwYCG+CQXzoCHpMXMSHbMAOKZkPsuPv9dBA4pHZ/gzphioFuaWWqFqRF39WrwArMxF9FyR5rVtlByaNGyN22P0Un2f/21E+iUbdvjVtJEL070MHdl8Z0PVaYVQ0dHerGDr/tx/XL87XweDJfJYaTtMY4LQJIGPDThIpt2OKXMlKlUJkXFbyhCsyjb2cieQrikB/m0JdoPlAA1DVJ1af5KU5WBqMol31sfnLpNGJ318co4YuewW/yPuCT5pIwuRvE+92A0h/azjngXySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SE2P216CA0164.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2cb::16)
 by SEZPR06MB7289.apcprd06.prod.outlook.com (2603:1096:101:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 04:16:11 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:101:2cb:cafe::be) by SE2P216CA0164.outlook.office365.com
 (2603:1096:101:2cb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 04:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A3B6541604EA;
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
Subject: [PATCH v5 05/14] PCI: cadence: Split PCIe EP support into common and specific functions
Date: Mon, 30 Jun 2025 12:15:52 +0800
Message-ID: <20250630041601.399921-6-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|SEZPR06MB7289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cd97029e-1c9d-4832-722d-08ddb78cd7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4KJR+iuVJV1U6+2rYkQonp8zSAt0rpJmJMnWdWh5+L+XmRIhK5nY4Vb11RC1?=
 =?us-ascii?Q?ZIqqOVoLLgmoBftV0w9egBK6WBrlWMVc/rAMxqU7Cd/clQ8YM3AnMEhoiMaI?=
 =?us-ascii?Q?J72wyJX/PldHd8F8hhsm81IT0F8CpL+Iln1A1E75yZsnncykvQrSeAXMyxD/?=
 =?us-ascii?Q?80OFhDDBUMrVN6sCm3+gTVJNcqgEZCJp8f4LPXWKA9+ipTcD5IEwrerrALeQ?=
 =?us-ascii?Q?vmdfM+h4VZdppySngBGHDn2m0V3eezumtxKCbnVNM8FnuyLaZc9hNZ7+ApnG?=
 =?us-ascii?Q?5gG8ZZWgG5duk6+Lg7LDZtuDczK/OWRF+N3hra0Q7U8royfIIXyD5ORT6tOJ?=
 =?us-ascii?Q?25DnGakGvaxeEnN5RbSXrgIrzf8/qVmDmVXaKaXvgSeBF9EfeqJ0N7hxecbB?=
 =?us-ascii?Q?0ob9B5bhxpFHtNN8//r+q9hHz+/KtjCMiu/3K0APkl1+YRTuBfdVWQ6JQJh9?=
 =?us-ascii?Q?gMhkAewRoZUna6tzR24vO5fDbypki6ztZqK0CxU70gd0zQOsapq8yuBTmWPc?=
 =?us-ascii?Q?EO7/Y5T1lwKOgq6KsQQpfRURg0lobrS4bLOAJJHoNngucePGkvaO1Ogb/xU9?=
 =?us-ascii?Q?zc8+iEsBsafKtIRHRwgbleqKhgEj1zz5OhJtiV8QzhDe3Qz34XYhSAb0D2TL?=
 =?us-ascii?Q?TKoM4G/buNeDtDskw/pOis1Sx3yjrps+io3/jn/vgln8yZJe6PJafLd2Mdd/?=
 =?us-ascii?Q?gaqfmbkNyG/AzrIdlGo3t4uixZru1bxB/suqEHMeaRZ7qavz1jQfc/4vON71?=
 =?us-ascii?Q?kv4iFpVInOlp3GLLDtnwgfcxg6L5jKF1XzLZ7SKVukvUOH0ahpLqUrFZguQu?=
 =?us-ascii?Q?6LU04gmIi/+bosienqOpryOZ7QIOKT0di6BsTiMV0v9O8t9PpkuFhh2rtmrx?=
 =?us-ascii?Q?/0V46EKHUHA5KqY3ZYV8OF5SpGMrMfgM0LPSM1ws3eMszrDG4pY3l6LUPe3h?=
 =?us-ascii?Q?bleJl2ydtBQ9dhfKnhE0c9ZJR9kG8at/zePX/ekvjwCvLBgrpJeA9+iBYXaA?=
 =?us-ascii?Q?58sXjjCrlrfqJTHdbz/0XLtuRWZb0zr6Y4BVQ6Wv+DQvUUpMAC9oqY6it+KT?=
 =?us-ascii?Q?eIiPbF5CBRjwIewg9GcJoEfHX+LZ9HywLvdWv4MfQZ+XyYjwwAKHZhWFPHtM?=
 =?us-ascii?Q?SwwYxkO2jzh0SwKl8uEuiQweVJdQLpdmcXHKyGtSJBjedG79IDpSOLISgtx4?=
 =?us-ascii?Q?4Kp1OdKq9zdPCwHMJ9YKqsdBMn0YWBhiPgv7q3LZV0uq7FwFnea8cQVLXMem?=
 =?us-ascii?Q?yUUpAm5AumQDJ1+arEnvf2Zd8bRpsk0Flp/DUoAO2YP3u5pCdaB4wi1+cOJ2?=
 =?us-ascii?Q?WjZbRdT0JzcaqYYjuJEj8H7uI/73bLmPA5sVkARXMVjXrqp57Hw63WVj0ZTi?=
 =?us-ascii?Q?D/iO0t24a4SNEVZQqJVEuadKLl+7dOvpwfYPJ0W80/oNF8ZLYW8AUkCKbdNY?=
 =?us-ascii?Q?ITWrzoGUnJuSXgI+GL/wMYl/nYkua1yVu53DcuCUU5R7iSoe9ys6bw7LGxrO?=
 =?us-ascii?Q?V8xV030Mbo4yQSLqbo+8S5RwB/Y1JSNl3+Hu?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:10.0813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd97029e-1c9d-4832-722d-08ddb78cd7fa
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7289

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe controller EP functionality into common
library functions and functions for legacy PCIe EP controller.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig        |   4 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 .../cadence/pcie-cadence-ep-common.c          | 240 +++++++++++++++++
 .../cadence/pcie-cadence-ep-common.h          |  36 +++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 243 +-----------------
 5 files changed, 287 insertions(+), 237 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.h

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 666e16b6367f..417f981ac8ca 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -12,11 +12,15 @@ config PCIE_CADENCE_HOST
 	select IRQ_DOMAIN
 	select PCIE_CADENCE
 
+config PCIE_CADENCE_COMMON
+	bool
+
 config PCIE_CADENCE_EP
 	tristate
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE
+	select PCIE_CADENCE_COMMON
 
 config PCIE_CADENCE_PLAT
 	bool
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 9bac5fb2f13d..918f8c924487 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE_COMMON) += pcie-cadence-ep-common.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-common.c b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
new file mode 100644
index 000000000000..cf5be3b3c981
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
@@ -0,0 +1,240 @@
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
index 8ab6cf70c18e..14c9ec45cc39 100644
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


