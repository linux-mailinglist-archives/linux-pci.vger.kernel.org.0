Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A027A70FD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 05:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjITD2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 23:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjITD15 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 23:27:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B94B6
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 20:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQEEi6mTJkVe6Orijs0DBKWlLO8GSmChvtYN3g+Yg5TcjJgaW6erLEUiOzGxwJs/xbXsXqbHvWX2UDVVm0a/AT/A1Ua0gEayrS/UO8Q4E/DX/MDCUx5EP1p9PzJRLeSwn0hqx8JjPjthxtZDOusaD1Bmy5tLB9ldQG+/K7Myyo1+QAxnBak7ry+75PrxvwledWtC+Q6QXAQIn/LZ5pu9dzrqxTGsMIXZQJU4sOB4/ofF3EUS53paXGGwcaqNolLg06A6jI0xPLa9r2O5kETva6QlQMw6Y0xhUojfj9jJJHDjTEJ183OlyX77+2XtrteuFQT7koqt7S5fMC2TJYBtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6L7iPot/AayBIyU4Ze+NkO+IosOItWIX/AzDQfR4jc=;
 b=JaPsJNBN4F7Gzxkg2BE6zWJtIo4C1b8hE3A+rYLZ/dPCCyE5TH3KjBg2d4w9gykZ9NoNEagoyVJFFoBVDSsW3btqCrDpkHDMXT2PL95XGd6O+oDPowK3A8F6VkjWp+IDLViVkEPPipKVJN6d6h2lJGnO2fnp+34CszsrJYtBCJ2LM6BUyWJa406zbjCmoZomBysyMIAWgXgqPxX9FfbRnOJNTB9RdngHbV1XytaMzJ7sSNSE7NEQpOcJDf0P60C8I1oQLR8wl1Djcljs6OwkWfPCVqbAtlV+Ojref9ncYhvQ4sGC5+37UnoV9/qBZ77aMGFCgb8+7O9VrG6CVgqZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6L7iPot/AayBIyU4Ze+NkO+IosOItWIX/AzDQfR4jc=;
 b=kAma6ZUdvOnYLgjGuSTSf8ETmONlgwLWGke4WECPrFTPIqnhoBQO980DCX0sdY4VqfyeAD/sxNlnqNeRjkzTB2ZGyAyE0bIEWIp2jtVCzvi7gee+VakUfl4jPtNPBK0sRX9qg4OsrlZPtSS1Js/X0Y9m62T63laay1ca+AyDj5o=
Received: from PH8PR07CA0006.namprd07.prod.outlook.com (2603:10b6:510:2cd::7)
 by BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 03:27:47 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::c9) by PH8PR07CA0006.outlook.office365.com
 (2603:10b6:510:2cd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:27:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:27:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <iain@orangesquash.org.uk>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v20 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers
Date:   Tue, 19 Sep 2023 22:27:24 -0500
Message-ID: <20230920032724.71083-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920032724.71083-1-mario.limonciello@amd.com>
References: <20230920032724.71083-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|BN9PR12MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9037ce-fd99-442e-cf1d-08dbb9898f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZZa4AgZhpGncqwKvpNp/QH2BUXNq1B61pH7QEA1lmi08EfSYAHtEu9c0xFX3w6M8nlwupL8xiAcWEpfOVanXe9Pkvx28WWjRggLQCqnrkJ2BCYDSJkwdJc5p6UL6MTbP6LS5lw9AYWCY8QcX4qyDvSY23GdGJK9JehEuseqJcRqOOTPO1Qiu1OWJF/6hZTjvLVUXf4QDXDfQMlcuWNpqy7GiAVFO3MWDVXkPiKrrMrt2/FsGvl4Rwj4fZEtGWFCzWoHOhBSdm0w9h0FnulGJ2l448nyYGzHzzDLCZ0P8lMbaBE6z/G1LDqPwT6q9Oxm9ygeivzpaslEGmZZeSyR0fD58Rcc20U0CdLbibqrV15XNQ0BQwRZEdzx5t2mb+NaKeFxhyXUx5/WQSdV2D3/z9SUEbL5f5SVgl5hHorWk4GnB5oSHAVEedvCU1mKKKyr/6xAxEWnz4UEhXMG/q6PPm4RZ1X33XBRfcxlLT/2hmcfXMI7cqyXk6IAiPj58oKf7zVz9tw1ZXZ2X3Qdt9zygn/Om4OrJL0VavKKudtl9ZxfBYdK/ImH7/6TjWunjjZzAjooGo8SAHBU7dhud4SStjCCwSqhLRjlVm9Q5wGBlKDv4KOBybaW8n4yEgCHxaPYBmhwe/DY0mxOxp8Z5xwCbUd4OHZZsIRkZ7V9iPqDy0Mxp8wcJtgaGWW6Lz/VWAfUJUTgE0gXSm1i3HarpTKDUp/zeuzOyx9Svjn6Lbin6cJpzxuVjyWKriGS17bovSH80dXWTJHHwPtopxQ5IyuQIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(336012)(26005)(54906003)(70206006)(81166007)(2616005)(40460700003)(356005)(82740400003)(8936002)(4326008)(8676002)(1076003)(110136005)(70586007)(41300700001)(316002)(86362001)(47076005)(5660300002)(2906002)(44832011)(83380400001)(426003)(16526019)(36860700001)(7696005)(36756003)(6666004)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:27:47.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9037ce-fd99-442e-cf1d-08dbb9898f73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Iain reports that USB devices can't be used to wake a Lenovo Z13
from suspend. This problem occurs because the PCIe root port has been put
into D3hot and AMD's platform can't handle the PME associated with USB
devices waking the platform from a hardware sleep state in this case.
The platform is put into a hardware sleep state by the actions of the
amd-pmc driver.

Although the issue is initially reported on a single model it actually
affects all Yellow Carp (Rembrandt) and Pink Sardine (Phoenix) SoCs.
This problem only occurs on Linux specifically when attempting to
wake the platform from a hardware sleep state.
Comparing the behavior on Windows and Linux, Windows doesn't put
the root ports into D3 at this time.

Linux decides the target state to put the device into at suspend by
this policy:
1. If platform_pci_power_manageable():
   Use platform_pci_choose_state()
2. If the device is armed for wakeup:
   Select the deepest D-state that supports a PME.
3. Else:
   Use D3hot.

Devices are considered power manageable by the platform when they have
one or more objects described in the table in section 7.3 of the ACPI 6.5
specification [1]. In this case the root ports are not power manageable.

If devices are not considered power manageable; specs are ambiguous as
to what should happen.  In this situation Windows 11 puts PCIe ports
in D0 ostensibly due the policy from the "uPEP driver" which is a
complimentary driver the Linux "amd-pmc" driver.

Linux chooses to allow D3 for these root ports due to the policy
introduced by commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
suspend"). Since Linux allows D3 for these ports, it follows the
assertion that a PME can be used to wake from D3hot or D3cold and selects
D3hot at suspend time.

Even though the PCIe PM capabilities advertise PME from D3hot or D3cold
the Windows uPEP driver expresses the desired state that should be
selected for suspend is still D30.  As Linux doesn't use this information,
for makin ga policy decision introduce a quirk for the problematic root
ports.

The quirk removes PME support for D3hot and D3cold at system suspend time.
When the port is configured for wakeup this will prevent these states
from being selected in pci_target_state().

After the system is resumes the PME support is re-read from the PM
capabilities register to allow opportunistic power savings at runtime by
letting the root port go into D3hot or D3cold.

Cc: stable@vger.kernel.org
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v19->v20:
 * Adjust commit message (Bjorn)
 * Use FIELD_GET (Ilpo)
 * Use pci_walk_bus (Lukas)
---
 drivers/pci/quirks.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..4159b7f20fd5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,3 +6188,74 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+
+#ifdef CONFIG_SUSPEND
+/*
+ * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
+ * into D3hot or D3cold downstream USB devices may fail to wakeup the system
+ * from suspend to idle.  This manifests as a missing wakeup interrupt.
+ *
+ * Prevent the associated root port from using PME to wake from D3hot or
+ * D3cold power states during suspend.
+ * This will effectively put the root port into D0 power state over suspend.
+ */
+#define PCI_PM_CAP_D3_PME_MASK	((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) \
+				>> PCI_PM_CAP_PME_SHIFT)
+static int modify_pme_amd_usb4(struct pci_dev *dev, void *data)
+{
+	bool *suspend = (bool *)data;
+	struct pci_dev *rp;
+	u16 pmc;
+
+	if (dev->vendor != PCI_VENDOR_ID_AMD ||
+	    dev->class != PCI_CLASS_SERIAL_USB_USB4)
+		return 0;
+	rp = pcie_find_root_port(dev);
+	if (!rp->pm_cap)
+		return -ENODEV;
+
+	if (*suspend) {
+		if (!(rp->pme_support & PCI_PM_CAP_D3_PME_MASK))
+			return -EINVAL;
+
+		rp->pme_support &= ~PCI_PM_CAP_D3_PME_MASK;
+		dev_info_once(&rp->dev, "quirk: disabling PME from D3hot and D3cold at suspend\n");
+
+		/* no need to check any more devices, found and applied quirk */
+		return -EEXIST;
+	}
+
+	/* already done */
+	if (rp->pme_support & PCI_PM_CAP_D3_PME_MASK)
+		return -EINVAL;
+
+	/* restore hardware defaults so runtime suspend can use it */
+	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
+	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
+
+	return -EEXIST;
+}
+
+static void quirk_reenable_pme(struct pci_dev *dev)
+{
+	bool suspend = FALSE;
+
+	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);
+}
+
+static void quirk_disable_pme_suspend(struct pci_dev *dev)
+{
+	bool suspend = TRUE;
+
+	/* skip for runtime suspend */
+	if (pm_suspend_target_state == PM_SUSPEND_ON)
+		return;
+
+	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);
+}
+
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_disable_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_disable_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_reenable_pme);
+#endif /* CONFIG_SUSPEND */
-- 
2.34.1

