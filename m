Return-Path: <linux-pci+bounces-31044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3804AED358
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39A01734AE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3201F3B97;
	Mon, 30 Jun 2025 04:16:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022085.outbound.protection.outlook.com [40.107.75.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC41A23B9;
	Mon, 30 Jun 2025 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256978; cv=fail; b=o67vkhYNQRXvJgz1yJD1RWeP+GEnX6eW8QZnpWrUui2JspJK87IOmnuB5LEgae6xx3pC6mSyAoMJqFQvDL6i4b+OYxEJeTAx3Tpia594W6T983bVSt5aR9Xtre/jUU87e5lwVYGKcLNqHozg+jpd4R0PLqNhXevWpMC+ktKfXSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256978; c=relaxed/simple;
	bh=4RLvysx+xCex2eLC0Z1p+TpaVc8nqfgHyUXBn86iGuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTWeeIgZkvQITTUqpdtLDkoOLbTxvuw+tDLVNUeykUqBIT/cBkTLV2Y5D2893cyaz97ZMIZjfxIQNtPtYAZPYVH5h00Pvv1yVKF63joURuc3dY/gOhG+Q2PS7UHHIVuYMTTzrPFPNBbSFcrKEgafozlE5qBbOFpEqoap9ili0Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdC8tnd+nDrKvAjLl3N5IJd1H8V71rDuMNg1HR05KTNB3psv8UGcvjHItGQZ2Qm0IghdOKhzVk6fzl0kvInwV9BNaZDKKu/ndzQgBk4SslG/3eyT3Grzrs2zAe6uSUGafGV2t3BFHiyxubgcq649d5iYGTR2NmrqRdfRKxjBHdtznO28v41Pp5bl9P+GTa3yfKrJeeVnMfcG9OhprdoKb+oslwraM10jFbcFBwWgy81HowMlTEHTaAc/rULY5TsMe8+FLj44qFF8fr2q3ahBiuLKJ8xWRTvnVTwWpWwJcesUgigk8eD9UOkIFYisp6YeK0hmOrysb39qFt6YqAWlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR88oC8LWfMzhJiL2iqmpyOLRj5vywyj5Y9QnWH3agI=;
 b=ed8GfMYG9SJfMqecAb096c6aEqw9f5W/Rl3mK9PhuwBr9UXxhYuPUiiltP+2FkAsgDedsVzevANeH1sOzjnsPS324RgjsPiPw3/QmDvbUJ+H1Amwsenazb82Ty8PakyO2vi2WFPEL+AGD78c2M4XAR7eTKC+Rf3KuMUgIdcx6EhnsnrrmI6nTplUqr9AGykYGJaNBYM6bQQFAKF0BaRkw71c0O67zp2LhuQtA6wN2oXXpBfSctDNIp/d6le4fvDm8n9RCQkpsEPss2PDmNQAOHvWILXA9Yp7q08uceibMMAXPs3JN/rvhKI1g2WzGUWXrSt0RgOtyDxeufxzJVSnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0202.jpnprd01.prod.outlook.com (2603:1096:405:7a::15)
 by PUZPR06MB6007.apcprd06.prod.outlook.com (2603:1096:301:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 04:16:10 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:405:7a:cafe::48) by TYCPR01CA0202.outlook.office365.com
 (2603:1096:405:7a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 04:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AA8C741604EE;
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
Subject: [PATCH v5 06/14] PCI: cadence: Split PCIe RP support into common and specific functions
Date: Mon, 30 Jun 2025 12:15:53 +0800
Message-ID: <20250630041601.399921-7-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|PUZPR06MB6007:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4d5c41ee-b9f1-4772-f769-08ddb78cd7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JJoHkR3ES/dR6pPVEUqhPhA0pUnIusPtWO2JkweqfElQgc0HkJXzygumdsSI?=
 =?us-ascii?Q?qWW6x9jYX8OC818BG3CPYqwlDO/qq9znOsIlpsOg/Wg95zaFhCWgMYxjfkTE?=
 =?us-ascii?Q?J6su5pkBmzfbntsD2/66QvLYc7F/Esh+NctWyo62kRY2s6NbKnvqks9D1z6e?=
 =?us-ascii?Q?R6jyJ0T+p4N3znttVVFp6KsEjR/FkuvJWqah0P/3sUS4mted49XawqrFl3Sx?=
 =?us-ascii?Q?bCm/h7cIrvNO2sgZN/DwQHkeVtr/dLh6xskzyYjB0h9DX7pbHZeV/DpKiUWh?=
 =?us-ascii?Q?BE3LSIq1ltW+lVLBqhGUHa8FcaI6rFn3THhnL6nxNmYZ0OzYa8y/iD+7cHP/?=
 =?us-ascii?Q?nL7Vq9Ml2//WS5qopvgRwyAXUEXJAafP2VK4qGl5IBhSgTs0+CbZegT8HisL?=
 =?us-ascii?Q?yUmsUZ/7kMRYpnovugtK1uWtQp0rlJxQAijE4V2RYBVUA6R0HDmAcZJPR6yd?=
 =?us-ascii?Q?qpJUr7+Wv82zhnVvitNhUbT4cCVbxKNYbPCarbIymUQURCrfr5YffxHA+fs/?=
 =?us-ascii?Q?sFX2dTHqLejRw1jdPAcNboA27R9POu8eyUNbIH7kU+BnT3MvMZamroSlBqu6?=
 =?us-ascii?Q?NT1Pkopy4wI2VthaHoUY4xnjannk1SXjWVjku74ZOvJ1Y8EfirPkzuA82/2s?=
 =?us-ascii?Q?L7pIz33AhOtnCyQguSxo95rUvem2RfcrwPvysdr3pu2d/fj0thYLc9n+/DSN?=
 =?us-ascii?Q?4cvg33ISFxQJX5ZtVeWTTQJyfV56Ez4c4N0I6PFSfQNamcDQ53iCHk2fjvov?=
 =?us-ascii?Q?WNFL2kcvATWC2+Xysx0Ugj+xDjw/F9U7wFG53/JICgqajJQZwz52cWQFnGrP?=
 =?us-ascii?Q?49a+2AgdgTmsq+zJHa6nZbb9WvEEptxR5D52T7RPBGtFoQx+MB6DfjMklvam?=
 =?us-ascii?Q?JH+ZRI5K+q9BOmhkBe5lWuuTQxzq43AJaskZ0h0Fm4nGsTLJmztQhQ0NaGXA?=
 =?us-ascii?Q?UFd7RT+O/FeEvqR9jmwHxCAtOg1qlheqqoQQQsk+tFA0ABQk9gjWKjJH+uoe?=
 =?us-ascii?Q?yKR7z4Jqx42CSOqXpvvr8fRhut+9qPFVniMhfGo2nNj9hCP7siUJKu2Ngi02?=
 =?us-ascii?Q?p/1V5Lj6KRtIOiEOm6sr4RolBO8BLKzKJjLaloziD1UiLJCJ2MwVXLI4n61o?=
 =?us-ascii?Q?ByIeHvFs4SU2wAOYckb4F7/VMHqT653QPkaOeumaSZq5zJ56q7XEjIIQoYy7?=
 =?us-ascii?Q?20qMMTShgSj7eXNdS0airtV67hzXuk3rqYk5QzNgbcY9eoP/FiwdOlfCHrPl?=
 =?us-ascii?Q?7VspLWCOKG72Z3FIweyBNvnM1JrulgNftdiGvsidgaFM2RrR/LnHxlNKODoY?=
 =?us-ascii?Q?aEV9HfBYygs6ALNWMr5OWnFw9tBPi5zh95MY1s88k4ztpLEamLjUxQ5OlPC/?=
 =?us-ascii?Q?d6WypMr1/VAd/smmKCz+15mDJ+73D1z5ECkLdEYNnpvN9fQKsty2DO+pUQiJ?=
 =?us-ascii?Q?yh2RmqzjCl6Xff1W/yboUERW4LQbAzU1AYPZM2FW7kdxwknQ8PXcorCguHBs?=
 =?us-ascii?Q?uoartO+zzxrQKWpgwusxtVrJrlBFZZU8kwN0?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:09.8568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5c41ee-b9f1-4772-f769-08ddb78cd7d6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6007

From: Manikandan K Pillai <mpillai@cadence.com>

Split the Cadence PCIe controller RP functionality into common
functions and functions for legacy PCIe RP controller.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig        |  12 +-
 drivers/pci/controller/cadence/Makefile       |   3 +-
 .../cadence/pcie-cadence-ep-common.h          |   8 +-
 .../cadence/pcie-cadence-host-common.c        | 169 ++++++++++++++++++
 .../cadence/pcie-cadence-host-common.h        |  25 +++
 .../controller/cadence/pcie-cadence-host.c    | 156 +---------------
 6 files changed, 209 insertions(+), 164 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 417f981ac8ca..a1caf154888d 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -6,21 +6,25 @@ menu "Cadence-based PCIe controllers"
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
-
-config PCIE_CADENCE_COMMON
-	bool
+	select PCIE_CADENCE_HOST_COMMON
 
 config PCIE_CADENCE_EP
 	tristate
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE
-	select PCIE_CADENCE_COMMON
+	select PCIE_CADENCE_EP_COMMON
 
 config PCIE_CADENCE_PLAT
 	bool
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 918f8c924487..0440ac6aba5d 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
-obj-$(CONFIG_PCIE_CADENCE_COMMON) += pcie-cadence-ep-common.o
+obj-$(CONFIG_PCIE_CADENCE_EP_COMMON) += pcie-cadence-ep-common.o
+obj-$(CONFIG_PCIE_CADENCE_HOST_COMMON) += pcie-cadence-host-common.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
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


