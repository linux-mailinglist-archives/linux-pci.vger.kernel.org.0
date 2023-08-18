Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786097808BC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359269AbjHRJg0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359284AbjHRJgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 05:36:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E545B3A91;
        Fri, 18 Aug 2023 02:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu6ng6+Nb5QCoqEBKqt0CmlF1Wtg9R1MhTX/M0TFcs6VdJWYRV/J4bHL9c6DqQKhkdLEFTejNkeeRpNqlocmuaAUYqEgcKtLlCqlZRMs6R1KfEa9OSkeNbJ0K2vdtOe2W8zMDAYjMJN8TnhkjTBj3MBrFaiq+ohwNvDU42vP3xY2Odm4yYS7nSBpjLWAs8LKwowJLVRoNIZ81117/io0zOmD5cPAXgh2znHbAB11aM30InWoU/tgxkY759uG37YuClww6MD42qmDo/Mo42xDYppeY95VKnUobfM87+J2NV6/ext+snCWmifGPhIpIEI7NOika4dBqfai3TsE5DPPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU7frFLcJptOKDpxyN6SEJx9b9lz/72kqx7PuUTaY4o=;
 b=OGaA/LOQFvUOnb2zU3xJyDCWkQNrR/ngRCti7Rsi+nUYBCctCBSYs+0mT2HLw37hk783rycz8bewNtcphfiLB4JxYBIwvdoaP5kjrzsJ40YQ9KwNH4WXiyQeRy86pd9eKq0MyWv7Towij3P3A75zf36ByStChLjKzcpHnrlYDpAPSi2Hblg1hCQlf1kvkG2eokPPNRyDMPV50A8SYkeKAzDbH+uaItvMXErKtr9vUlZZC4EkcVgHf16O5z2gu9iKGTK2IpCAWKxlqfwzERKtLRC0D8sV5gxjDxjNc4ur+Lch4LRP8GNUuSW0AXL1qg2cL3aH9xnpvLJY8kxqhePpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU7frFLcJptOKDpxyN6SEJx9b9lz/72kqx7PuUTaY4o=;
 b=BIomDweNDFD37FUhtptYm+4Zu/OFxkuZT7mbBbrND6fBaZAQ9ZVVhy/WWaNB2qeOrCJiY+Kocu9CUQ3EnJ2S0X34YUVD4ccRCfXrNWQ3b5BMs+M8sT0ow4eajz775myMQx2OK3LPOxrChQZTxvjR242uurMNW+wNMH/rjDjHghs=
Received: from MW4PR04CA0299.namprd04.prod.outlook.com (2603:10b6:303:89::34)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 09:35:58 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::33) by MW4PR04CA0299.outlook.office365.com
 (2603:10b6:303:89::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.19 via Frontend
 Transport; Fri, 18 Aug 2023 09:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Fri, 18 Aug 2023 09:35:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 04:35:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 04:35:56 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 18 Aug 2023 04:35:53 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <michal.simek@amd.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v6 0/3] Add support for Xilinx XDMA Soft IP as Root Port.
Date:   Fri, 18 Aug 2023 15:05:04 +0530
Message-ID: <20230818093507.24435-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ca9694-aff3-42a5-016e-08db9fce8717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psrsoPPhj52e8J+O9a2I34KW2x6XIofyDkdo5IK1vW7Z7RVs+Olczy5bFJfv8IZpXCNs/WUou5X24iDI+tXjQASWVnhIhqHzE641A1wKfxGwvNOHg2koGo4r5F8U0OSexx2CJNp9/nU/tEeZ0Ms7pmxUgIP6ou/jH5OWlnYDTstzW2kqaDqnFzWWH0huG+iz9mUOVG5Zgg0+oc6HVs1AATk4ZH2kSsG9TpEGcRU5ff0i5D8JiRelo1QHq5vW4+iQmnVk30pNMwaPMbRuHALCdamHVk2pT/8JeN8Vee1mdtHs72IC5D5of273i0ooZNteGc1aUH5L8mgvw17IKj9HOBZwh3B2ANWpa224v07v6gOADY5wmsqfta5UzPQuA3KKgrTzIGH4cCR8OLUfkRX0FMuu7n/9aKM9oPLMloFTpQVWzZ8R02u+sjTLkmDb1OUENj4L6mmqs+tkFP+9f4OAaDaTljMs/vd+O9vDlyjW7vbZfB2+27pHxIG4iMESlK8c2k6eKqqbLG1c87h9ZzG0fyzaTs0AqojiOWB6P0SQHIPwfEJ2VAipNzwXs1juehjMYE1Jd8MS2qcsC+ATRd3CaNBX3Aa5sJM65MEqh2HC8RK/oHepsXnMgmkxTv71aTBn7WJXt5Ly99Xot1ZdL4Kflyy8VCEdVdNvFqwZUOeUm0R9Py1htzAFniYE8+nhmGwTclqHZA1Z8N9aJwmj2BlrsdbV1OQtMg+RdkFHhmhRjBV0LPvREkK/+c4NkBShffhHYcOYWCPMUS3q9M/bTvTv8ZB6a0L2rErTceXqCPLA54c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(2616005)(5660300002)(44832011)(110136005)(70586007)(478600001)(70206006)(6666004)(54906003)(316002)(26005)(1076003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(426003)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:35:58.0005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ca9694-aff3-42a5-016e-08db9fce8717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 114 +++
 drivers/pci/controller/Kconfig                     |  11 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-common.h        |  31 +
 drivers/pci/controller/pcie-xilinx-cpm.c           |  38 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        | 802 +++++++++++++++++++++
 6 files changed, 966 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
 create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
 create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c

-- 
1.8.3.1

