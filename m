Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F459762A45
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGZE1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 00:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGZE0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 00:26:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF235BD;
        Tue, 25 Jul 2023 21:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpJtAU5dme6g44HDx9Ay8oIg0z4b3DCk6sXxcLzq4r1AeizKhJq2wURX97pyKHjspzCKjHO9gsFP2S5uQeo+iNSwkvkFO3tR3xhrshQaa+XOAIV8mygFOskPOBBhqpamQcg5vK3bG5EvFoEseATJg+qD+FCIhCD0YBQjMLgSg78QiBV8TnESlS0nqx71W3cxZs+Q/mIlkOUAwjANXiGqA6Ee1cXmFX2yOiZ4hvcQCYkeDMSDGpMlbtSWGWv5DffnUWCAtYAlaos5d5NOw6HFVrMRbMv1moZPVUoRcogZC/Gxiab/Yc8KwOdRNqKJeaG318pE2cwrZ9vwkzM3lRA58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QdF+r/5gGCtMMbTIw2XFSuIMUkFIn6UIY7WiaGEgHY=;
 b=CwrSXql5qvk+XppXVHprIKT0/TtURWzphTshI84CiD5SMjCqof0pN3xXy0YV4QXSOnPsocEuSLDyALcRg3h71swpmSTF+cRaU1iEEnojGhx11PKEsgPQSpr9N0a5MRP1lALfMMMOtxgPGT3OwGSZMK8YitpAglaFqntRVutIFvPzHVRquQ9ZgAD8aYYSlt5+F3d5DXrAFSh1R5+FRNT+hH4dXtu0NQBcZBJ+U6JNSJ9Ea7P2Ee0tI+sNXKm7Rud1AJQ64kkATzpfTgAmyNIxvB1KionS/QYLk7f4+BXF/aPbnZE159xWkgjEeOi+sYGAg6tOGZRmtL3UFbpT1Xcw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QdF+r/5gGCtMMbTIw2XFSuIMUkFIn6UIY7WiaGEgHY=;
 b=Ep2xeZX82lEDrgJbEFnJPaJwL/ZQcjJjuOhoeq5b+zI2v97WWfx+7/0M4f+NQdfX/uZ4oU6JUiGoh1c7Q/QRo3q3VTzUzTMwrKMxToyzpsfmtE6Ij2B2DdF/FOeurKQV/B6LMTVB7CQkNl5KCil1igMqOxYh4N8qz/Nrhd1V/RM=
Received: from MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::21)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:22:32 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::cf) by MW4P223CA0016.outlook.office365.com
 (2603:10b6:303:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Wed, 26 Jul 2023 04:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 04:22:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 23:22:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 21:22:31 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 25 Jul 2023 23:22:30 -0500
Message-ID: <97ae2eda-f712-0b83-dc90-0f29edd5db8b@amd.com>
Date:   Tue, 25 Jul 2023 21:22:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V11 2/5] PCI: Create device tree node for bridge
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
References: <1690323318-6103-1-git-send-email-lizhi.hou@amd.com>
 <1690323318-6103-3-git-send-email-lizhi.hou@amd.com>
 <CAL_JsqLoJzqnXtJ4BZZo6Y5fVz7PW701968K1VkZX93oKzxf5w@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_JsqLoJzqnXtJ4BZZo6Y5fVz7PW701968K1VkZX93oKzxf5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cfd5b2-1e7d-4048-a134-08db8d8fee49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yE3ENYQOFibYbKYtRmDAXa++mMdpNY5byQtjlcqEg443dw31DfU1tJ2jsgOPx4BBGEuzxZwpcmlF/YMOi3DNkw3NWB93OsRWlT0yk6xdq0Qr4ikUCLGN9g6N1HNuDmyGaZ46YxeJwn/ZxN19NToogPyuHGGvFSw8/ALZlrWhY0PUCCrsli9qPwaShrWe7Mu88na45AoRKmf8ZesHNymPCpmX2MHNIZNHMLYOq9kaYKW1lturlHF3fd3YyYQ4ymQXSuh3gMi7KDgZvXqIJChZFJxo4kjkeT5KCJoscOvEs2DOWgNWtR3hd8svCMV/jkTjmxhop5WVX+0nwaO0+wqmwAkDbjF/kRLS9hElI1xIRPr0a4AWKWO/al86jnnubmTn3TxWti09R7VSmqIH305AVxdP6TXJ6Wxx0LX0xZJrhUQB932T18l60mP7eQD8TQ9Zuo/HqmqRmtpbLuL775L4SP9UaBXP8yHm/3s+14GXFK0nY+1TnmbluK/bPOfbx2UnOEwwlQ3K+4B9j77i++bcKXpTdBQZnrla5vA/qFj9KtjCJvhrTgj6Oj73ynGb9ZZ6IXMh0DZVEVLkBcHrUok5k1wxGhlMWOfCERqdokZG16VccIYHIwCOoHDpzFbBNdWmObzlDAf99ShibQkQ6Dx3nWIPtf88XOru6vHFinNJXZUhwyoVadd7oQWy4ed6vBmaOGI/Ypb+H/vYnEDencWo9ZUHwSCe4/KGNeCBhYZrfN+30HIjMyXQVE1sVWpxHZK43t8x4G2ckoxsa7ZlNxE9fC7SVeRNo2/fvdsEstDYhJ9E7pgYyj5hWkHKvSI77ry+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(31686004)(44832011)(8936002)(8676002)(5660300002)(41300700001)(316002)(6916009)(4326008)(16576012)(2906002)(54906003)(70206006)(70586007)(6666004)(53546011)(336012)(26005)(186003)(478600001)(40460700003)(31696002)(86362001)(40480700001)(36756003)(426003)(82740400003)(2616005)(47076005)(36860700001)(83380400001)(356005)(81166007)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:22:31.9293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cfd5b2-1e7d-4048-a134-08db8d8fee49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/25/23 16:04, Rob Herring wrote:
> On Tue, Jul 25, 2023 at 4:15 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>> the PCI core discovers devices and BARs using the PCI enumeration process.
>> There is no infrastructure to discover the hardware peripherals that are
>> present in a PCI device, and which can be accessed through the PCI BARs.
>>
>> Apparently, the device tree framework requires a device tree node for the
>> PCI device. Thus, it can generate the device tree nodes for hardware
>> peripherals underneath. Because PCI is self discoverable bus, there might
>> not be a device tree node created for PCI devices. Furthermore, if the PCI
>> device is hot pluggable, when it is plugged in, the device tree nodes for
>> its parent bridges are required. Add support to generate device tree node
>> for PCI bridges.
>>
>> Add an of_pci_make_dev_node() interface that can be used to create device
>> tree node for PCI devices.
>>
>> Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
>> the kernel will generate device tree nodes for PCI bridges unconditionally.
>>
>> Initially, add the basic properties for the dynamically generated device
>> tree nodes which include #address-cells, #size-cells, device_type,
>> compatible, ranges, reg.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/pci/Kconfig       |  12 ++
>>   drivers/pci/Makefile      |   1 +
>>   drivers/pci/bus.c         |   2 +
>>   drivers/pci/of.c          |  96 +++++++++++++++-
>>   drivers/pci/of_property.c | 232 ++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h         |  12 ++
>>   drivers/pci/remove.c      |   1 +
>>   7 files changed, 354 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/pci/of_property.c
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 3c07d8d214b3..49bd09c7dd0a 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -194,6 +194,18 @@ config PCI_HYPERV
>>            The PCI device frontend driver allows the kernel to import arbitrary
>>            PCI devices from a PCI backend to support PCI driver domains.
>>
>> +config PCI_DYNAMIC_OF_NODES
>> +       bool "Create device tree nodes for PCI devices"
>> +       depends on OF
>> +       select OF_DYNAMIC
>> +       help
>> +         This option enables support for generating device tree nodes for some
>> +         PCI devices. Thus, the driver of this kind can load and overlay
>> +         flattened device tree for its downstream devices.
>> +
>> +         Once this option is selected, the device tree nodes will be generated
>> +         for all PCI bridges.
>> +
>>   choice
>>          prompt "PCI Express hierarchy optimization setting"
>>          default PCIE_BUS_DEFAULT
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 2680e4c92f0a..cc8b4e01e29d 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)      += p2pdma.o
>>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>>   obj-$(CONFIG_VGA_ARB)          += vgaarb.o
>>   obj-$(CONFIG_PCI_DOE)          += doe.o
>> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>>
>>   # Endpoint library must be initialized before its users
>>   obj-$(CONFIG_PCI_ENDPOINT)     += endpoint/
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 5bc81cc0a2de..ab7d06cd0099 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -340,6 +340,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>>           */
>>          pcibios_bus_add_device(dev);
>>          pci_fixup_device(pci_fixup_final, dev);
>> +       if (pci_is_bridge(dev))
>> +               of_pci_make_dev_node(dev);
>>          pci_create_sysfs_dev_files(dev);
>>          pci_proc_attach_device(dev);
>>          pci_bridge_d3_update(dev);
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index e51219f9f523..11d3be165e32 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -495,8 +495,21 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>                   * to rely on this function (you ship a firmware that doesn't
>>                   * create device nodes for all PCI devices).
>>                   */
>> -               if (ppnode)
>> -                       break;
>> +               if (ppnode) {
>> +                       /*
>> +                        * When PCI_DYNAMIC_OF_NODES is on, a device tree
>> +                        * node will be generated for PCI bridge. For the
>> +                        * dynamically generated node, interrupt mapping is
>> +                        * not supported. Thus, it needs to check interrupt-map
>> +                        * property and set ppnode to NULL to do standard
>> +                        * swizzling if interrupt-map does not present.
>> +                        */
>> +                       if (IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES) &&
>> +                           !of_property_present(ppnode, "interrupt-map"))
>> +                               ppnode = NULL;
> We cannot use a kconfig option to determine behavior. You don't get to
> decide the value of the kconfig option. The OS distro does. As I've
> said in the past, the kconfig option is not a long term solution. You
> need things to work the same way whether PCI nodes were populated
> before the kernel runs or dynamically.
>
> Perhaps what you need to do is read PCI_INTERRUPT_PIN and if it's
> non-zero for a device, populate 'interrupts' property using the value.
> Then the standard DT interrupt parsing code should work. That code
> will walk up nodes until it finds the host bridge interrupt-map.

of_irq_parse_pci() already has the code to read PCI_INTERRUPT_PIN for 
the device which does not have device tree node.

Because the device tree node is generated, the standard swizzling is 
skipped. Thus the code walking up to host bridge interrupt-map does not 
work. What is missing here is actually 'interrupt-map' for bridge nodes. 
It sounds to me we need to generate 'interrupt-map' for every bridge 
node (similar to powerpc)?


Lizhi

>
> Rob
