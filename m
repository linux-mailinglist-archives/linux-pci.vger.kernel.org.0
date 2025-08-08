Return-Path: <linux-pci+bounces-33603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACA8B1E357
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A899018A3FAD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E6623C8AA;
	Fri,  8 Aug 2025 07:29:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023135.outbound.protection.outlook.com [52.101.127.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5623AB8A;
	Fri,  8 Aug 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638182; cv=fail; b=WY5dHg6sGn+DzYV9ZAnA0FfoyN6hl9S47Ef5jMKhnef9P189Cz4dkyntdNppGrQle1UWfDa8eOLisGMj8vGxbCmdvsk41r+uhF07SGArbXS4sMYgutNB136o39RLJNivfoQ2q39zRz7/maPSv2gWvjyGnQW1V5lFGsLPtuA7BxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638182; c=relaxed/simple;
	bh=X7Lpiv5jtNGgVxNkHhKfRHwVdrK/5rII97ijF9qMoSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/dHdlF6KPuWUbbHuHuMraTbejhndMyvFp+eRPRJJztYA7fF7tYVWrTR541ERFK7RigSQ7bnIvTc57t3cHVkEYy3EJczgpOL/bMQIqKOvC7tgeAwnO1PgJ2zeSMS6a7WdF8Tm52blwAKyiyQyrKARE5dq1WYcYJu1UFg2ukPUQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0k+1F9A+6/QuuG2Q9UKhWFz1lsUoRfqvNHJFoAOL/djGalBsm4/Yp1eAiTJ+5BclkHUcBSL4D5eNVJ8pUZ425DJkVeMpKTSC8n7aX0O16uYHAi3tFIEJQXTFb9+z1JZrjcN8QBmjOiHRIvFBwY4vWC/1bnnZqz/ZkgmyNOoMwpLCpIX/00g4jrR6+yUOCVZaRYq84vTzEcKoBihQteYya19ZHmdT45QfECaiDMNp71Hv3lQ6lug9UIFyXsYfyS95hxSCxeiCUkryl72iswIFKcng/tE3xggOt3zT90S2Cqf4SMGXRTdwjkrhFlt7gQKhA1KrIA6F0MG+bIlZyCJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/srJqq/+EOYVSwVA3sS9gpmnbAUWhYUbj86GblsBUGc=;
 b=y/q7Gx4f9L2fN5zdIlu+l62pfogJ3OJ590o1rpx4mkIU7l99C0yfTU6fJt9+dIjb6XUeX9u9r3N3IsnPUCVSliWJfrFH3FCmYxlJzisqkfxjdLbvFuc8IR5MSC4edbE8rJg/XqbRVhCQ1T6jomeeHZvRPgz7suPEq4DTjLZzgWUvc2S/LdbzKJCBllXdiCpa097zRebBiYMMHpR4xT3K1SB0xWTfDfGb16HizHPlRa3/bG7/C8Bd5/2CP5ykEyA8EljXwZohLms4MkXdKy3fwFPT4FoaoikgcZYYrXWnjeojWc2+57DIWH0YUeVY+GVdoOp2aMjtQGiqnoT/ENvcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0007.apcprd02.prod.outlook.com (2603:1096:4:194::23)
 by SEYPR06MB6430.apcprd06.prod.outlook.com (2603:1096:101:16a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 07:29:34 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:194:cafe::b4) by SI2PR02CA0007.outlook.office365.com
 (2603:1096:4:194::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Fri,
 8 Aug 2025 07:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:32 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 396C84143A8D;
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
Subject: [PATCH v6 04/12] PCI: cadence: Split PCIe RP support into common and specific functions
Date: Fri,  8 Aug 2025 15:29:21 +0800
Message-ID: <20250808072929.4090694-5-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SEYPR06MB6430:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 91c3a0e9-5c67-48d2-2697-08ddd64d51f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DFj5nIJXmrcsbU2a0PHJRBCH1DOAOMOg2jvFltxZG5iUmkK/etcpkq3ENrFK?=
 =?us-ascii?Q?6pja8BCcIDg6nkKNFCkaJ1SpeJ6jNqSC0tu7aH73ne3tvPIXz9mwFfHYAlL+?=
 =?us-ascii?Q?6w/3WnawN+fZGWPvRe3VBV1RGnMaLgP6tY7gJcuxfgGoSqf2jbWG+rgT/c1h?=
 =?us-ascii?Q?uGvsdyGjiT2QlsKBd51DUmKA7H4Z3nZ0JvHN9TzKddtMAhH/7m9WEjUoejR9?=
 =?us-ascii?Q?LWvacSmG+TECEp8Rky8iqTm69GQ+LZV596SAsZB6fytsibSEiQRZ0ivI6N9r?=
 =?us-ascii?Q?yxq71f1FJrBe1N3P5XvNBCr7CbYZCEXIto6rdjdSY/OauTSrW/XVY/wwaA3J?=
 =?us-ascii?Q?uV0sQN/T/MB6mYxvHlaiDXtfWvDLw9qcxUs1gD8DIIlVBLRhCh3AWjBtYNOx?=
 =?us-ascii?Q?8OpPJf99sC59rRsfoAmtCjdnQkOvkJKgZSd7rOI0ooBwkhUokwhNT04xzCLJ?=
 =?us-ascii?Q?7JGxSDg26fUyT92pHWyPgVMZuJQ5TpZDhzWO+Y3kD8eHcjlj8/jV9a1K+Gnu?=
 =?us-ascii?Q?yNjAYeqeoPK5QAI/3/tGMxJZ1KQ1x3U9qyMrXtmmYnVTjtOLu2v33dksBpXk?=
 =?us-ascii?Q?CNgFdKltcIUIlsfjeMSzuAiBum78PjCZqCeEtuVJDGQ4oYtj2o2XcIS9SKjs?=
 =?us-ascii?Q?0uawO5RKVL3xj6MAcy6x1s+D3XBUPFUDmSTJoaLujmETkHcnwKulcJG2qXjH?=
 =?us-ascii?Q?O0SWYmnPxL4O02LYeUGL94O3VdK+fhxUrsJkQ+GHzYFrvNHLBtmpRqgm33vI?=
 =?us-ascii?Q?7ujlUMfnrkRzkjizd5NHiVeYrhKgLiX85J1JYk+uQld3CPLnuvr+pveIdONi?=
 =?us-ascii?Q?/37GvR4/TnDJcoJ4sujmAaZqIOtTtr07iPOfXvGAqJmj2Ml1Yg6HcOacBwmt?=
 =?us-ascii?Q?STosEZUq1UNYT8Stg3YNDsYwGXJBPyUWfWNMvNJ0Y1Fb2BRUYumyGk2RlJ1o?=
 =?us-ascii?Q?XsOK01kc42U3SPvW2S6cLukcz6ayLoKR0K9wD3t2dMDaFXf++nHnwJG6+m9e?=
 =?us-ascii?Q?8lnymjGWxmmzsO7d6rrIfyCWHdgb/vuGxlgKYEvKXYKZPHa6Hi3z5bwmpxdb?=
 =?us-ascii?Q?WzDpPO27T0cOl5P4NbKoTgW2qzZqkbb1ApXS+j1MTuaQg7ysYa5lc0GAkCnn?=
 =?us-ascii?Q?v7L9kjbTs5IZX8nQwL6L8lWNGvsbJqebwuBghqFfBPuqnLe6Vpj3TqM/MmLr?=
 =?us-ascii?Q?4oehcHsUjKx+Aye1zuYWERQ3EMyX+k1pb97U392TqEVIFeFETZgISCuMGT7d?=
 =?us-ascii?Q?8quyLH4XwrC2rWZEBdmeQH9wyg0ZvIs5pjcKCHIgac9zRVooadyMaYD+Ugrd?=
 =?us-ascii?Q?VpYJVkkrgyEWJdh0DRJ7oQE2WpLXZt0uHFITKI7j/24Xlrd87A1H/rse1AO1?=
 =?us-ascii?Q?0sup1y4LuMlVVM/LK6u88XWklUWH7ZyQGK9elwQ6zMPIgvelZzCDHITWW15p?=
 =?us-ascii?Q?WLEjgaBwqKuwbAXm894q0u6noPRqRphzjtCF3FLAW4oOtLZcphtfei1JrsRa?=
 =?us-ascii?Q?l76cQe8mIU+yOO98yaiTZHb914FZHra6saRw?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:32.9858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c3a0e9-5c67-48d2-2697-08ddd64d51f3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6430

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe controller RP functionality into common
functions and functions for legacy PCIe RP controller.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig        |   8 +
 drivers/pci/controller/cadence/Makefile       |   4 +-
 .../cadence/pcie-cadence-ep-common.h          |   8 +-
 .../cadence/pcie-cadence-host-common.c        | 169 ++++++++++++++++++
 .../cadence/pcie-cadence-host-common.h        |  25 +++
 .../controller/cadence/pcie-cadence-host.c    | 156 +---------------
 6 files changed, 210 insertions(+), 160 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 666e16b6367f..a1caf154888d 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -6,17 +6,25 @@ menu "Cadence-based PCIe controllers"
 config PCIE_CADENCE
 	tristate
 
+config PCIE_CADENCE_EP_COMMON
+	bool
+
+config PCIE_CADENCE_HOST_COMMON
+	bool
+
 config PCIE_CADENCE_HOST
 	tristate
 	depends on OF
 	select IRQ_DOMAIN
 	select PCIE_CADENCE
+	select PCIE_CADENCE_HOST_COMMON
 
 config PCIE_CADENCE_EP
 	tristate
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE
+	select PCIE_CADENCE_EP_COMMON
 
 config PCIE_CADENCE_PLAT
 	bool
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 80c1c4be7e80..0440ac6aba5d 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE_EP_COMMON) += pcie-cadence-ep-common.o
+obj-$(CONFIG_PCIE_CADENCE_HOST_COMMON) += pcie-cadence-host-common.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
-obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
+obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep-common.h b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
index a91084bdedd5..9cfd0cfa7459 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (c) 2017 Cadence
-// Cadence PCIe Endpoint controller driver.
+// Cadence PCIe Endpoint controller driver
 // Author: Manikandan K Pillai <mpillai@cadence.com>
 
-#ifndef _PCIE_CADENCE_EP_COMMON_H_
-#define _PCIE_CADENCE_EP_COMMON_H_
+#ifndef _PCIE_CADENCE_EP_COMMON_H
+#define _PCIE_CADENCE_EP_COMMON_H
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -33,4 +33,4 @@ const struct pci_epc_features *cdns_pcie_ep_get_features(struct pci_epc *epc,
 							 u8 func_no,
 							 u8 vfunc_no);
 
-#endif /* _PCIE_CADENCE_EP_COMMON_H_ */
+#endif /* _PCIE_CADENCE_EP_COMMON_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
new file mode 100644
index 000000000000..21264247951e
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -0,0 +1,169 @@
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
+#define LINK_RETRAIN_TIMEOUT HZ
+
+u64 bar_max_size[] = {
+	[RP_BAR0] = _ULL(128 * SZ_2G),
+	[RP_BAR1] = SZ_2G,
+	[RP_NO_BAR] = _BITULL(63),
+};
+
+int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
+{
+	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	unsigned long end_jiffies;
+	u16 lnk_stat;
+
+	/* Wait for link training to complete. Exit after timeout. */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+			break;
+		usleep_range(0, 1000);
+	} while (time_before(jiffies, end_jiffies));
+
+	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
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
+
+	return -ETIMEDOUT;
+}
+
+int cdns_pcie_retrain(struct cdns_pcie *pcie)
+{
+	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u16 lnk_stat, lnk_ctl;
+	int ret = 0;
+
+	/*
+	 * Set retrain bit if current speed is 2.5 GB/s,
+	 * but the PCIe root port support is > 2.5 GB/s.
+	 */
+
+	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
+					     PCI_EXP_LNKCAP));
+	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
+		return ret;
+
+	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
+		lnk_ctl = cdns_pcie_rp_readw(pcie,
+					     pcie_cap_off + PCI_EXP_LNKCTL);
+		lnk_ctl |= PCI_EXP_LNKCTL_RL;
+		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
+				    lnk_ctl);
+
+		ret = cdns_pcie_host_training_complete(pcie);
+		if (ret)
+			return ret;
+
+		ret = cdns_pcie_host_wait_for_link(pcie);
+	}
+	return ret;
+}
+
+int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
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
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size)
+{
+	enum cdns_pcie_rp_bar bar, sel_bar;
+
+	sel_bar = RP_BAR_UNDEFINED;
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
+		if (!rc->avail_ib_bar[bar])
+			continue;
+
+		if (size <= bar_max_size[bar]) {
+			if (sel_bar == RP_BAR_UNDEFINED) {
+				sel_bar = bar;
+				continue;
+			}
+
+			if (bar_max_size[bar] < bar_max_size[sel_bar])
+				sel_bar = bar;
+		}
+	}
+
+	return sel_bar;
+}
+
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size)
+{
+	enum cdns_pcie_rp_bar bar, sel_bar;
+
+	sel_bar = RP_BAR_UNDEFINED;
+	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
+		if (!rc->avail_ib_bar[bar])
+			continue;
+
+		if (size >= bar_max_size[bar]) {
+			if (sel_bar == RP_BAR_UNDEFINED) {
+				sel_bar = bar;
+				continue;
+			}
+
+			if (bar_max_size[bar] > bar_max_size[sel_bar])
+				sel_bar = bar;
+		}
+	}
+
+	return sel_bar;
+}
+
+int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
+				  const struct list_head *b)
+{
+	struct resource_entry *entry1, *entry2;
+
+	entry1 = container_of(a, struct resource_entry, node);
+	entry2 = container_of(b, struct resource_entry, node);
+
+	return resource_size(entry2->res) - resource_size(entry1->res);
+}
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.h b/drivers/pci/controller/cadence/pcie-cadence-host-common.h
new file mode 100644
index 000000000000..f8eae2e963d8
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2017 Cadence
+// Cadence PCIe Endpoint controller driver
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#ifndef _PCIE_CADENCE_HOST_COMMON_H
+#define _PCIE_CADENCE_HOST_COMMON_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+extern u64 bar_max_size[];
+
+int cdns_pcie_host_training_complete(struct cdns_pcie *pcie);
+int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie);
+int cdns_pcie_retrain(struct cdns_pcie *pcie);
+int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc);
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size);
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size);
+int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
+				  const struct list_head *b);
+
+#endif /* _PCIE_CADENCE_HOST_COMMON_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 59a4631de79f..bfdd0f200cfb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -12,14 +12,7 @@
 #include <linux/platform_device.h>
 
 #include "pcie-cadence.h"
-
-#define LINK_RETRAIN_TIMEOUT HZ
-
-static u64 bar_max_size[] = {
-	[RP_BAR0] = _ULL(128 * SZ_2G),
-	[RP_BAR1] = SZ_2G,
-	[RP_NO_BAR] = _BITULL(63),
-};
+#include "pcie-cadence-host-common.h"
 
 static u8 bar_aperture_mask[] = {
 	[RP_BAR0] = 0x1F,
@@ -81,77 +74,6 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
-static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
-{
-	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
-	unsigned long end_jiffies;
-	u16 lnk_stat;
-
-	/* Wait for link training to complete. Exit after timeout. */
-	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
-	do {
-		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
-		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
-			break;
-		usleep_range(0, 1000);
-	} while (time_before(jiffies, end_jiffies));
-
-	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
-		return 0;
-
-	return -ETIMEDOUT;
-}
-
-static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	int retries;
-
-	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (cdns_pcie_link_up(pcie)) {
-			dev_info(dev, "Link up\n");
-			return 0;
-		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static int cdns_pcie_retrain(struct cdns_pcie *pcie)
-{
-	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
-	u16 lnk_stat, lnk_ctl;
-	int ret = 0;
-
-	/*
-	 * Set retrain bit if current speed is 2.5 GB/s,
-	 * but the PCIe root port support is > 2.5 GB/s.
-	 */
-
-	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
-					     PCI_EXP_LNKCAP));
-	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
-		return ret;
-
-	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
-	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
-		lnk_ctl = cdns_pcie_rp_readw(pcie,
-					     pcie_cap_off + PCI_EXP_LNKCTL);
-		lnk_ctl |= PCI_EXP_LNKCTL_RL;
-		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
-				    lnk_ctl);
-
-		ret = cdns_pcie_host_training_complete(pcie);
-		if (ret)
-			return ret;
-
-		ret = cdns_pcie_host_wait_for_link(pcie);
-	}
-	return ret;
-}
-
 static void cdns_pcie_host_disable_ptm_response(struct cdns_pcie *pcie)
 {
 	u32 val;
@@ -168,23 +90,6 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
 }
 
-static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
-{
-	struct cdns_pcie *pcie = &rc->pcie;
-	int ret;
-
-	ret = cdns_pcie_host_wait_for_link(pcie);
-
-	/*
-	 * Retrain link for Gen2 training defect
-	 * if quirk flag is set.
-	 */
-	if (!ret && rc->quirk_retrain_flag)
-		ret = cdns_pcie_retrain(pcie);
-
-	return ret;
-}
-
 static void cdns_pcie_host_deinit_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -290,54 +195,6 @@ static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
 	return 0;
 }
 
-static enum cdns_pcie_rp_bar
-cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size)
-{
-	enum cdns_pcie_rp_bar bar, sel_bar;
-
-	sel_bar = RP_BAR_UNDEFINED;
-	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
-		if (!rc->avail_ib_bar[bar])
-			continue;
-
-		if (size <= bar_max_size[bar]) {
-			if (sel_bar == RP_BAR_UNDEFINED) {
-				sel_bar = bar;
-				continue;
-			}
-
-			if (bar_max_size[bar] < bar_max_size[sel_bar])
-				sel_bar = bar;
-		}
-	}
-
-	return sel_bar;
-}
-
-static enum cdns_pcie_rp_bar
-cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size)
-{
-	enum cdns_pcie_rp_bar bar, sel_bar;
-
-	sel_bar = RP_BAR_UNDEFINED;
-	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++) {
-		if (!rc->avail_ib_bar[bar])
-			continue;
-
-		if (size >= bar_max_size[bar]) {
-			if (sel_bar == RP_BAR_UNDEFINED) {
-				sel_bar = bar;
-				continue;
-			}
-
-			if (bar_max_size[bar] > bar_max_size[sel_bar])
-				sel_bar = bar;
-		}
-	}
-
-	return sel_bar;
-}
-
 static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 				     struct resource_entry *entry)
 {
@@ -410,17 +267,6 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 	return 0;
 }
 
-static int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
-					 const struct list_head *b)
-{
-	struct resource_entry *entry1, *entry2;
-
-        entry1 = container_of(a, struct resource_entry, node);
-        entry2 = container_of(b, struct resource_entry, node);
-
-        return resource_size(entry2->res) - resource_size(entry1->res);
-}
-
 static void cdns_pcie_host_unmap_dma_ranges(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
-- 
2.49.0


