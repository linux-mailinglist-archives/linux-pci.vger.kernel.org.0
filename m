Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45B05731CC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiGMJAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiGMJAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:00:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C18E632D;
        Wed, 13 Jul 2022 02:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0qv7umqy1ESv3p1mcLWieYQBKnXeu7am5skd32hoD3XX8xFFYl/qT/6eYTMARdJxvcEz6oyLe6gvEPlmRe0VOidy9Xqzz0eMFYplbh9shtH0ANXSfrP0HJK/j2FK3/EcR7gYpVCpGaU9+yHO4l+pdMqrqWipuSXI66bSk8qIFbrz8sK6cheJikroqn8UN9ecGseHLajK5Vx2Kk8QrwrmQ5GwPlXLFVQ+R7FflFxdkh5ZUTUtByC24/AFaNziFPCLHHFshETApUMj0+ddo06StEB2BG/Z49Lt98idk/Kq5e8UHJKkCyHHNDp1WMMbqSywK2ZQzICsvzUwOaHbtGn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGZl09GEgGmXjcvA9ve8+Q+1WKcqXR8EqQIGIgd9HIg=;
 b=Zrc2waS30x50cKKdcbNnO6uIsgJUBuJVlomentVhqFSC+xlb50b1gOnJ92FBJ3BGUn/jzIfzqRMSRwU5cJG+x/tfTQqg3XkZFHSWYfuiNaxoGjwXmqJw0f9kl5j5eYDyKDTV4I53mA60a22aeAdfimtCgODu79FA5HwQ3r03OsrUD3aLLax0DtU4BzhFwC5YaPpX3eLCyEkomdwVN61wkZMONKsrdGt8Sm/pbJECUWyovUM0gsfSQmCysMRXMtEbSGcOlJlLfixLfcH2ZQfegU0og7v+uk/pzxrdHsbx975oROQ4mySHc7pHJrCPA4btMFwWdM4zV2wsLkWYKUeYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGZl09GEgGmXjcvA9ve8+Q+1WKcqXR8EqQIGIgd9HIg=;
 b=f4YLjSt/IkvtpIrZgQDP8ia+i6IlGA0cQpR3MGx7RHaINfxwoZLJFIJ6eGF9aGiSL7tabKF+osQB1f1a01rZP6P5J22PmlMTyS7J52WsbidoUG64gFrMEByO1pjxPZCG2jklEagdN5a19VJVIi3cX0HTpBZr9XZ+mpdH2/A68pnLjR0GXzknnBwUsCxuhwMb1wDNhy810B3o1rtc4eo9VEFPQTmj9qzVSSFE/PNI6Idxs7Lj0XSP9GqalTzV1xXAEiog59Xq5FMofwx1w9faM/G3FiYvB79m3l7j7RTuYD4Ytfp0HTGugmiFrfN5gUWEljg/xBc85ZXIrj1bAMMvmw==
Received: from BN6PR14CA0020.namprd14.prod.outlook.com (2603:10b6:404:79::30)
 by CH2PR12MB4822.namprd12.prod.outlook.com (2603:10b6:610:6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 09:00:45 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::ca) by BN6PR14CA0020.outlook.office365.com
 (2603:10b6:404:79::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Wed, 13 Jul 2022 09:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 09:00:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 09:00:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 02:00:37 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 13 Jul 2022 02:00:32 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 0/9] PCI: tegra: Add Tegra234 PCIe support
Date:   Wed, 13 Jul 2022 14:30:20 +0530
Message-ID: <20220713090029.30395-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e2a62f-c1ef-4c47-770a-08da64ae2c0d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uTLmVWt/uwti5FQ7zfYGS+HWJ4AX4+lHozSlkscZif9/wQClklybFwzOGExx7I9zcnO6ValeKOoWB3jgcqybBu9+KR5MvLpWJH5FHftyZSnLhn0R7cLNIpnje6C7ReP7KKe50IQ4WoZlHmiaKnGhtmqehkTWbVpv5kRHT/l3CFXX1OylKW8liNIreJ0Qlan5SJR6BCFB3M4JCYbpODTI8pZDiqNdUVMAehcCPuKgPHQroFPQ1HHkQV6vrxBh4zYrwf4VBjd3aF17mAhv8A1vJNZOL6vEtw2LGUZxnboiKnPjWkMvmh+cchZofgM2dHFeWkdxpg8/KUrQlYyxEg+PBWnDuL76MgFGeOFpHb4RUe8E31WsuYGmk8T626W8G8KMfdN+RDOq1yRWaiTgU8Q5r2gqaZ4pFi672ZUs5VcuksjViGpz83C3P/YEfLuDJ/PllQmZAhBgwFDpAXKF1dyBLC86c+UP52eEWkFjHx06oHSNrAwtqAQGOrgFLFuaH9wYzIVqiOD5Et7DNIphhai1372AImuS97awZb6uXzOKGNz+nVwP/WdH6M3VbFXma7WHo20+OyppeQUS5mcDGXfy7+zuWD7L4o9mxKeA93WPRE02cA5r0nk4VF9nrqCS6xE9Ul8TEmUqaxsgBBgxDpAzxJtsqw34H06jVzkcpJW0+Y53uxmE/0JTVGUI56KXLDdCiN/qFxVXjhbeU1c5DKKfmRZKt+uNU4xHMbfrSGc4grczKTZykmpnj8Cl+9nO5VQWa3aiOWbUliuSMnhdkEub2or4EdQKFspnFFRV2U13BFxwjsAZC+6ikzIekp0z0RTMFyfjmXNHpCMd1VTVoNCWKISD8d/rE3vNRpxI0Qc9qSyC69zdj801ap249WkhDKg
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(46966006)(40470700004)(86362001)(1076003)(478600001)(82310400005)(6666004)(41300700001)(26005)(40460700003)(7696005)(2616005)(5660300002)(7416002)(8936002)(2906002)(4326008)(336012)(83380400001)(81166007)(36860700001)(36756003)(47076005)(70206006)(82740400003)(110136005)(70586007)(356005)(54906003)(316002)(8676002)(426003)(40480700001)(186003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 09:00:45.0638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e2a62f-c1ef-4c47-770a-08da64ae2c0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4822
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

V5:
* Addressed review comments from Rob

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

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 318 ++++++
 .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----
 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 349 +++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |  36 +
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  51 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 927 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 622 ++++++++----
 drivers/pci/quirks.c                          |  13 +-
 9 files changed, 2118 insertions(+), 447 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml

-- 
2.34.1

