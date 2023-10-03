Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7D47B6FE3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjJCRgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJCRgR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 13:36:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185CAB;
        Tue,  3 Oct 2023 10:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KY5ICZY0O5e3+Pf+FsXFnQrkjNdvcUxCKDlcunWNlpP+jfuxwL9kQZTPP9wl5IpRBllu1oxqjruYwtUO5vmzkcCHj4rWtlitT0thgIgnGrx8rr6hs9b3gozCP6bXs2jEuUsh8dNBHQrA+NCkekjBMVjUHA1fWOX+DnT8fQ9eRNLAuHkrfwJ0bCDbhxkMdbvUv/QsgpEd+236mf7iDvtm9lDOX70VGANvKvhSwVXsGIn/qFtIfcwldzSDfrMt3PRxyFEM4iGMmTDjN3I5QNs1PsK4cMc6AZ3JVDNq/j9Gh0QqjI85gsOUfNNxzx2Mndm0HoEh4YQKeTeBa587ZyCLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1QZ0dFzpTsmSLxrgykOW657O6ePz2Od/gvYQe75laI=;
 b=SXX7F3rI5RknnxWO5cexCOx58clk0EBqM36okOVQGy787/c1njO8BrrNAg3fvvyVkZKH2X7KD1jEVX2AH3WkZokfRbOmjkJC3RBidq2ZbeVkZIMv6ZGxpSrOrKx3ZroDyMnaRX12zYMHMqZKrm5EJqoQW1VGwzluJGl6k5GL/Qgw1TQ4rwKvfIiYbYO/Iq9h9FLDg8+V884NHdBOwQNVF/18zcyaNPY4/i9NngDrV0wL4e/EKxXIPIoD4QGxJc7KQ5TzEWbHgE9j3PqKFB8CWl2cNcy+UakyHzPsOY8ef4giEX+302WYs+c66FZACau4MjAy7aqtud+JTRcq0a3xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1QZ0dFzpTsmSLxrgykOW657O6ePz2Od/gvYQe75laI=;
 b=MFsHswfOoqAlYRy6xTaxBPcuuFME9vNmOQb1FeHdmWc7E2WB/Pqti2gHXbYRPiB+bxehPa8RI+H54ASeMGaif+l8hp9aEVyXjamG46X9ZmuspGiVFGpJe4jZWYxN9VWo8jTpkilMhmYKImdUShzxr/zp8g6SMHXOfUrrZWgLRHc=
Received: from MW4PR04CA0153.namprd04.prod.outlook.com (2603:10b6:303:85::8)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 17:36:09 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::ce) by MW4PR04CA0153.outlook.office365.com
 (2603:10b6:303:85::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 17:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.15 via Frontend Transport; Tue, 3 Oct 2023 17:36:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 12:36:08 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 12:36:05 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thippeswamy.havalige@amd.com>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>
Subject: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as Root Port.
Date:   Tue, 3 Oct 2023 23:04:50 +0530
Message-ID: <20231003173453.938190-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 121cec71-85fa-4b0e-b5ff-08dbc4373ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5B87PR4HRvdr5UEaUg6kH8d0oC2qAlqlAT5aqQJqw+4Q3+OwGwL6qMlXghx8bFCFq2XWhcxLYEN6ySfmblS2zedIMI6NmTjo9NvAzXCxmcDlbj1LEBhnD8DyPf5ptwnAjJOuYJSJvHJUdeHMRcvopJGAXd+vRPgOqNBs/+Kc2MCbeuFpsfuklFa9QfFbWRX6qMd1B1frV5ioZOf4SMsNfMgprNiKIwk6TzxwMF4v+9uLhgBjhItE+mwPbSS8rBRND4qan2q7/2EJslMyWe/jRnF0rlBcc2E1wVaWu7aeesxUl79I650tJe/3P+i3DykQz30UkCiMZ6b9vJ0ShWKpFCW8F+/y0/1SGcD+4YF068vr02LzCsaPBfOApuXFhdnc1EYBCTc9Mf3uEa+Uqk+gVv/EFXY61J6RHiT//VKO2ERQJYZE0asOa3BInnqAVOHokhF++xP4QggQKSiV+XhmeJjvs3FHeRIg1cZRnPOSH/KK3y2I/7vavmzqdpzxMhvKGEpXb4swRdwi0/QljIhIhDwQ+gWT9T4Gbu/fb21jmPhKCNe1HafiQPhoc8B1KozO3dPLj5y5Ie/qL/RLEgfWvN/LbM/NeU+qJ5qh8vQ/blQTsVJDtDjdKD+3U4Zmt8mNnGBcQQnAcEpAEcokMG6p2Y0N4qMin57gKPcMtYxGaKyertCmBVSGU/UIzCt2J4rrS7RGsnimv9K1R3RA7tcAaRpjKxmKA+Z+QOdG3WCew+002VobTXu7QRgnusV9xRQCns5U4uMPYP9XSJURcdyHVlHyjqU4k+KC7I5r2Qke+cU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(36860700001)(7416002)(110136005)(54906003)(8676002)(6666004)(8936002)(47076005)(70206006)(4326008)(81166007)(26005)(478600001)(83380400001)(82740400003)(2616005)(426003)(336012)(5660300002)(44832011)(41300700001)(356005)(1076003)(86362001)(70586007)(316002)(2906002)(40480700001)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 17:36:09.0758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121cec71-85fa-4b0e-b5ff-08dbc4373ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
  PCI: xilinx-cpm: Move interrupt bit definitions to common header
  dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe
    Root Port Bridge
  PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver

 .../bindings/pci/xlnx,xdma-host.yaml          | 114 +++
 drivers/pci/controller/Kconfig                |  11 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-xilinx-common.h   |  31 +
 drivers/pci/controller/pcie-xilinx-cpm.c      |  38 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c   | 803 ++++++++++++++++++
 6 files changed, 967 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
 create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
 create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c

-- 
2.25.1

