Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4D7A148F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 05:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjIODsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 23:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjIODsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 23:48:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8339196
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 20:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKFSqmUzu0CQduTtBBybn8gub3J5VsV37a+QgyW9EjQw8A7V1BFZpeaw2+fw/WXJ7l3wSUJeAyu8qfnFtZmimsqNAFQIOEjRtYgPffDJ9whbIs6W1xwAoHGf95CcGfM+a2eyLEh0m+RLRzmna21KVIC8qN/wwmzlJyMn+B3a30J//pV+U4yNgq4uFpFI1ITg0DbY9BQ5g71zGM7a9Fw9Mytv0Kyq3VNx48V1YZr1TrQhMaW2KNNB95vueWXMzVEctCvVlim8O1INIYc0pyA5vFIGBuf6dxBsCkAgea/dJSsbOEj3fc+088JsT3BX/BhMt9IHNTvWO1COfHCzwD7uTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5s7Q+iSzvXLKuT/QPMSj0K1v1qv3Kr37HtECqIw0rVc=;
 b=fs36dMt8ZYJVq2+mLWT25Ni3zeQsHGphYUe0mCVCmKzgS0pK0/qt831Kbad2EhGc+QyABGmpnrHv35dEfYJ46zARieLMDIgs3mNx0mbOxQx59szjAGrhaPeiX3LVFE6r83V2v5W6tY8jflSxy07Vx+G0d5MDzI71hzM41syadsIwZpFpAy1RaOjkFUhNVaXSGwSc3f6Xc3PTaQbszaY5bs67ZR0synqquleTwLhCrTgWxHJiUvvIJcGOWZFqjZCE8zPJOomLVj8OlvqML7ADp5PK4eSphRKluaIuWt4ndhjpeFU1qYZPyfazyHBRn1f8Vq3dc3fi8HHmoSehc37w3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s7Q+iSzvXLKuT/QPMSj0K1v1qv3Kr37HtECqIw0rVc=;
 b=0euwEhbJUlDjuTW3rTrh06STU2HAPl280QVoaxEVeaka/hv7c01MtPy7LFg2cu8/gf7ce9Dc/09lb1HoTM5Q1WgFbXjwVd4ZHKXMwp9C5T3q08tUgmayT4g/t92i3JI4CYysB97Kc/ODyahUqknDIbQexaSasclmQsnz/tjgTlk=
Received: from BL6PEPF0001641B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:10) by SA3PR12MB8023.namprd12.prod.outlook.com
 (2603:10b6:806:320::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 03:47:47 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2a01:111:f403:f902::2) by BL6PEPF0001641B.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 03:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 03:47:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 22:47:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <iain@orangesquash.org.uk>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers
Date:   Thu, 14 Sep 2023 21:33:54 -0500
Message-ID: <20230915023354.939-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915023354.939-1-mario.limonciello@amd.com>
References: <20230915023354.939-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9185b4-7949-48f6-ba3d-08dbb59e8662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4T2HDG3sKfgSzlfU591JmaKkFwNzgfepKeX4p0uHPIoZ2gxOutSH9i8AFmKz5SIVR28tbIt0La8txYdhlUIpQdp+QAeDql8KI8aziDDMHV3rb+gOxQs2loyRXzBbOVQlk+V1RaJ9cfu/MgBpJfW/zFhbL5IKcq9kCGVdeJrzxPm+Qc5LhZxmXhR9r66NcK6JojEknosLB6GtLf5jCjNymFigJ+JqSXVHRASk3LIkGfhZjCsiqMedIKr+P/31gMBEjHcHhqKfQ7CnsM447d+522iKFI+ePC1CFbvWZf9mhQDaYVGFwm5L79I/6yvGjU7lrM64ws2aGHu5FU2l9X/jG4tkF8j0efXoz/GYpCMlpDNKjJ+iP9jPSTE8/DoRlOENrEwHDr1alni0M4X6+59PZpWip37FPumWUIMM6BN7kxfzDi98yyfyVe7ZMEPPyC0IIbdJZggh2uM+vEe6RodZRU4lYYbayYd8pI0iGlSG2fD5LKHcvChFtc63VwvnaOp566EfTct+eNX1EDL2OhoB8rhKOkry8uuH5QBmKXdBvque7ap5Hxu82n8yJPambmZbhLaovAITSMAAFm5etw8xMi/kL5A2lTrxqVrFVyR9ZHiidlQ2qtD9O9grVmSl1++AdmwUfdOe0fDZmOlk93DLe0FIo2RHK2zQ8auwfAmr41wAABjF4EXtIEqZREL6Ytgr0/in8HUBa6ZyDLTctscBPMpE79Cmb9F8q/QRhyr2dYTGpwRArRWsddzapqsU1RugHf5RPnozQaWV3wUu+7wYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40460700003)(40480700001)(1076003)(478600001)(966005)(26005)(426003)(336012)(5660300002)(16526019)(70206006)(110136005)(70586007)(54906003)(316002)(44832011)(7696005)(8936002)(41300700001)(2616005)(8676002)(4326008)(2906002)(36860700001)(47076005)(81166007)(82740400003)(356005)(83380400001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:47:46.6822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9185b4-7949-48f6-ba3d-08dbb59e8662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Iain reports that USB devices can't be used to wake a Lenovo Z13
from suspend. This problem occurs because the PCIe root port has been put
into D3hot and AMD's platform can't handle USB devices waking the platform
from a hardware sleep state in this case. The platform is put into
a hardware sleep state by the actions of the amd-pmc driver.

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
suspend").

The Windows uPEP driver expresses the desired state that should be
selected for suspend but Linux doesn't, so introduce a quirk for the
problematic root ports.

The quirk removes PME support for D3hot and D3cold at suspend time if the
system will be using s2idle. When the port is configured for wakeup this
will prevent these states from being selected in pci_target_state().

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
 drivers/pci/quirks.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..ebc0afbc814e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,3 +6188,64 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+
+/*
+ * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
+ * into D3hot or D3cold downstream USB devices may fail to wakeup the system.
+ * This manifests as a missing wakeup interrupt.
+ *
+ * Prevent the associated root port from using PME to wake from D3hot or
+ * D3cold power states during s2idle.
+ * This will effectively put the root port into D0 power state over s2idle.
+ */
+static bool child_has_amd_usb4(struct pci_dev *pdev)
+{
+	struct pci_dev *child = NULL;
+
+	while ((child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child))) {
+		if (child->vendor != PCI_VENDOR_ID_AMD)
+			continue;
+		if (pcie_find_root_port(child) != pdev)
+			continue;
+		return true;
+	}
+
+	return false;
+}
+
+static void quirk_reenable_pme(struct pci_dev *dev)
+{
+	u16 pmc;
+
+	if (!dev->pm_cap)
+		return;
+
+	if (!child_has_amd_usb4(dev))
+		return;
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_PMC, &pmc);
+	pmc &= PCI_PM_CAP_PME_MASK;
+	dev->pme_support = pmc >> PCI_PM_CAP_PME_SHIFT;
+}
+
+static void quirk_disable_pme_suspend(struct pci_dev *dev)
+{
+	int mask;
+
+	if (pm_suspend_via_firmware())
+		return;
+
+	if (!child_has_amd_usb4(dev))
+		return;
+
+	mask = (PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >> PCI_PM_CAP_PME_SHIFT;
+	if (!(dev->pme_support & mask))
+		return;
+	dev->pme_support &= ~mask;
+	dev_info_once(&dev->dev, "quirk: disabling PME from D3hot and D3cold at suspend\n");
+}
+
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_disable_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_disable_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_reenable_pme);
-- 
2.34.1

