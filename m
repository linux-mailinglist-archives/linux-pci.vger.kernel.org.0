Return-Path: <linux-pci+bounces-33908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E5B23F98
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E532A54D4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB62C159F;
	Wed, 13 Aug 2025 04:27:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023110.outbound.protection.outlook.com [52.101.127.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3963D2BEC25;
	Wed, 13 Aug 2025 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059239; cv=fail; b=u4aSvfZz69x1KkE1RyWEweVr8ElfNz384K0JjrAsPG19VfeGbXMyJ1VRZHMa+zeqlbMBmy8kBTQnndsFAsTjlTfo0aJkaZB4QhBq6Ekn+2WIrBGwGTgM3x9gmIZGKspmgrQJGmZwMbqFkH6tzKSnFQnphSlMljH4xlld4xHLpBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059239; c=relaxed/simple;
	bh=HxkmfqgTx/YWMbItSiRaNiZMDK4bY/bryD1l25tW1Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR4QyfohJ83Z3Wa8Wo0lyLgGMzIsp6PkmYeUPkYl6nuLjHjjfqw/COLtYsfEEbvEZBrjD2sG5EI0ewUz8okyF2cHd/1VDBauoS25B9nXcDu917wVrlzgFOgIJCdpS0G7h4cmIShNviSgR4JQUDuVWMEKYCKn5fhhYj63eK06qJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkxMaSJHsFbrskxhcQJrFbSa+afczaLoEpNr32S3GZ2SRDgQwPNThRFFvBqKg7173XqTVPk4TSTwEB5VrQKZs39Zz/oEI/LnAMG+YPpilwNN2r5lHQhXRPw8Jf5YKhNoVk3vcvxGef8r8YhVuN5cstiS+vxvs7iHK/PoRuLYlX+mPt/OG3lGaAXW8cSfDbDBGo5c76WTOBQ4debYP0/igMBEhqvGmi51m5V4dK8tydPTl80UTudltlftbFXqfnWnaesXp0p21/DvYkOY6gvt7XEEAQxgObOx2uY6VxVsjuna8JEaTGVPxucWiDljmloRJTKdMNqWwHekdv+lIxTLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3zTibeDF/3eMrXlBuOtcWvdT0YInUHLWxB5RgK8rEo=;
 b=fai3tmWEfd4Mir4mV8J+vgv2o8lfc93E4O4WVQ73GjOXKJS32XCLuXCHFTzjiUdP0bZJ2w1eAWpM8baGlxyHzmkIFOtjlzBiKJ1nlr55e2dqjr+d0miP99TsU3Atnuj0XA0d337sDnH0gPfI7MLXXaZMuX4JVxc/Ot3betycRLm9yzDZ+4l9BgNeO0aIt2sjk5ULRd+s1KPMLg1TsjRvbKxsRvTci0pvqz9tNtOxhZeQFH8eg0eijtNhcGtQ3OClIH1rjJViwya3duAuhI27K/ghvSYFfdtEpTLSuqkh3EJwfHGfxy1Q7CeH5B3DwMydsaT0Fr4GgLIg8xZe6oNGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYWPR01CA0003.jpnprd01.prod.outlook.com (2603:1096:400:a9::8)
 by KU2PPF1A2CB34C0.apcprd06.prod.outlook.com (2603:1096:d18::48b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 04:27:10 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:400:a9:cafe::99) by TYWPR01CA0003.outlook.office365.com
 (2603:1096:400:a9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Wed,
 13 Aug 2025 04:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:08 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AD2244143A8D;
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
Subject: [PATCH v7 06/13] PCI: cadence: Split the common functions for PCIe controller support
Date: Wed, 13 Aug 2025 12:23:24 +0800
Message-ID: <20250813042331.1258272-7-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|KU2PPF1A2CB34C0:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 152ac205-c07c-4c7e-5b41-08ddda21aa59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9KQKkj87Lw6q/IYIPwU6TGZy3+rX5JGiKhTnULH/60U/VCIoiVTYttRzt2Y?=
 =?us-ascii?Q?A3R2/W1Tp+oBDr/5nyLi+mX4lEPLcfI3J+chx/3sK0PmZnBBCaEu+FGfLVCt?=
 =?us-ascii?Q?66BvByx6bwTnUrkNRDQxt0votId3r2OlS2QvHCcTfn7wV0UNmxKuyMWUBUsC?=
 =?us-ascii?Q?ElY7nLb+zd7AJQudwrIzkd1vUMmaxz7V3ehd8lE4/7GFrB/L1M5i5hxHQYjd?=
 =?us-ascii?Q?1xW9e/J2PRPpFmPJZjfL+FWbaIAvQyKcdLxilhzqSlhTcrewtskHj1Lpw6wk?=
 =?us-ascii?Q?ZwuRmrlTl8uKJPG/oKjx7PtL1G+pZk6nd5o2K488/b2khlwPqpn2iyWGkP87?=
 =?us-ascii?Q?/T63eFcsf5BehJiKmWD0pjLyBm1NJdRbmpA8RGFhWgWhWbBr2vA2OfXgN535?=
 =?us-ascii?Q?8DKLnckuXwZHsB+YvHkp8iBruQa06NBLiJcXdXYtzsTGbER5LKDDwzgrxJKG?=
 =?us-ascii?Q?JdOi0z9rszq0vVZmvIn3VMh7SgmaKakMs2piMFnD/VEXIktdPyLcRMEQTBSb?=
 =?us-ascii?Q?evAKIPfI66eOWlNMG0svV+2YGlBexbLq4xsdDE/L5/Vf3BAz1aS1Avt0iwRr?=
 =?us-ascii?Q?0hniDRIhk+ULvJLkjaPJeBYfXNVMgmwWhotUGkFPbx4yUssUWmMTeG4kmurz?=
 =?us-ascii?Q?QMR8cHfErOaKYuXyIwH1kgaIkAolwXNBeecVXlJUB8jODa9jrST8ga/GcvsL?=
 =?us-ascii?Q?GYF1zhuWOxaHWi5MPE15hSJixYy0YsEbOyAIFampMsjVkaXBONNZA0W0GFrT?=
 =?us-ascii?Q?PTFV+0KB6DjFsIcHzwwf8Fl+OdiBiP+jNzKmSCf5GelqTDyB2XKQzDE4Fkbn?=
 =?us-ascii?Q?ZFm1mrYJf5LnFX60n/PFy5LQZLrRzHa3QIq77mxvg5tOQMaR0zPz3QC4S8HD?=
 =?us-ascii?Q?d1dzNtJXMVh48wvlUIs6sqOuJcevXZNZUeBP3+OREKnQMFCNR/usWt9umI0x?=
 =?us-ascii?Q?gbMQ8qiy0QS4uBpC9MbysxhJF5w61Oe/9LJ1RCWHsrwJqBa/MRAOj+8mHwed?=
 =?us-ascii?Q?70XUYUKfQWopV3RL9estEoNnw1KHeVbotOsExoLnw7gM6PFOGRUYnp6RuZU2?=
 =?us-ascii?Q?2JeOY/CGm6ta5umO0OQsJWses3xBo/dpGe61gSi1lH6vIrgJRecNSixySgYt?=
 =?us-ascii?Q?ZHKyI62kBQ2zhH63/x5BD99zpujXfqlEZB6Li8Kl/1Yx6pUWwNrPuDoLOxBk?=
 =?us-ascii?Q?iNDefe0ZZXu+AiAhxoOHU2prlh0fB1+lyQtDQPKu5t8GIHPMf07CA5cvf/vX?=
 =?us-ascii?Q?YFiG7vZ9ecpr22YmpvuJiP/CioqYDUZxvqWOFC+a78/IOAcMLRyMQhshzrlE?=
 =?us-ascii?Q?PpbjhzR2TFHzWAnL4AyYg50g16UY9Twm1sbrnbVgdwPqoDV/fzm6hX+cg3vX?=
 =?us-ascii?Q?kBBmYKiW07ErWqK7hoSE98JTBXgvWbT+YecpsnMQNzq+MgZI8mGZrmsyCOty?=
 =?us-ascii?Q?ZVTek7xu6gcemnfneT0iTlrcn2uIRl/eP3h8HHj8duaAshw4nxkVIb+1h0G0?=
 =?us-ascii?Q?zIFCmyrIVK3opSGTyM0uHUbwyKfHbnloDm28?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:08.1133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 152ac205-c07c-4c7e-5b41-08ddda21aa59
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF1A2CB34C0

From: Manikandan K Pillai <mpillai@cadence.com>

Separate the functions for platform specific tasks and common
library tasks into different files.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Makefile       |   2 +-
 .../controller/cadence/pcie-cadence-common.c  | 142 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c | 129 ----------------
 3 files changed, 143 insertions(+), 130 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-common.c

diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index e45f72388bbb..b104562fb86a 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-common.o pcie-cadence.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
diff --git a/drivers/pci/controller/cadence/pcie-cadence-common.c b/drivers/pci/controller/cadence/pcie-cadence-common.c
new file mode 100644
index 000000000000..23c5ab6637fb
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-common.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe controller driver.
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include "pcie-cadence.h"
+
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
+{
+	int i = pcie->phy_count;
+
+	while (i--) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
+
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < pcie->phy_count; i++) {
+		ret = phy_init(pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret = phy_power_on(pcie->phy[i]);
+		if (ret < 0) {
+			phy_exit(pcie->phy[i]);
+			goto err_phy;
+		}
+	}
+
+	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_enable_phy);
+
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
+{
+	struct device_node *np = dev->of_node;
+	int phy_count;
+	struct phy **phy;
+	struct device_link **link;
+	int i;
+	int ret;
+	const char *name;
+
+	phy_count = of_property_count_strings(np, "phy-names");
+	if (phy_count < 1) {
+		dev_info(dev, "no \"phy-names\" property found; PHY will not be initialized\n");
+		pcie->phy_count = 0;
+		return 0;
+	}
+
+	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	for (i = 0; i < phy_count; i++) {
+		of_property_read_string_index(np, "phy-names", i, &name);
+		phy[i] = devm_phy_get(dev, name);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_phy;
+		}
+		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
+		if (!link[i]) {
+			devm_phy_put(dev, phy[i]);
+			ret = -EINVAL;
+			goto err_phy;
+		}
+	}
+
+	pcie->phy_count = phy_count;
+	pcie->phy = phy;
+	pcie->link = link;
+
+	ret =  cdns_pcie_enable_phy(pcie);
+	if (ret)
+		goto err_phy;
+
+	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		device_link_del(link[i]);
+		devm_phy_put(dev, phy[i]);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_init_phy);
+
+static int cdns_pcie_suspend_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+
+	cdns_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int cdns_pcie_resume_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cdns_pcie_enable_phy(pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable PHY\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+const struct dev_pm_ops cdns_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
+				  cdns_pcie_resume_noirq)
+};
+EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe controller driver");
+MODULE_AUTHOR("Manikandan K Pillai <mpillai@cadence.com>");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 5603f214f4c7..51c9bc4eb174 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -152,135 +152,6 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_reset_outbound_region);
 
-void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
-{
-	int i = pcie->phy_count;
-
-	while (i--) {
-		phy_power_off(pcie->phy[i]);
-		phy_exit(pcie->phy[i]);
-	}
-}
-EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
-
-int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
-{
-	int ret;
-	int i;
-
-	for (i = 0; i < pcie->phy_count; i++) {
-		ret = phy_init(pcie->phy[i]);
-		if (ret < 0)
-			goto err_phy;
-
-		ret = phy_power_on(pcie->phy[i]);
-		if (ret < 0) {
-			phy_exit(pcie->phy[i]);
-			goto err_phy;
-		}
-	}
-
-	return 0;
-
-err_phy:
-	while (--i >= 0) {
-		phy_power_off(pcie->phy[i]);
-		phy_exit(pcie->phy[i]);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(cdns_pcie_enable_phy);
-
-int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
-{
-	struct device_node *np = dev->of_node;
-	int phy_count;
-	struct phy **phy;
-	struct device_link **link;
-	int i;
-	int ret;
-	const char *name;
-
-	phy_count = of_property_count_strings(np, "phy-names");
-	if (phy_count < 1) {
-		dev_info(dev, "no \"phy-names\" property found; PHY will not be initialized\n");
-		pcie->phy_count = 0;
-		return 0;
-	}
-
-	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
-
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
-	for (i = 0; i < phy_count; i++) {
-		of_property_read_string_index(np, "phy-names", i, &name);
-		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i])) {
-			ret = PTR_ERR(phy[i]);
-			goto err_phy;
-		}
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			devm_phy_put(dev, phy[i]);
-			ret = -EINVAL;
-			goto err_phy;
-		}
-	}
-
-	pcie->phy_count = phy_count;
-	pcie->phy = phy;
-	pcie->link = link;
-
-	ret =  cdns_pcie_enable_phy(pcie);
-	if (ret)
-		goto err_phy;
-
-	return 0;
-
-err_phy:
-	while (--i >= 0) {
-		device_link_del(link[i]);
-		devm_phy_put(dev, phy[i]);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(cdns_pcie_init_phy);
-
-static int cdns_pcie_suspend_noirq(struct device *dev)
-{
-	struct cdns_pcie *pcie = dev_get_drvdata(dev);
-
-	cdns_pcie_disable_phy(pcie);
-
-	return 0;
-}
-
-static int cdns_pcie_resume_noirq(struct device *dev)
-{
-	struct cdns_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
-
-	ret = cdns_pcie_enable_phy(pcie);
-	if (ret) {
-		dev_err(dev, "failed to enable PHY\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-const struct dev_pm_ops cdns_pcie_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
-				  cdns_pcie_resume_noirq)
-};
-EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cadence PCIe controller driver");
 MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@free-electrons.com>");
-- 
2.49.0


