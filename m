Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C896387AC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 11:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKYKjR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 05:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKYKjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 05:39:16 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8383F04A;
        Fri, 25 Nov 2022 02:39:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BREf6AMmKAAG0OK6GctZ/iP6YlOSogLzoGFQ5YVDi39OzdRmssa1oDk7lLhV3wimGnMqSnhnKEOgapd3LbmCIy5OJMoiwWhqYJSh39hnIfzOeHbYasvz+g4AeLzazCZSZ0uH6enYSSQXpRlv2lJPYFOR4il1gw5FTv1Nlna1SIHPjmINzazHIDp/5N0PBjyAPnTr8tuE5vZ3Eg+nZrajv/o3iISoAfFUpY1h/c2YexzxUcBP7paHBh8czRN1WDX8bd3rUf8/QDkGAPyHpqW2dMiGSdpVAzUEqtER/CgBnvtQ8HpBXz8LFIFecqhYkxMzWJc0nPj7ZEZLB32Ua+Uxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBAGiCLR/S0r3SzzhqkhxFvMrhuI+l06PcKFn9bDk9I=;
 b=bifn6goCe3Ni5nMVD3HhUrpUCLjuHBy/Nd5Wn0JWIXdgZrPYHyMhgHPt07WQSOtCzW+c5ngOjITKCR0ebpqM5cKjd3KE6GZC+6PR2/6ROcyr0Lbog/aZtuee4gw3QSlh8UPqa7I2PNjh74XSlsz8gmkMQxC90zsB+ALaOiw2GI+HbCIiO4x5mGlF8tS6No6bOnycCq8rqQJLL1Zvz7Db7NpGx87UF58MmlQD19taM0mNm78JPF9mYOd7gdLXyrRPEEYedoQ72ZtMN/VMEr2O9uA2kDXQx09wloJxJEYfIJMuOw0L4dSa/9lnuuUTIhTgamvVNI6v+Jwlbf+mNfDtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBAGiCLR/S0r3SzzhqkhxFvMrhuI+l06PcKFn9bDk9I=;
 b=OWuBCR8giiD+r2dqWMK5SKDYvbXHqdfid27lKOKeLUMsxJjrQlgDOJYaXpuaUMyw22ww9Fw3BQvK97LDkuYEA8AbmPzZI9pDfsREf4uGWExpr+mJI/sw67Z1Wp45KGN+mz1EtZ1oiYBRlePraTXnbMzS15KkBPqBa8I4AnGghyE=
Received: from DM5PR08CA0034.namprd08.prod.outlook.com (2603:10b6:4:60::23) by
 CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.20; Fri, 25 Nov 2022 10:39:13 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::9e) by DM5PR08CA0034.outlook.office365.com
 (2603:10b6:4:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Fri, 25 Nov 2022 10:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.19 via Frontend Transport; Fri, 25 Nov 2022 10:39:13 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 25 Nov
 2022 04:39:08 -0600
Message-ID: <a36d4573-e0ed-89c8-436f-d3fe28f1f59f@amd.com>
Date:   Fri, 25 Nov 2022 11:39:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|CH0PR12MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 461dcb68-028b-4092-b7ff-08daced14b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N84y0uwsjzK2PK/EjOa2ZVvY1eoqx2OfFWPnD2NKuretfdyMYDJD4SEPYAa36KpJAKCk2OnH1pEL2CdjnfeWrFSyEdjP2TDFmILJo3TFjzNCSYkUW4iO5/INwTeCIYZhljPa3mPfXXfJT7yAlnje05n4I+iDZdHn2kzERrjhJz4w2OwCHTW+62zMb621wJoBDGvP20r8mFevnEvpJtgjaz0ajgW8Lv+8ubsPYmyA8/x+QTTjnl/HSGCuzTfX0Bmdi2k9fgyn+KyMDpze20qMQ03ll21l7wfyo1WttSdtDps1oGIOqRGkAVgEJS7c2269sNckF01SwA0ulR3s41PMVc430YeSPK7VG5g+HQ5xX/eH4Zn7bb1CtfmNrbgwvbgCMpUWkOCMvAch28VHePHP87aTA/Mvpot6QYVckSKj9GesbH7TkCBhZraF6jVVNrHhUuqQi9sQvtQtM8xh+cg3d0/BmBxo1+pZvrpMaAPPmiTXZbMwaCk9zI2GcK+bMn7DVBEgsap7vJpabkWNx6391TnHExJQjDmofn6cHeh5mO9xyK5WJ9Yfoq0JRPOaSlde2A8Wt7htWzvzi14cPYFoI1c3VziDsz7yVKv278M/0GZm5q8Rl2ZlZeHvr2vxx3kmwg49ctJnimw4WvgL/9WmUef0kmqt2kZO70A3SNptHQsSIWzC8xX4jIYmVwuE8P6qX+rZdVAUf0xIDu66S1guxKIcs5P6FEDkLsElV1L60pUPO3uXFrdTHLm7zFNgh+moUdpvSRw/lDoSytPZc8yogA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(44832011)(426003)(336012)(47076005)(40480700001)(36756003)(8676002)(4326008)(70586007)(70206006)(110136005)(54906003)(26005)(53546011)(186003)(316002)(2616005)(16576012)(16526019)(41300700001)(40460700003)(8936002)(82310400005)(356005)(81166007)(82740400003)(83380400001)(2906002)(36860700001)(31696002)(86362001)(6666004)(478600001)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 10:39:13.4402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461dcb68-028b-4092-b7ff-08daced14b6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/25/22 08:52, Thippeswamy Havalige wrote:
> The current Xilinx AXI PCIe Host Bridge driver uses generic PCIe
> subsystem framework. This driver works on both Microblaze and Zynq
> architecture based platforms.
> 
> The microblaze architecture specific code has unused PCIe host bridge
> supported API's which are no longer needed.
> 
> This series of patch removes unused architecture specific
> microblaze PCIe code.
> 
> Thippeswamy Havalige (13):
>    microblaze/PCI: Remove unused early_read_config_byte() et al
>      declarations
>    microblaze/PCI: Remove Null PCI config access unused functions
>    microblaze/PCI: Remove unused PCI bus scan if configured as a host
>    microblaze/PCI: Remove unused PCI legacy IO's access on a bus
>    microblaze/PCI: Remove unused device tree parsing for a host bridge
>      resources
>    microblaze/PCI: Remove unused allocation & free of PCI host bridge
>      structure
>    microblaze/PCI: Remove unused PCI BIOS resource allocation
>    microblaze/PCI: Remove unused PCI Indirect ops
>    microblaze/PCI: Remove unused pci_address_to_pio() conversion of CPU
>      address to I/O port
>    microblaze/PCI: Remove unused sys_pciconfig_iobase() and et al
>      declaration
>    microblaze/PCI: Remove unused pci_iobar_pfn() and et al declarations
>    microblaze/PCI: Remove support for Xilinx PCI host bridge
>    microblaze/PCI: Moving PCI iounmap and dependent code
> 
>   arch/microblaze/Kconfig                  |    8 -
>   arch/microblaze/include/asm/pci-bridge.h |   92 ---
>   arch/microblaze/include/asm/pci.h        |   29 -
>   arch/microblaze/pci/Makefile             |    3 +-
>   arch/microblaze/pci/indirect_pci.c       |  158 -----
>   arch/microblaze/pci/iomap.c              |   36 +
>   arch/microblaze/pci/pci-common.c         | 1067 ------------------------------
>   arch/microblaze/pci/xilinx_pci.c         |  170 -----
>   8 files changed, 37 insertions(+), 1526 deletions(-)
>   delete mode 100644 arch/microblaze/pci/indirect_pci.c
>   delete mode 100644 arch/microblaze/pci/pci-common.c
>   delete mode 100644 arch/microblaze/pci/xilinx_pci.c
> 

Applied with also removing PCI_XILINX from defconfig.

Thanks,
Michal
