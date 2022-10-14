Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426DB5FF556
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 23:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJNV0Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Oct 2022 17:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiJNV0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2022 17:26:02 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9701DDDE8;
        Fri, 14 Oct 2022 14:25:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n73so4892607iod.13;
        Fri, 14 Oct 2022 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrHfWhczEEpqsCUBVH2cJEFByigL6NOzIXD0VOHI3so=;
        b=IXq3Ke1yZxhKizTUy3mKAy11g0ZFMIWBOLwCeviB1MrQZazqKrDsEf48eOFfRT0gAs
         LPm//H420xr+0aKhOaRejuEe9p1ycqaPp8gumvYk0rbCX+TQ5bzwJAs6/cbJ8+d1did+
         gicB/a/9hmhIcR4+r9bHYEnB6WsSE7OISX96BTsGRuAc0wNdg8xxT8y0st7u9Agxt7TI
         tmv7d55si335KyCkp2aniNkddhCF8o76UUjMBBxzORTNqN3xHnZYmZ2Fn4LOTxa55vA0
         G/JPsRaZPfhSHhyJl+0FffQKjIAt3XVzbP8vcaM7qQ/JwHrWNtgl+5I9uzhoVL9lZESm
         /JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrHfWhczEEpqsCUBVH2cJEFByigL6NOzIXD0VOHI3so=;
        b=YMYV2ZIs/dX+CZnBtScwIHoabRHu0PaKXWBVUSWaPnp3yBiocSM9TrMlzXjKKTVUS9
         EsefmJE4OuETG5O1/A5l8m6H8q7tTgSsF64URivEwlL9cgzReCDmXa5xTU4S/DCFjIOM
         +eYM8sxsRN8EX+8qekcZ36qaLiz+z2/tzr4ERaTMbX6OjkXuLPTKZSnfHtCMqvaTFCuw
         JVVz9rL1DuAcu7CsqzhnygVjO5UQEMNq0SLSrlAXMuhQCc3Uaov5++h1FNkpgJbDqgdJ
         fB5TCtPObvDs5jSbgGtpj0r1rpg/jZRg6ZcGqeUa+CtvKL3FVHvoYOIkRc6Osx6GyEcO
         /axA==
X-Gm-Message-State: ACrzQf0Iu1sVy258eNq1117dstPKNPpE2UmKhWfsfpAmEtLF+NwMFP03
        OAaRLpnNFacETs+LtF0Thws=
X-Google-Smtp-Source: AMsMyM58ehDtG85T/+NTTK96ZeX1K8xuZf/v5x5fRn+30egUQ5voGegsdcKL3uQ5DRfzuvfAY67nkw==
X-Received: by 2002:a05:6638:1314:b0:363:b321:8721 with SMTP id r20-20020a056638131400b00363b3218721mr3985180jad.271.1665782729694;
        Fri, 14 Oct 2022 14:25:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:b45a:72e4:d631:1b4c? ([2600:1700:2442:6db0:b45a:72e4:d631:1b4c])
        by smtp.gmail.com with ESMTPSA id p12-20020a5ecb0c000000b006bc039e3224sm1316848iom.17.2022.10.14.14.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 14:25:29 -0700 (PDT)
Message-ID: <68ebf651-227a-1886-957e-2644e4130cb5@gmail.com>
Date:   Fri, 14 Oct 2022 16:25:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Content-Language: en-US
To:     Sonal Santan <sonal.santan@amd.com>, Tom Rix <trix@redhat.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org
Cc:     clement.leger@bootlin.com, max.zhen@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, stefano.stabellini@xilinx.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
 <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
 <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
 <8bee1ddd-0a84-62cd-9beb-3bbb09d83de1@amd.com>
 <f042a8d7-fa2b-3e75-a2f2-6e6ba28a9b38@gmail.com>
 <7393f2f3-3af5-edf9-4afb-8acc0a8db1e7@redhat.com>
 <2c3743cc-f29b-6cc9-d6b8-992cca69b60f@gmail.com>
 <40d45c78-d365-f3b4-43bb-c3b5dd6a11ec@amd.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <40d45c78-d365-f3b4-43bb-c3b5dd6a11ec@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/25/22 22:03, Sonal Santan wrote:
> On 9/19/22 20:12, Frank Rowand wrote:
>> On 9/17/22 13:36, Tom Rix wrote:
>>> Frank,
>>>
>>> On 9/16/22 7:23 PM, Frank Rowand wrote:
>>>> On 9/13/22 16:02, Lizhi Hou wrote:
>>>>> On 9/13/22 10:41, Frank Rowand wrote:
>>>>>> On 9/13/22 12:10, Lizhi Hou wrote:
>>>>>>> On 9/13/22 00:00, Frank Rowand wrote:
>>>>>>>> On 8/29/22 16:43, Lizhi Hou wrote:
>>>>>>>>> This patch series introduces OF overlay support for PCI devices which
>>>>>>>>> primarily addresses two use cases. First, it provides a data driven method
>>>>>>>>> to describe hardware peripherals that are present in a PCI endpoint and
>>>>>>>>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
>>>>>>>>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
>>>>>>>>> driver -- often used in SoC platforms -- in a PCI host based system. An
>>>>>>>>> example device is Microchip LAN9662 Ethernet Controller.
>>>>>>>>>
>>>>>>>>> This patch series consolidates previous efforts to define such an
>>>>>>>>> infrastructure:
>>>>>>>>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
>>>>>>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>>>>>>
>>>>>>>>> Normally, the PCI core discovers PCI devices and their BARs using the
>>>>>>>>> PCI enumeration process. However, the process does not provide a way to
>>>>>>>>> discover the hardware peripherals that are present in a PCI device, and
>>>>>>>>> which can be accessed through the PCI BARs. Also, the enumeration process
>>>>>>>>> does not provide a way to associate MSI-X vectors of a PCI device with the
>>>>>>>>> hardware peripherals that are present in the device. PCI device drivers
>>>>>>>>> often use header files to describe the hardware peripherals and their
>>>>>>>>> resources as there is no standard data driven way to do so. This patch
>>>>>>>>> series proposes to use flattened device tree blob to describe the
>>>>>>>>> peripherals in a data driven way. Based on previous discussion, using
>>>>>>>>> device tree overlay is the best way to unflatten the blob and populate
>>>>>>>>> platform devices. To use device tree overlay, there are three obvious
>>>>>>>>> problems that need to be resolved.
>>>>>>>>>
>>>>>>>>> First, we need to create a base tree for non-DT system such as x86_64. A
>>>>>>>>> patch series has been submitted for this:
>>>>>>>>> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
>>>>>>>>> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
>>>>>>>>>
>>>>>>>>> Second, a device tree node corresponding to the PCI endpoint is required
>>>>>>>>> for overlaying the flattened device tree blob for that PCI endpoint.
>>>>>>>>> Because PCI is a self-discoverable bus, a device tree node is usually not
>>>>>>>>> created for PCI devices. This series adds support to generate a device
>>>>>>>>> tree node for a PCI device which advertises itself using PCI quirks
>>>>>>>>> infrastructure.
>>>>>>>>>
>>>>>>>>> Third, we need to generate device tree nodes for PCI bridges since a child
>>>>>>>>> PCI endpoint may choose to have a device tree node created.
>>>>>>>>>
>>>>>>>>> This patch series is made up of two patches.
>>>>>>>>>
>>>>>>>>> The first patch is adding OF interface to allocate an OF node. It is copied
>>>>>>>>> from:
>>>>>>>>> https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/
>>>>>>>>>
>>>>>>>>> The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
>>>>>>>>> is turned on, the kernel will generate device tree nodes for all PCI
>>>>>>>>> bridges unconditionally. The patch also shows how to use the PCI quirks
>>>>>>>>> infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
>>>>>>>>> a device. Specifically, the patch generates a device tree node for Xilinx
>>>>>>>>> Alveo U50 PCIe accelerator device. The generated device tree nodes do not
>>>>>>>>> have any property. Future patches will add the necessary properties.
>>>>>>>>>
>>>>>>>>> Clément Léger (1):
>>>>>>>>>       of: dynamic: add of_node_alloc()
>>>>>>>>>
>>>>>>>>> Lizhi Hou (1):
>>>>>>>>>       pci: create device tree node for selected devices
>>>>>>>>>
>>>>>>>>>      drivers/of/dynamic.c        |  50 +++++++++++++----
>>>>>>>>>      drivers/pci/Kconfig         |  11 ++++
>>>>>>>>>      drivers/pci/bus.c           |   2 +
>>>>>>>>>      drivers/pci/msi/irqdomain.c |   6 +-
>>>>>>>>>      drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>>>>>>>>>      drivers/pci/pci-driver.c    |   3 +-
>>>>>>>>>      drivers/pci/pci.h           |  16 ++++++
>>>>>>>>>      drivers/pci/quirks.c        |  11 ++++
>>>>>>>>>      drivers/pci/remove.c        |   1 +
>>>>>>>>>      include/linux/of.h          |   7 +++
>>>>>>>>>      10 files changed, 200 insertions(+), 13 deletions(-)
>>>>>>>>>
>>>>>>>> The patch description leaves out the most important piece of information.
>>>>>>>>
>>>>>>>> The device located at the PCI endpoint is implemented via FPGA
>>>>>>>>        - which is programmed after Linux boots (or somewhere late in the boot process)
>>>>>>>>           - (A) and thus can not be described by static data available pre-boot because
>>>>>>>>                 it is dynamic (and the FPGA program will often change while the Linux
>>>>>>>>                 kernel is already booted
>>>>>>>>           - (B) can be described by static data available pre-boot because the FPGA
>>>>>>>>                 program will always be the same for this device on this system
>>>>>>>>
>>>>>>>> I am not positive what part of what I wrote above is correct and would appreciate
>>>>>>>> some confirmation of what is correct or incorrect.
>>>>>>> There are 2 series devices rely on this patch:
>>>>>>>
>>>>>>>        1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>>>>>
>>>>>>>        2) lan9662 PCIe card
>>>>>>>
>>>>>>>              please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>>> Thanks.  Please include this information in future versions of the patch series.
>>>>>>
>>>>>> For device 2 I have strongly recommended using pre-boot apply of the overlay to the base
>>>>>> device tree.  I realize that this suggestion is only a partial solution if one wants to
>>>>>> use hotplug to change system configuration (as opposed to using hotplug only to replace
>>>>>> an existing device (eg a broken device) with another instance of the same device).  I
>>>>>> also realize that this increased the system administration overhead.  On the other hand
>>>>>> an overlay based solution is likely to be fragile and possibly flaky.
>>>>> Can you clarify the pre-boot apply approach? How will it work for PCI devices?
>>>>>>> For Xilinx Alveo device, it is (A). The FPGA partitions can be programmed dynamically after boot.
>>>>>> I looked at the Xilinx Alveo web page, and there are a variety of types of Alveo cards
>>>>>> available.  So the answer to my next question may vary by type of card.
>>>>>>
>>>>>> Is it expected that the fpga program on a given card will change frequently (eg multiple
>>>>>> times per day), where the changed program results in a new device that would require a
>>>>>> different hardware description in the device tree?
>>>>> Different images may be loaded to a FPGA partition several times a
>>>>> day. The PCI topology (Device IDs, BARs, MSIx, etc) does not change.
>>>>> New IPs may appear (and old IPs may disappear) on the BARs when a new
>>>>> image is loaded. We would like to use flattened device tree to
>>>>> describe the IPs on the BARs.
>>>> That was kind of a non-answer.  I know that images _may_ change at
>>>> some frequency.  I was trying to get a sense of whether the images
>>>> were _likely_ to be changing on a frequent basis for these types
>>>> of boards, or whether frequent image changes are likely to be a
>>>> rare edge use case.
>>>>
>>>> If there is a good design for the 99.999% use case that does not
>>>> support the 0.001% use case then it may be better to not create
>>>> an inferior design that also supports the 0.001% use case.
>>>>
>>>> I hope that gives a better idea of the reason why I was asking the
>>>> question and how the answer could impact design and implementation
>>>> decisions.
>>>>
>>>> As a point of reference, some other fpga users have indicated a
>>>> desire to change images many times per second.  The current driver
>>>> and overlay architecture did not seem to me to be a good match to
>>>> that use case (depending on the definition of "many").
>>>
>>> I would rather we cover 99.999% now.
>>>
>>> My understanding is that the subdevices are flexible but fairly
>>> static and the frequency Lizhi mentions would cover development
>>> uses.
>>>
>>> In production I would expect the image to change about once a year
>>> with the same order of magnitude as firmware.
>>
>> Thanks for this info, it helps a lot.
>>
>>>
>>> Can you point me to a reference of a user case with high frequency
>>> images changing that also depends on pci io device changing?
>>
>> I actually don't have references to any previous PCI devices that are
>> based on FPGAs, let alone with a high frequency of images changing.
>>
>> The Alveo devices are the first such devices that have come to my
>> attention.  Note that this is a technology space that I do not
>> follow, so my lack of awareness does not mean much.
>>
>> I do not remember the specific discussion that was asserting or
>> desiring a high frequency of image changes for an FPGA.  The
>> current overlay architecture and overall device tree architecture
>> would not handle this well and/or robustly because (off the top of
>> my head, hopefully I'm getting this correct) the live system device
>> tree does not directly contain all of the associated data - some of
>> it is contained in the unflattened device tree (FDT) that remains in
>> memory after unflattening, both in the case of the base system device
>> tree and overlay device trees.  Some of the device tree data APIs return
>> pointers to this data in the FDT.  And the API does not provide reference
>> counting for the data (just reference counting for nodes - and these
>> reference counts are know to be frequently incorrect).
>>
> Thanks for pointing out the limitations of the current overlay
> architecture. Can a careful orchestration of overlay creation and
> tear down by each driver address the limitation? 

No, that is not practical (for example, see the never ending patches
to address broken refcounting -- of_node_get() and of_node_put() usage).
Plus the overlay data in the system device tree is visible to every
driver and subsystem, not just the limited set that appear to be
related to the nodes in the overlay.

> I did see another
> user, drivers/pci/hotplug/pnv_php.c, which seems to be using the
> overlay infrastructure in this manner.

What tree is that in?  And what sections of that file?

> 
> What is your suggestion to move forward?

https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts has a large
but incomplete list of areas to be worked on.

-Frank

> 
> -Sonal
> 
>> In general I have very little visibility into the FPGA space so I go
>> out of my way to notify them before making changes to the overlay
>> implementation, API, etc; listen carefully to their input; and give
>> them lots of opportunity to test any resulting changes.
>>
>> -Frank
>>
>>>
>>> Tom
>>>
>>>> -Frank
>>>>
>>>>> Thanks,
>>>>>
>>>>> Lizhi
>>>>>
>>>>>> Or is the fpga program expected to change on an infrequent basis (eg monthly, quarterly,
>>>>>> annually), in the same way as device firmware and operating systems are updated on a regular
>>>>>> basis for bug fixes and new functionality?
>>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Lzhi
>>>>>>>
>>>>>>>> -Frank
>>>
>>
> 

