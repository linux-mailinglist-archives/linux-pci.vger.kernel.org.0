Return-Path: <linux-pci+bounces-2506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A40839C48
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 23:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D945D2813E3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA450245;
	Tue, 23 Jan 2024 22:33:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAA20DEF
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049223; cv=none; b=csDoRYIWQlSUHRtPwGIsEtmiXgmYQi9Lg+l7zkWP/EbaW7Pi0ZLThMOhVyqlhqKxqZ+WsFy0yWcVtHt7LABSG3EXnsLnzhaI6iExUEPj6FrZxolQk9+SlrhVhyV8/U0LuHhIO0O/gW6vtFOPxgF5LzW4coxSTOZrG+txn7JX/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049223; c=relaxed/simple;
	bh=zH8WTDvfJPMbNxuf8F2bKlWY7Vc52K8C4uxqGfNgFnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg2TT4VzSMGj1Hk+DmY/qb7puJIXFrScyv8MO/kxwGIRImjR83wBc+vF9CK/+/DrbyLyW1O5grYTIUXHFH5D64nAIWsTM5ldIZyvkoGW4TMEa2GxK4Sj5/pDcB+xhTNP45PqlKZ+H1ah+rJbPjPiVv4XC00kySf6YqraBodkFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5997edc27ccso309340eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 14:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049221; x=1706654021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTLxPU7tvxXgy7NNYrvJfeiGbpsLGJRKfz85atB7xAo=;
        b=fKa8yLk5F2yzIuE4QYS4f+CBEtQ9LcQVyuft3CifQtLgETisdw2RsmmWjYETuwONze
         OyiJnEqGamvMStOyu7oD8vLl+Rl7j6iq+KxOYZ5IEEr/V5ad+eGCkpZVq7+VBCcXiGCd
         nKeFBibrZB9O6P7Tn7zi81krZrJYjqEEVRNXu/I2kRTnzbUd3hnLrrGz2TemcnkVEhD1
         XOKTMitcjHkSEh3WIj/3jDO9jLMTaE8Xu6rfi/Np2V4k9XSt5iwxg6DDrd15Aw1g2L9K
         rjwO1XM0SZ3NLQinoELVDgjyLMbgKqnMW5QfSldGupqlMi/D5FbJePhDcYTm5KlcYLse
         I2+Q==
X-Gm-Message-State: AOJu0Yxg8UKee3yWulqe5sX5TNqCBx44QrMU0QJVm1UsKEOcQKaTDlNq
	mpk8ZiiJJAtW6lBC7eQwPQ2YziIeks5KgfBGZ4afrdMdLsdUFlFL+ZazgCQoM+kHRAgVAkhs7/N
	sNeLQfkbUjp8GC3Zv+QYxtTYr4W63M5XALLI=
X-Google-Smtp-Source: AGHT+IFY83kt7Z+ShS4BYISMjFx1KdDz7PizHBkuq5Oh3DNzfbmgBYLs3hVeahLnOp5gLiKYO12iI8T1k66Vbt+S77Y=
X-Received: by 2002:a4a:cb86:0:b0:599:a116:6ca with SMTP id
 y6-20020a4acb86000000b00599a11606camr656894ooq.0.1706049221372; Tue, 23 Jan
 2024 14:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185548.1040096-1-alex.williamson@redhat.com>
 <CAJZ5v0gcjxmBnFy=qrUfPCwJyvzS_gy139TqhoF=gf_U_E2jPA@mail.gmail.com>
 <20240123125052.133a42bc.alex.williamson@redhat.com> <CAJZ5v0hLaka9od=_DB8L5nVJMPdu-9WKDgt5ro3jzE5b7MY-rQ@mail.gmail.com>
 <20240123133917.765743ed.alex.williamson@redhat.com>
In-Reply-To: <20240123133917.765743ed.alex.williamson@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 23:33:29 +0100
Message-ID: <CAJZ5v0jUHC3=Ga-5Sb41LK=BzJ5GitmrHUCOTCTZP7rtZWNULQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	lukas@wunner.de, mika.westerberg@linux.intel.com, sanath.s@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:39=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 23 Jan 2024 20:59:50 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Jan 23, 2024 at 8:51=E2=80=AFPM Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > >
> > > On Tue, 23 Jan 2024 20:40:32 +0100
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > On Tue, Jan 23, 2024 at 7:56=E2=80=AFPM Alex Williamson
> > > > <alex.williamson@redhat.com> wrote:
> > > > >
> > > > > The commit noted in fixes added a bogus requirement that runtime =
PM
> > > > > managed devices need to be in the RPM_ACTIVE state for PME pollin=
g.
> > > > > In fact, only devices in low power states should be polled.
> > > > >
> > > > > However there's still a requirement that the device config space =
must
> > > > > be accessible, which has implications for both the current state =
of
> > > > > the polled device and the parent bridge, when present.  It's not
> > > > > sufficient to assume the bridge remains in D0 and cases have been
> > > > > observed where the bridge passes the D0 test, but the PM state
> > > > > indicates RPM_SUSPENDING and config space of the polled device be=
comes
> > > > > inaccessible during pci_pme_wakeup().
> > > > >
> > > > > Therefore, since the bridge is already effectively required to be=
 in
> > > > > the RPM_ACTIVE state, formalize this in the code and elevate the =
PM
> > > > > usage count to maintain the state while polling the subordinate
> > > > > device.
> > > > >
> > > > > Cc: Lukas Wunner <lukas@wunner.de>
> > > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > > > Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
> > > > > Reported-by: Sanath S <sanath.s@amd.com>
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218360
> > > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > ---
> > > > >  drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
> > > > >  1 file changed, 22 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index bdbf8a94b4d0..764d7c977ef4 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work=
_struct *work)
> > > > >                 if (pdev->pme_poll) {
> > > > >                         struct pci_dev *bridge =3D pdev->bus->sel=
f;
> > > > >                         struct device *dev =3D &pdev->dev;
> > > > > -                       int pm_status;
> > > > > +                       struct device *bdev =3D bridge ? &bridge-=
>dev : NULL;
> > > > > +                       int bref =3D 0;
> > > > >
> > > > >                         /*
> > > > > -                        * If bridge is in low power state, the
> > > > > -                        * configuration space of subordinate dev=
ices
> > > > > -                        * may be not accessible
> > > > > +                        * If we have a bridge, it should be in a=
n active/D0
> > > > > +                        * state or the configuration space of su=
bordinate
> > > > > +                        * devices may not be accessible or stabl=
e over the
> > > > > +                        * course of the call.
> > > > >                          */
> > > > > -                       if (bridge && bridge->current_state !=3D =
PCI_D0)
> > > > > -                               continue;
> > > > > +                       if (bdev) {
> > > > > +                               bref =3D pm_runtime_get_if_active=
(bdev, true);
> > > > > +                               if (!bref)
> > > >
> > > > I would check bref <=3D 0 here.
> > > >
> > > > > +                                       continue;
> > > > > +
> > > > > +                               if (bridge->current_state !=3D PC=
I_D0)
> > > >
> > > > Isn't the power state guaranteed to be PCI_D0 at this point?  If it
> > > > isn't, then why?
> > >
> > > Both of these seem necessary to support !CONFIG_PM, where bref would =
be
> > > -EINVAL and provides no indication of the current_state.  Is that
> > > incorrect?  Thanks,
> >
> > Well, CONFIG_PCIE_PME depends on CONFIG_PM, so I'm not sure how
> > dev->pme_poll can be set without it.
>
> I only see that drivers/pci/pci.c:pci_pm_init() sets pme_poll true and
> I'm not spotting a dependency on either PCIE_PME or PM to get there.  I
> see a few places where pme.c, governed by PCIE_PME, can set pme_poll
> false though.

All of this is a bit moot when CONFIG_PM is unset, because PME polling
was introduced as a workaround for problems with PME signaling which
is only enabled when CONFIG_PM is set.  IOW, if CONFIG_PM is not set,
there is no reason for PME polling.

> It's also not clear to me that we should skip scanning a device if
> pm_runtime_get_if_active() returns -EINVAL for the bridge due to
> power.disable_depth.

Let me recap things a bit.

PME polling is run from a freezable workqueue, so it is not carried
out during system-wide PM transitions, only in the working state
proper.

This means that when runtime PM is disabled for a bridge, there is no
reason for its power state to change and all bridges start in D0.

So you are right, the endpoint device below the bridge still needs to
be scanned then, but I'm not sure about the current_state check.  In
theory, it should not be necessary.

But I agree that this is a minor point, so please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

to the patch.

