Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5396C2CD3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCUIqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCUIqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 04:46:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79077F95F;
        Tue, 21 Mar 2023 01:45:10 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f17-20020a9d7b51000000b00697349ab7e7so8110665oto.9;
        Tue, 21 Mar 2023 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679388299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WH1MmEtF7ADpDcXoElCHEx486umQTAF1UzwqryZja0=;
        b=hsPNy0zEl8O5lYKUVSdLUPnSSAJjnJpqnd9hGZUSpv4yFyIyCBTzXUVLcCh+T66EeW
         KtJMfyf6rt24EKhzYKvGy3YVfatKXFlR2e33nMmyVFBUJGSZ986hkY30Vsp0MhGMhKbE
         sZsQ5lJlKQYQImTGB5QuB0nMyzpfzrKn0r2b0GtnwJZunJYxXEGOqXNPmNDM4rut88bX
         yzSrqqGdgKBwBJMf5+i6i1OeOxLF98n+naa34zExRDJr3UZkMP7/Veoqh4/8mFBApNJA
         VhWw/s1ZjlXKA7cwfkFRK4M6E6mWo9zubRM1EQEfvnE0pfwWsyY7uvKsbgXbv/yW6zEe
         zHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679388299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WH1MmEtF7ADpDcXoElCHEx486umQTAF1UzwqryZja0=;
        b=KZxe1+A5CqyKwa2y4olX1E5kiFbkrTIDnWl6zrrYdH9/1BCrj3B3SvCfuttlXxvoTN
         PcoDB/9QOeNcHxbmaVjh03x3To9IGkBWaXUSp4gpq49mM04x4ApwmSnDrNjWYNQhMKur
         m7enW9jOwMQgTKh0Im9LVOGI3EYdM2DABbe26tukbbBR6moMxWKvIGY3izR5mPypJ9qs
         GPBFR6bxFse7ja2xbcM2ill3uMZ8sXj8sTDIOesVX7ek48ge0mtSMxeZCRhIGVKcEacR
         e6FUm6/fv71GPntJwamkVZvOzZ4uYt0Q2XdjHJ1H+didKfk9I5N3rNWcTNYFHqIZde4c
         EQnQ==
X-Gm-Message-State: AO0yUKVOZ+u+cNCZe3lu2z4FpVxKdtcJWUUbFigxcaC4fFiAZs+n1nJl
        F3ffeB7abTjwvsyMk/XInqrcsiXIB/iE2q77nzs=
X-Google-Smtp-Source: AK7set/dAoQ0Q2yGGJPZJuUDGPViLLRNf9rMV47079RBjuPur+ptYMY8qDGJXtwQO7rkJnE8xShLUhCSMJr8P/SaaV0=
X-Received: by 2002:a9d:6510:0:b0:699:7883:940d with SMTP id
 i16-20020a9d6510000000b006997883940dmr538422otl.7.1679388298816; Tue, 21 Mar
 2023 01:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
 <af2a6686-ea35-e5fc-7541-27e5d6ca9311@gmail.com> <20230227113150.398dcfa7@fixe.home>
 <52b8f136-c73f-a97d-2bb6-48aff3755f98@gmail.com> <f927790dc9839cd93902c0d2e5afe5e8@bootlin.com>
 <1886b888-a0e8-b1ee-c48a-ddbc8b5b0c63@gmail.com> <CAL_JsqL_ER32ys-yW_7-QKLjEmKK8StOeM5yvH2ChuvX++fe5Q@mail.gmail.com>
 <9b4bb45a-f6e4-c95c-d27c-21c7fecb5505@gmail.com> <20230309094507.62d7c35e@fixe.home>
In-Reply-To: <20230309094507.62d7c35e@fixe.home>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 21 Mar 2023 09:44:47 +0100
Message-ID: <CAH9NwWfvXjY8=OFesytZ1HAM-wBJ=tNB8wAkP99JLw=inYJJgg@mail.gmail.com>
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all

Am Do., 9. M=C3=A4rz 2023 um 09:52 Uhr schrieb Cl=C3=A9ment L=C3=A9ger
<clement.leger@bootlin.com>:
>
> Le Wed, 8 Mar 2023 01:31:52 -0600,
> Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
>
> > On 3/6/23 18:52, Rob Herring wrote:
> > > On Mon, Mar 6, 2023 at 3:24=E2=80=AFPM Frank Rowand <frowand.list@gma=
il.com> wrote:
> > >>
> >
> > < snip >
> >
> > Hi Rob,
> >
> > I am in no position to comment intelligently on your comments until I
> > understand the SoC on PCI card model I am asking to be described in
> > this subthread.
>
> Hi Frank,
>
> Rather than answering all of the assumptions that were made in the upper
> thread (that are probably doing a bit too much of inference), I will
> re-explain that from scratch.
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
>    0x0 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>        =E2=94=82           =E2=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82   Clock   =E2=94=82
>        =E2=94=82 controller=E2=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82           =E2=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82   I2C     =E2=94=82
>        =E2=94=82 controller=E2=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82           =E2=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82   MDIO    =E2=94=82
>        =E2=94=82 Controller=E2=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82           =E2=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82  Switch   =E2=94=82
>        =E2=94=82 Controller=E2=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82           =E2=94=82
>        =E2=94=82   ...     =E2=94=82
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
> https://github.com/clementleger/linux/blob/bf9b4ef803d86c4ae59a4ca195a415=
2b0d5c3cea/drivers/mfd/lan966x_pci.dts
> [2]
> https://lore.kernel.org/netdev/YhPSkz8+BIcdb72R@smile.fi.intel.com/T/
> [3]
> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootli=
n.com/
> [4]
> https://lore.kernel.org/lkml/20230223213418.891942-1-frowand.list@gmail.c=
om/
> [5]
> https://lore.kernel.org/lkml/1674183732-5157-1-git-send-email-lizhi.hou@a=
md.com/
> [6]
> https://github.com/clementleger/linux/blob/bf9b4ef803d86c4ae59a4ca195a415=
2b0d5c3cea/drivers/mfd/lan966x_pci_of.c
>
> --
> Cl=C3=A9ment L=C3=A9ger,
> Embedded Linux and Kernel engineer at Bootlin
> https://bootlin.com

What is missing to move on with this patch set?

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
