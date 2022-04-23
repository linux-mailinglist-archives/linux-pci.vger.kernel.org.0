Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAA50CA10
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 14:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiDWMwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiDWMwF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 08:52:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D384F1A82D;
        Sat, 23 Apr 2022 05:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R330jNaAtkZ6WpvIVfXh/8qvdexOEp9PkaqYxliVvpEzLMEwzmzSdYsPWQMhSlxbv/lpoAhwDUWOvRNgaOjl8Pl3FXcHCSxn8wha93InlYDcmL2yKwGTUfGI4NsfkNIRDBLi4o1d+wfEE6Ns/W3QH2vWvttcXQCWYBh10EuY0PMjJUCb+wgpaMRJFgvBybRtBBHyv1M9MqGLzwcQk+rKFsd3HMxnwOSYv0GRUkVtEmxfj8FnFBGNuDZKILWOwF0i2RC1hjRrkMgeD42pO7wAeseU6PRfIInnZBd9r/E2SV7TmGPYViR/IrkkFyDLDUl0LGRi4xQ89IXALLK9QEVZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTSc/AQ+PQCUuR104LNTU5MGKut8AGJpqoDYM65l76A=;
 b=f8mQclWBznbDXBlMRMTbO1Rc0+cHauO7CeyjiUALLiLwq70ILAbRPPcZW0vRkaOq1vzJihB3SFsklwh3GbJDm0rkXB8E9xiKH9Xg43dTuGr+zoOZX6j4vSKcfHf72kwd6PoVR10P2czCOH/pdCQdqlL0SPeQifgrOG7Tcgw9Ymobbt8mP3eQey+T27CKmF80QdYFS3t/2mKf4yFv89JE/MRP2h6wjsjbzpTMZ/Z69WmutYHW3ufoX7cFrO1mkT0JA6YLNISyuwIz7URlFG5XiKiWa/RahB+hwKNvAp/U4P3NjtPKNeL2Wc7yCqYoXOfNxIZYnlWdnP+oILWm4Jf4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTSc/AQ+PQCUuR104LNTU5MGKut8AGJpqoDYM65l76A=;
 b=OJNu1e3kgWe0JbVCZz9ERHJRsZ9phSys0IjXpug6Iio0irHcSN7yJ9g3Qq1XZkT0rMCZL53FdQRDta5GwOIm65hplyI/JXOi+hcIu+z4KJRUyVjkWydban5vt1MQiVdNR22QhfAxKxURgkbg+tyy5/+bG88qYR4+6Vn/fG+fP7cUfb8rfiZkuwF5z7KTFIN5WW4QhDuigTfYCS6vjQDeOXeycQwiwjEBigdMSFh4BOfPfVv6mPMt6mXAI1qmGASrdQreSE9+Q44OQ7RTesgOZ8YDxLGoxIEibCf6v4GeV7GppPm+fsm8kqWbVpxeap7RlZs4y77KdDN3A9f+THzIgg==
Received: from BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::12)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sat, 23 Apr
 2022 12:49:07 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::1a) by BN9P221CA0004.outlook.office365.com
 (2603:10b6:408:10a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Sat, 23 Apr 2022 12:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 12:49:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sat, 23 Apr 2022 12:49:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 23 Apr 2022 05:49:05 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sat, 23 Apr 2022 05:49:00 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzk@kernel.org>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 0/8] PCI: tegra: Add Tegra234 PCIe support
Date:   Sat, 23 Apr 2022 18:18:50 +0530
Message-ID: <20220423124858.25946-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 477b2588-ff8d-4561-6e45-08da2527a783
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB549396645C1AA0DA5E1DC2A8B8F69@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4gmupU7LbknwZEcHYdDCkrX2Sf8F71j2c+3uuOi6c9U3Nbf8gcnLA9lFdV2pjQJNyih7XMVarjTOg/p6/+idQW+t6cvUVtcqfWLuELuL4zZTWZqfkeAYdO6rBiZtoIDR9lWVfh2yPii3AUhG56kCCOJR6ms64K091UubVBn38bvhDYQx661EXtyqXJirnanlJizag5tuFydubIKoQiFWPXJUbUUTl+4S066NLP+UguFRBpGp+VNUnfuIgsLj/pQpA7wIOBSRGMD0ud8qhUishfV/SpwNz5pZXps38Dsoi3Oqbs4Iw7TTHJOHjbRIsgepoVg4PxF5XCWnRKcumlxv9fdMpmDvZObStxEIKwgJ7JyCePS5/mhxrFCGVf1aLO3SdXpFlt5Dp1ARg5pebxo/C6qoUcGoNO+duWeeMOiydjmmDqP32I+Pix4dF47UgD2i45+yla6EwhdTQsNz1hj+Vp0vSYA0BKABk6jBs4qjYXnwVX/RHKFu/lCWzw2PTs9z8nIjlN9rAYjudyRfB5pG/M5RxLOe/zYkDhKDhqC9lqd8UdtUBrk3wAQEeiPA9bIhjQpM1F3v42EqTnATfpOjau7M/1ACDbVmX14DU0vR/PkSBLYCxw8vC7V6mXM/RsaFz5TrjsZmmpVuh9Ug2KuVPqpv1DRsDI1m7NkT8NXOKK9oTEBMNG420PFlU0YbM+lijRWUD4rOOTdEjV+lnZYbg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(356005)(81166007)(5660300002)(40460700003)(6636002)(54906003)(110136005)(8936002)(508600001)(7416002)(4326008)(336012)(8676002)(70206006)(70586007)(316002)(26005)(186003)(2906002)(1076003)(2616005)(83380400001)(426003)(47076005)(6666004)(7696005)(82310400005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 12:49:06.8988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 477b2588-ff8d-4561-6e45-08da2527a783
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra234 has a total of 11 PCIe controllers based on Synopsys DesignWare core.
There are three Universal PHY (UPHY) blocks (viz. HSIO, NVHS and GBE) with
each block supporting 8 lanes respectively. Controllers:0~4 use UPHY lanes
from HSIO block, Controllers:5,6 use UPHY lanes from NVHS block and
Controllers:7~10 use UPHY lanes from GBE block. Lane mapping in each block
is controlled in XBAR module by BPMP-FW. Since PCIe core has PIPE interface,
a glue module called PIPE-to-UPHY (P2U) is used to connect each UPHY lane
(applicable to all three UPHY bricks i.e. HSIO/NVHS/GBE) to PCIe controller.
This patch series
- Adds support for Tegra234 in the existing P2U PHY driver
- Adds support for Tegra234 in the existing PCIe platform controller driver
- Adds device tree nodes for all PCIe controllers
- Enables nodes applicable to P3737-0000 platform

Testing done on P3737-0000 platform
- PCIe link is up with on-board Broadcom WiFi controller

- PCIe link is up with an NVMe drive connected to M.2 Key-M slot and its
  functionality is verified

- PCIe link is up with a variety of cards (NICs and USB3.0 add-on cards)
  connected to CEM slot and their functionality is verified

V2:
* Dropped 3 patches that add clocks & resets IDs, power-domain IDs and
  memory IDs for PCIe controllers as the patches are already available
  in linux-next
* Based on Bjorn's review comment, reverted the commit b57256918399 ("PCI:
  tegra194: Rename tegra_pcie_dw to tegra194_pcie") and pushed it as a
  separate patch before adding support for T234 in the existing driver
* Addressed review comments from Rob for the other changes

Vidya Sagar (8):
  dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
  dt-bindings: PCI: tegra: Add device tree support for Tegra234
  arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
  arm64: tegra: Enable PCIe slots in P3737-0000 board
  phy: tegra: Add PCIe PIPE2UPHY support for Tegra234
  PCI: Disable MSI for Tegra234 root ports
  Revert "PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie"
  PCI: tegra: Add Tegra234 PCIe support

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 104 ++-
 .../bindings/phy/phy-tegra194-p2u.yaml        |  17 +-
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  25 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 775 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 622 +++++++++-----
 drivers/pci/quirks.c                          |  13 +-
 drivers/phy/tegra/phy-tegra194-p2u.c          |  48 +-
 7 files changed, 1396 insertions(+), 208 deletions(-)

-- 
2.17.1

