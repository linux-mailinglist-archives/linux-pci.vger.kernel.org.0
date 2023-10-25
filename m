Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF047D5FB8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 04:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJYCGR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 22:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjJYCGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 22:06:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18EA10E4;
        Tue, 24 Oct 2023 19:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2x9YqB2NlHJ1wANb6a+5ws0YdBX3vsjkt2/PRvDZ6WVqRq+uCJr1h8waxQKENkrEzICJNxTJXx2Zl+1ed8VTjUKnPYuVK64ZntHNWxSH08W82WQue1h2mjojOs+E2Ln30DnTESHiNK70bC3v/XE99xCZrwgwKGyW/UwYXd792ztOAWGF6BEbhiQOjETyoaS9L3z87ikMhh8JGXzbrZOL7WLztVuIlRWMG/kf8gjvdErcq4tJOrLpwHvVW0lh6T0cB7u5ZOysGMXgGcXKjc7YUdibJY3vZLqMDCTej0zSzE9Z3Tsl7wG5nXxboNCEkbENn6Dnxnz/qnrWvzVxW73lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFiX9EXXuC5AphQlOCTSzBjRFt7sYTmuPaVEd26TXvc=;
 b=HNpMUBzMMVG1YPEkOu7uhJ7ni34EYHeY7lf5NEOVX8oAElXdzANT2QEwQIeswYBOJ6VKOZd8b2suvylsi0h+wKVcX1S+KmpBiCFkbVQuvUtLUWxpABDN047Kx4FffDtt9BaTpbwjddI7LIsTn3y0e0e29jBuWPaeq0G6TDf413F2dqj3PYNKn8JySvZUDC/+Z9VP7Qm6/lzdqlN5gfAm2g7w9+LEKnChrU9A3PTN/xIm5sai0vhOA5dSEa7KWyE/s2FdxxGy2K7LyPqKQ1sVe+zmw1qzbLTayOKuhCOsg1W8jVcMePnkN3mjW+36LpQwxCa9g1m3WJguz7AhjipIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFiX9EXXuC5AphQlOCTSzBjRFt7sYTmuPaVEd26TXvc=;
 b=gpKGP4L8NWADkgnTH5HuCytkDb6jK2OGWl90iV0vo6BEVvbd0nq90DC/ZzndUnYwyWqWAXcpVWE5iU3lJWDjkT/HHX/uJzzfmDWgtBQbvAfp3yNSVsmv+UERIOrXvqL18VNrqPrPebNEUcu4ZcwgCLms75WcQByihvxkvFcTrXk=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:06:08 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::fe) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 02:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 02:06:08 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 21:06:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/4] PCI: Make d3cold_allowed sysfs attribute read only
Date:   Tue, 24 Oct 2023 21:05:43 -0500
Message-ID: <20231025020546.504-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025020546.504-1-mario.limonciello@amd.com>
References: <20231025020546.504-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a33660a-69c7-45ee-bb21-08dbd4fef400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 025Luz6E2ySYlzM8KZccO3dhJc3ioCEIYXjiq2ZPsGa6tFobxIQ/OItRoyD6gLXYJk+W7uTkrphnoDD5VZnLdUzbeQ3s4ZUW3saTyiOZ5BoxzmbI9hrUlb2pVtlcYAX9PxNd6iaidMDAbDnUD/rQVQZy75sMpS5OdLTa1Mr2o3HmspFK84Rw9mSMUfjcPJOSnHsX+GgGSWLrzbHs27f/LGeAOxn9LqByo2wxH0mlArb1PofvTXb1skJ4VUKop+L+xfNeDC/SDDDkbXsBwfyOkqSaKLAUotTFZXEzE4C9gwb5v4LjyzfqYf6liGQ7Hxs7gS5YadCbKF0Z7+9oGPZS0LfT063bTZJGVgZaezwvANLk/A1QW18t67lFFKExo2hOn+X9bskuGbpwLE/R0DQjsqB/25J9kwu0y4ohXNE56mbb5umjRV9iB/+m9pb4TJOl2YvAqq8GD6rhFWVaDw9fy2lr0fxFi9sHdiH0UZ/NZK08yrqc3l7bY3rnxN+szTBXIktx1i3tDB7AJ+uU2SPpe3P/8WKUKZ/8NYmY5jGxNb0FzXx/UzAAyJa9C5UovcGdcUI0VAgbjmz0c3PkXPyhQyYwkBYmluXa4c+xVZiuMGmACe2opnykOaKwdiiZdwDxkc/z07olAAHib+l1d1R5LFxjZWyY/B2YyADNn9GIQAXJnuLCZey2NNpVxJsgiUzYG2iBt5n+KeHTfja4xZhql+SATDd8kR363+biXK/a7XY4jhTeuFX/c1JEFU+XYiumvHIiP1PKqEJGWhNedor1AAGSFjY1F41FLaV+tevU4d4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(26005)(86362001)(41300700001)(2906002)(36860700001)(40460700003)(44832011)(5660300002)(2616005)(36756003)(8676002)(4326008)(8936002)(7696005)(16526019)(478600001)(6666004)(110136005)(81166007)(1076003)(82740400003)(356005)(70206006)(70586007)(54906003)(316002)(966005)(83380400001)(336012)(47076005)(40480700001)(426003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:08.1964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a33660a-69c7-45ee-bb21-08dbd4fef400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before kernel 3.6 D3cold was considered "opt-in" for PCIe devices.
Userspace was able to opt PCIe devices into d3cold support by using
the `d3cold_allowed` sysfs attribute. The policy changed to default
to enabled with commit 4f9c1397e2e8 ("PCI/PM: Enable D3/D3cold by
default for most devices").  The sysfs file remains however and
can potentially allow userspace to prevent the SoC from getting into
the deepest sleep state on modern systems.

For debugging purposes `pcie_port_pm=` can be used to control whether
a PCI port will go into D3cold and runtime PM can be turned off by
`/sys/bus/pci/devices/*/power/control` on PCI end points.

Change the sysfs attribute to a noop that ignores the input when written
and shows a warning. Simplify the internal kernel logic to drop
`d3cold_allowed`.

Link: https://lore.kernel.org/linux-pci/20230918132424.GA11357@wunner.de/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from previous submission:
 * Update commit message
 * Roll into series for D3 related handling
---
 Documentation/ABI/testing/sysfs-bus-pci |  4 ++--
 drivers/pci/pci-acpi.c                  |  2 +-
 drivers/pci/pci-sysfs.c                 | 14 ++------------
 drivers/pci/pci.c                       |  3 +--
 include/linux/pci.h                     |  1 -
 5 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..b5db141dfee6 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -283,8 +283,8 @@ Description:
 		device will never be put into D3Cold state.  If it is set, the
 		device may be put into D3Cold state if other requirements are
 		satisfied too.  Reading this attribute will show the current
-		value of d3cold_allowed bit.  Writing this attribute will set
-		the value of d3cold_allowed bit.
+		value of no_d3cold bit.
+		Writing to this attribute is deprecated and will do nothing.
 
 What:		/sys/bus/pci/devices/.../sriov_totalvfs
 Date:		November 2012
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 05b7357bd258..a05350a4e49c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
 
-	if (pdev->no_d3cold || !pdev->d3cold_allowed)
+	if (pdev->no_d3cold)
 		d_max = ACPI_STATE_D3_HOT;
 	else
 		d_max = ACPI_STATE_D3_COLD;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5e741a05cf2c..52ed5a55a371 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -523,17 +523,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
-
-	if (kstrtoul(buf, 0, &val) < 0)
-		return -EINVAL;
-
-	pdev->d3cold_allowed = !!val;
-	pci_bridge_d3_update(pdev);
-
-	pm_runtime_resume(dev);
-
+	dev_warn_once(dev, "pci: writing to d3cold_allowed is deprecated\n");
 	return count;
 }
 
@@ -541,7 +531,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
+	return sysfs_emit(buf, "%u\n", !pdev->no_d3cold);
 }
 static DEVICE_ATTR_RW(d3cold_allowed);
 #endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..8c5a6f68f63d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3067,7 +3067,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 	bool *d3cold_ok = data;
 
 	if (/* The device needs to be allowed to go D3cold ... */
-	    dev->no_d3cold || !dev->d3cold_allowed ||
+	    dev->no_d3cold ||
 
 	    /* ... and if it is wakeup capable to do so from D3cold. */
 	    (device_may_wakeup(&dev->dev) &&
@@ -3204,7 +3204,6 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
-	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
 	dev->d2_support = false;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..5f4ed71d31f5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,7 +376,6 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
-	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
 	unsigned int	wakeup_prepared:1;
-- 
2.34.1

