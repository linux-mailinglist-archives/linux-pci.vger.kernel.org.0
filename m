Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7B7943B0
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbjIFTQs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjIFTQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 15:16:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6341E41;
        Wed,  6 Sep 2023 12:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmblRZeuLSIFcGHThRIWJ0Q6OxfLIDr1h/iwL0Ts8qAPmmxEzcDrHQorz8qCRFjgEs1AInkCOIAR61cNr8ZhLEUyuzAGVsK8B8kIA+vW3rTAxpFK0kI/Z/X6FvJ7MAD9vHsGa4fLtnOllGl1bNaclM/VDy4YUqBN7frBEVsHEwsuRcTg/0rKe4s7fL0SzUH96ZbnfMC9Za8As1WBwvjAGXx6hYGo6eQKhl6xQQW6RgCXtKAmxl4MbRKt1JJxlb9rhZzQzaFUdZV4W4PvD4+0Y93i8Dz99qX+S54RwfTUw4WiylnxV21wHi4EX8lTfMnCSKDiWOHBv6Q6RQ1w8/EbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5xxYKRtpI0GejmHbFRAM5xdMKLsVnMzvB9IwcTCtRE=;
 b=awT6czXzzyAGuON+2cf0oAMDfDzilyneRVDge/RKlDGtB0FG7Aks97NhvMuLPvqG+TVeSMU2eE+Y+PrLCJhaciGqCX2cK2spdW7gNYobulGdilFsMPZtX39VdD3MQgV2aq0bDFBS//P+/ln22zDhCB53gVL6i8G1+sYdLlZOpGvfAHO4swNVa3+K65aEbbMtMrr33lB4flrh33UaFB6UYbCHzg+pUKRNOHep/0W7THGs2aZB+m5PzIfLKw3Zpynd4UBUSgMWiMoIFvbBwz/EWfxQ2QRVBbSYkeHvASIBDlDJGL3HQoYYwh2BLK84QpQGYmjFBD+67i7VEehmSek+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5xxYKRtpI0GejmHbFRAM5xdMKLsVnMzvB9IwcTCtRE=;
 b=Bp/8lSU0sL+8WSWpk3VtDXyybXNbkXi/jvcj24OryLEBLBZtBSjEIwpJvyy+06k10hMAf17k3vqcTD+yhwpvnPPhMh9NPigoypkMZo/80Tv7K+d4nW6Hc8EcPEm3+pu9OrJkUdXL3vcavKbKbpJMIHVliL7jLs1685tuTULRWrc=
Received: from BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::29)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 19:16:32 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::da) by BL1P223CA0024.outlook.office365.com
 (2603:10b6:208:2c4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 19:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.26 via Frontend Transport; Wed, 6 Sep 2023 19:16:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 14:16:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v17 2/4] PCI: Add support for drivers to register optin or veto of D3
Date:   Wed, 6 Sep 2023 13:43:52 -0500
Message-ID: <20230906184354.45846-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906184354.45846-1-mario.limonciello@amd.com>
References: <20230906184354.45846-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f500ed-edd4-4019-6332-08dbaf0dc809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvmObIpYMnYlBT0WpRwfPzkRn4e4EZyWEU9spVxO5eg4SWSvfmrsefb/IDWUL+0BZzvyw289kbeWbxpdSRzdtPDqgKhQMNzAQHsoCF4MBPpExmwAFl5jPOXZ0Niyz4ZbFXqR17L2G1+6aVQjpmh5ad3PG2BlehDr7oagAWzXYbjRzXeUXrKIs5PpERwfm69poIjZeVJ/R9S5Ks0SjDyB0RZ25fhA2XWP7xAAM9BDETGCPAh0ybExsEokH648Qgax/4GTZ0KRQcg/XhAoU50w6kThA1dC3jlu3HrnvM66kyf6xEvGTtRdSmoENKc55bxLeuskGg7kCeN1dg3r+3a1JOUHew2sO1PNp7qyHZbTHl1uyg3BdlXPHnOaooyPYIqZuOkYB4Qyw9Gm8u7G+QVRHd4E8F/y7a+mIG9qsODxBXAxgWKQV3AZOUGxX5VEArEBJFrvVHvIehSz6TfzMwPmL/BIzmHw3ldaXMZW4t4vyL5Rzyk46uWTAHo+VdCAFlzpNlQAha5Sj2C4NSKegzmv0bkaEnIaskLElxQXEycPHUx6FBoYMwnBkm7NIyyVNlSWE/0aQ/qEJWFzxEc9LlgKVOTeOxY6ShyebNVgQD1+dl6znpfDSxOmT/B4kbq38ELJkzNftGP2TF1g6yHW7+8/paGAT6nqc/kTmauyvsFKnwSUsw0GtVo2NjxdBbrwAOebqmzgQrtlAGuzD9imtHEtvuSObuHpa13/Bn7O1yYh+eE4okw7plsM1EYTnAeJaqigxxdQEjytUbRdS2Si5By7IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(40460700003)(26005)(81166007)(16526019)(356005)(1076003)(7696005)(47076005)(36756003)(36860700001)(426003)(336012)(83380400001)(40480700001)(4326008)(478600001)(8676002)(8936002)(70586007)(44832011)(110136005)(70206006)(5660300002)(316002)(86362001)(54906003)(6666004)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 19:16:32.8082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f500ed-edd4-4019-6332-08dbaf0dc809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

Add support for drivers to register both 'optin' and 'veto' callbacks
and a priority which can be used for deciding whether a device should
use D3. When drivers register the callbacks, the list is sorted by
priority.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c   | 143 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |   9 +++
 2 files changed, 152 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..06ab73f58adf 100644
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
 
@@ -161,6 +164,14 @@ static bool pcie_ats_disabled;
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
 
+/* Preferences set by a driver for D3 optin/veto */
+enum driver_d3_pref {
+	D3_PREF_UNSET,	/* Not configured by driver */
+	D3_PREF_NONE,	/* Driver does not care */
+	D3_PREF_OPTIN,	/* Driver prefers D3 */
+	D3_PREF_VETO,	/* Driver vetoes D3 */
+};
+
 bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
@@ -3031,6 +3042,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_force)
 			return true;
 
+		/* check for any driver optin of D3 for the bridge */
+		if (bridge->driver_d3 == D3_PREF_OPTIN)
+			return true;
+
 		/* Even the oldest 2010 Thunderbolt controller supports D3. */
 		if (bridge->is_thunderbolt)
 			return true;
@@ -3050,6 +3065,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (dmi_check_system(bridge_d3_blacklist))
 			return false;
 
+		/* check for any driver veto for D3 for the bridge */
+		if (bridge->driver_d3 == D3_PREF_VETO)
+			return false;
+
 		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
@@ -3168,6 +3187,130 @@ void pci_d3cold_disable(struct pci_dev *dev)
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
+static void pci_refresh_d3_possible(void)
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
+		if (bridge->driver_d3 != D3_PREF_UNSET)
+			bridge->driver_d3 = D3_PREF_UNSET;
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
+		if (bridge->driver_d3 != D3_PREF_UNSET)
+			continue;
+
+		/* the list is pre-sorted by highest priority */
+		mutex_lock(&d3_possible_list_mutex);
+		list_for_each_entry(driver, &d3_possible_list, list_node) {
+			/* another higher priority driver already set preference */
+			if (bridge->driver_d3 != D3_PREF_UNSET)
+				break;
+			/* check for opt in to D3 */
+			if (driver->optin && driver->optin(bridge))
+				bridge->driver_d3 = D3_PREF_OPTIN;
+			/* check for opt out of D3 */
+			else if (driver->veto && driver->veto(bridge))
+				bridge->driver_d3 = D3_PREF_VETO;
+		}
+		mutex_unlock(&d3_possible_list_mutex);
+
+		/* no driver set a preference */
+		if (bridge->driver_d3 == D3_PREF_UNSET)
+			bridge->driver_d3 = D3_PREF_NONE;
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
+/**
+ * pci_register_d3_possible_cb - Register a driver callback for checking d3 veto
+ * @arg: driver provided structure with function pointer and priority
+ *
+ * This function can be used by drivers to register a callback that can be
+ * used to veto a device going into D3.
+ * Returns 0 on success, error code on failure.
+ */
+int pci_register_d3_possible_cb(struct pci_d3_driver_ops *arg)
+{
+	mutex_lock(&d3_possible_list_mutex);
+	list_add(&arg->list_node, &d3_possible_list);
+	list_sort(NULL, &d3_possible_list, pci_d3_driver_cmp);
+	mutex_unlock(&d3_possible_list_mutex);
+	pci_refresh_d3_possible();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_register_d3_possible_cb);
+
+/**
+ * pci_unregister_d3_possible_cb - Unregister a driver callback for checking d3 veto
+ * @arg: driver provided structure with function pointer and priority
+ *
+ * This function can be used by drivers to unregister a callback that can be
+ * used to veto a device going into D3.
+ */
+void pci_unregister_d3_possible_cb(struct pci_d3_driver_ops *arg)
+{
+	mutex_lock(&d3_possible_list_mutex);
+	list_del(&arg->list_node);
+	list_sort(NULL, &d3_possible_list, pci_d3_driver_cmp);
+	mutex_unlock(&d3_possible_list_mutex);
+	pci_refresh_d3_possible();
+}
+EXPORT_SYMBOL_GPL(pci_unregister_d3_possible_cb);
+
 /**
  * pci_pm_init - Initialize PM functions of given PCI device
  * @dev: PCI device to handle.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..863399e78869 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -389,6 +389,7 @@ struct pci_dev {
 						   bit manually */
 	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
+	unsigned int	driver_d3;	/* Driver D3 request preference */
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
@@ -1404,6 +1405,14 @@ void pci_d3cold_disable(struct pci_dev *dev);
 bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
 void pci_resume_bus(struct pci_bus *bus);
 void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
+struct pci_d3_driver_ops {
+	struct list_head list_node;
+	int priority;
+	bool (*optin)(struct pci_dev *pdev);
+	bool (*veto)(struct pci_dev *pdev);
+};
+int pci_register_d3_possible_cb(struct pci_d3_driver_ops *arg);
+void pci_unregister_d3_possible_cb(struct pci_d3_driver_ops *arg);
 
 /* For use by arch with custom probe code */
 void set_pcie_port_type(struct pci_dev *pdev);
-- 
2.34.1

