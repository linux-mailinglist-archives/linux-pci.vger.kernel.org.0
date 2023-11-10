Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DEA7E8342
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 20:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjKJTov (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 14:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjKJTog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 14:44:36 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2D5FD0;
        Fri, 10 Nov 2023 10:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGPtBp7ZMM9iB3jQApmOp0EVGqf5ejzWunQPgZ7M2xHXNmzVdBnehrX2JhUgpEK7xw+kgTqXuDiAZoFZ+JtJYbdHbfrxWXKYHAwCfY10e/LeF+qJwYZLukL38PAv0+2MDQ+ZbdWlrZTs74h0NIW8E2ITmfDfcFaGDodCn3K8+caiB12iQwgaxY46jBcto5u0nXpw5DnImAu+kDktGFHkCf2sFPwpwDV+EIhOtS3zjZrQgYPnqc5cY2vZ0HFbuhj6FIF9TlRPlGgIuU53hmBHoN6VXbfYsWMOwsrGTpduQOmYIFkATiwx8xnZT+IzUQUVhnCuk3iwo+bNED4F+GoE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evpbeo1dZAqXLwCv66bXfYPNXxJZjiCaBhoTDXXLTik=;
 b=lr+fk9ZfayBsrDfo7LTZv0PGT9J0tT/COxwjuDkk5frhzmIyNzCicWCArdvMR0wrSeYtoAoV6ytGMS5USZx/9VZo30meYuX2VJJxhMEruZS+V2NGYnokf5ExupTUeXaa0XLWGMvceiF9rHNHYyou+am2Qs7lwrsJ2rCV6WX6LcwkhG1dwQS9oNMfTPqYRNCKEV4DkfIshThGXKWvGyq3AAINTCMHBjnW2E5Jl9Qd+/YBDZv/XS4RVqoUZBsGBxzqOHZ0z7rtyYTNiyhpU17+EWd35QhoqYNcjne6E8dQiHfAmU8iM6dWVMKsl/gcDYM+aA48HbWKXFh30D9KJDa+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evpbeo1dZAqXLwCv66bXfYPNXxJZjiCaBhoTDXXLTik=;
 b=RFI9087FQs0vTBF/7k+RkxqdXxAn1syGtpccyjW6Iip+RdG569IbWYpRuQwLp6zTcsqKTLoiFbgJ1mCSn9MeR5cfTB03jj5/6lMI71i0g1pheBAXYolVjZMLv9P4tpMOX+N7QJF+COwTghjI+Z3D7NqK8iXxvOkAHtYWzWSg0WU=
Received: from MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 18:55:29 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::b0) by MN2PR01CA0030.outlook.office365.com
 (2603:10b6:208:10c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 18:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 18:55:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 12:55:26 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/3] PCI: Call PCI ACPI _DSM with consistent revision argument
Date:   Fri, 10 Nov 2023 12:55:01 -0600
Message-ID: <20231110185503.46117-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110185503.46117-1-mario.limonciello@amd.com>
References: <20231110185503.46117-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: c64b0b10-ea75-4634-c2db-08dbe21e9b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sq/wCSpVqcJc7ZNxqUL0ZLuHIT1SW+tnItcTtGSIIAjud9cT4hYQ1ruPtN7goTwthqjl2hJU3tscJOm3Ko5mRL7NwqRme5EDZLLL/ogRYC4Wk/ehnecrlj7xXknKp1DJeuuK9Gbv+og5bIsW1lacowBk6N2y4fMyPOKEgR5vEVPMzETAUVyDeDPtcnyn5TmxlcUIA6bOw5vOOVRC6c4kRv+G0zqTYo7NsyCcSN1dV+6Dy4hJaDwGld1VvyoMw3UCnTMOH+ZgqrCMi1I/7FNQQOiKOWvwmdzaGMfcvj4debYJ5XHVyNyZHXW6xHL6oxzpmrQ19OlsSwiE9CsmYVCC/hQR9uKfuEeRz9ptHV/rb8D/sYxxoMwgHo1L81xTNl+j9j167WC6PjwGdzLGXBwLItNQVkK9jxTpxH3heWlroha3ssSy/5LRvb3CnvepzGDoqUhapm0ZJEdvd1DFOG2krVih0tpMdeaSmshQpUESybhgIbOkKAP6FogdUWkITExkXHipv+EUEKbl3MMgnEJC3yw4TEYlIwyFVQ7KfuaAfcsD0gfRriZHuy0m5o/1skugaK/JuiQvnpvr8n+tmXxANiHIEEKz13Zs6xLtGaQbQk9f95qHhT1NnWM1ATQk1/IlaXytb+InAxwazel3A6G+hwvBKiFxFvGC4JFpHf0pZpeXKm2sRpq7xUk7rnxQw74gLuZ8KMl7prRyEmbrlCAlHznLZX/NgBY09QS/uaSI9jS3EPNDzVLb6nLGlF8nSPCKf2Hbifak2yAaJJrqskGQHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(478600001)(336012)(83380400001)(81166007)(426003)(6666004)(7696005)(2616005)(1076003)(16526019)(26005)(82740400003)(40480700001)(966005)(356005)(47076005)(36860700001)(70586007)(70206006)(54906003)(316002)(44832011)(110136005)(4326008)(86362001)(2906002)(5660300002)(8936002)(41300700001)(8676002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 18:55:28.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64b0b10-ea75-4634-c2db-08dbe21e9b99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI ACPI _DSM is called across multiple places in the PCI core
with different arguments for the revision.

The PCI firmware specification specifies that this is an incorrect
behavior.
"OSPM must invoke all Functions other than Function 0 with the
 same Revision ID value"

Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
      PCI Firmware specification 3.3, section 4.6
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/pci_root.c  |  3 ++-
 drivers/pci/pci-acpi.c   |  6 ++++--
 drivers/pci/pci-label.c  |  4 ++--
 drivers/pci/pcie/edr.c   | 13 +++++++------
 include/linux/pci-acpi.h |  1 +
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 58b89b8d950e..bca2270a93d4 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1055,7 +1055,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	 * exists and returns 0, we must preserve any PCI resource
 	 * assignments made by firmware for this host bridge.
 	 */
-	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
+	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
+				      &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
 				      DSM_PCI_PRESERVE_BOOT_CONFIG, NULL, ACPI_TYPE_INTEGER);
 	if (obj && obj->integer.value == 0)
 		host_bridge->preserve_config = 1;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..bea72e807817 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -28,6 +28,7 @@
 const guid_t pci_acpi_dsm_guid =
 	GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
 		  0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
+const int pci_acpi_dsm_rev = 5;
 
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *res)
@@ -1215,7 +1216,8 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 	if (!pci_is_root_bus(bus))
 		return;
 
-	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
+	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
+				      &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
 				      DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
 	if (!obj)
 		return;
@@ -1376,7 +1378,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	if (bridge->ignore_reset_delay)
 		pdev->d3cold_delay = 0;
 
-	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
+	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
 				      DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
 				      ACPI_TYPE_PACKAGE);
 	if (!obj)
diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 0c6446519640..91bdd04029f0 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -41,7 +41,7 @@ static bool device_has_acpi_name(struct device *dev)
 	if (!handle)
 		return false;
 
-	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
+	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
 			      1 << DSM_PCI_DEVICE_NAME);
 #else
 	return false;
@@ -162,7 +162,7 @@ static int dsm_get_label(struct device *dev, char *buf,
 	if (!handle)
 		return -1;
 
-	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
+	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
 				DSM_PCI_DEVICE_NAME, NULL);
 	if (!obj)
 		return -1;
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 5f4914d313a1..ab6a50201124 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
 	 * Behavior when calling unsupported _DSM functions is undefined,
 	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
 	 */
-	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
 			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
 		return 0;
 
@@ -51,8 +51,9 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
 	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
 	 * optional.  Return success if it's not implemented.
 	 */
-	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
-				EDR_PORT_DPC_ENABLE_DSM, &argv4);
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
+				pci_acpi_dsm_rev, EDR_PORT_DPC_ENABLE_DSM,
+				&argv4);
 	if (!obj)
 		return 0;
 
@@ -88,12 +89,12 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 	 * Behavior when calling unsupported _DSM functions is undefined,
 	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
 	 */
-	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
 			    1ULL << EDR_PORT_LOCATE_DSM))
 		return pci_dev_get(pdev);
 
-	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
-				EDR_PORT_LOCATE_DSM, NULL);
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
+				pci_acpi_dsm_rev, EDR_PORT_LOCATE_DSM, NULL);
 	if (!obj)
 		return pci_dev_get(pdev);
 
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 078225b514d4..7966ef8f14b3 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -115,6 +115,7 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 #endif
 
 extern const guid_t pci_acpi_dsm_guid;
+extern const int pci_acpi_dsm_rev;
 
 /* _DSM Definitions for PCI */
 #define DSM_PCI_PRESERVE_BOOT_CONFIG		0x05
-- 
2.34.1

