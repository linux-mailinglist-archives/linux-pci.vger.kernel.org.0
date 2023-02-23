Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1226A0022
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 01:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjBWAhr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 19:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBWAhq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 19:37:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F842BD1;
        Wed, 22 Feb 2023 16:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWwjSSvqDZ9uS+2umiJV48AIhB1jgHg03pqyJHxB+lXDDHuG6ZQXJVHcxD2oE9KGKNrViyKwW6od2EJEBZkGLhIVmOcU+N7j4mhznrm/FXq1TSxjBpwLVmhX4aoQEIbQEn69TgpGcPGz6qDPH3UDV3UVCOC/Yka8JPrbjEPsyIcS/sfdMolkxQ3TP3dbMTCOJuzuAHy2xf0stfY9oqb4LPIhdjeyHbRWxwcKwmzIqldWsXLrxioOkBz6cjOfj6S22v6dpXVpuigUkZ4BatQXCSZWzoMD2dtaUQ2GSyPA9uUN4kb5x7sgExPj3CY9QObj1H/+4hLoVfn9npk285C3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq+2JU2MS1HNnJZ5goPpANMInC/IFVr2HjpSinI65Ic=;
 b=daQMqlLi+Q5ROR5Edn4QHRlhb9vLvvid/zJ7fsqYY7cadTUfuknjrUPafwIOgXTc1+L9n7ZPVoW7vkZHo5neo+whmWpLJfMtAA8uExTadxvDxnMmWqOSDy8caQK1kxrh8eeoTGxpcqEZJzna4VsGyLuRmeceHQJOqFm6WoYdOO3bPyywrKnP3Qc+T2gKCwU4DKJfht6FvzeB8Ag8H6uOFWSdEHapsGv0B54anszyOpJE+yoS2mj9l08rWjyYBqfbvb3+edAS1Slb50HLhut0sW2wUuphiCAGgcRzq3Eu7G7a0Z/ux+3Vfzi+nVSKrBqStlfeclYLJGbdxxD7B19l/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq+2JU2MS1HNnJZ5goPpANMInC/IFVr2HjpSinI65Ic=;
 b=c4c2oqkgBwVI3vbij3UFXgl67c//e3ZliMpctIY7EYAAHOZc+yI8NuTVwGceLi5uJ61WCClJRzXuZAJN5GmeeReKSpWum7KFpJBDj//BoQp8tePR56iHXRsTZb4HO561eYhyWariB9yfymuj/3uoUYXNfMGthmXUCN4m6nxWf/c=
Received: from BN9PR03CA0173.namprd03.prod.outlook.com (2603:10b6:408:f4::28)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 00:37:41 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b0) by BN9PR03CA0173.outlook.office365.com
 (2603:10b6:408:f4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Thu, 23 Feb 2023 00:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 00:37:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 18:37:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 18:37:40 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Feb 2023 18:37:39 -0600
Message-ID: <82e7bddf-6de4-0ca5-4a65-c60aa1fae7fc@amd.com>
Date:   Wed, 22 Feb 2023 16:37:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     Frank Rowand <frowand.list@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <helgaas@kernel.org>
CC:     <clement.leger@bootlin.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <0b44ec45-a5d8-87ff-34e9-cfed58eb060c@gmail.com>
 <140e5073-f0d9-f561-dee0-08ad28169085@gmail.com>
 <3b74b383-68d0-0a9f-55d3-9fd389b4497e@gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <3b74b383-68d0-0a9f-55d3-9fd389b4497e@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: b720a0f8-1b96-40a2-dd48-08db15362c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ//bEJlDl2JT7N+jEsuTdiz0ESPSw1NDnyu1bO34CDYCjnff1oDfcxbIYm28SRYNJ90SW1W9m9DYW/8BNhu5unr48ocxgIqWIZiy3HN5FVh17uSIS2GXLJk3B3SJHFlB9t4vglFLJDdsjtVqJaKiCa4Cadho0DjI7uexR4jA4Y5UVBmR+xwUy8CzLlO103j5TBHf2Cya90L84snucKyvTpbTyoP6X6AomZv6q22tDZJCKo6ZsvBu7qeqcEza8WrK8gXjnexyPsdwc1fVbTaa5hzxmoVGmGGLNloqxscpxwpKSMJO15c7lL7dNZ8cb3lipC/3ujXLzsYe7id9VUCrB0NS4uXNG0Wo7PyAcJDVn5g5ewKzVOkWyH1Cafr2gfXUnD635d+toHJR0RvzOLMRYJnlT7p94JrI+KGAP7pwq0RULt4NrxazPq73mMzYi9tkxcAWr0p6+lPD33+MLYkmczVisRznNALOauSTctDPWXmklpga/OUKD+pQyA9MjMFqfrIAbyAF8Pf65XgCnVm9XWD/ylCaqPimgwq9mNoq0SfryITgYr2zvV62ecssL6VgK4j8AUD0ZRB7RSGSgREcAyN1fC8OIERUrUJB7kQ9lhmCCP5GkF7mdcDpU6NcXcq3bPOInLi9BPjL5esKrCARJ8qmxy18vSdspVrFKFG8TyKE6UeXnwWVaaR3Wf4IL+fTd7g58j14RtLo5F50SfDfN87qBIuULIr3HPt0aS6mLl7oIT3oBMbdynBNVeLi3IljQgBVD7MJxgpBSp4GlWNBjORLC6dbj9KeaY8l6SDcgk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(31696002)(82310400005)(86362001)(36756003)(40480700001)(356005)(336012)(316002)(16576012)(83380400001)(426003)(66574015)(47076005)(478600001)(54906003)(110136005)(31686004)(26005)(186003)(2616005)(966005)(53546011)(44832011)(30864003)(2906002)(36860700001)(81166007)(82740400003)(8676002)(8936002)(70586007)(4326008)(41300700001)(5660300002)(70206006)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 00:37:41.4373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b720a0f8-1b96-40a2-dd48-08db15362c11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

On 2/22/23 07:26, Frank Rowand wrote:
> Hi Lizhi,
>
> On 1/23/23 17:40, Frank Rowand wrote:
>> On 1/22/23 22:32, Frank Rowand wrote:
>>> Hi Rob, Lizhi,
>>>
>>> On 1/19/23 21:02, Lizhi Hou wrote:
>>>> This patch series introduces OF overlay support for PCI devices which
>>>> primarily addresses two use cases. First, it provides a data driven method
>>>> to describe hardware peripherals that are present in a PCI endpoint and
>>>> hence can be accessed by the PCI host. Second, it allows reuse of a OF
>>>> compatible driver -- often used in SoC platforms -- in a PCI host based
>>>> system.
>>> I had hoped to review this series by today, but have not yet due to working
>>> on some new unittest features.  I hope to get to this series Monday.
>> I have skimmed through the series, and dug more deeply into portions of
>> the patches, but have not yet fully examined the full series.
>>
>> I will be on vacation for a week or so, and will resume the detailed
>> reading of the series.
> I am back from vacation, and I have completed the other devicetree
> related tasks that were also at the top of my devicetree todo list.
>
> I will resume the detailed reading of the series as the item that is
> now at the top of my devicetree todo list.  But I consider any review
> comments coming out of this as trivial compared to the issue raised in
> the following paragraph:
>
>> One overall comment at this point, is that this series is somewhat
>> duplicating portions of the (incomplete and fragile) overlay functionality
>> but not fully.  One trivial example is no locking to prevent interference
>> between tree modification by overlay code that could be occurring
>> asynchronously at the same time this new code is modifying the tree.
> Since there was no reply to the above paragraph, I am guessing that what
> I wrote was not clear enough.  As far as I am concerned, this issue is
> critical.  This patch series creates a body of code that is _more fragile_
> and _more incomplete_ than the existing overlay code.  I have been very
> clear over many years that the overlay code is not usable in its current
> implementation.
>
> Further, the body of code in this patch series will interact with the
> overlay code in a manner that makes the overlay code even more fragile
> and not usable.
>
> -Frank

I did not fully understand the concern here. And I thought you will add 
more after your vacation. :)

This patch calls of_changeset_apply() to add new nodes to base tree. And 
inside of_changeset_apply(),

global lock of_mutex is used to protect the change.  And this function 
is also used by hotplug-cpu.c, i2c-demux-pinctrl.c, pnv_php.c.

Do you mean of_changeset_apply() is fragile and should not be used?


The scope of this patch is just create a device tree node for pci device 
and add the node to the base tree during pci enumeration.

Could you give me an example code for the race condition you are 
worrying about?


Thanks,

Lizhi


>
>> -Frank
>>
>>> -Frank
>>>
>>>> There are 2 series devices rely on this patch:
>>>>
>>>>    1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>>    2) Microchip LAN9662 Ethernet Controller
>>>>
>>>>       Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
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
>>>> This patch series is made up of three patches.
>>>>
>>>> The first patch is adding OF interface to create or destroy OF node
>>>> dynamically.
>>>>
>>>> The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.
>>>> When the option is turned on, the kernel will generate device tree nodes
>>>> for all PCI bridges unconditionally. The patch also shows how to use the
>>>> PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
>>>> tree node for a device. Specifically, the patch generates a device tree
>>>> node for Xilinx Alveo U50 PCIe accelerator device. The generated device
>>>> tree nodes do not have any property.
>>>>
>>>> The third patch adds basic properties ('reg', 'compatible' and
>>>> 'device_type') to the dynamically generated device tree nodes. More
>>>> properties can be added in the future.
>>>>
>>>> Here is the example of device tree nodes generated within the ARM64 QEMU.
>>>> # lspci -t
>>>> -[0000:00]-+-00.0
>>>>             +-01.0-[01]--
>>>>             +-01.1-[02]----00.0
>>>>             +-01.2-[03]----00.0
>>>>             +-01.3-[04]----00.0
>>>>             +-01.4-[05]----00.0
>>>>             +-01.5-[06]--
>>>>             +-01.6-[07]--
>>>>             +-01.7-[08]--
>>>>             +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
>>>>             |                                            \-00.1
>>>>             +-02.1-[0c]--
>>>>             \-03.0-[0d-0e]----00.0-[0e]----01.0
>>>>
>>>> # tree /sys/firmware/devicetree/base/pcie\@10000000
>>>> /sys/firmware/devicetree/base/pcie@10000000
>>>> |-- #address-cells
>>>> |-- #interrupt-cells
>>>> |-- #size-cells
>>>> |-- bus-range
>>>> |-- compatible
>>>> |-- device_type
>>>> |-- dma-coherent
>>>> |-- interrupt-map
>>>> |-- interrupt-map-mask
>>>> |-- linux,pci-domain
>>>> |-- msi-parent
>>>> |-- name
>>>> |-- pci@1,0
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@1,1
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@1,2
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@1,3
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@1,4
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@1,5
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@1,6
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@1,7
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@2,0
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- pci@0,0
>>>> |   |   |-- #address-cells
>>>> |   |   |-- #size-cells
>>>> |   |   |-- compatible
>>>> |   |   |-- device_type
>>>> |   |   |-- pci@0,0
>>>> |   |   |   |-- #address-cells
>>>> |   |   |   |-- #size-cells
>>>> |   |   |   |-- compatible
>>>> |   |   |   |-- dev@0,0
>>>> |   |   |   |   |-- compatible
>>>> |   |   |   |   `-- reg
>>>> |   |   |   |-- dev@0,1
>>>> |   |   |   |   |-- compatible
>>>> |   |   |   |   `-- reg
>>>> |   |   |   |-- device_type
>>>> |   |   |   |-- ranges
>>>> |   |   |   `-- reg
>>>> |   |   |-- ranges
>>>> |   |   `-- reg
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@2,1
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- pci@3,0
>>>> |   |-- #address-cells
>>>> |   |-- #size-cells
>>>> |   |-- compatible
>>>> |   |-- device_type
>>>> |   |-- pci@0,0
>>>> |   |   |-- #address-cells
>>>> |   |   |-- #size-cells
>>>> |   |   |-- compatible
>>>> |   |   |-- device_type
>>>> |   |   |-- ranges
>>>> |   |   `-- reg
>>>> |   |-- ranges
>>>> |   `-- reg
>>>> |-- ranges
>>>> `-- reg
>>>>
>>>> Changes since v6:
>>>> - Removed single line wrapper functions
>>>> - Added Signed-off-by Clément Léger <clement.leger@bootlin.com>
>>>>
>>>> Changes since v5:
>>>> - Fixed code review comments
>>>> - Fixed incorrect 'ranges' and 'reg' properties and verified address
>>>>    translation.
>>>>
>>>> Changes since RFC v4:
>>>> - Fixed code review comments
>>>>
>>>> Changes since RFC v3:
>>>> - Split the Xilinx Alveo U50 PCI quirk to a separate patch
>>>> - Minor changes in commit description and code comment
>>>>
>>>> Changes since RFC v2:
>>>> - Merged patch 3 with patch 2
>>>> - Added OF interfaces of_changeset_add_prop_* and use them to create
>>>>    properties.
>>>> - Added '#address-cells', '#size-cells' and 'ranges' properties.
>>>>
>>>> Changes since RFC v1:
>>>> - Added one patch to create basic properties.
>>>> - To move DT related code out of PCI subsystem, replaced of_node_alloc()
>>>>    with of_create_node()/of_destroy_node()
>>>>
>>>> Lizhi Hou (3):
>>>>    of: dynamic: Add interfaces for creating device node dynamically
>>>>    PCI: Create device tree node for selected devices
>>>>    PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
>>>>
>>>>   drivers/of/dynamic.c        | 197 +++++++++++++++++++++++++++++++++
>>>>   drivers/pci/Kconfig         |  12 ++
>>>>   drivers/pci/Makefile        |   1 +
>>>>   drivers/pci/bus.c           |   2 +
>>>>   drivers/pci/msi/irqdomain.c |   6 +-
>>>>   drivers/pci/of.c            |  71 ++++++++++++
>>>>   drivers/pci/of_property.c   | 212 ++++++++++++++++++++++++++++++++++++
>>>>   drivers/pci/pci-driver.c    |   3 +-
>>>>   drivers/pci/pci.h           |  19 ++++
>>>>   drivers/pci/quirks.c        |  11 ++
>>>>   drivers/pci/remove.c        |   1 +
>>>>   include/linux/of.h          |  24 ++++
>>>>   12 files changed, 556 insertions(+), 3 deletions(-)
>>>>   create mode 100644 drivers/pci/of_property.c
>>>>
