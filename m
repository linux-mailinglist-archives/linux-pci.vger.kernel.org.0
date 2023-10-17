Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4F7CBC8D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjJQHoP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjJQHoO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:14 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11EF2;
        Tue, 17 Oct 2023 00:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbB6iCwkk9CQrzOLbE5Vw+jTUTfLjM9ZgBgGEMMT/CbTi/4uWPQHAajwmqXwXtphLIFC4T54HiDZfhTIUStoMO4gHQavkAYcRDdPHB55xFhJDewSNsgv++/hnrXLzg1heDs4CiZGHjKorFOm59hg7aWZ02fWtUT2MC2mgo3QMYTYZ9q4LKOz5i3HxFtyV3RspDGOjrDFmy6THSDx5giOfwCDvqE5yevhQmDYewft4tP9Q4gmhWvCeAmrwoBBYhUxMLWHC/lTXsL848i8l4NUl2A2mBs6yf0aw4abCTpZ4UBbhDz9dxr6mjPL3yc95slTkgUiEIn2jW+aXQ10QF964A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcAaM35r7yZL7svTVidSM0MqJyjI++7E0U7a77YAHlk=;
 b=UoBmvpHxJ992/NtW6wV0/tQpCrmwvythrWlil4tkWx9GLOMMB1bZFCQ0VDL852laehgyqhTkRWFl0t1VoyO/bXDtwYiQHHRf+KsnVpVVVwGHy10Rb8bxz2b0EULrVKTqvEvbR2eEH0vTZzU4lRx01vCAEazmtmCCUA1QKU2SqVzCnSFtFfqY1Te2tEijTD841SuIvbo/vKXa5oJYYd84DLneAVAdYXyHlYguqxnakNcJnVDz6DE4PJwGozvzGXL/PLLCuCjvowLrp0rjhwTlrVP1A2OYiZL4NQOa3uCiwy8tKZw4u47CrINTYVSqZ0PSuj0SapMz1UZMiaudexcUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcAaM35r7yZL7svTVidSM0MqJyjI++7E0U7a77YAHlk=;
 b=tOLrr8XtLm3WTg2AEx+WBqZRx89xoCouTICmUUyRPDavXPeNZd1/TplAXvzNApDpk2eKDQ7a1XSiFuhy3mYLsAXRISgATWpK0Nux+eN2URddjLKLyJj+D/u7H/bStjx6kIQ/T3MgbteNczKS0EdAQg3Csogk4W6DJsOiZqWA+2lfxUKhyUx9FEUJXWV5VL0Szi2QEyandVdAlIC4Fmd4fzWzapk3qV3uuPQtSIJsd1zujLcGwISomPwiVYgPcLRRuSKOv/img2C7IMQ1o7fusV+jeR1wiAB8sbfscAm3V8P4BLPq0ens1fN4BtOlWFRWHU9Omh+s2dgIgxz73X8ZBg==
Received: from BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49) by
 BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Tue, 17 Oct 2023 07:44:09 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::38) by BL0PR01CA0036.outlook.office365.com
 (2603:10b6:208:71::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 07:44:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:43:56 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:43:52 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 05/12] PCI: Add device-specific reset for NVIDIA Spectrum devices
Date:   Tue, 17 Oct 2023 10:42:50 +0300
Message-ID: <20231017074257.3389177-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017074257.3389177-1-idosch@nvidia.com>
References: <20231017074257.3389177-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|BL1PR12MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 4391690c-3c89-4abb-eb86-08dbcee4d910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIhu5V9NaeTbtulm1Y8jdthAZ9FDnRyzNTA8rdvLDBOGGhzZDU0LUmWyYV9P/yE6qif88Qr2V5kPozPzZFKIx+kE9NciNL51xGVUgFzbr01DeezqkzjfMJZYYSSbeuEcs6F4+FIXG8ZLV/XLEDHg/TqIqv6k30lWLvjs/hVC+NQzsIp7lxsQ2Sx83jTlToEI9a2lGwoMRxe7f984SwgRbxUoz+dfP32+mAy/PJcPrNeXuCNDFgHrAcW9+cWyoQBm3aqUI6Say+GVhR4NoCEM5yUGjDcvDUKQ4rggoSdKM8/eECdXTJlWXAfy7MP2ubfQ3drkndfj8jBfs85u+YuQ0VeLKphb91Ft3KHY4IuoryF30CZOha1o1SraQxilHaD+aA7l7VpOWcWc+L2MtIyOKyrx29E/EsjqUoCOaD2uZx68dI0o9WiBuv/B+0cVQp+wy55GaFPBDMJCVOs3rkysazmu1lqTwy1KZZ26Mt26D8UzWBBeP0ZmWPHu+PxoBZ/1JMyA0k10c0M8bictCPDvHxOJmcJ825gQIC/b6kU+P1YaUtPhjSNbJfrZZHCMF77McIp1+RpSFja48mXp1Eyuhz94fKgFcyHRGBJpNEev0/AgpQeNozC/eMXV2h/Lj+fyDhSNQKjZu4A0Z4n0IvJqINeYJcFRHazZxcWP+SRCVQWMuvI0Z9EhRPJ/YLDl36NgK9Q+DLnUffKSmO0W208uZ5W6Y6ms0N6r+ZXD9xl/7cqmkOG9J4ny/indFeTe4nYr
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(478600001)(47076005)(70586007)(70206006)(110136005)(54906003)(26005)(16526019)(107886003)(41300700001)(336012)(1076003)(316002)(426003)(2616005)(4326008)(2906002)(8936002)(8676002)(5660300002)(36756003)(86362001)(7636003)(36860700001)(83380400001)(356005)(82740400003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:09.0655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4391690c-3c89-4abb-eb86-08dbcee4d910
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe specification defines two methods to trigger a hot reset across
a link: Bus reset and link disablement (r6.0.1, sec 7.1, sec 6.6.1). In
the first method, the Secondary Bus Reset (SBR) bit in the Bridge
Control Register of the Downstream Port is asserted for at least 1ms
(r6.0.1, sec 7.5.1.3.13). In the second method, the Link Disable bit in
the Link Control Register of the Downstream Port is asserted and then
cleared to disable and enable the link (r6.0.1, sec 7.5.3.7).

While the two methods are identical from the perspective of the
Downstream device, they are different as far as the host is concerned.
In the first method, the Link Training and Status State Machine (LTSSM)
of the Downstream Port is expected to be in the Hot Reset state as long
as the SBR bit is asserted. In the second method, the LTSSM of the
Downstream Port is expected to be in the Disabled state as long as the
Link Disable bit is asserted.

This above difference is of importance because the specification
requires the LTTSM to exit from the Hot Reset state to the Detect state
within a 2ms timeout (r6.0.1, sec 4.2.7.11). NVIDIA Spectrum devices
cannot guarantee it and a host enforcing such a behavior might fail to
communicate with the device after issuing a Secondary Bus Reset. With
the link disablement method, the host can leave the link disabled for
enough time to allow the device to undergo a hot reset and reach the
Detect state. After enabling the link, the host will exit from the
Disabled state to Detect state (r6.0.1, sec 4.2.7.9) and observe that
the device is already in the Detect state.

The PCI core only implements the first method, which might not work with
NVIDIA Spectrum devices on certain hosts, as explained above. Therefore,
implement the link disablement method as a device-specific method for
NVIDIA Spectrum devices. Specifically, disable the link, wait for 500ms,
enable the link and then wait for the device to become accessible.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/pci/quirks.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 23f6bd2184e2..a6e308bb934c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4182,6 +4182,31 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+#define PCI_DEVICE_ID_MELLANOX_SPECTRUM		0xcb84
+#define PCI_DEVICE_ID_MELLANOX_SPECTRUM2	0xcf6c
+#define PCI_DEVICE_ID_MELLANOX_SPECTRUM3	0xcf70
+#define PCI_DEVICE_ID_MELLANOX_SPECTRUM4	0xcf80
+
+static int reset_mlx(struct pci_dev *pdev, bool probe)
+{
+	struct pci_dev *bridge = pdev->bus->self;
+
+	if (probe)
+		return 0;
+
+	/*
+	 * Disable the link on the Downstream port in order to trigger a hot
+	 * reset in the Downstream device. Wait for 500ms before enabling the
+	 * link so that the firmware on the device will have enough time to
+	 * transition the Upstream port to the Detect state.
+	 */
+	pcie_capability_set_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
+	msleep(500);
+	pcie_capability_clear_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
+
+	return pci_bridge_wait_for_secondary_bus(bridge, "link toggle");
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4197,6 +4222,10 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM, reset_mlx },
+	{ PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM2, reset_mlx },
+	{ PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM3, reset_mlx },
+	{ PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM4, reset_mlx },
 	{ 0 }
 };
 
-- 
2.40.1

