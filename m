Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C77B59A6
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbjJBRsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbjJBRsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 13:48:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F26CE;
        Mon,  2 Oct 2023 10:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr76gXLahXsyHRng6QSTDCMmHMWU7E/T8ZlQ44iggB3pHIe4qciQWjtkY/VFTzA9lFwwHr/n+G69mrckMOiQHNXk8sfto9uxIst6iMam5yrdAs48vq6ygMwJcz2aeIGZOFcKSFiVP8vuKiMGgmSZ1Ham2+QosSKZwByWC0C2pnglcxaJKN21r2NgMVk1OxLyPUa1J5An0cVEoF2rNfaPBz+35S8NtXcyMUw9kpiF1A5lVzsaHeNPYuvulOt8BTwpyyALFfYcUsq/OwzrUhVFpvGo0C4T7SwcKevhhYzhGcJ4r0lhKKoVVbOYsULi6O7lqyLUn5uQkEbsamXtLnYVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7K2RTXbP3KUHZ+rjqHKRn8tdUYw6cspuKgzcyM+ET8=;
 b=lnz04N9eWNtCa3Yxym2h4gpLxZSyCU2H1+iVxbiLCPAP4zyFNVpVApPEhRo3AXiKqkZq+x4oIHrgv8ORZ8oW/+b65InZyP/Bkg/CTBbXL/sMV7Xb5+Y/omj2xz2OaEZTmWsPfVE2FaVdq5lAf/syfJfZXTT4M2ahuR1Wna374QY2/M31knzQun40dMGMioqGsnlS8ogd8nXuazAXoQxRNODT1U3k4fsuxTjj/PnT3g4NQ4YhL7++I196VBH9Pcs6p579TMwR5ByXZ7zjM0HrO/fEeY/p8gN6Od0cLSjUXvXVcS7YEpgME7mb7zj1X7rl8dSDOfrmVBGIEpoC/zd/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7K2RTXbP3KUHZ+rjqHKRn8tdUYw6cspuKgzcyM+ET8=;
 b=x22pbL75gGHMdeE+W4U8m3lGKmuc/6XYcNI3VjDnQYP4jS/TBSLiJFQpAOLH32g3K4njP9xLZaSb93plE9ThhFTR2XMhjH6ct+U6DKD2dVPR3FAa1KRgQ8xLRY9MceCQIe8k33SAHxArFOPRrtARAQzXNfk5pLmDJ3RC2iz1hTE=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 17:47:56 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::9d) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 17:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Mon, 2 Oct 2023 17:47:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 12:47:55 -0500
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
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/ USB4 controllers
Date:   Mon, 2 Oct 2023 13:09:06 -0500
Message-ID: <20231002180906.82089-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BL0PR12MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a314c55-97ac-45b9-5beb-08dbc36fb623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 702oNlwW6Nn3DC5XXe4XIqGRGfbOC30idgyI1PPbGAEQZNqKaKelMozGjC6xPBfYTDNuPbhuNRM9QBY5px5KwNo8e4YQEMVwaRqvLZKe6nL9eMUEOo9h7jQRkCmVJ+D72Jg9n8lZUebTI3tUSD5HmMzIAFV15dW+jI7mMhWq87KFDNPP3RxqVk6umRGm+il8yJT7nwgX7yawh/mGeboGEY956JeLjDsX72Ua9tdqHNs4ZB01PVv7vN9rDWiHsJTbKrgT6/xfJG4/cfxlhXIiHYNp9iywHpyy6bAzemosuGO4ekUJ+PDgrUM9Cj5xQabtm69fD1vCnlZyY8X1HjBQXKIcpG1hYuPGfLwk8eNn9iTEDbziKvDwc56hN3h/yMxNYujznW7EP5/LVl9/X+agoP8lWRkXzn8sqHlw/AKCSSl63wQOVC7aFZeYAX7ROx9Rk3clVIiccs8i4wEIhuU/qAJFqhn4h3jJOwcOsYorkbGfGYQrsySCVScSC3y53hx6GgnXe2jw6zC7uQnI75ZopRz6RNf7ZM27bSPd5RP2vevgyJkFxoL7HanoORRvXiUfC95eZaaFbIJ3Q86yk3bjN3a9IluHMhTmjGGfcLWHWKNbQ7morfXRQ6xXurAGF9+qi/fLv3MhX6w/5/Ko0TrHoYZRGJo9O6SwO29cpuzWHb730LcWfNdM3uhcPOAxCltzAf5dUomXqWO7kp6+dLCfpbrHpl4c8eR4PLuRwA94dgN4v4EX9crPpCLOTu/ghrzDGSb3QL5rqEuJgxm5VRyyzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(7696005)(478600001)(966005)(6666004)(426003)(66574015)(15650500001)(336012)(26005)(16526019)(2616005)(1076003)(83380400001)(110136005)(316002)(70206006)(70586007)(5660300002)(41300700001)(4326008)(8936002)(8676002)(44832011)(54906003)(36756003)(2906002)(36860700001)(47076005)(86362001)(82740400003)(356005)(81166007)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:47:56.6051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a314c55-97ac-45b9-5beb-08dbc36fb623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URI_TRY_3LD autolearn=no autolearn_force=no version=3.4.6
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

Cc: stable@vger.kernel.org # 6.1.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
Cc: stable@vger.kernel.org # 6.5.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
Cc: stable@vger.kernel.org # 6.6.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v20-v21:
 * Rewrite commit message, lifting most of what Bjorn clipped down to on v20.
 * Use pci_d3cold_disable()/pci_d3cold_enable() instead
 * Do the quirk on the USB4 controller instead of RP->USB->RP
---
 drivers/pci/quirks.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..5674065011e7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,3 +6188,47 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
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
+ * When suspending, disable D3 support for the Root Port so we don't use it.
+ * Restore D3 support when resuming.
+ */
+static void quirk_enable_rp_d3cold(struct pci_dev *dev)
+{
+	pci_d3cold_enable(pcie_find_root_port(dev));
+}
+
+static void quirk_disable_rp_d3cold_suspend(struct pci_dev *dev)
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
+	pci_d3cold_disable(rp);
+	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
+}
+/* Rembrandt (yellow_carp) */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, quirk_disable_rp_d3cold_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, quirk_enable_rp_d3cold);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, quirk_disable_rp_d3cold_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, quirk_enable_rp_d3cold);
+/* Phoenix (pink_sardine) */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, quirk_disable_rp_d3cold_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, quirk_enable_rp_d3cold);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, quirk_disable_rp_d3cold_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, quirk_enable_rp_d3cold);
+#endif /* CONFIG_SUSPEND */
-- 
2.34.1

