Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913F850BB7F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387221AbiDVPS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 11:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449335AbiDVPSl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 11:18:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA05F9C
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 08:15:47 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MFFLBj001557;
        Fri, 22 Apr 2022 10:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650640521;
        bh=vqjfVLIyTTSMKeHeuYKKyba+5URBr8k2MKFvy+5Pj+Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=P+ez63yJSqcGf1VdZD0iHV9rN7QVNrBeVQSlvnuWD/ivsXgEFy/yxcCx/u61TWJgP
         4FyPLuRa1KEm8DKGNnQXWTvAjYk8kp2ullLqo70idz5rVA1lSfXdHx2EZ1zRwINQuX
         WJSMLppzCs7GC8jNj50D3T+2owcETguTTE+sGwow=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MFFLT3087116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 10:15:21 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 10:15:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 10:15:21 -0500
Received: from [10.250.233.93] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MFFG5a007959;
        Fri, 22 Apr 2022 10:15:17 -0500
Subject: Re: [PATCH V2 0/4] NTB function for PCIe RC to EP connection
To:     Zhi Li <lznuaa@gmail.com>
CC:     Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <hongxing.zhu@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, <linux-ntb@googlegroups.com>,
        <linux-pci@vger.kernel.org>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <fa2ab3cf-1508-bbeb-47af-8b2d47904b20@ti.com>
 <CAHrpEqT2zwWiiiTUDAu9JNPXmzP1zELF7YDERWjdOohGMFRBnA@mail.gmail.com>
 <CAHrpEqSceNNQNAzCwbfiJc2Zk9fYCo5KqKmLZqHAG-7teSqF0Q@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0407f63c-b422-bcfa-999a-5ef31a2afedf@ti.com>
Date:   Fri, 22 Apr 2022 20:45:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHrpEqSceNNQNAzCwbfiJc2Zk9fYCo5KqKmLZqHAG-7teSqF0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

On 21/04/22 1:52 am, Zhi Li wrote:
> On Tue, Apr 5, 2022 at 10:35 AM Zhi Li <lznuaa@gmail.com> wrote:
>>
>> On Tue, Apr 5, 2022 at 5:34 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>
>>> Hi Frank Li,
>>>
>>> On 22/02/22 9:53 pm, Frank Li wrote:
>>>> This implement NTB function for PCIe EP to RC connections.
>>>> The existed ntb epf need two PCI EPs and two PCI Host.
>>>
>>> As I had earlier mentioned in [1], IMHO ideal solution would be build on virtio
>>> layer instead of trying to build on NTB layer (which is specific to RC<->RC
>>> communication).
>>>
>>> Are there any specific reasons for not taking that path?
>>
>> 1. EP side work as vHOST mode.  vHost suppose access all memory of virtual io.
>> But there are only map windows on the EP side to access RC side
>> memory. You have to move
>> map windows for each access.  It is quite low efficiency.

I'm not sure I quite get this. EP HW has limited outbound memory to access RC
memory irrespective of how we implement it. This is not a SW framework
limitation AFAICS.
>>
>> 2. So far as I know, virtio is still not DMA yet.  CPU access PCI
>> can't generate longer PCI TLP,
>> So the speed is quite slow.  NTB already has DMA support.  If you use
>> system level DMA,
>> no change is needed at NTB level.  If we want to use a PCI controller
>> embedded DMA,  some small
>> changes need if based on my other Designware PCI eDMA patches, which
>> are under review.

Adding dmaengine API to do memcopy should be simple to add in vhost/virtio
interface.
>>
>> 3. All the major data transfer of NTB is using write.  Because TLP
>> write needn't wait for complete,  write
>> performance is better than reading.  On our platform,  write
>> performance is about 10% better than  read.
>>
>> Frank
> 
> Any Comments or rejection? @Kishon Vijay Abraham I

I'd strongly recommend going with virtio/vhost based approach and standardizing
it IMO.

Thanks,
Kishon

> 
> best regards
> Frank Li
> 
>>
>>>
>>> Thanks,
>>> Kishon
>>>
>>> [1] -> https://lore.kernel.org/r/459745d1-9fe7-e792-3532-33ee9552bc4d@ti.com
>>>>
>>>> This just need EP to RC connections.
>>>>
>>>>     ┌────────────┐         ┌─────────────────────────────────────┐
>>>>     │            │         │                                     │
>>>>     ├────────────┤         │                      ┌──────────────┤
>>>>     │ NTB        │         │                      │ NTB          │
>>>>     │ NetDev     │         │                      │ NetDev       │
>>>>     ├────────────┤         │                      ├──────────────┤
>>>>     │ NTB        │         │                      │ NTB          │
>>>>     │ Transfer   │         │                      │ Transfer     │
>>>>     ├────────────┤         │                      ├──────────────┤
>>>>     │            │         │                      │              │
>>>>     │  PCI NTB   │         │                      │              │
>>>>     │    EPF     │         │                      │              │
>>>>     │   Driver   │         │                      │ PCI Virtual  │
>>>>     │            │         ├───────────────┐      │ NTB Driver   │
>>>>     │            │         │ PCI EP NTB    │◄────►│              │
>>>>     │            │         │  FN Driver    │      │              │
>>>>     ├────────────┤         ├───────────────┤      ├──────────────┤
>>>>     │            │         │               │      │              │
>>>>     │  PCI BUS   │ ◄─────► │  PCI EP BUS   │      │  Virtual PCI │
>>>>     │            │  PCI    │               │      │     BUS      │
>>>>     └────────────┘         └───────────────┴──────┴──────────────┘
>>>>         PCI RC                        PCI EP
>>>>
>>>>
>>>>
>>>> Frank Li (4):
>>>>   PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address
>>>>   NTB: epf: Allow more flexibility in the memory BAR map method
>>>>   PCI: endpoint: Support NTB transfer between RC and EP
>>>>   Documentation: PCI: Add specification for the PCI vNTB function device
>>>>
>>>>  Documentation/PCI/endpoint/index.rst          |    2 +
>>>>  .../PCI/endpoint/pci-vntb-function.rst        |  126 ++
>>>>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  167 ++
>>>>  drivers/ntb/hw/epf/ntb_hw_epf.c               |   48 +-
>>>>  .../pci/controller/dwc/pcie-designware-ep.c   |   10 +-
>>>>  drivers/pci/endpoint/functions/Kconfig        |   11 +
>>>>  drivers/pci/endpoint/functions/Makefile       |    1 +
>>>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1424 +++++++++++++++++
>>>>  8 files changed, 1775 insertions(+), 14 deletions(-)
>>>>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
>>>>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst
>>>>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c
>>>>
