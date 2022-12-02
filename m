Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7B640BB2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiLBRGF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 12:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiLBRGE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 12:06:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C36F2D5;
        Fri,  2 Dec 2022 09:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7G80r/l/RPGdUsccG39mW8/L201ItB2TMrCijDXTXrN6WDPyR27X5KzxrjKoKQGAbPLzWwnKDIk56PoAwxAs+y/jegqmN/9XqHgpP5hpG4R9bItWXtPdYCrsyGn8P7ALKz26mb8ViliE+Q6C1PkDTXPcKg5cFDKdX8R0xVBaUG4Lev8Srr6eQWphifIHvQIZ0nqfTj7ydJHRHsj92KltzIIUL67WLP7Wuwi9MtwdK0Ut4SNLI/fuJ3dGkouOK1nllUrbCI2QlK/bQZXLftsIXe82xKMlZeHwqXCrDYe7girmJwsWjhdkiWWpkagg0BLta41sEBNHMaHr5ht07QLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEEfP2tw/XdVNUsgzgnh6+6Md9upQm1Fc5Fbz606wow=;
 b=LuyJhUm0ITFB3fvjG9ulxbJNYVj/5F7X/vFdwjsAwyUbe6JvDMn9ogxBbt9ToavhL85B0sFIT7NoqmKSS/LMwy6sb+GBeFIwQeJgqfvzXVTss51Hib6yDL9g8+ZpW/7C/+TdcXegD+L0A0x9D9Ew3nP/ElKpYhps76a6hX8ryD+SlmF2UD4X0OslweNww2uHOxAQL5qkcaBdy2iPBPzEEPy5Wd+lia4DV0i1aGQurwKtzrV2DbXfAMOP3cPzEwTCtumC6HDY2T/AS91U32hHmBkP1Y3ZpuVZtqlNK5jaufD68UmbzZxSmIAY8K5gx2mt+2bxdY7fwJItxwUb0YAgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEEfP2tw/XdVNUsgzgnh6+6Md9upQm1Fc5Fbz606wow=;
 b=JOOHP7CLvx6ZKdh7NmzxLPQmpXCEDIRXCDOrWdpOUc1QQYkvrgDhtMsMxJi0hngs72ByoHTz/Rw+XFK7sDG7dGd6AFaMqzzku3LDtcXIUWKr/aa61nTU2qf5sqpbar0LlTQHbeCaOA3d31XQE07aE3k2Mgj86lHKwNv6LpNiLV4=
Received: from CY5PR16CA0009.namprd16.prod.outlook.com (2603:10b6:930:10::22)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 17:05:58 +0000
Received: from CY4PEPF0000C96A.namprd02.prod.outlook.com
 (2603:10b6:930:10:cafe::67) by CY5PR16CA0009.outlook.office365.com
 (2603:10b6:930:10::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Fri, 2 Dec 2022 17:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C96A.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Fri, 2 Dec 2022 17:05:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 11:05:57 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 2 Dec 2022 11:05:56 -0600
Content-Type: multipart/mixed;
        boundary="------------DyzxPEhU3RGp1T525PVZ00Hq"
Message-ID: <b7580b32-bd06-80bc-e71c-7008e4a0b555@amd.com>
Date:   Fri, 2 Dec 2022 09:05:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH RFC V4 0/3] Generate device tree node for pci
 devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frowand.list@gmail.com>,
        <helgaas@kernel.org>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
 <20221201212009.GB1225112-robh@kernel.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20221201212009.GB1225112-robh@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96A:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ae41b2-58e1-4b64-6efa-08dad4877b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjXF360lEskQ4klmAIc4v3a8tqB3QRsPB0gspNFW1yV6qShm3WKLEGabvu/fTNKkf04aa03Fd36CtNPzgqrIRfxDzMY2Ehmz7MyNmx+Hc4hxgnzKdauFfAOjSzN9jIH/HfW2o8kCKAXrz+Ie1ciu1Pt9uBpdRJPgikRrBu7BI3yUMG/+WDOdlv5QjfrCCGphIYkMAotrVjM5RNkOdtue1G8z4mWA8ApmjfUSe4Sge/7myoM5OzH/yWnlzJmszCU5JD3XnGr7Dk+wMN8nXY/B145czFfQMv1k/Tz28dnaqsxJngA5Vdc62E/UgapVT2O1ZCVQndqd+WPa7F+39WgMz4i1xvNF9yWhOVhDKpuaooaJJBwim1ZsMinl+HXMv01PlQik5BeQ9tQyfOMf1Vui/FlSnDB4eyI/03WNZL0hjVnktgVIZCJc5qISPqB4Dxg205oj80LMKQhLcovtAZfSdsSrOTc6WH/yZTo1VvA2gEyZMjcxh3kADNlvK/u0jELy3IolI/tgGQUElXza2tEb2RXB9Hemfw6rmxZDhQFICxK/L2On+tYJ38w+4vaMTleAPirCjWd5j0Ygz4+RV2JfsX6tPht/8jCEth+F1mMx2CexMrLWoe+VIwKkjl7gp9o8qP7yoz5v91jH2CLwI+MpK55saiqRaTjPAxJ7zZ4x2XCKULyNOOmAssROhJeCsHDzZ8YoriEAG9d8E2YRGGC5gT9RIiKvaLJu2fbX5EMqf/LGguCI9yD56MTz9uesz/Ms1Fq/abiVqHVBYxCHeBu4TJCliQfxlYsoD6WPkTAVrY/uYCCPWKs3JcAp9/ebjpJCSpFiDM2qQVJ1WOtLf8A/cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(26005)(36860700001)(21480400003)(966005)(86362001)(83380400001)(31696002)(478600001)(31686004)(33964004)(53546011)(47076005)(6916009)(316002)(2616005)(54906003)(70206006)(41300700001)(186003)(426003)(235185007)(5660300002)(21460400002)(40480700001)(8936002)(40460700003)(44832011)(2906002)(356005)(16576012)(82740400003)(81166007)(4326008)(82310400005)(8676002)(70586007)(36756003)(336012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 17:05:58.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ae41b2-58e1-4b64-6efa-08dad4877b7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--------------DyzxPEhU3RGp1T525PVZ00Hq
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 12/1/22 13:20, Rob Herring wrote:
> On Mon, Nov 21, 2022 at 08:43:01AM -0800, Lizhi Hou wrote:
>> This patch series introduces OF overlay support for PCI devices which
>> primarily addresses two use cases. First, it provides a data driven method
>> to describe hardware peripherals that are present in a PCI endpoint and
>> hence can be accessed by the PCI host. Second, it allows reuse of a OF
>> compatible driver -- often used in SoC platforms -- in a PCI host based
>> system.
>>
>> There are 2 series devices rely on this patch:
>>
>>    1) Xilinx Alveo Accelerator cards (FPGA based device)
>>    2) Microchip LAN9662 Ethernet Controller
>>
>>       Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>
>> Normally, the PCI core discovers PCI devices and their BARs using the
>> PCI enumeration process. However, the process does not provide a way to
>> discover the hardware peripherals that are present in a PCI device, and
>> which can be accessed through the PCI BARs. Also, the enumeration process
>> does not provide a way to associate MSI-X vectors of a PCI device with the
>> hardware peripherals that are present in the device. PCI device drivers
>> often use header files to describe the hardware peripherals and their
>> resources as there is no standard data driven way to do so. This patch
>> series proposes to use flattened device tree blob to describe the
>> peripherals in a data driven way. Based on previous discussion, using
>> device tree overlay is the best way to unflatten the blob and populate
>> platform devices. To use device tree overlay, there are three obvious
>> problems that need to be resolved.
>>
>> First, we need to create a base tree for non-DT system such as x86_64. A
>> patch series has been submitted for this:
>> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
>> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
>>
>> Second, a device tree node corresponding to the PCI endpoint is required
>> for overlaying the flattened device tree blob for that PCI endpoint.
>> Because PCI is a self-discoverable bus, a device tree node is usually not
>> created for PCI devices. This series adds support to generate a device
>> tree node for a PCI device which advertises itself using PCI quirks
>> infrastructure.
>>
>> Third, we need to generate device tree nodes for PCI bridges since a child
>> PCI endpoint may choose to have a device tree node created.
>>
>> This patch series is made up of three patches.
>>
>> The first patch is adding OF interface to create or destroy OF node
>> dynamically.
>>
>> The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.
>> When the option is turned on, the kernel will generate device tree nodes
>> for all PCI bridges unconditionally. The patch also shows how to use the
>> PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
>> tree node for a device. Specifically, the patch generates a device tree
>> node for Xilinx Alveo U50 PCIe accelerator device. The generated device
>> tree nodes do not have any property.
>>
>> The third patch adds basic properties ('reg', 'compatible' and
>> 'device_type') to the dynamically generated device tree nodes. More
>> properties can be added in the future.
>>
>> Here is the example of device tree nodes generated within the ARM64 QEMU.
> Can you share the setup for QEMU.
I attached the VM xml config file. Should I include the configure in 
cover letter next time?
>
>
>> # lspci -t
>> -[0000:00]-+-00.0
>>             +-01.0-[01]--
>>             +-01.1-[02]----00.0
>>             +-01.2-[03]----00.0
>>             +-01.3-[04]----00.0
>>             +-01.4-[05]----00.0
>>             +-01.5-[06]--
>>             +-01.6-[07]--
>>             +-01.7-[08]--
>>             +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
>>             |                                            \-00.1
>>             +-02.1-[0c]--
>>             \-03.0-[0d-0e]----00.0-[0e]----01.0
>>
>> # tree /sys/firmware/devicetree/base/pcie\@10000000
>> /sys/firmware/devicetree/base/pcie@10000000
>> |-- #address-cells
>> |-- #interrupt-cells
>> |-- #size-cells
>> |-- bus-range
>> |-- compatible
>> |-- device_type
>> |-- dma-coherent
>> |-- interrupt-map
>> |-- interrupt-map-mask
>> |-- linux,pci-domain
>> |-- msi-parent
>> |-- name
>> |-- pci@1,0
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,1
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,2
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,3
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,4
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,5
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,6
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@1,7
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@2,0
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- pci@0,0
>> |   |   |-- #address_cells
>> |   |   |-- #size_cells
>> |   |   |-- compatible
>> |   |   |-- device_type
>> |   |   |-- pci@0,0
>> |   |   |   |-- #address_cells
>> |   |   |   |-- #size_cells
>> |   |   |   |-- compatible
>> |   |   |   |-- dev@0,0
> I don't see anywhere in the patch series defining 'dev'.

It is defined here:

 > +void of_pci_make_dev_node(struct pci_dev *pdev)
 > +{
 > +    struct device_node *parent, *dt_node = NULL;
 > +    const char *pci_type = "dev";


Thanks,

Lizhi

>
>> |   |   |   |   |-- compatible
>> |   |   |   |   `-- reg
>> |   |   |   |-- dev@0,1
>> |   |   |   |   |-- compatible
>> |   |   |   |   `-- reg
>> |   |   |   |-- device_type
>> |   |   |   |-- ranges
>> |   |   |   `-- reg
>> |   |   |-- ranges
>> |   |   `-- reg
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@2,1
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- ranges
>> |   `-- reg
>> |-- pci@3,0
>> |   |-- #address_cells
>> |   |-- #size_cells
>> |   |-- compatible
>> |   |-- device_type
>> |   |-- pci@0,0
>> |   |   |-- #address_cells
>> |   |   |-- #size_cells
>> |   |   |-- compatible
>> |   |   |-- device_type
>> |   |   |-- ranges
>> |   |   `-- reg
>> |   |-- ranges
>> |   `-- reg
>> |-- ranges
>> `-- reg
>>
>> Changes since RFC v3:
>> - Split the Xilinx Alveo U50 PCI quirk to a separate patch
>> - Minor changes in commit description and code comment
>>
>> Changes since RFC v2:
>> - Merged patch 3 with patch 2
>> - Added OF interfaces of_changeset_add_prop_* and use them to create
>>    properties.
>> - Added '#address-cells', '#size-cells' and 'ranges' properties.
>>
>> Changes since RFC v1:
>> - Added one patch to create basic properties.
>> - To move DT related code out of PCI subsystem, replaced of_node_alloc()
>>    with of_create_node()/of_destroy_node()
>>
>> Lizhi Hou (3):
>>    of: dynamic: Add interfaces for creating device node dynamically
>>    PCI: Create device tree node for selected devices
>>    PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
>>
>>   drivers/of/dynamic.c        | 187 ++++++++++++++++++++++++++
>>   drivers/pci/Kconfig         |  12 ++
>>   drivers/pci/Makefile        |   1 +
>>   drivers/pci/bus.c           |   2 +
>>   drivers/pci/msi/irqdomain.c |   6 +-
>>   drivers/pci/of.c            |  71 ++++++++++
>>   drivers/pci/of_property.c   | 256 ++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci-driver.c    |   3 +-
>>   drivers/pci/pci.h           |  19 +++
>>   drivers/pci/quirks.c        |  11 ++
>>   drivers/pci/remove.c        |   1 +
>>   include/linux/of.h          |  24 ++++
>>   12 files changed, 590 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/pci/of_property.c
>>
>> -- 
>> 2.17.1
>>
>>
--------------DyzxPEhU3RGp1T525PVZ00Hq
Content-Type: text/xml; charset="UTF-8"; name="arm64-vm.xml"
Content-Disposition: attachment; filename="arm64-vm.xml"
Content-Transfer-Encoding: base64

PGRvbWFpbiB0eXBlPSdxZW11Jz4KICA8bmFtZT5hcm02NC12bTwvbmFtZT4KICA8dXVpZD41
M2Q4MTllZi1kNjI4LTQzMzctOWEyMS0xNDQ2OGU2YzQ0MzY8L3V1aWQ+CiAgPG1lbW9yeSB1
bml0PSdLaUInPjIwOTcxNTI8L21lbW9yeT4KICA8Y3VycmVudE1lbW9yeSB1bml0PSdLaUIn
PjIwOTcxNTI8L2N1cnJlbnRNZW1vcnk+CiAgPHZjcHUgcGxhY2VtZW50PSdzdGF0aWMnPjI8
L3ZjcHU+CiAgPG9zPgogICAgPHR5cGUgYXJjaD0nYWFyY2g2NCcgbWFjaGluZT0ndmlydC0y
LjExJz5odm08L3R5cGU+CiAgICA8a2VybmVsPi9yb290L3BjaWUtZHQtaW1hZ2VzL3ZtbGlu
dXotNi4wLjAtcmM1Kzwva2VybmVsPgogICAgPGluaXRyZD4vcm9vdC9wY2llLWR0LWltYWdl
cy9pbml0cmQuaW1nLTYuMC4wLXJjNSs8L2luaXRyZD4KICAgIDxjbWRsaW5lPmNvbnNvbGU9
dHR5QU1BMCwxMTUyMDAgcm9vdD0vZGV2L3ZkYSBuZXQuaWZuYW1lcz0wIGJpb3NkZXZuYW1l
PTA8L2NtZGxpbmU+CiAgICA8Ym9vdCBkZXY9J2hkJy8+CiAgICA8Ym9vdG1lbnUgZW5hYmxl
PSdubycvPgogIDwvb3M+CiAgPGZlYXR1cmVzPgogICAgPGdpYyB2ZXJzaW9uPScyJy8+CiAg
PC9mZWF0dXJlcz4KICA8Y3B1IG1vZGU9J2N1c3RvbScgbWF0Y2g9J2V4YWN0JyBjaGVjaz0n
bm9uZSc+CiAgICA8bW9kZWwgZmFsbGJhY2s9J2FsbG93Jz5jb3J0ZXgtYTU3PC9tb2RlbD4K
ICA8L2NwdT4KICA8Y2xvY2sgb2Zmc2V0PSd1dGMnLz4KICA8b25fcG93ZXJvZmY+ZGVzdHJv
eTwvb25fcG93ZXJvZmY+CiAgPG9uX3JlYm9vdD5yZXN0YXJ0PC9vbl9yZWJvb3Q+CiAgPG9u
X2NyYXNoPmRlc3Ryb3k8L29uX2NyYXNoPgogIDxkZXZpY2VzPgogICAgPGVtdWxhdG9yPi91
c3IvbG9jYWwvYmluL3FlbXUtc3lzdGVtLWFhcmNoNjQ8L2VtdWxhdG9yPgogICAgPGRpc2sg
dHlwZT0nZmlsZScgZGV2aWNlPSdkaXNrJz4KICAgICAgPGRyaXZlciBuYW1lPSdxZW11JyB0
eXBlPSdyYXcnLz4KICAgICAgPHNvdXJjZSBmaWxlPScvcm9vdC9hcm02NC12bS5pbWcnLz4K
ICAgICAgPHRhcmdldCBkZXY9J3ZkYScgYnVzPSd2aXJ0aW8nLz4KICAgICAgPGFkZHJlc3Mg
dHlwZT0ncGNpJyBkb21haW49JzB4MDAwMCcgYnVzPScweDA0JyBzbG90PScweDAwJyBmdW5j
dGlvbj0nMHgwJy8+CiAgICA8L2Rpc2s+CiAgICA8Y29udHJvbGxlciB0eXBlPSd1c2InIGlu
ZGV4PScwJyBtb2RlbD0ncWVtdS14aGNpJyBwb3J0cz0nOCc+CiAgICAgIDxhZGRyZXNzIHR5
cGU9J3BjaScgZG9tYWluPScweDAwMDAnIGJ1cz0nMHgwMicgc2xvdD0nMHgwMCcgZnVuY3Rp
b249JzB4MCcvPgogICAgPC9jb250cm9sbGVyPgogICAgPGNvbnRyb2xsZXIgdHlwZT0ncGNp
JyBpbmRleD0nMCcgbW9kZWw9J3BjaWUtcm9vdCcvPgogICAgPGNvbnRyb2xsZXIgdHlwZT0n
cGNpJyBpbmRleD0nMScgbW9kZWw9J3BjaWUtcm9vdC1wb3J0Jz4KICAgICAgPG1vZGVsIG5h
bWU9J3BjaWUtcm9vdC1wb3J0Jy8+CiAgICAgIDx0YXJnZXQgY2hhc3Npcz0nMScgcG9ydD0n
MHg4Jy8+CiAgICAgIDxhZGRyZXNzIHR5cGU9J3BjaScgZG9tYWluPScweDAwMDAnIGJ1cz0n
MHgwMCcgc2xvdD0nMHgwMScgZnVuY3Rpb249JzB4MCcgbXVsdGlmdW5jdGlvbj0nb24nLz4K
ICAgIDwvY29udHJvbGxlcj4KICAgIDxjb250cm9sbGVyIHR5cGU9J3BjaScgaW5kZXg9JzIn
IG1vZGVsPSdwY2llLXJvb3QtcG9ydCc+CiAgICAgIDxtb2RlbCBuYW1lPSdwY2llLXJvb3Qt
cG9ydCcvPgogICAgICA8dGFyZ2V0IGNoYXNzaXM9JzInIHBvcnQ9JzB4OScvPgogICAgICA8
YWRkcmVzcyB0eXBlPSdwY2knIGRvbWFpbj0nMHgwMDAwJyBidXM9JzB4MDAnIHNsb3Q9JzB4
MDEnIGZ1bmN0aW9uPScweDEnLz4KICAgIDwvY29udHJvbGxlcj4KICAgIDxjb250cm9sbGVy
IHR5cGU9J3BjaScgaW5kZXg9JzMnIG1vZGVsPSdwY2llLXJvb3QtcG9ydCc+CiAgICAgIDxt
b2RlbCBuYW1lPSdwY2llLXJvb3QtcG9ydCcvPgogICAgICA8dGFyZ2V0IGNoYXNzaXM9JzMn
IHBvcnQ9JzB4YScvPgogICAgICA8YWRkcmVzcyB0eXBlPSdwY2knIGRvbWFpbj0nMHgwMDAw
JyBidXM9JzB4MDAnIHNsb3Q9JzB4MDEnIGZ1bmN0aW9uPScweDInLz4KICAgIDwvY29udHJv
bGxlcj4KICAgIDxjb250cm9sbGVyIHR5cGU9J3BjaScgaW5kZXg9JzQnIG1vZGVsPSdwY2ll
LXJvb3QtcG9ydCc+CiAgICAgIDxtb2RlbCBuYW1lPSdwY2llLXJvb3QtcG9ydCcvPgogICAg
ICA8dGFyZ2V0IGNoYXNzaXM9JzQnIHBvcnQ9JzB4YicvPgogICAgICA8YWRkcmVzcyB0eXBl
PSdwY2knIGRvbWFpbj0nMHgwMDAwJyBidXM9JzB4MDAnIHNsb3Q9JzB4MDEnIGZ1bmN0aW9u
PScweDMnLz4KICAgIDwvY29udHJvbGxlcj4KICAgIDxjb250cm9sbGVyIHR5cGU9J3BjaScg
aW5kZXg9JzUnIG1vZGVsPSdwY2llLXJvb3QtcG9ydCc+CiAgICAgIDxtb2RlbCBuYW1lPSdw
Y2llLXJvb3QtcG9ydCcvPgogICAgICA8dGFyZ2V0IGNoYXNzaXM9JzUnIHBvcnQ9JzB4Yycv
PgogICAgICA8YWRkcmVzcyB0eXBlPSdwY2knIGRvbWFpbj0nMHgwMDAwJyBidXM9JzB4MDAn
IHNsb3Q9JzB4MDEnIGZ1bmN0aW9uPScweDQnLz4KICAgIDwvY29udHJvbGxlcj4KICAgIDxj
b250cm9sbGVyIHR5cGU9J3BjaScgaW5kZXg9JzYnIG1vZGVsPSdwY2llLXJvb3QtcG9ydCc+
CiAgICAgIDxtb2RlbCBuYW1lPSdwY2llLXJvb3QtcG9ydCcvPgogICAgICA8dGFyZ2V0IGNo
YXNzaXM9JzYnIHBvcnQ9JzB4ZCcvPgogICAgICA8YWRkcmVzcyB0eXBlPSdwY2knIGRvbWFp
bj0nMHgwMDAwJyBidXM9JzB4MDAnIHNsb3Q9JzB4MDEnIGZ1bmN0aW9uPScweDUnLz4KICAg
IDwvY29udHJvbGxlcj4KICAgIDxjb250cm9sbGVyIHR5cGU9J3BjaScgaW5kZXg9JzcnIG1v
ZGVsPSdwY2llLXJvb3QtcG9ydCc+CiAgICAgIDxtb2RlbCBuYW1lPSdwY2llLXJvb3QtcG9y
dCcvPgogICAgICA8dGFyZ2V0IGNoYXNzaXM9JzcnIHBvcnQ9JzB4ZScvPgogICAgICA8YWRk
cmVzcyB0eXBlPSdwY2knIGRvbWFpbj0nMHgwMDAwJyBidXM9JzB4MDAnIHNsb3Q9JzB4MDEn
IGZ1bmN0aW9uPScweDYnLz4KICAgIDwvY29udHJvbGxlcj4KICAgIDxjb250cm9sbGVyIHR5
cGU9J3BjaScgaW5kZXg9JzgnIG1vZGVsPSdwY2llLXJvb3QtcG9ydCc+CiAgICAgIDxtb2Rl
bCBuYW1lPSdwY2llLXJvb3QtcG9ydCcvPgogICAgICA8dGFyZ2V0IGNoYXNzaXM9JzgnIHBv
cnQ9JzB4ZicvPgogICAgICA8YWRkcmVzcyB0eXBlPSdwY2knIGRvbWFpbj0nMHgwMDAwJyBi
dXM9JzB4MDAnIHNsb3Q9JzB4MDEnIGZ1bmN0aW9uPScweDcnLz4KICAgIDwvY29udHJvbGxl
cj4KICAgIDxjb250cm9sbGVyIHR5cGU9J3BjaScgaW5kZXg9JzknIG1vZGVsPSdwY2llLXJv
b3QtcG9ydCc+CiAgICAgIDxtb2RlbCBuYW1lPSdwY2llLXJvb3QtcG9ydCcvPgogICAgICA8
dGFyZ2V0IGNoYXNzaXM9JzknIHBvcnQ9JzB4MTAnLz4KICAgICAgPGFkZHJlc3MgdHlwZT0n
cGNpJyBkb21haW49JzB4MDAwMCcgYnVzPScweDAwJyBzbG90PScweDAyJyBmdW5jdGlvbj0n
MHgwJyBtdWx0aWZ1bmN0aW9uPSdvbicvPgogICAgPC9jb250cm9sbGVyPgogICAgPGNvbnRy
b2xsZXIgdHlwZT0ncGNpJyBpbmRleD0nMTAnIG1vZGVsPSdwY2llLXJvb3QtcG9ydCc+CiAg
ICAgIDxtb2RlbCBuYW1lPSdwY2llLXJvb3QtcG9ydCcvPgogICAgICA8dGFyZ2V0IGNoYXNz
aXM9JzEwJyBwb3J0PScweDExJy8+CiAgICAgIDxhZGRyZXNzIHR5cGU9J3BjaScgZG9tYWlu
PScweDAwMDAnIGJ1cz0nMHgwMCcgc2xvdD0nMHgwMicgZnVuY3Rpb249JzB4MScvPgogICAg
PC9jb250cm9sbGVyPgogICAgPGNvbnRyb2xsZXIgdHlwZT0ncGNpJyBpbmRleD0nMTEnIG1v
ZGVsPSdwY2llLXN3aXRjaC11cHN0cmVhbS1wb3J0Jz4KICAgICAgPG1vZGVsIG5hbWU9J3gz
MTMwLXVwc3RyZWFtJy8+CiAgICAgIDxhZGRyZXNzIHR5cGU9J3BjaScgZG9tYWluPScweDAw
MDAnIGJ1cz0nMHgwOScgc2xvdD0nMHgwMCcgZnVuY3Rpb249JzB4MCcvPgogICAgPC9jb250
cm9sbGVyPgogICAgPGNvbnRyb2xsZXIgdHlwZT0ncGNpJyBpbmRleD0nMTInIG1vZGVsPSdw
Y2llLXN3aXRjaC1kb3duc3RyZWFtLXBvcnQnPgogICAgICA8bW9kZWwgbmFtZT0neGlvMzEz
MC1kb3duc3RyZWFtJy8+CiAgICAgIDx0YXJnZXQgY2hhc3Npcz0nMTEnIHBvcnQ9JzB4MCcv
PgogICAgICA8YWRkcmVzcyB0eXBlPSdwY2knIGRvbWFpbj0nMHgwMDAwJyBidXM9JzB4MGIn
IHNsb3Q9JzB4MDAnIGZ1bmN0aW9uPScweDAnIG11bHRpZnVuY3Rpb249J29uJy8+CiAgICA8
L2NvbnRyb2xsZXI+CiAgICA8Y29udHJvbGxlciB0eXBlPSdwY2knIGluZGV4PScxMycgbW9k
ZWw9J2RtaS10by1wY2ktYnJpZGdlJz4KICAgICAgPG1vZGVsIG5hbWU9J2k4MjgwMWIxMS1i
cmlkZ2UnLz4KICAgICAgPGFkZHJlc3MgdHlwZT0ncGNpJyBkb21haW49JzB4MDAwMCcgYnVz
PScweDAwJyBzbG90PScweDAzJyBmdW5jdGlvbj0nMHgwJy8+CiAgICA8L2NvbnRyb2xsZXI+
CiAgICA8Y29udHJvbGxlciB0eXBlPSdwY2knIGluZGV4PScxNCcgbW9kZWw9J3BjaS1icmlk
Z2UnPgogICAgICA8bW9kZWwgbmFtZT0ncGNpLWJyaWRnZScvPgogICAgICA8dGFyZ2V0IGNo
YXNzaXNOcj0nMTQnLz4KICAgICAgPGFkZHJlc3MgdHlwZT0ncGNpJyBkb21haW49JzB4MDAw
MCcgYnVzPScweDBkJyBzbG90PScweDAwJyBmdW5jdGlvbj0nMHgwJy8+CiAgICA8L2NvbnRy
b2xsZXI+CiAgICA8Y29udHJvbGxlciB0eXBlPSd2aXJ0aW8tc2VyaWFsJyBpbmRleD0nMCc+
CiAgICAgIDxhZGRyZXNzIHR5cGU9J3BjaScgZG9tYWluPScweDAwMDAnIGJ1cz0nMHgwMycg
c2xvdD0nMHgwMCcgZnVuY3Rpb249JzB4MCcvPgogICAgPC9jb250cm9sbGVyPgogICAgPGlu
dGVyZmFjZSB0eXBlPSduZXR3b3JrJz4KICAgICAgPG1hYyBhZGRyZXNzPSc1Mjo1NDowMDo2
NTo4ZTplNCcvPgogICAgICA8c291cmNlIG5ldHdvcms9J2RlZmF1bHQnLz4KICAgICAgPG1v
ZGVsIHR5cGU9J3J0bDgxMzknLz4KICAgICAgPGFkZHJlc3MgdHlwZT0ncGNpJyBkb21haW49
JzB4MDAwMCcgYnVzPScweDBlJyBzbG90PScweDAxJyBmdW5jdGlvbj0nMHgwJy8+CiAgICA8
L2ludGVyZmFjZT4KICAgIDxzZXJpYWwgdHlwZT0ncHR5Jz4KICAgICAgPHRhcmdldCB0eXBl
PSdzeXN0ZW0tc2VyaWFsJyBwb3J0PScwJz4KICAgICAgICA8bW9kZWwgbmFtZT0ncGwwMTEn
Lz4KICAgICAgPC90YXJnZXQ+CiAgICA8L3NlcmlhbD4KICAgIDxjb25zb2xlIHR5cGU9J3B0
eSc+CiAgICAgIDx0YXJnZXQgdHlwZT0nc2VyaWFsJyBwb3J0PScwJy8+CiAgICA8L2NvbnNv
bGU+CiAgICA8Y2hhbm5lbCB0eXBlPSd1bml4Jz4KICAgICAgPHRhcmdldCB0eXBlPSd2aXJ0
aW8nIG5hbWU9J29yZy5xZW11Lmd1ZXN0X2FnZW50LjAnLz4KICAgICAgPGFkZHJlc3MgdHlw
ZT0ndmlydGlvLXNlcmlhbCcgY29udHJvbGxlcj0nMCcgYnVzPScwJyBwb3J0PScxJy8+CiAg
ICA8L2NoYW5uZWw+CiAgICA8aG9zdGRldiBtb2RlPSdzdWJzeXN0ZW0nIHR5cGU9J3BjaScg
bWFuYWdlZD0neWVzJz4KICAgICAgPHNvdXJjZT4KICAgICAgICA8YWRkcmVzcyBkb21haW49
JzB4MDAwMCcgYnVzPScweDY1JyBzbG90PScweDAwJyBmdW5jdGlvbj0nMHgwJy8+CiAgICAg
IDwvc291cmNlPgogICAgICA8YWRkcmVzcyB0eXBlPSdwY2knIGRvbWFpbj0nMHgwMDAwJyBi
dXM9JzB4MGMnIHNsb3Q9JzB4MDAnIGZ1bmN0aW9uPScweDAnIG11bHRpZnVuY3Rpb249J29u
Jy8+CiAgICA8L2hvc3RkZXY+CiAgICA8aG9zdGRldiBtb2RlPSdzdWJzeXN0ZW0nIHR5cGU9
J3BjaScgbWFuYWdlZD0neWVzJz4KICAgICAgPHNvdXJjZT4KICAgICAgICA8YWRkcmVzcyBk
b21haW49JzB4MDAwMCcgYnVzPScweDY1JyBzbG90PScweDAwJyBmdW5jdGlvbj0nMHgxJy8+
CiAgICAgIDwvc291cmNlPgogICAgICA8YWRkcmVzcyB0eXBlPSdwY2knIGRvbWFpbj0nMHgw
MDAwJyBidXM9JzB4MGMnIHNsb3Q9JzB4MDAnIGZ1bmN0aW9uPScweDEnLz4KICAgIDwvaG9z
dGRldj4KICAgIDxybmcgbW9kZWw9J3ZpcnRpbyc+CiAgICAgIDxiYWNrZW5kIG1vZGVsPSdy
YW5kb20nPi9kZXYvdXJhbmRvbTwvYmFja2VuZD4KICAgICAgPGFkZHJlc3MgdHlwZT0ncGNp
JyBkb21haW49JzB4MDAwMCcgYnVzPScweDA1JyBzbG90PScweDAwJyBmdW5jdGlvbj0nMHgw
Jy8+CiAgICA8L3JuZz4KICA8L2RldmljZXM+CjwvZG9tYWluPgoK

--------------DyzxPEhU3RGp1T525PVZ00Hq--
