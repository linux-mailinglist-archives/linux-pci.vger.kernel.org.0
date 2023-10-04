Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE0A7B82A3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjJDOsG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJDOsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 10:48:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA4C0;
        Wed,  4 Oct 2023 07:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJQju9Amn651tb/mYgMZfcX1oMoG4rfY+PyZQ/pf+AvJcecyjAPLogPKyy9+pVEQPQ0JRzI+BcQ0Wts5PZdJsMWZmGxgbIcQaDc2QNC3H3Q8hE9fk0v+5j60zt6uuFCL+KcqYaVcsQfLWEV5D7AlTTjIixL9rOM62aZtpWN3c6T2NntdyNbf9UYjeHrWuVY5LkyFzajSyL6U8a06DKaoGioQS2OSfRKhmskGywhd0c66G+at7897ejxF84bs2RLVD6OFTUp9eIukOKvxJengUZNmuzjMhu5hwfyeqI/kFt29m/nbNP7bO/dvxGM6+Bv3XWodJ/RSTgIM0a1Psi69Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpqp2qNH9kU7dpWm/rVoLysJsuXZSUa4aDoqLRmqG1U=;
 b=Clu5TF2uBcroq4XEqRf9TrqCj9Lvrp33CSulbGz/g05jpCFSmM0DnRyX9/wPe013/qQqj2OR01iR+PfFRGLMd5Sis9t19bFL3bidvhSC6U0rnNFCtwR2D53/TSfm1vjTY8eG3HgrPBIXNLp7oz9ZiM0L3S+8FJKLf3PgJnkKm34igdCFDNHf4aIOXrQlrxoAS1vwTuMsMH+yohO/EJnRW2OB3mSDAmq+g5WbWLewZDWO4wJc7EUwzCXia7XFqopNTnt/b6I6uMgzBOfhCYRrI8ziHqmLrQdX/VVOtDYy8qCBaBwVE+YyEM+vQXhlQrxBzDgRtq+f06ZKi3X6qI9QIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpqp2qNH9kU7dpWm/rVoLysJsuXZSUa4aDoqLRmqG1U=;
 b=CUO4ifdYLH98IKGf7pOZKZDCSzGGW+GFjPOtCpSN1s6ifh+8bEAcRwYxFp6btw5kpc4cYTjLUEbYFzopuwxbk9dmKWIYQPn1sb3BxBFID2Z/uA5nSqseXDG6HuQNEtfbtTfJbnBnOZJj18oBN5L7UjpiG+Rgbqqtd11Y4b1OMZU=
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 14:47:59 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::d0) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 14:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 14:47:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 09:47:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <bhelgaas@google.com>, <lukas@wunner.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] PCI: Make d3cold_allowed sysfs attribute read only
Date:   Wed, 4 Oct 2023 09:47:31 -0500
Message-ID: <20231004144731.158342-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 7665f5bb-d4e2-42c6-eb0a-08dbc4e8e6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUD+Q+DhLANTYDjmJf7RQZgzsibvtmOY5ng/sAmngmzFuSK6tgwtW0CxaIlXYDTSSHVdEVtjP0TgAW23u0UxOpgTpHafuNgmdWZ4w1S4W3wlhJILyP5IUNQAlx3alabVMKqQ43tVf6CObUG0VS/pICye3+XeaZub77WE8sq6hFMuydgp3qAbxSByuXrb74sIFqAWiPPOV2fOvuI0AZbrqh5V0hgqm4RWwZ2G5z8jMWRfY1B08Eo3eRvGEGgPkXLqKG17nGEkF2aQ+5rBYN75fK2xbM89WzThCj8ruLpIOFDmdgMjCmqn4JXJYymsA5LIt00FzU1BzOn5E+n4dt2anhb4Z+VMcUKlA8VkruVqag0GxK5Mz2s2o02oN4/WdRuHVqZb2vd3QfAxFo7hUHiBdVUE1uBp4RakfaYCFE+gITqiZ/Q0+GsGYfmgHh+k7HQpUWmIebgeRPfCdoCdzOQzlGpGhcPXZdbTQNE9Oma7InkaGbconxUyruETdjb6avMzBeSviXtWRfO0BDeOQYPq9q98OL0o119UyHcS0hWRsPztoNcHnuf+GraTbotUMp4Vwg6wPXXydlcdwGxg29qpKu+9lyYSkHOt29F+zBBegYnsFQAuJHEGN8x59wZZf/jcvrsmA1Pk5JCV5Ft5Y7T7CZxmFn1DdrKZR3EEHml3S/wAtzmrD2miZpep99159yTMR4R/TEdFJHvQsvudifjODw5KGxdVQ+FDvzW7WP5C5vuWzRKycp0mBxmLw/usjp0JW1IDaVvm5XYynqBFEO4Hbhhj2tUt8KSUsbUf2Fm8jaQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(16526019)(2906002)(44832011)(5660300002)(26005)(4326008)(1076003)(41300700001)(8676002)(36756003)(40480700001)(316002)(8936002)(2616005)(54906003)(478600001)(83380400001)(110136005)(40460700003)(70206006)(7696005)(356005)(70586007)(86362001)(36860700001)(6666004)(426003)(336012)(82740400003)(47076005)(81166007)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:47:58.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7665f5bb-d4e2-42c6-eb0a-08dbc4e8e6bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before d3cold was stable userspace was allowed to influence the kernel's
decision of whether to enable d3cold for a device by a sysfs file
`d3cold_allowed`.  This potentially allows userspace to break the suspend
for the system.

For debugging purposes `pci_port_pm=` can be used to control whether
a PCI port will go into D3cold and runtime PM can be turned off by
sysfs on PCI end points.

Change the sysfs attribute to a noop that ignores the input when written
and shows a warning. Simplify the internal kernel logic to drop
`d3cold_allowed`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Leave R/W and show a warning instead
 * Mark deprecated in sysfs file
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

