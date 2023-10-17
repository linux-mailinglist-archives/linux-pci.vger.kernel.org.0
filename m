Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C018F7CBC82
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjJQHn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQHn4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:43:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0198F;
        Tue, 17 Oct 2023 00:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJMPQNZk4yws6ElYrGfHUfM5ugll1EYz3+MfCzEVIFTox1Bp5NysvD/+0DuND39uQxok43YwxL1oJSqc+BVu/rdWV0mQZ0Maci5tDw450pttnH53X0ASJVOa+dKBWfHyzE3M9b8zJsR91XYva/khGHjjn69QUvgPph6s945zpggt2O6ool50OENCzYPE36wuSClc5UCVVdb7ZFoHImSaqSgSflzupJBg7QgoSH3eWxylH/5MPErUQfyl5vo8RUdB7N9Im3uAr52CjiaVRxhh7OnPgTpDkblt4GKAA1jb7dpfKbFJUggMhBd9LH5gxLNsoShHFfcZLj37YC4r8fVEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmRErNJi/3yE7TLfGbrsdrVbFl0EEfYUMoGwVR5Iv1Y=;
 b=Ya6ZeE0jshmBXyg9GXe014dUTlTMmQIYB1/AAocDICp+W98LSF38Gz7cRfo7k6Fv3f/jLHZuNQ38slsDCJxhONvwMex4Py9NJv8TtRqOty2WfO3GVlZjP6JIsuu/TMUr6epjm4iAIs2MbHrGhAEpw0AkXBPK3UVXwuuo4FpeK0sQgvE/7J7eXnqG1hdvNoOtqi1QucEPRECNtsOtda42uRmJoFBRRLbp8OyKbnuZV0TH9LelOWTkapYi08qeZ1GmHcm/xj4IwEfpDtIzdz/iTE0xsdWEQBXNJo/TYxbY4YdCCcCN+c1N4LGuhOzmmlI0BNkj5vFmmMV8lt5k0CaqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmRErNJi/3yE7TLfGbrsdrVbFl0EEfYUMoGwVR5Iv1Y=;
 b=ll/h3D6egWxmv091ahy2rWwuvCSgjAMK603U/AYygpif21mPAqM8tMSvUnJCkP/UI/PX2db5DI5Cwo0lCc1ixcjbKC+oHUCw5Y6VoTpPsQRhWbM3lbxmx6a8gGLnb2e+S7wa4uGiVzZKGgm30/K0Y2Ntny8EnffmThvWE1wWwnVCr0uF/kcvvvjmHh57cSXjGhWT5nCNImQqBqkgtIp2mYMzCOZh+1BxymjYxLxZD84p5SDJLqQonZQVUo2E6xE9Tj06S+gprX0Q4n/Qlk2mElfZhO1AFOosXrfcVG0eNQ1n95bEYZoIfTnO+VfNrWo5gioDfg2x91U8DQnsdf+jUw==
Received: from BL1PR13CA0141.namprd13.prod.outlook.com (2603:10b6:208:2bb::26)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:43:52 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::18) by BL1PR13CA0141.outlook.office365.com
 (2603:10b6:208:2bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 07:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:43:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:43:37 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:43:33 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 00/12] mlxsw: Add support for new reset flow
Date:   Tue, 17 Oct 2023 10:42:45 +0300
Message-ID: <20231017074257.3389177-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f0cb4a-d2b7-42a3-7257-08dbcee4cecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOvYM0S5P+hB8t1i1oMAFR9PVJwyE9IA42NKJSCIRn3KUR7Au+Q4kkTkyPenaDGTfaNkz7KgCYDbT3s1LsXaWvFlzIIpK6mT4glmNtkqy+fyDCiRIQZVCif4xjpdWd9CSZ+x3ADmTXV3WGNE+2awz+8zu0wAi5/Qjyns7vxjs0zDo+C0nGLuNxxS1+jbNzCrXRoybMVCMBBSbpv14VhPBW8xOXPi1aWoaP4sDu8Ycht2SRNPmyZvEh30jkZxnB7BQ8hSX7PxRH6DHmH4BAhUBFZj+1tEYGQkP6SGglmFpWtJUzf+qwbV1jmJVc9Wwky8XEiY4bLOShgV3kdm3DgKdyUaxzt1gwsCB79PZHSPoON16pSi/FkNSoX16GqnZgG0ROoKM7rt1R1pt/GBS+vWsVm59EKj6sYMdpJctIAJo/JJDgMXykf6oyEvyT/H59h8Y8ey3yVXRHaEcRAqvnPsYbt8GHJork3fHDCirDvv6xpHdh7tRlY/WtGBvLuwxwgVXGP8zs4DHbwAe/+r/yDtUmPO32LMyoOe6j/ZMkiLLnBRGobq6360rOEvu/Ra28lwNjxcQDs3uqooHYA7qfOehbNEmO5JFxE0tJZT7PHWSKvNYh/lvEAqkh1KUnS0nCRJrc+XkXj/T6czsBOfvd6FsgrvTMxrAoNVEaea+TI9ESSvTJ0EhuMKuvlpPZkWC4dtRGz/+tJIpHW81PYgDePAUad2ATRkp+AnMM2nBk8xzb9AXVToBkkBbuanWS4kduI9gCY1QnxPl7l6MsZiHiKl1FlLu6aHbmisMaGg++q432c=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(110136005)(2906002)(40480700001)(356005)(7636003)(966005)(86362001)(478600001)(41300700001)(54906003)(36756003)(70206006)(70586007)(36860700001)(316002)(6666004)(8676002)(40460700003)(8936002)(26005)(2616005)(426003)(16526019)(82740400003)(336012)(1076003)(107886003)(83380400001)(4326008)(47076005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:43:51.8461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f0cb4a-d2b7-42a3-7257-08dbcee4cecd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset changes mlxsw to issue a PCI reset during probe and
devlink reload so that the PCI firmware could be upgraded without a
reboot.

Unlike the previous version of this patchset [1], in this version the
driver no longer tries to issue a PCI reset by triggering a PCI link
toggle on its own, but instead calls the PCI core to issue the reset.

The PCI APIs require the device lock to be held which is why patches
#2-#3 adjust devlink to hold a reference on the associated device and
acquire the device lock during reload. Patch #1 prepares netdevsim for
these devlink changes. See the commit message for more details.

Patches #4-#5 add reset method quirks for NVIDIA Spectrum devices.

Patch #6 adds a debug level print in PCI core so that device ready delay
will be printed even if it is shorter than one second.

Patches #7-#9 are straightforward preparations in mlxsw.

Patch #10 finally implements the new reset flow in mlxsw.

Patch #11 adds PCI reset handlers in mlxsw to avoid user space from
resetting the device from underneath an unaware driver. Instead, the
driver is gracefully de-initialized before the PCI reset and then
initialized again after it.

Patch #12 adds a PCI reset selftest to make sure this code path does not
regress.

[1] https://lore.kernel.org/netdev/cover.1679502371.git.petrm@nvidia.com/

Amit Cohen (3):
  mlxsw: Extend MRSR pack() function to support new commands
  mlxsw: pci: Rename mlxsw_pci_sw_reset()
  mlxsw: pci: Move software reset code to a separate function

Ido Schimmel (9):
  netdevsim: Block until all devices are released
  devlink: Hold a reference on parent device
  devlink: Acquire device lock during reload
  PCI: Add no PM reset quirk for NVIDIA Spectrum devices
  PCI: Add device-specific reset for NVIDIA Spectrum devices
  PCI: Add debug print for device ready delay
  mlxsw: pci: Add support for new reset flow
  mlxsw: pci: Implement PCI reset handlers
  selftests: mlxsw: Add PCI reset test

 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 90 +++++++++++++++++--
 drivers/net/ethernet/mellanox/mlxsw/reg.h     | 16 +++-
 drivers/net/netdevsim/bus.c                   | 12 +++
 drivers/pci/pci.c                             |  3 +
 drivers/pci/quirks.c                          | 42 +++++++++
 net/devlink/core.c                            |  7 +-
 net/devlink/dev.c                             |  8 ++
 net/devlink/devl_internal.h                   | 19 +++-
 net/devlink/health.c                          |  3 +-
 net/devlink/netlink.c                         | 21 +++--
 net/devlink/region.c                          |  3 +-
 .../selftests/drivers/net/mlxsw/pci_reset.sh  | 58 ++++++++++++
 12 files changed, 261 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh

-- 
2.40.1

