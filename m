Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E21569CF3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiGGINc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiGGINR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:13:17 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F714D165;
        Thu,  7 Jul 2022 01:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enhJps+/KVP0/s2La0s6MfGnakmQZc/m6aKWnSkg6Tu5ef5SJwoo/izsIf6LD7JHaHJEo0+6yX/nbxkGTUiPL44UJ27ht9DHbKA0AXtjti61Iz36zF50Uq7G9sXHIhRACWICAUMGA64GWDQyLWei1sc3oRtA8WPu3u8ITUQ54s6NwpPw3BR1O0cfM96UmWAYBV3rYjh0Sn2Xj8R03ZLgWxDKre0b66c/TNGUwUjKL6W8Of/cMIvaSvrW6U2qQ1aQ5nYoYXuEO+QfIiVi8BPElYpVphzviXo5tQeQcw/II8blrr77hXIxBykilwt89JSomZcYqTGDlfnjdfM9CYsl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBGh4nMQQhPgydKs055vn5hRIH/pfZICV4kzreD5Imc=;
 b=CI8QigfARP1iVwXCqjmvDhkwkZ5XVFPGqRsvgI8tJAd1BThK+dVbtQgU4ybvoz0yXpKQFDCK5wN++Z0aX++9IwSEvPxk3xExA7TYRiovidyx4rDLm7oIlKNVJi2acaxtiGssKE8Ev445Le3Ht1KOO9fON801PnrgtrJHOBIaOh2HKHRBZnvbEbkgYLzeVi/yHQ5tf2iAlkBk3uQ6l9xUxuKAtPuMhzsT4Pepclp2W5iI9AKXeH3x01GevrW2Hm0zMScbmNNNUztgEQEz9hsFm3ESBy78vnPBnGB+xlyvc/aY/v7/mRHdYJgOPRzw6G22SJCIqqfre2Grov9/BrdiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBGh4nMQQhPgydKs055vn5hRIH/pfZICV4kzreD5Imc=;
 b=dxJiJtgMXV320Si9H/4zfX/X9gpiqByyRZWGix5GZKkuUGf3fliUtYlmQ5jAiNA/LPvILnBa5e+9fAyPPeNF8BsLvzKbZnRKHHD8G1ymjKnd+9rWRIqIyNEaGN1/n9Jf6rVKIP3e0jEwPOzNtURaIeyLGZzCypMCcsPV8YYJUbU96X0YaqVpt8oj5KrTpL/R/uVJ9AW70O81h+R7Yyl4sky54FZohoaX+QTWg4JKCWrD8aknCKw4si6AidC6RHCYDFKnVp4W50jdUv7JHawEojsKyXS6NVwBcfMrSD1OnPqmlkNNCPNB8J7xw9figH6SMrpgHLU4cD+IDLsSahUOBg==
Received: from CO2PR07CA0066.namprd07.prod.outlook.com (2603:10b6:100::34) by
 CY4PR12MB1704.namprd12.prod.outlook.com (2603:10b6:903:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 08:13:09 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::be) by CO2PR07CA0066.outlook.office365.com
 (2603:10b6:100::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 08:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 08:13:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 08:13:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 01:13:08 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 01:13:03 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 0/9] PCI: tegra: Add Tegra234 PCIe support
Date:   Thu, 7 Jul 2022 13:42:52 +0530
Message-ID: <20220707081301.29961-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ba16eaf-b35d-4dd1-d894-08da5ff08757
X-MS-TrafficTypeDiagnostic: CY4PR12MB1704:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCjnKZFCJ4QsrR0pEv2tDf0yMox5W+rVPqyp6smkWG/u7OvYXyQL626B3Y5jCodeFberAWtg6YBQitsTYfNAFh81cHYsP6oPHtZN2yRrK+zuAik4APKNIcCoilsPUUzcFIiY3g0i9tbnXKIazy8WzkPM0DsTn6uWRq5o3Wz0mbZnu0UF1MAPcY8kLDytI34xnOl2FzDx5a9JteQmiKq0V0OtMqaV5QARUfhWkQ8TXhJkgWrfgEX7VS2cWMwU/wLVBuDtvJHXVYNPLrriULtI1qHG+/iXnUL87jCpk/ndX45X/HW7VlI66n7ygmMG5cpnm9M7gGoLWYODYQe7rvCAvdBK7MSO5qsu3y7QehRiyfMeU28iD+bPdb1iuGO9sh63WVrQzg0JFTNSvzdFRkjxjH/rdKzTR7CWztvEtbC9BFD3kj34Sd1yzMHzxj+nCt6kOIoaXMnUXIQQ/XVOu08rTZYuPhVW2OsYsT0wNBrAH+QUkMgArlaU+G7FKSLvThmtOLOLMagfKd9apWZHwdbPFEru177PiM0/FtXf4+qzSQMbpA/uBlPE0FSEu/LHC14j/WLzK5ZMQgPFDbEHCXrMxgmO6uFhm77hUp2yZnQ/9zlFS5b2ao+4q0Vi5wfAcLCyGIVoU7YvSXutmeSJWUCeUrtyZGkWYQ70gtLfwgUUKBn901Dj3bdpQofmzTtpX6KQ0+VAXDnlKyuy/BPD4QPB1XXaHAoRS1NwJ0GvZctMRzcpJSpIovOaVsvoAgdv0ATm24YEDcPJgwkg7HNPnNvkMK3aq5pEJpooExK47Vb3LthDvbnxLc18Zv7H8NF5f7w2OLlPcFqoyUrnGwQirwjSrTKbN8+Oe6uCDCYDE3RCRbzMqYaVd6obCB02QdPQexo6
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(8676002)(47076005)(5660300002)(81166007)(110136005)(54906003)(82740400003)(86362001)(7416002)(8936002)(356005)(82310400005)(6666004)(70586007)(4326008)(336012)(316002)(83380400001)(40480700001)(426003)(36756003)(7696005)(41300700001)(36860700001)(26005)(478600001)(40460700003)(2616005)(2906002)(186003)(70206006)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 08:13:09.2567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba16eaf-b35d-4dd1-d894-08da5ff08757
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1704
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

V4:
* Addressed review comments from Krzysztof and Rob
* Changes are only in schema files and regulator patch
* Dropped PHY related patches as they are already accepted

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

Vidya Sagar (9):
  dt-bindings: pci: tegra: Convert to json-schema
  dt-bindings: PCI: tegra234: Add schema for tegra234 rootport mode
  dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
  arm64: tegra: Add regulators required for PCIe
  arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
  arm64: tegra: Enable PCIe slots in P3737-0000 board
  PCI: Disable MSI for Tegra234 root ports
  Revert "PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie"
  PCI: tegra: Add Tegra234 PCIe support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 339 +++++++
 .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----
 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 381 +++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |  36 +
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  51 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 927 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 622 ++++++++----
 drivers/pci/quirks.c                          |  13 +-
 9 files changed, 2170 insertions(+), 446 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml

-- 
2.17.1

