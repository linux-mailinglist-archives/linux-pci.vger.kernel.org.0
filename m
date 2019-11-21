Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0D10526F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 13:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUMxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 07:53:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48019 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726701AbfKUMxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 07:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574340795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYVd9Wx7thzZZDxf1X7Bt3zWOGy3VRzz5kqCnYWG4J0=;
        b=dnaSGB9CbIWLtgND5aCeA8ZOWXq+N0Bsbnr9eo7nSLS9hUe7Q0sYECTXIrQ3vNOvqg9DEx
        Tuu4L9Pf+UTue1kuhKUGlYwIj4VFGDyo85PCWlsKX5S1CtbdtdzN/3ejH6Di4YpWHLSVhR
        c4fRDXCETtw+4WHvGy/P0S46BC0ClXE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-jeKXKxWDNTu7FjiN4c5X0w-1; Thu, 21 Nov 2019 07:53:11 -0500
Received: by mail-qv1-f71.google.com with SMTP id d12so2191970qvj.16
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 04:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEM0PnaeoKHLdOkLMiZXYw1vcMAsLpGiAJp9uLo00xA=;
        b=DUB7O7HY/CO+m6+dlJDd30L2F6hF+CarsNPIlVQD+xFuHnIin1+txbGIuxUo+TbHEQ
         1esJPae+IHgz7sqBjybXjpSKN89tl0J5nJbkBWrU4NEzF9dm3rdhw2zf37MvgZ8Lgx0C
         tGgm8lGnoTb3ppfAR3oQazWFC2q+ysbczUuEsp6g4breELRjfsRo3yvxvdYmsKj8LY7H
         2xUy0HG0NvMzsLV2+weF9S7mO/QOZ2VVe6haKxRh2Kr6jJxgS5FmHek9gJ1Bwi4dNNda
         npyLZq3KW0NavsiZ0imPEpFWXfxGaki1zp9rIHrJTyRpcNYE4e3UvY9+uSgxRFgfASv1
         TenA==
X-Gm-Message-State: APjAAAWBzD3///JHHWHP4hzgx+8MYOmYGqU3+sckT7ifO7ycAL/Z1lEP
        TXgn9urHiSknFW1+cCVJbG923e+heEMAp9zcp6O22pyfMfPY3+PsJqROjvzTR73BCicHDlkOZYd
        A7dmcNoo03qYcMaYSEwJVOecaqCbVlV9K/RqX
X-Received: by 2002:ac8:5557:: with SMTP id o23mr8377462qtr.378.1574340791047;
        Thu, 21 Nov 2019 04:53:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqw52DQ6/+PFF1D7ZWko3HUNgikWPVpBkNz+T6JsTEqXPznpS5K5F7R1sz/hNMU3oG6dRHsmVibiYzYtcy2E5Vc=
X-Received: by 2002:ac8:5557:: with SMTP id o23mr8377430qtr.378.1574340790766;
 Thu, 21 Nov 2019 04:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com>
In-Reply-To: <20191121114610.GW11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 21 Nov 2019 13:52:57 +0100
Message-ID: <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
X-MC-Unique: jeKXKxWDNTu7FjiN4c5X0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 12:46 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > > > last week or so I found systems where the GPU was under the "PCI
> > > > > Express Root Port" (name from lspci) and on those systems all of =
that
> > > > > seems to work. So I am wondering if it's indeed just the 0x1901 o=
ne,
> > > > > which also explains Mikas case that Thunderbolt stuff works as de=
vices
> > > > > never get populated under this particular bridge controller, but =
under
> > > > > those "Root Port"s
> > > >
> > > > It always is a PCIe port, but its location within the SoC may matte=
r.
> > >
> > > Exactly. Intel hardware has PCIe ports on CPU side (these are called
> > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP i=
s
> > > still the same.
> > >

yeah, I meant the bridge controller with the ID 0x1901 is on the CPU
side. And if the Nvidia GPU is on a port on the PCH side it all seems
to work just fine.

> > > > Also some custom AML-based power management is involved and that ma=
y
> > > > be making specific assumptions on the configuration of the SoC and =
the
> > > > GPU at the time of its invocation which unfortunately are not known=
 to
> > > > us.
> > > >
> > > > However, it looks like the AML invoked to power down the GPU from
> > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 at
> > > > that point, so it looks like that AML tries to access device memory=
 on
> > > > the GPU (beyond the PCI config space) or similar which is not
> > > > accessible in PCI power states below D0.
> > >
> > > Or the PCI config space of the GPU when the parent root port is in D3=
hot
> > > (as it is the case here). Also then the GPU config space is not
> > > accessible.
> >
> > Why would the parent port be in D3hot at that point?  Wouldn't that be
> > a suspend ordering violation?
>
> No. We put the GPU into D3hot first, then the root port and then turn
> off the power resource (which is attached to the root port) resulting
> the topology entering D3cold.
>

If the kernel does a D0 -> D3hot -> D0 cycle this works as well, but
the power savings are way lower, so I kind of prefer skipping D3hot
instead of D3cold. Skipping D3hot doesn't seem to make any difference
in power savings in my testing.

> > > I took a look at the HP Omen ACPI tables which has similar problem an=
d
> > > there is also check for Windows 7 (but not Linux) so I think one
> > > alternative workaround would be to add these devices into
> > > acpi_osi_dmi_table[] where .callback is set to dmi_disable_osi_win8 (=
or
> > > pass 'acpi_osi=3D"!Windows 2012"' in the kernel command line).
> >
> > I'd like to understand the facts that have been established so far
> > before deciding what to do about them. :-)
>
> Yes, I agree :)
>

Yeah.. and I think those would be too many as we know of several
models with this laptops from Lenovo, Dell and HP and random other
models from random other OEMs. I think we won't ever be able to
blacklist all models if we go that way as those might be just way too
many. Also I know from some reports on bumblebee bugs (hitting the
same issue essentially) that the acpi_osi overwrite didn't help every
user.

