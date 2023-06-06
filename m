Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C34724901
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjFFQYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbjFFQYW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 12:24:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F6C10EA;
        Tue,  6 Jun 2023 09:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7KOLY0qlkN7wbMp2H1xm5KI8NZ4TQtyLqLhldSXDMA6nifiYpKQspjQRZXkliPTwawj/de+9ditlvWX/va4joG2evJlkse4Fl+DHKeBP8+99B8ILb0x4kepHXE0UEH1Hc4d1eYcgMEroypeVc68MJLmrU8Rcj3ueqsf7qZObtp0XZcR/4GQY8wYmXaiYgt51Yx5+fPc67tMl109Y8JoxLHdzSASSVroBnWQ39UmdV4Wt3Rf52bfbkDj0MSCOvDm+vHyBOAJ6VBlJIcWBdvsyyWglv2uVuOGLgrZ+ePwY65LGiaO5S56qRT5wvOmzpjZiIjteI12Gr9PKq+O7sbMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvaLigvBWC8xjoh3ywCjaq7FhlRykUwhuFVFH+4LNwI=;
 b=mk9eKLIrN8ioyyIfDChRSdcsXAkpw1yVZkNWCuu5cLT4U02yG0UgCrRkstFCnx6ktTfdRcAr60Pq3QkM1yE56HCajzjdt5l40EDX/avFYvEevUyiBWSstZOHH2ShTHuWN46BE0d1Q57NUDzTD5MIA7wS1jq/Vpc18CIF67tUCE53sagkLZdj5qXBLNGTfmgnYVjSXm7NXOf8adszHsgbey7dc3guBaX+YxwBu+pBRFm5o0LH0nT6RprElzAoGj0qmNAdF3jtIrmagvelbv//v44iIj1WqApcd4qex4tKrixLI4Luw565xQ+nvEhgTHIBl6kJh0MEuPREZo22230CUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvaLigvBWC8xjoh3ywCjaq7FhlRykUwhuFVFH+4LNwI=;
 b=voBbyO3GuE9zLHzG9YgAumYNnctKwQ5HGgaKW93rk4RNmEB+5uyOyfmb6XFMvCe7oPWMT0FuvRYhLt6W61/a1hALhdbc/MYLkqT+wkvxk1DRBrCWovGhH5jVjFU0Zci9uhiZsxAPfcVn4P4QAuRdgRKHTAS04qCZ7gHYxSC4Fzw=
Received: from DM5PR07CA0092.namprd07.prod.outlook.com (2603:10b6:4:ae::21) by
 DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Tue, 6 Jun 2023 16:23:37 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::91) by DM5PR07CA0092.outlook.office365.com
 (2603:10b6:4:ae::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 16:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:23:37 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:23:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] PCI: Call _REG when saving/restoring PCI state
Date:   Tue, 6 Jun 2023 11:23:21 -0500
Message-ID: <20230606162321.34222-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|DM6PR12MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 1547660d-b622-4e79-9358-08db66aa61eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9Y+slEGwVywyysipWHbF4iY7Gjae8sFqySzaTmNuwl6PwSzuSxE2BNJ3CFMi5RrDU9Lpvwq/tXPwcEpnTBI4Gipn5sdv/N+aa31BVE6Tv64+7P72SSEkfwSRxZPE8SIg5mAoaksbBgr9HlXdbD43WBb66etRQhAMVDQzGrSw9yTv6aR1mARitR7jl5XZgFXCL/LGFvwi81LkRizKUh4dmD0RpSg8G6ZYqjbrpk7mPzh/f9sFHVZhODTV26IGa6d+IDdV3bHtFRGPxurlO889yNhaRYLmLI5CuEW6BMRKCgn92QrX5Ch5n0WuK11tZ8KZaiW3XaVtBPt+Wx/PcQLhqz3nsOSy/pxzbqMIvwirQFJAtssvcLN8l17DMmf61Pgd4owY1WkJWVj4hIFORNw0xJF695DLiKBMQrqY5DHnj8PKxKam0cr7jFGpv+mxN0ENrYBqQOEnVS6HobT4skmUm5rSMuKF6Ij3JyC2oYaiYrWpOPYGV+czF58EHtxQwbG8gN+5e6BXKm3mXGMctynEj0EUDDDiFrtCgMjwcsX+TVUcvc7CoZooWZcj02SSboplGef+6FgPQ03HQuZwmEQbRwd11Dp/l8Lak0rb+idPyVOf6Yv4yAe0aVKmtQLEbYzhgmJ12dfXYpm+AqXiRPeqL3VazSR1Ili6lei4Za09Ajk8cyZm0renwJOD1eVXy27GUv14+Sv8bcT/JrPpB1eFaqkilF18hpIGIdcbPttYsDY/bKCqTyAV+vXa8UQRdL3kMEKdw1eLGOw85+UGftir15C4imlZbeuYurjMkPbjz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(41300700001)(316002)(54906003)(110136005)(44832011)(356005)(82740400003)(81166007)(5660300002)(2906002)(70206006)(4326008)(70586007)(8676002)(8936002)(6666004)(966005)(82310400005)(7696005)(40460700003)(86362001)(186003)(2616005)(36756003)(16526019)(26005)(36860700001)(40480700001)(426003)(83380400001)(336012)(1076003)(47076005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:23:37.5578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1547660d-b622-4e79-9358-08db66aa61eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ASMedia PCIe GPIO controllers fail functional tests after returning from
suspend (S3 or s2idle). This is because the BIOS checks whether the
OSPM has called the `_REG` method to determine whether it can interact with
the OperationRegion assigned to the device.

As described in 6.5.4 in the APCI spec, `_REG` is used to inform the AML
code on the availability of an operation region.

To fix this issue, call acpi_evaluate_reg() when saving and restoring the
state of PCI devices.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Handle case of no CONFIG_ACPI
 * Rename function
 * Update commit message
 * Move ACPI calling code into pci-acpi.c instead
 * Cite the ACPI spec
---
 drivers/pci/pci-acpi.c | 10 ++++++++++
 drivers/pci/pci.c      | 14 ++++++++++++++
 drivers/pci/pci.h      |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1698205dd73c..abc8bcfc2c71 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1209,6 +1209,16 @@ void acpi_pci_remove_bus(struct pci_bus *bus)
 	acpi_pci_slot_remove(bus);
 }
 
+void acpi_pci_set_register_access(struct pci_dev *dev, bool enable)
+{
+	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
+	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
+				    ACPI_ADR_SPACE_PCI_CONFIG, val);
+	if (ret)
+		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
+			val ? "connect" : "disconnect", ret);
+}
+
 /* ACPI bus type */
 
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e38c2f6eebd4..b2f1f603ec62 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1068,6 +1068,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+static inline void platform_set_register_access(struct pci_dev *dev, bool en)
+{
+	if (pci_use_mid_pm())
+		return;
+
+	acpi_pci_set_register_access(dev, en);
+}
+
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
@@ -1645,6 +1653,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
 int pci_save_state(struct pci_dev *dev)
 {
 	int i;
+
+	platform_set_register_access(dev, false);
+
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
@@ -1790,6 +1801,8 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_enable_acs(dev);
 	pci_restore_iov_state(dev);
 
+	platform_set_register_access(dev, true);
+
 	dev->state_saved = false;
 }
 EXPORT_SYMBOL(pci_restore_state);
@@ -3203,6 +3216,7 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_STATUS, &status);
 	if (status & PCI_STATUS_IMM_READY)
 		dev->imm_ready = 1;
+	platform_set_register_access(dev, true);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ffccb03933e2..78961505aae2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -703,6 +703,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
 int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
 bool acpi_pci_need_resume(struct pci_dev *dev);
 pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
+void acpi_pci_set_register_access(struct pci_dev *dev, bool enable);
 #else
 static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
@@ -742,6 +743,7 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	return PCI_POWER_ERROR;
 }
+static inline void acpi_pci_set_register_access(struct pci_dev *dev, bool enable) {}
 #endif
 
 #ifdef CONFIG_PCIEASPM
-- 
2.34.1

