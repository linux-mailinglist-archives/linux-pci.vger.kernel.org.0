Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7911A60C52E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiJYHbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 03:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJYHbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 03:31:48 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F3B54642;
        Tue, 25 Oct 2022 00:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+0ikAcG4o8VMIaNdwWPP5LYXV7fF3BZp3kcu7Isl7jpARYIcLTCLgS9jZlpYVif1r0wYjwHb7WbGZ7p3CHtZAZqJGpei62C/+9z/7TtISlnJHtM6nh9DjIEZ/pyfJq7L4Mtm/U+bA18cEiFcwaxYvQhjI74W9zsgE4GHltzfKvk8eZ62mhD2xxgp3BynT8N82k5oKrD/JAas/mrlGzKILm4wZEsIXwiFrw/gtdZ2/Cs7h2yrtvbPdRgHhz5/WtA1tBMEZQ9vpl5aXTPrW2p7yHcYVXhQpDWVBU9EBlZwJoicRlPqCMamd6C3f1QDaQMygSqO+ZDlfoGvXyUE/eGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pk6QvT2VpBGlyWp/XI7MdvWsF1Z1haizUXLgIgerHY=;
 b=ggZe8vX9g7VSu94raGqG3sRlCXt9Fi445OV0Joz0zxBI1HkaOnzYIWpflcYkOL7hU+Q/nYiWS0UyMG5GrTxZsrvifnLZ0zc0IaLPsvX6xwuZ9/7MherEvSj59eaDvWLZb3YfKW1ASqwF2JDlTqZ0ly7mnkGE/I26OPsBZOliqbu7gz3dI7K9GhkNegUO+mjbobCziOTFqsme78FkrEdCBXgnp8OFDYfQTpSppOw5eEoGa/XgwBubNw/Q5uLJbbc61b5IJRZXGJWM8fSOzYBVaUplyjn5hTCvDlWJC7Z7DjwqKVk9dYJW8cT4cCm0zmWk4s1ABblrcO624EMDIuLijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pk6QvT2VpBGlyWp/XI7MdvWsF1Z1haizUXLgIgerHY=;
 b=KER7NHnoCR7RewoaB+d9HMAxZmcJ/YPYp2IejjVcGC60aqNA31j9KKauCgeW/5EuMKJAXg8TjQnmdMDtZfsMbMqM7fqfASiAWJfCy/UmnTqVi0L+nckL0b3+MWuANxOzvCtXeBs5qrfRA35kzJ4t9pfA2pFjArz1G0z82SMYYAE=
Received: from DM6PR04CA0009.namprd04.prod.outlook.com (2603:10b6:5:334::14)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Tue, 25 Oct
 2022 07:31:44 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c2) by DM6PR04CA0009.outlook.office365.com
 (2603:10b6:5:334::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 07:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 07:31:43 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 02:31:40 -0500
Message-ID: <06718d29-f3e1-db07-d537-b78290213b10@amd.com>
Date:   Tue, 25 Oct 2022 09:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fab3ab7-51ef-46ed-63f7-08dab65af76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RI7sWuMXgZYpEW2wEg+PiWA96K1Q/nGtC7v2ctZRMuP0CZRoLdeIBKR71AsrEMtHirbfqZh/Ac+viFwDQZPMTW745x4FH4jKQ0nP6iPL05SAQ8OOhhDkwN79+5sf5FyGIcjgkgGL2f8IMCteQF5W1LBw/erkCWMk/IN8PlL28O++v0CUTnqPjS8Fz+ywSeRDpH7CqqVQnURsI2w2Q6EGLVZim0PMwdX4fZW+nqyrTR3ktZM0HyB/lO7s0Z2wbbNLEArt2ehxZ3ZgEzf4xz560ahNOegfPQP2Q4gnW1CO6l+206QKIs+KKGcX46KUYTnQ/Za+RGvQSec1YI0x5Nhpl/wwG74iwa/bASggcmrBCa35761A6+R7yAJ/kSo56dO2gyHVLXXTCOg/ClwMCN6yb8iSSJxAxxydiTm+pbcoMa/jh1c5hQICDT5ysY33QaTv7YUztu3UoNbHBUqfomMmEtq/V3t7pwG+U3/VrkKwQmAq3SMVSclopyooNJkb/PFTxASibfICOxM1KKqxKPeoi/k3vpCLm7iavTiLyI1NwhHBtn2hA+dS/uBHD8c8pYpP6RbHuiqdIY/4vIItuTxiETjnNCynMCBMads1LG9yBQR419i/fWfiqwCPYiF9J0QH7XSiB58n0SXbb1VEJ0AZUyoxrNLIt8BmQKyUtmerXPCVspsmr/wGt7lNbvkOB6CMhIvVymzgdAV++eSLCLLU20FGdbh7YvSqS7WMvopxg2hmu8HKryYyJp1bsSYStBEFL61oy8qYiIv2AmAnDIGnqfn4zCxkW9ObDHtCf+ITf4XU/H5BTR12M4m7dt7Hz4GxBGw0gGFihUKJSQB8aMWxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(47076005)(82310400005)(426003)(44832011)(316002)(16576012)(2616005)(110136005)(40460700003)(54906003)(36860700001)(41300700001)(8936002)(36756003)(26005)(336012)(16526019)(2906002)(40480700001)(6666004)(186003)(5660300002)(31696002)(4326008)(8676002)(70586007)(53546011)(86362001)(70206006)(81166007)(31686004)(82740400003)(478600001)(356005)(83380400001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:31:43.7765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fab3ab7-51ef-46ed-63f7-08dab65af76c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

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

Why are you sending it again?

M
