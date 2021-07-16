Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA1F3CB9BB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbhGPP1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:33 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:52672
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240892AbhGPP12 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T63tSswUejcoMz0rU0esspATMwyo46SSUdUBT9oJkFl5ETbgOes3OBh65BpZO2hhvPafzaPDj5K2gzSnvtpyX7pxoyDuB79mrYx3ItXrrCdMrpgI//i+WZUBrG2MYitpLUW7PG3CKLYJpDFd8J0WP+IeUQ1lNJtQtXpWHcmipAwPXrBZfn2HEpsv3MYuntvzt4oWc97zetpHBWqyKujdVGZCBAajSklMZwRtswM6b3LWjN+rolTAGpu/tcQgbvFBm/w+3R5N8bhfPl1zoOO5ZhPIargYAALc5oLYUKnWx2uJP5fjHM8htuQ0nzUGGksgfkD5o9vt6cqqbEeRXzOblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl+5ztjPoWm2qZQ0S94/WMf9XlisuAxbrMhd3ecEYH8=;
 b=FVJckbIjE348BksNZf+hmwRVDA/bF/xpIK3vbZbC3CvQNKwUKCwneyt1NROWa59yHtZuYT28X1x/wDq3Wiiu8jHhRtFY8eFCSbbDk83ksQKx3oaMfvCjDbRCSWPJ+EMc/ZQPpleRp0zv4aJFMDX9UMAJ7xoSDcSgyIagVIqDHJcy3xopiXxSF4hZZfXQQTtNGZgNGY2ByBIpS/3fDFd2ObfBWhpjETpHVtVtykEW9p2wR/qWDOaSOPTO8K3DZPZDuMcmuPhZvZyRiQnm/d4+xqPJhU7agXTNDE4rwfJhEFXroDcUWRX2Q6d5WEnUq+sYLpVT76r2e8cWUFG3kQdTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl+5ztjPoWm2qZQ0S94/WMf9XlisuAxbrMhd3ecEYH8=;
 b=gTWJtcaSEhroZCKD76Vu06QD3HKuBeMAUcE2ZuQt1XoegseCyN6IR+Ry7e6fdxz5IzrGvMfxhM9+riMIu3Vbjlo/j+w6mNmh7b3M7mvlBjrh+ETTJbzRW2Z4Jn4/YeYYr9rtxHeb0DYnmCLJZ0fZud1i5TXAegm6A5N8nJ6l2rEJ++Wb2qRsWGpDbx4MNS5vysXsciz/y3vUcp6fFMmon2j+dc3XfFS9Jf1zZ/J1Sswa33j0ce4AFEWBPHOCgWdtW3Oeq/bc5IcMo0hygUFnI6WUADoe1X0ycm5WAEaTrj7+/zTFW1c9yOUKjBB13Kp7pzSu8v/v7JoPSkq9rlHioA==
Received: from BN6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:404:8e::32)
 by BN8PR12MB3155.namprd12.prod.outlook.com (2603:10b6:408:97::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 15:24:31 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::77) by BN6PR21CA0022.outlook.office365.com
 (2603:10b6:404:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:31 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 15:24:28 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v12 3/8] PCI: Remove reset_fn field from pci_dev
Date:   Fri, 16 Jul 2021 10:19:41 -0500
Message-ID: <20210716151946.690-4-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716151946.690-1-sdonthineni@nvidia.com>
References: <20210716151946.690-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83cc6e2c-9db7-4354-a7be-08d9486dcf2e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3155:
X-Microsoft-Antispam-PRVS: <BN8PR12MB31553B261D27FE92B06954C2C7119@BN8PR12MB3155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3exZ0Of7SsVddA9bCKH0rNftnhelEvtu9witenCTYvQTEURQzrok4eY3bN2B7HqKtmoJlscxhNelDYhlBxBW+FtavwZxMmnpY74wEqrqR4y7P5Z2IWagwZlbCYWjFy7+eMfszKvx7hGtdKisE2OnjqCiXkS8flPH7gfAWul/aV5W8s0ES0gjgrP/sODGEDWFuR7l3A+3ihSlK7bXMdKUw+aBTeRi41SKxT8Vp5SG5SOwEGOtgv1purKwb+8+jACxJ2P2YqWfV8bVrc5MOttU9hcH+/HBmWDDS+JKt1Y6LLLseYzILut+a77fiB7c9M7vHpInI5rR04tcSnDvTWLl8KgOaMaX9Db6nizcVWcPdXHQ5/xd37zyhKNc3iqH+yzJG/2I0SGbOoX70VABgmIuB3qM93J5l38P1wLzhjM2n2rgXee00gSLLuMwXGjCyozR5cYdJ+CdGoEauaggqbFgrIXbE9UoxQ/5NFt+ciVdPM7DFmF2hUV/ROr63wgxfARbCpgmKbSg0hFXHLi9DFxx8v75lPxjqdNgdT1V6QqKoBoIs6axyfvpRrThO5Ld9ug+zHP7xun3e93auTEIACK26fRqZ06DGZ9Yw+uX2+4WpRr3HoMPFgJqC03kea25hCDZoj6nKZLhhvRKPjSGzyiU7enYfxhHSAkxc4/JoeWr4E5ATel5vPaLEQJVhb3HOxmlLYqAv9su4rYQDoASwy7gCbDgMy24ix06I/6O1eJajYA=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(8936002)(2616005)(2906002)(82310400003)(6666004)(70206006)(316002)(34020700004)(186003)(82740400003)(47076005)(5660300002)(426003)(16526019)(70586007)(478600001)(8676002)(26005)(6916009)(83380400001)(54906003)(36860700001)(336012)(36906005)(7696005)(7416002)(86362001)(36756003)(1076003)(7636003)(4326008)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:31.2453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cc6e2c-9db7-4354-a7be-08d9486dcf2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3155
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

reset_fn field is used to indicate whether the device supports any reset
mechanism or not. Remove the use of reset_fn in favor of new reset_methods
array which can be used to keep track of all supported reset mechanisms of
a device and their ordering.

The octeon driver is incorrectly using reset_fn field to detect if the
device supports FLR or not. Use pcie_reset_flr() to probe whether it
supports FLR or not.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
 drivers/pci/pci-sysfs.c                            | 2 +-
 drivers/pci/pci.c                                  | 6 +++---
 drivers/pci/probe.c                                | 1 -
 drivers/pci/quirks.c                               | 2 +-
 drivers/pci/remove.c                               | 1 -
 include/linux/pci.h                                | 1 -
 7 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index ffddb3126a323..d185df5acea69 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			oct->irq_name_storage = NULL;
 		}
 		/* Soft reset the octeon device before exiting */
-		if (oct->pci_dev->reset_fn)
+		if (!pcie_reset_flr(oct->pci_dev, 1))
 			octeon_pci_flr(oct);
 		else
 			cn23xx_vf_ask_pf_to_do_flr(oct);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7c18206..a1d9b0e83615a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1367,7 +1367,7 @@ static umode_t pci_dev_reset_attr_is_visible(struct kobject *kobj,
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (!pdev->reset_fn)
+	if (!pci_reset_supported(pdev))
 		return 0;
 
 	return a->mode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d5618b232363..cc9f96effa546 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5233,7 +5233,7 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_lock(dev);
@@ -5269,7 +5269,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_save_and_disable(dev);
@@ -5292,7 +5292,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	if (!pci_dev_trylock(dev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4ce7979d703eb..66f052446de20 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2431,7 +2431,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
-	dev->reset_fn = pci_reset_supported(dev);
 }
 
 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 90144fbc4f4ea..f43883a2e33df 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5626,7 +5626,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 
 	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
 	    pdev->subsystem_device != 0x222e ||
-	    !pdev->reset_fn)
+	    !pci_reset_supported(pdev))
 		return;
 
 	if (pci_enable_device_mem(pdev))
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index dd12c2fcc7dc1..4c54c75050dc1 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -19,7 +19,6 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-		dev->reset_fn = 0;
 
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c2d3a357eedb..58cc2e2b05051 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -431,7 +431,6 @@ struct pci_dev {
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
-	unsigned int	reset_fn:1;
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
-- 
2.25.1

