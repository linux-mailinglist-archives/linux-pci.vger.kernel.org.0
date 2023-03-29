Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539116CEFD2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 18:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjC2QvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjC2QvP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 12:51:15 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F76595;
        Wed, 29 Mar 2023 09:50:59 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17aaa51a911so16844268fac.5;
        Wed, 29 Mar 2023 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680108658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PehrIGvL7yrC1nSpIWGfA0jHs68N9zhBNDrUAi9TH7E=;
        b=RuloJ8452t5VMRd/Gc/4PkkNTbP9SMWjIkICi2rgimWyX3kvdpBE0cK1eOZnxAyBoW
         15Y8zazVAarN2P9zKWg4KCl1v32n7kPlIiRVULo0ebnmj3t/20FpQSUAZKSbDcalLqR8
         xbRn9ltbKcuFMzYhLoQJtu469cn79rBbXF7IPJHpi1Blvv9VVZq+E6TuFx3WCaum9Hx0
         g/21YT2MazcIcKkp7Z6OIuOb41Ln0wBI1B8t7L5NjErhDTsPvYxLhnbU58M2jmT6ta3y
         3RNAICG27/KiOIhbGU0UUykzaO4/v5T9ntklMJz/4rCPThusAgmOW3ASEPKSOiyholtj
         sR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680108658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PehrIGvL7yrC1nSpIWGfA0jHs68N9zhBNDrUAi9TH7E=;
        b=x06lwnKbuanXpiiO4rW2QZZQCx5dbWBIlMge8oirjrgIhcuIS9er0/asYOhJzinTNn
         uHRfyDvPWsd7AnoxieY+gb0VjFfpVEr6KNX84OCrWwjDJ3SfJxp8f4v7Pdl5E8MBehYG
         sRW3dPk3fmK23m2kv9BzvISh3HHSmfcfeF2COwEy/DqjhwX9tkHB3rvlZiBICBCVOuAN
         WDEZx624LKacIjB7B9d9x4a2GXbbRIDU83FMrUc4+dJYhNluQXuMyTqbyQiApABAhTzC
         0qPV4XtqYlV/uDOXuBK8V6+2oGDdY1LmJNO3ZsQPKiOhWHQ18RQS9TORhTiyqsSf2KIX
         xZeQ==
X-Gm-Message-State: AO0yUKW3X80sPUzfEiwWSzSnppu1TJ3oMpDrG4OFe5a+ZLJGNbEa9ctg
        twR/xkTjoGU2ukioHFkiu1Q=
X-Google-Smtp-Source: AKy350YsLi+p13RRSVPYDYULgRngZJZHfRMlUAGUaozsIfg1QWULbyMLp1TRGCv4Bv2Qm/c/NMJRHA==
X-Received: by 2002:a05:6870:1d1:b0:17e:c403:a046 with SMTP id n17-20020a05687001d100b0017ec403a046mr11978937oad.12.1680108658258;
        Wed, 29 Mar 2023 09:50:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:d913:852b:d7c6:7253? ([2600:1700:2442:6db0:d913:852b:d7c6:7253])
        by smtp.gmail.com with ESMTPSA id n12-20020a9d740c000000b006a0ae1c4263sm6437854otk.48.2023.03.29.09.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 09:50:57 -0700 (PDT)
Message-ID: <fed57536-cd2c-bf9b-37bc-7a653685cbf2@gmail.com>
Date:   Wed, 29 Mar 2023 11:50:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
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
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230309094507.62d7c35e@fixe.home>
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

On 3/9/23 02:45, Clément Léger wrote:
> Le Wed, 8 Mar 2023 01:31:52 -0600,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>> On 3/6/23 18:52, Rob Herring wrote:
>>> On Mon, Mar 6, 2023 at 3:24 PM Frank Rowand <frowand.list@gmail.com> wrote:  
>>>>  
>>
>> < snip >
>>
>> Hi Rob,
>>
>> I am in no position to comment intelligently on your comments until I
>> understand the SoC on PCI card model I am asking to be described in
>> this subthread.
> 
> Hi Frank,
> 
> Rather than answering all of the assumptions that were made in the upper
> thread (that are probably doing a bit too much of inference), I will
> re-explain that from scratch.

Thanks!  The below answers a lot of my questions.
> 
> Our usecase involves the lan966x SoCs. These SoCs are mainly targeting
> networking application and offers multiple SFP and RGMII interfaces.
> This Soc can be used in two exclusive modes (at least for the intended
> usage):
> 
> SoC mode:
>    The device runs Linux by itself, on ARM64 cores included in the
>    SoC. This use-case of the lan966x is currently almost upstreamed,
>    using a traditional Device Tree representation of the lan996x HW
>    blocks [1] A number of drivers for the different IPs of the SoC have
>    already been merged in upstream Linux (see
>    arch/arm/boot/dts/lan966x.dtsi)
> 
> PCI mode:
>   The lan966x SoC is configured as a PCIe endpoint (PCI card),
>   connected to a separate platform that acts as the PCIe root complex.
>   In this case, all the IO memories that are exposed by the devices
>   embedded on this SoC are exposed through PCI BARs 0 & 1 and the ARM64
>   cores of the SoC are not used. Since this is a PCIe card, it can be
>   plugged on any platform, of any architecture supporting PCIe.
> 
> This work only focus on the *PCI mode* usage. In this mode, we have the
> following prerequisites:
> - Should work on all architectures (x86, ARM64, etc)
> - Should be self-contained in the driver

> - Should be able to reuse all existing platform drivers

I've said before (in different words) that using an existing platform
driver for hardware on a PCI card requires shims, which have been
strongly rejected by the Linux kernel.

> 
> In PCI mode, the card runs a firmware (not that it matters at all by
> the way) which configure the card in PCI mode at boot time. In this
> mode, it exposes a single PCI physical function associated with
> vendor/product 0x1055/0x9660. This is not a multi-function PCI device !
> This means that all the IO memories (peripheral memories, device
> memories, registers, whatever you call them) are accessible using
> standard readl()/writel() on the BARs that have been remapped. For
> instance (not accurate), in the BAR 0, we will have this kind of memory
> map:
> 
>            BAR0
>    0x0 ┌───────────┐
>        │           │
>        ├───────────┤
>        │   Clock   │
>        │ controller│
>        ├───────────┤
>        │           │
>        ├───────────┤
>        │   I2C     │
>        │ controller│
>        ├───────────┤
>        │           │
>        ├───────────┤
>        │   MDIO    │
>        │ Controller│
>        ├───────────┤
>        │           │
>        ├───────────┤
>        │  Switch   │
>        │ Controller│
>        ├───────────┤
>        │           │
>        │   ...     │
>           
> 
> It also exposes either a single interrupt via the legacy interrupt
> (which can then be demuxed by reading the SoC internal interrupt
> controller registers), or multiple interrupts using MSI interrupts.
> 
> As stated before, all these peripherals are already supported in SoC
> mode and thus, there are aleready existing platform drivers for each of
> them. For more information about the devices that are exposed please
> see link [1] which is the device-tree overlay used to describe the
> lan9662 card.
> 
> In order to use the ethernet switch, we must configure everything that
> lies around this ethernet controller, here are a few amongst all of
> them:
> - MDIO bus
> - I2C controller for SFP modules access
> - Clock controller
> - Ethernet controller
> - Syscon
> 
> Since all the platform drivers already exist for these devices, we
> want to reuse them. Multiple solutions were thought of (fwnode, mfd,
> ACPI, device-tree) and eventually ruled out for some of them and efforts
> were made to try to tackle that (using fwnode [2], device-tree [3])
> 

> One way to do so is to use a device-tree overlay description that is
> loaded dynamically on the PCI device OF node. This can be done using the
> various device-tree series series that have been proposed (included
> this one). On systems that do not provide a device-tree of_root, create
> an empty of_root node (see [4]). Then during PCI enumeration, create
> device-tree node matching the PCI tree that was enumerated (See [5]).
> This is needed since the PCI card can be plugged on whatever port the
> user wants and thus it can not be statically described using a fixed
> "target-path" property in the overlay.

I understand that this is a use case and a desire to implement a
solution for the use case.  But this is a very non-standard model.
The proposal exposes a bunch of hardware beyond the pci interface
in a non-pci method.

No, just no.  Respect the pci interface boundary and do not drag
devicetree into an effort to pierce and straddle that boundary
(by adding information about the card, beyond the PCI controller,
into the system devicetree).  Information about dynamically
discoverable hardware does not belong in the devicetree.

-Frank

> 
> Finally, to glue everything together, we add a PCI driver for the
> VID/PID of the PCI card (See [6]). This driver is responsible of adding
> the "ranges" property in the device-tree PCI node to remap the child
> nodes "reg" property to the PCI memory map. This is needed because the
> PCI memory addresses differ between platform, enumeration order and so
> on.Finally, the driver will load the device-tree overlay (See [1]) to
> the PCI device-tree node. Eventually, a call to
> of_platform_default_populate() will probe the nodes and platform
> drivers.
> 
> I hope this will help you understanding what is going on here. In the
> meantime, I'm also trying to obtain public documentation about the
> lan966x SoC.
> 
> [1]
> https://github.com/clementleger/linux/blob/bf9b4ef803d86c4ae59a4ca195a4152b0d5c3cea/drivers/mfd/lan966x_pci.dts
> [2]
> https://lore.kernel.org/netdev/YhPSkz8+BIcdb72R@smile.fi.intel.com/T/
> [3]
> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> [4]
> https://lore.kernel.org/lkml/20230223213418.891942-1-frowand.list@gmail.com/
> [5]
> https://lore.kernel.org/lkml/1674183732-5157-1-git-send-email-lizhi.hou@amd.com/
> [6]
> https://github.com/clementleger/linux/blob/bf9b4ef803d86c4ae59a4ca195a4152b0d5c3cea/drivers/mfd/lan966x_pci_of.c
> 

