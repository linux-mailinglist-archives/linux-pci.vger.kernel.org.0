Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62F1055E3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 16:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUPni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 10:43:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37137 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUPni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 10:43:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id d5so3325616otp.4;
        Thu, 21 Nov 2019 07:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6BtIcSR6Sz2/7y/lGE3fC0q1eR/CKJYxQr5CTA/9Uc=;
        b=pOhfT9kJ9HEyHZ+7YqsMjsJ+4osY8nBU/WgE0IKnWh6msl4uQx+4Sg2jK3q6qcW2CQ
         crFwN/1Te5TvAzC+5eM22SdDiZ6yqSYk1t8AV0SbW9foKMsHy2dblhmfT6eJUHKJFOAS
         bic8yDNUhdLRvTgKRY3zjly7b6D+mTUO9Bn7dtHLeXOTphZuWgF+D9V/pWBelIlX3BCf
         EVQRqQXzMFEUohiSvdFVb0moxpsFdohGCpFOwiohtPUD/Jiou5L6a7D0tBXijd5HC9PJ
         SbEMk01zd2cFJl4M84EXr+0VPtO+DFSX+3aRS8eRjwdg02C6mzimAJfdisMJulc/g7Sj
         LqjA==
X-Gm-Message-State: APjAAAX0m4KP023mktn65lPnA2waSXnC0potUZmLfg71FltJCjK4dvH0
        g2KAWSff9YjlOpiEKJJH6zEfgCjD3bPkOzteYYk=
X-Google-Smtp-Source: APXvYqxszDM90W/tRIlxbpBS9iYycKQwHojBugtimrAfg57FfxPfoUZyiQ/a8iP2L0RYZnuBEcgjDJESRlnjbPGrO6M=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr7175465otg.262.1574351015588;
 Thu, 21 Nov 2019 07:43:35 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
In-Reply-To: <20191121125236.GX11621@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 16:43:24 +0100
Message-ID: <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 1:52 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Thu, Nov 21, 2019 at 01:46:14PM +0200, Mika Westerberg wrote:
> > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > > > > last week or so I found systems where the GPU was under the "PCI
> > > > > > Express Root Port" (name from lspci) and on those systems all of that
> > > > > > seems to work. So I am wondering if it's indeed just the 0x1901 one,
> > > > > > which also explains Mikas case that Thunderbolt stuff works as devices
> > > > > > never get populated under this particular bridge controller, but under
> > > > > > those "Root Port"s
> > > > >
> > > > > It always is a PCIe port, but its location within the SoC may matter.
> > > >
> > > > Exactly. Intel hardware has PCIe ports on CPU side (these are called
> > > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP is
> > > > still the same.
> > > >
> > > > > Also some custom AML-based power management is involved and that may
> > > > > be making specific assumptions on the configuration of the SoC and the
> > > > > GPU at the time of its invocation which unfortunately are not known to
> > > > > us.
> > > > >
> > > > > However, it looks like the AML invoked to power down the GPU from
> > > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 at
> > > > > that point, so it looks like that AML tries to access device memory on
> > > > > the GPU (beyond the PCI config space) or similar which is not
> > > > > accessible in PCI power states below D0.
> > > >
> > > > Or the PCI config space of the GPU when the parent root port is in D3hot
> > > > (as it is the case here). Also then the GPU config space is not
> > > > accessible.
> > >
> > > Why would the parent port be in D3hot at that point?  Wouldn't that be
> > > a suspend ordering violation?
> >
> > No. We put the GPU into D3hot first,

OK

Does this involve any AML, like a _PS3 under the GPU object?

> > then the root port and then turn
> > off the power resource (which is attached to the root port) resulting
> > the topology entering D3cold.
>
> I don't see that happening in the AML though.

Which AML do you mean, specifically?  The _OFF method for the root
port's _PR3 power resource or something else?

> Basically the difference is that when Windows 7 or Linux (the _REV==5
> check) then we directly do link disable whereas in Windows 8+ we invoke
> LKDS() method that puts the link into L2/L3. None of the fields they
> access seem to touch the GPU itself.

So that may be where the problem is.

Putting the downstream component into PCI D[1-3] is expected to put
the link into L1, so I'm not sure how that plays with the later
attempt to put it into L2/L3 Ready.

Also, L2/L3 Ready is expected to be transient, so finally power should
be removed somehow.

> LKDS() for the first PEG port looks like this:
>
>    P0L2 = One
>    Sleep (0x10)
>    Local0 = Zero
>    While (P0L2)
>    {
>         If ((Local0 > 0x04))
>         {
>             Break
>         }
>
>         Sleep (0x10)
>         Local0++
>    }
>
> One thing that comes to mind is that the loop can end even if P0L2 is
> not cleared as it does only 5 iterations with 16 ms sleep between. Maybe
> Sleep() is implemented differently in Windows? I mean Linux may be
> "faster" here and return prematurely and if we leave the port into D0
> this does not happen, or something. I'm just throwing out ideas :)

But this actually works for the downstream component in D0, doesn't it?

Also, if the downstream component is in D0, the port actually should
stay in D0 too, so what would happen with the $subject patch applied?
