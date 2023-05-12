Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1AB700056
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 08:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbjELG1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 02:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjELG1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 02:27:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1382D47;
        Thu, 11 May 2023 23:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeQmb/6p655Sy0g/TTQuYRECJ+gXb67CprU9QK2N8TzR6jfAEdT0ZJINCVGoocncYoPBVtMctMsQXUru87nMZaNgK5CkjeQkTOCNrrgXnn/t4AlDT9ktX7bw1MNRabqY1FoTUFhXczo0iww6AiJ2FwfdSiVe/yxNpfJZ9v8UIiOwGdOxVVrJwyABGv2racLfKqC1zjwmd8Gq0fAAfj30eoXHHGsnpUU124RqPOj8YORPHxDH+4PGf1EgP89yvLACN7R/e998ES6oxhujmHljDnnA4Wzl+GB6myZ/Wx5yjXNMbKEa8KrAViXMEYeO9w4YLiVyQAOHdfCgP4P9zZ9HLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jrg9cQjwERw+jBXG4HOPUPiVmNikOuUFB38Ex96oCDc=;
 b=QS7/cbh2ZfbfozbuwQG/ej+NJ83v5WEok9HyygbTI9nB6hyYtRWuomyhMEgeACMbPWCLTzB1ljF7LrwFsiQJf+tl1VBhVNT1C98gP24o5MZw0DGCibXYLWcwZZKy8k0/OTaSILFcB6SrgO7uUgBS9TmYueOnaidOlKIlcJQfHlmJJ2vBHxp1uVjHT8l/jsmbz9WlS3QbhCelouuCSHXh4NG/mA2IWO7dIpVQpR/PqGYTwHIfFRse9VzPgndvgSW63T3kq1nRfOGHM0hez637krCGQs0PyaokXL8nnrh8Sr0I44n9aBBoU867VQHjmJsRuprFLrh23rfADex0LSpVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jrg9cQjwERw+jBXG4HOPUPiVmNikOuUFB38Ex96oCDc=;
 b=biBW0N5tZ5rp9uP2TLHk7AgqWTMNFpNy9U7p6JSgIfdDJOOjQWYK+T520e9wuXMwiU8g/KyVgbeS/On/xQzkQtVJZg4gAz0SE9ohrDwcupzBz1RdmYvLQKhhbqOz9TfYaUcIFSQ9iJMIYbmEU3qajYwJBCFGuJtebqU27MFWhdY=
Received: from MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17) by
 CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 06:27:48 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::df) by MW2PR16CA0004.outlook.office365.com
 (2603:10b6:907::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 06:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.22 via Frontend Transport; Fri, 12 May 2023 06:27:48 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 01:27:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 23:27:36 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 12 May 2023 01:27:33 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <nagaradhesh.yeleswarapu@amd.com>, <bharat.kumar.gogada@amd.com>,
        <lorenzo.pieralisi@arm.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v2 0/3] Add support for Xilinx XDMA Soft IP as Root Port.
Date:   Fri, 12 May 2023 11:57:22 +0530
Message-ID: <20230512062725.1208385-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 124ea027-3c0e-45c3-18bd-08db52b2018e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVTXynBQ3oQsQ9aVMy51qTOZklsIhYH+2RE+oWw+WTnb+yfwvI1Z7bo8V1d5W8Hi9Lkr3Lrt/zbWOii0L4UXR+IgeK2euUx8ovGmSVVnxk20aIWuzli2Pma6317Y3Z4UVP2rB57nw7Nj/sEE8bwCA4glvD64NTReukeMUFjZBY2lOldSZoUkMTI7LmKQ3bS9ZLuJmz8tuOlXbxMpI0VfXkIHJLeEyhTGiFsmgJGCKSohDXYXoVGsbulsXRTYSh9OHW0+xOZ84IwtJ9z7+YjYNBGPHmgzM6727NXWvqaunEDPQdmnKPZs5FxByxjSjPD8xzEuGL3tCuf9f8soC19/PcxjVLzkfWWu9sGqufLtM6E+LZQ9JB69LeyNtCLqbM5MyJpGHRKWHEYaJPh95G8sC+sRYIAAjklRPx516oMScW2Cd/G2THwfwTZ+SEuGjZ6BawNuXKbUjaX7XLKokQP8vRl9jWZ7eOAOj9pa/wnnSMAXJ4twJPwn4JOm3FmiQ7t4Jzt5nUezflvxGiwaUkRWmoi2AQFZjUIJxsfgX4k/uRojsCJcnxcjsS/5s64frqDcCX7NaeXuz2pSjvzAAqQp+VewURpxUX/SdpV9+ZXn7UAP3Gk04GYKaAWFe22h8OsSuENp7Bn1n0fGS9FVSdmtrazYPDyZr8BJ7mcBp+W0tPVbw1GADntJKmiURomSOjNMdxQbJjzWGwyleLdxBfqKqU6wK2p9y9qz0dbJyMpwRf9s0kd2Y6gZiomtA+Xp9vQKzC+osKDrFneVQtHywRFCvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(40460700003)(54906003)(110136005)(316002)(41300700001)(6666004)(36756003)(478600001)(86362001)(4326008)(70206006)(70586007)(40480700001)(1076003)(83380400001)(26005)(2616005)(186003)(82740400003)(426003)(336012)(356005)(81166007)(5660300002)(8676002)(8936002)(44832011)(47076005)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 06:27:48.5240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124ea027-3c0e-45c3-18bd-08db52b2018e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
  Move error interrupt bits to a common header.
  dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe
    Root Port Bridge
  PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver

 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 117 +++
 drivers/pci/controller/Kconfig                     |  10 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xdma-pl.c              | 800 +++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-common.h        |  31 +
 drivers/pci/controller/pcie-xilinx-cpm.c           |  38 +-
 6 files changed, 966 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
 create mode 100644 drivers/pci/controller/pcie-xdma-pl.c
 create mode 100644 drivers/pci/controller/pcie-xilinx-common.h

-- 
1.8.3.1

