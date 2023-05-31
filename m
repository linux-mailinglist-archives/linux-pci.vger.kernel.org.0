Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED82717A46
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjEaIi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjEaIiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 04:38:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADCFBE;
        Wed, 31 May 2023 01:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGfvtqD+xR2STWjIGPoucKbomjPQcUPYI+gzV4Woc9kSsBJjAnn2CSlz7bBzF+B5bZwbwsBH4PcNQNT6KGUfaLEeJeURuEvfYyRg6Ql/Ggie+HlchVQV/OSII9/1gttu52xW8DARs/RjBoz1pc++xGFmbE9Ns2ZEC8JQqhY1q6LuOCMcqLOLfzoN4ude2EGfwcH7tus5OjCZH/YvHRRpwv5HhNhl83Rf5VxM3Y3ddIyetb0eRhkVVtR2X7C9k/w1b/JVxRnAtdaczTAVh9LDw2f80BhokqEjAd6h2rKos+vnfvT/fytlRjiAUhpyrymE5JfDJI7iaGGzcLo9YM+cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZmicaCvfQOrReh28SooQJoroCwMOl2g2iv2NvidjWs=;
 b=AMavsJ1Beg7ZbCqIve26AbJPcM5yNSsTa+GU84hNdzdyWhGZOuYTBfRs/NOovAQ+8rU8HGmlasi6OGCioTMWTxGHJpEqj5mW34X7gxrYmLAoVNAsNrfjxSXifk+tvxwYaVDjhq7ompoMww+RsCHCMsMnlVrkLx6/emWCiItLzahepsIiJdVkbiWEy+M9vn1ZonG6Fg6nIZukxB5KhPkqH24K8GId4fRxMaAZmn37UwHZsb/DozxsmoFrIa+Zb8cv/MqVVrNX2Ka/sqo8UUPndwBRPXEU9euzqzCMgaCN6cBt5mX9sdCnq8GGD+esByhh7BB51KGCWC4onw3+CgYdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZmicaCvfQOrReh28SooQJoroCwMOl2g2iv2NvidjWs=;
 b=eOnz2Eg/mHgK7/FgFgXETqWx3n3hqLfP7V6dngglPg6hS/6ZRa/f+CCIhbN6msnLP9QUChBBHO9hS5ceY7Sf6cH1jQmQZBDqTrLSK8JiUKSvi+bH3jPtt7DsB2q68rV66quqNblOqimvjUj90TgmBounmUWYgn7zWwzuk2L1zM4=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 08:38:50 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::65) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 08:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 08:38:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 03:38:48 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 31 May 2023 03:38:45 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        <nagaradhesh.yeleswarapu@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v4 0/3] Add support for Xilinx XDMA Soft IP as Root Port.
Date:   Wed, 31 May 2023 14:08:22 +0530
Message-ID: <20230531083825.985584-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: ca00dca0-50d4-48c1-95cb-08db61b2756e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2t8oTm+jzInNlZlIyfYPbvHbLlw6XDEtYuztT/s4i9afI5AJ778wcO5Nfmc8ugkAEZ33djLYw6FgEE9QpUt/Rwtgkeuo9EgcY2hJao5Tsdv8OJx73Sx/fGxU+g5jVpAemxX0vfVFr/O/HaOUf90Cn+1F9mzyeWPF7uPzHgZITyfk7IXOVyP7wUVtDV/pP7+b9MqArUDldljHUKP17tZAzZkvXRHLGHS9oLvGfhGKyb7z2PWwaiN0ViGnUXjVopWykC7mSdNKhFU5i8smasQu6CG6hCcKO8DB5F3BnkinQM0EQtitjMOMusuzPYZr5Vx7IHsDrwGAdEVhackFbZFZboRdaq5uswqeOZM6LH1QBE8wr1/qfmZUt84xp+KQak7b/zgOAEMPRBVjcOcm2RMTrNyOa/oLbEcpwquIYseT6OPcX0P9aR0E92ZDxrJyT7ZMHYjeCi7ELM9sfuR1gl7Gt6gugj0NY92Otqmig3BPya4NKCmkxvyUFIuZKdSCZK5/WHt00jBqpGZaCOIhJitnPIrJ777/pDLhH5PCGBIS8EuDy9gR7dQJVw0z71Z9MAw+i34gOOEqMQmZPIQvJIgpuEcy/wY3VmH+3LjtaIasZ6GHmDGNJ1Oys5PwNzsYXNQY9vsp0M5t/qKoLwedTvkwSPY33kA0obcbCAHGz491ZZ4DyEIVERjM85Mg7kPhKFJCX4dVceXKXyMPHPLY0xqwvZFlYbqkuhSy9r8I743u6BqSpdzKMBwW2AjRcPQiM/v9iJWbG05ZUgjUGWnEwMeuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(54906003)(110136005)(478600001)(44832011)(70206006)(4326008)(70586007)(316002)(2616005)(426003)(26005)(1076003)(41300700001)(8936002)(5660300002)(336012)(8676002)(2906002)(186003)(6666004)(83380400001)(47076005)(36860700001)(82310400005)(81166007)(82740400003)(40460700003)(36756003)(40480700001)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:38:50.4061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca00dca0-50d4-48c1-95cb-08db61b2756e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
  Move and rename error interrupt bits to a common header.
  dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe
    Root Port Bridge
  PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver

 .../bindings/pci/xlnx,xdma-host.yaml          | 114 +++
 drivers/pci/controller/Kconfig                |  11 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-xilinx-common.h   |  31 +
 drivers/pci/controller/pcie-xilinx-cpm.c      |  38 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c   | 795 ++++++++++++++++++
 6 files changed, 959 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
 create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
 create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c

-- 
2.25.1

