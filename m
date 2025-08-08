Return-Path: <linux-pci+bounces-33609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8958DB1E389
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A61A02405
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6A2750E9;
	Fri,  8 Aug 2025 07:29:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022096.outbound.protection.outlook.com [40.107.75.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657E23B615;
	Fri,  8 Aug 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638184; cv=fail; b=uUGld/I8Jd+KE0j9nHsal3sO/2kKL3S8FHYlzHxl5NPe3Et/1sfQLgxT6AEdBiaSPv1PUOAPnVqZeR8fP4Z+zj/QtGTS16YAdjZRKlT4WHD71NqAZx4g6GiNNn7V7ADegxvnly4HYQlHK9Akj/b3HZl8ejLqjBQfEoqAQrdSpg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638184; c=relaxed/simple;
	bh=7rvUFDamz8HgP62nF0S/2Mxt/EC0mf99sR7hVEylujk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiBOeN9JjMBEvw4kjaRm8zgHbq8eB/SMTOzqwtjzo6StBOMz6ZbZn9eJxYrwOCohDmd2h3WGh5uY8ByBvzk/hJoNbLOAOgNVq7Ygh/e3gTWZBzKmIV/988Bmuld2KLsx4kikIPN348P/Ly1tS9c+i2SYuCcuRr0+Ky8JIrhi93A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elRbPVES+v4BpYG9h7Puj8QenI/5TchwV5ElRCa4VAqFQhV31cln+Zh5xAnBnRVmZz8OrxTpoRQfPru8XpbaTpl8aYFYTnPaZMf2f1bzXvAMFDXFXMf+0GVvppgdMqn0WCR4jQCkfSe3RieuDWMBtzEfgRivBebm50PFZpLGRRhbKS1u1+6Z3F5ZgNQLN7mCrfQah+t0q6EmjKNfMJ1jR7E5mMh2CG5m+ksRPQgY1clfNGwQKp9rsMoLEO029w5PHnvevzQxkMmLvzMg+7+rSW2qicKY0J4opCPyuzUV53TrNtY6kfspj4jQd1yl4IkVrEdKdXdZQaiRlBxSYOy65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naL0piV24y6eY+H9xJzknvSkcY0cLCnsx9zgk5U+zrY=;
 b=ebv1kPfEB4rcWx9IIQ3e636f4rX3FVgqCUj345ilLlBS9TmBfzz6f1fkXWJZWtysOu6LTNKRBGUftBlhotX07/gfLmi5JghWX7TWT+72NxyLz0o0kuZqS5LGrmR2osw5zUFWbCr+FTkG3UNdwq1UO/jkHBK2rcsh863UeBebr9Dxj1p4PkENoBBNcXn676Y3PnGrqtS75CpQjkI1a9X/ybUwi/BDMELfl5At9eC4cykQivb4wN+XTtHsb4pXPW7NuX3URq3Qt8P7KKru+gQuxRIggtzCJGMs2njriBeOfUFx1iIH9Ok17dEcb2cmzzczM5Y2UnQDxKTOUCew5tUCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:79::14)
 by PUZPR06MB5539.apcprd06.prod.outlook.com (2603:1096:301:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 07:29:36 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:405:79:cafe::e) by TYCP286CA0367.outlook.office365.com
 (2603:1096:405:79::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 07:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:34 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 286694126FFD;
	Fri,  8 Aug 2025 15:29:31 +0800 (CST)
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
Subject: [PATCH v6 03/12] PCI: cadence: Split PCIe EP support into common and specific functions
Date: Fri,  8 Aug 2025 15:29:20 +0800
Message-ID: <20250808072929.4090694-4-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808072929.4090694-1-hans.zhang@cixtech.com>
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|PUZPR06MB5539:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da94f69f-5bea-4665-e89d-08ddd64d52cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6XO7O8vKBho15g95WZ7mdffWV07hFgOlHKxsheCp96hJ4xp9tf5dwAhwZsen?=
 =?us-ascii?Q?4u7SGz3qMnoEbVfgbHk8Lbdm+J6PTT1DL63MVD71z+bZ24TTBkv+OnJHXKUU?=
 =?us-ascii?Q?Rlq4p6HTSFkGye8esjqqBbutLuZfMXAsO9JymKm/7tdms0Ttvv/YEVda0Eef?=
 =?us-ascii?Q?NmrHCgVocki4+hLIC+dTc4/KSTJJIp4Ae7aVZowGWPoTQWHBGJXnsJQHWHAx?=
 =?us-ascii?Q?7np9EVGKHtRZ6/6zJ7jv3bkhHoJ/bfUTho+gJRQixJyC90N5LhaLcoDF8/KL?=
 =?us-ascii?Q?Oxg2Z3ATMppTHs/Z1Bsb6rFnD9ktJPpSyU9TjjrH3Au29vApT97brHxvEU+R?=
 =?us-ascii?Q?gFpuXg4ZmvtNSve6aUHUm1KQS2IVbi6w7tz7i1QVN08HxnydWf9v2czifvHp?=
 =?us-ascii?Q?JDa+rnzP09+lpRY6Ru2gac6u6om0D17NEcwg8WPzxP7I7FsgJu9hOPr9Ur+x?=
 =?us-ascii?Q?VzvHNXo1rlUGb+tfgK3pcV7t1iUOGhQ4D5WC4Mr7snwvOwOc+O4C766TbyKz?=
 =?us-ascii?Q?GvZNGHTdf1qv9xK8AITxWOsf2mDuJt2jLh3kqNDKNsx6fj8clwfaYSkcoJ+0?=
 =?us-ascii?Q?niNaTO6aonEBMR2PDm9dUVVsZbjN0ubb/Q/9f3wWEEJdYbKLEfQ31Q3kZZR1?=
 =?us-ascii?Q?KHep9Ce7GPJfQos8KppMHnVNUB6EUHUUljJ2Hpc1dUTRyUX6knrKq+3vjwVr?=
 =?us-ascii?Q?mSjAWp5B37AW3xHPk+Z/b8iGqxiGYZkqHYrrE/8dC6RfNolwEF+uQhR7G0WH?=
 =?us-ascii?Q?cP7kvkw3v2LNWpHjGJpaR1OJD1nz3R6Vd34Vo43NPvH3CMX+8lKen9eTEZtL?=
 =?us-ascii?Q?TRMjgFTc7tGJpEQHk1NXBrfhu/U7Uz1ajSesPAthNN3GSMA5swRbHtsqfB8f?=
 =?us-ascii?Q?n20/WVBiX1OEib9BjNaUsv7eY6+ep8URsgRbKLHD73JyConY/eeMgGFVX1HK?=
 =?us-ascii?Q?OWtN5wRjLEVfWOaVxNNIFVPUUXHMhdqxVnkOu8RldyNdJPEOI4+MOAFHT1I3?=
 =?us-ascii?Q?oQICZUSEvGb8VPYNvA8X7549yo8JyokisUO6AFB0U6gFPdqkOdwALi2tczHF?=
 =?us-ascii?Q?8hJKvCBLIH3wZP4Ar2Mg2rrC1Zap+2VECtR+FQUgEwQKYgDPXN6h3ZJV1kho?=
 =?us-ascii?Q?unPEg9BiZqhfrqht8PgeGGwnPLX4JO/MIMPP9jou7LKax/TaH/LgjYQL3H4z?=
 =?us-ascii?Q?nGJJmjUneYGMOGfUnGJeTdAJx9ULAGi1jGJjoAGn/iZdp1vNps3YQNMVFHCy?=
 =?us-ascii?Q?ctpRHA/zwqnGf3WTT4gezBBYgNFVx+xknJQD8ORlNupFs3CdC3a1n+3TOJNT?=
 =?us-ascii?Q?4j5jw8VfscK1LSPdAVhRvmzKQ9Pd6Tov1GgkZ/E75S47QkvuTrHS06NvNSNf?=
 =?us-ascii?Q?uGY0a79VmTHnFLrA9YbOwqCfOc+4/eYa2hL3CLabrmsCsRDzw35fhhQDL/vA?=
 =?us-ascii?Q?qnklHsPN++SGYRluc4ZS2HStQMOuD/kiZKHgRL7cKnc2UXEg+QPR1kAsO14C?=
 =?us-ascii?Q?Rjl/HCAVu9/o0KsFD5Mi020xK64KnoHbXSQd?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:34.2393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da94f69f-5bea-4665-e89d-08ddd64d52cc
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5539

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe controller EP functionality into common
library functions and functions for legacy PCIe EP controller.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../cadence/pcie-cadence-ep-common.c          | 240 +++++++++++++++++
 .../cadence/pcie-cadence-ep-common.h          |  36 +++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 243 +-----------------
 4 files changed, 283 insertions(+), 238 deletions(-)
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


