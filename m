Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3396B740D78
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF1JsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 05:48:03 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:46700
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233114AbjF1J2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 05:28:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHseua+lBvjQRXxKVqUkAZa7LyAZp+dpEvT3KbfpQSC+4X5RZZoowEZSwcCT91+cgwx/SKr8NQabmxZBj0+upDYDy7shghrBZuNwkKPRLpuxLFg0hIP0VqTdoEBI4ie+BrDyr8T27H/6zuUHLIcsKNpdOBwaR3LV/bGaeXboP7L+EuUI+me1ktURJkxQvCCVQWQE68Xz3hu2Ej54fTlmGyMpjdS94EVDsrXMoGWrxHmWpoSRqXQU9eH+XNHVtS4Fu36ZxfI0k8IMyyNhkqHAB1WkPpCVT+Wvu5Q24ggxfhb5taR+0xDmKkVT+cW0CeN/d0o4G35UGNH8+NUFaVBLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABrX4W0T5lOUiTOLtx/NG+biEB7Cm4XoJEv6sC+EcE8=;
 b=DHPPGWt3gYqElyUUvMKK59ZFsIcDcuoBEpiXC+b+Vh8UrO1dVPQ7QuAB+FEHCfcd/fE6sKNvOKYShSbUl7tgaOtP4nc+lMPRn1PeezuYoDCUafIcjyxzlt1GJbnodfe5p6XHwZSSgqhBYtQGnXSdhnFxd6Feo7ZkcHun4l4NGBnoX4Df6V8WKOUyZ4wyJEKwxylWpPujGHJY3RprvNIt1MS32kq23PJKKmV2cRFtCWDsJOK/yVUcC8B5KrJUGdNzGV7twDIcxkAhwXhxOaEHPuSfd0XV0NR4Y4x928EQBuR+hEl8w13q3EuW+8IslYdE8bbwqg4RwjON4movkEwZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABrX4W0T5lOUiTOLtx/NG+biEB7Cm4XoJEv6sC+EcE8=;
 b=rz5lIq8WX8KKiaqQUNVZiyag2+Ms1lOAbmaOwKV7jm3l5TAKKrYnPCglHMjtgaUeCksNQn5PWsyakzpHzSZj1Ads2t2A4EzL6K2ivuK0haZ9dvtvOdQcT4sYiIVtvoQjKcieWYZaHA53NIQhoZlwAhpBaKrFEm3ckAVnmCVuiFI=
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 09:28:18 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::78) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 09:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 09:28:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 04:28:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 02:28:17 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 28 Jun 2023 04:28:14 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH V5 0/3] Add support for Xilinx XDMA Soft IP as Root Port.
Date:   Wed, 28 Jun 2023 14:58:09 +0530
Message-ID: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 679e586e-8346-4b26-c2d6-08db77ba0202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57PDKv2gEH1G04LCYua/dmKDkArHMzIwya+sAbMsMX0WLyfbwaMpH09PM4BvNDKaproygHY3zxjQVeOIlHPNVH9TEJ89dm4xXAUHhK9Y/sLgv35S9aMqLB6c/NLeLul18Yl2BXoW0blY/pxqJaFTkgHZhASaVO9pT/dYCoreENIZK75992JyilCzPrIfCSZEU51NAtQNEAsa3SrsqQ7gL2dkLROWZK3tu46+fiYhTVDLf3zz7vgDUy75Y9e7CwGigE023UgGZOIIrLIAFe1ln9YQgbmvRQFt1rdEiT3Pf78ocbVWf9wEIeUQNqhSTkDqTqvjoohmE7oMJP7Cl7VtHzo0qr25avTnJ3POSzFUKdR9C5BU3kQBzhfNNXOhvJn0PJZRgpYXaNUlGYhnpsYywtURJ3g+e2heZDNacGUWH6iB5dgkuxGJ3ME/beLxOyvHx1WhttauyWT25RXX3ttn/DL7174ymMBWzsids49GGFezDkXLk10OZD80gNj5GKGcSse4M8NyYQvooPCwVfu8+O7oC3q+jFhO/+WUiFztPrBX0XBxXsDWPfoQL7VGRuuTBlib4oBvW2aLuVDc7GrrjMoWq8WIquTL0U45FJN9KcQc7E6CkEB8CtJfku7mF/J0lkZAQu4TXlGQyvGF+McCeELi+gbf5TWDPhErUEQJXd4iJNP/ji5i1JhGCxAsiNapYnxe47eUnlqlwgyXhLMCrnvfp5NSEIMP25EnnaaSKG5rBBGQpxeSE6e7Oo5IwflR/tMavhlAk0/GkiryTi1lnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(44832011)(4326008)(316002)(70586007)(478600001)(8936002)(70206006)(36756003)(8676002)(5660300002)(2906002)(40460700003)(110136005)(54906003)(86362001)(36860700001)(40480700001)(41300700001)(6666004)(82310400005)(186003)(426003)(26005)(47076005)(336012)(81166007)(356005)(82740400003)(83380400001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:28:18.2696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679e586e-8346-4b26-c2d6-08db77ba0202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patch add support for Xilinx XDMA Soft IP as Root Port.

The Xilinx XDMA Soft IP support's 32 bit and 64bit BAR's.
As Root Port it supports MSI and legacy interrupts.

For code reusability existing CPM4 error interrupt bits are moved to
common header.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
Thippeswamy Havalige (3):
  Move and rename error interrupt bits to a common header.
  dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe
    Root Port Bridge
  PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver

 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 114 +++
 drivers/pci/controller/Kconfig                     |  11 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-common.h        |  31 +
 drivers/pci/controller/pcie-xilinx-cpm.c           |  38 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        | 803 +++++++++++++++++++++
 6 files changed, 967 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
 create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
 create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c

-- 
1.8.3.1

