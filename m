Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E24AA9EC
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiBEQV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 11:21:58 -0500
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:14177
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232747AbiBEQV4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 11:21:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUEWh06B8Lu2p4drDlR4xVASEq7THsK5dblW6AGpTbztY6XjODPG76ycFRoYLU7BKT/GzD5tYdqjcQbcUmSAP6jAn1sr9Upn+4ggHfNMF3HLtKYLFsANy0f0xXex1DkkD4eTpAuq3t3yAdDdCcEO3sHJj58svex8u1Rd8NUl3rYsdPRsrvptjhrTZXcqWpgDG0oT4YC0S/GJBkOk+Og8N9ouw1x6/oFARZFdN/2qSel3VOvTzpWvnre/uTYPg6erdReQrsdGmh9CXwaYhNxHmNjkhVDrQq0wQc2yHJSw2Bw/htC0aioe+5RS6iUSmZq4a8Cak2J1nFYsbR5XOZxQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0MIrXqZqFewEs031r7WYE4P7by1bewUg1TP5yjSq0o=;
 b=dnlj/Lct0LGi7EYOqmdzZ8ah5gGPuT3LkSUJneGfokyajYEUrYAudyDRYEKdVrVoF/VXNlkhvuSwTkY+o9SBe8REIRrxbGdK0bRuixxmdbAhLfLS3L5I4SRBJPoLRlU8tfF1cvx+aNuGN44R0ZEAVAie5h+6Qhyz2nJ1Qcc8rKxbNrvKTRMZZJLibwM79z8VJnspaAv/pNFm0NHjB7RZNlGKkY1NX8OsgQnI85TNaV2jz6ANLCz430P7v/ahrOP6BBQSuLxriKwD3QHlQIdHR+y02slHgHc/Kc0XdG4Lg/+RvjUQpvsWX19PYVFjwnBMamFpcioQimMU9Z26vdObsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0MIrXqZqFewEs031r7WYE4P7by1bewUg1TP5yjSq0o=;
 b=BGoIDzXkoK3vlycQB7BJdpXs7J8pGWnzppcpHPDdkkuTln0U1/y1Z/Ao3T4+PKvRCCc51gLWZ9zUedUmEj1ZZBsJG4+SKsdoUxy/FBpFoefsEeeE3q0chYCHMB8O2+eFGXYT4YsNrrPvjLz4pzLp/G8/qg6IWb9UA/308f1OJbQ+V/lC5YNfZdbw8/d+mUDcI7moG1wudCmR83MLlTL4ERd4b5tVPka4mSUC6a6RzjS5RjwKZTsXcibUXsyG45hOAvZ4ml1Th0eoztwKceGynd89B3LBRMhUrSXKimiRxgyhKAq6pJWOkDhFVUP2MyzhDQvboc2JwUF6Iiu1tYiGAQ==
Received: from CO2PR05CA0081.namprd05.prod.outlook.com (2603:10b6:102:2::49)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Sat, 5 Feb
 2022 16:21:54 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::87) by CO2PR05CA0081.outlook.office365.com
 (2603:10b6:102:2::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 16:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:21:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 16:21:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 08:21:52 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 5 Feb 2022 08:21:47 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 00/10] PCI: tegra: Add Tegra234 PCIe support
Date:   Sat, 5 Feb 2022 21:51:34 +0530
Message-ID: <20220205162144.30240-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3fd54b6-fb04-4053-e224-08d9e8c39f61
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25641B95429CD8C78AC4550FB82A9@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnaYQg8qwGO6CCs2xlh9LaXgXzIxN++TZGKydhmLfsuAVR7kXm/yDuSvFJag9pnwf8mdvnddXcLmbrGuBnGo+nwR+9ezQmZFu81CWW3gqR98j4zNfJAaOhMc4c4xdgMEZZ3dl3+ZKsnvcClUY9y+06YzPZtIwiVk9ck8SaATN+7YDY+RfpJXgs3k9cjwmvX1mrTSflKGX4LE+fC9j/S8c0iAneop2EMUi7l+7/10Fu0KrKmx0/o1c+0GxYin51ZPRwlSePJwAppcxaiv31W7M/c7wUJswgl25XmOBmDE/5iddG/+eqadsAkGe7RVI4k+lcAL1Odl7jRwzjGbm9SL1ybHU9M7U0aRRFw1g20/3hkMlVT6PPq00qKuNNH801wdJGUVAlXh0pTaZBS8fPli1sMnldCSM/5Zwi0PjqSQF4G7bLcZuvBqOLDCuAaPzKCNhESgjD9mq9nMEDxq+IPQHT43YNgQxYZc4ENSgwE+pRi3qkvepr3bQheEy6+WbcBtDO94M5GCHP08TfDL+ugFMMHrRw8uUXSgM7uYv6cUYkyI1hdzEllqtNwgqcSt+J64XiabLjX0RYdXx9bASnRXH5BFjZabhHATONY2FiJh7tqV1X0TK23cJTCVdyOdEkIdMfVGHNKMnJQym6tIMRHARhrP3RdOFeWkaPIJSyvfwsbintAeYITl7S0bhExGJW4jaCiPtg6MElERSTJExPHKqw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(110136005)(6666004)(86362001)(26005)(1076003)(6636002)(316002)(356005)(81166007)(54906003)(2616005)(186003)(426003)(8676002)(4326008)(508600001)(8936002)(336012)(7416002)(70586007)(82310400004)(70206006)(47076005)(2906002)(40460700003)(83380400001)(5660300002)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:21:53.8801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fd54b6-fb04-4053-e224-08d9e8c39f61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
- Adds device tree nodes each PCIe controllers
- Enables nodes applicable to P3737-0000 platform

Testing done on P3737-0000 platform
- PCIe link is up with on-board Broadcom WiFi controller

- PCIe link is up with NVMe drive connected to M.2 Key-M slot and its
  functionality is verified

- PCIe link is up with a variety of cards (NICs and USB3.0 add-on cards)
  and their functionality is verified

Vidya Sagar (10):
  dt-bindings: Add Tegra234 PCIe clocks and resets
  dt-bindings: power: Add Tegra234 PCIe power domains
  dt-bindings: memory: Add Tegra234 PCIe memory
  dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
  dt-bindings: PCI: tegra: Add device tree support for Tegra234
  arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
  arm64: tegra: Enable PCIe slots in P3737-0000 board
  phy: tegra: Add PCIe PIPE2UPHY support for Tegra234
  PCI: Disable MSI for Tegra234 root ports
  PCI: tegra: Add Tegra234 PCIe support

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 106 ++-
 .../bindings/phy/phy-tegra194-p2u.yaml        |  17 +-
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  26 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 743 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 409 +++++++---
 drivers/pci/quirks.c                          |   9 +
 drivers/phy/tegra/phy-tegra194-p2u.c          |  48 +-
 include/dt-bindings/clock/tegra234-clock.h    |  25 +-
 include/dt-bindings/memory/tegra234-mc.h      |  64 ++
 .../dt-bindings/power/tegra234-powergate.h    |  20 +
 include/dt-bindings/reset/tegra234-reset.h    |  27 +-
 11 files changed, 1390 insertions(+), 104 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra234-powergate.h

-- 
2.17.1

