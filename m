Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45A10527C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 13:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKUM5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 07:57:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42580 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726532AbfKUM5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 07:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574341032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVnuS3G07UEp6AIL04Xz4q+Tzbj4PQPwyBSCk9uHGkw=;
        b=GF2GzW1SDMVsf9DdCexQggBjeiNGrZSMC7ugfDMgb3C8TvjztFBs1oJ2eJzQBcp/oTY5e0
        TnYfmLmTiZ3u53zCIi72E7D+IwWdsx2S6yVResv8ci5Uh6lAGx1fSEfV2aurxMXRIuqpAR
        dWuwcNcGt6rJ8o65JtZjklc4O0FSvdM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-op4j_shNNbCHsMNcArYy7A-1; Thu, 21 Nov 2019 07:57:10 -0500
Received: by mail-qt1-f199.google.com with SMTP id j18so2187569qtp.15
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 04:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QH9raaSEy0ZT3Ng+Xr/UbfMvZg5iClSyjL5MYEeeB0o=;
        b=Gg4Zezhn1bz0CvuZNeZ/sEpzPMUzFyxPtqK4OBPNKTZeYgQ6WnTNJoNwviAxO4wMBW
         7S11+3EaIR/WUfKlIkuR/lrEimgyUyrHZHzYw3n+aQkBEY+DTSaTI3FQ8wzbsacsQEQF
         nRvKgEFV294oe4guJoxzEJT9CLPVn/HtiBwa4IPAwNomI2e/s6YuoDzHwQP9BaOPXRnu
         WLHSZMixbiPt77YPRbky7i8Ag9ZJwuXweK/F7RWqlSn9jiIDet4W0wUELnldF51gfAlQ
         s9GZaikyUXf7WMZc6oXo1V0WK7dRTQtpjOa4DpRawK5uq/4RdPCFfrFzM8YSkYq9ofW4
         +5oA==
X-Gm-Message-State: APjAAAWy+1kLFw2QRG5aXA2YnXkrnm9jHqe6mjETVyynsKzVvCF3u3mR
        RXz0r40aQZL4iizX1rrCi2r3ahYRuxYyGvyrfVXmkjUc5jyoYXif2WGWiN13bNp9i70if50fIar
        ROTv+X/HNgs+903aqgIJ7lGJ2hE8VFMkZ4ozC
X-Received: by 2002:ac8:7550:: with SMTP id b16mr8247880qtr.286.1574341029751;
        Thu, 21 Nov 2019 04:57:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCB3+oy9LxTLupf+9fIdsK0rCf/DUfxOcnQaIfyPvrUsIjLHSyzhlMj9XMgXerrNXcdpm7ZYcN/G4r6b/xReI=
X-Received: by 2002:ac8:7550:: with SMTP id b16mr8247859qtr.286.1574341029535;
 Thu, 21 Nov 2019 04:57:09 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
In-Reply-To: <20191121125236.GX11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 21 Nov 2019 13:56:57 +0100
Message-ID: <CACO55ttOgx=jyCh_uZLH4t8C5SW0f2u3BSrw93vPmusM98p0Mg@mail.gmail.com>
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
X-MC-Unique: op4j_shNNbCHsMNcArYy7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
> > > > > > last week or so I found systems where the GPU was under the "PC=
I
> > > > > > Express Root Port" (name from lspci) and on those systems all o=
f that
> > > > > > seems to work. So I am wondering if it's indeed just the 0x1901=
 one,
> > > > > > which also explains Mikas case that Thunderbolt stuff works as =
devices
> > > > > > never get populated under this particular bridge controller, bu=
t under
> > > > > > those "Root Port"s
> > > > >
> > > > > It always is a PCIe port, but its location within the SoC may mat=
ter.
> > > >
> > > > Exactly. Intel hardware has PCIe ports on CPU side (these are calle=
d
> > > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP=
 is
> > > > still the same.
> > > >
> > > > > Also some custom AML-based power management is involved and that =
may
> > > > > be making specific assumptions on the configuration of the SoC an=
d the
> > > > > GPU at the time of its invocation which unfortunately are not kno=
wn to
> > > > > us.
> > > > >
> > > > > However, it looks like the AML invoked to power down the GPU from
> > > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 a=
t
> > > > > that point, so it looks like that AML tries to access device memo=
ry on
> > > > > the GPU (beyond the PCI config space) or similar which is not
> > > > > accessible in PCI power states below D0.
> > > >
> > > > Or the PCI config space of the GPU when the parent root port is in =
D3hot
> > > > (as it is the case here). Also then the GPU config space is not
> > > > accessible.
> > >
> > > Why would the parent port be in D3hot at that point?  Wouldn't that b=
e
> > > a suspend ordering violation?
> >
> > No. We put the GPU into D3hot first, then the root port and then turn
> > off the power resource (which is attached to the root port) resulting
> > the topology entering D3cold.
>
> I don't see that happening in the AML though.
>
> Basically the difference is that when Windows 7 or Linux (the _REV=3D=3D5
> check) then we directly do link disable whereas in Windows 8+ we invoke
> LKDS() method that puts the link into L2/L3. None of the fields they
> access seem to touch the GPU itself.
>
> LKDS() for the first PEG port looks like this:
>
>    P0L2 =3D One
>    Sleep (0x10)
>    Local0 =3D Zero
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
>

keep in mind, that I am able to hit this bug with my python script:
https://raw.githubusercontent.com/karolherbst/pci-stub-runpm/master/nv_runp=
m_bug_test.py

