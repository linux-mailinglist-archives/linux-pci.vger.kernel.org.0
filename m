Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909D579DF0E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbjIMEKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 00:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbjIMEJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 00:09:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E2A8;
        Tue, 12 Sep 2023 21:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1NfeAg5xYeUGvzyZMhG27pJShUeJrxbXEoYUS0xMpeyasF0WPNxjRapzqSnkmVthtRkT5ifa7XYXAxkI9veT30bAglma64QO5IB/ZgKZlE9gcrUYw+9aB1N958a+ecv5azROpMj1+2S4ia/yGhCWFozUFWrbV3HHuCXEs7SOeKx01qEzYxkzJcOTZvNiiRwOqyACqPpmdRy6USesrZG9H/02ABFEAgcv5ZF5Xtf7aOWk9LDTYH6PwAUPdKYowisEtOwD46tqYQ9pur/oAdt96f3czerL8zmu2Y4OJVX8cBFN29qHkfekuTYOYN5aU+vpYoCytqtJK7edlimQUlcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co05OyDJ5rrh0aNDPlIvWZjbDGN87E+41XO3D6jAviI=;
 b=OvpiaI3R2pUjmUVMVE37cBIYRlJ31RLNJ/eSRFMQKs/pWRG0jLA8wuiyPxh9+95A5lcsDpHaZ0Udb0b/tKQAsCqOjGDIMws2eyfdem84DuQNEI5GS8DJIvb4XCLV62bEUdmTY7MEWrgy2nimkt9Z5mkszLUCdJOnogUckWueCv30TNA2zxU1AFRDdvVJfZ2QFirNtVGCZTlUn3z243xSoMpKJj+46EoHjj3wL74dCRxvJnj6FE/Y3Kkcxc9nx2hu65u6k0Fqzv32UeVnknxJTm74eloTAjv1cAqFkKpvEs/RpcmqoPEVJoQFPX68wn64iRn02CIux7uGqxr7eOPhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co05OyDJ5rrh0aNDPlIvWZjbDGN87E+41XO3D6jAviI=;
 b=FMy0tV/bfaCofx5mU0WGS3ClzJG7YFTCFmWRB0gGozzSVM8vu14i4v/IrsOTc81mwfwJl8f00GOvaSJW6lIRMPRF4zpJzONSBOqTqVt7WI+1VdAWOjGurirCKVMIaGPgfeZ9LvSQrl8/2wlXCtYh1uM32P20WXLN5PUErFJsWKg=
Received: from BL1PR13CA0141.namprd13.prod.outlook.com (2603:10b6:208:2bb::26)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 04:08:59 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::b6) by BL1PR13CA0141.outlook.office365.com
 (2603:10b6:208:2bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.17 via Frontend
 Transport; Wed, 13 Sep 2023 04:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 04:08:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 23:08:55 -0500
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
Subject: [PATCH v18 0/2] Add quirk for PCIe root port on AMD systems
Date:   Tue, 12 Sep 2023 23:08:30 -0500
Message-ID: <20230913040832.114610-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY5PR12MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4b815d-b4e1-462a-8508-08dbb40f26e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyZcAsEbGzdU9OIcE8aifkjwbKzCGPYnErJAh9KNw93VwSyosMODZZSGDe+6aG4lK4P+THVqY7nksSjM7v1MvkLGxt/eQA1aJDGOgwDyoUvcYuMen9ySzFJjNb6T1kPi/o1JhOCo5LKzQIT3vFEuT/wjfLp9wCfQxVx2puwyvsgEiX/+V1y+TbmoEyrNG6APCZ2AoUTxEAQ0IJxVqoffS5oMKLjOsEsjdLaKGKt+SNb1NnlOebg1W/iDQz72NE6dp/mK/I6lwsxuwiVfOsY1UIyXWhkIlWXxrElyzgr4fUNmJsBrJPZoOduJKiu+0mOp0bmX9youY7xktGYEA9IBiGut4CLLB505ikbVGIotuQRHThYcXOkobBulOG6hruXMqVO3/ru96HuSrb4pYUp6XnIg56QjfNybim7HRo1YoXoRRhjm3PBvDdljVWckkfBtk5qb1gsNVnc+k+o8JCarVyVNZ0+KlZbVIaSmLrYsIhtmr04sB/syr+u4m3Rvnla8Au2IXZkswp/no4KsJmnF0G6J8x9tq613DrsQ+V4iP2zZPKurxcBIGoRZJaGwoyY0oameGY7Hr5SxCAKWqlVTjbXQvvVoXE3JZvn6AUxlqP3JV6p+bR88pKWSWedAxGs9hHMB6fGW/Tm9wvWOx2gdINrmXycU4yPWHwCPGCfeJa0SNDEn6mi1hlCWWjw97lfwh3tcLnJA8trYaGdA/nU5eMM0hvdBSCVLBRz0SAZ0/6o5bZrNLmSZt4A0nGcpyC82IewD7QnMFQfrm27fJp+XYMSHPE4WRTfjHJEp2//Ajhc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(82310400011)(186009)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(63370400001)(63350400001)(316002)(54906003)(36756003)(4326008)(41300700001)(8676002)(8936002)(40480700001)(44832011)(5660300002)(110136005)(70206006)(70586007)(6666004)(7696005)(2616005)(1076003)(426003)(336012)(36860700001)(82740400003)(356005)(16526019)(26005)(81166007)(478600001)(966005)(86362001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 04:08:57.2567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4b815d-b4e1-462a-8508-08dbb40f26e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Iain reports that USB devices can't be used to wake a Lenovo Z13
from suspend. This is because the PCIe root port has been put
into D3hot and AMD's platform can't handle USB devices waking the
platform from a hardware sleep state in this case.

The firmware doesn't express this limitation in a way that Linux
recognizes so this series introduces a quirk for this problem.

Previous submissions:
* v17 
  https://lore.kernel.org/platform-driver-x86/20230906184354.45846-1-mario.limonciello@amd.com/
  This version implemented constraints for the amd-pmc driver and introduced
  a veto/optin system for the PCI core as suggested by Hans.
  Rafael suggested not to use the veto/optin system and instead use a quirk.
* v16
  https://lore.kernel.org/platform-driver-x86/20230829171212.156688-1-mario.limonciello@amd.com/
  This version implemented constraints for the amd-pmc driver.
* v15
  https://lore.kernel.org/platform-driver-x86/20230828042819.47013-1-mario.limonciello@amd.com/#t
  This version hardcoded the quirk into amd-pmc driver as part of suspend
  callback.
* v14
  https://lore.kernel.org/linux-pci/20230818193932.27187-1-mario.limonciello@amd.com/
  https://lore.kernel.org/linux-pci/20230818194007.27410-1-mario.limonciello@amd.com/
  https://lore.kernel.org/linux-pci/20230818194027.27559-1-mario.limonciello@amd.com/
  This version implemented constraints exporting and limited the policy for
  >= 2015 to Intel only. It also added support for constraints optin.
  V13 was split into multiple parts to make it easier to land. 14.b was
  merged.
* v13
  https://lore.kernel.org/linux-pci/20230818051319.551-1-mario.limonciello@amd.com/
* v12
  https://lore.kernel.org/linux-pci/20230816204143.66281-1-mario.limonciello@amd.com/
* v11
  https://lore.kernel.org/linux-pci/20230809185453.40916-1-mario.limonciello@amd.com/
* v10
  https://lore.kernel.org/linux-pci/20230804210129.5356-1-mario.limonciello@amd.com/
* v9
  https://lore.kernel.org/linux-pci/20230804010229.3664-1-mario.limonciello@amd.com/
* v8
  https://lore.kernel.org/linux-pci/20230802201013.910-1-mario.limonciello@amd.com/
* v7
  https://lore.kernel.org/linux-pci/20230711005325.1499-1-mario.limonciello@amd.com/
* v6
  https://lore.kernel.org/linux-pci/20230708214457.1229-1-mario.limonciello@amd.com/
* v5
  https://lore.kernel.org/linux-pci/20230530163947.230418-1-mario.limonciello@amd.com/
* v4
  https://lore.kernel.org/linux-pci/20230524190726.17012-1-mario.limonciello@amd.com/
* v3
  https://lore.kernel.org/linux-pci/20230524152136.1033-1-mario.limonciello@amd.com/
* v2
  https://lore.kernel.org/linux-pci/20230517150827.89819-1-mario.limonciello@amd.com/
* v1
  https://lore.kernel.org/linux-pci/20230515231515.1440-1-mario.limonciello@amd.com/
Mario Limonciello (2):
  PCI: Move the `PCI_CLASS_SERIAL_USB_USB4` definition to common header
  PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers

 drivers/pci/pci.c         |  5 +++++
 drivers/pci/quirks.c      | 28 ++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi.h |  2 --
 include/linux/pci.h       |  2 ++
 include/linux/pci_ids.h   |  1 +
 5 files changed, 36 insertions(+), 2 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

