Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821176C99D2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 05:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjC0DB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Mar 2023 23:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjC0DBt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Mar 2023 23:01:49 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9665558D;
        Sun, 26 Mar 2023 20:01:40 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17683b570b8so7811556fac.13;
        Sun, 26 Mar 2023 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679886100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/ODnD91UY42Ysvog6gyqrIAdQSS1mTSw0ElJHMXsUQ=;
        b=fnNrSwJTJTEF0B70kqmJw1ENbREis1qbd5p9GmPzE1v4KQcUELgHIxtJrNha+1fqR5
         UMlCSGp604H5740+mzjN8Uo4vwU2gxuj9dghmuzXrKNYi0qfIH/czrn0yUqYo+17FiDZ
         TQ3wIfF0VUQiRE+Y+Vwo2EBEN+r4aLe/5U0HzZKAIZpNVk3nhBrudpIWwxOKla5XZxkI
         o5MxCGGCVFvK0QDQB7egcRUMXvdgWnRMqXDEQaoTiDaPjSBvlRewxqTTWP/S0WOm2Eq4
         n7ID0D6VDYdR8WO7zvuwyEO3IEqJ2RkDfe0swxXHcjoqcQHdcFbesN2QRb0rfSWDPXO4
         mjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679886100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/ODnD91UY42Ysvog6gyqrIAdQSS1mTSw0ElJHMXsUQ=;
        b=7dVQYmOiSfoy6vBQPbewLpcCaHZf+W8zf3tZGjSbhsMnwoVfatZxwJZ71EFfMiFkk1
         MJxLrF+XarFVLgPPVyRloE4/cCctkdxwKKsSCNuCNx4xvx/CmEzji/fg/GaUsNXrlGUo
         2ANgwmH40E/aP9cGBka0MoGgPlXtcla3dvTnYjieIgE5ZdxQPsqZt7vjohbUaOkIhZtZ
         5Vioep5OaPzZmAud2UvdixSojh/ZZ3y/Yf3f6u56kgbD+ITC17/vDqWjW7agZ8g0Ue5c
         br21IZmAeEyLj4Df01NiQZAEk9XFe1VLUYwRXNX2FOZe+2NhGLqiTYE9Q6OoKBJ5Nh86
         Rxug==
X-Gm-Message-State: AAQBX9ew4YKv7wfyu5+j2vMilMsn0KbiMJwdNT95kI4aBrexOdg1WzcN
        9vKAVBjCIC8e7ajQHwKgItM=
X-Google-Smtp-Source: AK7set/4eDYG1uEuvh2RsElDMslo5k4epLRJSOnyys22BmZJTqrLzLKk3XBWac/gx9pQGS52dIrLQQ==
X-Received: by 2002:a05:6870:40d2:b0:177:c6f2:a74b with SMTP id l18-20020a05687040d200b00177c6f2a74bmr6693499oal.1.1679886100067;
        Sun, 26 Mar 2023 20:01:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:988b:7dda:764e:c744? ([2600:1700:2442:6db0:988b:7dda:764e:c744])
        by smtp.gmail.com with ESMTPSA id l26-20020a0568301d7a00b0069fa776d3c2sm4932048oti.18.2023.03.26.20.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 20:01:39 -0700 (PDT)
Message-ID: <a14f6e0d-88fe-4c38-0489-a9d2d97ef307@gmail.com>
Date:   Sun, 26 Mar 2023 22:01:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
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
 <9b4bb45a-f6e4-c95c-d27c-21c7fecb5505@gmail.com>
 <20230309094507.62d7c35e@fixe.home>
 <CAH9NwWfvXjY8=OFesytZ1HAM-wBJ=tNB8wAkP99JLw=inYJJgg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAH9NwWfvXjY8=OFesytZ1HAM-wBJ=tNB8wAkP99JLw=inYJJgg@mail.gmail.com>
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

On 3/21/23 03:44, Christian Gmeiner wrote:
> Hi all
> 
> Am Do., 9. März 2023 um 09:52 Uhr schrieb Clément Léger
> <clement.leger@bootlin.com>:
>>
>> Le Wed, 8 Mar 2023 01:31:52 -0600,
>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>
>>> On 3/6/23 18:52, Rob Herring wrote:
>>>> On Mon, Mar 6, 2023 at 3:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>
>>>
>>> < snip >
>>>
>>> Hi Rob,
>>>
>>> I am in no position to comment intelligently on your comments until I
>>> understand the SoC on PCI card model I am asking to be described in
>>> this subthread.
>>
>> Hi Frank,
>>
>> Rather than answering all of the assumptions that were made in the upper
>> thread (that are probably doing a bit too much of inference), I will
>> re-explain that from scratch.
>>
>> Our usecase involves the lan966x SoCs. These SoCs are mainly targeting
>> networking application and offers multiple SFP and RGMII interfaces.
>> This Soc can be used in two exclusive modes (at least for the intended
>> usage):
>>
>> SoC mode:
>>    The device runs Linux by itself, on ARM64 cores included in the
>>    SoC. This use-case of the lan966x is currently almost upstreamed,
>>    using a traditional Device Tree representation of the lan996x HW
>>    blocks [1] A number of drivers for the different IPs of the SoC have
>>    already been merged in upstream Linux (see
>>    arch/arm/boot/dts/lan966x.dtsi)
>>
>> PCI mode:
>>   The lan966x SoC is configured as a PCIe endpoint (PCI card),
>>   connected to a separate platform that acts as the PCIe root complex.
>>   In this case, all the IO memories that are exposed by the devices
>>   embedded on this SoC are exposed through PCI BARs 0 & 1 and the ARM64
>>   cores of the SoC are not used. Since this is a PCIe card, it can be
>>   plugged on any platform, of any architecture supporting PCIe.
>>
>> This work only focus on the *PCI mode* usage. In this mode, we have the
>> following prerequisites:
>> - Should work on all architectures (x86, ARM64, etc)
>> - Should be self-contained in the driver
>> - Should be able to reuse all existing platform drivers
>>
>> In PCI mode, the card runs a firmware (not that it matters at all by
>> the way) which configure the card in PCI mode at boot time. In this
>> mode, it exposes a single PCI physical function associated with
>> vendor/product 0x1055/0x9660. This is not a multi-function PCI device !
>> This means that all the IO memories (peripheral memories, device
>> memories, registers, whatever you call them) are accessible using
>> standard readl()/writel() on the BARs that have been remapped. For
>> instance (not accurate), in the BAR 0, we will have this kind of memory
>> map:
>>
>>            BAR0
>>    0x0 ┌───────────┐
>>        │           │
>>        ├───────────┤
>>        │   Clock   │
>>        │ controller│
>>        ├───────────┤
>>        │           │
>>        ├───────────┤
>>        │   I2C     │
>>        │ controller│
>>        ├───────────┤
>>        │           │
>>        ├───────────┤
>>        │   MDIO    │
>>        │ Controller│
>>        ├───────────┤
>>        │           │
>>        ├───────────┤
>>        │  Switch   │
>>        │ Controller│
>>        ├───────────┤
>>        │           │
>>        │   ...     │
>>
>>
>> It also exposes either a single interrupt via the legacy interrupt
>> (which can then be demuxed by reading the SoC internal interrupt
>> controller registers), or multiple interrupts using MSI interrupts.
>>
>> As stated before, all these peripherals are already supported in SoC
>> mode and thus, there are aleready existing platform drivers for each of
>> them. For more information about the devices that are exposed please
>> see link [1] which is the device-tree overlay used to describe the
>> lan9662 card.
>>
>> In order to use the ethernet switch, we must configure everything that
>> lies around this ethernet controller, here are a few amongst all of
>> them:
>> - MDIO bus
>> - I2C controller for SFP modules access
>> - Clock controller
>> - Ethernet controller
>> - Syscon
>>
>> Since all the platform drivers already exist for these devices, we
>> want to reuse them. Multiple solutions were thought of (fwnode, mfd,
>> ACPI, device-tree) and eventually ruled out for some of them and efforts
>> were made to try to tackle that (using fwnode [2], device-tree [3])
>>
>> One way to do so is to use a device-tree overlay description that is
>> loaded dynamically on the PCI device OF node. This can be done using the
>> various device-tree series series that have been proposed (included
>> this one). On systems that do not provide a device-tree of_root, create
>> an empty of_root node (see [4]). Then during PCI enumeration, create
>> device-tree node matching the PCI tree that was enumerated (See [5]).
>> This is needed since the PCI card can be plugged on whatever port the
>> user wants and thus it can not be statically described using a fixed
>> "target-path" property in the overlay.
>>
>> Finally, to glue everything together, we add a PCI driver for the
>> VID/PID of the PCI card (See [6]). This driver is responsible of adding
>> the "ranges" property in the device-tree PCI node to remap the child
>> nodes "reg" property to the PCI memory map. This is needed because the
>> PCI memory addresses differ between platform, enumeration order and so
>> on.Finally, the driver will load the device-tree overlay (See [1]) to
>> the PCI device-tree node. Eventually, a call to
>> of_platform_default_populate() will probe the nodes and platform
>> drivers.
>>
>> I hope this will help you understanding what is going on here. In the
>> meantime, I'm also trying to obtain public documentation about the
>> lan966x SoC.
>>
>> [1]
>> https://github.com/clementleger/linux/blob/bf9b4ef803d86c4ae59a4ca195a4152b0d5c3cea/drivers/mfd/lan966x_pci.dts
>> [2]
>> https://lore.kernel.org/netdev/YhPSkz8+BIcdb72R@smile.fi.intel.com/T/
>> [3]
>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>> [4]
>> https://lore.kernel.org/lkml/20230223213418.891942-1-frowand.list@gmail.com/
>> [5]
>> https://lore.kernel.org/lkml/1674183732-5157-1-git-send-email-lizhi.hou@amd.com/
>> [6]
>> https://github.com/clementleger/linux/blob/bf9b4ef803d86c4ae59a4ca195a4152b0d5c3cea/drivers/mfd/lan966x_pci_of.c
>>
>> --
>> Clément Léger,
>> Embedded Linux and Kernel engineer at Bootlin
>> https://bootlin.com
> 
> What is missing to move on with this patch set?

I need to evaluate what Clément Léger wrote in the email you replied to.  I had overlooked this
reply to my questions.  From a quick scan, it looks like he _probably_ provided the context I
was looking for to understand the architecture of the proposal.  But it is late Sunday night,
so I won't get to this tonight.

-Frank

> 

