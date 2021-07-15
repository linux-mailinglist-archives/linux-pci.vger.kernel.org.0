Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3346A3CAE93
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhGOVfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:35:09 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:10161
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231325AbhGOVe6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:34:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om05Im7BWkOsQ+KeMCaC/PL2PVdYKkYgyWJpqg2poGw9yOZpX/AC5oGdVBaj3gj+5g1eTDvbC4IdWcKo/tYM9SidBvD9PtpoMrjtHzoy88O7K+fKnjbe+xCUoK1IV7zgHVwLeZ2IlRQ0hmWmUFqPwaEsYQT49jh0iczYoCJl00K54xxp2fwYBitxAedDZjLuYf51T+32QOJqLZ8pWwRu2t7Qrm/FwqEyCdMkavUSAjxc9Sb8ytEArUGaEelqDMIh8Wv1mDC53dMo6xoTYFnK/lGU3s4bVn+GCe6TqFXW+dxYZdmKmF3Phw9WYGo23R02nBASqGNILZGcfOgb84Nvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl+5ztjPoWm2qZQ0S94/WMf9XlisuAxbrMhd3ecEYH8=;
 b=FjQ09qS7U4uBjJgVDTzc+uh3cuiTHOCqxxWBaKG1YI1I6nIxR+K2WONHDJKPHlcFVeQ+ImcoTuUpHRlu5j8WSfjAJWtJENI7icG4cmNIDbrtte1o8doJ5d5vrpR1HHm2v+CrXVMWRqbTcO7nXhbh5okKIG4LkyVeMyKpD6vYWcdmpnmHwxPCslQoTfqmqepz1sFWb1BXuscrvOMLA/Bg0tDDEK2bG8EoINXXscVCwIevnLNAm1c1Wr6oTC8S5Kbgy1X5sNZrdKM2kF7qm6iyOx9KPe2cfUOvA9NDmb4IgRZEjonQ+4EYdQ8Ey0fNI4we1/qpzrey42viNoZXpoM3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl+5ztjPoWm2qZQ0S94/WMf9XlisuAxbrMhd3ecEYH8=;
 b=AH3D/wCpewc+euiYaT1gKCBQxoN/5Wuv2mXz+9neWEd/leeHbV+A3mc4GJZKEjNt6LCieqKl5H0YsAAVdwSJsbRHtcURMpnGweBMKntnDAs0GsBzpEKHRWPIE7iBm+dAlz7hZcrJojGpsiQUaTIw4n+D7PhE/A/eKztPwS+mBepcZVTXzchx4XzuN7V995JGO5tU0HiQBaOT4KESeL8vHbduZuBZm+47k7tm7PRJamAoO8yT7stx+4Dh3+siUrIFUKUvzmR96L/IWfr+s3w4EiCnFn9yi58HYZIFuxUfN2j93QBHIMtDI1Zb7TrxODITo+mhrlfEJSdUIrcNs2hsFA==
Received: from BN9PR03CA0057.namprd03.prod.outlook.com (2603:10b6:408:fb::32)
 by DM6PR12MB5552.namprd12.prod.outlook.com (2603:10b6:5:1bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 21:32:02 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::55) by BN9PR03CA0057.outlook.office365.com
 (2603:10b6:408:fb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Thu, 15 Jul 2021 21:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 21:32:02 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 21:32:00 +0000
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
Subject: [PATCH v11 3/8] PCI: Remove reset_fn field from pci_dev
Date:   Thu, 15 Jul 2021 16:30:55 -0500
Message-ID: <20210715213100.11539-4-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715213100.11539-1-sdonthineni@nvidia.com>
References: <20210715213100.11539-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9937bcf8-6e27-43ac-124c-08d947d7fc62
X-MS-TrafficTypeDiagnostic: DM6PR12MB5552:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55521467E5438CFF78054B51C7129@DM6PR12MB5552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVqi32VvYUXJE/a33763wRaOSqX6EpJ9yzdCHXluR6JD2IobtBVzmffeCciBJ+d6S4oI5IYqcVm0lKgoFWPE1S9acs0dnZfZ9zPjligTvekPMPbqutiMy0+3d0HQBzL2otwcBLckYZTnvs+upZOdAOfQ2b/ng788RKMCsMPIJiLbVn/wvGOAXzcZlE9WMW5pbknJr2wei22qdSwdQQb9wpENW5uqsyobd60A1A5VstgxKyyuWaDVruaeFqBdefJDSyahN+D4TJrbrSNOl/8PLF/nZ1YY0grMLfO1oyKyMBQTRE09UNE3xXqOOgB9JTaHofZqE3w8IN1YRs87kMFccCorzuwtu2xl48A78pK1JstPoCHCLCDfLvtjYtZzQI45TNaQ9SzjAxasgrh32KQ8K8avPjS9QIBFwXI4jjzTottlbiCmvix8EH5QINvxwKGigvCzYm4BNJ21GVfVV1g5NRGxfTEXYwTilnQYK86nwxYcQLPHPcLTeGOkXCaLOptU3b6aXkNwHAW5J2ooVtYUYTchWaNrniHGSwT7i1CuCQeXxP+KIRPhrXF/bqIXHilK9MPQPUGzZ5rvgCcvEHVTis0rXfnzXZ9gEbRrlBWANjzy4sVz23ZHVZi3MN7cacQOQlKkR73LMM1X9iONqW6ndNxkV4VJXicsoGwXSLU+5Rx+QyYSK9OSATncMps2h5ntIyy9iX1U6FgTxbtb+Kj60pQW31wDw66tFeVDjUCj8II=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(36756003)(86362001)(4326008)(6916009)(2616005)(8676002)(1076003)(6666004)(36906005)(336012)(5660300002)(316002)(83380400001)(54906003)(26005)(7696005)(34020700004)(70206006)(16526019)(47076005)(7636003)(36860700001)(2906002)(82310400003)(8936002)(186003)(7416002)(82740400003)(356005)(426003)(478600001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 21:32:02.5783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9937bcf8-6e27-43ac-124c-08d947d7fc62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5552
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

