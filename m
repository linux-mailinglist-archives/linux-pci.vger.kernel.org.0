Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1364B87D2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 13:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiBPMh5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 07:37:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiBPMh4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 07:37:56 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFD1A399;
        Wed, 16 Feb 2022 04:37:43 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id a7so2559752ybj.12;
        Wed, 16 Feb 2022 04:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GR3qfBOskF1geBQk+Kw8y3oufWn3aW+k8M3B4Rxy0Ng=;
        b=mK8wEeYrHXLWQYhC0NEOEJcyWrjWN4JoNtfLkNCGqVNpVtvKgpfrQnLYCd/SwnUa2o
         VsTQieCcuhmWU+BPdzFngb2ajFqSDiKv7l5Y9HPB4nnyGFtgXDlHnbNIJ2uCrytt+f0o
         oCQw3w7xuEMuoFbbtCp7LkbPMSY2x6Of2mH1uGNgi+1rO/Nl24OCo1pPw1OiUam2k0ml
         RpkiU1EhGa4WrgG5j4tHCZt8QDWCxb1r40LGxnAaCS0aI5InxbuKJ8KfFkQtUwvvBGJA
         Ow/XsUDJd0i/zDaZymbdMI70XHifJCwt8lMVdCwN4BDXLiMb4t3WS/CPI0o/BKWYUqJr
         NThQ==
X-Gm-Message-State: AOAM530+Gs5anwefm5EDr56vAIHRSOL8h2CajtyIEmCIGIveQTwyeFqa
        0C0CKqF/y/0bFUwioOEYzDpVKoKBCFJ2QO3F2JPFA5+rnNk=
X-Google-Smtp-Source: ABdhPJxy6INMZmU51GIgS8kVS4N2b/ccgnY+ep70go2UqR5ZSwVbcS8Gyqm0t9gs26RJILh7NZt80sIjFCiOY3j0v04=
X-Received: by 2002:a05:6902:10c7:b0:61e:1639:df86 with SMTP id
 w7-20020a05690210c700b0061e1639df86mr1967990ybu.78.1645015062762; Wed, 16 Feb
 2022 04:37:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0i6+EMMGuKckhtTdt7TgC3LbofW7oS7B5=McSNjEh1yKA@mail.gmail.com>
 <20220216015303.GA137820@bhelgaas>
In-Reply-To: <20220216015303.GA137820@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Feb 2022 13:37:29 +0100
Message-ID: <CAJZ5v0irC5WJAKjzR6niY4ai965td_6UqF=KXKhCjxaxBGuNtw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 16, 2022 at 2:53 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Feb 15, 2022 at 06:09:15PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 15, 2022 at 4:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Feb 14, 2022 at 08:23:05AM +0800, Kai-Heng Feng wrote:
> > > > On Thu, Feb 10, 2022 at 5:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Tue, Dec 07, 2021 at 02:15:04PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
> > > > > > > On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
> > > > > > > > When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> > > > > > > > combination causes AER message flood and drags the system performance
> > > > > > > > down.
> > > > > > > >
> > > > > > > > The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> > > > > > > > isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> > > > > > > > is enabled regardless of _OSC:
> > > > > > > > [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> > > > > > > > ...
> > > > > > > > [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> > > > > > > >
> > > > > > > > Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> > > > > > > > disable PCIe features accordingly to resolve the issue.
> > > > > > >
> > > > > > > At least for some versions of this hardare, I recall ACPI is unaware of
> > > > > > > any devices in the VMD domain; the platform can not see past the VMD
> > > > > > > endpoint, so I throught the driver was supposed to always let the VMD
> > > > > > > domain use OS native support regardless of the parent's ACPI _OSC.
> > > > > >
> > > > > > This is orthogonal to whether or not ACPI is aware of the VMD domain
> > > > > > or the devices in it.
> > > > > >
> > > > > > If the platform firmware does not allow the OS to control specific
> > > > > > PCIe features at the physical host bridge level, that extends to the
> > > > > > VMD "bus", because it is just a way to expose a hidden part of the
> > > > > > PCIe hierarchy.
> > > > >
> > > > > I don't understand what's going on here.  Do we understand the AER
> > > > > message flood?  Are we just papering over it by disabling AER?
> > > >
> > > > To be more precise, AER is disabled by the platform vendor in BIOS to
> > > > paper over the issue.
> > > > The only viable solution for us is to follow their settings. We may
> > > > never know what really happens underneath.
> > > >
> > > > Disabling ASPM/AER/PME etc is a normal practice for ODMs unfortunately.
> > >
> > > OK.  So this patch actually has nothing in particular to do with AER.
> > > It's about making _OSC apply to *all* devices below a host bridge,
> > > even those below a VMD.
> >
> > Right.
> >
> > > This is slightly ambiguous because while "_OSC applies to the entire
> > > hierarchy originated by a PCI Host Bridge" (PCI Firmware spec r3.3,
> > > sec 4.5.1), vmd.c creates a logical view where devices below the VMD
> > > are in a separate hierarchy with a separate domain.
> >
> > But from the HW perspective they still are in the same hierarchy below
> > the original host bridge.
>
> I suppose in some sense it's the same hierarchy because the electrical
> connection all goes through a root port in the original host bridge,
> but it's a little muddy because according to [1], a VMD spawns a new
> hierarchy that can use an entirely new [bus 00-ff] space, and the
> hierarchy below VMD uses a new config access mechanism independent of
> ECAM or whatever the original host bridge uses.

IIUC, that's part of the hiding mechanism.  See below.

> > > The interpretation that _OSC applies to devices below VMD should work,
> > > as long as it is possible for platform firmware to manage services
> > > (AER, pciehp, etc) for things below VMD without getting in the way of
> > > vmd.c.
> >
> > vmd.c actually exposes things hidden by the firmware and the point of
> > the patch is to still let the firmware control them if it wants/needs
> > to IIUC.
>
> My mental picture is that without vmd.c, Linux would enumerate the VMD
> RCiEP itself, but none of the devices below the VMD would be visible.
> With vmd.c, devices below the VMD RCiEP are visible.  Maybe this
> picture is incorrect or too simple?

It doesn't reflect what really happens AFAICS.  The devices that
appear to be located below the VMD RCiEP are not there physically.

> Apparently there's a firmware toggle, but I don't know exactly what it
> does.  Maybe if the toggle is set to disable VMD, the VMD device looks
> like a regular Root Port and the devices below are enumerated
> normally even without any vmd.c?

If the toggle is set to disable VMD, all of the devices that would be
hidden by the firmware and only visible through the VMD mechanisms
show up in their proper locations in the original PCIe hierarchy that
they belong to physically.

> > > But I think one implication of this is that we cannot support
> > > hot-added VMDs.  For example, firmware that wants to manage AER will
> > > use _OSC to retain AER control.  But if the firmware doesn't know how
> > > VMDs work, it will not be able to handle AER for devices below the
> > > VMD.
> >
> > Well, the firmware needs to know how stuff works to hide it in the
> > first place ...
>
> [1] does also say that VMD is a Root Complex *Integrated* Endpoint,
> which could not be hotplugged.  But I don't see anything in the code
> that actually enforces or requires that, so I don't know what to make
> of it.

[1] is correct.

> If it's possible to hot-add a VMD device, firmware wouldn't be
> involved in configuring it (assuming pciehp hotplug).  I assume the
> new VMD would look like an Endpoint, and if vmd.c is present, maybe it
> could construct a new hierarchy below that Endpoint?  In that case, we
> have to assume firmware doesn't know how to operate VMD, so even if
> firmware manages AER in general, it wouldn't be able to do it for
> things below the VMD.

No, this really is only about re-exposing some of the existing PCIe
hierarchy that was hidden by the firmware from the OS.  Physically, it
is still the same hierarchy all the time.

> > > > > If an error occurs below a VMD, who notices and reports it?  If we
> > > > > disable native AER below VMD because of _OSC, as this patch does, I
> > > > > guess we're assuming the platform will handle AER events below VMD.
> > > > > Is that really true?  Does the platform know how to find AER log
> > > > > registers of devices below VMD?
> > > > >
> > > > > > The platform firmware does that through ACPI _OSC under the host
> > > > > > bridge device (not under the VMD device) which it is very well aware
> > > > > > of.
>
> [1] https://git.kernel.org/linus/185a383ada2e
