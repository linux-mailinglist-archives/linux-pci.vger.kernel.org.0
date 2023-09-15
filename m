Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7277A148D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 05:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjIODrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 23:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIODrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 23:47:52 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D33196
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 20:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHDIxR/is2ywHVpSv+uqdMVu4kochE7whtRXOZn9aH1LEP7zuk+7OIU9Aqmtcc80MszC5fRUYqya+u3v3CrwJV3c1G9mp4z7UTNcuQCwPBFqUKJ1Cz0wUYjCsy46dbX9cwK//fV+hZjqKan48RznFZ/WK+SD9xMq7tg1funrIZboEY6bk0VJqyIk95+opaeKmwrwQUwqCN5r+VtHAyJHxpyITp/n0VT04zxvA0ThVzxVBgkYZFjokJxIVrI+gtomUNQVGTrDynUSRif/NV0z970qFcJBtyftoXpdRvlCHvQYdbR3OuT6o2w+6CvFcGS826r1ify3HiaEKe3P/eEXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqdJuUN0VqGMZKVTXGiGK3lTEcnil+hjRKAv67BR8KM=;
 b=EzIVA4WxwjjqwyDawroXnBvRCbn1r09SJTkIohlA2Jo6Etmpj/7R2wEr1tD3U/x8Sj5ekSlm40JWJu5CXgTXA6StlisIZP2ICwh5BJcE1qsu7/kITxQ3TDeXqHivGpAe12qugsJF8dGN9A/YHvkPpVCs07ovk6AlkRqVdPXFD6BryLG7TM87Wjh1bGNx70ewPluXWySpaEZ/yEWmRgPBpmYtFXtzHtg4SgDLj5x0MZSoh4lL2Yo05SxLlQnWExbNvH8wMpKGOpKEoAuHO9tFtHtlH6qjWNxygonEFbxRDGnvKtJ+r3KbEr1lB3WW9Bdw94Nmd75H2opMJR6iRsOOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqdJuUN0VqGMZKVTXGiGK3lTEcnil+hjRKAv67BR8KM=;
 b=cEnXUdpIKbX0Lvri1XV6BFlwfVqcCxeCLSg8+fCgwr810Hf+HDul0Tbi+72iA33GdxGwpedGQvPZXfLB5nenbTz0KV4sXMfcG7VPnT/wd/pGq5wjsL2IV+mMYKzjfAw+Jz3iaQEHyvqSwMywz/1puG/hzoOKlkAjgPwaD8qaKjU=
Received: from BL6PEPF0001641D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:12) by DS0PR12MB8220.namprd12.prod.outlook.com
 (2603:10b6:8:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 03:47:45 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2a01:111:f403:f902::2) by BL6PEPF0001641D.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 03:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 03:47:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 22:47:40 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <iain@orangesquash.org.uk>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v19 0/2] Add quirk for PCIe root port on AMD systems
Date:   Thu, 14 Sep 2023 21:33:52 -0500
Message-ID: <20230915023354.939-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdae6ee-4450-4bc9-618f-08dbb59e8587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGftj2lqIlQjjGdPJk61DxUH7LpaXO/GHsozsS+9e0vRuBvSiWIViuvhzvSg6Tf+YzV0JJuLrIOxCHuxg/DjqHg64uEym6uRRKSSn+XpwqS79ii4NVNtg4XkBkGGVbpxhZ+w9+HPI77U/Ssp78wReBJzDDjf0J3HE9pTfGjn5yqVrqO3f1vS/q4ZeEDX26tEPzorgyhvtUQ81xq6EnZTuYSs5Y205KcD0WvZYNr15Onet0lNEeaI1EsyXPjU8UEUWuqc2d2dPsufaOAW+2O/2A7RIcRzqq3blP1oKLFE0mauBW7eBQuo9e8+4E9ix5KmdJu0i9dyBfu20VOIriLUUSdRxMbmSQd85FsNH75EkeOxb0ccqoG6tnbSQioPdfwF82dCHAaPglu1SUE/cB2PbZHCFqHxp4fy4t70/Ux9qWIrERZmKDJwQGkvHJ/2O3y2MX4hup/6BZfLBFmXBLKmY1hymVyTmiWClwLAFbbZ64fEfy9fut6BiS5HXTltoduJezuz/oeW+/gytNwdblUIDbct6Kyy6y4x4zdjD3wDekSaCv+iXveqfBmp65uyJvQW5VXXKaoc4EqGnlkjQ4JC3Tl8wF2PpuMRc0kHd7XBHGLHG0GKdnXaSwdCpk7vD49m4+y20jI87+QOYCPPy85aLzCnYvKEgZcoz/z2B/C5ANOr2PUMrkwhCQH2NKMO5499AQiTiTv+qnnNMfBgK3Eso2imr3+Syf3vFMWANUROvInHnGyDV0gYBeOq+ME11QWojYOc6fuj2G1oEo2lQHkAHGyq0eu0liUBW1K08HhAa1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(4326008)(8936002)(8676002)(54906003)(316002)(70586007)(70206006)(110136005)(2906002)(40460700003)(5660300002)(44832011)(2616005)(36860700001)(426003)(47076005)(336012)(1076003)(83380400001)(26005)(16526019)(81166007)(86362001)(356005)(6666004)(36756003)(82740400003)(7696005)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:47:45.2290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdae6ee-4450-4bc9-618f-08dbb59e8587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
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
* v18
  https://lore.kernel.org/linux-usb/20230913040832.114610-1-mario.limonciello@amd.com/T/#m92a2654129d5f6be5439d8a94fb36734804763c1
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

 drivers/pci/quirks.c      | 61 +++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi.h |  2 --
 include/linux/pci_ids.h   |  1 +
 3 files changed, 62 insertions(+), 2 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1

