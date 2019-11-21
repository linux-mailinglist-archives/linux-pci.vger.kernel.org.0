Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC7105CDA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 23:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUWun (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 17:50:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55758 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbfKUWum (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 17:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574376640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTk6XMOiYbuw5+XVlipRiSh5UzNmwzHGNqkkTsALVdg=;
        b=VWET5Mwrse85ED/PMXHoeSuFCOE36llSrM0SqEOC/Gq9CgD8wOzjg170wTrIdSwadBXTPK
        Se7eJiiAwAKiPDqzZvklMozCfa1lshRgVM+jWyeEOULkn+SlM76+DDCiBiiBoP+KjylGsF
        ltBhwl6mmSxVW1IsEMFsVKt2ADnegjQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-wlGj0P17NV2EUWk1JtUijQ-1; Thu, 21 Nov 2019 17:50:39 -0500
Received: by mail-qv1-f71.google.com with SMTP id g30so3370705qvb.11
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 14:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6kwu2ljuFRHJGSHsZ074oAeIVPpmWLJ+DvKmAed55k=;
        b=Ymh5sPFIIn7SvfOa8qkhmYrK/EXhUUT3PHqTz48bAqNK/jRLwrnLmoMf4JQ1PCai5d
         ywBirJPwVj3ntXw4SHfF+6YzdJe9Z6iwHyq2iJ4Uk6aTkBkMCx0eFKZZE3TEhj7D/bBw
         O3KEszjiPFFcs+krk1HPjxXNdB9qP6z+f1IL8qBLvdEGGlVS8y8yLbusk8jyetf5wCsB
         FDnrbaaG5r+ytyLcS+oLxny/JbyGrasIpNJ2xkxXnbq2UJ0yV1XxCvVW7yJAppw2LC88
         qxZAIllFtoeCq3MTQUOg0+GtjPa8hXd95yi5obzWQZKf69k0j6GBSJ8Ad/kqLDhCSlPN
         KT2A==
X-Gm-Message-State: APjAAAXxKlTMEwQx6L0YMcOYOO+iF4DBYSfbsqkyIOeFUDokA1pHzE4M
        Hq/FO7sygmk2f6rp5jGHSVEyTx3qH/3titwjKcm21VrWMgEv1KDJ43AU/xpg5rRdOxx4MFscU2s
        dulkkEUCj0ExrSuxFlGzUZT4vxgQSpq451I97
X-Received: by 2002:a37:8285:: with SMTP id e127mr2677680qkd.62.1574376638875;
        Thu, 21 Nov 2019 14:50:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqziB5Ucb8ZFpCpITvN4kvLRDkloqv4Emub8IRaRDSPVC7EbFpNg+VGTx80DbnaXEZuqQUj9nX/wiwQNyS7b2t8=
X-Received: by 2002:a37:8285:: with SMTP id e127mr2677652qkd.62.1574376638429;
 Thu, 21 Nov 2019 14:50:38 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
 <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
 <20191121194942.GY11621@lahna.fi.intel.com> <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 21 Nov 2019 23:50:26 +0100
Message-ID: <CACO55tvFeTFo3gGdL02gnWMMk+AHPPb=hntkre0ZcA6WvKcV1A@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
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
X-MC-Unique: wlGj0P17NV2EUWk1JtUijQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 11:39 PM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Thu, Nov 21, 2019 at 8:49 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 04:43:24PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Nov 21, 2019 at 1:52 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Thu, Nov 21, 2019 at 01:46:14PM +0200, Mika Westerberg wrote:
> > > > > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > > > > <mika.westerberg@intel.com> wrote:
> > > > > > >
> > > > > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki w=
rote:
> > > > > > > > > last week or so I found systems where the GPU was under t=
he "PCI
> > > > > > > > > Express Root Port" (name from lspci) and on those systems=
 all of that
> > > > > > > > > seems to work. So I am wondering if it's indeed just the =
0x1901 one,
> > > > > > > > > which also explains Mikas case that Thunderbolt stuff wor=
ks as devices
> > > > > > > > > never get populated under this particular bridge controll=
er, but under
> > > > > > > > > those "Root Port"s
> > > > > > > >
> > > > > > > > It always is a PCIe port, but its location within the SoC m=
ay matter.
> > > > > > >
> > > > > > > Exactly. Intel hardware has PCIe ports on CPU side (these are=
 called
> > > > > > > PEG, PCI Express Graphics, ports), and the PCH side. I think =
the IP is
> > > > > > > still the same.
> > > > > > >
> > > > > > > > Also some custom AML-based power management is involved and=
 that may
> > > > > > > > be making specific assumptions on the configuration of the =
SoC and the
> > > > > > > > GPU at the time of its invocation which unfortunately are n=
ot known to
> > > > > > > > us.
> > > > > > > >
> > > > > > > > However, it looks like the AML invoked to power down the GP=
U from
> > > > > > > > acpi_pci_set_power_state() gets confused if it is not in PC=
I D0 at
> > > > > > > > that point, so it looks like that AML tries to access devic=
e memory on
> > > > > > > > the GPU (beyond the PCI config space) or similar which is n=
ot
> > > > > > > > accessible in PCI power states below D0.
> > > > > > >
> > > > > > > Or the PCI config space of the GPU when the parent root port =
is in D3hot
> > > > > > > (as it is the case here). Also then the GPU config space is n=
ot
> > > > > > > accessible.
> > > > > >
> > > > > > Why would the parent port be in D3hot at that point?  Wouldn't =
that be
> > > > > > a suspend ordering violation?
> > > > >
> > > > > No. We put the GPU into D3hot first,
> > >
> > > OK
> > >
> > > Does this involve any AML, like a _PS3 under the GPU object?
> >
> > I don't see _PS3 (nor _PS0) for that object. If I read it right the GPU
> > itself is not described in ACPI tables at all.
>
> OK
>
> > > > > then the root port and then turn
> > > > > off the power resource (which is attached to the root port) resul=
ting
> > > > > the topology entering D3cold.
> > > >
> > > > I don't see that happening in the AML though.
> > >
> > > Which AML do you mean, specifically?  The _OFF method for the root
> > > port's _PR3 power resource or something else?
> >
> > The root port's _OFF method for the power resource returned by its _PR3=
.
>
> OK, so without the $subject patch we (1) program the downstream
> component (GPU) into D3hot, then we (2) program the port holding it
> into D3hot and then we (3) let the AML (_OFF for the power resource
> listed by _PR3 under the port object) run.
>
> Something strange happens at this point (and I guess that _OFF doesn't
> even reach the point where it removes power from the port which is why
> we see a lock-up).
>

it does though. I will post the data shortly (with the change in power
consumption), as I also want to do the ACPI traces now.

> We know that skipping (1) makes things work and we kind of suspect
> that skipping (3) would make things work either, but what about doing
> (1) and (3) without (2)?
>
> > > > Basically the difference is that when Windows 7 or Linux (the _REV=
=3D=3D5
> > > > check) then we directly do link disable whereas in Windows 8+ we in=
voke
> > > > LKDS() method that puts the link into L2/L3. None of the fields the=
y
> > > > access seem to touch the GPU itself.
> > >
> > > So that may be where the problem is.
> > >
> > > Putting the downstream component into PCI D[1-3] is expected to put
> > > the link into L1, so I'm not sure how that plays with the later
> > > attempt to put it into L2/L3 Ready.
> >
> > That should be fine. What I've seen the link goes into L1 when
> > downstream component is put to D-state (not D0) and then it is put back
> > to L0 when L2/3 ready is propagated. Eventually it goes into L2 or L3.
>
> Well, that's the expected behavior, but the observed behavior isn't as
> expected. :-)
>
> > > Also, L2/L3 Ready is expected to be transient, so finally power shoul=
d
> > > be removed somehow.
> >
> > There is GPIO for both power and PERST, I think the line here:
> >
> >   \_SB.SGOV (0x01010004, Zero)
> >
> > is the one that removes power.
>
> OK
>
> > > > LKDS() for the first PEG port looks like this:
> > > >
> > > >    P0L2 =3D One
> > > >    Sleep (0x10)
> > > >    Local0 =3D Zero
> > > >    While (P0L2)
> > > >    {
> > > >         If ((Local0 > 0x04))
> > > >         {
> > > >             Break
> > > >         }
> > > >
> > > >         Sleep (0x10)
> > > >         Local0++
> > > >    }
> > > >
> > > > One thing that comes to mind is that the loop can end even if P0L2 =
is
> > > > not cleared as it does only 5 iterations with 16 ms sleep between. =
Maybe
> > > > Sleep() is implemented differently in Windows? I mean Linux may be
> > > > "faster" here and return prematurely and if we leave the port into =
D0
> > > > this does not happen, or something. I'm just throwing out ideas :)
> > >
> > > But this actually works for the downstream component in D0, doesn't i=
t?
> >
> > It does and that leaves the link in L0 so it could be that then the
> > above AML works better or something.
>
> That would be my guess.
>
> > That reminds me, ASPM may have something to do with this as well.
>
> Not really if D-states are involved.
>
> > > Also, if the downstream component is in D0, the port actually should
> > > stay in D0 too, so what would happen with the $subject patch applied?
> >
> > Parent port cannot be lower D-state than the child so I agree it should
> > stay in D0 as well. However, it seems that what happens is that the
> > issue goes away :)
>
> Well, at least this is kind of out of the spec.
>
> Note that pci_pm_suspend_noirq() won't let the port go into D3 if the
> downstream device is in D0, so the $subject patch will not work as
> expected in the suspend-to-idle case.
>
> Also we really should make up our minds on whether or not to force
> PCIe ports to stay in D0 when downstream devices are in D0 and be
> consequent about that.  Right now we do one thing during system-wide
> suspend and the other one in PM-runtime, which is confusing.
>
> The current design is mostly based on the PCI PM Spec 1.2, so it would
> be consequent to follow system-wide suspend in PM-runtime and avoid
> putting PCIe ports holding devices in D0 into any low-power states.
> but that would make the approach in the $subject patch ineffective.
>
> Moreover, the fact that there are separate branches for "Windows 7"
> and "Windows 8+" kind of suggest a change in the expected behavior
> between Windows 7 and Windows 8, from the AML perspective.  I would
> guess that Windows 7 followed PCI PM 1.2 and Windows 8 (and later)
> does something else.  Now, the structure of the "Windows 8+" branch
> described by you suggests that, at least in the cases when it is going
> to remove power from the port eventually, it goes straight for the
> link preparation (the L2/L3 Ready transition) and power removal
> without bothering to program the downstream device and port into D3hot
> (because that's kind of redundant).
>
> That hypothetical "Windows 8+" approach may really work universally,
> because it doesn't seem to break any rules (going straight from D0 to
> D3cold is not disallowed and doing that for both a port and a
> downstream device at the same time is kind of OK either, as long as
> the link is ready for that).
>

