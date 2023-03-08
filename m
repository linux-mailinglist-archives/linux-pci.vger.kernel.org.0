Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF26AFFA6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 08:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCHH3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 02:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHH3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 02:29:13 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA648C976;
        Tue,  7 Mar 2023 23:29:10 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d7so17217630qtr.12;
        Tue, 07 Mar 2023 23:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvvwre36ZvKzOBMNVn55DxLHO+Ck6JE5A+PvSlGqOtI=;
        b=n+Hjdn9Gu5tO/ACiOaNBjvlCm9eNwirIL0QEbFO4P1jf1kr9av3PPRSb9t0WdDtNiw
         xxwUc5gxZWLnQtkJnqDY6QRI6XT8/bAKermFRnnpM4H4V8g2dEgmyKfcBka9Zhw6wvd6
         hvPa383S9Shal2leKYEVK5c7rNuaa00If6Y6iJr1F6fKh13FLBBNWqZhLySCId7VkcrZ
         LvsOnX7tTry5WDAzeg7FB+mT9Wxw5GhSt5o2loRNEA/tnhFrLBywkuz3nigFZGsxgrNL
         ilfqh5+D/yZn70Fp/bM9qPVMqnoefwgSWjzdHqGCVxvhDES/DNHI2hVbpN3NyqXrLdok
         UtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvvwre36ZvKzOBMNVn55DxLHO+Ck6JE5A+PvSlGqOtI=;
        b=J4LY84Nw1Ms+hTNGGy02tsxW5468iDaRGdA4HIZHB/DtCWKrlJaYLU4EH/Qs3yIVVn
         tTIsFoqbvaAwdrbPMF9aWbmY797lgUYUomB72fxDcptFfY2i++L/2YnJIp8MKNZeUpBo
         nD3ozTFlFWNccs/bRp/n+evmd9spbryzAF7gQJGXa743ycaMD/n1m7wscS2cHVnK/y/F
         GnPIaokduDQ61791mUvY4WY1VXvMKZXDIF878lemiIompT7MCXw2Lm98O2UF43VI5cFR
         m/PDOvIwYr4Djc4MMldi2IoykD6Tjcth2UwynzEM+NtdbVPw+oWDxYDhkbIa7m4qYpHk
         NkHg==
X-Gm-Message-State: AO0yUKUksNlzspT2cAK6GV+q/sALmuVmnJ2h2EbXLA5B+tMnWDPfalko
        VgA+Ed5VY8Ihp0Wrz5NcajQ=
X-Google-Smtp-Source: AK7set8E0C4WjpAZl+QoA9EZ2QRbqoDGiGvUddu6KaNKxi9yShjyZhtKpHlwXrRDulITKj1dlqzk3g==
X-Received: by 2002:ac8:5982:0:b0:3bf:bff0:841d with SMTP id e2-20020ac85982000000b003bfbff0841dmr27209071qte.21.1678260549383;
        Tue, 07 Mar 2023 23:29:09 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:4cdf:396a:50a:e093? ([2600:1700:2442:6db0:4cdf:396a:50a:e093])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a0b5600b0070648cf78bdsm10783027qkg.54.2023.03.07.23.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 23:29:08 -0800 (PST)
Message-ID: <c0b9bbcb-9ffe-a3e3-65e5-d6779d7928b3@gmail.com>
Date:   Wed, 8 Mar 2023 01:29:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Rob Herring <robh@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
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
 <20230307094709.7f5020fe@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230307094709.7f5020fe@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/7/23 02:47, Clément Léger wrote:
> Le Mon, 6 Mar 2023 18:52:42 -0600,
> Rob Herring <robh@kernel.org> a écrit :
> 
>> On Mon, Mar 6, 2023 at 3:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 3/6/23 02:35, clement.leger@bootlin.com wrote:  
>>>> Le 2023-03-04 00:42, Frank Rowand a écrit :  
>>>>> On 2/27/23 04:31, Clément Léger wrote:  
>>>>>> Le Mon, 27 Feb 2023 00:51:29 -0600,
>>>>>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>>>>>  
>>>>>>> On 1/19/23 21:02, Lizhi Hou wrote:  
>>>>>>>> This patch series introduces OF overlay support for PCI devices
>>>>>>>> which
>>>>>>>> primarily addresses two use cases. First, it provides a data driven
>>>>>>>> method
>>>>>>>> to describe hardware peripherals that are present in a PCI endpoint
>>>>>>>> and
>>>>>>>> hence can be accessed by the PCI host. Second, it allows reuse of a
>>>>>>>> OF
>>>>>>>> compatible driver -- often used in SoC platforms -- in a PCI host
>>>>>>>> based
>>>>>>>> system.
>>>>>>>>
>>>>>>>> There are 2 series devices rely on this patch:
>>>>>>>>
>>>>>>>>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>>>>>>   2) Microchip LAN9662 Ethernet Controller
>>>>>>>>
>>>>>>>>      Please see:

First off, if I had paid gone back and finished reading through this link:

>>>>>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/

I would have found out that the Microchip LAN9662 Ethernet Controller is
_not_ just an ethernet controller (as I was assuming), but is instead also
contains ARM64 cores.  (Actually I am sure that I had noted that an SoC
was involved, but lost track of that info when trying to wrap my head
around this patch series.)

Even this information does not explain where the ethernet controller is
located and how it is accessed.  My most likely guess without looking at
chip specification is that the ethernet controller interfaces to the
processor bus and/or an IOMMU is probably involved.  What is very unclear
to me is the interconnection between the card PCI connector (which will be
plugged into the host system where we are running Linux for this patch
series).  This will feed into my misunderstanding below.

For future versions of this patch series, please include the info that the
LAN9662 Ethernet Controller is an SoC, as was noted in the above link.

>>>>>>>>  
>>>>>>>
>>>>>>>  
>>>>>>>> Normally, the PCI core discovers PCI devices and their BARs using
>>>>>>>> the
>>>>>>>> PCI enumeration process. However, the process does not provide a way
>>>>>>>> to
>>>>>>>> discover the hardware peripherals that are present in a PCI device,
>>>>>>>> and
>>>>>>>> which can be accessed through the PCI BARs. Also, the enumeration
>>>>>>>> process  
>>>>>>>
>>>>>>> I'm confused.  The PCI Configuration Header Registers should describe
>>>>>>> the
>>>>>>> hardware on the PCI card.
>>>>>>>
>>>>>>> Ignoring case 1 above _for the moment_ (FPGA devices are a world unto
>>>>>>> themselves, so I would like to analyze that case separately), does
>>>>>>> the
>>>>>>> second device, "Microchip LAN9662 Ethernet Controller" properly
>>>>>>> implement
>>>>>>> the PCI Configuration Header Registers?  What additional information
>>>>>>> is
>>>>>>> needed that is not provided in those registers?  
>>>>>>
>>>>>> Hi Frank,
>>>>>>
>>>>>> I guess Lizhi wanted to say that it does not provide a way to describe
>>>>>> all the "platform" devices that are exposed by this PCI device. Which
>>>>>> is of course the whole point of the work we are doing right now. But
>>>>>> all the BARs are correctly described by the LAN9662 PCI card.
>>>>>>
>>>>>> Clément  
>>>>>
>>>>> I remain confused.
>>>>>
>>>>> [RFC 00/10] add support for fwnode in i2c mux system and sfp
>>>>> https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
>>>>>
>>>>>   references a PCIe driver:
>>>>>   [2]
>>>>> https://github.com/clementleger/linux/blob/fwnode_support/drivers/mfd/lan966x_pci_mfd.c
>>>>>
>>>>> So there is a PCIe driver that works.
>>>>>
>>>>> However, the RFC patch series was proposing adding fwnode support to
>>>>> the driver.  My first
>>>>> surface reading (just part of that one email, not the entire series or
>>>>> the replies yet),
>>>>> notes:
>>>>>
>>>>>   ... However, when
>>>>>   plugged in a PCIe slot (on a x86), there is no device-tree support
>>>>> and
>>>>>   the peripherals that are present must be described in some other way.
>>>>>
>>>>> I am assuming that the peripherals are what you mentioned above as
>>>>> '"platform"
>>>>> devices'.  This is where my current confusion lies.  Are the "platform"
>>>>> devices accessed via the PCI bus or is there some other electrical
>>>>> connection
>>>>> between the host system and the PCIe card?  
>>>>>>>> Hi Frank,
>>>>

From Clément:

>>>> The platform devices exposed by this PCIe card are available via some
>>>> BAR using PCI memory mapped areas, so it's totally standard PCI stuff.
>>>>  
>>>>>

I had been assuming that each device that is visible via the PCI connector
had a set of PCI configuration header registers that
provided the information required to use that device.

The above paragraph reinforced my understanding, saying "so it's totally
standard PCI stuff".  (Apparently my understanding was wrong, see further
below...)

I had earlier asked this:

>>>>> If the "platform" devices are accessed via the PCI bus, then I would
>>>>> expect them
>>>>> to be described by PCI configuration header registers.  Are the PCI
>>>>> configuration
>>>>> registers to describe the "platform" devices not present?  

Clément replied:

>>>>
>>>> I'm not sure to understand what you mean here. PCI configuration headers
>>>> only provides some basic registers allowing to identify the PCI device
>>>> (vendor/product) and some memory areas that are exposed (BAR). They do
>>>> not provides the "list" of peripherals that are exposed by the devices,
>>>> only some BARs that can be mapped and that allows to access.  
>>>

To which I replied:

>>> Yes, "identify the PCI device (vendor/product) and some memory areas".
>>> The driver for the (vendor/product) 'knows' what peripherals are exposed
>>> by the device and where within the BAR to find the registers for each
>>> of the devices.
>>>
>>> A normal PCI driver would contain this information.  If I understand the
>>> proposal of this patch series, of_pci_make_dev_node() adds a node to
>>> the devicetree, when invoked via a PCI quirk for certain specific
>>> vendor/product cards.  This node must exist for the flattened device
>>> tree (FDT) overlay for the card to be loaded.  The driver for the card
>>> will get the overlay FDT from the card and load it into the kernel.
>>> The driver will use the information that then exists in the devicetree
>>> describing the card, instead of using information from the PCI configuration
>>> headers from the card.  
>>

Clément had further replied (this seems to have gotten lost in Rob's reply to me:

   In the case of the lan9662 cnetwork controller, BAR 0 and 1 exposes
   multiples devices that are located at some subranges of this BAR. For
   instance (not accurate), we have the I2C controller located at BAR 0
   + offset 0X1000, then the flexcom controller exposed in BAR 0 at offset
     0x20000, etc. This list of peripheral is not exposed at all by the PCI
   configuration headers (since it is not the purpose of course). All of
   these peripherals have already existing platform drivers which can then
   be reused thanks to the PCI device-tree overlay series.

At this point my understanding (or misunderstanding as we will see below)
remains intact, with the slight addition that the devices on the PCI card
are multi-function.  I've never worked with multi-function devices on a
PCI card so I don't know how they are supposed to be described, but this
new information seems reasonable.

The (vendor/product) would provide the information to find a driver
that understands that this PCI device contains both the I2C controller
and the flexcom controller.

The phrase "This list of peripheral is not exposed at all by the PCI
configuration headers" is confusing to me.  A major function of the
configuration headers it to list exactly what devices are available on
the card, as identified by (vendor/product) in each configuration
header.  The (vendor/product) "exposes" the multi-function device,
also known as "the list of peripheral".


Rob's "re-explaining":

>> How would all the sub devices be defined by the PCI config space other
>> than a VID/PID implies *everything*. That's the same as the pre-DT
>> world where the ARM machine ID number (from RMK's registry) implied
>> everything. These days, we can have an entire SoC exposed behind a PCI
>> BAR which I think is pretty much Clement's usecase. Putting an SoC
>> behind a PCI BAR is no more discoverable than a "normal" SoC.

That is a PCI device problem, not a non-discoverable device on the
system non-discoverable busses.  PCI devices are supposed to be
discoverable on the PCI bus.

This series claimed to be about (1) a method to "describe hardware devices
that are present in a PCI endpoint" and (2) "allows reuse of a OF
compatible driver".

(1) is normally implemented directly in a PCI driver

(2) is using a shim to make a single driver able to access a device that
is either directly on the system bus (the driver "native" environment)
or located on a PCI card (in other words on the other side of the PCI
bus interface on the PCI card).

"Putting an SoC behind a PCI BAR" is not different to me than any
other device on a PCI card.  And I do not _even_ know what it means
to put an SoC behind a PCI BAR (there are many ways that could be
implemented), which is why I was asking Clément questions, trying
to understand the problem space.

PCI devices are more than a BAR, there is a set of PCI Configuration
Header Registers to provide the requisite information to locate the
proper driver for the device and provides the dynamic information
specific to the device in this card (eg address ranges, interrupt
info, MSI, MSI-X, etc).  The driver is expected to contain all
further knowledge about how to control the device.


Clément replies:

> Thanks Rob for re-explaining all of that, I thought the cover letter
> at [1] explained that This is *exactly* my usecase. the lan9662 SoC can
> either be used to run Linux and uses a device-tree description, or can

This is a clue for me:

> be configured as a PCIe endpoint card and plugged on, a PCI port, in
> which case all the SoC IO memories are exposed through BAR 0 & 1.

I had been assuming that each SoC supplied device that is visible via
the PCI connector had a set of PCI Configuration Header Registers that
provided the information required to use that device.

I think this is where my misunderstanding jumps out.

Please correct and explain as necessary anything in the block the
I write here:

The clue above appears to say that one portion of "SoC IO memories" are
exposed through BAR 0 and a second portion of "SoC IO memories" are
exposed through BAR 1.

This would be consistent with Rob's description saying the entire
SoC is exposed by a single Configuration Header Register set.

Caveat: I've never worked with an IOMMU on ARM64 (only on other very
different architectures) so I have no clue as to what the specific
ARM64 IOMMU architecture is or any related nuances.

I don't know what "SoC IO memories" are.  But given the context of a
driver accessing addresses, I am guessing these are addresses in the
context of the processor bus.  The precise description probably does
not matter if I can simply assume they are addresses the driver will
use, and the addresses are properly mapped into the addresses listed
in the BARs.

Frank's assumption: the relevant devices, such as the ethernet controller
are located directly on the SoC processor bus (is the proper term "memory
bus"? - addresses that are accessed via SoC load and store instructions).

So are the entire set of SoC processor bus addresses mapped via the BARs?
Or even a significant subset?

Further Frank's assumptions: Some sort of firmware is running on the SoC
that is on the PCI card that does things like control clocks, do power
management, set up the interrupts from devices to be visible via the PCI
connector, as described by the PCI Configuration Header Registers (possibly
including the MSI and/or MSI-X registers), any IOMMU setup if needed, etc.
The host system that the PCI card is plugged into is insulated from that
set of activities by the PCI interface.  <----- This assumption may turn
out to be wrong, as I ask more questions further below.


> 
>>
>>>
>>> The intent is to be able to re-use devicetree based drivers instead of
>>> having the driver be a native PCI driver.  
>>
>> Not instead of. There's the PCI driver for the FPGA or SoC bus with
>> multiple unrelated devices behind it. The PCI driver is just a bus
>> driver much like we have for various custom SoC bus drivers.
>>
>>> This goes against historical Linux practice.  The idea of taking a driver
>>> from another environment (eg Windows, HP Unix, Sun Unix, IBM Unix, etc)
>>> and adding a shim layer to translate between Linux and the other
>>> environment has been rejected.  Ironically, in this case, the other
>>> environment is Linux (more specifically the Linux OF implementation).
>>
>> I don't see how your example relates to this in any way whatsoever.
>> We're talking about different discovery mechanisms, not different
>> driver models/environments.
>>
>>> Even thought the other environment is Linux, this is still adding a
>>> shim layer to translate between that other environment and the native
>>> Linux PCI environment for which the driver would normally be written.
> 

Clément replies:

> Since there is an entire SoC described behind that PCI card, we need to
> link all the devcies together. So it's not as simple as saying "I want
> a driver for each device to be probed", we also need to describe the
> whole hierarchy & links between the devices. PCI "itself" does not
> describe how to define that, only a way to access the memory and
> identify the PCI device.

This makes me guess that the assumption I made above in this email
is not correct.  This seems to be saying that the host system needs
to understand related devices in the card's SoC, and possibly control
them.  An example of this could be that the PCI Configuration Header
Register do _not_ describe the interrupt information for e.g. the
ethernet controller, and maybe the host system needs to understand
and/or program an interrupt controller in the card's SoC.  Is this
conceptually correct (that is maybe not this specific hardware, but
a similar concept)?


> 
>>>
>>> In other words, this is not acceptable.  Normal alternatives would be
>>> something like
>>> (1) add the PCI awareness to the existing drivers,  
>>

Rob said:

>> The downstream devices don't have their own PCI config space. That
>> won't work. PCI drivers expect a device with PCI config space. Devices
>> to drivers are always 1:1, so we couldn't share the config space among

A PCI device can be a multifunction device.  Whether the host OS supports
this via a single driver or multiple drivers is OS dependent.

>> multiple drivers or something. For devices which are not discoverable
>> like these are, our choices are DT, ACPI or s/w nodes (aka
>> platform_data 2.0).

The devices _are_ discoverable.  The PCI Configuration Header Register
(vendor/product) says what the devices are.

> 

Clément replies:
> Exactly, and even though it would be possible to share the the config
> space, it would mean that each driver would need to be modified to
> support PCI and all the OF layer that allows to link the devcuie
> together and configure the device would need to be modified in some way
> to allows passing arguments, that would be going back to paltform_data
> stuff.

To me this implies that (as an example, using the ethernet controller)
the host system will be configuring the resources and/or infrastructure
on the SoC that is used by the ethernet controller.

Do I understand that correctly?

My previous expectation is the the ethernet controller driver on the
host system would only be touching registers mapped to the ethernet
controller driver to do things like send commands, read status results,
specify buffer addresses that would map back to flow through the PCI
connector, etc.

> 
>>
>>> (2) split the devicetree aware and PCI aware portions of the driver
>>> to common code that would be invoked from separate devicetree and PCI
>>> drivers,  
>>
>> That only makes sense for something that is a single driver. Not the
>> case here. For the FPGA, the devices are not known up front.
>>
>>> (3) write entirely separate devicetree and PCI drivers, or  
>>
>> For the same reason as 1, that simply won't work.
>>
>>> (4) some other creative solution.
>>>
>>> Am I mis-interpretting or misunderstanding anything crucial here?  
>>
>> Yes...
>>
>> We now have 3 different use cases all needing the same thing. The
>> 3rd[1] is the recent test infrastructure change to have test devices
>> added. They all have non-discoverable devices downstream of a PCI
>> device. We need a solution here.
> 
> We have been going back and forth for about more than a year now and we
> tested several things (software nodes, ACPI, MFD cells,
> device-tree overlays). The most elegant solution (at least from the
> ones we though of) has proven to be the device-tree overlays with
> dynamic PCI of nodes for various reasons:

I can't really respond to this section and below because I still do
not understand the specific problem space of the SoC on the PCI card.

Hopefully your response to this email will move me further along
the path to properly understand the PCI card implementation.

-Frank

> 
> - Minimal amount of code modified
> - Reusability of the existing SoC device-tree
> - Already available bindings (no need to define a new standard for
>   system description)
> - Works on all platforms (x86, ARM, ARM64, etc)
> - Ease of use for the end-user
> 
> No other solution was providing so much pros (see [1] for the history).
> Of course there are some cons such as the *not so clear* status about OF
> overlays statiblity when loaded/unloaded but we are clearly working
> toward a better support.
> 
> I even think that a common driver to handle much of these use cases
> could exists and allow to load an overlay based on the PCI VID/PID and
> apply some ranges remapping depending on it, allowing to reduce the
> amount of specific complex drivers for handling these usecases.
> 
> Clément
> 
> [1]
> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/

