Return-Path: <linux-pci+bounces-40624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F0C42D9F
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6736B4E129C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55D5213E6A;
	Sat,  8 Nov 2025 14:03:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022096.outbound.protection.outlook.com [52.101.126.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1361C84A1;
	Sat,  8 Nov 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610595; cv=fail; b=ZQff5i2Q2bIE7s/UYHhAwfQp9NDP8It9kljHbAmc/wEVnjc0gWY6G9fI1ksZrw0QFhv7aACLvrcNzr+coj2puGZFIX8jTELMTeqOgMLXXPBci5akulb1tXcsZIJ2tms/Ys2kIoNNEfi1rae2F8TEJ7aLilnwqofxIZ5uvtyXY8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610595; c=relaxed/simple;
	bh=TBgok9AP2pWXZZp+0POamyt8uyGp+OUFskSrKyvjVmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShtAhieHJjNlqtJa4UEGM9dvpIcnEtp3//ovm0rqV/cgiixNjVWUGKx+Pt5iWRYLgQHsVZjwU3Xtn9wjk36iDBnmLJieSprjJ+zBoSn8zkPboUky0qniX/mrScIq/kO6qneWAksT32TsEAwfk1wg+OlciIhpO0M5aj6/1ulD4nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldVZPV2GMEjfkoSe4EIzT7kUZIeC816frGKQGq3qIWu617Neh/7/LpgunaUjOkRLG3C4qaHIBoOTWyY1CCIPB5L+1yHlc7Pq/XC/mwFRvM/AQ/+JAQ4NHt60ORtYzjh72XXnAcUyzKEmoilhjlrQ9wIzu6DC6wPX7W4BUKXmzQVrorIUkW2/nKjlmk3Rc3ehSA0x6kJh0CU/Ww7oOq/G3H2jscdKxIpzbgHW0RT62N21rASgxkj8ldx41CVEDZeOqltmbYqxe3eOVJxtZkgN7OcoSHEytVSZmQ/UH7CyEIcisxTgZejp2zZU7bI80RjOecl6APLHCF86JV2xUoFbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnXw5VF3OCcUmjd0KPq1SawphiONvYYtw4hgtz2jLj4=;
 b=Wg5Dh4rzvXfv4Jfq8mSbXscCN3rsRn6iSuVNtL5qieTtwKQc5kugEWSUHHRfYVgtAgU0xQ+HuFDrozcvEEIi+L3EiPAmwlQNhgSqI7EGLi6ct3ZNNKX0gecS8fm436Q8VJCZQu9PjfzHwyaF/c9iqXpC76o+xPmT77Dqqb5mW3FXTRVMvuQIRO8J/V02wK96jX2p+P6DtPHkWioGnGmMpaz2AHvj/iYFcZDabMA8CCkJGeXgY54cZtYMXDu/5wtod1KIGFoQMwzhgeC7+vKsKcUTkzAV5C3mCZ/QuSKFURAM3pNc46swHHHsEmYcgZ8MBmhQ70ofgAE+1kXJ4kAC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0072.apcprd02.prod.outlook.com (2603:1096:300:5a::36)
 by SG2PR06MB5083.apcprd06.prod.outlook.com (2603:1096:4:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Sat, 8 Nov
 2025 14:03:10 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:300:5a:cafe::79) by PS2PR02CA0072.outlook.office365.com
 (2603:1096:300:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 14:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id F03254079A20;
	Sat,  8 Nov 2025 22:03:05 +0800 (CST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 03/10] PCI: cadence: Move PCIe RP common functions to a separate file
Date: Sat,  8 Nov 2025 22:02:58 +0800
Message-ID: <20251108140305.1120117-4-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|SG2PR06MB5083:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 97ee6a72-66e0-4b8c-7291-08de1ecf8bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJy8js5PgYGpssEs6Rc7WiSy02o8vAeSvW+5wIrJo+jXUh/iiw9X7YjszpQ9?=
 =?us-ascii?Q?2o67vwnnBZRo++YCfR+dQfrUBE4mIAB23ZVISIsL7G0SytFdRsCn26NWXMAX?=
 =?us-ascii?Q?9mMCfq2fY1ZDKO/hPiOrxDbMrMtczToEr6H4Id8LuqYEKe6CJs8nrb+0SHl7?=
 =?us-ascii?Q?+U90BKwlTQ1qF5j6NpZgyD0X8l9jSJK8qpkNn+zWxwjCAz1oYnNDUdDtIYcA?=
 =?us-ascii?Q?p6lttnXmzjG0eC1EgPHE2WashYuN5m8FJyYCbNhZQFF62lb6WvDRw7qpTY0w?=
 =?us-ascii?Q?ceeH3ifWLxW9syadYU0glMhsqyonJe4rtgMz8pd6AVyL92l85N4Ue5eSnVPO?=
 =?us-ascii?Q?UnInBZn56N6yVY2xzJfQN1j7e7RVHD9Ll57Ut6H+5ZvwLN3X9Y6pkeWerFYt?=
 =?us-ascii?Q?5yR482cFDZdfyAVkSaXCmTFpbnTuEjY44b1I6ucFkhE/xS3R/XH3XGRmim4p?=
 =?us-ascii?Q?m8PCf9dQ8LvpTm1GQTbWJoAr/nU0p6t2FI/H9yfPyzimVDIS859aAjMcjAWd?=
 =?us-ascii?Q?I3iLVC411vNy25GeQBMmck56emNN5WZJRS4hEIc75lYsB4VDb+qEwMcKtp2J?=
 =?us-ascii?Q?difZQrDyHrfNDQBJkyw9Srl9eOacDNtCi1tj4Lphh2X9OQ7zG5WYbYwkljd3?=
 =?us-ascii?Q?skUc18ZAYzFfk0tKkgVZX+47jl8MGjPuCHl+ZYbmpcOf+vUz0g7Nk8rXJSaF?=
 =?us-ascii?Q?3hdjwHangfDgg+x09KUGYvCTSCLm/raGpolEHiKW9GKOENFSgzrlrV0mEDBa?=
 =?us-ascii?Q?NnSpxCssoHCK8X/YXF7NgAGWmbcz8UDk2o9Z8Rp0KuOkEasuVxWnHPjvXtU/?=
 =?us-ascii?Q?ICoWPIfECqkKPIpsj53hI7sXfDvrD0EnNWqUyaVrIQhfLOC3usiwKqo1WNBf?=
 =?us-ascii?Q?9Y+tsFr19UsRjdl1v2nKtVX7tXD5jNVYtGIACk2uE8ziO29JX0E80Z8Urc9W?=
 =?us-ascii?Q?+mTMYMN9hY1ZqJtIRyo7DHM6QT8HldzTWShI76ZrDaSRSNIN8zu8i4TQMiSs?=
 =?us-ascii?Q?9/kcFIGO6V0HMu/Zu7vtUsPQDR6kUwR30lfp1yaWozYO8zX3MJ/D5zmwHZLd?=
 =?us-ascii?Q?HZU2FSP7AU56wznOojzOBxSEZ1wDV56PJWqogPCEb4wrF103vvcBaQtKgXqO?=
 =?us-ascii?Q?SS06doIbTXLGvp56gEgQwB5+29dQqp6xiSDIhiHMYfKESDC0LDfVy4vlVRji?=
 =?us-ascii?Q?JsWzqkvtWloVhpbnXuQ2uP191JPxvzgJehWahNephw02EbjTskNsti2VciEr?=
 =?us-ascii?Q?IL0i1YwDcTrtDuoi3owUvJWCKy2KI/glBJiNJY5MM6rAHx5UmOnb7hVLroo/?=
 =?us-ascii?Q?4JesNaO4DfteGwznT6qroqRM7B02vOQq6xZ75w0ubIzCPeVxA/lxmkT4m5Am?=
 =?us-ascii?Q?THpavs+QWOYt3Vp7L8w6QkqFzRHr0Ojlt0A7ywMCDl0Ici8pMe8aCjrjkep1?=
 =?us-ascii?Q?Eb55rbbMOOK9OuwD9Hf4fS/Ea87o825gbxQivVCxtEUk41a5OTomgOZ9vfVI?=
 =?us-ascii?Q?7W71SBZc2q5MKT6FQCji4+fS+6Mh2Y0uAQcfMc/6GdLD5wRtTz7cGzUFKqe4?=
 =?us-ascii?Q?4T0KkaL3L09+n3rcFA0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:07.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ee6a72-66e0-4b8c-7291-08de1ecf8bad
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5083

From: Manikandan K Pillai <mpillai@cadence.com>

Move the Cadence PCIe controller RP common functions into a separate
file. The common library functions are split from legacy PCIe RP
controller functions to a separate file.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 drivers/pci/controller/cadence/Makefile       |  10 +-
 .../cadence/pcie-cadence-host-common.c        | 289 ++++++++++++++++++
 .../cadence/pcie-cadence-host-common.h        |  46 +++
 .../controller/cadence/pcie-cadence-host.c    | 278 +----------------
 4 files changed, 350 insertions(+), 273 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 5e23f8539ecc..91ffdbfd3aaa 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,7 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
-obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
-obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
+pcie-cadence-mod-y := pcie-cadence.o
+pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o
+pcie-cadence-ep-mod-y := pcie-cadence-ep.o
+
+obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
+obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
+obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
 obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
new file mode 100644
index 000000000000..10cd5239d9c2
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -0,0 +1,289 @@
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
+int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie,
+				 cdns_pcie_linkup_func pcie_link_up)
+{
+	struct device *dev = pcie->dev;
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (pcie_link_up(pcie)) {
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
+int cdns_pcie_retrain(struct cdns_pcie *pcie,
+		      cdns_pcie_linkup_func pcie_link_up)
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
+		ret = cdns_pcie_host_wait_for_link(pcie, pcie_link_up);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_retrain);
+
+int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc,
+			      cdns_pcie_linkup_func pcie_link_up)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	int ret;
+
+	ret = cdns_pcie_host_wait_for_link(pcie, pcie_link_up);
+
+	/*
+	 * Retrain link for Gen2 training defect
+	 * if quirk flag is set.
+	 */
+	if (!ret && rc->quirk_retrain_flag)
+		ret = cdns_pcie_retrain(pcie, pcie_link_up);
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
+int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
+			      struct resource_entry *entry,
+			      cdns_pcie_host_bar_ib_cfg pci_host_ib_config)
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
+	while (size > 0) {
+		/*
+		 * Try to find a minimum BAR whose size is greater than
+		 * or equal to the remaining resource_entry size. This will
+		 * fail if the size of each of the available BARs is less than
+		 * the remaining resource_entry size.
+		 *
+		 * If a minimum BAR is found, IB ATU will be configured and
+		 * exited.
+		 */
+		bar = cdns_pcie_host_find_min_bar(rc, size);
+		if (bar != RP_BAR_UNDEFINED) {
+			ret = pci_host_ib_config(rc, bar, cpu_addr, size, flags);
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
+		 *
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
+		ret = pci_host_ib_config(rc, bar, cpu_addr, winsize, flags);
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
+int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc,
+				  cdns_pcie_host_bar_ib_cfg pci_host_ib_config)
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
+		err = pci_host_ib_config(rc, RP_NO_BAR, 0x0, (u64)1 << no_bar_nbits, 0);
+		if (err)
+			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
+		return err;
+	}
+
+	list_sort(NULL, &bridge->dma_ranges, cdns_pcie_host_dma_ranges_cmp);
+
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		err = cdns_pcie_host_bar_config(rc, entry, pci_host_ib_config);
+		if (err) {
+			dev_err(dev, "Fail to configure IB using dma-ranges\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe host controller driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.h b/drivers/pci/controller/cadence/pcie-cadence-host-common.h
new file mode 100644
index 000000000000..fe7d4202a8b6
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.h
@@ -0,0 +1,46 @@
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
+typedef int (*cdns_pcie_host_bar_ib_cfg)(struct cdns_pcie_rc *,
+					 enum cdns_pcie_rp_bar,
+					 u64,
+					 u64,
+					 unsigned long);
+typedef bool (*cdns_pcie_linkup_func)(struct cdns_pcie *);
+
+int cdns_pcie_host_training_complete(struct cdns_pcie *pcie);
+int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie,
+				 cdns_pcie_linkup_func pcie_link_up);
+int cdns_pcie_retrain(struct cdns_pcie *pcie, cdns_pcie_linkup_func pcie_linkup_func);
+int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc,
+			      cdns_pcie_linkup_func pcie_link_up);
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_min_bar(struct cdns_pcie_rc *rc, u64 size);
+enum cdns_pcie_rp_bar
+cdns_pcie_host_find_max_bar(struct cdns_pcie_rc *rc, u64 size);
+int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
+				  const struct list_head *b);
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr,
+				 u64 size,
+				 unsigned long flags);
+int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
+			      struct resource_entry *entry,
+			      cdns_pcie_host_bar_ib_cfg pci_host_ib_config);
+int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc,
+				  cdns_pcie_host_bar_ib_cfg pci_host_ib_config);
+
+#endif /* _PCIE_CADENCE_HOST_COMMON_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fffd63d6665e..db3154c1eccb 100644
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
@@ -245,10 +150,11 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
-static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
-					enum cdns_pcie_rp_bar bar,
-					u64 cpu_addr, u64 size,
-					unsigned long flags)
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr,
+				 u64 size,
+				 unsigned long flags)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
 	u32 addr0, addr1, aperture, value;
@@ -290,137 +196,6 @@ static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
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
-static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
-				     struct resource_entry *entry)
-{
-	u64 cpu_addr, pci_addr, size, winsize;
-	struct cdns_pcie *pcie = &rc->pcie;
-	struct device *dev = pcie->dev;
-	enum cdns_pcie_rp_bar bar;
-	unsigned long flags;
-	int ret;
-
-	cpu_addr = entry->res->start;
-	pci_addr = entry->res->start - entry->offset;
-	flags = entry->res->flags;
-	size = resource_size(entry->res);
-
-	if (entry->offset) {
-		dev_err(dev, "PCI addr: %llx must be equal to CPU addr: %llx\n",
-			pci_addr, cpu_addr);
-		return -EINVAL;
-	}
-
-	while (size > 0) {
-		/*
-		 * Try to find a minimum BAR whose size is greater than
-		 * or equal to the remaining resource_entry size. This will
-		 * fail if the size of each of the available BARs is less than
-		 * the remaining resource_entry size.
-		 * If a minimum BAR is found, IB ATU will be configured and
-		 * exited.
-		 */
-		bar = cdns_pcie_host_find_min_bar(rc, size);
-		if (bar != RP_BAR_UNDEFINED) {
-			ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
-							   size, flags);
-			if (ret)
-				dev_err(dev, "IB BAR: %d config failed\n", bar);
-			return ret;
-		}
-
-		/*
-		 * If the control reaches here, it would mean the remaining
-		 * resource_entry size cannot be fitted in a single BAR. So we
-		 * find a maximum BAR whose size is less than or equal to the
-		 * remaining resource_entry size and split the resource entry
-		 * so that part of resource entry is fitted inside the maximum
-		 * BAR. The remaining size would be fitted during the next
-		 * iteration of the loop.
-		 * If a maximum BAR is not found, there is no way we can fit
-		 * this resource_entry, so we error out.
-		 */
-		bar = cdns_pcie_host_find_max_bar(rc, size);
-		if (bar == RP_BAR_UNDEFINED) {
-			dev_err(dev, "No free BAR to map cpu_addr %llx\n",
-				cpu_addr);
-			return -EINVAL;
-		}
-
-		winsize = bar_max_size[bar];
-		ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
-						   flags);
-		if (ret) {
-			dev_err(dev, "IB BAR: %d config failed\n", bar);
-			return ret;
-		}
-
-		size -= winsize;
-		cpu_addr += winsize;
-	}
-
-	return 0;
-}
-
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
@@ -447,43 +222,6 @@ static void cdns_pcie_host_unmap_dma_ranges(struct cdns_pcie_rc *rc)
 	}
 }
 
-static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
-{
-	struct cdns_pcie *pcie = &rc->pcie;
-	struct device *dev = pcie->dev;
-	struct device_node *np = dev->of_node;
-	struct pci_host_bridge *bridge;
-	struct resource_entry *entry;
-	u32 no_bar_nbits = 32;
-	int err;
-
-	bridge = pci_host_bridge_from_priv(rc);
-	if (!bridge)
-		return -ENOMEM;
-
-	if (list_empty(&bridge->dma_ranges)) {
-		of_property_read_u32(np, "cdns,no-bar-match-nbits",
-				     &no_bar_nbits);
-		err = cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
-						   (u64)1 << no_bar_nbits, 0);
-		if (err)
-			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
-		return err;
-	}
-
-	list_sort(NULL, &bridge->dma_ranges, cdns_pcie_host_dma_ranges_cmp);
-
-	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
-		err = cdns_pcie_host_bar_config(rc, entry);
-		if (err) {
-			dev_err(dev, "Fail to configure IB using dma-ranges\n");
-			return err;
-		}
-	}
-
-	return 0;
-}
-
 static void cdns_pcie_host_deinit_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -561,7 +299,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 		r++;
 	}
 
-	return cdns_pcie_host_map_dma_ranges(rc);
+	return cdns_pcie_host_map_dma_ranges(rc, cdns_pcie_host_bar_ib_config);
 }
 
 static void cdns_pcie_host_deinit(struct cdns_pcie_rc *rc)
@@ -607,7 +345,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 		return ret;
 	}
 
-	ret = cdns_pcie_host_start_link(rc);
+	ret = cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
 
-- 
2.49.0


