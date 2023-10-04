Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC07B82AB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjJDOuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjJDOub (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 10:50:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC450B8
        for <linux-pci@vger.kernel.org>; Wed,  4 Oct 2023 07:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSAAtLKRy35KeLlDxhcwnhMNgZJRODuKeJBO6Vxelg3McQYaFEiEwjRF7ni9FqQSEJ6Pc6+2YdeRRGTT6D4rk4idbjSD4GL7cAIKKf/pYVhZajkyXRn8zQwGF0/CuRyLv9xjeRtTB6Zl3KXapyl8JBF1Va5juIlZEoWiWDZ1ALSYSt1O5bd9kXiAIj1+EQVxPaWO9d6pOJfef+ul+Sd/pB7IAKGKESHWV+0BjMzeTHvH9jenguQT5Fz4P9XZ1wE6yZaUbq9F2rMthaDFYYIYsk3oySP9oURR92yXm5FGpnCj4IbQyaob+PJibzFEC2M4kou6Sbvc/dBwdb1+8ZChDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIDL11m2PVelnGkJP1PE81gBJ6ftFBhQlBAFn232E94=;
 b=f0OR8PHwspS+ZATXLEOXEBzV2P5/AtQkNaQcPoTT2j4HgPkdshRnT/a0L2Tn++G7IHcxMtUw4nR1nXmbvnUSV2IHpbLpom6oaSEnHx8/IHFbHDvPDgaNjqF3EXo1SIVQ4bixPwZr4ipHd+u5AQueZhMZ7VMm+NDLENcQ1GYDcKgrtnMcRURHacxAbq/0v2sdiCMdqFn00IWPmLYfZI//D//fKOy9XFXjKBUVRA5GrJ5WsPgkNY522KsHfjc8WP1OuPmdC/BhkkzRxKU6Ga5RzUmPtY5dpz+OK8fP10OOUr8fLu3P9wK5hKKv4VHbZ6vvIu3NPPPmRctXI3Gw53QLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIDL11m2PVelnGkJP1PE81gBJ6ftFBhQlBAFn232E94=;
 b=yRTR66XjuzJOcR9LJqFBsUkBFGrOaGATS8ekIPQ7Y9616pOplpj6bPdP/FjEFCDzMxhLJvrzfsbvcSUfZaBbaMvJFvtCHrQBjzPx7JWWsth4xJjKN6Df6yho+IwU6ezij4Sq1D3FMc6HCfYh1DLqRW67snwX1wPfm5Kx3PaeNIc=
Received: from MN2PR22CA0029.namprd22.prod.outlook.com (2603:10b6:208:238::34)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 14:50:21 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::a1) by MN2PR22CA0029.outlook.office365.com
 (2603:10b6:208:238::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 14:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 14:50:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 09:50:20 -0500
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
Subject: [PATCH v22] PCI: Avoid D3 at suspend for AMD PCIe root ports w/ USB4 controllers
Date:   Wed, 4 Oct 2023 09:49:59 -0500
Message-ID: <20231004144959.158840-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 30090434-6356-40d9-64ed-08dbc4e93bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78UJuDG/z0xdjniaErdbpzqFMyXPYuseufDRFcK8HN3viTPn3jn4GQWdWrnmzAP9d1TCGL0qdylzKPTD/wslXM8GJdMZ/M5c25KQd8+9JNpeLgBeKWDAYR+fy/f4xLN1GzTjKuMQ9oU8T/NJIxqp/gMmOQSPlfxgA+D9BCWve2sDpULxaNl8sj6ELvrJlDXz2XgDnjge5H2voEw0T9t02w1w4iaOR7Pbo7ztZXf/CV1/zdZ8ABVdG9ffKe6o+JhwUFcENKtPNJ2KTQnfptebgvvNaXTGKGRRcff/fssIJScJK8N+sufjHsCgAsBu5gs43G5+YPq7GGD8fJp4TuAZ7z1kP8x96h8UpmXcNvFrGxjC+7/dnvO2q7AV5lwwdF9YD3ga6F8PHCkNKNIiEx+D9GaBYzrAJdDH0WHODvG5CoH4uvf01rsdFBiLMbbCCU4W6GtkBMsbdps50nif1MMNHpS0NqJBQde01YUZwRPk3/hZhQM8ydlBsqd7PhT0CTGofs7B8DN7p+sLS9YDMOWXCHOkI1y+GsfmV+fBPHyiISov2H6LSBK+3/0uSqWgSg5CUj6ZkMDLQeYw7XFmJk+Rwab02VyVnjRTueFSNuJtVSiKhZj7sGUhC1NEP1FNkagXLHBjm1fwLD39JUfmS8nD9sQ0PR0BMas6HSWopJllS9DV4T3S0RUAXeKqUs/1C87uS4y3WozIe9oCMWSiNRVe+QMTilfk80VJ/r29zUjEOVWHrUla8+sPStvSoQjnzS4urLIbmhrZncqtGOJyHf9hqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(336012)(36860700001)(66574015)(83380400001)(44832011)(5660300002)(4326008)(8676002)(8936002)(1076003)(2616005)(16526019)(26005)(426003)(47076005)(7696005)(82740400003)(6666004)(356005)(81166007)(86362001)(40480700001)(2906002)(478600001)(966005)(110136005)(70206006)(316002)(54906003)(41300700001)(15650500001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:50:21.0100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30090434-6356-40d9-64ed-08dbc4e93bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED,URI_TRY_3LD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Iain reports that USB devices can't be used to wake a Lenovo Z13 from
suspend.  This occurs because on some AMD platforms, even though the Root
Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
messages and generate wakeup interrupts from those states when amd-pmc has
put the platform in a hardware sleep state.

Iain reported this on an AMD Rembrandt platform, but it also affects
Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
generates the PME. To avoid this issue, disable D3 for the root port
associated with USB4 controllers at suspend time.

Restore D3 support at resume so that it can be used by runtime suspend.
The amd-pmc driver doesn't put the platform in a hardware sleep state for
runtime suspend, so PMEs work as advertised.

Cc: stable@vger.kernel.org
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v21->v22:
 * Back to PME to avoid implications for wakeup (Bjorn)
 * This is the submission that Bjorn sent in the mailing in response to v21.  It
   tests well, so Bjorn please add a Co-Developed-by/Signed-off-by for your
   self if you feel it's appropriate.
v20-v21:
 * Rewrite commit message, lifting most of what Bjorn clipped down to on v20.
 * Use pci_d3cold_disable()/pci_d3cold_enable() instead
 * Do the quirk on the USB4 controller instead of RP->USB->RP
---
 drivers/pci/quirks.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..4b601b1c0830 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,3 +6188,60 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+
+#ifdef CONFIG_SUSPEND
+/*
+ * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
+ * if the SoC is put into a hardware sleep state by the amd-pmc driver, the
+ * Root Ports don't generate wakeup interrupts for USB devices.
+ *
+ * When suspending, remove D3hot and D3cold from the PME_Support advertised
+ * by the Root Port so we don't use those states if we're expecting wakeup
+ * interrupts.  Restore the advertised PME_Support when resuming.
+ */
+static void amd_rp_pme_suspend(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+
+	/*
+	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
+	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
+	 *
+	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
+	 * sleep state, but we assume amd-pmc is always present.
+	 */
+	if (pm_suspend_target_state == PM_SUSPEND_ON)
+		return;
+
+	rp = pcie_find_root_port(dev);
+	if (!rp->pm_cap)
+		return;
+
+	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
+				    PCI_PM_CAP_PME_SHIFT);
+	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
+}
+
+static void amd_rp_pme_resume(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+	u16 pmc;
+
+	rp = pcie_find_root_port(dev);
+	if (!rp->pm_cap)
+		return;
+
+	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
+	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
+}
+/* Rembrandt (yellow_carp) */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_resume);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_resume);
+/* Phoenix (pink_sardine) */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_resume);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_resume);
+#endif /* CONFIG_SUSPEND */
-- 
2.34.1

