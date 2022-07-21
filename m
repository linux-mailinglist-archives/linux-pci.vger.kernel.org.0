Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5257CD3C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiGUOVR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiGUOVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:21:16 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D9076472;
        Thu, 21 Jul 2022 07:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw5FDDCvtXRjrTgR4iUWQ/2/977dbGFXVeb9aPS9ECPKTEAevi+SH+E1AIbl/00mEVFe3LFmp+ejs9pk7f1LQ3y27i7Emvz/x5t4mrp4eDbn39rtt22/3lsopL6710Er9HqhTnFTORkHFdubG9kCWZ80TtVn7CPxVCPj6PAPeZS9RMYdszBiGfOQQeIAcugZcYp3RSA1H07Iam4wsqiNGvBYAAYbyqeWvP4mrEbvHXNGP4rrIw6hOm08BgL5/vsS6SB3wGt9PF97LT0Kwn1DiWiK350uWE3uEdHIW+xJXyZX48HZ+yJlh56BG07jP+cqecactbPO8FHXs2pOa3Z+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ/5wQXA8qAy7cntkCecQiSgrHK2PoECQnT963QYDWE=;
 b=ocz5RVZkvJRzU+H4vxYXfrnSOcwX+HyjhfVhv7U19juYRHi/N+dHjqF/SnAocPw2Xt/LtUrtQFqtBdDzH1BMPixhrgDdY7HHe75RbP3JLhjLmNFU2BBouG2R1yGrGsslPoPEtlTxIhptiOEZiLUxhLOjsOSkhMr3Tb53+tfHKYCFPkh+1ocmo9e7N8aXI7JB3wV8kg2lJif2DjtzjmO2zpmnhpRZE86VlfnYRA0Yi+esViCyDWFmNPtVZqUzH4JKj408O1RFDODPEqN5gbsvUXCV1cMnabrwKvMhonayAzTX2TsVPJbqyIgyyEJJNa36QPnf9hQBykvNtTX1y9w2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ/5wQXA8qAy7cntkCecQiSgrHK2PoECQnT963QYDWE=;
 b=jJlX1mVqQx3bjp+cISc+vLGDA7yDmpMp9O/AeMprX7PNTXspKg8ywuraEo8xh4xBccFPrsKVyxmHmHW/9vF3VZeKZDLeP77zcHTIX8Fb2ijDQG4thiDY2XRwEP08IkeG5Z4o4UAD176xY1QM5a/B2Yi5kva0K+Ghee5V0iIgSFNf76vXJbE2ye86YIljpFPpSFfG+J3NNq1dHgXSa+Qkm1SQodo5OPK1qnFwZUXdKBfMo3A8/ybBUE96MbwD9/oswiOeQOigxfw/poYFAJ9VxOhXTNy4xgMpiCOnnTSkYX53yQKnSYo9nE53EmG6w+cvGwM1Q1Ar3z52Ev+oWGE7Rg==
Received: from MW4PR04CA0262.namprd04.prod.outlook.com (2603:10b6:303:88::27)
 by MWHPR1201MB0272.namprd12.prod.outlook.com (2603:10b6:301:52::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 21 Jul
 2022 14:21:13 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::70) by MW4PR04CA0262.outlook.office365.com
 (2603:10b6:303:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Thu, 21 Jul 2022 14:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:21:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:21:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:21:12 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:21:08 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 00/16] PCI: tegra: Add Tegra234 PCIe support
Date:   Thu, 21 Jul 2022 19:50:36 +0530
Message-ID: <20220721142052.25971-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3d5a86-1b95-478a-5970-08da6b244452
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0272:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/VvclIwACGVpZruTTxWlVlNHHrJ5o6ZAI0QoYlOKX5imxfh+bi0yy0bXZtG/HocleYothOBhKSPGBWTU2GdspVkuE1di0CJjdmw4ID5j+PANOomKsIB6ZfhovHkmymcZxS2nOobHnee1NBTkAe27tij09O27H4ETnwyIBE4d044bi8nGwslugAGRUQ1Lbt3VoVqVoLUirPgc40bxsCxEJ2FwI12rrB/C8ldSnXs+tVQeApCm4XoZr9E8AVgpNbs+eopVQgOBk4UUuVXLuebMqTUDnn1uSdgUuw+Vgz/7x53AUhsQIP8ZoaYkNb2a2RRj8+JwTHB+E8DL9qDjD6lSGjnY3/6AhErOn/drl34j4RKKeDAXuJK6mfT8KzRYrOtTmqSXw7bCLus+8rBQa5fbViENnfwFp0zS7j6W+LQujgpU8kzNFVz1L0FqLdMaj3Qp5jfi6nCf2mvdsx0hpnpJEoZSdb6oFxV0+9evoa6HZea9PhAFN3nXDQIh7iFx6csbqP+mbL8y0rgE/5+sXd7QB4hYciqwN9rOgcXd1tOHya26oGSTBnm0Hnh9m5CWiHQORCZa+rutxXEITCgcieNybZ2YSojwxIzFgSaB4f7QxVgchP450BpXzzvej9a1dD0EvihvyOSwCwmNW3nLR6xRYRR/rNhZ/t3yKcMlOo1raYVyfVHHKT8I629HbmkQ4cbCIQ7Q2gHIjtH67IUSdYuBdXtFqFBinG1n1BtSnKixlqUQnxJnGY71dPVZH3LHXRPwNRQ6MOzXXqBnxyVv0NptajrDXaNhrf6UXSWTdA6uZpxPE/GvvMLI+r4NDaFQ/BPF8HbES2E23pjdanODHk2tA1VnmAQyg5msEupPJu2hJU=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(426003)(1076003)(2616005)(8936002)(186003)(40460700003)(336012)(36860700001)(83380400001)(26005)(2906002)(70206006)(7416002)(86362001)(47076005)(82740400003)(40480700001)(54906003)(36756003)(5660300002)(7696005)(356005)(81166007)(4326008)(70586007)(6666004)(82310400005)(41300700001)(478600001)(316002)(8676002)(110136005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:21:13.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3d5a86-1b95-478a-5970-08da6b244452
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0272
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

V6:
* Addressed review comments from Bjorn
* Moved out non-Tegra234 specific changes and created separate patches

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

Vidya Sagar (16):
  dt-bindings: pci: tegra: Convert to json-schema
  dt-bindings: PCI: tegra234: Add schema for tegra234 rootport mode
  dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
  arm64: tegra: Add regulators required for PCIe
  arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
  arm64: tegra: Enable PCIe slots in P3737-0000 board
  PCI: Disable MSI for Tegra234 root ports
  Revert "PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie"
  PCI: tegra194: Find RAS DES PCIe capability offset
  PCI: tegra194: Fix root port interrupt handling
  PCI: tegra194: Clear bandwidth management status
  PCI: tegra194: Enable support for 256 Byte payload
  PCI: tegra194: Cleanup the exit path for endpoint mode
  PCI: tegra194: Fix link up retry sequence
  PCI: tegra194: Extend endpoint mode support
  PCI: tegra: Add Tegra234 PCIe support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 318 ++++++
 .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----
 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 349 +++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |  36 +
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  51 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 927 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  19 +
 drivers/pci/controller/dwc/pcie-tegra194.c    | 658 ++++++++-----
 drivers/pci/quirks.c                          |  13 +-
 10 files changed, 2136 insertions(+), 484 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml

-- 
2.17.1

