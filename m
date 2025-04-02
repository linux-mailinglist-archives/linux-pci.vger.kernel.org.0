Return-Path: <linux-pci+bounces-25196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55113A795F5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 21:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75143B1B08
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29531EDA31;
	Wed,  2 Apr 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKs5rtRz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D51EDA24;
	Wed,  2 Apr 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622573; cv=none; b=fflN5BnsDyLkTbp0nyJAigV+QtJKbyNq/eE61CDGKlsFaOWKl3VP385hCr3IdCaOfDdamZaJe7EYeEQotSqT9p6dwbUH/L4RI9iD8EYYSkRo0cu71bMZKCv82ZNGqYrckg6FsuOp6TsneVa23prPSyYYwUUVOB4IXpDewiGMe/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622573; c=relaxed/simple;
	bh=N6aEnNC1BVJp0+4yG0StSefwIxjnvJ1BAP9HWFigLMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkEwjN43JTD42w/14hT9/1oz98lrBrOoivuYEianS3QUAJRrbBUORK2k1hwPY3vyBOMn1U9vwoD6lNd4KPCbRZQnrGICNbOK52d5s0J7XjNpnGNJlB4kcQfRaSOkwmArhcZlUiRpkBdPv32HhZDMBYCF3yJdU2r7KCPOYuzzqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKs5rtRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4045BC4AF09;
	Wed,  2 Apr 2025 19:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743622573;
	bh=N6aEnNC1BVJp0+4yG0StSefwIxjnvJ1BAP9HWFigLMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qKs5rtRzy/8w8K4QcavthdwiyqRS56rILrRRZvMFttPhL7EVZi2x1qNqBivnrWfWR
	 0DnMaASiOtHP+5YEm6VMW64rk0aCKpVxQUPMdyNkrzR9DfnA2i16QGctd/XvhePIao
	 goHZk1jPhkny65sK6r41sw0hM8DWR4/vJJsEN/ayq2vi5LFQQJs0LOKla3gFIQf+J5
	 duNa/QLV8HWyb2bsXaEgyCw2nO//1OOQFcYaO6nsYLG2bV4KZQU+N62pPnAu47Eycu
	 OQBL3rXeVS/WRpU5ElRMky6hmwmENKR3kr6SdlBLpzKqV+n+08wyobTrf8XCtwBqzB
	 74Wc6YKJBLRyw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b8e26063e4so42874fac.3;
        Wed, 02 Apr 2025 12:36:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIcgCDBumkMUEPOxUTOI9tdrMoA/93q+M7NRPAAdvphmtCMZdSngH9UqFvjw1PlQa0kO0DBKV/ixOG@vger.kernel.org, AJvYcCXt8TQ754IS7i+EXhbETuZiY6avryWB9Ddu+Npa4SMABPZH8GN39NyImpqMfTwdePXwQYIrHp3+wZhl@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXG74uEUdmjlptcVuGrOKsnVYQ/hoqdgD8ItZXM1d0hStH2VD
	GhQabXk0QIojkRGZYjTdnUNUFqDR+vbDOgwkdEN46zyNThEvhtbwh8vzhPs3Lku/BxUK7BU676T
	QzOWZEhA1KI9uyHF/fXkXQMJxR8o=
X-Google-Smtp-Source: AGHT+IEbLGuDKsj7mLsQ/fliURHgcHOUIssazmjJ/mSLq3LkY9RY8J7eawGItNQ60g+zmdbulS+xN5+5KirtjDRQWos=
X-Received: by 2002:a05:6870:e389:b0:29e:24c7:2861 with SMTP id
 586e51a60fabf-2cc60af34f2mr2056482fac.13.1743622572376; Wed, 02 Apr 2025
 12:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0h+oaw48B4EcrbNTtcKKY=1BwLdTcXoS0CkKFypnOs3cA@mail.gmail.com>
 <20250402184847.GA1737363@bhelgaas>
In-Reply-To: <20250402184847.GA1737363@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Apr 2025 21:36:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQjtTCu1wXgKvBWBBegbj-VD+Z0yBspt1uFes8Xun7Cw@mail.gmail.com>
X-Gm-Features: AQ5f1JqpkWWRN8yB3K891jYD1ZCljZwkLHbWFPmLbsL1CnEdBh7luPW11A3D8Qw
Message-ID: <CAJZ5v0hQjtTCu1wXgKvBWBBegbj-VD+Z0yBspt1uFes8Xun7Cw@mail.gmail.com>
Subject: Re: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Anshuman Gupta <anshuman.gupta@intel.com>, 
	intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, lenb@kernel.org, bhelgaas@google.com, 
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com, 
	rodrigo.vivi@intel.com, badal.nilawar@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 8:48=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Apr 02, 2025 at 07:51:29PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 2, 2025 at 5:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Wed, Apr 02, 2025 at 04:52:55PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Apr 2, 2025 at 4:21=E2=80=AFPM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > > > > On Wed, Apr 02, 2025 at 01:06:42PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Tue, Apr 1, 2025 at 5:36=E2=80=AFPM Anshuman Gupta <anshuman=
.gupta@intel.com> wrote:
> > > > > > >
> > > > > > > Implement _DSM Method 11 as per PCI firmware specs
> > > > > > > section 4.6.11 Rev 3.3.
> > > > >
> > > > > > > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, =
u32 delay_us)
> > > > > > > +{
> > > > > > > +       union acpi_object in_obj =3D {
> > > > > > > +               .integer.type =3D ACPI_TYPE_INTEGER,
> > > > > > > +               .integer.value =3D delay_us,
> > > > > > > +       };
> > > > > > > +
> > > > > > > +       union acpi_object *out_obj;
> > > > > > > +       acpi_handle handle;
> > > > > > > +       int result, ret =3D -EINVAL;
> > > > > > > +
> > > > > > > +       if (!dev || !ACPI_HANDLE(&dev->dev))
> > > > > > > +               return -EINVAL;
> > > > > > > +
> > > > > > > +       handle =3D ACPI_HANDLE(&dev->dev);
> > > > > > > +
> > > > > > > +       out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi=
_dsm_guid, 4,
> > > > > >
> > > > > > This is something I haven't noticed in the previous patch, but =
also
> > > > > > applies to it.
> > > > > >
> > > > > > Why is rev 4 of the interface hard-coded here?
> > > > >
> > > > > Thanks for asking this because it's related to the whole _DSM rev=
ision
> > > > > question that I don't understand.
> > > > >
> > > > > If we didn't use rev 4 here, what should we use?  The PCI Firmwar=
e
> > > > > spec, r3.3, sec 4.6.11, documents this interface and says "lowest
> > > > > valid Revision ID value is 4", so that's the source of the 4.
> > > >
> > > > Well, the "lowest valid Revision ID" does not generally mean the "o=
nly
> > > > valid Revision ID".
> > >
> > > True, but why should the kernel change from using the tested revision
> > > ID to some other revision ID?  What would be the benefit of using rev
> > > 5?
> >
> > TBH I'm not exactly buying the "tested revision ID" concept because
> > what does it really mean?
> >
> > If a given _DSM interface has been tested on one platform, does it
> > necessarily mean that it will work on all of the other platforms
> > implementing it?
>
> No, all we can say is that this OS rev 4 code works on the platforms
> we've tested.  Other platforms might have their own defects.
>
> My point is that this OS code was written to the rev 4 spec and has
> been tested, and we shouldn't change the code or the revision it uses
> unless we're fixing something.

Well, if the spec says "rev 5 is the same as rev 4 except for function
Y which is new in rev 5", then arguably the same OS code is also
compliant with rev 5 (it will not use function Y, but that's fine).

If the platform firmware follows the same spec, then the rev 5
implementation in it can be expected to work exactly as its rev 4
implementation either.

I see no problem with using rev 5 instead of rev 4 in that case and nn
new platforms, rev 5 is just as risky as rev 4.

> > > > Now, I'm not sure how likely it is for the PCI Firmware spec to
> > > > bump up the revision of this interface (I suppose that it will
> > > > do so if a new function is defined), but even if it does so, the
> > > > kernel will have to check both the new revision and rev 4
> > > > anyway, in case the firmware doesn't know about the new
> > > > revision.
> > >
> > > I guess the reason the OS would check both rev 5 and rev 4 would
> > > be that a new platform might implement
> > > DSM_PCI_PERST_ASSERTION_DELAY only at rev 5?  I think this would
> > > be a real mistake in terms of implementing something to the spec.
> >
> > This is a real possibility, however, because there's nothing to
> > prevent this kind of spec interpretation.
> >
> > I didn't mean this, though.
> >
> > Say the kernel wants to use a function that is only defined at rev
> > 5.  It will invoke function 0 at rev 5 to see if this function is
> > available, but then it may as well see if the other functions it
> > wants to use are available at rev 5 because it will get this
> > information from the same _DSM call.  If the platform firmware
> > responds that they all are implemented, why won't the kernel use
> > them all at rev 5?
>
> This is an unnecessary change, since the OS tested its rev 4 code and
> now we're saying the OS should use rev 5 instead, which the OS did not
> test.

Yes, it did.  It is the same code, as per the above.

> The reason rev 5 exists at all is probably that some completely
> unrelated new function was added, and somebody decided it should be
> rev 5.
>
> I guess function 0 *could* have been defined to answer "yes/no" about
> whether a single (function, revision) is implemented.  Then we
> probably wouldn't be having this conversation.
>
> But we do get an entire bitmask of implemented functions back from
> function 0, which allows the possibility of using the same revision
> for all the functions.  I suppose we could have a boot-time function
> that calls function 0 with rev 0, 1, 2, ..., until it gets an empty
> bitmask, and saves the highest rev with a non-empty mask.
>
> In PCI we don't do that; instead, we call acpi_check_dsm() before
> every acpi_evaluate_dsm().  The main reason is that I don't think it's
> safe to change the function X rev just because function Y was added
> later with a higher revision.

So what if there is a platform that only implements revisions greater than =
X?

Presumably, there is another OS targeted by this platform that only
uses revisions X+1 and forward.

> > > The spec documents DSM_PCI_PERST_ASSERTION_DELAY rev 4.  Some
> > > platforms implemented and tested DSM_PCI_PERST_ASSERTION_DELAY rev
> > > 4.  Linux added and tested support for
> > > DSM_PCI_PERST_ASSERTION_DELAY rev 4.  I propose new platforms
> > > should also implement and test DSM_PCI_PERST_ASSERTION_DELAY rev
> > > 4.
> > >
> > > If a new platform implements only DSM_PCI_PERST_ASSERTION_DELAY
> > > rev 5, there is no actual documentation for that rev other than
> > > the spec assertion that "rev 5 must support all functions defined
> > > by previous revs of the UUID."  IMO this is nonsense.  The
> > > platform might have no need to implement all the functions defined
> > > for the UUID.
> >
> > Sure.  That's why function 0 should always be used.
>
> Yes.  But the requirement that rev 5 must support all functions ever
> previously documented for the UUID still makes no sense to me.  I
> don't think there's any requirement that a platform implement ALL of
> the documented PCI functions.

I think that there is some confusion in the spec language that seems
to be conflating platforms with interface definitions.

It ostensibly wants the definitions of subsequent revisions of the
same interface to be consistent with each other, which is not a bad
thing in principle IMV, but at the same time it ostensibly allows
platforms to choose which functions to implement, and it doesn't say
anything about the expected behavior when the OS attempts to use a
function that is not implemented for a given rev.

You are right that the backward compatibility language in the _DSM
definition is not enforceable, but it can be regarded as a guidance:
Do not change the interface that you have once defined arbitrarily
between revisions.  After all, if you don't like this guidance, you
can just allocate a new UUID and define a new interface based on it.

Anyway, I'm not the author of this piece of the specification, so I
don't really know the original intent, and it is not sufficiently
clear.

> Maybe the intent is that this only applies to a given platform, i.e.,
> that new firmware for that platform must continue to support all
> functions and revisions that were ever supported on that platform?
> That seems obvious to me and hardly worth mentioning.
>
> > > Even if the platform makes all its functions valid for "the lowest
> > > valid Revision ID" through the "current Revision ID", there's
> > > nothing other than the spec assertion to guarantee that they all
> > > behave the same.  And dealing with multiple revisions that are
> > > "supposed" to be the same just makes work and risk for the OS.
> >
> > You seem to be questioning the interface versioning at large by
> > saying that there is no real guarantee of backwards compatibility
> > between consecutive interface revisions on the same platform.
>
> That's exactly what I'm saying, although I think problems are more
> likely across different platforms.  There's the requirement in the
> spec, but that's just words on a page.  There's no way to enforce or
> validate it.
>
> > Presumably, though, the interface is adhering to some specification
> > which defines the behavior of the functions (and the set of
> > available functions in the first place) for all of the valid
> > revisions of it.  The OS and the platform firmware both follow the
> > same spec and so they should be mutually compatible.  If this
> > particular spec defines rev 5 to be an exact superset of rev 4,
> > there is no reason to expect anything else.
>
> I don't *expect* rev 5 to be different.  But as a user of it, why
> would I change working, tested code that is not broken?
>
> The PCI DPC function 0xc is an example where rev 5 (per ECN) and rev 6
> (per r3.3) are not compatible.
>
> If the OS implemented rev 5, then learns via function 0 that function
> 0xc is also supported at rev 6, and starts using the same OS code with
> rev 6, the OS is broken.

Yes, in this case the backward compatibility language in the _DSM
definition is obviously not followed.

