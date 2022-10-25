Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8960C80A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiJYJ2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiJYJ1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 05:27:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F665D0;
        Tue, 25 Oct 2022 02:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW0dVVJAONQ/RMY9U6px9RoWo8ibL0U5z0LrbIfZf4iY1vyworMFrX/Rli5kSvGLI8YXvAYX5dXG+2fCw4rMeb++kYsM1onJxVjeJ5HNAeGABinUylBJGnUCYXCpJuh5Wc4P0IQLOIvzaFPUv2wIpUfpYVbhgaAnm5fYqBL0GZM7uOZuT7aZzAp/Zi43VbMUgWSFcYt3CKCtwcTHfgqIvV/raqnZm8lCfgPNO33Ud1FBVFMzvUc9qwHZ9zyhhb5Tr6OKq2RYJVJEyz35Ybwc2eFD+L09VGxTINhpyAf+QrgQFTJE1CYvzLEzKeNYmHsmGF09Sm6LDby7WT3oFzLJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh1cvljWNP9PYOoCdbCwwXFh5PTX6BdXQK8dC6eV2Z4=;
 b=gDuixFbLIoiMt+FMoNcdyyHBQmVyXArLz1rQUEQ4663z7U0fYRXC8gsbopu2SCRHW4mBu11SNFlMqcx4b2anRv3AIiOnmkAeZkCJXMTvAA4VCetpqhxI06Ub2DsErLMtbQ9n5+aNzjJhu+Kxu/aJe2sBxqnWzdFDk+1ifdlpPQxcVLsfnBNv6YIMRSMvCuyiohL5bUXhAryKA+2sQwC6HOioS+5H5j16l9VllxaRHIfg7LH8HN94XzqsqML9gp4cQ0D9xodfcJZGChzdKezDvenoSSWSKNNoqh+8n3rWzIekdc2/cXRU/n4Zp9RQoAxIcR47KC9iTkKVy+onNSy0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh1cvljWNP9PYOoCdbCwwXFh5PTX6BdXQK8dC6eV2Z4=;
 b=YuXFOUnU7+hku8BkxIF9xvXaRa5auzH/DaQNSPyE/bvuFN+jPwar/aNeYzUwJuO2U1/5NAPp+j61xOc5twvyzuE6tq71x712QsG4+EJXH6EUYtIj24ulcxNV7i9lsMIW2LnrPCDllvLvn4jhf170ILWdsn3qGlojlwtTrIr43VY=
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 09:23:24 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::b7) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 09:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 09:23:24 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 04:23:17 -0500
Message-ID: <87f841bb-0182-23df-820b-9d250ab89463@amd.com>
Date:   Tue, 25 Oct 2022 11:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
Content-Language: en-US
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
 <06718d29-f3e1-db07-d537-b78290213b10@amd.com>
 <CY4PR1201MB0135792D5D8E7CBA417C2DBE8B319@CY4PR1201MB0135.namprd12.prod.outlook.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <CY4PR1201MB0135792D5D8E7CBA417C2DBE8B319@CY4PR1201MB0135.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8600e1-ebef-4392-1b4d-08dab66a9140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxFz45V0TpkBRQrkHNwiMx7f38A/rYV0hO72dRit9UJyweplXGh8T01PJIPL4ZzVGVSvjdkhCrFUe9cVqlYu4wdBqxy6i/F2+59kUbCjwPXJX8XtzkbE06vZlr4eMV8G8MeUE2NiMNb/TYfwkfAZp2Nrf4MA53oYRSQsWesBakj4Fw2op0UlEVgCgxYw5kYRGFjYW2YIRob4riKSyFvte+2gz45S9TE5h+/vHUJ56r8cZwdJIhkkjcqhubpja5HhGGR6GryAktANqi65NmAqdQwPca/B2f3QZPWx1fxDVUqPIfhIpMSh6L5v05U7V5pX675z4hdwEGsNs74bJl9k0qeni4cW3hGEq2wMGz3aQ5W6IisXhKFKp1XYyo8BcDPSR3/777BVkJ2hDq47hsX9Q7LGEHpTHA9XjbZ8p4LqJgznHNW8vJ0sw97ASBKZojb1alrxoovZRWCfHYLj9kM/FCcdXN9NsjsqkUbhJHTHjaN98X1kk2QEaHBJacsR3voY4JZ7XOPrhQBucPcc8HSB8uEERRA5BxuXR5rc8pB8zJqEe5lf386EDBlAwUwDY8H2yLs5U4xy59wHUjd9XDXeSQoulQ0gIEbIRHQDnAutzljebYYg3ULUrY36C6sMbytNfCbGQZTBmWvT8l9Vxxrs9p99Gi11N9b4rEDM5bz+CkMGNzDYYkyWgQSYyCjBhDbwIi8zSdkEMwREVeMUTeSZrrBrlzYJrQpp1zMZUN0QDHfTSWq10rb6FZOWmSz8tAcQ5y2963lVx694f59urvC9eN6ARZuxKUI2R2o8R8l4Y85a9OwEokya+70TChxaJ7m4yn00S6FxJzpoth2oUm1uCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(16526019)(31686004)(36860700001)(86362001)(82740400003)(356005)(31696002)(6666004)(336012)(5660300002)(53546011)(426003)(8936002)(81166007)(83380400001)(44832011)(2616005)(110136005)(54906003)(316002)(70206006)(82310400005)(478600001)(41300700001)(70586007)(40460700003)(16576012)(4326008)(8676002)(2906002)(47076005)(40480700001)(186003)(26005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 09:23:24.5251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8600e1-ebef-4392-1b4d-08dab66a9140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/25/22 10:26, Havalige, Thippeswamy wrote:
> Hi,
>> -----Original Message-----
>> From: Simek, Michal <michal.simek@amd.com>
>> Sent: Tuesday, October 25, 2022 1:02 PM
>> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; linux-
>> pci@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; krzysztof.kozlowski@linaro.org
>> Cc: bhelgaas@google.com; michals@xilinx.com; robh+dt@kernel.org;
>> lorenzo.pieralisi@arm.com; Gogada, Bharat Kumar
>> <bharat.kumar.gogada@amd.com>
>> Subject: Re: [PATCH 00/13] Remove unused microblaze PCIe bus architecture
>>
>> Hi,
>>
>> On 10/25/22 08:52, Thippeswamy Havalige wrote:
>>> The current Xilinx AXI PCIe Host Bridge driver uses generic PCIe
>>> subsystem framework. This driver works on both Microblaze and Zynq
>>> architecture based platforms.
>>>
>>> The microblaze architecture specific code has unused PCIe host bridge
>>> supported API's which are no longer needed.
>>>
>>> This series of patch removes unused architecture specific microblaze
>>> PCIe code.
>>>
>>> Thippeswamy Havalige (13):
>>>     microblaze/PCI: Remove unused early_read_config_byte() et al
>>>       declarations
>>>     microblaze/PCI: Remove Null PCI config access unused functions
>>>     microblaze/PCI: Remove unused PCI bus scan if configured as a host
>>>     microblaze/PCI: Remove unused PCI legacy IO's access on a bus
>>>     microblaze/PCI: Remove unused device tree parsing for a host bridge
>>>       resources
>>>     microblaze/PCI: Remove unused allocation & free of PCI host bridge
>>>       structure
>>>     microblaze/PCI: Remove unused PCI BIOS resource allocation
>>>     microblaze/PCI: Remove unused PCI Indirect ops
>>>     microblaze/PCI: Remove unused pci_address_to_pio() conversion of CPU
>>>       address to I/O port
>>>     microblaze/PCI: Remove unused sys_pciconfig_iobase() and et al
>>>       declaration
>>>     microblaze/PCI: Remove unused pci_iobar_pfn() and et al declarations
>>>     microblaze/PCI: Remove support for Xilinx PCI host bridge
>>>     microblaze/PCI: Moving PCI iounmap and dependent code
>>>
>>>    arch/microblaze/Kconfig                  |    8 -
>>>    arch/microblaze/include/asm/pci-bridge.h |   92 ---
>>>    arch/microblaze/include/asm/pci.h        |   29 -
>>>    arch/microblaze/pci/Makefile             |    3 +-
>>>    arch/microblaze/pci/indirect_pci.c       |  158 -----
>>>    arch/microblaze/pci/iomap.c              |   36 +
>>>    arch/microblaze/pci/pci-common.c         | 1067 ------------------------------
>>>    arch/microblaze/pci/xilinx_pci.c         |  170 -----
>>>    8 files changed, 37 insertions(+), 1526 deletions(-)
>>>    delete mode 100644 arch/microblaze/pci/indirect_pci.c
>>>    delete mode 100644 arch/microblaze/pci/pci-common.c
>>>    delete mode 100644 arch/microblaze/pci/xilinx_pci.c
>>>
>>
>> Why are you sending it again?
>>
>> M
> 
> 
> Last time mails were not delivered to opensource maintainers due to some access permissions.

But people in TO/CC got it. It means you should send it as RESEND or v2 to avoid 
confusion.

Thanks,
Michal

