Return-Path: <linux-pci+bounces-25194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83751A794B8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75A0172562
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408B1A2872;
	Wed,  2 Apr 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G96Np4VA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECE1A23AF;
	Wed,  2 Apr 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616302; cv=none; b=oE47P7QSqP7ifAYvhfMGY0WsyuDiFdbpqPgX/oo/FRyhZEDOavZ1icjc8FN/Vjn9/qRj4H3aOCYIJLXj7IZAEzh1qLY0oQ074Akq5eOn7EJ76NEwMuZs0Chsw1n3+MQteuffw0oVf8k3+zDXUHbnIkWeRTgse4gTLE4fZPNY/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616302; c=relaxed/simple;
	bh=om/1K6v+3Iaux+WtUm4GIVe3ZulXmSHxGyn9U0M7tWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUpBc6Sq2w1Fm53yeAND+BZPtduiaNFIe4ihvIbejyxUbobdYXeIxSblNXy2inLFgWirFjvo1AyAQeb+m/SdJNBj6mC1icHSzjeMp5sZdaU72QGnVoH5BG6a565v0oBtNvqe2xcmZKO+msssW2pXFumYKHkuMldQiKlI1PZXloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G96Np4VA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D444BC4CEE5;
	Wed,  2 Apr 2025 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743616301;
	bh=om/1K6v+3Iaux+WtUm4GIVe3ZulXmSHxGyn9U0M7tWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G96Np4VAEFHPOAnFqd0Xwt2zjeZiWwYB56+ZCOJOdP/QzdSUfS1x/RidzAtHLM+sw
	 YYmhz7N13skRXpBZ1GgmPsML/MUlPfrp2K71cVQqL9ii5C603TLKldIt0BJ5eqZdar
	 CqChaQG/j7PQEsTS8TyxsVBVw4hYMk01WczB1xD1AvM5Dag8BtTefLxTAzw5vCVA8C
	 yt91+d+JdTb9GV2ZeSDpwdVK7GeLu8LnFjtwx2zbLzlBhj+DkoBW9Mosi54PfAa9E1
	 CR3d58SKQQuU5MOsrykne8eDLK4xsOhJ/A3DzhYl1TIWSFil8TSXPdkQ2l5zhqYBLC
	 JMDjMWOaGA9/A==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a01bcd0143so7676173fac.2;
        Wed, 02 Apr 2025 10:51:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhXPu4FtHkbDQszkhv4Ef+JjirRn84fzwqbMKNDRtzh1t1gSlsyaMbD0ofq/f9UtEks7OgGZhqUU8M@vger.kernel.org, AJvYcCWtGkI0lxv8bLjHMIwHiKTJsqumEMDMQfzfujosfrnAHg1bFnZdsLq4nS7yrWn8n9IbY/SdORaCRqg7@vger.kernel.org
X-Gm-Message-State: AOJu0YxIczr8oGQchGKiJzhMFg7qvipQ6Txu7h+Nl1MZMoZ7a/DdFpF0
	nM/Mzi3iMweIwpfoSWZXBQLUby0WanxbbtYvBuMeva6HaxaRXOPDJ48A9mR81pQcWHL4IEhIyMY
	1tHjIyQmX9Phw0hkC1769FjZorqo=
X-Google-Smtp-Source: AGHT+IEmdAermefk4yZuKJh7+LdLXhLrfV3utNmnB+Nj6NRvEYgmqtOgPntB8AuVHp1+NBEeaq+ipb3DOkBSoMTKRLc=
X-Received: by 2002:a05:6870:20f:b0:2c2:3e24:9b54 with SMTP id
 586e51a60fabf-2cbcf4a7ceemr9854519fac.11.1743616301079; Wed, 02 Apr 2025
 10:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0juJFTbPJh2rTmFe4gF9LzXsfao0k3ne2eXd5OqubtwCw@mail.gmail.com>
 <20250402155020.GA1725452@bhelgaas>
In-Reply-To: <20250402155020.GA1725452@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Apr 2025 19:51:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+oaw48B4EcrbNTtcKKY=1BwLdTcXoS0CkKFypnOs3cA@mail.gmail.com>
X-Gm-Features: AQ5f1JrbTgW5dTStZO6JN949mpoDT6NvsQ0-9aoEwlekGNNqhETB8rMuii9dDug
Message-ID: <CAJZ5v0h+oaw48B4EcrbNTtcKKY=1BwLdTcXoS0CkKFypnOs3cA@mail.gmail.com>
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

On Wed, Apr 2, 2025 at 5:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Apr 02, 2025 at 04:52:55PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 2, 2025 at 4:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Wed, Apr 02, 2025 at 01:06:42PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Apr 1, 2025 at 5:36=E2=80=AFPM Anshuman Gupta <anshuman.gup=
ta@intel.com> wrote:
> > > > >
> > > > > Implement _DSM Method 11 as per PCI firmware specs
> > > > > section 4.6.11 Rev 3.3.
> > >
> > > > > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 =
delay_us)
> > > > > +{
> > > > > +       union acpi_object in_obj =3D {
> > > > > +               .integer.type =3D ACPI_TYPE_INTEGER,
> > > > > +               .integer.value =3D delay_us,
> > > > > +       };
> > > > > +
> > > > > +       union acpi_object *out_obj;
> > > > > +       acpi_handle handle;
> > > > > +       int result, ret =3D -EINVAL;
> > > > > +
> > > > > +       if (!dev || !ACPI_HANDLE(&dev->dev))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       handle =3D ACPI_HANDLE(&dev->dev);
> > > > > +
> > > > > +       out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm=
_guid, 4,
> > > >
> > > > This is something I haven't noticed in the previous patch, but also
> > > > applies to it.
> > > >
> > > > Why is rev 4 of the interface hard-coded here?
> > >
> > > Thanks for asking this because it's related to the whole _DSM revisio=
n
> > > question that I don't understand.
> > >
> > > If we didn't use rev 4 here, what should we use?  The PCI Firmware
> > > spec, r3.3, sec 4.6.11, documents this interface and says "lowest
> > > valid Revision ID value is 4", so that's the source of the 4.
> >
> > Well, the "lowest valid Revision ID" does not generally mean the "only
> > valid Revision ID".
>
> True, but why should the kernel change from using the tested revision
> ID to some other revision ID?  What would be the benefit of using rev
> 5?

TBH I'm not exactly buying the "tested revision ID" concept because
what does it really mean?

If a given _DSM interface has been tested on one platform, does it
necessarily mean that it will work on all of the other platforms
implementing it?

> PCI Firmware r3.3 does contain a statement that "OSPM must invoke all
> Functions other than Function 0 with the same Revision ID value," but
> IMO that was a mistake, and we just approved an ECR to remove it.
>
> > > My argument is that the spec documents rev 4, the kernel code was
> > > tested with rev 4, so what would be the benefit of using a different
> > > revision here?
> >
> > I'm talking about using a symbol to represent the number 4, not about
> > possibly using a different number, along the lines of using, say,
> > ACPI_FADT_LOW_POWER_S0 instead of putting BIT(21) directly into the
> > code.
> >
> > The value is not likely to change, but using a symbol for representing
> > it has merit (it can be meaningfully used in searches, it can be
> > documented etc.).
>
> DSM_PCI_PERST_ASSERTION_DELAY (the function number) is a great thing
> to search for.  I doubt a symbol for "4" would really add anything.
> At least in PCI, changes to a particular _DSM function are relatively
> rare.
>
> > Now, I'm not sure how likely it is for the PCI Firmware spec to bump
> > up the revision of this interface (I suppose that it will do so if a
> > new function is defined), but even if it does so, the kernel will have
> > to check both the new revision and rev 4 anyway, in case the firmware
> > doesn't know about the new revision.
>
> I guess the reason the OS would check both rev 5 and rev 4 would be
> that a new platform might implement DSM_PCI_PERST_ASSERTION_DELAY only
> at rev 5?  I think this would be a real mistake in terms of
> implementing something to the spec.

This is a real possibility, however, because there's nothing to
prevent this kind of spec interpretation.

I didn't mean this, though.

Say the kernel wants to use a function that is only defined at rev 5.
It will invoke function 0 at rev 5 to see if this function is
available, but then it may as well see if the other functions it wants
to use are available at rev 5 because it will get this information
from the same _DSM call.  If the platform firmware responds that they
all are implemented, why won't the kernel use them all at rev 5?

> The spec documents DSM_PCI_PERST_ASSERTION_DELAY rev 4.  Some
> platforms implemented and tested DSM_PCI_PERST_ASSERTION_DELAY rev 4.
> Linux added and tested support for DSM_PCI_PERST_ASSERTION_DELAY rev
> 4.  I propose new platforms should also implement and test
> DSM_PCI_PERST_ASSERTION_DELAY rev 4.
>
> If a new platform implements only DSM_PCI_PERST_ASSERTION_DELAY rev 5,
> there is no actual documentation for that rev other than the spec
> assertion that "rev 5 must support all functions defined by previous
> revs of the UUID."  IMO this is nonsense.  The platform might have no
> need to implement all the functions defined for the UUID.

Sure.  That's why function 0 should always be used.

> Even if the platform makes all its functions valid for "the lowest
> valid Revision ID" through the "current Revision ID", there's nothing
> other than the spec assertion to guarantee that they all behave the
> same.  And dealing with multiple revisions that are "supposed" to be
> the same just makes work and risk for the OS.

You seem to be questioning the interface versioning at large by saying
that there is no real guarantee of backwards compatibility between
consecutive interface revisions on the same platform.

Presumably, though, the interface is adhering to some specification
which defines the behavior of the functions (and the set of available
functions in the first place) for all of the valid revisions of it.
The OS and the platform firmware both follow the same spec and so they
should be mutually compatible.  If this particular spec defines rev 5
to be an exact superset of rev 4, there is no reason to expect
anything else.

