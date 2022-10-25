Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0BC60C408
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJYGwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYGww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:52:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712CA42E4E;
        Mon, 24 Oct 2022 23:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/F7rksvqvDnW/b4dQReT9qI1dydLqFXrBtO0LbDa0l/cfQ2Zc/UXusKVgh4kRiuhPSsckV3OfcaMRIwHaYA4A3TMnwQ0hWN/JmJ1rlLM4gL/n1dBGasLcarNlQQpInhXsv+7/VlLdVZYN1y7464hA/zLDi7VeZTZjfjKDemhI7QfDi+iWfBDAiVLXw/W8vBjFMi1DdVeb6dLpdOVTzV5eMC0i5L7sLff0G7/9wmENiRIO41v9b944v1oJxPyWvgJI39ZEH6meraTK0OfLkp7+BQ1I5baEmh/Y/uX5gktNG6Tu7V7Bvwma6jRzLYiaftTFlcLBfwHDqPm+Y3mzenZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8CZ+dripgv69xyw2s/HScRj2qUnmb0A8T8TEydkHRU=;
 b=OSPjS0UQr1AnpRXVyEu61fldrr5zEIyytRXFh2C49gIkXe/L8UqeAotAC5A2+CcSughIgg7OpLe9kHpOhAICJwDLwqfEHV5SVRQ4NKG6Tl80/d/efIuy87xLkNcWazRilZwWBEprwadrHyCzTGk0hBB3xOkwenjpjECWqPXLrr8QWEwBX3Uuk5lAV4GYMwqJGgJxytJIs0EyFQPy0p69AixO3/hf7lHBxkMYqdhaTdVT30NyY5h7xEqPDijYVNzsyziAtOPi9evKu857GRGg3jRcSaDNpn/PCWD5wUcWTPikDVenMaN+7SAl8nZ0gL+kQk75VyIA2ar5/ton/2q9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8CZ+dripgv69xyw2s/HScRj2qUnmb0A8T8TEydkHRU=;
 b=qEHurgKP4LSqPFiKAyU7/4IeV1jnBAOXKQ5aqAn4ZuHJaOH4XZNqmSN1gPhx3WigiwsPWSPppvEfOOt3YnRVjzYAmmebpsbGxrt2POYBcuuQwKDxoe6Y4ugZTMf5C8kLyFFF71hzC/aPYmEsCWn9bp6tHwTdMk3t1k2IEcuj8SQ=
Received: from DM6PR14CA0057.namprd14.prod.outlook.com (2603:10b6:5:18f::34)
 by DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 06:52:49 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::f3) by DM6PR14CA0057.outlook.office365.com
 (2603:10b6:5:18f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 06:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:52:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:52:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 23:52:45 -0700
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:52:42 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
Date:   Tue, 25 Oct 2022 12:22:01 +0530
Message-ID: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|DM6PR12MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e5c6d0-7fa6-4f8d-1eaf-08dab6558810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pigjjs9Bz1htpF0ztNddpl3m5LIXupofnabb1QxCDKUu7a6SRVBjVqw7sPTldZBbP+wFgi52mo+mE0IGX80Jm6Mo70UjADpB8yRGB7P0kFNTRkiDdU7tg+ACYmPe850+zBCT3eyHfY5uEPC+K22lxYEg63bPUYbNX5ZBF7/QcegqEweQUuCIwLEfmLdu4zATDg2OyJBztCJk7CO1DU1595vfnQG8Y0cFofjaGOgAy3xjwaMUrQCI3C8v1s8hl4mWm8TwTcTzwdqMGGHA1bxQmpo1wpDlhga47+emXEbjCs8ojuQzEpLDTbFMqD4y5KPHRVDfHzsloyIfyXdzUf3WNzkKNQCCQZRnZyzAWSM0c3F8dQxrA0cIyw4mKjHzmk0eVMg6WEqCX9UAv3J9dtxzwdjG4DBnO4/SjDjrakUTSORMPiqE+yQpN9PA5zUrfYdPHy1x/IVdSYI05G2ylnbRmaOgCNAyYKPdp2kSEnq/0qSb7i88O0mbVQgmg70HB+tRxLQ+7nBtme59xdgMiaQTBqC/6kTrJMbMFXG6Ehu77NGUEU356fRUe93ZL14KP8DNwnh58rLvjqqt4DRYcRzOlzw0jHLcskA9fUiAOZDUTVlbqBAW8kpw1JCaY/+s3WdK9FMgetDtjipEOnyebqYZ9ChqXP5nzdVFU9yU12akfBO7WQ4yefjSBHF0nL6H59bRTZ6tB4VOt+F1CoYPIOO8k3ldxdfnsuxfYltz7qTJAmaipDrChE2k8/NqLQvlpezfqXb/XGSIf13amkIyAWDhyf1BpvDREoe6xH6F/cGSAMnT3UGZ6tRzyjBRP4Ax4kWz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(426003)(47076005)(86362001)(36860700001)(70206006)(82740400003)(356005)(5660300002)(8936002)(70586007)(4326008)(8676002)(44832011)(2906002)(82310400005)(6666004)(186003)(26005)(2616005)(40460700003)(110136005)(54906003)(40480700001)(81166007)(316002)(336012)(478600001)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:52:49.6798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e5c6d0-7fa6-4f8d-1eaf-08dab6558810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current Xilinx AXI PCIe Host Bridge driver uses generic PCIe 
subsystem framework. This driver works on both Microblaze and Zynq
architecture based platforms.

The microblaze architecture specific code has unused PCIe host bridge
supported API's which are no longer needed. 

This series of patch removes unused architecture specific 
microblaze PCIe code.

Thippeswamy Havalige (13):
  microblaze/PCI: Remove unused early_read_config_byte() et al
    declarations
  microblaze/PCI: Remove Null PCI config access unused functions
  microblaze/PCI: Remove unused PCI bus scan if configured as a host
  microblaze/PCI: Remove unused PCI legacy IO's access on a bus
  microblaze/PCI: Remove unused device tree parsing for a host bridge
    resources
  microblaze/PCI: Remove unused allocation & free of PCI host bridge
    structure
  microblaze/PCI: Remove unused PCI BIOS resource allocation
  microblaze/PCI: Remove unused PCI Indirect ops
  microblaze/PCI: Remove unused pci_address_to_pio() conversion of CPU
    address to I/O port
  microblaze/PCI: Remove unused sys_pciconfig_iobase() and et al
    declaration
  microblaze/PCI: Remove unused pci_iobar_pfn() and et al declarations
  microblaze/PCI: Remove support for Xilinx PCI host bridge
  microblaze/PCI: Moving PCI iounmap and dependent code

 arch/microblaze/Kconfig                  |    8 -
 arch/microblaze/include/asm/pci-bridge.h |   92 ---
 arch/microblaze/include/asm/pci.h        |   29 -
 arch/microblaze/pci/Makefile             |    3 +-
 arch/microblaze/pci/indirect_pci.c       |  158 -----
 arch/microblaze/pci/iomap.c              |   36 +
 arch/microblaze/pci/pci-common.c         | 1067 ------------------------------
 arch/microblaze/pci/xilinx_pci.c         |  170 -----
 8 files changed, 37 insertions(+), 1526 deletions(-)
 delete mode 100644 arch/microblaze/pci/indirect_pci.c
 delete mode 100644 arch/microblaze/pci/pci-common.c
 delete mode 100644 arch/microblaze/pci/xilinx_pci.c

-- 
1.8.3.1

