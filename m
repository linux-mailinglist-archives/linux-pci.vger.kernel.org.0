Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA5678E3F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 03:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjAXCbI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 21:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 21:31:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCE89EC2;
        Mon, 23 Jan 2023 18:31:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Od2OU8dxen526hSind8YX5v7rH98jMckPW5lGcwfg2LOPZ4BAjsyWhBOp2nKpLVGOBqJbFckcIzhpyPFpy184sZPUTryeNnhrsY5Xvn+SFDCN0D3QIUq2IXWM+oQd8ET8+unFkqKU5GKL7B4r8o/s4pj2kqQj/RRRhcMU2f6rAsSYymcT310joVR5iyps+9+Nd/Mq28M7ucg8/MMZkRaTFOIjTwUnGCpSHnbKRGcqXHuFciVwUOMmcsn4PWIqAjQ4Wxah5lbOuHErp93eaC2xJgbZIDcOsjETkeaCGmXkQQfuZxR0DsX/jVjbAn2vkSsLRvMCAiQO4IlZa74LuVmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4DXg+HJbedJp21XbWJCZZdmZ66jfaC07Q20bWOt15Y=;
 b=kQYYEdMjmawRUAICxm/nMj4zOkTSpHI2Ys8wWeNLK2baIblA5ur0PF1/k34NEP0tr1l+2R11NO85HCR9H5VtIU+G51Og5w9v0YkYlHbN+RoW33hzqrFBjEepcZ+/uMrUt2Ipv/0JtxER7kTss2ScY4BIa1l1rDXcurPM5EQbSXPdQLpmTaQIIej9T6sXZIoXiZmJCMYkASWPD04zRF5vCkj1wJlWGf4iJWkLJZe99Fs5nI9gMHcBIDn3lJfaJArno3azDb5vef8x7XestsXzGLUwXXUFhEGJQMuEqyL/JySe4jwAZgirjNRNa5LoU9Brs4iw7fzfklUIprBYU1hkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4DXg+HJbedJp21XbWJCZZdmZ66jfaC07Q20bWOt15Y=;
 b=PdbApDGg0h4Va8LsyDKnNB59z+gKgvX589mu1l+WtWAh8TbohMi5t8IWa/5Qbx9EEkDGUOK33Q3R9Ue38O9CoAm1VOBv7vxDH7yT/C6Id3fjIk2IwMW9kUeXQ39N7X4pFYL9syF1gwMqWsGfKl08/oeNhfrMr35ZMQXJmp60htQ=
Received: from CY5PR22CA0074.namprd22.prod.outlook.com (2603:10b6:930:80::22)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 02:31:02 +0000
Received: from CY4PEPF0000C973.namprd02.prod.outlook.com
 (2603:10b6:930:80:cafe::83) by CY5PR22CA0074.outlook.office365.com
 (2603:10b6:930:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 02:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C973.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.14 via Frontend Transport; Tue, 24 Jan 2023 02:31:01 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 20:31:00 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 18:30:54 -0800
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 23 Jan 2023 20:30:53 -0600
Message-ID: <e59cb465-3f0d-4d11-8585-f0716cb09061@amd.com>
Date:   Mon, 23 Jan 2023 18:30:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
CC:     Lee Jones <lee@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Zhen, Max" <Max.Zhen@amd.com>,
        "Santan, Sonal" <sonal.santan@amd.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com> <Y86vm0zDOeb1G3zh@axis.com>
 <CAL_JsqLHi_1QJ4s28uM1b_Z2f+Nsu_CusAsqsx6vVOCCAPLMgw@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_JsqLHi_1QJ4s28uM1b_Z2f+Nsu_CusAsqsx6vVOCCAPLMgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C973:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac95a85-160a-433f-f8f9-08dafdb30926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQeClh5WAD3PtR5RLg2YSAhv85rs0kLw4a2/U1P4e2/CEB36hzOijAGVr4tAE4fHNjPKX5UzfVL83faXNTDArFdXcgQFhTTPWnk8kmS7QiQFKKUPdA8H0/w/qFnmHG37vROohzPM7BwfA7LUlNXJYtfO8mC/CBXgYSj4BGxduQt3IzuPbCiKSZkaswV/nLorQKrRQEHRY32A0TLjSnCHLjofbSpRPEDqVm3KUWQBfUSJNeSa72+UAhkVtFz0Wh9CkEjqNR17EskpaspCd8ZcWacuvxg5Ik6SWRU03FkAL9x8lYFCg31KcHMBlVzY705dM/HeScoZ+nXDZP4KNdFJLmztix9t/xtWgcMY5rxtk7A0BcsXhuMh7weH+3eO0FXqe8HMZ3kjhq7YJiOFq28ct40h6HJbToGE/1hXBNak0N+yhi3SyiG1xqu9/sq1VL1r//QQe7jh6fqHLt4PqxLP6eAnGRHC1RkCQdi13Lur5UPRu9qJeuwtxgvTcjSujXIPgsMZvh3qanRbAvX1GQxP7viMxLAmN5qN8a/ZqL4vV+OnzvZtb8kiDkVrLeeUErLpBUplEqGK2HHFN1qJLI3brEVJdgYE+GWIPipUhJ7LBXsB2iavJdH2PHqdmvO8eZzHUsV+Nw6TE/OEtoxduyDNwKexRa04tNequGz1uW9T8MdUHl9SuFH545uanADFVvljiZNuO1WurnAS6NM1CKEOXRFREd0A76drBEBy1xPWmn+bhWtAK+gMsNQlnWqq+vKkSNJ1O2z7C7YaMAserdEpPRtDLi7zwR0IGsq7zCya3dlPozddGCZyj476UDomwwO28KqrGgR6HIigVNAiKM97Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(31686004)(36756003)(186003)(336012)(110136005)(966005)(26005)(53546011)(2616005)(478600001)(6666004)(82310400005)(31696002)(86362001)(356005)(44832011)(2906002)(83380400001)(426003)(47076005)(8936002)(8676002)(4326008)(16576012)(40460700003)(41300700001)(70206006)(316002)(70586007)(54906003)(5660300002)(81166007)(82740400003)(36860700001)(40480700001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 02:31:01.9775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac95a85-160a-433f-f8f9-08dafdb30926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C973.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/23/23 08:36, Rob Herring wrote:
> On Mon, Jan 23, 2023 at 10:02 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
>> On Mon, Jan 23, 2023 at 04:32:55PM +0100, Lee Jones wrote:
>>> On Mon, 23 Jan 2023, Vincent Whitchurch wrote:
>>>> Add a PCI driver which registers all child nodes specified in the
>>>> devicetree.  It will allow platform devices to be used on virtual
>>>> systems which already support PCI and devicetree, such as UML with
>>>> virt-pci.
>>>>
>>>> The driver has no id_table by default; user space needs to provide one
>>>> using the new_id mechanism in sysfs.
>>> This feels wrong for several reasons.
>>>
>>> Firstly, I think Greg (Cc:ed) will have something to say about this.
>>>
>>> Secondly, this driver does literally nothing.
>> Well, it does do what the commit message says.  If there's another way
>> of accomplishing that, I'm all ears.
>>
>>> Why can't you use of of the other, pre-existing "also register my
>>> children" compatibles?
>>>
>>> See: drivers/bus/simple-pm-bus.c
>>>       drivers/of/platform.c
>> simple-pm-bus registers a platform driver, and drivers/of/platform.c
>> works on the platform bus.  The driver added by this patch is a PCI
>> driver.  So I don't understand how the files you mention could be used
>> here?
>>
>> In case it helps, the relevant nodes in my UML devicetree look something
>> like this:
>>
>>      virtio@2 {
> dtc should complain about this...
>
>>          compatible = "virtio,uml";
> Binding?
>
>>          virtio-device-id = <1234>;
>>          ranges;
>>
>>          pci {
>>                  #address-cells = <3>;
>>                  #size-cells = <2>;
>>                  ranges = <0x0000000 0 0 0 0xf0000000 0 0x20000>;
>>                  compatible = "virtio,device4d2", "pci";
> "pci" is not a valid compatible string.
>
>>                  device_type = "pci";
>>                  bus-range = <0 0>;
>>
>>                  platform_parent: device@0,0 {
>>                          compatible = "pci494f,dc8";
>>                          reg = <0x00000 0 0 0x0 0x10000>;
>>                          ranges;
>>
>>                          uart@10000 {
>>                                  compatible = "google,goldfish-tty";
>>                                  reg = <0x00000 0 0x10000 0 0x10000>;
> This is not a PCI device, so it shouldn't be using PCI addressing.
> 'ranges' needs an entry (for each BAR) to translate to just a normal
> MMIO bus with 1 or 2 address/size cells. Maybe we want a 'simple-bus'
> node for each BAR. The FPGA series needs the same things, but that
> aspect hasn't really been addressed as the first issue is populating
> the PCI devices dynamically.
>
> The DT address translation code should support all this
> (MMIO->PCI->MMIO), but I don't think there's any existing examples. An
> example (that I can test) would be great. If the unittest had that
> example, I'd be thrilled.
(I tried to reply with my comment this morning, but it did not post to
kernel mail alias. I am re-sending it. Please ignore if you already
received my reply)

I have proposed the address format for hardware apertures on PCI BAR.
The address consists of BAR index and offset. It uses the following
encoding:

     0xIooooooo 0xoooooooo

   Where:

     I = BAR index
     oooooo oooooooo = BAR offset

   The endpoint is compatible with 'simple-bus' and contains 'ranges'
   property for translating aperture address to CPU address.

Ref: 
https://lore.kernel.org/lkml/20220305052304.726050-3-lizhi.hou@xilinx.com/
The 64-bit address can use the default translator defined of/address.c

I implemented an example of top of my latest patch
https://lore.kernel.org/lkml/1674183732-5157-1-git-send-email-lizhi.hou@amd.com/
to verify the address translation. The test device tree nodes are defined
to present two hardware apertures on our alveo PCI device:

   pr-isolation:  PCI BAR 0, offset 0x41000, len 0x1000
   xdma: PCI BAR 2, offset 0x0, len 0x40000

     / {
         fragment@0 {
             target-path="";
             __overlay__ {
                 pci-ep-bus@0 {
                     compatible = "simple-bus";
                     #address-cells = <2>;
                     #size-cells = <2>;
                     ranges = <0x0 0x0 0x0 0x0 0x0 0x2000000>;
                     pr_isolate_ulp@41000 {
                         compatible = "xlnx,alveo-pr-isolation";
                         reg = <0x0 0x41000 0x0 0x1000>;
                     };
                 };
                 pci-ep-bus@2 {
                     compatible = "simple-bus";
                     #address-cells = <2>;
                     #size-cells = <2>;
                     ranges = <0x0 0x0 0x20000000 0x0 0x0 0x40000>;
                     alveo-xdma@0 {
                         compatible = "xlnx,alveo-xdma";
                         reg = <0x0 0x0 0x0 0x40000>;
                     };
                 };
             };
         };
     };

Overall, the test is as below

1) added code to generate 'ranges' for PCI endpoint dt node

    00000000 00000000 C30B0000 00000080 10000000 00000000 02000000 (BAR 0)

    20000000 00000000 C30B0000 00000080 14000000 00000000 00040000 (BAR 2)

    ^ bar index                ^^^^^^^^^^^^^BAR IOMEM address

    code link: 
https://github.com/houlz0507/linux-xoclv2/compare/29031e597fd6272f825dd04ba41a38defb77a99a...pci-dt-v6?diff=unified#diff-bf1b86155c18e04c439b74f5a02bad99c91a8c04f3c21243afce996c2174be56

2) overlay the test device tree fragment under PCI endpoint.

3) Alveo pci device driver probe function calls 
of_platform_default_populate().

I can see the BAR index+offset is translated to IO address correctly.

# ls /sys/bus/platform/devices/
0.flash
3f000000.pcie
3f000000.pcie:pci@2,0:pci@0,0:pci@0,0:dev@0,0:pci-ep-bus@0
3f000000.pcie:pci@2,0:pci@0,0:pci@0,0:dev@0,0:pci-ep-bus@2
8010041000.pr_isolate_ulp
8014000000.alveo-xdma

# lspci -vd 10ee:5020 | grep Memory
     Memory at 8010000000 (64-bit, prefetchable) [disabled] [size=32M]
     Memory at 8014000000 (64-bit, prefetchable) [disabled] [size=256K]

This test needs our Alveo PCI device. It might be a reference to create 
unittest.

Thanks,
Lizhi

>
> Rob
