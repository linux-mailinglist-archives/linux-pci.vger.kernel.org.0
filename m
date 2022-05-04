Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C855192D9
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 02:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiEDAhG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 20:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiEDAhF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 20:37:05 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9B71AF03;
        Tue,  3 May 2022 17:33:31 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id a10so19864413oif.9;
        Tue, 03 May 2022 17:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+69jK9IPHtq7eTQpuH4u7DsenSPiOVy1Fxyon9TR9q0=;
        b=vhsnB7Eu8YLo8GpNYxcBFEh5lQCusz56zGQUCJ1cBvW3tnSXfBRw64jt+49UQA43w1
         QTCxtK/Q/YZVbYN8l7+/kjP4/Rqh8tbBj+MUz1jq6dshS7zilWmmh8R5/uDviq5Ez0RQ
         xXHXmJCCBWgP1ZN1CwAFsDLGBAqOh0okp1N1WLQI4QXZh9P9mtHy6BXR9bqhBev8U3V3
         Hq7XFcTCCQShz6AoHoIY2qFbbiJsssi/gmKM6AuuhX3r0SicyjUVMqNLVVLdsQcqNQoh
         AyIz004xFtFLU31I9kWFd0u/HsMzqLv9et6U4aFCYI0sq/1LAcgV7w+ZsvVZvSVJQ9/f
         H5IA==
X-Gm-Message-State: AOAM530HFwGvcROKT54XTO90P5Y901T/rxW5Hz45o3AcNmSoVEKS+tJj
        yEqT3Rh7E5jPT4wqb2E8tw==
X-Google-Smtp-Source: ABdhPJy9hwsgHM6RNU9r1FLK8J2cCGc+iKNimAULdRWWFDNux+5LRT3N6BpBMEvwZ0ZU5BfGCMl4Xg==
X-Received: by 2002:a05:6808:118f:b0:2d9:a01a:48be with SMTP id j15-20020a056808118f00b002d9a01a48bemr2854191oil.265.1651624411016;
        Tue, 03 May 2022 17:33:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p6-20020aca4206000000b00325cda1ffbbsm3769396oia.58.2022.05.03.17.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 17:33:30 -0700 (PDT)
Received: (nullmailer pid 319775 invoked by uid 1000);
        Wed, 04 May 2022 00:33:29 -0000
Date:   Tue, 3 May 2022 19:33:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: apple: Add support for optional PWREN GPIO
Message-ID: <YnHJ2ZKd2CqhNWrX@robh.at.kernel.org>
References: <20220502093832.32778-1-marcan@marcan.st>
 <20220502093832.32778-4-marcan@marcan.st>
 <CAL_Jsq+_cWZUXtJVXC_cwhmADj0NQc95v1sqgFioMsfEX6OqGg@mail.gmail.com>
 <0ccc44cd-21aa-3670-24b3-4ee051dd3c12@marcan.st>
 <2615501d-7569-41cb-7039-46e690689f1f@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2615501d-7569-41cb-7039-46e690689f1f@marcan.st>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 03, 2022 at 12:20:48PM +0900, Hector Martin wrote:
> On 03/05/2022 00.32, Hector Martin wrote:
> > On 03/05/2022 00.14, Rob Herring wrote:
> >> On Mon, May 2, 2022 at 4:39 AM Hector Martin <marcan@marcan.st> wrote:
> >>>
> >>> WiFi and SD card devices on M1 Macs have a separate power enable GPIO.
> >>> Add support for this to the PCIe controller. This is modeled after how
> >>> pcie-fu740 does it.
> >>
> >> It did, but it's not ideal really. The problem is the GPIO is really
> >> associated with the device (WiFi/SD) rather than the PCI host and
> >> therefore should be part of a WiFi or SD node. You probably don't have
> >> one (yet), but I would suspect that SD will need one for all the
> >> standard MMC/SD DT properties. The secondary issue is we'll end up
> >> adding more power sequencing properties to control ordering and timing
> >> for different devices. The exception here is standard PCI slot
> >> properties like perst#, clkreq, and standard voltage rails can go in
> >> the host bridge (and for new bindings, those should really be in the
> >> root port node). For a complicated example, see Hikey960 or 970.
> >>
> >> Of course with power control related properties there's a chicken or
> >> egg issue that the PCI device is not discoverable until the device is
> >> powered on. This issue comes up over and over with various hacky
> >> solutions in the bindings. The PCI subsystem needs to solve this. My
> >> suggestion is that if the firmware says there is a device on the bus
> >> and it wasn't probed, then we should force probing (or add a pre-probe
> >> hook for drivers). That is what MDIO bus does for example.
> >>
> > 
> > I agree with the premise. Right now macOS does not actually power down
> > these devices as far as I know (except maybe sleep mode? not sure what
> > goes on then yet), but I think the hardware actually has an SD card
> > detect GPIO hookup that would allow us to entirely power down the SD
> > controller when no card is inserted. That would obviously be ideal.
> > 
> > FWIW, we do have the device nodes downstream [1]. I did in fact have to
> > add the SD one for the CD/WP inversion flags (and had to add driver
> > support for that too).
> > 
> > That said, as for how to make this happen in the PCI subsystem
> > properly... I think I'll defer to the maintainers' opinion there before
> > trying to hack something up ;)
> > 
> > Meanwhile, I guess I better get PCIe hotplug working, since doing it in
> > the driver isn't going to work without that first...
> > 
> > [1]
> > https://github.com/AsahiLinux/linux/blob/bits/000-devicetree/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi#L222
> 
> Thinking about this some more, I think it still makes sense to have the
> power enable GPIO in the PCI root port node. A generic power enable GPIO
> still makes sense there (think "slot power"). The PCI core could handle
> it properly by default, including turning it on prior to initial probing
> and shutting it down when the device should go into whatever the PCI
> core's idea of D3cold is. AIUI this already happens on some platforms
> via firmware, right? Since D3cold is supposed to be a state where the
> device receives no power after all.

We have put slot stuff in the bridge node. That's because PCI child 
nodes already have a definition and we didn't define slot nodes up 
front. We often have started without a slot/connector and then 
retrofitted nodes in.

I can think of lots of ways to implement 'slot power' with a single GPIO 
being just one way. If it's not defined by PCIe specs or defacto 
standards then I don't think we want to try to do something generic.

The other way to model power gpios is as a GPIO regulator. We probably 
already have PCI examples doing that.

> Obviously this can't handle funky power sequencing requirements, but we
> don't have any of those here and we don't know if we ever will (at least
> Apple seems to be a fan of throwing little CPLDs on their boards for
> fine grained power sequencing, driven by a single IO). If we do, then
> that would be the time to have GPIOs in the device node.
> 
> In addition, sometimes a single power enable is shared between multiple
> functions of one device. This is the case with WiFi/BT, which is a combo
> chip with two functions. Coordinating GPIO usage between both drivers
> would be problematic if they both try to own it.

A GPIO regulator solves this problem as it is reference counted.

> The individual device drivers still need to have some kind of API to be
> able to put devices into a low-power state. For example, the WiFi driver
> could outright power down the device when it is wholly unused and the
> interface is down (same for BT, and the PCI core should only put the
> slot GPIO into powerdown if both functions say they should be off).
> Similarly, the SD driver needs to support an external SD detect GPIO,
> and have a mode where it tells the PCI core to shut down the device when
> no SD is inserted, and power it back up on insertion. This all allows
> the devices to behave a users might expect, with the device nodes
> existing and the PCI devices "visible" even when they are powered down
> behind the scenes, until they are needed. AIUI this is already how e.g.
> hybrid graphics power management works, where power is outright yanked
> from the secondary card when it is not needed even though it is still
> visible from the userspace point of view (and it is automatically
> powered and reinitialized on use).

Can it detect a card insertion when powered down?

I think a GPIO regulator solves all this as long as card detect still 
works.

> I'm not super familiar with PCI device power states (making brcmfmac
> sleep work properly on these platforms is on my TODO list...) so I'd
> love to get some feedback from the PCI folks on what they think about
> this whole issue.

I'm not either. I know there's some backlog of work to rework PCI power 
management to be more inline with how the rest of kernel drivers work.
 
Isn't D3cold an ACPI thing, not PCI?

Rob
