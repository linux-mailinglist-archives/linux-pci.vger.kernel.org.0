Return-Path: <linux-pci+bounces-2499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 800918399F0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 21:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC366B2268F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 20:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2A82D6E;
	Tue, 23 Jan 2024 20:00:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56E63511
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040004; cv=none; b=h5k3RCyDKurpvLAIvrIfNd1KxKbiUunEs+XQAP+kv6hUESmwSvLwPcPgmIKmtEdkvkvWVXzA/92HeU26qRkeNfT6ykZPbthIXz1WvLS6YpggXejXYwcDJU4MUYiGyUhP5HEg3/qAF8MthdOlTKigZ+4vVCsnmk/2Z92Nv/QPocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040004; c=relaxed/simple;
	bh=mFHMF3oTEOEx9arLblnlWQ6ObSd2sqZlui9G1NKSPDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/7WhSiAgiTXc6COF7YRZp8u/cvq1RMs5STMCLdnI60nRkvkX1CiBx4MJqb+RulT/WrCrC5kimcW4/ixsj+TwQjZOjI4/a/rDiGtiLo3p289AEwuqTh+arsoWWpaRvGF57Q+gUU1NMmKqUofsjzDAsFm8OwgT7wWfyhy34rY6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5997edc27ccso288601eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 12:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706040002; x=1706644802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQAZahutm3AtbO/u1Q8fBFd5Z2Ta3PNqXtyyWjZizOY=;
        b=GrQHM/VPiXcArMaGqksR21wmi7iomhkNj/8AzGFwiDhJbfPerDE1eVlTdDM859DjAY
         vVwsjwXrz3ikD40ViKwKlNFfy4+pYyNnIuGqDl+Lz5qzfJq69XiChovSIRjh/7tw+vXn
         8sppIfA5tdDqv9gkgIbLxY8NyTco3LsrKOS2oBhHKUx6dS39JBpBswDh34GCgw7q/+AJ
         a2um3CXm2AtABiBJaWFuB7lkJl8ZS9xnUyGsorzisJEaBmUlZH8BkNEuHIl4kl6OIMn3
         pzxdrvSKg60xRHtdOEQ8va9kjU1qH2+svsLGbKLy3z8c0S8BZIiOx/tZ5JfiSk8LZO3b
         Zb2Q==
X-Gm-Message-State: AOJu0YxQiwhEB3qosPhniGs4HRs2z6H/W1VGFILY8tAtflF28sVZbA8F
	Y9wJ+mP5Rk0BwW5Q3jEOFDRFS30dYEZEemY91r43DXtDBgJsrhVPx2sMs1vEtri44p2cRH7dYuk
	sJCRqMq2E4nTdluCdWhyYN5X6ZH4=
X-Google-Smtp-Source: AGHT+IGYOkny43wtZnSNrb6T4IztbLOdbAmddYgMrqS+ycEzdZ+skYTM1l019XI0K0EhilX0Six58EEkjlguBoXmZ4I=
X-Received: by 2002:a05:6820:825:b0:599:a348:c582 with SMTP id
 bg37-20020a056820082500b00599a348c582mr296313oob.1.1706040002251; Tue, 23 Jan
 2024 12:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185548.1040096-1-alex.williamson@redhat.com>
 <CAJZ5v0gcjxmBnFy=qrUfPCwJyvzS_gy139TqhoF=gf_U_E2jPA@mail.gmail.com> <20240123125052.133a42bc.alex.williamson@redhat.com>
In-Reply-To: <20240123125052.133a42bc.alex.williamson@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 20:59:50 +0100
Message-ID: <CAJZ5v0hLaka9od=_DB8L5nVJMPdu-9WKDgt5ro3jzE5b7MY-rQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	lukas@wunner.de, mika.westerberg@linux.intel.com, sanath.s@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:51=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 23 Jan 2024 20:40:32 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Jan 23, 2024 at 7:56=E2=80=AFPM Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > >
> > > The commit noted in fixes added a bogus requirement that runtime PM
> > > managed devices need to be in the RPM_ACTIVE state for PME polling.
> > > In fact, only devices in low power states should be polled.
> > >
> > > However there's still a requirement that the device config space must
> > > be accessible, which has implications for both the current state of
> > > the polled device and the parent bridge, when present.  It's not
> > > sufficient to assume the bridge remains in D0 and cases have been
> > > observed where the bridge passes the D0 test, but the PM state
> > > indicates RPM_SUSPENDING and config space of the polled device become=
s
> > > inaccessible during pci_pme_wakeup().
> > >
> > > Therefore, since the bridge is already effectively required to be in
> > > the RPM_ACTIVE state, formalize this in the code and elevate the PM
> > > usage count to maintain the state while polling the subordinate
> > > device.
> > >
> > > Cc: Lukas Wunner <lukas@wunner.de>
> > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
> > > Reported-by: Sanath S <sanath.s@amd.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218360
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > >  drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
> > >  1 file changed, 22 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index bdbf8a94b4d0..764d7c977ef4 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work_str=
uct *work)
> > >                 if (pdev->pme_poll) {
> > >                         struct pci_dev *bridge =3D pdev->bus->self;
> > >                         struct device *dev =3D &pdev->dev;
> > > -                       int pm_status;
> > > +                       struct device *bdev =3D bridge ? &bridge->dev=
 : NULL;
> > > +                       int bref =3D 0;
> > >
> > >                         /*
> > > -                        * If bridge is in low power state, the
> > > -                        * configuration space of subordinate devices
> > > -                        * may be not accessible
> > > +                        * If we have a bridge, it should be in an ac=
tive/D0
> > > +                        * state or the configuration space of subord=
inate
> > > +                        * devices may not be accessible or stable ov=
er the
> > > +                        * course of the call.
> > >                          */
> > > -                       if (bridge && bridge->current_state !=3D PCI_=
D0)
> > > -                               continue;
> > > +                       if (bdev) {
> > > +                               bref =3D pm_runtime_get_if_active(bde=
v, true);
> > > +                               if (!bref)
> >
> > I would check bref <=3D 0 here.
> >
> > > +                                       continue;
> > > +
> > > +                               if (bridge->current_state !=3D PCI_D0=
)
> >
> > Isn't the power state guaranteed to be PCI_D0 at this point?  If it
> > isn't, then why?
>
> Both of these seem necessary to support !CONFIG_PM, where bref would be
> -EINVAL and provides no indication of the current_state.  Is that
> incorrect?  Thanks,

Well, CONFIG_PCIE_PME depends on CONFIG_PM, so I'm not sure how
dev->pme_poll can be set without it.

