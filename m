Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4164679DF15
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 06:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbjIMELG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 00:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbjIMEKv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 00:10:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DAE19A7;
        Tue, 12 Sep 2023 21:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLDcdiWirAtBdJ6txLuJVtFsk+0ni3kPmVLCnGvTzPfONRc3ERRwOMtiM36MiftNc2QKW/XZcSjV011JVhzPMva/0LxYgstZIxXFQDwegaSHforBzm9gMcaSqcB+SS4YqxlBTOxKiDSZY5znshOVMr6IkVRlkjDjoLgcRPPaVjye9sQOEzArFGJiKbW2nQeNlRyhhY6qm20V3PQbvPNmgDBgMJmkYxzJ5D8vVSP/AUSlEBJcUywl0intmyKfsNeDEj1meX1w0otzOBh/nVL6NRdbGssFbWHkxyZKr1JCEwoE7KgewBM74e2R/C0XQZXpcZt5iZuy8MPkx6PIzl6HQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IexjpFrkf6cNVms+KaCheSQNtYEzVsqOhH3IWIveLZM=;
 b=JKQFaNJA0BgoRyBOpiEmI2vuYXLMc0bBw7MlludUiiaACEmwBUim3oAV2XGivHSG7Je1Prf6FhpJMsg8Tp7DlRpVY5U8uWmQmTeVKcMDuYdWaucp8EF9Tf87q/ja1r1mUO59Atjl9BVklfKmAQQNgrvnXVD0NJqanKHvs9GF4V/X5Mmq3/Cr0RuRsiCcNnjsC7AY+v/4e2qDom55ZrLSgimBSdz9YqTmncRcrqSaAyOdiOCVCGMddcTCz3wpgEBUzhjj2O//jAVdJwiwO1VbAGUL62OB2LTCddgOEiOne3X/4jgbHkHtEhaq9A2DGK05p7gZc31HM61H5W0T8651xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IexjpFrkf6cNVms+KaCheSQNtYEzVsqOhH3IWIveLZM=;
 b=VAJa7yar9KSR76EiL3+XB38VN+YmBKgr3dNSbGKbiHnlVXOI6BkLee+NG25zwRJtlq4XpeFYKsJON9PERvz0vL0QgRk4lj+TiV0jDmpAgwpH8C+clbLsXn/iGVV4607nW7X2U3q9gVCM/0Alv+z1kDQPQUMBQkzEfui3qHnDBys=
Received: from BLAPR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:335::26)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 13 Sep
 2023 04:09:40 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:335:cafe::d4) by BLAPR05CA0046.outlook.office365.com
 (2603:10b6:208:335::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 04:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 04:09:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 23:09:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        <iain@orangesquash.org.uk>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers
Date:   Tue, 12 Sep 2023 23:08:32 -0500
Message-ID: <20230913040832.114610-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913040832.114610-1-mario.limonciello@amd.com>
References: <20230913040832.114610-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c9d3b5-42e8-44ef-ac5d-08dbb40f4054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4BrPM8KJRAkUeEJ8YWeQ0p7Gk84RE3B6NeV6Cevzjs+fwDrXwYPa3km/aIZtW8LgEWEf+9Uv9SJ9lXJcI/h/KMLjvk/bKuilHifXCCxifZBGZYIBIoZOOUpW5+sGa3faIY52OI6/ZwCrX9SA9+6gzrH/zuKC1R9u06fpAESmfnoNIyabZPwvblvh5BuadFHTQOwWkyt3KxseOKUvys0ZKmscp93Umz7EMR32ZceR45KlG7vq3XDC/zksM8uj0bC318BD6QDlATbob2Br6KIIX4GNaYE85mucsWgkTcroIXZwB6h5YeU7XQm1fDBg7uE3U+wKPUjZIBjzNty2d8Mo70eU8otFYeXoaUn7jjGSn971csg0NG9ON2i+d7Vicwaar8bOGqMcfAE662QdpLEMP8ydf0DhszQeOwjlIgvodYP0T1ojdsdVINrFyNCh9SdwpyZkSEWPpmJxxdkL+KaAJTsIqCtSumgEAmts6mt9eVHmNsKosqmWgvvuauvnht0YFjScYGwV12jMp2JhvWPKU1kzXTcy3OMpq8/mCD+hYPjIqZDK9pBGzo3wX3OWMP4wpAUAICXo2hMbEmWOYlfn6jrCxhn5Kb6puyY5s/QTmvWrcO5VMgFdp9bUC9JMDJPTklaQvPEAAevTWCtlZwoDGmPISn5jzkfGS8a5kzaB017b6/xISGbC3/e7q6ipGpEXMBYDYc0Jj6BzR+uaScw9Dnb+F0ehAcSdpXh/psL+yNfGjcxYWb+zC93SQy1cEHq42ZtoimLsBhSzRug+e/FvEVUpcRWBcnITPsrmc1ZgYI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(426003)(4326008)(336012)(16526019)(44832011)(5660300002)(26005)(41300700001)(8936002)(2906002)(36860700001)(8676002)(83380400001)(110136005)(1076003)(478600001)(47076005)(966005)(316002)(7696005)(70586007)(36756003)(2616005)(70206006)(81166007)(54906003)(86362001)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 04:09:39.9388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c9d3b5-42e8-44ef-ac5d-08dbb40f4054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Iain reports that USB devices can't be used to wake a Lenovo Z13
from suspend. This is because the PCIe root port has been put
into D3hot and AMD's platform can't handle USB devices waking the
platform from a hardware sleep state in this case.

This problem only occurs on Linux, when waking from a platform hardware
sleep state. Comparing the behavior on Windows and Linux, Windows
doesn't put the root ports into D3.

In Windows systems that support Modern Standby specify hardware
pre-conditions for the SoC to achieve the lowest power state by device
constraints in a SOC specific "Power Engine Plugin" (PEP) [1] [2].
They can be marked as disabled or enabled and when enabled can specify
the minimum power state required for an ACPI device.

The policy on Linux does not take constraints into account to decide what
state to put the device into at suspend like Windows does. Rather for
devices that support D3, the target state is selected by this policy:
1. If platform_pci_power_manageable():
   Use platform_pci_choose_state()
2. If the device is armed for wakeup:
   Select the deepest D-state that supports a PME.
3. Else:
   Use D3hot.

Devices are considered power manageable by the platform when they have
one or more objects described in the table in section 7.3 of the ACPI 6.5
specification [3].

If devices are not considered power manageable; specs are ambiguous as
to what should happen.  In this situation Windows 11 leaves PCIe
ports in D0 while Linux puts them into D3 due to the policy introduced by
commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend").

As the Windows PEP driver uses constraints to express the desired state
that should be selected for suspend  but Linux doesn't introduce a quirk
for the problematic root ports.

When selecting a target state specifically for sleep in
`pci_prepare_to_sleep` this quirk will prevent the root ports from
selecting D3hot or D3cold if they have been configured as a wakeup source.

Cc: stable@vger.kernel.org
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [2]
Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [3]
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
The same PCI ID is used for multiple different root ports.  This problem
only affects the root port that the USB4 controller is connected to.

 drivers/pci/pci.c    |  5 +++++
 drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++++
 include/linux/pci.h  |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..a113b8941d09 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2752,6 +2752,11 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
+	/* quirk to avoid setting D3 */
+	if (wakeup && dev->dev_flags & PCI_DEV_FLAGS_NO_WAKE_D3 &&
+	   (target_state == PCI_D3hot || target_state == PCI_D3cold))
+		target_state = PCI_D0;
+
 	pci_enable_wake(dev, target_state, wakeup);
 
 	error = pci_set_power_state(dev, target_state);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..c6f2c301f62a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3869,6 +3869,34 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_poweroff_thunderbolt);
+
+
+/*
+ * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3 power
+ * states may cause problems when the system attempts wake up from s2idle.
+ *
+ * This manifests as a missing wakeup interrupt on the following systems:
+ * Family 19h model 44h (PCI 0x14b9)
+ * Family 19h model 74h (PCI 0x14eb)
+ * Family 19h model 78h (PCI 0x14eb)
+ *
+ * Add a quirk to the root port if a USB4 controller is connected to it
+ * to avoid D3 power states.
+ */
+static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
+{
+	struct pci_dev *child = NULL;
+
+	while (child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child)) {
+		if (pci_upstream_bridge(child) != pdev)
+			continue;
+		pdev->dev_flags |= PCI_DEV_FLAGS_NO_WAKE_D3;
+		pci_info(pdev, "quirk: disabling D3 for wakeup\n");
+		break;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
 #endif
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..2292fbc20630 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Wakeup events don't work over D3 */
+	PCI_DEV_FLAGS_NO_WAKE_D3 = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.34.1

