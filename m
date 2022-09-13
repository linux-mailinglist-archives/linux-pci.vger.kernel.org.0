Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055275B7C6B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIMVC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIMVC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:02:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E496A489;
        Tue, 13 Sep 2022 14:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHPx/MEkhPF+o7BmbBTKPsSuibdEtQnri8urT2iLdkajsM+b61vDw1fbzGNiE6heY7bxXN1aUL/9pCR5BDOoYeywYRsYMSjcbI1y+54Yf0LCo06biSgWKW82et5EboLGXsAgP4+Y9o9kIPsBjzQZjfgZDbwlyziNKqbw6TAqpLomDmqUODGnFGE4j7loRFBdyE6rKteDyMsommRFmDzTSsno4aPCvkJxM2bdpMimn1FFlQ3wDglln0TLbrxC87ZiBeQ/81Du1gru43LZ8llNf0JGhLpUBcHZDKz2+vJZ1KdLOmhLvkBwIUgvxa3Utj5RXbCYcYPOH5aYdTnfnEhjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn0wPaLWv7aP0kwu+7nZSCnXl3v2Jy6S1Id09V0D8qc=;
 b=Xbk9+UFVleMbMzKjRdZTd+mOrNHps9AAR7EGgdxmI85gTxRY/s1qqXpgLZTNEpGVo/Wd8AxKUNLW95VwC1VYqcUI6aZlrL0YaVyhcRccxTgk8614UBVSnQ9K5s9oYYoQHEDDTOaWPdrOUGWKhtGnTrO0jKDcQGKsxuk9/FQbD+/ke8RdgXkC/kkd9i98GuIGcFP0tZlgQx7ubTNkSZMoYeH8Uwo/9vSsMQ8fBeY4cc0BFhWmgK0UIxKIfVh45v7YtiiVXJF6v3T5rfRMwBKOaCanRmVEexwXa9G99TzRd+ybW7hiu5UDs+rH7/0td1C85Ck35aWw9SKwBLETSQyhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn0wPaLWv7aP0kwu+7nZSCnXl3v2Jy6S1Id09V0D8qc=;
 b=NcREnzwX8o6lbLVg8vM+zUX8CfeKGUJoXHmXVMi+vBX/7bvm0UDgwqiIRoVeCJp4vjmv3K47rhq5gIy9175eqi+CWWkVaV5oZodL0QYXzQeGMI2Prmm+H1I7Cuc39Qdt/6R4ANU+64X0DAtsqjFrgh1vOCdBmfIOKnqy5urahMk=
Received: from MW3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:303:2b::21)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 21:02:52 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::b4) by MW3PR05CA0016.outlook.office365.com
 (2603:10b6:303:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.10 via Frontend
 Transport; Tue, 13 Sep 2022 21:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 13 Sep 2022 21:02:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 16:02:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 16:02:50 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 16:02:49 -0500
Message-ID: <8bee1ddd-0a84-62cd-9beb-3bbb09d83de1@amd.com>
Date:   Tue, 13 Sep 2022 14:02:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Content-Language: en-US
To:     Frank Rowand <frowand.list@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <helgaas@kernel.org>
CC:     <clement.leger@bootlin.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
 <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
 <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: d05dde53-1c15-4ff6-5d98-08da95cb529e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFjiXdKWK5kt2qIpvwMYSkZfdyU2oxYdXVHD8Xv6ZXm73TymrYzjcVk7gPIUma2YlliijhL57lS721KJgd6HHiyEIDKcHNQX6j1gq47HqPasmhBu9nXK9EGqU/QEtcDvpupcLFR9StZiQHaqTJeuyKrZXZ2ada9DsTxa7SB80lWArUtSF5TMqldDbtryYhvfqHs+3IUfs/hHAwBx1FzaTwIfMdPq6qKtERUTx+y1TNOB4WmH3I07u8cWah6j3U+5pvTyitpqD8AaaSywrJ4RUUpRLUmIfAYkvwSTGTAw/za5liU1vmtfHSHLmCa5d44m5PT1Ugj/uLsuVfbOMzsLitlN12ibcxylPB3zPuDet0vKSAmhzmELWSV2fdQUhsJKoW7ViQ+p7zteJDoY0KMggt2Z57KuDIocYx5GrRKzhqaMuQpXulfcCKJiBwFweJY3tnRCRbmizm9zYMoS/wcAfQsxdkf7lJOQ3bP+Ak0VBvKE6OFTs6CN5kWEPAgpqyoXfHq4uYdQ454x1ZeMpuyF2rylClkbO+0jh7EuC/8Xspbhcf8t6tXaTIT1zvm8c0ryCzAN1fkyz0sj62BwOsvxOJM5sn31TnGx9eSdOtybS4RgKQF6RWh2wJlX2AYyu6o9Nt7WE/1W/LvtSJBB7aPGqoQM3C8wknbJQS2FqTiS7WJF7XHZRfk8XB49X6YQ1jA0McHNqekAgxZV/CwfYo5OU3YMpm7j10nP2g61NTpIfp6kJWEKay+/+mdPQ7VV3ULqjyAzoLAhFKsTpr2LdSDQFY6kSkXXYGTP/BJUkcN19QL0KEuwf74OisGd5tez4cFx8QInIGeaDWlVxWQyfgpmSODy+rHO65tKfXpBy/gfKj+YFcUFhCQjpRfNxt0STYdvPTe5RW8GE7eVglLCtwzl/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(110136005)(40460700003)(4326008)(86362001)(81166007)(36860700001)(31696002)(966005)(66574015)(26005)(5660300002)(316002)(40480700001)(8676002)(70586007)(70206006)(47076005)(426003)(2906002)(31686004)(41300700001)(36756003)(186003)(54906003)(53546011)(356005)(2616005)(82740400003)(478600001)(44832011)(336012)(83380400001)(82310400005)(8936002)(16576012)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 21:02:52.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05dde53-1c15-4ff6-5d98-08da95cb529e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/13/22 10:41, Frank Rowand wrote:
> On 9/13/22 12:10, Lizhi Hou wrote:
>> On 9/13/22 00:00, Frank Rowand wrote:
>>> On 8/29/22 16:43, Lizhi Hou wrote:
>>>> This patch series introduces OF overlay support for PCI devices which
>>>> primarily addresses two use cases. First, it provides a data driven method
>>>> to describe hardware peripherals that are present in a PCI endpoint and
>>>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
>>>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
>>>> driver -- often used in SoC platforms -- in a PCI host based system. An
>>>> example device is Microchip LAN9662 Ethernet Controller.
>>>>
>>>> This patch series consolidates previous efforts to define such an
>>>> infrastructure:
>>>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>
>>>> Normally, the PCI core discovers PCI devices and their BARs using the
>>>> PCI enumeration process. However, the process does not provide a way to
>>>> discover the hardware peripherals that are present in a PCI device, and
>>>> which can be accessed through the PCI BARs. Also, the enumeration process
>>>> does not provide a way to associate MSI-X vectors of a PCI device with the
>>>> hardware peripherals that are present in the device. PCI device drivers
>>>> often use header files to describe the hardware peripherals and their
>>>> resources as there is no standard data driven way to do so. This patch
>>>> series proposes to use flattened device tree blob to describe the
>>>> peripherals in a data driven way. Based on previous discussion, using
>>>> device tree overlay is the best way to unflatten the blob and populate
>>>> platform devices. To use device tree overlay, there are three obvious
>>>> problems that need to be resolved.
>>>>
>>>> First, we need to create a base tree for non-DT system such as x86_64. A
>>>> patch series has been submitted for this:
>>>> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
>>>> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
>>>>
>>>> Second, a device tree node corresponding to the PCI endpoint is required
>>>> for overlaying the flattened device tree blob for that PCI endpoint.
>>>> Because PCI is a self-discoverable bus, a device tree node is usually not
>>>> created for PCI devices. This series adds support to generate a device
>>>> tree node for a PCI device which advertises itself using PCI quirks
>>>> infrastructure.
>>>>
>>>> Third, we need to generate device tree nodes for PCI bridges since a child
>>>> PCI endpoint may choose to have a device tree node created.
>>>>
>>>> This patch series is made up of two patches.
>>>>
>>>> The first patch is adding OF interface to allocate an OF node. It is copied
>>>> from:
>>>> https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/
>>>>
>>>> The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
>>>> is turned on, the kernel will generate device tree nodes for all PCI
>>>> bridges unconditionally. The patch also shows how to use the PCI quirks
>>>> infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
>>>> a device. Specifically, the patch generates a device tree node for Xilinx
>>>> Alveo U50 PCIe accelerator device. The generated device tree nodes do not
>>>> have any property. Future patches will add the necessary properties.
>>>>
>>>> Clément Léger (1):
>>>>     of: dynamic: add of_node_alloc()
>>>>
>>>> Lizhi Hou (1):
>>>>     pci: create device tree node for selected devices
>>>>
>>>>    drivers/of/dynamic.c        |  50 +++++++++++++----
>>>>    drivers/pci/Kconfig         |  11 ++++
>>>>    drivers/pci/bus.c           |   2 +
>>>>    drivers/pci/msi/irqdomain.c |   6 +-
>>>>    drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>>>>    drivers/pci/pci-driver.c    |   3 +-
>>>>    drivers/pci/pci.h           |  16 ++++++
>>>>    drivers/pci/quirks.c        |  11 ++++
>>>>    drivers/pci/remove.c        |   1 +
>>>>    include/linux/of.h          |   7 +++
>>>>    10 files changed, 200 insertions(+), 13 deletions(-)
>>>>
>>> The patch description leaves out the most important piece of information.
>>>
>>> The device located at the PCI endpoint is implemented via FPGA
>>>      - which is programmed after Linux boots (or somewhere late in the boot process)
>>>         - (A) and thus can not be described by static data available pre-boot because
>>>               it is dynamic (and the FPGA program will often change while the Linux
>>>               kernel is already booted
>>>         - (B) can be described by static data available pre-boot because the FPGA
>>>               program will always be the same for this device on this system
>>>
>>> I am not positive what part of what I wrote above is correct and would appreciate
>>> some confirmation of what is correct or incorrect.
>> There are 2 series devices rely on this patch:
>>
>>      1) Xilinx Alveo Accelerator cards (FPGA based device)
>>
>>      2) lan9662 PCIe card
>>
>>            please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> Thanks.  Please include this information in future versions of the patch series.
>
> For device 2 I have strongly recommended using pre-boot apply of the overlay to the base
> device tree.  I realize that this suggestion is only a partial solution if one wants to
> use hotplug to change system configuration (as opposed to using hotplug only to replace
> an existing device (eg a broken device) with another instance of the same device).  I
> also realize that this increased the system administration overhead.  On the other hand
> an overlay based solution is likely to be fragile and possibly flaky.
Can you clarify the pre-boot apply approach? How will it work for PCI 
devices?
>
>> For Xilinx Alveo device, it is (A). The FPGA partitions can be programmed dynamically after boot.
> I looked at the Xilinx Alveo web page, and there are a variety of types of Alveo cards
> available.  So the answer to my next question may vary by type of card.
>
> Is it expected that the fpga program on a given card will change frequently (eg multiple
> times per day), where the changed program results in a new device that would require a
> different hardware description in the device tree?

Different images may be loaded to a FPGA partition several times a day. 
The PCI topology (Device IDs, BARs, MSIx, etc) does not change. New IPs 
may appear (and old IPs may disappear) on the BARs when a new image is 
loaded. We would like to use flattened device tree to describe the IPs 
on the BARs.


Thanks,

Lizhi

>
> Or is the fpga program expected to change on an infrequent basis (eg monthly, quarterly,
> annually), in the same way as device firmware and operating systems are updated on a regular
> basis for bug fixes and new functionality?
>
>
>>
>> Thanks,
>>
>> Lzhi
>>
>>> -Frank
