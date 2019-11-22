Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD07A105D90
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 01:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfKVANu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 19:13:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56392 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726265AbfKVANt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 19:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574381627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uN54nyKovZpjX15ad46fYr/x8ehKgPmORA/aMiVni9I=;
        b=LVU57+0+KInoFRrkRNxX3IkWRHjfZGeUfSAFUFSbE+X83rRQUgorHcdhO/r+vKURwcEOew
        qKwf+38NdH2qfqOTnniNSHMTqxX7FtWqRJ+elew5OTx1rR4+md0IWYCfEpHCskg2UaeDFO
        jD7eFOPcwtYrksT0NgpJZtFE6lhIhO0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-FRqBdz_lN7ONr_OcLhTx2A-1; Thu, 21 Nov 2019 19:13:44 -0500
Received: by mail-qt1-f200.google.com with SMTP id x50so3510954qth.4
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 16:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zw+Oguaqsrzx3D3QkM2PFuC8jKyKAZCHmY4jQUCNjDs=;
        b=BCW6ouSwpbff3kVf2G3AU2npV8Nvfqd+5U5In4GmnAror83Z1RKZngTHzINfIZROgJ
         czIHvSHQVRQbrherlpLPyQr+Rz6OkdKlfNOe1xKLSeQjShTz4f27o2w0YpVwBmGyQd0t
         mkLtlGzLArMXBRJN/MUCgxe+XSBdzWNdljxU2bKiwmIfdy15bRU79yB7DuUHb/Yttqb1
         LfKDHimXC2svh033kUIE4GNJow4GnFQHIBH758nHs3432N/UX1uKhZAiNcnmUcVajBYE
         +jzFlq5yIwVD6KR3++vRAdvlYksjHdtm4elR2ufAgZ1vvfYxywVeGwCsix6eZUltvtMx
         C62A==
X-Gm-Message-State: APjAAAVm4ok7QFZl3ZOdmQjR4xNYG+/F87Vt+7hm4RqkMyd5En1iISl+
        pBAhN38sKLNpxIqFTqkJ8Vg0ORsaGBZyYCW/R11bi/L0mX/x9rKwwDw7V3mjEIzxiaMske8oHSF
        UVeT2I3Qb/RmFbJVTUV5C9RvNUhDwpJe4rNxR
X-Received: by 2002:a0c:baad:: with SMTP id x45mr10952480qvf.230.1574381623554;
        Thu, 21 Nov 2019 16:13:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQeNbFPjt9g+SPOPeQ04yvEr8s+o4BozjzIBZZ3TrnGaEiSiHTX2apI5nYqFjPEWJt1G9UpqEUlJOEWQETsLY=
X-Received: by 2002:a0c:baad:: with SMTP id x45mr10952438qvf.230.1574381622981;
 Thu, 21 Nov 2019 16:13:42 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
 <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
 <20191121194942.GY11621@lahna.fi.intel.com> <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
 <CACO55tvFeTFo3gGdL02gnWMMk+AHPPb=hntkre0ZcA6WvKcV1A@mail.gmail.com>
In-Reply-To: <CACO55tvFeTFo3gGdL02gnWMMk+AHPPb=hntkre0ZcA6WvKcV1A@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 22 Nov 2019 01:13:31 +0100
Message-ID: <CACO55tvkQyYYnCs71_nJuNFm4f8kkvBqje8WeZGph7X+2zO3aA@mail.gmail.com>
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
X-MC-Unique: FRqBdz_lN7ONr_OcLhTx2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

so while trying to test with d3cold disabled, I noticed that I run
into the exact same error. And I verified that the
\_SB.PCI0.PEG0.PG00._STA returns 1, which indicates it should still be
turned on.

On Thu, Nov 21, 2019 at 11:50 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Thu, Nov 21, 2019 at 11:39 PM Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> >
> > On Thu, Nov 21, 2019 at 8:49 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 04:43:24PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Nov 21, 2019 at 1:52 PM Mika Westerberg
> > > > <mika.westerberg@intel.com> wrote:
> > > > >
> > > > > On Thu, Nov 21, 2019 at 01:46:14PM +0200, Mika Westerberg wrote:
> > > > > > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wro=
te:
> > > > > > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > > > > > <mika.westerberg@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki=
 wrote:
> > > > > > > > > > last week or so I found systems where the GPU was under=
 the "PCI
> > > > > > > > > > Express Root Port" (name from lspci) and on those syste=
ms all of that
> > > > > > > > > > seems to work. So I am wondering if it's indeed just th=
e 0x1901 one,
> > > > > > > > > > which also explains Mikas case that Thunderbolt stuff w=
orks as devices
> > > > > > > > > > never get populated under this particular bridge contro=
ller, but under
> > > > > > > > > > those "Root Port"s
> > > > > > > > >
> > > > > > > > > It always is a PCIe port, but its location within the SoC=
 may matter.
> > > > > > > >
> > > > > > > > Exactly. Intel hardware has PCIe ports on CPU side (these a=
re called
> > > > > > > > PEG, PCI Express Graphics, ports), and the PCH side. I thin=
k the IP is
> > > > > > > > still the same.
> > > > > > > >
> > > > > > > > > Also some custom AML-based power management is involved a=
nd that may
> > > > > > > > > be making specific assumptions on the configuration of th=
e SoC and the
> > > > > > > > > GPU at the time of its invocation which unfortunately are=
 not known to
> > > > > > > > > us.
> > > > > > > > >
> > > > > > > > > However, it looks like the AML invoked to power down the =
GPU from
> > > > > > > > > acpi_pci_set_power_state() gets confused if it is not in =
PCI D0 at
> > > > > > > > > that point, so it looks like that AML tries to access dev=
ice memory on
> > > > > > > > > the GPU (beyond the PCI config space) or similar which is=
 not
> > > > > > > > > accessible in PCI power states below D0.
> > > > > > > >
> > > > > > > > Or the PCI config space of the GPU when the parent root por=
t is in D3hot
> > > > > > > > (as it is the case here). Also then the GPU config space is=
 not
> > > > > > > > accessible.
> > > > > > >
> > > > > > > Why would the parent port be in D3hot at that point?  Wouldn'=
t that be
> > > > > > > a suspend ordering violation?
> > > > > >
> > > > > > No. We put the GPU into D3hot first,
> > > >
> > > > OK
> > > >
> > > > Does this involve any AML, like a _PS3 under the GPU object?
> > >
> > > I don't see _PS3 (nor _PS0) for that object. If I read it right the G=
PU
> > > itself is not described in ACPI tables at all.
> >
> > OK
> >
> > > > > > then the root port and then turn
> > > > > > off the power resource (which is attached to the root port) res=
ulting
> > > > > > the topology entering D3cold.
> > > > >
> > > > > I don't see that happening in the AML though.
> > > >
> > > > Which AML do you mean, specifically?  The _OFF method for the root
> > > > port's _PR3 power resource or something else?
> > >
> > > The root port's _OFF method for the power resource returned by its _P=
R3.
> >
> > OK, so without the $subject patch we (1) program the downstream
> > component (GPU) into D3hot, then we (2) program the port holding it
> > into D3hot and then we (3) let the AML (_OFF for the power resource
> > listed by _PR3 under the port object) run.
> >
> > Something strange happens at this point (and I guess that _OFF doesn't
> > even reach the point where it removes power from the port which is why
> > we see a lock-up).
> >
>
> it does though. I will post the data shortly (with the change in power
> consumption), as I also want to do the ACPI traces now.
>
> > We know that skipping (1) makes things work and we kind of suspect
> > that skipping (3) would make things work either, but what about doing
> > (1) and (3) without (2)?
> >
> > > > > Basically the difference is that when Windows 7 or Linux (the _RE=
V=3D=3D5
> > > > > check) then we directly do link disable whereas in Windows 8+ we =
invoke
> > > > > LKDS() method that puts the link into L2/L3. None of the fields t=
hey
> > > > > access seem to touch the GPU itself.
> > > >
> > > > So that may be where the problem is.
> > > >
> > > > Putting the downstream component into PCI D[1-3] is expected to put
> > > > the link into L1, so I'm not sure how that plays with the later
> > > > attempt to put it into L2/L3 Ready.
> > >
> > > That should be fine. What I've seen the link goes into L1 when
> > > downstream component is put to D-state (not D0) and then it is put ba=
ck
> > > to L0 when L2/3 ready is propagated. Eventually it goes into L2 or L3=
.
> >
> > Well, that's the expected behavior, but the observed behavior isn't as
> > expected. :-)
> >
> > > > Also, L2/L3 Ready is expected to be transient, so finally power sho=
uld
> > > > be removed somehow.
> > >
> > > There is GPIO for both power and PERST, I think the line here:
> > >
> > >   \_SB.SGOV (0x01010004, Zero)
> > >
> > > is the one that removes power.
> >
> > OK
> >
> > > > > LKDS() for the first PEG port looks like this:
> > > > >
> > > > >    P0L2 =3D One
> > > > >    Sleep (0x10)
> > > > >    Local0 =3D Zero
> > > > >    While (P0L2)
> > > > >    {
> > > > >         If ((Local0 > 0x04))
> > > > >         {
> > > > >             Break
> > > > >         }
> > > > >
> > > > >         Sleep (0x10)
> > > > >         Local0++
> > > > >    }
> > > > >
> > > > > One thing that comes to mind is that the loop can end even if P0L=
2 is
> > > > > not cleared as it does only 5 iterations with 16 ms sleep between=
. Maybe
> > > > > Sleep() is implemented differently in Windows? I mean Linux may b=
e
> > > > > "faster" here and return prematurely and if we leave the port int=
o D0
> > > > > this does not happen, or something. I'm just throwing out ideas :=
)
> > > >
> > > > But this actually works for the downstream component in D0, doesn't=
 it?
> > >
> > > It does and that leaves the link in L0 so it could be that then the
> > > above AML works better or something.
> >
> > That would be my guess.
> >
> > > That reminds me, ASPM may have something to do with this as well.
> >
> > Not really if D-states are involved.
> >
> > > > Also, if the downstream component is in D0, the port actually shoul=
d
> > > > stay in D0 too, so what would happen with the $subject patch applie=
d?
> > >
> > > Parent port cannot be lower D-state than the child so I agree it shou=
ld
> > > stay in D0 as well. However, it seems that what happens is that the
> > > issue goes away :)
> >
> > Well, at least this is kind of out of the spec.
> >
> > Note that pci_pm_suspend_noirq() won't let the port go into D3 if the
> > downstream device is in D0, so the $subject patch will not work as
> > expected in the suspend-to-idle case.
> >
> > Also we really should make up our minds on whether or not to force
> > PCIe ports to stay in D0 when downstream devices are in D0 and be
> > consequent about that.  Right now we do one thing during system-wide
> > suspend and the other one in PM-runtime, which is confusing.
> >
> > The current design is mostly based on the PCI PM Spec 1.2, so it would
> > be consequent to follow system-wide suspend in PM-runtime and avoid
> > putting PCIe ports holding devices in D0 into any low-power states.
> > but that would make the approach in the $subject patch ineffective.
> >
> > Moreover, the fact that there are separate branches for "Windows 7"
> > and "Windows 8+" kind of suggest a change in the expected behavior
> > between Windows 7 and Windows 8, from the AML perspective.  I would
> > guess that Windows 7 followed PCI PM 1.2 and Windows 8 (and later)
> > does something else.  Now, the structure of the "Windows 8+" branch
> > described by you suggests that, at least in the cases when it is going
> > to remove power from the port eventually, it goes straight for the
> > link preparation (the L2/L3 Ready transition) and power removal
> > without bothering to program the downstream device and port into D3hot
> > (because that's kind of redundant).
> >
> > That hypothetical "Windows 8+" approach may really work universally,
> > because it doesn't seem to break any rules (going straight from D0 to
> > D3cold is not disallowed and doing that for both a port and a
> > downstream device at the same time is kind of OK either, as long as
> > the link is ready for that).
> >

