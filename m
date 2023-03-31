Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9006D2A71
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 23:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjCaV4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 17:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjCaV4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 17:56:42 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835324ACD;
        Fri, 31 Mar 2023 14:56:05 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54606036bb3so274807147b3.6;
        Fri, 31 Mar 2023 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680299764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7HRQr8w2hf6U/zowNiMuUr4QUdVHcRUrc81SgNzxZg=;
        b=j+c/TtYz6uIGVrC1nUPjqZAVKtOmilkwgjlBCWus/pGWuGUb7Knd34Rpi0rkNpyunn
         KCeq9K9peM449F76zvXZPdjdp+5BtLHWyL1rfcGKPWiwU0PGRvs6ue8MrnuaTIrb0Xql
         HIL9YDWNucTtBf0oNpXCkMVvgdDkthrAEE5wh/r977Tyasl1XZPadxfqNNDcN8yLWMFj
         9H83+M9dp/EtK87lChy6tr41bJYjiaKsLIfgHE9/XO7UbVjv47FS7dGyxNdkD+M6Fouy
         hS8WhZzDCgGf4ix/6XexY7Ylyzj+hAQXTELzY3XMNozjra9qoD8nG/NOKsrrY0Y4Ddr6
         htKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680299764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7HRQr8w2hf6U/zowNiMuUr4QUdVHcRUrc81SgNzxZg=;
        b=rXx5jA0OYsBrc2A/YQij5jHcFbNEx2xMHFDbXx12u9KrmLlDu7aZg2J8IXRdRfnCeB
         lajp2rRyL6zFTk8/kXNaQhGB29qDZoyPjGuTxkQgW9bF2RWpCjeBGNVwUbvMD/3NSPLv
         VHeIO2+mDaJwip0GPbzx+r7tEXOGSLaYgQxasc8evzynv0mXd2fvirO/57jWg7sBUPFd
         GNo4/JW4LAbB/zFP/w2hySTYyaHgw87SUBhIKhIgrcGnkYuPFQoHOSgBe4Yj76sRneqm
         BIjS3N9Wtn0U2Ih2MQMJvRkQFDfDnDbYjfYHvZ94sYMa6QwOzhyu6+7ilm5d7qiHN7eF
         kEag==
X-Gm-Message-State: AAQBX9ek893P+kMppewAECwn5nmqam0shescDVGWfGqDGiRXPBNAHu/q
        WwWW6t9sKk8JSf0+akI3bfw=
X-Google-Smtp-Source: AKy350ZmKjNWZmeQTp6FuTrc+LN4Jq8iZyPoPomR0hqzFRc0hv0Bl0ab1ZtQaFiOUA4LQz06d3bCtQ==
X-Received: by 2002:a0d:cc50:0:b0:544:cbd3:76fb with SMTP id o77-20020a0dcc50000000b00544cbd376fbmr25798968ywd.27.1680299763898;
        Fri, 31 Mar 2023 14:56:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:71ba:9450:b500:725c? ([2600:1700:2442:6db0:71ba:9450:b500:725c])
        by smtp.gmail.com with ESMTPSA id z135-20020a814c8d000000b00545a08184adsm784357ywa.61.2023.03.31.14.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 14:56:03 -0700 (PDT)
Message-ID: <b2bfa57c-c82c-f9ab-100a-26aa517ede46@gmail.com>
Date:   Fri, 31 Mar 2023 16:56:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
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
 <9b4bb45a-f6e4-c95c-d27c-21c7fecb5505@gmail.com>
 <20230309094507.62d7c35e@fixe.home>
 <fed57536-cd2c-bf9b-37bc-7a653685cbf2@gmail.com>
 <CAL_JsqL+HLQVs-MoHYaVTnoNHE2DGnYZnUThp00r0vuZArwCsw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqL+HLQVs-MoHYaVTnoNHE2DGnYZnUThp00r0vuZArwCsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

This is an off the cuff response, so anything that requires me to do research
(eg because it involves stuff that I am not educated about) will be an
incomplete answer, but I don't want to delay the discussion too much in
the meantime.

On 3/30/23 10:19, Rob Herring wrote:
> On Wed, Mar 29, 2023 at 11:51 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 3/9/23 02:45, Clément Léger wrote:
>>> Le Wed, 8 Mar 2023 01:31:52 -0600,
>>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>>
>>>> On 3/6/23 18:52, Rob Herring wrote:
>>>>> On Mon, Mar 6, 2023 at 3:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>
>>>>
>>>> < snip >
>>>>
>>>> Hi Rob,
>>>>
>>>> I am in no position to comment intelligently on your comments until I
>>>> understand the SoC on PCI card model I am asking to be described in
>>>> this subthread.
>>>
>>> Hi Frank,
>>>
>>> Rather than answering all of the assumptions that were made in the upper
>>> thread (that are probably doing a bit too much of inference), I will
>>> re-explain that from scratch.
>>
>> Thanks!  The below answers a lot of my questions.
>>>
>>> Our usecase involves the lan966x SoCs. These SoCs are mainly targeting
>>> networking application and offers multiple SFP and RGMII interfaces.
>>> This Soc can be used in two exclusive modes (at least for the intended
>>> usage):
>>>
>>> SoC mode:
>>>    The device runs Linux by itself, on ARM64 cores included in the
>>>    SoC. This use-case of the lan966x is currently almost upstreamed,
>>>    using a traditional Device Tree representation of the lan996x HW
>>>    blocks [1] A number of drivers for the different IPs of the SoC have
>>>    already been merged in upstream Linux (see
>>>    arch/arm/boot/dts/lan966x.dtsi)
>>>
>>> PCI mode:
>>>   The lan966x SoC is configured as a PCIe endpoint (PCI card),
>>>   connected to a separate platform that acts as the PCIe root complex.
>>>   In this case, all the IO memories that are exposed by the devices
>>>   embedded on this SoC are exposed through PCI BARs 0 & 1 and the ARM64
>>>   cores of the SoC are not used. Since this is a PCIe card, it can be
>>>   plugged on any platform, of any architecture supporting PCIe.
>>>
>>> This work only focus on the *PCI mode* usage. In this mode, we have the
>>> following prerequisites:
>>> - Should work on all architectures (x86, ARM64, etc)
>>> - Should be self-contained in the driver
>>
>>> - Should be able to reuse all existing platform drivers
>>
>> I've said before (in different words) that using an existing platform
>> driver for hardware on a PCI card requires shims, which have been
>> strongly rejected by the Linux kernel.
> 
> Do you have an example of what you are saying has been rejected
> because I have no clue what you are referring to?

Ancient history.  Using windows drivers, proprietary unix drivers, etc
in the Linux kernel.  Is that enough to make clear what I'm talking about,
or do I need to provide specific pointers?

> 
> The kernel already has a way to divide up a PCI device into multiple
> non-PCI sub-drivers. It's auxiliary_bus. Is that not a "shim"? So why
> not use that? From the docs:

I don't know auxiliary_bus, so my response here is iffy.  But from what
you describe here, auxiliary_bus sounds like a potential fit.

> 
>  * A key requirement for utilizing the auxiliary bus is that there is no
>  * dependency on a physical bus, device, register accesses or regmap support.
>  * These individual devices split from the core cannot live on the platform bus
>  * as they are not physical devices that are controlled by DT/ACPI.  The same
>  * argument applies for not using MFD in this scenario as MFD relies on
>  * individual function devices being physical devices.
> 
> 
> In the usecases here, they are physical devices because it's the same
> devices when Linux is running on the SoC.
> 
>>>
>>> In PCI mode, the card runs a firmware (not that it matters at all by
>>> the way) which configure the card in PCI mode at boot time. In this
>>> mode, it exposes a single PCI physical function associated with
>>> vendor/product 0x1055/0x9660. This is not a multi-function PCI device !
>>> This means that all the IO memories (peripheral memories, device
>>> memories, registers, whatever you call them) are accessible using
>>> standard readl()/writel() on the BARs that have been remapped. For
>>> instance (not accurate), in the BAR 0, we will have this kind of memory
>>> map:
>>>
>>>            BAR0
>>>    0x0 ┌───────────┐
>>>        │           │
>>>        ├───────────┤
>>>        │   Clock   │
>>>        │ controller│
>>>        ├───────────┤
>>>        │           │
>>>        ├───────────┤
>>>        │   I2C     │
>>>        │ controller│
>>>        ├───────────┤
>>>        │           │
>>>        ├───────────┤
>>>        │   MDIO    │
>>>        │ Controller│
>>>        ├───────────┤
>>>        │           │
>>>        ├───────────┤
>>>        │  Switch   │
>>>        │ Controller│
>>>        ├───────────┤
>>>        │           │
>>>        │   ...     │
>>>
>>>
>>> It also exposes either a single interrupt via the legacy interrupt
>>> (which can then be demuxed by reading the SoC internal interrupt
>>> controller registers), or multiple interrupts using MSI interrupts.
>>>
>>> As stated before, all these peripherals are already supported in SoC
>>> mode and thus, there are aleready existing platform drivers for each of
>>> them. For more information about the devices that are exposed please
>>> see link [1] which is the device-tree overlay used to describe the
>>> lan9662 card.
>>>
>>> In order to use the ethernet switch, we must configure everything that
>>> lies around this ethernet controller, here are a few amongst all of
>>> them:
>>> - MDIO bus
>>> - I2C controller for SFP modules access
>>> - Clock controller
>>> - Ethernet controller
>>> - Syscon
>>>
>>> Since all the platform drivers already exist for these devices, we
>>> want to reuse them. Multiple solutions were thought of (fwnode, mfd,
>>> ACPI, device-tree) and eventually ruled out for some of them and efforts
>>> were made to try to tackle that (using fwnode [2], device-tree [3])
>>>
>>
>>> One way to do so is to use a device-tree overlay description that is
>>> loaded dynamically on the PCI device OF node. This can be done using the
>>> various device-tree series series that have been proposed (included
>>> this one). On systems that do not provide a device-tree of_root, create
>>> an empty of_root node (see [4]). Then during PCI enumeration, create
>>> device-tree node matching the PCI tree that was enumerated (See [5]).
>>> This is needed since the PCI card can be plugged on whatever port the
>>> user wants and thus it can not be statically described using a fixed
>>> "target-path" property in the overlay.
>>
>> I understand that this is a use case and a desire to implement a
>> solution for the use case.  But this is a very non-standard model.
>> The proposal exposes a bunch of hardware beyond the pci interface
>> in a non-pci method.
> 
> It is not the proposal that exposes a bunch of hardware. This device
> exposes a bunch of hardware. As you say, it is *beyond the PCI
> interface*, so it has zero to do with PCI.
> 
> We already support non-discoverable h/w behind a PCI bus. It's called
> ISA. There's powerpc DT files in the tree with ISA devices.

Thanks for the specific example.

Off the top of my head, I suspect ISA is a very different case.  Wasn't
ISA an example of a legacy bus that was expected to disappear?  (A long
time since I have thought about ISA.)  I'm not sure whether the powerpc
DT files with ISA devices is a good argument here or not - I would have
to look at them

> 
>> No, just no.  Respect the pci interface boundary and do not drag
>> devicetree into an effort to pierce and straddle that boundary
>> (by adding information about the card, beyond the PCI controller,
>> into the system devicetree).  Information about dynamically
>> discoverable hardware does not belong in the devicetree.
> 
> What is discoverable? Nothing more than a VID/PID.
> 
> Your suggestion is simply use the VID/PID(s) and then the PCI driver
> for the card will have all the details that implies. There's a name
> for that: board files. Just like we had a single machine ID per board

No, IMHO it is most definitely not analogous to board files.

Board files were a mix of configuration information and description
of hardware that was non-discoverable.  The hardware present could
vary quite a bit between different boards within a family.  PCI
device drivers have been able to contain the information needed to
access the PCI device, and to handle variations between versions
of the board during the board's evolving life.

> registered with RMK and the kernel had to contain all the
> configuration details for each machine ID. It's not just 1 card here.
> This is a chip and I imagine what's used or not used or how the
> downstream peripherals are configured all depend on the customer and
> their specific designs.

You are saying that this is a universal board, that will be used
different ways by different customers?

This is one of the things I've been trying to get explained (eg
why I've asked for a high level data sheet).  The use case as
presented in this patch series if for a specific PCI card that
has an SoC on it that can provide network functionality.  My
guess would be that the card has one of more physical network
connectors that make the board useful in a larger system.  The
SoC potentially has a lot of other functionality that could be
used if the proper physical connectors exist, but I don't know
because the information has not been provided. It has been
asserted that other logic blocks on the SoC need to be controlled
by other existing platform drivers - but is that because they
are needed to best use the network functionality (eg, as a
theoretical example, is some power management control desired
so the board doesn't consume excess power when the network is
idle).

> 
> If DT is not used here, then swnodes (DT bindings embedded in the
> kernel or platform_data 2.0) will be. It's exactly the same structure
> in the kernel. It's still going to be non-PCI drivers for all the sub
> devices. The change in the drivers will not be making them PCI
> drivers, but simply converting DT APIs to fwnode APIs which is
> pointless churn IMO.

Why can't there be PCI drivers for devices on the PCI board?

Why add all the complexity of doing an impedance conversion to
make a device on a PCI card look like it is on the system bus
(in other words, the driver uses the DT description and APIs
as if the device was located on a system bus instead of being
on the other side of the PCI socket)?

> 
> Finally, let's not forget the FPGA usecase. We already support DT
> overlays for FPGAs. The fact that the FPGA sits behind a PCI interface
> is pretty much irrelevant to the problem. There is simply no way the

I consider the PCI interface to be a big deal.  Whether for an FPGA
or for an SoC on a PCI card.

The PCI socket (or cable) insulates all hardware on the PCI card from
the host system.  The PCI controller "driver" is aware of details of
the host system (eg will have to arrange for system interrupts used
to implement the PCI interrupts), but PCI drivers do not manage
those details - they deal with PCI concepts (eg PCI interrupts).

Everything I've said above may be a little cloudy and incomplete.  That
could reflect lack of knowledge on my part and/or incomplete information
about the need and the use case.  I've clearly been struggling with
trying to understand the proposal, the architecture, and the mental
model involved.  It has been asserted that I don't need to dig into
the previous rejected alternative approaches, but I suspect that not
having done so is contributing to my confusion.

> kernel is going to contain information about what's within the FPGA
> image. If not DT, how should we communicate the FPGA configuration to
> the kernel?

If the FPGA creates and exposes non-discoverable devices on the system
busses (not behind the PCI socket boundary) then DT seems reasonable.
If overlays, then preferably static overlays that can be applied by
the bootloader before the kernel boots.  (Yes, I understand how restrictive
and unpopular that is for the FPGA community, but that also does not
negate the fact that overlay support has never been properly completed
for generic use.)

I don't want to re-debate the whole FPGA discussion. For this patch
series I have been trying to narrow the discussion to the SoC on a
PCI board issue.  I'm trying to either find a solution for the
SoC on a PCI board or not accept non-solutions for that.

> 
> Rob

