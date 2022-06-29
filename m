Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2155F609
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiF2GEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiF2GEs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:04:48 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3518B2E;
        Tue, 28 Jun 2022 23:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMD54vG0vYPRm67xJasW8sbuCe6EnDIyx//wKwDkv61UXvObDHY7VVcdESkv/ot4W5N685rJKKfVc+qTcxH5d+655lmmb8yYQHyE+W8EE/pGUNThhAZabkqQDpg5GpG/zVEBWMsJtS2VPts2zZVMQB0dYeVSNbR+lU2ooJJH4UBxcrudUyUmH8GySSgkFZVw1PZhHA/PgeYOYIE+Np2J3BG9o6O6+1Ijv7N52mxM6YRvtZHhxSyWHOgOFJ6KjVNATcOYeYPWQZJuhGTvyWadBQv1IaIJGqGHGIEnTD37HzKNA/ZaB8plQYdykII40ZLOoYSexsxzAOy/ubzwJQEx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxdTEW7J6BEZidifFvWZJQykUkDJ9z6efFjJUrhLmxI=;
 b=YjdNmJwjDBH4pbFu/OWTWMaZPFIWbEL9w3ScTcgz1D4UqKaGgENI+ZMAdJSgMMb26PytgwbYhxXMjshVynyMMWa0kVq9H4dx9vTcQ/mvmg7YbYq7D3TY+jtzTc/up6ww1YhjEfmbAFJ5Ff9dv/bQts8/AkiBjEcXRT2Qc6YeV1kyStXaxAc0uYMOOxbHGqKySwDM1xWlggUlPJ5u3qzUiQal413WY9H93eX1Oc3IRmVvfeRTplqA7BMqPPJLHCaIg2FJPgHPurZ+81aUdk7A6eai5x6XAUNNCChZAOY0oHqsPBh1CD2qlFyBHqhWROVewKDWGeBYY/BMJwq7x+E4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxdTEW7J6BEZidifFvWZJQykUkDJ9z6efFjJUrhLmxI=;
 b=Adq0khzR2TqZLOGQRqf/yBa74Vvkp19qsXUrHs6pGVjglH/jqguXo8yDq44xPYc4s/+mva1IESjslfM7S9gjgQcZ/dCEhndcP2JJl/3/oFnPyUiU7GfZeJ78/WhYsTq6Iiqy+KfZSBNvhTUMXqlyAP/ligw4QokL57sIXFOXXdw73FXPTQiooAkVuv5XSA8r0iDP6MJX51wKg3NSVgTlIHBwGYnKs/INnwdb1g5JBOiFoj34KJQctqSa5jcsh/bu/CzXvfhXcgK3UiYmdx0z6gD4n+xzM1CaufP4fvdxXcs3b29eP6Vuwwph3OrrjGlif95s2nR/2mmXAJPTE3ILzA==
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 06:04:45 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::21) by DM6PR17CA0034.outlook.office365.com
 (2603:10b6:5:1b3::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Wed, 29 Jun 2022 06:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:04:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:04:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:04:43 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:04:38 -0700
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
Subject: [PATCH V3 00/11] PCI: tegra: Add Tegra234 PCIe support
Date:   Wed, 29 Jun 2022 11:34:24 +0530
Message-ID: <20220629060435.25297-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d56b6e3-09f8-4442-0fe6-08da59954393
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMM8LZBE+xgJxp6YgJmmB0CywI/KrhEFDtwM/1zj48I0hHxAjRrWaJBpyjdPdO5/VYm8yaP5d3Su9s5uhm/qjnohxRFzJ4VrsaAgUGhQ7+w0ZtnDVRioiHHP1QxqA5WnPaWdmUaU2PUMBKxMNDClUWY7bQr57pS9eryMDwmMpIbkq5E33TV+bQLtSgc38tPGD7OUw456L345WbW5lCh0Dh7sxxcuEHPmvZziDIksr3wae7mIOlCUXI7zuWMadvXrUavJsFvnB3jwQtyIXkX5NWew8B7nuysRBWEwoftuqrr8WLssPWvC/ZyyOxJ9BNimZrENKGgZf61kAOYIpxj91HHMk5HBfZpktHiFdqsuZ3Q9M+eamOsSj7M0myaC4suPC9gJBvMwlBb/WfsU9pp/nrIpOOffT55bSwgY6yW7J8KQrAs1fqIb3Tm9OazWct/uXDkkQ8qxig6dqtDNOwZ1LHTGwB4t0ZlGGrCXoh+Da5XppmOsHqGZexn2PyL1S0DK+xlB0/g5YhxxAiRnNOSDsZRjs5T+IMrPJny6qO3vcFqfnfpco1uUnNueObF/ZFhbAu0Ux6Rg4eZziqSg3TL2ffAZqRQlpKZ63LEeyPUkOTFYgyHrShCfkLWuOapWZ0jXtZl0fj+wcLyjba24qJbuEL37lAn9ldjyC3/s6zgfvTBf+Gns/7deO2CZDk4mALuXdq5+u+EenRqHlIihRI1hse5MkHq+ntlJuZJAsdAL83RjyCBdg5iCraU9E100Ud2z6IhF/YfnrPHVebLIyzNY7xoXzNOfi2eehZMqMrLdzO70j5wu9Frlv2qoXG97XKBMdKxaEAAca+EwGGkDRKTxFw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(2906002)(8676002)(41300700001)(478600001)(82310400005)(40480700001)(54906003)(86362001)(110136005)(4326008)(6636002)(6666004)(26005)(70586007)(316002)(70206006)(7696005)(40460700003)(356005)(1076003)(36756003)(8936002)(47076005)(186003)(2616005)(83380400001)(7416002)(426003)(36860700001)(81166007)(5660300002)(336012)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:04:44.3963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d56b6e3-09f8-4442-0fe6-08da59954393
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
All the controllers can operate in the RootPort mode where as only controllers
C5, C6, C7 and C10 can operate in the EndPoint mode.

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

- PCIe link is up with C5 controller configured for the endpoint mode with
  a host

V3:
* Add DT nodes for the controllers that can work in the EndPoint mode
* Converted the existing device-tree binding documentation from .txt to .yaml
* Add T234 specific information to the RP and EP .yaml documentation files
* Added regulators required to power up required power rails

V2:
* Dropped 3 patches that add clocks & resets IDs, power-domain IDs and
  memory IDs for PCIe controllers as the patches are already available
  in linux-next
* Based on Bjorn's review comment, reverted the commit b57256918399 ("PCI:
  tegra194: Rename tegra_pcie_dw to tegra194_pcie") and pushed it as a
  separate patch before adding support for T234 in the existing driver
* Addressed review comments from Rob for the other changes

Vidya Sagar (10):
  dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
  dt-bindings: PCI: tegra234: Add schema for tegra234 rootport mode
  dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
  arm64: tegra: Add regulators required for PCIe
  arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
  arm64: tegra: Enable PCIe slots in P3737-0000 board
  phy: tegra: Add PCIe PIPE2UPHY support for Tegra234
  PCI: Disable MSI for Tegra234 root ports
  Revert "PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie"
  PCI: tegra: Add Tegra234 PCIe support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 370 +++++++
 .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----
 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 395 ++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
 .../bindings/phy/phy-tegra194-p2u.yaml        |  17 +-
 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |  24 +
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  52 +
 .../boot/dts/nvidia/tegra234-p3737-0000.dtsi  |  23 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 935 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 622 ++++++++----
 drivers/pci/quirks.c                          |  13 +-
 drivers/phy/tegra/phy-tegra194-p2u.c          |  48 +-
 12 files changed, 2295 insertions(+), 451 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml

-- 
2.17.1

