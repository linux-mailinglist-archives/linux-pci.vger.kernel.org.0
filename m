Return-Path: <linux-pci+bounces-38700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD5BEF46C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7373318914DC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F62C0266;
	Mon, 20 Oct 2025 04:29:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023114.outbound.protection.outlook.com [52.101.127.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B933987;
	Mon, 20 Oct 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934547; cv=fail; b=rb/pQEpJCZZ7GJRmitILji1uBlva6MfN6Ilt9UFmHG7QBpa9UbT2zv/wY+fq0M/NZF0noX8aE1Eg2uLJTWlGsJZ+xuTK98WFz9bhj1pVKoAGL2/1twmJwI4UjjikwIt00CKeA0tcTUPukOJSQTviSTyt89XKPDijIsp+M2TuPjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934547; c=relaxed/simple;
	bh=aKclNouqQgXqK824rhpH2Tx4e0j+o9YwoVE2a3T5KSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsLez0kdrfG9TqCvkKQBMcxLroJSXEYG//BS+36oMIbfLXeFBskxxJZpWwDmobRHXf4lnXnNPccGg74odsoHJFnJA7cL2RkVG7onZo0EZNlHB3cYpgShci+qrvzFycRl7V3NRPyuffnMDEmypObk0vryIW/Y1iX5BG+1gK00Hrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwOaAkrDxMPACiS/BYqnEJIpuwFFT7+EpDVOVLpfEIzdkay0heBmAYoDiigGeK26sOj2U00dSMGc51ULeQQgFrZG9SmkLSxVtjZr7mUN+3eyM9TC0MXUGgo/4yogAEUt3sA1KzOx9Ok2D303iAEiVTEwtKSJcMdiY6aqNxhuiDfvhsP+eWRlm0Etxpzsf0f8Jiku0uqu9wS+nAHYn9QacGsNX90C78+FaIpk5XjIcsz9kUd196v/+763MAjqlggkD5SN8XVXXITe3rgig2Zext/vxwGczV8XPoxONxWRn4twYpIBCkPlnKGUZpRvijPz3smmohmBzBz7fmM/pdtTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1Yv0AETJnzTimIR9orqq5CToG7p80mxXAr3x/qBznY=;
 b=G5WV0GXHEj8hKhwVzKX8dkyh4zKHfi3pID2CrdprH51NnnZgn4gqdi6WPLhvcb9oi6ddtS3yPn+aU9Ak2ahe0zHHvcLgourBPdr6WK2iwTZsJpOxcg3kempPXUM/cGbGIbhkkEfsmaQNZOwaFRCiI8rUD4uXylVjCTY+oVXwAi9yl/0iwDLK9TGu0RE5SNGqwwbwfdJht2FSv0JyPY8VjzvyfPmtdU/euw5P5chCz+JrFjOSBiSregsSnNtdR/f45BjubkfbXsmHsj9f81l59lFtj3dVR6gFU1Xu1GP653hN7ltJ6Z44icZpYlKkkxOaYRbha6k+oJi/JdL95OjZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PUZP153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::21)
 by TYZPR06MB5528.apcprd06.prod.outlook.com (2603:1096:400:28e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Mon, 20 Oct
 2025 04:29:00 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::71) by PUZP153CA0006.outlook.office365.com
 (2603:1096:301:c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.6 via Frontend Transport; Mon,
 20 Oct 2025 04:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:28:58 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id E234F41C016B;
	Mon, 20 Oct 2025 12:28:57 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
Subject: [PATCH v10 03/10] PCI: cadence: Move PCIe RP common functions to a separate file
Date: Mon, 20 Oct 2025 12:28:50 +0800
Message-ID: <20251020042857.706786-4-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251020042857.706786-1-hans.zhang@cixtech.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|TYZPR06MB5528:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d5da379-b5ee-4130-a870-08de0f913070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JXsMBYOASEsc/zpr9VdGJDejWrknvjUwQt3zetd8e/+wzs8o3DpKnOcDAWxL?=
 =?us-ascii?Q?utGeuvBbfJHkXtbM4eJGN5pzVRzefLf/mDqbhiRgactAcm9GeBPK7uX7Fwwg?=
 =?us-ascii?Q?9tj77WUNTOl3IlGsXI+32gPcBISlDYTs6JBZ47SbHOTSBEBvUW3LMCR+zXiS?=
 =?us-ascii?Q?8XlPjrusJ9C/JtlZEROuLSm1k4LkdV+gNn4RPYytGgHtnTfFdnHJNqu0BfGU?=
 =?us-ascii?Q?vr0eUMSw4Dc6lkhYuqprhDrN/DjsSCGbyBC1H7wjKDrHrjsOPTY/NH3VjcjA?=
 =?us-ascii?Q?/5bu5ESlsc+f7yDdByTXOWrCMl7eLi44oD92VY4EzLVx14l+FLdfc9ZkZyyS?=
 =?us-ascii?Q?JtrWQvXtF55KTjFPNSApTkvjy9unhmcQLU1B4iJ4TIr6dJ1/UQfowFAboRsZ?=
 =?us-ascii?Q?P2afejMNbfiM4w4vbh4/cuwxMe0vM3BtbSShMXsCDFss4RhJi4dZe+dmCCvZ?=
 =?us-ascii?Q?Yg1q+D7NoWkghYsuvhw/TB3+RKAvrwCa8TcYcWM51Gw2GghUpaPcDA2fhtkN?=
 =?us-ascii?Q?jyVaM8kteqmTDV88mK8XmaiWOZ2DX8wHLVqQiMj+S5obtqvPxkHdW8/0k2hT?=
 =?us-ascii?Q?vJC1s980X199S0nt6otMF+R8cEzchEaZ58woTeWvUPhRX/OAJGx/gtHjf5JM?=
 =?us-ascii?Q?TTybgxRGNEY4KdxxHbyMxyN3mQ3a0b0UfiesBhL1C4quR3bk2I4hkIPc+6j4?=
 =?us-ascii?Q?mJTz+Nd+XU27wHKtMOWBKYLJeIcg4OADQldKDj2tAY+14CZ3WdOemkMJL/UC?=
 =?us-ascii?Q?hAZf/PziBd4OkG1MwOB2UQ5PCp3TRszHLfabbEZA0PpvWFOyHaEDv8ngSeSD?=
 =?us-ascii?Q?5EopezFUE6L3Nw7pkkOHopnl7Y/AAD3wAQ0kHehFQC5TUh4MDN+RoiwDZ7dV?=
 =?us-ascii?Q?vlyWMAjnL+5QJXhej8W9dA9xL8XVJL4qZgw31uelu4JjatC2qDeIEwg9DHfO?=
 =?us-ascii?Q?saPpvBdUCs++I42IUlmN/3Ka1IaG6jv46LlP1gECq0+um+3U4e3mWsDMBrl0?=
 =?us-ascii?Q?5qm1mLGcdmAl4xEU+F5HsfS0ln6KHws3e9GPg9xjKFPdgkNP0/hx7rIl0VDG?=
 =?us-ascii?Q?kj8+EycIdDx6ZBHY/nnF/E9NDkYHZo5E+Aqr0Deu6RlhhSpZRz8Iq5shuLHr?=
 =?us-ascii?Q?x2+6uwY70Sul2mjpAImv5InPODOuX5hM3VEzJmlpX4Qo860XWM+ywaWpVgzt?=
 =?us-ascii?Q?tQyO9STJ58zw/SVnRylYc/HFJfz20cwj89rB7wZJiTOFgFiURHRacaBr2fcg?=
 =?us-ascii?Q?nUgfcSVzRWRBfP9vK0rIBZAup3zQ9ckIcapbbRpRjs4QEzUR0dB9QNz86WP/?=
 =?us-ascii?Q?FH88coF/q9i3UXeJ7A4CyRLdBYWOR9KBrW57UA8dDY+lzZoMvV+IbH+6R0xi?=
 =?us-ascii?Q?XflGEjlwcT7iiwmsRgXlX+kCyfvdGciNr2acNS+FJ424SGPtbJMyRDn+RLlw?=
 =?us-ascii?Q?CxLLpQx/PKOyIs8HW2HRiKemhRtBrLHdQdmQ0xuHm8M641cR1oV3yOIIr2dV?=
 =?us-ascii?Q?cyzXHvEY9Sq8s4K5veBUGwpbcyHqlxeK08IgfHTL2XFNEjd/a0CFtyMFKuee?=
 =?us-ascii?Q?VDP5bh9f8/X4Ay1hYgs=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:28:58.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5da379-b5ee-4130-a870-08de0f913070
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5528

From: Manikandan K Pillai <mpillai@cadence.com>

Move the Cadence PCIe controller RP common functions into a separate
file. The common library functions are split from legacy PCIe RP
controller functions to a separate file.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../cadence/pcie-cadence-host-common.c        | 182 ++++++++++++++++++
 .../cadence/pcie-cadence-host-common.h        |  26 +++
 .../controller/cadence/pcie-cadence-host.c    | 156 +--------------
 4 files changed, 210 insertions(+), 156 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 5e23f8539ecc..a52ebf6f3201 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
-obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
+obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
new file mode 100644
index 000000000000..e72af6949992
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe host controller library.
+ *
+ * Copyright (c) 2017 Cadence
+ * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+ */
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
+EXPORT_SYMBOL_GPL(bar_max_size);
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
+EXPORT_SYMBOL_GPL(cdns_pcie_host_training_complete);
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
+EXPORT_SYMBOL_GPL(cdns_pcie_host_wait_for_link);
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
+EXPORT_SYMBOL_GPL(cdns_pcie_retrain);
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
+EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);
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
+EXPORT_SYMBOL_GPL(cdns_pcie_host_find_min_bar);
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
+EXPORT_SYMBOL_GPL(cdns_pcie_host_find_max_bar);
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
+EXPORT_SYMBOL_GPL(cdns_pcie_host_dma_ranges_cmp);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe host controller driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.h b/drivers/pci/controller/cadence/pcie-cadence-host-common.h
new file mode 100644
index 000000000000..dabf77986cca
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence PCIe Host controller driver.
+ *
+ * Copyright (c) 2017 Cadence
+ * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+ */
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
+#endif /* _PCIE_CADENCE_HOST_COMMON_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fffd63d6665e..d5a82460ee4b 100644
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


