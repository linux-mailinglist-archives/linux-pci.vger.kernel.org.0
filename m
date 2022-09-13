Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060005B791F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiIMSHC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 14:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiIMSGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 14:06:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9536C75D;
        Tue, 13 Sep 2022 10:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+dv8HBPzm4nK2zaypWdRs79RPgI2j5QU4ZYTmzsc4sXPZ0OsO996AiKquAyyVeDJou0S2FWhz0bqslhqs6elLztxQ1dWM6RR8PuL3r2EkjSkqTnLsMSpXH6FYoVPDED6t805+5o4Qd/+9qservbpJfxwH/tfeHQNUZqL7wfoguInZsKsaFF5ii0kot8b6vAC9md/7beV5x52gp8iVUCZk3XgWUmxOJrvZY7wUJUSYN/ijFVsGGgW2DZDKweqv3MoYLG8fGz4aK1NO1YhKz0Lb2jLm0PdHrHU5HpkKaVh1O6/lZbDlWF6yP8MsFDF8zE5vLv6aL0Y/FCf2fAesjfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr9IN7vpE6b36GzY0uKqKoTibmem7u+Y0JYwWzxv6Ec=;
 b=R1Sop65QDUq30CnwcfQmpD72D0LuFdHS32VRg5SFsYMo79jl224NOCmqemqEqJZSXSKmTQ24Kbeikn5cftiI8UrtSjAGJ8IAewCHFADBoC1Vav5V/BPMABksY6ajE7exK/Fh7MvmPWtjo89mkckp0Ng689g3HrMU/QdrjBkrBEriawHtoXweOLGJFEch+MsM2tGLMI58mWKKmpGB6DftyXPrPiLpkSZ7teuGz2+5y5aFeySgV5K8scY/njZV9DBprKrhJ0D/sj8cve8mY4zmOsJT/SeLg9ZAIj04hk0FNRuhu/ZcT+I/v4PCLIvxK+u6Hh0BpSayxj05DVjc5EVMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr9IN7vpE6b36GzY0uKqKoTibmem7u+Y0JYwWzxv6Ec=;
 b=Tn4akW3z23bSvFf0qfedvuxjzlCCSwMSlv6w/4cldCwLxhpI/4jaoMLaerGvf2756ZvN9j8jJvl3jLw5J0cmYoEXAlk/OlkmsAMYVFnc2sT3+3WUioSSTaTwzJB4QvfYFSGiu+T1dm7MZZNyk8MLUaEwIAYAdqYPM2FiV2Fg8QU=
Received: from BN1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:408:e2::21)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 17:10:06 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::9) by BN1PR13CA0016.outlook.office365.com
 (2603:10b6:408:e2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Tue, 13 Sep 2022 17:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 17:10:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 12:10:05 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 12:10:04 -0500
Message-ID: <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
Date:   Tue, 13 Sep 2022 10:10:04 -0700
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
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed65e13-4920-4f1d-9128-08da95aace4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtjMO6eUsBM/euC+kjKgemyPekBpspvvhCfV99dVrCXvZIXhAkMoLgcD5BRdWvt1rk5uXmlMP8Z1bRingk3HwYerM1qju5qex5rTU9/C0THIaTLvgrSQjC+GZs3F9dCbpnbKWXAH0fP/tlVigikyKc4x/GlDLqH5OCEyZpVWng4vXA+cIZMh6jBCm2KJWOuTTl7zHIgxUWuxMSxKnBDbnfhHsE27zTtI82ReFqjT0y01b2sHd7GfKLffVQvMGOJrv+fP4M4Xkz7FHh2P4qw1gsDp/A4BOyaB2RXg0d2vLD2pMQD7B2W2Q0nwv6b13nxmX34Y5hzELbgc7HzuViY9TxeXTcVDTf9zE9DR8eGuhtc/Zn7A0Z42v/VpBXgprpvNA5mEqyhCfVPlYQl1am9y7TfCGakPMT64ig1MgUW1Gr4XaELrUen58kV9n19Bqf6IvQbvJnMHAlZ4s2pP0O7GfVkkpE6SgSU3iiDlltgn22S4H2kyRlOmlM9sMn8gfVfbcJIz9/HOzzzTwihrfB/PHFarjYWokcj0LusCm+ZyGFi67FYCBRjf4hPB8R35hkhzAuE3Z0N4MzrvSP4ZTDDeF7Pb/2ZFxBiSgtG5zzqs0YHMK3jZsyGUQHHCTNIAHe3txjhW5tiOrzeRDqBMCvrKuuOMI91Es5T2W2YVUVkwyTd7847W5Alii7VxzXKnW0DuQt/u2eSPT1tb1PTV8uWNKOjqxPm531Qf+rNDdE2WgRE8fVsssPwE8DHXUM0W0duOzoPn4XKtafhsvZbONpqFwgJ7vHNJJJvYQ6Pj4TC2POMEO269GcuJJKNr7Nv8vkkOBpeVqS8bEyy796vmLOPzuDzmpxDh6GWn16NGHK/D6Gz/sLnCYTK8DLmjJJfr32sRc+0bdnLtU7Eb9dQ8eU1zTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(31696002)(966005)(2906002)(31686004)(426003)(5660300002)(86362001)(8676002)(478600001)(81166007)(66574015)(316002)(26005)(4326008)(356005)(40460700003)(110136005)(54906003)(40480700001)(44832011)(82740400003)(186003)(16576012)(70206006)(41300700001)(8936002)(83380400001)(47076005)(70586007)(36756003)(53546011)(82310400005)(336012)(2616005)(36860700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 17:10:06.4021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed65e13-4920-4f1d-9128-08da95aace4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/13/22 00:00, Frank Rowand wrote:
> On 8/29/22 16:43, Lizhi Hou wrote:
>> This patch series introduces OF overlay support for PCI devices which
>> primarily addresses two use cases. First, it provides a data driven method
>> to describe hardware peripherals that are present in a PCI endpoint and
>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
>> driver -- often used in SoC platforms -- in a PCI host based system. An
>> example device is Microchip LAN9662 Ethernet Controller.
>>
>> This patch series consolidates previous efforts to define such an
>> infrastructure:
>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
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
>> This patch series is made up of two patches.
>>
>> The first patch is adding OF interface to allocate an OF node. It is copied
>> from:
>> https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/
>>
>> The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
>> is turned on, the kernel will generate device tree nodes for all PCI
>> bridges unconditionally. The patch also shows how to use the PCI quirks
>> infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
>> a device. Specifically, the patch generates a device tree node for Xilinx
>> Alveo U50 PCIe accelerator device. The generated device tree nodes do not
>> have any property. Future patches will add the necessary properties.
>>
>> Clément Léger (1):
>>    of: dynamic: add of_node_alloc()
>>
>> Lizhi Hou (1):
>>    pci: create device tree node for selected devices
>>
>>   drivers/of/dynamic.c        |  50 +++++++++++++----
>>   drivers/pci/Kconfig         |  11 ++++
>>   drivers/pci/bus.c           |   2 +
>>   drivers/pci/msi/irqdomain.c |   6 +-
>>   drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci-driver.c    |   3 +-
>>   drivers/pci/pci.h           |  16 ++++++
>>   drivers/pci/quirks.c        |  11 ++++
>>   drivers/pci/remove.c        |   1 +
>>   include/linux/of.h          |   7 +++
>>   10 files changed, 200 insertions(+), 13 deletions(-)
>>
> The patch description leaves out the most important piece of information.
>
> The device located at the PCI endpoint is implemented via FPGA
>     - which is programmed after Linux boots (or somewhere late in the boot process)
>        - (A) and thus can not be described by static data available pre-boot because
>              it is dynamic (and the FPGA program will often change while the Linux
>              kernel is already booted
>        - (B) can be described by static data available pre-boot because the FPGA
>              program will always be the same for this device on this system
>
> I am not positive what part of what I wrote above is correct and would appreciate
> some confirmation of what is correct or incorrect.

There are 2 series devices rely on this patch:

     1) Xilinx Alveo Accelerator cards (FPGA based device)

     2) lan9662 PCIe card

           please see: 
https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/

For Xilinx Alveo device, it is (A). The FPGA partitions can be 
programmed dynamically after boot.


Thanks,

Lzhi

>
> -Frank
