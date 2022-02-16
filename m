Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA64B7CC4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 02:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245616AbiBPBxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 20:53:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiBPBxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 20:53:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0556C1DC;
        Tue, 15 Feb 2022 17:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D49A3B81D90;
        Wed, 16 Feb 2022 01:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A46C340EB;
        Wed, 16 Feb 2022 01:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644976386;
        bh=RpHh2XK3cscZmha2HhZmkS5MLrmpjSMVuJard6nBP7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H/HPajPvU7ri60s90Bh8iAi4awFW7WonTf3sq4g+UXfYvPpo7f4ORClQuRXwv8jsb
         1R9/ooc2UiG2pkAaOBJZg+WWbQuQTJYka0oGvUc0bLJK4I+9kf/N+xi/M0Hke87ZUg
         4Qannc73uStqzNqbff3G935vnuVPrxptKjbb0HNAArwmBlD5n7WXfHQ+eU2PpbPYmX
         5BrAzB+tA7V/FqaS46GwiXu7GidNuXJaIA9LLCBuEmYMRZ3+7kIpYwD4qpY3HQYv6v
         4bpOii1xnGjL51SdxBJ54Tm+gDCOj/kDkzPe1epKqiKS2QNs3NNVp+Ps+PbIbj1bCQ
         LkmkCg7CLaclw==
Date:   Tue, 15 Feb 2022 19:53:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
Message-ID: <20220216015303.GA137820@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i6+EMMGuKckhtTdt7TgC3LbofW7oS7B5=McSNjEh1yKA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 06:09:15PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 15, 2022 at 4:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Feb 14, 2022 at 08:23:05AM +0800, Kai-Heng Feng wrote:
> > > On Thu, Feb 10, 2022 at 5:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Dec 07, 2021 at 02:15:04PM +0100, Rafael J. Wysocki wrote:
> > > > > On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
> > > > > > On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
> > > > > > > When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> > > > > > > combination causes AER message flood and drags the system performance
> > > > > > > down.
> > > > > > >
> > > > > > > The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> > > > > > > isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> > > > > > > is enabled regardless of _OSC:
> > > > > > > [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> > > > > > > ...
> > > > > > > [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> > > > > > >
> > > > > > > Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> > > > > > > disable PCIe features accordingly to resolve the issue.
> > > > > >
> > > > > > At least for some versions of this hardare, I recall ACPI is unaware of
> > > > > > any devices in the VMD domain; the platform can not see past the VMD
> > > > > > endpoint, so I throught the driver was supposed to always let the VMD
> > > > > > domain use OS native support regardless of the parent's ACPI _OSC.
> > > > >
> > > > > This is orthogonal to whether or not ACPI is aware of the VMD domain
> > > > > or the devices in it.
> > > > >
> > > > > If the platform firmware does not allow the OS to control specific
> > > > > PCIe features at the physical host bridge level, that extends to the
> > > > > VMD "bus", because it is just a way to expose a hidden part of the
> > > > > PCIe hierarchy.
> > > >
> > > > I don't understand what's going on here.  Do we understand the AER
> > > > message flood?  Are we just papering over it by disabling AER?
> > >
> > > To be more precise, AER is disabled by the platform vendor in BIOS to
> > > paper over the issue.
> > > The only viable solution for us is to follow their settings. We may
> > > never know what really happens underneath.
> > >
> > > Disabling ASPM/AER/PME etc is a normal practice for ODMs unfortunately.
> >
> > OK.  So this patch actually has nothing in particular to do with AER.
> > It's about making _OSC apply to *all* devices below a host bridge,
> > even those below a VMD.
> 
> Right.
> 
> > This is slightly ambiguous because while "_OSC applies to the entire
> > hierarchy originated by a PCI Host Bridge" (PCI Firmware spec r3.3,
> > sec 4.5.1), vmd.c creates a logical view where devices below the VMD
> > are in a separate hierarchy with a separate domain.
> 
> But from the HW perspective they still are in the same hierarchy below
> the original host bridge.

I suppose in some sense it's the same hierarchy because the electrical
connection all goes through a root port in the original host bridge,
but it's a little muddy because according to [1], a VMD spawns a new
hierarchy that can use an entirely new [bus 00-ff] space, and the
hierarchy below VMD uses a new config access mechanism independent of
ECAM or whatever the original host bridge uses.

> > The interpretation that _OSC applies to devices below VMD should work,
> > as long as it is possible for platform firmware to manage services
> > (AER, pciehp, etc) for things below VMD without getting in the way of
> > vmd.c.
> 
> vmd.c actually exposes things hidden by the firmware and the point of
> the patch is to still let the firmware control them if it wants/needs
> to IIUC.

My mental picture is that without vmd.c, Linux would enumerate the VMD
RCiEP itself, but none of the devices below the VMD would be visible.
With vmd.c, devices below the VMD RCiEP are visible.  Maybe this
picture is incorrect or too simple?

Apparently there's a firmware toggle, but I don't know exactly what it
does.  Maybe if the toggle is set to disable VMD, the VMD device looks
like a regular Root Port and the devices below are enumerated
normally even without any vmd.c?

> > But I think one implication of this is that we cannot support
> > hot-added VMDs.  For example, firmware that wants to manage AER will
> > use _OSC to retain AER control.  But if the firmware doesn't know how
> > VMDs work, it will not be able to handle AER for devices below the
> > VMD.
> 
> Well, the firmware needs to know how stuff works to hide it in the
> first place ...

[1] does also say that VMD is a Root Complex *Integrated* Endpoint,
which could not be hotplugged.  But I don't see anything in the code
that actually enforces or requires that, so I don't know what to make
of it.

If it's possible to hot-add a VMD device, firmware wouldn't be
involved in configuring it (assuming pciehp hotplug).  I assume the
new VMD would look like an Endpoint, and if vmd.c is present, maybe it
could construct a new hierarchy below that Endpoint?  In that case, we
have to assume firmware doesn't know how to operate VMD, so even if
firmware manages AER in general, it wouldn't be able to do it for
things below the VMD.

> > > > If an error occurs below a VMD, who notices and reports it?  If we
> > > > disable native AER below VMD because of _OSC, as this patch does, I
> > > > guess we're assuming the platform will handle AER events below VMD.
> > > > Is that really true?  Does the platform know how to find AER log
> > > > registers of devices below VMD?
> > > >
> > > > > The platform firmware does that through ACPI _OSC under the host
> > > > > bridge device (not under the VMD device) which it is very well aware
> > > > > of.

[1] https://git.kernel.org/linus/185a383ada2e
