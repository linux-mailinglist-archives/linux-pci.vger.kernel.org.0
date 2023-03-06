Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A64B6AD01C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 22:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCFVYb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 16:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFVYa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 16:24:30 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE21E36FD8;
        Mon,  6 Mar 2023 13:24:28 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id b10-20020a4aba0a000000b005200c0d4a2aso1745310oop.11;
        Mon, 06 Mar 2023 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678137868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiNtvv+D7X+t5NsYnY0rMQ0neqzEBrMG1hOuSpK1Aj0=;
        b=Hr05qOP3Lx5Hb8rtB0+K6UqPC76CzPY2INrjig69Zsxwnc17DGsBs/43mrMUDsLCP5
         LEIZwt8UluuuYxsujmhv4WQKxNMKvGupTGVOM0OXBvAM4o1RfsLx6V8kktxOMKQwhQ8F
         xQBe0qyzG7epqo0K0a2FVKfCLfz8Kbywga8cwUDngtQcO+BagN3GSkQ8ugGz/UYdQ9M0
         lJffHsKwMnUF5UlahIj1RctcshQzcgzebm8/gIegsGlUNtI3yy/Vg1GS49VCdVIX8ToL
         ijS5g4ZblhrSvktMYcHBGDbfz7SUBY0eG4F33BA2pjrQ7xZV6fnqQEZ3r+wRDDkFfK8r
         BlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678137868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiNtvv+D7X+t5NsYnY0rMQ0neqzEBrMG1hOuSpK1Aj0=;
        b=jM3p1ME0YWH+mnR0ZG0LyqrhfCLaKcjQ189HgWf8Q/SDzMB1ZaBBTD+PrrqbX6lrsS
         SU0T1OGO9Rj1/H/CTiFyF9JuO68ceffMkSgG2VRxRZdcSwC8JukIl71ntbVC5KcHgUF2
         27+oZShuQx8FTiI6M/XeXfsG9Vd3qIRAWP9i7xL2ByDh/M+MdSBpzg6bc9mvOuMASVWL
         Jb/QJxgYWblwwJk560xJWQt3LAFPOiLrFjUWr3b2Zrs9+wlz+wBTfF8d+s8ezIRapGB6
         ad7y3j/0oNZwsd9L65lRqor24LbHgOM3Ac/iDTd9zD6xOUvHP7ZLDnpBF9aAeO4m/AFy
         6n/A==
X-Gm-Message-State: AO0yUKUXQfhyrsKAKiAs6qqIH3feNlmBW4fxf2hACo1zXdG7GubT0/t8
        G/b6qB3Jnlmu4rwZ3c3Ugyk=
X-Google-Smtp-Source: AK7set8Dgm9iR8Cx0CMT05iUxDZqfiIVl32bePP07mTvU7tHvEUwpPAyPsyqDMWdXKbZTcoDcyJxtQ==
X-Received: by 2002:a4a:98d1:0:b0:49f:8941:ffed with SMTP id b17-20020a4a98d1000000b0049f8941ffedmr4882878ooj.9.1678137868110;
        Mon, 06 Mar 2023 13:24:28 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:9f3:cb51:9474:db3f? ([2600:1700:2442:6db0:9f3:cb51:9474:db3f])
        by smtp.gmail.com with ESMTPSA id e20-20020a4a8f14000000b0051134f333d3sm4332527ool.16.2023.03.06.13.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 13:24:27 -0800 (PST)
Message-ID: <1886b888-a0e8-b1ee-c48a-ddbc8b5b0c63@gmail.com>
Date:   Mon, 6 Mar 2023 15:24:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     clement.leger@bootlin.com
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com>
 <20230227113150.398dcfa7@fixe.home>
 <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com>
 <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
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

On 3/6/23 02:35, clement.leger@bootlin.com wrote:
> Le 2023-03-04 00:42, Frank Rowand a écrit :
>> On 2/27/23 04:31, Clément Léger wrote:
>>> Le Mon, 27 Feb 2023 00:51:29 -0600,
>>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>>
>>>> On 1/19/23 21:02, Lizhi Hou wrote:
>>>>> This patch series introduces OF overlay support for PCI devices 
>>>>> which
>>>>> primarily addresses two use cases. First, it provides a data driven 
>>>>> method
>>>>> to describe hardware peripherals that are present in a PCI endpoint 
>>>>> and
>>>>> hence can be accessed by the PCI host. Second, it allows reuse of a 
>>>>> OF
>>>>> compatible driver -- often used in SoC platforms -- in a PCI host 
>>>>> based
>>>>> system.
>>>>>
>>>>> There are 2 series devices rely on this patch:
>>>>>
>>>>>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>>>   2) Microchip LAN9662 Ethernet Controller
>>>>>
>>>>>      Please see: 
>>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>>
>>>>
>>>>
>>>>> Normally, the PCI core discovers PCI devices and their BARs using 
>>>>> the
>>>>> PCI enumeration process. However, the process does not provide a way 
>>>>> to
>>>>> discover the hardware peripherals that are present in a PCI device, 
>>>>> and
>>>>> which can be accessed through the PCI BARs. Also, the enumeration 
>>>>> process
>>>>
>>>> I'm confused.  The PCI Configuration Header Registers should describe 
>>>> the
>>>> hardware on the PCI card.
>>>>
>>>> Ignoring case 1 above _for the moment_ (FPGA devices are a world unto
>>>> themselves, so I would like to analyze that case separately), does 
>>>> the
>>>> second device, "Microchip LAN9662 Ethernet Controller" properly 
>>>> implement
>>>> the PCI Configuration Header Registers?  What additional information 
>>>> is
>>>> needed that is not provided in those registers?
>>>
>>> Hi Frank,
>>>
>>> I guess Lizhi wanted to say that it does not provide a way to describe
>>> all the "platform" devices that are exposed by this PCI device. Which
>>> is of course the whole point of the work we are doing right now. But
>>> all the BARs are correctly described by the LAN9662 PCI card.
>>>
>>> Clément
>>
>> I remain confused.
>>
>> [RFC 00/10] add support for fwnode in i2c mux system and sfp
>> https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
>>
>>   references a PCIe driver:
>>   [2]
>> https://github.com/clementleger/linux/blob/fwnode_support/drivers/mfd/lan966x_pci_mfd.c
>>
>> So there is a PCIe driver that works.
>>
>> However, the RFC patch series was proposing adding fwnode support to
>> the driver.  My first
>> surface reading (just part of that one email, not the entire series or
>> the replies yet),
>> notes:
>>
>>   ... However, when
>>   plugged in a PCIe slot (on a x86), there is no device-tree support 
>> and
>>   the peripherals that are present must be described in some other way.
>>
>> I am assuming that the peripherals are what you mentioned above as 
>> '"platform"
>> devices'.  This is where my current confusion lies.  Are the "platform"
>> devices accessed via the PCI bus or is there some other electrical 
>> connection
>> between the host system and the PCIe card?
> 
> Hi Frank,
> 
> The platform devices exposed by this PCIe card are available via some 
> BAR using PCI memory mapped areas, so it's totally standard PCI stuff.
> 
>>
>> If the "platform" devices are accessed via the PCI bus, then I would 
>> expect them
>> to be described by PCI configuration header registers.  Are the PCI
>> configuration
>> registers to describe the "platform" devices not present?
> 
> I'm not sure to understand what you mean here. PCI configuration headers
> only provides some basic registers allowing to identify the PCI device
> (vendor/product) and some memory areas that are exposed (BAR). They do
> not provides the "list" of peripherals that are exposed by the devices,
> only some BARs that can be mapped and that allows to access.

Yes, "identify the PCI device (vendor/product) and some memory areas".
The driver for the (vendor/product) 'knows' what peripherals are exposed
by the device and where within the BAR to find the registers for each
of the devices.

A normal PCI driver would contain this information.  If I understand the
proposal of this patch series, of_pci_make_dev_node() adds a node to
the devicetree, when invoked via a PCI quirk for certain specific
vendor/product cards.  This node must exist for the flattened device
tree (FDT) overlay for the card to be loaded.  The driver for the card
will get the overlay FDT from the card and load it into the kernel.
The driver will use the information that then exists in the devicetree
describing the card, instead of using information from the PCI configuration
headers from the card.

The intent is to be able to re-use devicetree based drivers instead of
having the driver be a native PCI driver.

This goes against historical Linux practice.  The idea of taking a driver
from another environment (eg Windows, HP Unix, Sun Unix, IBM Unix, etc)
and adding a shim layer to translate between Linux and the other
environment has been rejected.  Ironically, in this case, the other
environment is Linux (more specifically the Linux OF implementation).
Even thought the other environment is Linux, this is still adding a
shim layer to translate between that other environment and the native
Linux PCI environment for which the driver would normally be written.

In other words, this is not acceptable.  Normal alternatives would be
something like (1) add the PCI awareness to the existing drivers,
(2) split the devicetree aware and PCI aware portions of the driver
to common code that would be invoked from separate devicetree and PCI
drivers, (3) write entirely separate devicetree and PCI drivers, or
(4) some other creative solution.

Am I mis-interpretting or misunderstanding anything crucial here?

-Frank

> 
> In the case of the lan9662 cnetwork controller, BAR 0 and 1 exposes
> multiples devices that are located at some subranges of this BAR. For
> instance (not accurate), we have the I2C controller located at BAR 0
> + offset 0X1000, then the flexcom controller exposed in BAR 0 at offset
>   0x20000, etc. This list of peripheral is not exposed at all by the PCI
> configuration headers (since it is not the purpose of course). All of
> these peripherals have already existing platform drivers which can then
> be reused thanks to the PCI device-tree overlay series.
> 
>>
>> I'll read through the fwnode RFC thread to add to see what happened to
>> the proposal.
> 
> You can probably read the cover letter which described the use case in 
> details. However, don't spend too much time reading the patchset, we
> discarded them for many good reason (way too much modifications in
> subsystems, no standardization of software node bindings, etc).
> 
> Clément
> 

