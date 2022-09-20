Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C05BDABA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 05:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiITDOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 23:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiITDOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 23:14:52 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5B6584;
        Mon, 19 Sep 2022 20:14:50 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id h5so730790vkc.5;
        Mon, 19 Sep 2022 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3tC17ydEXE0ipwLhiejx78Ifh9gVJNR3v+BzRu0I5bM=;
        b=DALbMkaENjnsC0pqm0faDU0vDIkCtkMpDPhtStJjc5nTxsFe1sBT1o3bHATmhBL3ro
         WABdpIS/VbokU+7KfgVFAqwPBgmtNgemC5n2zY6hHn+nxj0fIA6nXYMbInP5ppMiEup8
         T35SL0YPx3L9R3hCmaQXRPyWPsHsZyRCoagbY5WbP9JRgaxTyBCF7ISFj7VVsYVUmdBN
         UyRmjoK15E9GsUkd1juUJ6JZHozeqUP5r8Uw61Ak96UQrzyS+qmizeY3ca2E8/LVEoyn
         mH1g5WoVyIoKZ2c8FOjoiMCyffc4JdD6zqp1U5cijUvldeb3EDF3mndKRS4MzFy/qNuZ
         d99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3tC17ydEXE0ipwLhiejx78Ifh9gVJNR3v+BzRu0I5bM=;
        b=geK07su8YGGf+DmVDsUB3XA9wVQjjTj/gCjrrdbR9JttyQPLIfs2r736ciHO6QXsbJ
         1FrYWkgN+iOJgzIwxBrnrM5XXQCj0f8av0WTULrgFCDztctTn/4fHlgLZR+mAndgV85H
         MXE1zfHlTBji6KsMprx4GjpTVl+f+IG/WS9zekdPeIEOFf/wFdfQ//8785mSEVN+ms1V
         b46E/zR+zZI8ERZhfMJDBwIPYtNV8vu+7rsEOkoTinp6ySzf8CsSp0pn2c+MQ5eQXEha
         swTciO/5aGIGlg6dvHQBePc+Bk4sf/dWYVmroOqsn59psfSD/llMWnTdVPr/roYaCg9z
         eYaQ==
X-Gm-Message-State: ACrzQf0V4f42Yo5kQriWD+/UwipTHAjEz3Q6w/Qw0puaMi3e+xIxXCY+
        YkNPeUvbuQezdAZkmt+ffkc=
X-Google-Smtp-Source: AMsMyM5AUhQTxxtBBRh1nR+MZ7B/Beo0k/NE74dw5FrUJC/GWrTduZB7Tyn1h0B7edfrE1CGA6G7cg==
X-Received: by 2002:a1f:4397:0:b0:39e:8f5b:a2a7 with SMTP id q145-20020a1f4397000000b0039e8f5ba2a7mr7131865vka.26.1663643688986;
        Mon, 19 Sep 2022 20:14:48 -0700 (PDT)
Received: from [192.168.1.140] ([65.35.200.237])
        by smtp.gmail.com with ESMTPSA id v12-20020a67af0c000000b0039807c3161asm67172vsl.18.2022.09.19.20.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 20:14:48 -0700 (PDT)
Message-ID: <2c3743cc-f29b-6cc9-d6b8-992cca69b60f@gmail.com>
Date:   Mon, 19 Sep 2022 22:12:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@amd.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, helgaas@kernel.org
Cc:     clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
 <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
 <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
 <8bee1ddd-0a84-62cd-9beb-3bbb09d83de1@amd.com>
 <f042a8d7-fa2b-3e75-a2f2-6e6ba28a9b38@gmail.com>
 <7393f2f3-3af5-edf9-4afb-8acc0a8db1e7@redhat.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <7393f2f3-3af5-edf9-4afb-8acc0a8db1e7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/17/22 13:36, Tom Rix wrote:
> Frank,
> 
> On 9/16/22 7:23 PM, Frank Rowand wrote:
>> On 9/13/22 16:02, Lizhi Hou wrote:
>>> On 9/13/22 10:41, Frank Rowand wrote:
>>>> On 9/13/22 12:10, Lizhi Hou wrote:
>>>>> On 9/13/22 00:00, Frank Rowand wrote:
>>>>>> On 8/29/22 16:43, Lizhi Hou wrote:
>>>>>>> This patch series introduces OF overlay support for PCI devices which
>>>>>>> primarily addresses two use cases. First, it provides a data driven method
>>>>>>> to describe hardware peripherals that are present in a PCI endpoint and
>>>>>>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
>>>>>>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
>>>>>>> driver -- often used in SoC platforms -- in a PCI host based system. An
>>>>>>> example device is Microchip LAN9662 Ethernet Controller.
>>>>>>>
>>>>>>> This patch series consolidates previous efforts to define such an
>>>>>>> infrastructure:
>>>>>>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
>>>>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>>>>
>>>>>>> Normally, the PCI core discovers PCI devices and their BARs using the
>>>>>>> PCI enumeration process. However, the process does not provide a way to
>>>>>>> discover the hardware peripherals that are present in a PCI device, and
>>>>>>> which can be accessed through the PCI BARs. Also, the enumeration process
>>>>>>> does not provide a way to associate MSI-X vectors of a PCI device with the
>>>>>>> hardware peripherals that are present in the device. PCI device drivers
>>>>>>> often use header files to describe the hardware peripherals and their
>>>>>>> resources as there is no standard data driven way to do so. This patch
>>>>>>> series proposes to use flattened device tree blob to describe the
>>>>>>> peripherals in a data driven way. Based on previous discussion, using
>>>>>>> device tree overlay is the best way to unflatten the blob and populate
>>>>>>> platform devices. To use device tree overlay, there are three obvious
>>>>>>> problems that need to be resolved.
>>>>>>>
>>>>>>> First, we need to create a base tree for non-DT system such as x86_64. A
>>>>>>> patch series has been submitted for this:
>>>>>>> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
>>>>>>> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
>>>>>>>
>>>>>>> Second, a device tree node corresponding to the PCI endpoint is required
>>>>>>> for overlaying the flattened device tree blob for that PCI endpoint.
>>>>>>> Because PCI is a self-discoverable bus, a device tree node is usually not
>>>>>>> created for PCI devices. This series adds support to generate a device
>>>>>>> tree node for a PCI device which advertises itself using PCI quirks
>>>>>>> infrastructure.
>>>>>>>
>>>>>>> Third, we need to generate device tree nodes for PCI bridges since a child
>>>>>>> PCI endpoint may choose to have a device tree node created.
>>>>>>>
>>>>>>> This patch series is made up of two patches.
>>>>>>>
>>>>>>> The first patch is adding OF interface to allocate an OF node. It is copied
>>>>>>> from:
>>>>>>> https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/
>>>>>>>
>>>>>>> The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
>>>>>>> is turned on, the kernel will generate device tree nodes for all PCI
>>>>>>> bridges unconditionally. The patch also shows how to use the PCI quirks
>>>>>>> infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
>>>>>>> a device. Specifically, the patch generates a device tree node for Xilinx
>>>>>>> Alveo U50 PCIe accelerator device. The generated device tree nodes do not
>>>>>>> have any property. Future patches will add the necessary properties.
>>>>>>>
>>>>>>> Clément Léger (1):
>>>>>>>      of: dynamic: add of_node_alloc()
>>>>>>>
>>>>>>> Lizhi Hou (1):
>>>>>>>      pci: create device tree node for selected devices
>>>>>>>
>>>>>>>     drivers/of/dynamic.c        |  50 +++++++++++++----
>>>>>>>     drivers/pci/Kconfig         |  11 ++++
>>>>>>>     drivers/pci/bus.c           |   2 +
>>>>>>>     drivers/pci/msi/irqdomain.c |   6 +-
>>>>>>>     drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>>>>>>>     drivers/pci/pci-driver.c    |   3 +-
>>>>>>>     drivers/pci/pci.h           |  16 ++++++
>>>>>>>     drivers/pci/quirks.c        |  11 ++++
>>>>>>>     drivers/pci/remove.c        |   1 +
>>>>>>>     include/linux/of.h          |   7 +++
>>>>>>>     10 files changed, 200 insertions(+), 13 deletions(-)
>>>>>>>
>>>>>> The patch description leaves out the most important piece of information.
>>>>>>
>>>>>> The device located at the PCI endpoint is implemented via FPGA
>>>>>>       - which is programmed after Linux boots (or somewhere late in the boot process)
>>>>>>          - (A) and thus can not be described by static data available pre-boot because
>>>>>>                it is dynamic (and the FPGA program will often change while the Linux
>>>>>>                kernel is already booted
>>>>>>          - (B) can be described by static data available pre-boot because the FPGA
>>>>>>                program will always be the same for this device on this system
>>>>>>
>>>>>> I am not positive what part of what I wrote above is correct and would appreciate
>>>>>> some confirmation of what is correct or incorrect.
>>>>> There are 2 series devices rely on this patch:
>>>>>
>>>>>       1) Xilinx Alveo Accelerator cards (FPGA based device)
>>>>>
>>>>>       2) lan9662 PCIe card
>>>>>
>>>>>             please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>> Thanks.  Please include this information in future versions of the patch series.
>>>>
>>>> For device 2 I have strongly recommended using pre-boot apply of the overlay to the base
>>>> device tree.  I realize that this suggestion is only a partial solution if one wants to
>>>> use hotplug to change system configuration (as opposed to using hotplug only to replace
>>>> an existing device (eg a broken device) with another instance of the same device).  I
>>>> also realize that this increased the system administration overhead.  On the other hand
>>>> an overlay based solution is likely to be fragile and possibly flaky.
>>> Can you clarify the pre-boot apply approach? How will it work for PCI devices?
>>>>> For Xilinx Alveo device, it is (A). The FPGA partitions can be programmed dynamically after boot.
>>>> I looked at the Xilinx Alveo web page, and there are a variety of types of Alveo cards
>>>> available.  So the answer to my next question may vary by type of card.
>>>>
>>>> Is it expected that the fpga program on a given card will change frequently (eg multiple
>>>> times per day), where the changed program results in a new device that would require a
>>>> different hardware description in the device tree?
>>> Different images may be loaded to a FPGA partition several times a
>>> day. The PCI topology (Device IDs, BARs, MSIx, etc) does not change.
>>> New IPs may appear (and old IPs may disappear) on the BARs when a new
>>> image is loaded. We would like to use flattened device tree to
>>> describe the IPs on the BARs.
>> That was kind of a non-answer.  I know that images _may_ change at
>> some frequency.  I was trying to get a sense of whether the images
>> were _likely_ to be changing on a frequent basis for these types
>> of boards, or whether frequent image changes are likely to be a
>> rare edge use case.
>>
>> If there is a good design for the 99.999% use case that does not
>> support the 0.001% use case then it may be better to not create
>> an inferior design that also supports the 0.001% use case.
>>
>> I hope that gives a better idea of the reason why I was asking the
>> question and how the answer could impact design and implementation
>> decisions.
>>
>> As a point of reference, some other fpga users have indicated a
>> desire to change images many times per second.  The current driver
>> and overlay architecture did not seem to me to be a good match to
>> that use case (depending on the definition of "many").
> 
> I would rather we cover 99.999% now.
> 
> My understanding is that the subdevices are flexible but fairly
> static and the frequency Lizhi mentions would cover development
> uses.
> 
> In production I would expect the image to change about once a year
> with the same order of magnitude as firmware.

Thanks for this info, it helps a lot.

> 
> Can you point me to a reference of a user case with high frequency
> images changing that also depends on pci io device changing?

I actually don't have references to any previous PCI devices that are
based on FPGAs, let alone with a high frequency of images changing.

The Alveo devices are the first such devices that have come to my
attention.  Note that this is a technology space that I do not
follow, so my lack of awareness does not mean much.

I do not remember the specific discussion that was asserting or
desiring a high frequency of image changes for an FPGA.  The
current overlay architecture and overall device tree architecture
would not handle this well and/or robustly because (off the top of
my head, hopefully I'm getting this correct) the live system device
tree does not directly contain all of the associated data - some of
it is contained in the unflattened device tree (FDT) that remains in
memory after unflattening, both in the case of the base system device
tree and overlay device trees.  Some of the device tree data APIs return
pointers to this data in the FDT.  And the API does not provide reference
counting for the data (just reference counting for nodes - and these
reference counts are know to be frequently incorrect).

In general I have very little visibility into the FPGA space so I go
out of my way to notify them before making changes to the overlay
implementation, API, etc; listen carefully to their input; and give
them lots of opportunity to test any resulting changes.

-Frank

> 
> Tom
> 
>> -Frank
>>
>>> Thanks,
>>>
>>> Lizhi
>>>
>>>> Or is the fpga program expected to change on an infrequent basis (eg monthly, quarterly,
>>>> annually), in the same way as device firmware and operating systems are updated on a regular
>>>> basis for bug fixes and new functionality?
>>>>
>>>>
>>>>> Thanks,
>>>>>
>>>>> Lzhi
>>>>>
>>>>>> -Frank
> 

