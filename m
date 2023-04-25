Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D976EE4CA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjDYPcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 11:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDYPcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 11:32:54 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8EBA5F5;
        Tue, 25 Apr 2023 08:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMn8gSa6BuDaQJEixmqeWnZrCynaM4VZteS9mOWvi0bDTWj4hqMqeIRbe1BGRfrJA+by2NOC5iPXMcazw90MldiDra75gwpm0Y/MlKzkDLPAHOWL0GBgZ7vE0P3vDVCB2NflIVRWiuq5U6Hsw6Iy2fkIKJtRBGQpA7Vl3DAeWZInVFO/VSwsW4zPBL2QorfVKFWNEVGwshHFKKh5aPcNBHaSfKUZyb15n9BIQm3LqSySdkvldQ6QVZs6rzNGSl5T4bx3yWPLY1OvTYlzogPcqcMvwDDj43jzIDU5X7a1R68YSiKW0bOOY5/jScR7wMcb87pdrz8KsqvDu15xNwFzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MuHLKsva91dfsls2Se9SCvXdOlA5zkxvIXf22zi40M=;
 b=EB2BZWf3ps8+W3592/S0bhCuV1Hy+JalgAl3MLpnJH7ixxkZrSalocs5A4pd72XehSmjEK8e2SztHGWo7JdTbZqxe+bpp/ARkxBp+Nutl4bGzOkCldeQSWwyEPPphB2PI+M/zjSDDovHQvqV9gd+jAwigj3qj4HXIOg5l+fCah7O1rPorfKS0WV9W7pzs2cHAIFJFWFV+0PrnlzQCv6ySjgZd2ZqVysg7aG06bksYm965cfWjN+woOmfU8WFapGr9CzcjJnK9T4NKFnhHEvREIoF16UcIbGOX5rm8KRYMfo9GAP2FpI0TTq1rg9REUuJxRw8gGTU5F9Wo86evrkyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MuHLKsva91dfsls2Se9SCvXdOlA5zkxvIXf22zi40M=;
 b=MzPWIgWHPebZFMj3NKRiedxyyrirLeg1BPOycz1Bu7nrym8yiV8xz268Tz9m+QuA1AYLlIW15mNr/QSrnMO2HlSurUGoP8ZHEAI7YQLlQmz1NtLP76wiSH52CDtiR1PYeLVaXMOvFDM7sL1HnDUE9Yqb7g9zwSAl/fID4k/oz/s=
Received: from BN9PR03CA0883.namprd03.prod.outlook.com (2603:10b6:408:13c::18)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 15:32:47 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::4a) by BN9PR03CA0883.outlook.office365.com
 (2603:10b6:408:13c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 15:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 15:32:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 10:32:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 08:32:46 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 25 Apr 2023 10:32:46 -0500
Message-ID: <22f8e42c-c766-cd04-c1a9-9f0e15d80f39@amd.com>
Date:   Tue, 25 Apr 2023 08:32:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V8 2/3] PCI: Create device tree node for selected devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frowand.list@gmail.com>,
        <helgaas@kernel.org>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <1681877994-16487-1-git-send-email-lizhi.hou@amd.com>
 <1681877994-16487-3-git-send-email-lizhi.hou@amd.com>
 <20230419231155.GA899497-robh@kernel.org>
 <20d251bc-c4ec-64cc-8e6b-10c24cae6c9b@amd.com>
 <CAL_Jsq+P-_w8q7ahKpRzw=A1kkWBWocrWnni8P4LmpxffS0pfA@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_Jsq+P-_w8q7ahKpRzw=A1kkWBWocrWnni8P4LmpxffS0pfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed21f8c-93d1-4afc-c190-08db45a252af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oz7vAvTwHc35moekie8ogqiwj64YC05jnZ7hG+b0YKTXPs/wu6t7Bv3NjLpLGIJGNvjNyKrZDIw1CZBiXfbFj42x8q6mTTp8djHhMQdsYJabNYCvp1KHPL9qM3Lu+JB+SsJ+8FFTQ7kx94d/f7Jj7Qu3efqfEk053jSJ5DJVEM9vLkwvv9+VjIqyRJGNt4SSN93/AuFiGekcArAm7gb17oNtTJHZGTDljBXGTtWjAREuByVKChfdkd6aSG4Ae4MPD29KyzhET/zaI+72LRPF1g/rBksgLN3goZbP8I6mweVW4dDLmxC4eJcDMMOifdHW0S+FcqQ7J2fGAFdVTBosk0kSPeEQC/SYTpgezK6U469sWhRrCDIi64Hc5zsenzmvGTIlAsSTxCh/Ckft7SPs24kabl5eVt55j1woh1ivoeGM40y2diIJjwOqCbc3s9CqgH4xW8/KQ0lJuFp35BXMEjrKtFYGs2jc2YnxNSEuHh7oCYVcf+TZD6vsDFWk+EczVpvy4UMpHuuZ8xDbjWPfMdXly1Nv4vv41O06DPO/tjTYT3G4137jzc3H/US3FIqJHDXAz5CmreUw6HsMKcB3Xsh4QCdb4Q1xPGR3xrDmuRtn3GIXcnGz4SrGvH74lVraTAierXzNXeaJkdLHcA5lMPd7RH1qFgK8o9IbdWyAZy3hec8TIDYsHhsub3AzX5z5/9PqM/51qqMHV5D+IVurZkZY/8zlgipeCEossJWXycJ8CZwJyRr//NwiIkAbYdAy4zNALydj4vTQx+woPsrf/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(2616005)(186003)(40480700001)(53546011)(70206006)(70586007)(8936002)(8676002)(41300700001)(6916009)(4326008)(316002)(26005)(478600001)(44832011)(5660300002)(54906003)(82740400003)(356005)(81166007)(82310400005)(36756003)(86362001)(40460700003)(31696002)(36860700001)(47076005)(336012)(426003)(83380400001)(31686004)(16576012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:32:47.6700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed21f8c-93d1-4afc-c190-08db45a252af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/25/23 08:02, Rob Herring wrote:
> On Thu, Apr 20, 2023 at 11:05 AM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> On 4/19/23 16:11, Rob Herring wrote:
>>> On Tue, Apr 18, 2023 at 09:19:53PM -0700, Lizhi Hou wrote:
>>>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>>>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>>>> the PCI core discovers devices and BARs using the PCI enumeration process.
>>>> There is no infrastructure to discover the hardware peripherals that are
>>>> present in a PCI device, and which can be accessed through the PCI BARs.
> [...]
>
>>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>>> index 196834ed44fe..42a5cfac2d34 100644
>>>> --- a/drivers/pci/of.c
>>>> +++ b/drivers/pci/of.c
>>>> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>>>               } else {
>>>>                       /* We found a P2P bridge, check if it has a node */
>>>>                       ppnode = pci_device_to_OF_node(ppdev);
>>>> +                    if (ppnode && of_node_check_flag(ppnode, OF_DYNAMIC))
>>>> +                            ppnode = NULL;
>>> Again, different behavior if dynamic. I'm not seeing why you need this
>>> change.
>> This change is required. For dynamic generated node, we do not generate
>> interrupt routing related properties. Thus we need to fallback to use
>> pci_swizzle_interrupt_pin(). Generating interrupt routing related
>> properties might be difficult. I think we can differ it to the future
>> patches. Or just use pci_swizzle_interrupt_pin() which is much simpler.
> I don't think we need to generate anything else in the DT. I think we
> need to break from the loop if (ppnode && of_property_present(ppnode,
> "interrupt-map")) instead.
Sure. I will use 'interrupt-map' instead.
>
>
>>>> +static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
>>>> +                       struct device_node *np)
>>>> +{
>>>> +    struct of_pci_addr_pair *reg;
>>>> +    int i = 1, resno, ret = 0;
>>>> +    u32 flags, base_addr;
>>>> +    resource_size_t sz;
>>>> +
>>>> +    reg = kcalloc(PCI_STD_NUM_BARS + 1, sizeof(*reg), GFP_KERNEL);
>>>> +    if (!reg)
>>>> +            return -ENOMEM;
>>>> +
>>>> +    /* configuration space */
>>>> +    of_pci_set_address(pdev, reg[0].phys_addr, 0, 0, 0, true);
>>>> +
>>>> +    base_addr = PCI_BASE_ADDRESS_0;
>>>> +    for (resno = PCI_STD_RESOURCES; resno <= PCI_STD_RESOURCE_END;
>>>> +         resno++, base_addr += 4) {
>>>> +            sz = pci_resource_len(pdev, resno);
>>>> +            if (!sz)
>>>> +                    continue;
>>>> +
>>>> +            ret = of_pci_get_addr_flags(&pdev->resource[resno], &flags);
>>>> +            if (ret)
>>>> +                    continue;
>>>> +
>>>> +            of_pci_set_address(pdev, reg[i].phys_addr, 0, base_addr, flags,
>>>> +                               true);
>>>> +            reg[i].size[0] = FIELD_GET(OF_PCI_SIZE_HI, (u64)sz);
>>>> +            reg[i].size[1] = FIELD_GET(OF_PCI_SIZE_LO, (u64)sz);
>>>> +            i++;
>>>> +    }
>>>> +
>>>> +    ret = of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)reg,
>>> I believe this should be 'assigned-addresses' rather than 'reg'. But the
>>> config space entry above does go in 'reg'.
>> Do you mean I need to add 'assigned-addresses' in this patch?
> Yes, but on further thought, I think they can just be omitted. They
> are only needed
> if we need of_pci_address_to_resource() to work.
Got it.
>
>> For 'reg', it needs to have pairs for memory space or I/O space. Here is
>> what I saw in IEEE1275:
>>
>> "In the first such pair, the phys-addr component shall be the
>> Configuration Space address of the
>> beginning of the function's set of configuration registers (i.e. the
>> rrrrrrrr field is zero) and the size component shall
>> be zero. Each additional (phys-addr, size) pair shall specify the
>> address of an addressable region of Memory Space or I/
>> O Space associated with the function. In these pairs, if the "n" bit of
>> phys.hi is 0, reflecting a relocatable address, then
>> phys.mid and phys.lo specify an address relative to the value of the
>> associated base register. In general this value will be
>> zero, specifying an address range corresponding directly to the
>> hardware's. If the "n" bit of phys.hi is 1, reflecting a nonrelocatable
>> address, then phys.mid and phys.hi specify an absolute PCI address."
> I think this is a case where true OpenFirmware and FDT differ
> slightly. In OF, the DT reflects everything the firmware discovered
> and configured. FDT is more just what's static and not discoverable.
> (Though generating nodes here is more OF like.) For example, we don't
> put the bus numbers in the DT as those are dynamic and assigned by the
> OS. The purpose of the BAR registers in reg is to define the BAR size
> (and address only if fixed). We don't need that unless what's
> discoverable is wrong and we want to override it.
Thanks for the comments. I will remove the memory and I/O pairs.
>
>
>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>> index 57ddcc59af30..9120ca63a82a 100644
>>>> --- a/drivers/pci/pci-driver.c
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -1634,7 +1634,8 @@ static int pci_dma_configure(struct device *dev)
>>>>       bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>>>>
>>>>       if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
>>>> -        bridge->parent->of_node) {
>>>> +        bridge->parent->of_node &&
>>>> +        !of_node_check_flag(bridge->parent->of_node, OF_DYNAMIC)) {
>>> Again, I don't think changing behavior for dynamic case is right. I
>>> haven't dug into what an ACPI+DT case would look like here. (Hint:
>>> someone that wants this merged can dig into that)
>> I think this is required. Without dynamic node, on pure DT system,
>> has_acpi_companion() will return false. Then "ret" is 0 and the
>> following iommu_device_use_default_domain() might be called.
>>
>> With dynamic node, of_dma_configure() might return error because dma
>> related properties are not generated. Thus, "ret" is none zero and the
>> following iommu_device_use_default_domain() will be skipped.
> Again, dynamic is the wrong thing to key off of. If we need
> properties, then they should be added. However, I think the host
> bridge should have what's needed. If the code needs to handle this
> case, then we need to figure out the right thing to do.

I see. I will remove this change. It is not needed for pure DT case.


Thanks,

Lizhi

>
> Rob
