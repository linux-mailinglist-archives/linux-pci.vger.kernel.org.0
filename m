Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3F75FEE7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjGXSS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjGXSSw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 14:18:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDA10D9;
        Mon, 24 Jul 2023 11:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvOOFYqzZ1kj8oaLkC/ciyyVG5jKkgYkT0E9gEz6MAOWqjSlp1rYwGXlwLAzA4NZSYa6gLa/3ZiZ9dSxJCCuDPMlpvcHP/WCV3yPtvdvI57haRbdqc15f9Vnj2Cfxvft7hjUh04yRFRWOmQB3e3Vq+ppJGI6x3qbI9LCXeV+KzNGAWSFIY8pKUdfKZEtQ1mzZ9MWi4zihz4FiOHGpD4jJmSRwhHyXmXqzfhwJPzBCQWgyTtrK1uusnp5NtDl6hQlfVV1c5IAG+pmBQqadVzSJaWNe0z9CTo1Qq6Eo6veDWsUWhI/m52AQHapc6LUcl5rjhq+UZEh1p/nJVb1OBMDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOI6Si0TL/iCTmjZKhFOL9x33W1wbvdG8s30iVTGwDE=;
 b=Tg3Nmn7THd4ui9JF7apoJPJf+YJj1tb9vUHD0OmNPFfXjFoloL0GXKRJ5aoyO9b3+mHZTMq1++cUDmkSyo5ztzxKd0U6g3JLQxNxE++7WdYjXYrbNkm4xCDYFBoYiyqi8AmFKmL2Kyu1OJpiItnXIE+DlyJ/18Jr2BNkWqxNuwDNxtXeJR7RsMZIghcjYrPpphguFDaEEYzDMwEycvtleTWoStkiH/CkB2eEkXWlye1O8If9WJecC5ug0fJssUM/K89RobY9dDUrooHLa1WJwfvVkWh1cQ5AgTzMgaV4zb0U+VH/PdMm8pXaLKRWAYO48dzKSlNyQ16Fv7zsXZAzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOI6Si0TL/iCTmjZKhFOL9x33W1wbvdG8s30iVTGwDE=;
 b=gMM4m0RXc6glJLg1JUchUoqBaCtV7TJbCqftp9dw6x0JsdWVp2nbv+LFgRlPaWKsp7fufyYK/GDQruvutqDIFI0dyu9Tm00ruGqjWs+e3ol+y3+JVEbPR/ZcDTHLqZlNQjo+SiPdYrdw7TZEtXpZIgOEN6JTcSCqEPmV8Q1+USE=
Received: from BN7PR06CA0065.namprd06.prod.outlook.com (2603:10b6:408:34::42)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 18:18:43 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::c4) by BN7PR06CA0065.outlook.office365.com
 (2603:10b6:408:34::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 18:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 18:18:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 13:18:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 13:18:42 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 13:18:42 -0500
Message-ID: <6f85ea12-b0d3-520f-f114-001669aa0434@amd.com>
Date:   Mon, 24 Jul 2023 11:18:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V10 2/5] PCI: Create device tree node for bridge
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>
References: <1688059190-4225-3-git-send-email-lizhi.hou@amd.com>
 <20230629225631.GA446944@bhelgaas> <20230629235226.GA92592-robh@kernel.org>
 <9f39fc3d-ae40-e5b1-8d40-8c27fc4e1022@amd.com>
 <CAL_JsqLzGted2tYHM7uKZRYDHypz4P6KMXGDuYLgpYsJcUyU8Q@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_JsqLzGted2tYHM7uKZRYDHypz4P6KMXGDuYLgpYsJcUyU8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: ba54086b-f533-45b6-20d0-08db8c7269f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Q20ZlcM7o6xS3+hvsQmBa05MYepVnVj2kcUj8pBlDdzROyDi+REushs3+rU1C18xhqwHLuawL5npzXeJaSnnAYtuORADiZaiw86D/nZBzY1Ux9tBGBRj7jYGiQIddBCuHcn7BfKk3pZuzk0yQzyFKlDWIWLs0XcESaInjrAVmigUGxLbglPFjqauqCO1eqDPIcXPzBmP/UzXJhDhDl1V0r9K26YWEK1DpPwrbEowgeuAZ8UpUfMiiJpGekqFqivbP5Msb8Of1boo37ympumyWKcxkvHeBGR1u1CFHD0CF977hgRZL8xr6aAZH9C1WM3Hd5ROes8omfyJsoOSlHNOGCE0+0mwRrYq4GhR6inwFm28wmB3AlhcICP7cZFoQwOph3ZwTONuNpGeyIr9DPicDC+gihx15bNg3EfsrCvy+wLGuyDfftuYgrG4s9aeE7I1kS+ZucYf8k2Yepw+2PdZ6B/XV5HSJViiHuDzcwXZ3UcJSf0RV0g8yvbeJbdH6vgcp1EHEDX35G/W27VJazxCoSzxRcNjqGbUT+nOyc4diUMyvPg5u7t+r18eZl0cZfWGq/UkfhbhFGDbqGuaQc2jujXiqi6ao3+xpF2+C1n+4fy2JtFBIddlo13hkNq9HGSTjwRisLc75zIGxolFmPcE2fQLwEhnHLefiDHjOAUv7zztMrBj/lLddO9OA5WE8Vptiohze48WDCSpQyrfS82Qh7SX/Dwn4/4asSXMEBgab8W07wcPL7WAze8TtNwfoHJN9SeXUzawHHUKsi44AyuCZq9ik/ajGnM1Uij+Kkil50=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(2906002)(40480700001)(478600001)(8676002)(966005)(81166007)(426003)(356005)(47076005)(82740400003)(186003)(26005)(336012)(2616005)(36860700001)(53546011)(40460700003)(8936002)(31696002)(86362001)(5660300002)(36756003)(44832011)(6916009)(70586007)(70206006)(316002)(16576012)(54906003)(41300700001)(4326008)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:18:43.4486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba54086b-f533-45b6-20d0-08db8c7269f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/18/23 11:15, Rob Herring wrote:
> On Fri, Jun 30, 2023 at 12:25 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>>
>> On 6/29/23 16:52, Rob Herring wrote:
>>>>> +                   rp[i].child_addr[0] = j;
>>>>> +   ret = of_changeset_add_empty_prop(ocs, np, "dynamic");
>>>> It seems slightly confusing to use a "dynamic" property here when we
>>>> also have the OF_DYNAMIC dynamic flag above.  I think they have
>>>> different meanings, don't they?
>>> Hum, what's the property for? It's new in this version. Any DT property
>>> needs to be documented, but I don't see why we need it.
>> This is mentioned in my previous reply for V9
>>
>> https://lore.kernel.org/lkml/af9b6bb3-a98d-4fb6-b51e-b48bca61dada@amd.com/
>>
>> As we discussed before, "interrupt-map" was intended to be used here.
>>
>> And after thinking it more, it may not work for the cases where ppnode
>>
>> is not dynamically generated and it does not have "interrupt-map".
>>
>> For example the IBM ppc system, its device tree has nodes for pci bridge
>>
>> and it does not have "interrupt-map".
> How do you know? I ask because usually the only way I have visibility
> there is when I break something. In traditional OpenFirmware, which
> IBM PPC is, all PCI devices have a DT node because it's the firmware
> telling the OS "these are the devices I discovered and this is how I
> configured them".

I configured a ppc VM and added a bridge to the VM

qemu-system-ppc -L pc-bios -boot c -prom-env "boot-device=hd:,\yaboot" 
-prom-env "boot-args=conf=hd:,\yaboot.conf" -M mac99 -m 1024 -hda 
debian10.qcow2 -nographic -device pci-bridge,chassis_nr=1,id=pci.9

# ls /proc/device-tree/pci\@f2000000/pci1b36\,1\@f/
66mhz-capable        class-code      fast-back-to-back min-grant      
vendor-id
assigned-addresses  device-id      interrupts         name
bus-range        devsel-speed  linux,phandle      reg
cache-line-size     ethernet@1      max-latency revision-id

The bridge node does not have 'interrupt-map'. That is why I concerned 
for using 'interrupt-map'.


To further debugging on if it really breaks anything, I added a nic 
device under bridge. Even without my patch, it is failed anyway.

      [    0.086586] pci 0000:01:01.0: of_irq_parse_pci: failed with rc=-22

So I setup another power10 VM and see the 'interrupt-map' is created for 
pci bridge. And the nic device under bridge works fine.


Maybe using 'interrupt-map' will not break anything in the real world.  
I will re-create a patchset which uses 'interrupt-map' (like V9) and 
checks it only when CONFIG_PCI_DYNAMIC_OF_NODES is turned on.


Thanks,

Lizhi

>
>> Based on previous discussions, OF_DYNAMIC should not be used here.
> For the same reasons, I don't think the behavior should change based
> on being dynamic. Now maybe the behavior when it's an ACPI system with
> DT overlays has to change, but that's a problem for later. I don't yet
> know if we'd handle that here somehow or elsewhere so that this node
> looks like a normal DT system.
>
> This should all work the same whether we've generated the nodes or
> they were already present in the FDT when we booted.
>
>> So I think adding "dynamic" might be a way to identify the dynamically
>>
>> added node. Or we can introduce a new flag e.g OF_IRQ_SWIZZLING.
> I hope not. The flags tend to be hacks.
>
> Rob
