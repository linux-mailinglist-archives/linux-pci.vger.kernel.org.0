Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4AA6AD88A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 08:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCGHzF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 02:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCGHzF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 02:55:05 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:101:465::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021F4DBE2
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 23:55:00 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4PW75X5zJPz9sX0;
        Tue,  7 Mar 2023 08:54:56 +0100 (CET)
Message-ID: <aecca8c5-687d-ddf3-94fd-9d65d8f5c1d2@denx.de>
Date:   Tue, 7 Mar 2023 08:54:52 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     clement.leger@bootlin.com, Lizhi Hou <lizhi.hou@amd.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
 <20230227113150.398dcfa7@fixe.home>
 <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com>
 <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
 <1886b888-a0e8-b1ee-c48a-ddbc8b5b0c63@gmail.com>
 <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
Content-Language: en-US
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PW75X5zJPz9sX0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/7/23 01:52, Rob Herring wrote:
> On Mon, Mar 6, 2023 at 3:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 3/6/23 02:35, clement.leger@bootlin.com wrote:
>>> Le 2023-03-04 00:42, Frank Rowand a écrit :
>>>> On 2/27/23 04:31, Clément Léger wrote:
>>>>> Le Mon, 27 Feb 2023 00:51:29 -0600,
>>>>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>>>>
>>>>>> On 1/19/23 21:02, Lizhi Hou wrote:
>>>>>>> This patch series introduces OF overlay support for PCI devices
>>>>>>> which
>>>>>>> primarily addresses two use cases. First, it provides a data driven
>>>>>>> method
>>>>>>> to describe hardware peripherals that are present in a PCI endpoint
>>>>>>> and
>>>>>>> hence can be accessed by the PCI host. Second, it allows reuse of a
>>>>>>> OF
>>>>>>> compatible driver -- often used in SoC platforms -- in a PCI host
>>>>>>> based
>>>>>>> system.
>>>>>>>
>>>>>>> There are 2 series devices rely on this patch:
>>>>>>>
>>>>>>>    1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>>>>>    2) Microchip LAN9662 Ethernet Controller
>>>>>>>
>>>>>>>       Please see:
>>>>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>>>>
>>>>>>
>>>>>>
>>>>>>> Normally, the PCI core discovers PCI devices and their BARs using
>>>>>>> the
>>>>>>> PCI enumeration process. However, the process does not provide a way
>>>>>>> to
>>>>>>> discover the hardware peripherals that are present in a PCI device,
>>>>>>> and
>>>>>>> which can be accessed through the PCI BARs. Also, the enumeration
>>>>>>> process
>>>>>>
>>>>>> I'm confused.  The PCI Configuration Header Registers should describe
>>>>>> the
>>>>>> hardware on the PCI card.
>>>>>>
>>>>>> Ignoring case 1 above _for the moment_ (FPGA devices are a world unto
>>>>>> themselves, so I would like to analyze that case separately), does
>>>>>> the
>>>>>> second device, "Microchip LAN9662 Ethernet Controller" properly
>>>>>> implement
>>>>>> the PCI Configuration Header Registers?  What additional information
>>>>>> is
>>>>>> needed that is not provided in those registers?
>>>>>
>>>>> Hi Frank,
>>>>>
>>>>> I guess Lizhi wanted to say that it does not provide a way to describe
>>>>> all the "platform" devices that are exposed by this PCI device. Which
>>>>> is of course the whole point of the work we are doing right now. But
>>>>> all the BARs are correctly described by the LAN9662 PCI card.
>>>>>
>>>>> Clément
>>>>
>>>> I remain confused.
>>>>
>>>> [RFC 00/10] add support for fwnode in i2c mux system and sfp
>>>> https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
>>>>
>>>>    references a PCIe driver:
>>>>    [2]
>>>> https://github.com/clementleger/linux/blob/fwnode_support/drivers/mfd/lan966x_pci_mfd.c
>>>>
>>>> So there is a PCIe driver that works.
>>>>
>>>> However, the RFC patch series was proposing adding fwnode support to
>>>> the driver.  My first
>>>> surface reading (just part of that one email, not the entire series or
>>>> the replies yet),
>>>> notes:
>>>>
>>>>    ... However, when
>>>>    plugged in a PCIe slot (on a x86), there is no device-tree support
>>>> and
>>>>    the peripherals that are present must be described in some other way.
>>>>
>>>> I am assuming that the peripherals are what you mentioned above as
>>>> '"platform"
>>>> devices'.  This is where my current confusion lies.  Are the "platform"
>>>> devices accessed via the PCI bus or is there some other electrical
>>>> connection
>>>> between the host system and the PCIe card?
>>>
>>> Hi Frank,
>>>
>>> The platform devices exposed by this PCIe card are available via some
>>> BAR using PCI memory mapped areas, so it's totally standard PCI stuff.
>>>
>>>>
>>>> If the "platform" devices are accessed via the PCI bus, then I would
>>>> expect them
>>>> to be described by PCI configuration header registers.  Are the PCI
>>>> configuration
>>>> registers to describe the "platform" devices not present?
>>>
>>> I'm not sure to understand what you mean here. PCI configuration headers
>>> only provides some basic registers allowing to identify the PCI device
>>> (vendor/product) and some memory areas that are exposed (BAR). They do
>>> not provides the "list" of peripherals that are exposed by the devices,
>>> only some BARs that can be mapped and that allows to access.
>>
>> Yes, "identify the PCI device (vendor/product) and some memory areas".
>> The driver for the (vendor/product) 'knows' what peripherals are exposed
>> by the device and where within the BAR to find the registers for each
>> of the devices.
>>
>> A normal PCI driver would contain this information.  If I understand the
>> proposal of this patch series, of_pci_make_dev_node() adds a node to
>> the devicetree, when invoked via a PCI quirk for certain specific
>> vendor/product cards.  This node must exist for the flattened device
>> tree (FDT) overlay for the card to be loaded.  The driver for the card
>> will get the overlay FDT from the card and load it into the kernel.
>> The driver will use the information that then exists in the devicetree
>> describing the card, instead of using information from the PCI configuration
>> headers from the card.
> 
> How would all the sub devices be defined by the PCI config space other
> than a VID/PID implies *everything*. That's the same as the pre-DT
> world where the ARM machine ID number (from RMK's registry) implied
> everything. These days, we can have an entire SoC exposed behind a PCI
> BAR which I think is pretty much Clement's usecase. Putting an SoC
> behind a PCI BAR is no more discoverable than a "normal" SoC.
> 
>>
>> The intent is to be able to re-use devicetree based drivers instead of
>> having the driver be a native PCI driver.
> 
> Not instead of. There's the PCI driver for the FPGA or SoC bus with
> multiple unrelated devices behind it. The PCI driver is just a bus
> driver much like we have for various custom SoC bus drivers.
> 
>> This goes against historical Linux practice.  The idea of taking a driver
>> from another environment (eg Windows, HP Unix, Sun Unix, IBM Unix, etc)
>> and adding a shim layer to translate between Linux and the other
>> environment has been rejected.  Ironically, in this case, the other
>> environment is Linux (more specifically the Linux OF implementation).
> 
> I don't see how your example relates to this in any way whatsoever.
> We're talking about different discovery mechanisms, not different
> driver models/environments.
> 
>> Even thought the other environment is Linux, this is still adding a
>> shim layer to translate between that other environment and the native
>> Linux PCI environment for which the driver would normally be written.
>>
>> In other words, this is not acceptable.  Normal alternatives would be
>> something like
>> (1) add the PCI awareness to the existing drivers,
> 
> The downstream devices don't have their own PCI config space. That
> won't work. PCI drivers expect a device with PCI config space. Devices
> to drivers are always 1:1, so we couldn't share the config space among
> multiple drivers or something. For devices which are not discoverable
> like these are, our choices are DT, ACPI or s/w nodes (aka
> platform_data 2.0).
> 
>> (2) split the devicetree aware and PCI aware portions of the driver
>> to common code that would be invoked from separate devicetree and PCI
>> drivers,
> 
> That only makes sense for something that is a single driver. Not the
> case here. For the FPGA, the devices are not known up front.
> 
>> (3) write entirely separate devicetree and PCI drivers, or
> 
> For the same reason as 1, that simply won't work.
> 
>> (4) some other creative solution.
>>
>> Am I mis-interpretting or misunderstanding anything crucial here?
> 
> Yes...
> 
> We now have 3 different use cases all needing the same thing. The
> 3rd[1] is the recent test infrastructure change to have test devices
> added. They all have non-discoverable devices downstream of a PCI
> device. We need a solution here.

Thanks Rob for this explanation. I would like to second that, as I've
been looking for a "solution" for exact this situation for a few years
now in multiple system configurations. The setup mostly being identical:
An FPGA connected via PCIe to the host CPU, embedded in the FPGA misc
devices like NS16550 UART, GPIO controller, etc which often have
existing drivers in the Kernel. Using this dynamic device tree node
approach for the PCIe EP with the possibility to describe the FPGA-
internal devices via device tree seems to be the most elegant solution
IMHO.

Thanks,
Stefan

> Rob
> 
> [1] https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com/
