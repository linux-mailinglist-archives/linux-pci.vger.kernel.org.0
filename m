Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC696E4550
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 12:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDQKf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 06:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDQKfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 06:35:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE895FE8;
        Mon, 17 Apr 2023 03:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtn9YFhaHl57OUyS9k01CO9CvdBCD9bjf3GqpaM5ModdIOKN9nTh7Z9PCyCe1m14vDgcUIWhA8L9q68z+Gagfx7FelQvdjMUauRId+ACNlYJJYWx4qufeQQxDUGy+LnisAlnS6hQM5vKlvEob6vAhsi07h/Ft7dnEM1GagIRaaYwF/JryzRF7FUrjjFkbhs+xud6AvkvRw2CO7j6mBblAbvH/XD/BF6QEb3deI6fldfH2zi9vyR3kjSOZpZf3tEROv2WQbggLnh/z+oI2dUwMSwvf5Ad/3B1kuhOUi6ySD5ReimfDv0HmEIza+4nsvO/2lLKNH/RcZdI6NHce3CH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eohcHGR3xOqVsyJ2t2ABIsyEPw9GaUnrXy5TJF3iYI0=;
 b=jklUNa/EqyOAPTBQuCJg1dST17Od5/ItFYAxBfgXOUD/KkFStQWSLr91l2FBYyaEKeYDwIvGqRj+oFklwbyDWH2Xn4rNjooZa7WB2UZogwLEqt5Twlz6S3Dw4yGt1/v5yauh4A0T7wyIluJzr+e0NDy9MugJG3em4R4GrOfJB1kvKiSiWlEAx1NvkmkVCSwp9Js2WcXBrB0OU+3nyPZ8qbdSPOJ2PddIx3OWy2cEkeRj2pAVJNTWjLroKoH4kqVBz6W25FJZGRf4uowDaXVIhKBHXBN/PM6J68uxaRfKyEC5yGm/lqe0j/QzMKkWwEUIoIsp2yoUm2WHEyzvzKPR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eohcHGR3xOqVsyJ2t2ABIsyEPw9GaUnrXy5TJF3iYI0=;
 b=wn8BltaQRVE76KZa6xskdcGCE2rHjaAQK5NO5B3gZ6wUhgBF4EfeqGNBC5tkNktuGgNRh/z/0BOBFMeIQoZr1d784YkPZvnM3F9Z02KhfhqUDNsfnwLBiAxJeia9Jtc+n9vt3VnY/8m1icgxmWoXefBJeZap9C2pYIopzxX3BAI=
Received: from MN2PR10CA0018.namprd10.prod.outlook.com (2603:10b6:208:120::31)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 10:33:18 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::a0) by MN2PR10CA0018.outlook.office365.com
 (2603:10b6:208:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 10:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Mon, 17 Apr 2023 10:33:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 05:33:17 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 17 Apr 2023 05:33:14 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        <lorenzo.pieralisi@arm.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH 0/2] Add support for Xilinx XDMA Soft IP as Root Port.
Date:   Mon, 17 Apr 2023 16:02:24 +0530
Message-ID: <20230417103226.334588-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e0357c-8cce-4717-0c30-08db3f2f28ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLR8FHb936j162LUOSiXS1smD3wQ0NPxsVj5gLLCnK2UhkYhtyR/GCsx6h41fnfe91jffDAMRDlURzsOQ2m1Sy+2plFlDnplU86a1A3fLRTqWuHV9YbIVY8ylVqMaEkhKvias6cks1EM6p5LhwNWakR3grFU8QAEJDP6nNjOudLNOqqoKjQk+0TqS+D5ILHWbihVLm2TZqyaqjOae9sxH3E79tX99r/ofbYXdR7QzxKdBtDCFt5ZLwlW6OlZa0Z/qBiuCdF6qida7gdHgDq86Xa77BJntDsGcjqsB61M8EA2bfoUEVlS07+OvpGpL6euVnfx/rbW7SteDXo8a0fOuwflf5Oqjc1sducWe+RjcKWqiSO9DqEJ+cLQ2j5olgNq4GlBz5/D87USRU/HQC3TjsVXCTzDUPrC+uEbPawjvV78EGwatMaw7yVJpeudsF/UVf9cyeZIavFbGEwe8maZS75tN0gK2g670UG4YsTGhei0s3yIByFH4w+NcpheBoDZvZClFtVvMoaqqxVf7pM6dpWrMn6NyXcgeyubZQAS2C/ZFJJbZUjI7XqtwOYdUJrmKWZWOEL1YukKYkt2tRqo2iZmpovBG0NiKkw0b5zxuloWfZZZV0Hj+PiQaa52wtXH1hUOTpF5jBY+tWiiGmwSq5YdGzaqXU9ALxTk2a2ixvku6fxSui4UH+IBRKurKG+JrVV+4soiVFuDDDD/EEIA2DpFEhl3fRa+JuFQu+PDAMI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(81166007)(44832011)(36860700001)(70586007)(70206006)(6666004)(8676002)(8936002)(4744005)(2906002)(5660300002)(478600001)(36756003)(82740400003)(356005)(54906003)(40460700003)(26005)(1076003)(186003)(110136005)(82310400005)(41300700001)(47076005)(2616005)(316002)(4326008)(40480700001)(336012)(426003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 10:33:18.2931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e0357c-8cce-4717-0c30-08db3f2f28ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patch add support for Xilinx XDMA Soft IP as Root Port.

The Xilinx XDMA Soft IP support's 32 bit and 64bit BAR's.
As Root Port it supports MSI and legacy interrupts.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe
    Root Port Bridge
  PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver

 .../bindings/pci/xlnx,xdma-host.yaml          | 117 +++
 drivers/pci/controller/Kconfig                |  10 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-xdma-pl.c         | 877 ++++++++++++++++++
 4 files changed, 1005 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
 create mode 100644 drivers/pci/controller/pcie-xdma-pl.c

-- 
2.25.1

