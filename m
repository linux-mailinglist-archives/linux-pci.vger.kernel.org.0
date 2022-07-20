Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83157BB35
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiGTQSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbiGTQSo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 12:18:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5C54050;
        Wed, 20 Jul 2022 09:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF0B3B8210A;
        Wed, 20 Jul 2022 16:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D508C341D0;
        Wed, 20 Jul 2022 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658333919;
        bh=dBAYRKIzFm0RTKOcH+0KPke3E8MEw8rlIWS4O1tZUf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T9YI5+FhKac8fuIV3QPR3CTu79OZY1DHEEAfFE4Iim6EREIDLDo+mQtP1mxW1sggg
         yt7JoQkZfykvX12pala/eTUXAaJ3AkijMLabBuMpLpzF+Up0VP8nP6WqWD5oYllZ7V
         T/NcMA6ky6NLqgMz9bHnkh7JhSPYcB9qMKxguCKk6PZQTgW/+j7Np/I9ItGdl8R3Sf
         IirxP8/4VzC0NN6Oqc19EFy/Tzj7n1fs3rlwpeMpIg74IFPBFuGlJoUI+Xdqks+UgY
         yzjYj2x+/rSwjxcUbDFOjRGhWwOh6e1hQLkAqsSbS8DfftnnfN4IZaFoBIxbhqHYd8
         hlxESxWG0hfLQ==
Received: by mail-vs1-f48.google.com with SMTP id l190so16812109vsc.0;
        Wed, 20 Jul 2022 09:18:39 -0700 (PDT)
X-Gm-Message-State: AJIora8M3AUpI++Smmzjy6ERlkbaWrW8kWPO9r5Yuoh9RrB662lYXVfn
        6hVr4oFzSOWHwGDOdfdrdJNMcycKntDVJastKQ==
X-Google-Smtp-Source: AGRyM1voQ4F5sT5eKvu1fTJ7ITqpMhh2FJ7XwBQbxVTbwxyO9/skYla1F1uslswBejdiQH8uJSTEQjOOUOMZ4R5nVvM=
X-Received: by 2002:a67:c18e:0:b0:357:5fc3:45d7 with SMTP id
 h14-20020a67c18e000000b003575fc345d7mr13075314vsj.53.1658333918336; Wed, 20
 Jul 2022 09:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-6iNz8DTjAMXnWuOd=0W=qa6J4uD03oH3RJezEk1WxaUN1NA@mail.gmail.com>
 <20220719200332.GA1552587@bhelgaas> <CA+-6iNzn=JsG=xU2BxagyfeUMZ13p9yg=y+_wVcsAaZ0NgEvKg@mail.gmail.com>
In-Reply-To: <CA+-6iNzn=JsG=xU2BxagyfeUMZ13p9yg=y+_wVcsAaZ0NgEvKg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Jul 2022 10:18:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLm5pWFNLMYjRXrBNYumOd0Vdyaxj0+PGnABQbjA6bDBQ@mail.gmail.com>
Message-ID: <CAL_JsqLm5pWFNLMYjRXrBNYumOd0Vdyaxj0+PGnABQbjA6bDBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 8:53 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Tue, Jul 19, 2022 at 4:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Jul 19, 2022 at 09:08:48AM -0400, Jim Quinlan wrote:
> > > On Mon, Jul 18, 2022 at 6:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Mon, Jul 18, 2022 at 02:56:03PM -0400, Jim Quinlan wrote:
> > > > > On Mon, Jul 18, 2022 at 2:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
> > > > > > > Currently, the function does the setup for establishing PCIe link-up
> > > > > > > with the downstream device, and it does the actual link-up as well.
> > > > > > > The calling sequence is (roughly) the following in the probe:
> > > > > > >
> > > > > > > -> brcm_pcie_probe()
> > > > > > >     -> brcm_pcie_setup();                       /* Set-up and link-up */
> > > > > > >     -> pci_host_probe(bridge);
> > > > > > >
> > > > > > > This commit splits the setup function in two: brcm_pcie_setup(), which only
> > > > > > > does the set-up, and brcm_pcie_start_link(), which only does the link-up.
> > > > > > > The reason why we are doing this is to lay a foundation for subsequent
> > > > > > > commits so that we can turn on any power regulators, as described in the
> > > > > > > root port's DT node, prior to doing link-up.
> > > > > >
> > > > > > All drivers that care about power regulators turn them on before
> > > > > > link-up, but typically those regulators are described directly under
> > > > > > the host bridge itself.
> > > > >
> > > > > Actually, what you describe is what I proposed with my v1 back in Nov 2020.
> > > > > The binding commit message said,
> > > > >
> > > > >     "Quite similar to the regulator bindings found in
> > > > >     "rockchip-pcie-host.txt", this allows optional regulators to be
> > > > >     attached and controlled by the PCIe RC driver."
> > > > >
> > > > > > IIUC the difference here is that you have regulators described under
> > > > > > Root Ports (not the host bridge/Root Complex itself), so you don't
> > > > > > know about them until you've enumerated the Root Ports.
> > > > > > brcm_pcie_probe() can't turn them on directly because it doesn't know
> > > > > > what Root Ports are present and doesn't know about regulators below
> > > > > > them.
> > > > >
> > > > > The reviewer's requested me to move the regulator node(s)
> > > > > elsewhere, and at some point later it was requested to be placed
> > > > > under the Root Port driver.  I would love to return them under the
> > > > > host bridge, just say the word!
> > > >
> > > > Actually, I think my understanding is wrong.  Even though the PCI core
> > > > hasn't enumerated the Root Port as a pci_dev, brcm_pcie_setup() knows
> > > > about it and should be able to look up the regulators and turn them
> > > > on.
> > >
> > > One can do this with
> > >         regulator_bulk_get(NULL, ...);
> > >
> > > However, MarkB did not like the idea of a driver getting the
> > > regulator from the global DT namespace [1].
> > >
> > > For the RC driver, one  cannot invoke  regulator_bulk_get(dev, ...)
> > > if there is not a direct child regulator node.  One needs to use the
> > > Port driver device.  The Port driver device does not exist at this
> > > point unless one tries to prematurely create it; I tried this and it
> > > was a mess to say the least.
> > >
> > > > Can you dig up the previous discussion about why the regulators need
> > > > to be under the Root Port and why they can't be turned on before
> > > > calling pci_host_probe()?
> > >
> > > RobH did not want the regulators to be under the RC as he said their
> > > DT location should resemble the HW [2].  The consensus evolved to
> > > place it under the port driver, which can provide a general
> > > mechanism for turning on regulators anywhere in the PCIe tree.
> >
> > I don't want to redesign this whole thing.  I just want a crisp
> > rationale for the commit log.
> >
> > All other drivers (exynos, imx6, rw-rockchip, histb, qcom, tegra194,
> > tegra, rockchip-host) have regulators for downstream PCIe power
> > directly under the RC.  If putting the regulators under an RP instead
> > is the direction of the future, I guess that might be OK, and I guess
> > the reasons are:
> >
> >   1) Slot or device power regulators that are logically below the RP
> >      should be described that way in the DT.
> >
> >   2) Associating regulators with a RP allows the possibility of
> >      selectively controlling power to slots/devices below the RP,
> >      e.g., to power down devices below RP A when suspending while
> >      leaving wakeup devices below RP B powered up.
> >
> > I think in your case the motivating reason is 2).
> >
> > Your commit log for "Add mechanism to turn on subdev regulators"
> > suggests that you want some user control of endpoint power, e.g., via
> > sysfs, but I don't see that implemented yet except possibly via a
> > "remove" file that would unbind the driver and remove the entire
> > device.
> Hi Bjorn,
>
> Initially we wanted to (a) turn on any regulator found under the RC
> node and (b) allow the possibility of the regulator to control the
> EP's power. From the feedback, we realized early on that neither of
> these were going to fly, so we conceded both requests and just wanted
> to turn on standard PCIe regulators.  Upon reading the aforementioned
> commit message I realize that there are a couple of leftover sentences
> from these early days that must be removed.
>
> I think when I submitted v1 of the original series that only the
> rockchip driver had regulators under the RC.   And my recollection was
> that this was accepted but there was apprehension of this turning into
> the "standard" way of turning on such regulators,  as the location of
> the regulator nodes was in question.
>
> In short, I would be quite content  to follow the existing examples.

The existing examples are, in general, incomplete and only work for
the simplest cases.

There's 2 cases to consider here. The first is standard slots with
standard PCIe signals (e.g. PERST#) and voltage rails. The 2nd is
either non-standard slots or just soldered down devices which could
have any number of device specific resources. In the latter case,
those resources need to go into the node for the device. For the
former case (which we are discussing here), putting the resources in
the upstream (side of the link) node is fine. That's the root port
node(s) or switch port nodes. However, since most host bridges are a
single RP and don't put the RP node in DT, we've ended up with these
properties in host bridge nodes. That's fine as long as it's a single
RP and device. When it is not, we need to do something different. The
only way this scales is putting resources in the port nodes as those
are what have a 1:1 relationship to slots. If that's supported, then
the simple cases are also easily supported with if the resources are
not found in the port node/device, then look for them in the parent
node. That's also the path for how we get the handling of PERST out of
every host bridge driver.

Rob
