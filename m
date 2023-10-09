Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D897BEEA0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 00:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378958AbjJIW5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378961AbjJIW53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 18:57:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8315A4
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 15:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lldqslOiYoi8d5YNx6495LoZ8qnOLLJsyT9O9Z7kHyf5wlxz7ZpTKOrziPxMQSw07ceEcliqHsaquEzcxl6dWd4givUxBYbgV2tdRTNhmIC0BDt3kSPCawUM0wwwegNb3GZgj2inrBRPlRz7sjTqQVuj+06NFkLAti/+kwUaz5nOGxpu9R8sXskfTVB3jsC8TpaST9rYnBw7x92KLOQxr6SwLNLdGD8V69bkCleQahylDFYmIMCViyWzh8mDPyiTZi3PZGfZMKRugBQhNyHnijHsV573chzpqmnobWCnaFJd7G//W3I4Om0oMb6r3QRUx1jUbIR6d+uY7gHFwOZzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqZX+nKpQrDcwOExLQrZV0f2UN7nreWNMpuBtL9orks=;
 b=KF5uliUEFkpfBaqtM1FgK/3hmJ4EU8r0zwTu0xVuJMkOfrjW/CRnoHlqXx+W5492tbsZOQ7L6+WDkqh7H8Q67X9DAjxMbAc37h+QdBd9PehZb01NRH2LD6o3t9+sRXMjXS925wYHigQmY9Tbj27HHkcBZeSYvTtWc17GuDJKXd/6HSWdXXRvY9ADNhmlAuVDbbcL/CPOtRiZulqyh/y6AZLc4v+HEfGe3Qb5btplD2vfKz0MpJSnU9uMmX00tIEas32T5rpHds8n44AdpnENV942ZmYb9nBBxp9v0rjRGzcBDPsb1FEl5Wyh4IIoF0+/qh16js9514zs2kIWMcC94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqZX+nKpQrDcwOExLQrZV0f2UN7nreWNMpuBtL9orks=;
 b=3BLhmCINTTRl12uDmyCmkH0SMTvttQ89qiA+il0E2jF3x0GrZZ4V2Bsvr3VkG4nnEqqNHkxdIBo9P/OUfAhk1JB8LkXJ6q4gawYXYhPH/iWQfv2TcayKLzjY6ikx8HA5ai9h51tKM0KmnzmDErTvmhq0M15auGlH2QEssoiqDBQ=
Received: from CYZPR05CA0029.namprd05.prod.outlook.com (2603:10b6:930:a3::28)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 22:57:21 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::44) by CYZPR05CA0029.outlook.office365.com
 (2603:10b6:930:a3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Mon, 9 Oct 2023 22:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 9 Oct 2023 22:57:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 17:57:19 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC v1 2/4] PCI: Add support for drivers to decide bridge D3 policy
Date:   Mon, 9 Oct 2023 17:56:51 -0500
Message-ID: <20231009225653.36030-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009225653.36030-1-mario.limonciello@amd.com>
References: <20231009225653.36030-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 557ead1e-46dd-4f90-506e-08dbc91b186b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLOjiZlARhEmCpW+RemFXjkFYinReIsREbZmgyQj1eEzOB8GDtKBI6CxFGDtal5bvn/W92guSzvbnq+xH65lOBS2a87QLYjxPnD3xlVmuAI16rO8VaXEriEHalMdZSQubYX+Di946Pxk2va3pvg8t81KUS4OqwGC9rJk2a+4cg7LbJc7L4yE7JzpNJN/LNOJN2dMQ/EAZfNRM7Jadx67LBgra87PTodgbIs96zUhsAyfzpjdSt7AbDZZf3aTB5WQT44f4OG2ofRalaabtqqh2cGM3kOHokjud6hgwvbvWwz6bmhJWlLQaXQ+hkBH0OXAYLvra6fvtKB1H7a7v2BpdnkYEpdDVOkBIOy8twkaKqh8WR6b3OSsjEeBWCnFaOsbtSZxl4kEZyBXYYGvtTB+MopiKj8LL17eUXLEPPfCLYAXABkoR+iYicDYpOUH7B5vHx1z65e8RFjYndi5x31ErtPFCCvx2uxN8QexucXjXXR+4/eFnQtz0KDgFpLwhKHyk1pvOotVbFbv6lZXwUw/yRvOjqaqvs0CxwhbMsFcUgjGKbEQuZ2U6XwGT8B4pk/n81PEezDIaQLgqCVp9XDlJmBhdzCES1JazwWJuoiUFvBZkTUaD6kHFV+4kJ39oWE3mPOggFPRH/wQ4zF3lYPLs3326aA49a/DY/58ToMrq5WRcPDy3KMVHmQzSkGc2aGyY9in8ASuYRHE/Ly3pugoRdpyqSKfhAfNrr6rTS4dFnIgFOVm/9LbR2XjyD1xMnyUAb74SUXEeJOZh7bg3KEHQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(1076003)(426003)(26005)(336012)(16526019)(36860700001)(7696005)(6666004)(41300700001)(47076005)(8676002)(8936002)(478600001)(2906002)(44832011)(4326008)(83380400001)(54906003)(110136005)(70206006)(70586007)(5660300002)(316002)(40460700003)(81166007)(356005)(36756003)(86362001)(40480700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:57:21.2949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557ead1e-46dd-4f90-506e-08dbc91b186b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
changed pci_bridge_d3_possible() so that any vendor's PCIe ports
from modern machines (>=2015) are allowed to be put into D3.

This policy change has worked for most machines, but the behavior
is improved with `pcie_port_pm=off` on some others.

Add support for drivers to register a callback that they can optionally
use to decide the policy on supported machines.

A priority is used so that if multiple drivers register a callback and
support deciding for a device the highest priority driver will return
the value.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c   | 119 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  54 ++++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..3b8e7b936908 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/list_sort.h>
 #include <linux/log2.h>
 #include <linux/logic_pio.h>
 #include <linux/pm_wakeup.h>
@@ -54,6 +55,8 @@ unsigned int pci_pm_d3hot_delay;
 static void pci_pme_list_scan(struct work_struct *work);
 
 static LIST_HEAD(pci_pme_list);
+static LIST_HEAD(d3_possible_list);
+static DEFINE_MUTEX(d3_possible_list_mutex);
 static DEFINE_MUTEX(pci_pme_list_mutex);
 static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
 
@@ -3031,6 +3034,16 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_force)
 			return true;
 
+		/* check for any preferences for the bridge */
+		switch (bridge->driver_d3) {
+		case BRIDGE_PREF_DRIVER_D3:
+			return true;
+		case BRIDGE_PREF_DRIVER_D0:
+			return false;
+		default:
+			break;
+		}
+
 		/* Even the oldest 2010 Thunderbolt controller supports D3. */
 		if (bridge->is_thunderbolt)
 			return true;
@@ -3168,6 +3181,112 @@ void pci_d3cold_disable(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_disable);
 
+static struct pci_dev *pci_get_upstream_port(struct pci_dev *pci_dev)
+{
+	struct pci_dev *bridge;
+
+	bridge = pci_upstream_bridge(pci_dev);
+	if (!bridge)
+		return NULL;
+
+	if (!pci_is_pcie(bridge))
+		return NULL;
+
+	switch (pci_pcie_type(bridge)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		return bridge;
+	default:
+		break;
+	};
+
+	return NULL;
+}
+
+static void pci_refresh_driver_d3(void)
+{
+	struct pci_d3_driver_ops *driver;
+	struct pci_dev *pci_dev = NULL;
+	struct pci_dev *bridge;
+
+	/* 1st pass: unset any preferences set a previous invocation */
+	while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
+		bridge = pci_get_upstream_port(pci_dev);
+		if (!bridge)
+			continue;
+
+		if (bridge->driver_d3 != BRIDGE_PREF_UNSET)
+			bridge->driver_d3 = BRIDGE_PREF_UNSET;
+	}
+
+	pci_dev = NULL;
+
+	/* 2nd pass: update the preference and refresh bridge_d3 */
+	while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
+		bridge = pci_get_upstream_port(pci_dev);
+		if (!bridge)
+			continue;
+
+		/* don't make multiple passes on the same device */
+		if (bridge->driver_d3 != BRIDGE_PREF_UNSET)
+			continue;
+
+		/* the list is pre-sorted by highest priority */
+		mutex_lock(&d3_possible_list_mutex);
+		list_for_each_entry(driver, &d3_possible_list, list_node) {
+			/* another higher priority driver already set preference */
+			if (bridge->driver_d3 != BRIDGE_PREF_UNSET)
+				break;
+			if (!driver->check)
+				continue;
+			bridge->driver_d3 = driver->check(bridge);
+		}
+		mutex_unlock(&d3_possible_list_mutex);
+
+		/* no driver set a preference */
+		if (bridge->driver_d3 == BRIDGE_PREF_UNSET)
+			bridge->driver_d3 = BRIDGE_PREF_NONE;
+
+		/* update bridge_d3 */
+		pci_bridge_d3_update(pci_dev);
+	}
+}
+
+static int pci_d3_driver_cmp(void *priv, const struct list_head *_a,
+			   const struct list_head *_b)
+{
+	struct pci_d3_driver_ops *a = container_of(_a, typeof(*a), list_node);
+	struct pci_d3_driver_ops *b = container_of(_b, typeof(*b), list_node);
+
+	if (a->priority < b->priority)
+		return -1;
+	else if (a->priority > b->priority)
+		return 1;
+	return 0;
+}
+
+int pci_register_driver_d3_policy_cb(struct pci_d3_driver_ops *arg)
+{
+	mutex_lock(&d3_possible_list_mutex);
+	list_add(&arg->list_node, &d3_possible_list);
+	list_sort(NULL, &d3_possible_list, pci_d3_driver_cmp);
+	mutex_unlock(&d3_possible_list_mutex);
+	pci_refresh_driver_d3();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_register_driver_d3_policy_cb);
+
+void pci_unregister_driver_d3_policy_cb(struct pci_d3_driver_ops *arg)
+{
+	mutex_lock(&d3_possible_list_mutex);
+	list_del(&arg->list_node);
+	list_sort(NULL, &d3_possible_list, pci_d3_driver_cmp);
+	mutex_unlock(&d3_possible_list_mutex);
+	pci_refresh_driver_d3();
+}
+EXPORT_SYMBOL_GPL(pci_unregister_driver_d3_policy_cb);
+
 /**
  * pci_pm_init - Initialize PM functions of given PCI device
  * @dev: PCI device to handle.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..c36903a4e351 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -389,6 +389,7 @@ struct pci_dev {
 						   bit manually */
 	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
+	unsigned int	driver_d3;	/* Driver D3 request preference */
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
@@ -1405,6 +1406,59 @@ bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
 void pci_resume_bus(struct pci_bus *bus);
 void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
 
+/**
+ * enum bridge_d3_pref - D3 preference of a bridge
+ * @BRIDGE_PREF_UNSET: Not configured by driver
+ * @BRIDGE_PREF_NONE: Driver does not care
+ * @BRIDGE_PREF_DRIVER_D3: Driver prefers D3
+ * @BRIDGE_PREF_DRIVER_D0: Driver prefers D0
+ */
+enum bridge_d3_pref {
+	BRIDGE_PREF_UNSET,
+	BRIDGE_PREF_NONE,
+	BRIDGE_PREF_DRIVER_D3,
+	BRIDGE_PREF_DRIVER_D0,
+};
+
+/**
+ * pci_d3_driver_ops - Operations provided by a driver to evaluate D3 policy
+ * @list_node: the linked list node
+ * @priority: the priority of the callback
+ * @check: the callback to evaluate D3 policy
+ *
+ * For the callback drivers are expected to return:
+ *  BRIDGE_PREF_NONE if they can't evaluate the decision whether to support D3
+ *  BRIDGE_PREF_DRIVER_D0 if they decide the device should not support D3
+ *  BRIDGE_PREF_DRIVER_D3 if they decide the device should support D3
+ */
+struct pci_d3_driver_ops {
+	struct list_head list_node;
+	int priority;
+	enum bridge_d3_pref (*check)(struct pci_dev *pdev);
+};
+
+/**
+ * pci_register_driver_d3_policy_cb - Register a driver callback for configuring D3 policy
+ * @arg: driver provided structure with function pointer and priority
+ *
+ * This function can be used by drivers to register a callback that can be used
+ * to delegate the decision of whether a device should be used for D3 to that
+ * driver.
+ *
+ * Returns 0 on success, error code on failure.
+ */
+int pci_register_driver_d3_policy_cb(struct pci_d3_driver_ops *arg);
+
+/**
+ * pci_unregister_driver_d3_policy_cb - Unregister a driver callback for configuring D3 policy
+ * @arg: driver provided structure with function pointer and priority
+ *
+ * This function can be used by drivers to unregister a callback that can be used
+ * to delegate the decision of whether a device should be used for D3 to that
+ * driver.
+ */
+void pci_unregister_driver_d3_policy_cb(struct pci_d3_driver_ops *arg);
+
 /* For use by arch with custom probe code */
 void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);
-- 
2.34.1

