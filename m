Return-Path: <linux-pci+bounces-30704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3760AE9AFB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C710717D97D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E2218EB7;
	Thu, 26 Jun 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNT5dm+n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AC18035;
	Thu, 26 Jun 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932924; cv=none; b=AE6I/N8hELgRY6Y5Qvqi6lo3BFAolSp3YUkeBTG25GBnwo5FLShYZjLOnKjFhsCsKNbFppHdpz2tir6H1Ksr35WhHtqB7C5fKkATZgD7TgN2XCaTG68GmJwGaAOWjT4TsMiHfCCoaK7FunrHx8pD1sHSv9Vx+rEh439saei7XSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932924; c=relaxed/simple;
	bh=44xu6JCHyb323vq5dOnWk5A0wM3ylQxRP2p6KUxGsBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9YARSisre9RiKmNkBXRFkDdZ9UPeuxjAsJg61HX6ywiL3/iKkd1CBT7H8k/VLH+LTR65kZiaAYJdaV0f7zfKVY8zq7321JaFlm8avB/PiDMQLyt4RNALmN8RBzNUqG/j7z8lYKb0iELcgPAIzBxdj7svLZR9ZlwKvnd7YnBU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNT5dm+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51493C4CEEB;
	Thu, 26 Jun 2025 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750932924;
	bh=44xu6JCHyb323vq5dOnWk5A0wM3ylQxRP2p6KUxGsBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qNT5dm+nkHdaqZBn49xw1vpfhz72lLGx4vjhAhV94C1swC4CIRH5378+1EOBIxJsY
	 DtMaDxXTUA00TedNSbUnSMV27cH5r9JPRVHKdpzfOp8ogF7lQv3PIjTbP9OTRRwX6w
	 QxWyfSZV7LG6zDGb29mb4Mzk509aTUDgaJKj2PBzjQyEVNmUpssI8Pt8v+ONeLpAic
	 0nU2y43yRI2SqtkkcgMrsrs6x96mnIsf55QXwcZqdv4usrAF4sphicvaBB3doJF7Q0
	 cTdmEZc6oJxdIJb6OAtgzKe484s+/HG3EL+H7JbYw6t+bsoN2I7w+Ptxts7mZKEET+
	 h1i4O77S+VwzQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6060a70ba80so425067eaf.2;
        Thu, 26 Jun 2025 03:15:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/spPU3LABTKubrsky+q/EbevmPjPu94LhFPyp0b9e9qlMDvbcvagdEZmVp655P92eZsIw6ex+NcqDbKIR@vger.kernel.org, AJvYcCUNHQjuBg0H8WGSoMvuOva0tX4limUUkVCf0x0XVCsKclS4baKyAJknp4nw5dQdIs1oZAD4yvf0C18=@vger.kernel.org, AJvYcCV3qTWZicbGZE5tU4JECtoJMhc2oRRnJnOkiIJV5wclB8JBjXfPyaIUNDWL74WTS2gUajDQ9bQdZuaD@vger.kernel.org, AJvYcCXSYOeWVcNivSK0th6K0NhloRQTQPdHU/u6yWF+y7GgXzu64YPNQ0sxrS13v5GMqXW0+h8cpjhSJK74@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAFFy7jsbYm4o0wNNa2l7+ObXR9dERC9dIum+W6FpkoaeONcX
	ZWKHxJ7GJvtXGirVnijy3r2Cy3+OO5FMXVLYobU+jUfbjn1eswRdYpHDDMAN3UY6ODDyDNyBoEM
	tVvdeKmh58BXS4Dso64FlNTVLKZPqdLw=
X-Google-Smtp-Source: AGHT+IGj8eLfRKwWINQQHiHquwCVNetysNJ/Q0Zgqkacdoynvdy2ew0KThJ4qdn0o9C8WSAWacwgPEmk75uzj4Z6A+A=
X-Received: by 2002:a05:6820:4c16:b0:611:7a4a:737b with SMTP id
 006d021491bc7-6119d7dfceemr4310519eaf.4.1750932923697; Thu, 26 Jun 2025
 03:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <3306233.5fSG56mABF@rjwysocki.net>
 <CAPDyKForsegoD+J6rumvnhHna7W+DVdb5zdKGiRB-TFv27sy7A@mail.gmail.com>
In-Reply-To: <CAPDyKForsegoD+J6rumvnhHna7W+DVdb5zdKGiRB-TFv27sy7A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 12:15:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gDtDSOe8oWTtVUNBYh4xiFRRDVCNQZKz4+hio5AmLSpA@mail.gmail.com>
X-Gm-Features: Ac12FXyuQj8CPJon6mKCLdApXR_3Ouv_4PvSkK5bOqmHW-WukbYjuEOBJfbsju4
Message-ID: <CAJZ5v0gDtDSOe8oWTtVUNBYh4xiFRRDVCNQZKz4+hio5AmLSpA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] PM: Check power.needs_force_resume in pm_runtime_force_suspend()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a power.needs_force_resume check to pm_runtime_force_suspend() so
> > it need not rely on the runtime PM status of the device when deciding
> > whether or not to return early.
> >
> > With the new check in place, pm_runtime_force_suspend() will also skip
> > devices with the runtime PM status equal to RPM_ACTIVE if they have
> > power.needs_force_resume set, so it won't need to change the RPM
> > status of the device to RPM_SUSPENDED in addition to setting
> > power.needs_force_resume in the case when pm_runtime_need_not_resume()
> > return false.
> >
> > This allows the runtime PM status update to be removed from
> > pm_runtime_force_resume(), so the runtime PM status remains unchanged
> > between the pm_runtime_force_suspend() and pm_runtime_force_resume()
> > calls.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |   21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1975,7 +1975,7 @@
> >         int ret;
> >
> >         pm_runtime_disable(dev);
> > -       if (pm_runtime_status_suspended(dev))
> > +       if (pm_runtime_status_suspended(dev) || dev->power.needs_force_=
resume)
> >                 return 0;
> >
> >         callback =3D RPM_GET_CALLBACK(dev, runtime_suspend);
> > @@ -1990,15 +1990,16 @@
> >         /*
> >          * If the device can stay in suspend after the system-wide tran=
sition
> >          * to the working state that will follow, drop the children cou=
nter of
> > -        * its parent, but set its status to RPM_SUSPENDED anyway in ca=
se this
> > -        * function will be called again for it in the meantime.
> > +        * its parent and the usage counters of its suppliers.  Otherwi=
se, set
> > +        * power.needs_force_resume to let pm_runtime_force_resume() kn=
ow that
> > +        * the device needs to be taken care of and to prevent this fun=
ction
> > +        * from handling the device again in case the device is passed =
to it
> > +        * once more subsequently.
> >          */
> > -       if (pm_runtime_need_not_resume(dev)) {
> > +       if (pm_runtime_need_not_resume(dev))
> >                 pm_runtime_set_suspended(dev);
> > -       } else {
> > -               __update_runtime_status(dev, RPM_SUSPENDED);
> > +       else
> >                 dev->power.needs_force_resume =3D true;
> > -       }
> >
> >         return 0;
> >
> > @@ -2029,12 +2030,6 @@
> >         if (!dev->power.needs_force_resume)
> >                 goto out;
> >
> > -       /*
> > -        * The value of the parent's children counter is correct alread=
y, so
> > -        * just update the status of the device.
> > -        */
> > -       __update_runtime_status(dev, RPM_ACTIVE);
> > -
> >         callback =3D RPM_GET_CALLBACK(dev, runtime_resume);
> >
> >         dev_pm_disable_wake_irq_check(dev, false);
> >
>
> As I mentioned for patch4, pm_runtime_force_suspend() is being used
> from driver's ->remove() callback too.
>
> If such a driver/device gets probed again, we need a fresh start. It
> seems like we need to clear the needs_force_resume flag in
> pm_runtime_reinit(). In fact, that looks like an existing bug, even
> before $subject patch, right?

If it is used in ->remove(), then yes, it needs to be cleared in
_reinit(), at least in principle.

