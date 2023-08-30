Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BED78DB71
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbjH3SjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbjH3JHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 05:07:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5FACC9;
        Wed, 30 Aug 2023 02:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdNTldvYzjxzoKppl/tBn2YJC+lmFBTfOV+8EXiQYAPLXBjeciMq6TaHBm+MFujsi6b6v+PBgzv8G0gxB9FYRI0wF8BEttrsXnCYQ/3hptSgbwHp0tBzwp3K1XZIbpXTgI3UB55JzLQ1u4nFEtHPHQUr4EgZIbfS3f65NU26EjSkoASLhjdI70UWJ7nhXcPbrPBN8CBAmv6cGFMweYgiXJkdvM7iYdE2o3Te/tSPUAXtcIHi3hfFzXPJakv2Qm6UQkP5xee19YsB90YNHRA2Xaxpyx2MrVvdJyap9tLSnqCwTUmtCifx6lifUd+BLqHl2XvjYz2f6fKMcO6p90In4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrqH2rLyf2471W7zshM7Xz9MgcR2yU6GBBMPrBWCKuQ=;
 b=euTerudDokGQTzXf/pA01mQq8L7H6uqUaUiC74sEpDrAezhhSWYljBdygjk+1QV62hshFVH1Fep4BEmvZWLPelS4Lr7HU+GrqBvff2ormJbb+AQQJlVgjfx1XE8fXJtnU9e5PoLHMZMcbWDypR/SQd11KDqsjJSYKV20C5ugUGhhzWop0F6UPjZAwKKOc3bIGJRPRlxhleqN1kO5KsDIvkYi40ifs6jAGVlnoPriHnqB09PkUc0uY5MnTJfjgHIC/FuOUBqs/94X3RDKuO5VkRfOeJTqIsalP9qyYts7cFSH2++TZloUevRzCMQtyGIVTlnfe7m38KoNdTPxouYdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrqH2rLyf2471W7zshM7Xz9MgcR2yU6GBBMPrBWCKuQ=;
 b=Yog6tpXBvDrKk8GtISmaDO4OcMVmh2kF6+ap8kX81QORmRt51nOg17MVQjVuNkQ/Jmee9YvCrU3xT9O1Gz2/w7d96pJqhKNHO1m/89L8himUXKBfXO6kAqtMZN6hoYhcnIAEvl/8yD0z0hWhXBuTyYrQVo+Z6gLZHmERhZjhZxM=
Received: from PH8PR15CA0006.namprd15.prod.outlook.com (2603:10b6:510:2d2::14)
 by DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 09:07:26 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::cd) by PH8PR15CA0006.outlook.office365.com
 (2603:10b6:510:2d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 09:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 09:07:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 04:07:25 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 04:07:22 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v7 0/3] Add support for Xilinx XDMA Soft IP as Root Port.
Date:   Wed, 30 Aug 2023 14:37:04 +0530
Message-ID: <20230830090707.278136-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: 1068d219-59f2-4cf8-d931-08dba9388773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ALl6zBoiIdr4rsXrVn+gb9RF9JHZIz8RDUyX9iEmJslAIBnaFhLE0sEzxO6Rs8Lk4nAb7H4B5RzdDs2qphVjkbxLHzCO9HJDhP/3/LP58seyB0a2lNw3SJ1hAon/FiJuTdxLpYFIboybNLcG3je88cDgUqO8ixUlgugePQYLbY4Kl/1i3kWjfz+jRVm+oktmfWujt3nAhFMRRe3rVVv3aOtuoOJ7wpqgH1qL4NkJHnhqXNxiQrP2zrlCo/ljP86UG4M35Q0GiLL0/FML96Mq+76N+wcMTjT1dshW9Xf9JYTGZ/9bBFsK3PzV7J9IRvKw3XtYWgHB6OqJEKcY0efr2DJnMFSQ2VhY0DAKDDgDnEG5Fp+WHjwTDj7kg6QXaBRVzjRWIQGQOp2BonnFGr2DCj44rfCFmkiEmtfr8Puv1An7uxiVS8KuDvOTOidp93RPs5mNIpWQVEnV7GuaKaZaOBUTmZUyuuWj/EZMV6v+pzohe/wu6d015dGmu1p5oeUI7gYwXw9cN0h+YohUClwZdGi01m9w4YWMSB0MuflVAl4YG0vGkL6Tviudye/L1OJjZuCUHp51B0sy6dGnm64TOKYHu/+vzJ/8Hlw0KAP8cVok1bbiWbh//HVSdPMi2wsLVN8uVhdYfXMFg9cro7XXyAc5uVeAwRJo4RcLatb7oUJqb87ebafbC2nRdGpJos+++eG+vHkm0b59yJBAvaOXk+ukVRxugd+8su9E94ussDXko1pd3wlLqEztzYryuEIeanrXd7OupSFPUhbHAPti2NHvAcpVgjCw93D9sh8TpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(70206006)(2906002)(5660300002)(40460700003)(36756003)(86362001)(44832011)(82740400003)(356005)(81166007)(40480700001)(8676002)(4326008)(36860700001)(47076005)(41300700001)(8936002)(83380400001)(336012)(1076003)(426003)(316002)(26005)(2616005)(54906003)(6666004)(478600001)(70586007)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:07:25.8211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1068d219-59f2-4cf8-d931-08dba9388773
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5152
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

