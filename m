Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6C68EDB0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjBHLTZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjBHLTC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:19:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59B25BB8;
        Wed,  8 Feb 2023 03:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUt0ZtYza91+PiOvwGjuDpUL7JYm2l81YBsmc5OAQ/IazjUNPdLuT3kcnN/+AN45f3gOcL5RDIr/NDif7/dH9NJJ6nu4NIX2stA5jOd4PrHXR5RMHqTnr5Llkwux2dsqZT4tt04WcszGAV8a/r5xSuXDDAhxo1DAaJ8Ki8u+VEtJspflUpXvPoFbm+qiGHO56ODJPM+ZySjpJ2gwfKB/EizymvtZwGPXw+o/sGYwEUlMnAWogJOTytek+ZOO/LiXCzePKBbkt05yV21Jw0COguCDQk9mKwUNr1C7kDHF34Vl/pDxpj6BwLIKpWjFyFAMtFIgpYN01uh1cf5WB1XhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CioCbog9+DveTk+544k+87uyyBf+XseOQ5gERTL8wJ8=;
 b=Aedbn5jIYKxhZtFmXwUt7G0IS2m/3qfBenBs9fBPHhJfsYTT76zt/vwg1KAq8vt+RQTdU9whnt+/Vnda/iBSrMP2Q0becxoLtCOezFOrtxd8K4C/G3PtNyW9MusCNDOndaCtIbKXEKtc8Sb5OmiSSvuDEVwQuHSZ8EZfkgFSJjeWkWaFKi7fwqPcOrm6g2VnyHE0M+Ifz3OVi8YcfP0d/VvO4iTiXP6bkzAsNDCJERiuREbppwfe/xQGIddpQz1GMd2KhmLOyUnJQD6NNgSrttb4V5QP6DSojFsC/Z9e34SCk+BkZ3zWcSHKQeKkTAaGIxC/EJ5y+MlPeeMC0Pwx8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CioCbog9+DveTk+544k+87uyyBf+XseOQ5gERTL8wJ8=;
 b=GBg7LTywR0Z2BN6GNVk1tIcJUxSOfJdX7ZhpH0oURTcFeoLaEka1BDyCVzb39d19K/PsJsDTh5cDN1wzSEzkXdaLguhU+TOJi0icC8BT+NXTuBFNW368DbXzNx9hyRrvWN0rEZ7pQ18EtTqp4jEHKiJtl2CbScOSrinyWp9OhV8r1ohfVPesAU0CgXii/c5Hk+GwFv8V8LjHvLOyduJ9PubgPHeOWERedbfJfeS4Ypfpo2KT9SZDr6Zsg857RFUgBHS5O5AnrW4NN51Ny1+RdeS5e4ppgZ8dkNV9GkJMkVRHFO1YpxdOAMjhfHp9zTcbi5Rv+6E2c9PSjpK6GroqzQ==
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Wed, 8 Feb
 2023 11:17:46 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::7) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Wed, 8 Feb 2023 11:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 11:17:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:29 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 8 Feb 2023 03:17:23 -0800
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <petlozup@nvidia.com>, <rafael.j.wysocki@intel.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>,
        <jeffy.chen@rock-chips.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <jonathanh@nvidia.com>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <gregkh@linuxfoundation.org>, <steven.price@arm.com>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <vidyas@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [RFC,v14 3/5] PCI / PM: Add support for the PCIe WAKE# signal for OF
Date:   Wed, 8 Feb 2023 16:46:43 +0530
Message-ID: <20230208111645.3863534-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 973b9164-0dd2-4938-c10d-08db09c61a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBSganwMsDHwq1PLZl82ZCRCuX173DJSDwwjRlWrkaC0wJ+V1n8CVjzbsbzSQJ/CHs9uSSvnUewlcUwCt0MwV2huInIyb9+RdhjI3EhcLfnFh9Gs1NYBTSidyZUADhv0pxd3K6TXvIDa1IRH/BsrlGp40Dt862sGy5wwmCOmmsndApjtMddozBmcTo4bEsVWWgwPHiR6AiXYWHDE0GcdBAkJ1NGgjWMyuWjrHYRFGDgt1dHYVMmG9c5gYPDs7p6kASMW2NomScCXlPqmsoKuEKF4Fb7Mq2j9+ypaykV2oc5kDtZs4kDI+t6v/NCb8SPpfovL6uSJ/Y01NDg/Wue2V6/saw5opr7o9+3mqtpJa7TkSpt7F4XlEo7XE+CTWoCko7nPhg+Rha85Ir6t2fQUXVUrg2KzxE5MImxTP8NJO7SEiXjPQ2KfAWajeAxFdgivZ1Tx4nVIC+tm7yvOziPZJAhE/yzKvfVtXcTSNNMTTVMF0c92V46UIpdVuBCNBmdxwcinxN8SEVIQsyRX5EBsMnapxFGYQENEwmd6NGn3DneCujYcPqC2+GE03nmDaXJ3KhnztfqK1pHZp1rM04dGlcSvE+/Wbq5J3+tIz6uc2Tt1AhFGRVagxFW1+zHDpkXr7gsfFI1MgDnnXhSojgqdqdXeNUoEeUMbMgi+livdPZT8vR7feT4W34MCzqXuF/4UJNdGdo1ZIW6aCVbTpSaifw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(36756003)(47076005)(7416002)(2906002)(426003)(83380400001)(1076003)(40480700001)(2616005)(356005)(336012)(7636003)(82740400003)(8676002)(36860700001)(70586007)(70206006)(4326008)(110136005)(54906003)(316002)(8936002)(41300700001)(6666004)(107886003)(186003)(82310400005)(26005)(40460700003)(478600001)(7696005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 11:17:45.4476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 973b9164-0dd2-4938-c10d-08db09c61a8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Add of_pci_setup_wake_irq() to parse the PCIe WAKE# interrupt from the
device tree and set the wake irq. Add of_pci_teardown_wake_irq() to clear
the wake irq.

Call of_pci_setup_wake_irq() in pci_device_probe() to setup PCIe WAKE#
interrupt during PCIe Endpoint enumeration.

Enable or disable PCIe WAKE# interrupt in platform_pci_set_wakeup().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---

Changes in v14:
pci_platform_pm_ops structure is removed in latest kernel, so dropped
pci-of driver. Instead, enable wake in platform_pci_set_wakeup().

Changes in v13:
Fix compiler error reported by kbuild test robot <fengguang.wu@intel.com>

Changes in v12:
Enable the wake irq in noirq stage to avoid possible irq storm.

Changes in v11:
Only support 1-per-device PCIe WAKE# pin as suggested.

Changes in v10:
Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
since dedicated wakeirq will be lost in device_set_wakeup_enable(false).

Changes in v9:
Fix check error in .cleanup().
Move dedicated wakeirq setup to setup() callback and use
device_set_wakeup_enable() to enable/disable.

Changes in v8:
Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.

Changes in v7:
Move PCIE_WAKE handling into pci core.

Changes in v6:
Fix device_init_wake error handling, and add some comments.

Changes in v5:
Rebase.

Changes in v3:
Fix error handling.

Changes in v2:
Use dev_pm_set_dedicated_wake_irq.

 drivers/pci/of.c         | 49 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c | 10 ++++++++
 drivers/pci/pci.c        |  7 ++++++
 drivers/pci/pci.h        |  8 +++++++
 4 files changed, 74 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ff897c40ed71..1c348e63f175 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -13,6 +13,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pm_wakeirq.h>
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -705,3 +706,51 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 	return slot_power_limit_mw;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
+
+int of_pci_setup_wake_irq(struct pci_dev *pdev)
+{
+	struct pci_dev *ppdev;
+	struct device_node *dn;
+	int ret, irq;
+
+	/* Get the pci_dev of our parent. Hopefully it's a port. */
+	ppdev = pdev->bus->self;
+	/* Nope, it's a host bridge. */
+	if (!ppdev)
+		return 0;
+
+	dn = pci_device_to_OF_node(ppdev);
+	if (!dn)
+		return 0;
+
+	irq = of_irq_get_byname(dn, "wakeup");
+	if (irq == -EPROBE_DEFER) {
+		return irq;
+	} else if (irq < 0) {
+		/* Ignore other errors, since a missing wakeup is non-fatal. */
+		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);
+		return 0;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+
+	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, irq);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to set wake IRQ: %d\n", ret);
+		device_init_wakeup(&pdev->dev, false);
+		return ret;
+	}
+
+	/* Start out disabled to avoid irq storm */
+	dev_pm_disable_wake_irq(&pdev->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_setup_wake_irq);
+
+void of_pci_teardown_wake_irq(struct pci_dev *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
+EXPORT_SYMBOL_GPL(of_pci_teardown_wake_irq);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d934c27491c4..fca966137fac 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/sched/isolation.h>
 #include <linux/cpu.h>
+#include <linux/of_pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/kexec.h>
@@ -456,10 +457,17 @@ static int pci_device_probe(struct device *dev)
 	if (error < 0)
 		return error;
 
+	error = of_pci_setup_wake_irq(pci_dev);
+	if (error < 0) {
+		pcibios_free_irq(pci_dev);
+		return error;
+	}
+
 	pci_dev_get(pci_dev);
 	error = __pci_device_probe(drv, pci_dev);
 	if (error) {
 		pcibios_free_irq(pci_dev);
+		of_pci_teardown_wake_irq(pci_dev);
 		pci_dev_put(pci_dev);
 	}
 
@@ -471,6 +479,8 @@ static void pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	of_pci_teardown_wake_irq(pci_dev);
+
 	if (drv->remove) {
 		pm_runtime_get_sync(dev);
 		drv->remove(pci_dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fba95486caaf..332a0b98b6c3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/pci_hotplug.h>
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
@@ -1052,6 +1053,12 @@ static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
 	if (pci_use_mid_pm())
 		return PCI_POWER_ERROR;
 
+	/* Enable or disable wakeirq if set via device tree. */
+	if (enable)
+		dev_pm_enable_wake_irq(&dev->dev);
+	else
+		dev_pm_disable_wake_irq(&dev->dev);
+
 	return acpi_pci_wakeup(dev, enable);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9ed3b5550043..83a2af148631 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -631,6 +631,8 @@ int of_pci_get_max_link_speed(struct device_node *node);
 u32 of_pci_get_slot_power_limit(struct device_node *node,
 				u8 *slot_power_limit_value,
 				u8 *slot_power_limit_scale);
+int of_pci_setup_wake_irq(struct pci_dev *pdev);
+void of_pci_teardown_wake_irq(struct pci_dev *pdev);
 void pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
@@ -669,6 +671,12 @@ of_pci_get_slot_power_limit(struct device_node *node,
 	return 0;
 }
 
+static inline int of_pci_setup_wake_irq(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+static inline void of_pci_teardown_wake_irq(struct pci_dev *pdev) { }
 static inline void pci_set_of_node(struct pci_dev *dev) { }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
-- 
2.25.1

