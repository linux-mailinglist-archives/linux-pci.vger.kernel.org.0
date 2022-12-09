Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30FE648906
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 20:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLIThk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 14:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIThj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 14:37:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BC4103E;
        Fri,  9 Dec 2022 11:37:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geISiEvt0jYwf0Huuw3DfjjlH02fuGxRYZzl6rGDNue2kkY99xWLM1TAPJ8ml56PMnyyu2tO6okFz0BI1JYRvnltAvbbTqdei7XF8W6FgFy+IXbZEn0gavgsIP+v57gSxz7RXtzI+YI21Wm7iM4+HkBFKvRmpgqPGJ0jAW+6gcz/YtO62yYCp7C3z8QlMLTQbtt6DGkHzDufSCP9CtVSUvyubD9xaADB8ZehUlwgCixRUs3i4MCbIj8drmsR1clfC/a4rNlENGoxpPd1tcsU9qDaL6dZVb85DjxB0eBTVvIbsBECo/vQ9SG9Keebksd31jKatGOBWE+pyX9HCPDMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAXskH3z+TdEBvF3qswvYB2DKbPU9IFjxE1olWKmvw0=;
 b=ScuSujKHZVOy9sYMybPLdUMhxG/fFZgHP5E4HiRr4FtWacJ/iNAK2Si+dtYnw/GP6SAJWc5CzhQMvSfrcc6veD2nSIrSyqBtto7H1/jDlVcXVBeCDxSqA1bJQgj1RyDqLwyGVQGQbDsExDUhX1XasCVbs6eY6eiB9P4+nFO0EUFK+DwfGCaov0E/WGOKLAc9QdJweAbAZ3o32MPlPHiafUgbqewKTMjUtO4YwpEXftuOqO+Q7sm2qbRJ30g+3xxaHFsTOzoMPIJ0MQDQxw5PZvLtKcFWtSH7Vb0IVcXcfSN4TiqWkFJNAeiwwqxTobwhNPiA1SQGpJdecJj/+vklbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAXskH3z+TdEBvF3qswvYB2DKbPU9IFjxE1olWKmvw0=;
 b=yGvjj8+QAflbLglqLMJTEMJC/TmaEhXTSzHya4HfpLexTe8ZgOuX0XS6XBP8OId6ZZXkT9a2/z27EP7VVNTXx87CiQ4ZEAh7PM4ia7B+LWbeHNkLyBshyrCQtI2RuQK2se3VLaDGUSpaaYcCIDI1LpvxkwKlrnzx2lCiJKMjd5c=
Received: from BN7PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:20::39)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 19:37:34 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::8f) by BN7PR02CA0026.outlook.office365.com
 (2603:10b6:408:20::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 19:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 19:37:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 13:37:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 13:37:33 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 9 Dec 2022 13:37:32 -0600
Message-ID: <b7dd1f8c-f1b0-af65-bd6d-914b7e42d75d@amd.com>
Date:   Fri, 9 Dec 2022 11:37:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH RFC V4 2/3] PCI: Create device tree node for
 selected devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frowand.list@gmail.com>,
        <helgaas@kernel.org>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
 <1669048984-56394-3-git-send-email-lizhi.hou@amd.com>
 <20221201211224.GA1225112-robh@kernel.org>
 <5e8eabf7-edc8-28a9-afd7-1ccf207d5018@amd.com>
 <CAL_JsqJyi3XYdSmgOQ3Xk1cnMeRXUzSsd=-SgweKiLnEsJ-9YQ@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_JsqJyi3XYdSmgOQ3Xk1cnMeRXUzSsd=-SgweKiLnEsJ-9YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 1960531c-4925-44a2-1809-08dada1cd1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+Twx0TGj/LoTCI2orGjFlMpvdgRv7iwVwAhFN2819tVaUX/CFB7PrAPKDZyQ3hmsyg3Y/uG0X5lLCtHE+iKqNaLIh2sOEJ2hgVrGSteANFBU94GjbjoWcaJ6n9DpxQtihLdKV48M6/9VG3ZVhxRCbjbIEJvESGL2QmQC3Bk6uibALNPoxGJK7glRY/9p7bFEgxTTtfubHccS3yC8yuR5Kj2sce40KrHvhuYPUncj92hiWFILKN0crlhq4lAZwzcmT5624Wt1JMJHwAio77+YGZi81sDZHfyGCz5R6+w5bzKL1F6ec8OrOByn3Zj12aKo7Ckd2TLxez9qDyYDeO647WCP0xDK8FmYbTyGjfN9S9yuO/VjThbh29x6BjU9Y91uev6QXV9+DtBy6ZM8xT4iHPvwhCkP+eKlyR0ODdzdJHgMpyBaszI1pFDtmJ0niC/pWvvtubd25AyQWcW1TNohxJyH9rojPZt+tubHagugn1VtPet/u3PD/W1plUAjtfStTU7VGgNLc0l3B/iZoVmb9SQpG4r9XyCp3Vwr4yxX9rGaDkCigVjALdtyKq6iLJna4GNJFaodv6mrQqCah8HUrMT6jO5YaqLlCHmrCJl/fV9QQQMMFW6tKC3B14seSpOgChonEeUp+GGBXF40lgo6h/zn0gLAhfCX+YjsnpDDrPxCMy7Ce+AphJoUGlrbwbbz/uvVOGKn94b3cD2aNYr4SXkFY668KbxVR22hhYdQPQD+nHLur13mfPzhj+0p5xQIoJPJWxbwiiGwu42aq5bFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(66899015)(31686004)(70206006)(2906002)(86362001)(83380400001)(31696002)(336012)(2616005)(40480700001)(70586007)(44832011)(40460700003)(36756003)(5660300002)(8936002)(356005)(41300700001)(316002)(16576012)(81166007)(4326008)(8676002)(186003)(426003)(6916009)(47076005)(54906003)(82310400005)(53546011)(82740400003)(478600001)(26005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 19:37:34.0089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1960531c-4925-44a2-1809-08dada1cd1d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12/7/22 14:44, Rob Herring wrote:
> On Mon, Dec 5, 2022 at 6:30 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>>
>> On 12/1/22 13:12, Rob Herring wrote:
>>> On Mon, Nov 21, 2022 at 08:43:03AM -0800, Lizhi Hou wrote:
>>>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>>>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>>>> the PCI core discovers devices and BARs using the PCI enumeration process.
>>>> There is no infrastructure to discover the hardware peripherals that are
>>>> present in a PCI device, and which can be accessed through the PCI BARs.
>>>>
>>>> For Alveo PCI card, the card firmware provides a flattened device tree to
>>>> describe the hardware peripherals on its BARs. The Alveo card driver can
>>>> load this flattened device tree and leverage device tree framework to
>>>> generate platform devices for the hardware peripherals eventually.
>>>>
>>>> Apparently, the device tree framework requires a device tree node for the
>>>> PCI device. Thus, it can generate the device tree nodes for hardware
>>>> peripherals underneath. Because PCI is self discoverable bus, there might
>>>> not be a device tree node created for PCI devices. This patch is to add
>>>> support to generate device tree node for PCI devices.
>>>>
>>>> Added a kernel option. When the option is turned on, the kernel will
>>>> generate device tree nodes for PCI bridges unconditionally.
>>>>
>>>> Initially, the basic properties are added for the dynamically generated
>>>> device tree nodes.
>>>>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>> Reviewed-by: Brian Xu <brian.xu@amd.com>
>>>> ---
>>>>    drivers/pci/Kconfig         |  12 ++
>>>>    drivers/pci/Makefile        |   1 +
>>>>    drivers/pci/bus.c           |   2 +
>>>>    drivers/pci/msi/irqdomain.c |   6 +-
>>>>    drivers/pci/of.c            |  71 ++++++++++
>>>>    drivers/pci/of_property.c   | 256 ++++++++++++++++++++++++++++++++++++
>>>>    drivers/pci/pci-driver.c    |   3 +-
>>>>    drivers/pci/pci.h           |  19 +++
>>>>    drivers/pci/remove.c        |   1 +
>>>>    9 files changed, 368 insertions(+), 3 deletions(-)
>>>>    create mode 100644 drivers/pci/of_property.c
>>>>
>>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>>> index 55c028af4bd9..126c31b79718 100644
>>>> --- a/drivers/pci/Kconfig
>>>> +++ b/drivers/pci/Kconfig
>>>> @@ -198,6 +198,18 @@ config PCI_HYPERV
>>>>         The PCI device frontend driver allows the kernel to import arbitrary
>>>>         PCI devices from a PCI backend to support PCI driver domains.
>>>>
>>>> +config PCI_DYNAMIC_OF_NODES
>>>> +    bool "Device tree node for PCI devices"
>>> Create Devicetree nodes for PCI devices
>> Sure.
>>> But as I've said before, making this a config option doesn't really work
>>> except as something to experiment with. Once you add your driver and
>>> want to do a 'select PCI_DYNAMIC_OF_NODES', you've affected everyone
>>> else.
>> Do you mean we should remove PCI_DYNAMIC_OF_NODES and make
>> creating dynamic tree node default?
> No, I'm saying as long as it is a config option, it's not useful for
> more than experimentation. A distro kernel has to decide how to set a
> config option for *everyone*.
Ok. I will keep this option.
>
>> Based on the previous discussions, the approach I am implementing
>> is to create device tree nodes for all PCI bridges and devices defined
>> by pci quirks. I believe a PCI endpoint which is not defined by PCI quirks
>> should not to be affected because there is no device tree node is created
>> for it.
>>
>> Are you fine with this approach?
> How does that work? The quirks run when a device is discovered. At
> that time you've already discovered and probed everything upstream of
> the device. So the only thing controlling the upstream devices getting
> a DT node is the config option, right?

Yes, correct.

I meant that the endpoint devices which are not defined in quirks will

not have devicetree node generated. Thus, the behavior of those endpoint

device driver will not be affected.

>
>>>> +    depends on OF
>>>> +    select OF_DYNAMIC
>>>> +    help
>>>> +      This option enables support for generating device tree nodes for some
>>>> +      PCI devices. Thus, the driver of this kind can load and overlay
>>>> +      flattened device tree for its downstream devices.
>>>> +
>>>> +      Once this option is selected, the device tree nodes will be generated
>>>> +      for all PCI bridges.
>>>> +
>>>>    choice
>>>>       prompt "PCI Express hierarchy optimization setting"
>>>>       default PCIE_BUS_DEFAULT
>>>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>>>> index 2680e4c92f0a..cc8b4e01e29d 100644
>>>> --- a/drivers/pci/Makefile
>>>> +++ b/drivers/pci/Makefile
>>>> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)   += p2pdma.o
>>>>    obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>>>>    obj-$(CONFIG_VGA_ARB)              += vgaarb.o
>>>>    obj-$(CONFIG_PCI_DOE)              += doe.o
>>>> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>>>>
>>>>    # Endpoint library must be initialized before its users
>>>>    obj-$(CONFIG_PCI_ENDPOINT) += endpoint/
>>>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>>>> index 3cef835b375f..8507cc32b61d 100644
>>>> --- a/drivers/pci/bus.c
>>>> +++ b/drivers/pci/bus.c
>>>> @@ -316,6 +316,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>>>>        */
>>>>       pcibios_bus_add_device(dev);
>>>>       pci_fixup_device(pci_fixup_final, dev);
>>>> +    if (pci_is_bridge(dev))
>>>> +            of_pci_make_dev_node(dev);
>>>>       pci_create_sysfs_dev_files(dev);
>>>>       pci_proc_attach_device(dev);
>>>>       pci_bridge_d3_update(dev);
>>>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>>>> index e9cf318e6670..eeaf44169bfd 100644
>>>> --- a/drivers/pci/msi/irqdomain.c
>>>> +++ b/drivers/pci/msi/irqdomain.c
>>>> @@ -230,8 +230,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>>>>       pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>>>>
>>>>       of_node = irq_domain_get_of_node(domain);
>>>> -    rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
>>>> -                    iort_msi_map_id(&pdev->dev, rid);
>>>> +    if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
>>>> +            rid = of_msi_map_id(&pdev->dev, of_node, rid);
>>>> +    else
>>>> +            rid = iort_msi_map_id(&pdev->dev, rid);
>>> I have no idea if this works. It looks kind of broken already if
>>> !of_node calls iort_msi_map_id(). With a DT only system, I would think
>>> we'd always call of_msi_map_id(). Have you tested MSIs?
>>>
>>> With a mixed system, I have no idea what happens. That needs to be
>>> understood for MSI, DMA, and interrupts.
>> Yes, I tested MSI in VM.
>>
>> # cat
>> /sys/devices/platform/3f000000.pcie/pci0000:00/0000:00:02.0/0000:09:00.0/0000:0a:00.0/msi_irqs/29
>>
>> msi
>> # cat /proc/interrupts | grep 29
>>    29:          1          0       MSI 5242880 Edge      pciehp
>>
>> The idea is to preserve the current behaviror.
>>
>>         current: PCI device does not have dt node, thus iort_msi_map_id()
>> is called.
>>
>>         modified code: PCI device has dt node but with OF_DYNAMIC flag,
>> thus  iort_msi_map_id() is called.
>>
>> I was planning to take on of_msi_map_id() for dynamically generated dt node
>>
>> in future when we see a real use case?
>>
>>>>       return rid;
>>>>    }
>>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>>> index 196834ed44fe..fb60b04f0b93 100644
>>>> --- a/drivers/pci/of.c
>>>> +++ b/drivers/pci/of.c
>>>> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>>>               } else {
>>>>                       /* We found a P2P bridge, check if it has a node */
>>>>                       ppnode = pci_device_to_OF_node(ppdev);
>>>> +                    if (of_node_check_flag(ppnode, OF_DYNAMIC))
>>>> +                            ppnode = NULL;
>>>>               }
>>>>
>>>>               /*
>>>> @@ -599,6 +601,75 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>>>       return pci_parse_request_of_pci_ranges(dev, bridge);
>>>>    }
>>>>
>>>> +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
>>>> +
>>>> +void of_pci_remove_node(struct pci_dev *pdev)
>>>> +{
>>>> +    struct device_node *dt_node;
>>> node or np are the typical names.
>> Will fix this.
>>>> +
>>>> +    dt_node = pci_device_to_OF_node(pdev);
>>>> +    if (!dt_node || !of_node_check_flag(dt_node, OF_DYNAMIC))
>>>> +            return;
>>>> +    pdev->dev.of_node = NULL;
>>>> +
>>>> +    of_destroy_node(dt_node);
>>>> +}
>>>> +
>>>> +void of_pci_make_dev_node(struct pci_dev *pdev)
>>>> +{
>>>> +    struct device_node *parent, *dt_node = NULL;
>>>> +    const char *pci_type = "dev";
>>>> +    struct of_changeset *cset;
>>>> +    const char *full_name;
>>>> +    int ret;
>>>> +
>>>> +    /*
>>>> +     * If there is already a device tree node linked to this device,
>>>> +     * return immediately.
>>>> +     */
>>>> +    if (pci_device_to_OF_node(pdev))
>>>> +            return;
>>>> +
>>>> +    /* Check if there is device tree node for parent device */
>>>> +    if (!pdev->bus->self)
>>>> +            parent = pdev->bus->dev.of_node;
>>>> +    else
>>>> +            parent = pdev->bus->self->dev.of_node;
>>>> +    if (!parent)
>>>> +            return;
>>>> +
>>>> +    if (pci_is_bridge(pdev))
>>>> +            pci_type = "pci";
>>> What's the node name if not a bridge? I don't see how that would work.
>>>
>>> It should depend on the device class if it has one.
>> pci_type is initialized with "dev"
>>
>> +    const char *pci_type = "dev";
> I missed that...
>
>> Do you mean I should use class instead of pci_is_bridge()?
>>
>> if ((pdev->class >> 24) == PCI_BASE_CLASS_BRIDGE)
>>       pci_type = "pci";
> Well, maybe as preparation to support other classes. If you had a UART
> for example, the node name is 'serial'. I don't think you need to
> worry about those ATM. We may need some way for the name to come from
> the driver as not all devices have a class. Yours for example, we'd
> want something like 'fpga@...' ideally. Maybe that's fine to leave as
> a known issue.

Got it. I will keep generic endpoint name 'dev' for now.  Thanks.


Lizhi

>
> Rob
