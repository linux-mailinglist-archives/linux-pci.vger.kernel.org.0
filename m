Return-Path: <linux-pci+bounces-2502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCAC839A6C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 21:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0081F2A28E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 20:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D66C20F1;
	Tue, 23 Jan 2024 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K15YvAFr"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC076AAB
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042363; cv=none; b=sDt2BdGQx41kRly48Bq7ymuejFqkvXzBwb3wrRHlBaH5Y6u1n2iUOZ6OO2gW4jDzBLmKuruJ4cRiYhNRTAfIfkKi0GCiAIbA5bYnmVSOXt+NAZ54QaoNxvbtDExjYAw9W8rekNGTTynKBRMNwYV2CBUWdJ+YTkx0AJdrGYzKXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042363; c=relaxed/simple;
	bh=gjPCV/TN/mj+V72WzQsFZHcy0G3DJKrYkfV8ufHL6pU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKzUngLQiJIxm5ETlOF9qbuMXcGx3+XasMbWEenV2MsSLbNlmmTgZSpjEB7m6+pDd+Udfx9B0hRj6OKnENxKeyDgjyjIm/LrLSCFezHSnD2n7kEedLXZ+HWsNpHHWi2+f0suVe+qlHSKEeFoyN0qRCHrZRseOFwGtSn6I2MGptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K15YvAFr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706042360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qZvJ4XyFRm/orqM3JDktkw5W23C2bHZYs4F6xr3L9w=;
	b=K15YvAFrTljG0X5D48jg3bf/Kf+UXJeqZpIanP87zHiZwM6fKEXqXfBFfHLcJgMIQQs6Ax
	izf5f86x66ZyXHdVb+PGpgcrzovn/kgumYr8TTAkEzgAMmySAkIcFsylBuNwPgfmrD9Ca0
	KI1x6HNbEs4A2kSEqfKh4loHronwBXk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-87_5KrAPNXWiKSaItJPSxg-1; Tue, 23 Jan 2024 15:39:19 -0500
X-MC-Unique: 87_5KrAPNXWiKSaItJPSxg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36280fd2213so15023745ab.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 12:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042358; x=1706647158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qZvJ4XyFRm/orqM3JDktkw5W23C2bHZYs4F6xr3L9w=;
        b=BK5vSyp9cR/aWLBJs71aRwkpb3o7VrHjTpuZjtlpuvst5kBi+BmatdPh3MLyrasmK0
         P8NJH/qsU98fL/dBMxmvasZN/8OKRNqRc4C9ER2iZ6MI9N8E1YNOnCNJBk5Cjtf827rh
         n0UTuyQYl/3rafe2uyy/Z7rZgaEfNX6Emgfxe2XZqsbHy8rDCi7Nj9BwdS/kp85lPUjo
         BYZiB+Yd6O5/Y6AP7W1Sxsk+CeOPwJzsKuY9WM292iqiTmMJi3VRzjMa4PGwk4CqxPpQ
         DDx0eZyoVzOcHwMftvhcCjSJF3u1dWvA6HLFBmIi6wFOw+xXj77HQhHpxkgWkQdXOK+y
         l7dg==
X-Gm-Message-State: AOJu0YyJFNMlbppo3B4lmKkTwDegTyxvGvcswORrHY73mAi0VTqz9PXj
	XLlCyA6jXC2kCuA6M8KbLUDoJEVfYDEop5gaH3Pqer2AKu7zymFPM+HTFVWIlxrhM0GdT2THszi
	VN/OtMFWQFwsujZN1DA35nCH6mRPjjss9TZrV2yl0lnPUDLv69aORwnxodw==
X-Received: by 2002:a05:6e02:1845:b0:361:b16e:27a8 with SMTP id b5-20020a056e02184500b00361b16e27a8mr501339ilv.56.1706042358560;
        Tue, 23 Jan 2024 12:39:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmiODcL9zp+99JCvdM4Kstsy1lBqYLTUCZtl6v/mUlKZDT16hqYuulnT4BDx1TlHQvm9SXYQ==
X-Received: by 2002:a05:6e02:1845:b0:361:b16e:27a8 with SMTP id b5-20020a056e02184500b00361b16e27a8mr501335ilv.56.1706042358342;
        Tue, 23 Jan 2024 12:39:18 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id bp15-20020a056e02348f00b00362768a8dccsm2213778ilb.30.2024.01.23.12.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:39:17 -0800 (PST)
Date: Tue, 23 Jan 2024 13:39:17 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
 mika.westerberg@linux.intel.com, sanath.s@amd.com
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
Message-ID: <20240123133917.765743ed.alex.williamson@redhat.com>
In-Reply-To: <CAJZ5v0hLaka9od=_DB8L5nVJMPdu-9WKDgt5ro3jzE5b7MY-rQ@mail.gmail.com>
References: <20240123185548.1040096-1-alex.williamson@redhat.com>
	<CAJZ5v0gcjxmBnFy=qrUfPCwJyvzS_gy139TqhoF=gf_U_E2jPA@mail.gmail.com>
	<20240123125052.133a42bc.alex.williamson@redhat.com>
	<CAJZ5v0hLaka9od=_DB8L5nVJMPdu-9WKDgt5ro3jzE5b7MY-rQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 20:59:50 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Jan 23, 2024 at 8:51=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Tue, 23 Jan 2024 20:40:32 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > =20
> > > On Tue, Jan 23, 2024 at 7:56=E2=80=AFPM Alex Williamson
> > > <alex.williamson@redhat.com> wrote: =20
> > > >
> > > > The commit noted in fixes added a bogus requirement that runtime PM
> > > > managed devices need to be in the RPM_ACTIVE state for PME polling.
> > > > In fact, only devices in low power states should be polled.
> > > >
> > > > However there's still a requirement that the device config space mu=
st
> > > > be accessible, which has implications for both the current state of
> > > > the polled device and the parent bridge, when present.  It's not
> > > > sufficient to assume the bridge remains in D0 and cases have been
> > > > observed where the bridge passes the D0 test, but the PM state
> > > > indicates RPM_SUSPENDING and config space of the polled device beco=
mes
> > > > inaccessible during pci_pme_wakeup().
> > > >
> > > > Therefore, since the bridge is already effectively required to be in
> > > > the RPM_ACTIVE state, formalize this in the code and elevate the PM
> > > > usage count to maintain the state while polling the subordinate
> > > > device.
> > > >
> > > > Cc: Lukas Wunner <lukas@wunner.de>
> > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > > Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
> > > > Reported-by: Sanath S <sanath.s@amd.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218360
> > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > ---
> > > >  drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
> > > >  1 file changed, 22 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index bdbf8a94b4d0..764d7c977ef4 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work_s=
truct *work)
> > > >                 if (pdev->pme_poll) {
> > > >                         struct pci_dev *bridge =3D pdev->bus->self;
> > > >                         struct device *dev =3D &pdev->dev;
> > > > -                       int pm_status;
> > > > +                       struct device *bdev =3D bridge ? &bridge->d=
ev : NULL;
> > > > +                       int bref =3D 0;
> > > >
> > > >                         /*
> > > > -                        * If bridge is in low power state, the
> > > > -                        * configuration space of subordinate devic=
es
> > > > -                        * may be not accessible
> > > > +                        * If we have a bridge, it should be in an =
active/D0
> > > > +                        * state or the configuration space of subo=
rdinate
> > > > +                        * devices may not be accessible or stable =
over the
> > > > +                        * course of the call.
> > > >                          */
> > > > -                       if (bridge && bridge->current_state !=3D PC=
I_D0)
> > > > -                               continue;
> > > > +                       if (bdev) {
> > > > +                               bref =3D pm_runtime_get_if_active(b=
dev, true);
> > > > +                               if (!bref) =20
> > >
> > > I would check bref <=3D 0 here.
> > > =20
> > > > +                                       continue;
> > > > +
> > > > +                               if (bridge->current_state !=3D PCI_=
D0) =20
> > >
> > > Isn't the power state guaranteed to be PCI_D0 at this point?  If it
> > > isn't, then why? =20
> >
> > Both of these seem necessary to support !CONFIG_PM, where bref would be
> > -EINVAL and provides no indication of the current_state.  Is that
> > incorrect?  Thanks, =20
>=20
> Well, CONFIG_PCIE_PME depends on CONFIG_PM, so I'm not sure how
> dev->pme_poll can be set without it.

I only see that drivers/pci/pci.c:pci_pm_init() sets pme_poll true and
I'm not spotting a dependency on either PCIE_PME or PM to get there.  I
see a few places where pme.c, governed by PCIE_PME, can set pme_poll
false though.

It's also not clear to me that we should skip scanning a device if
pm_runtime_get_if_active() returns -EINVAL for the bridge due to
power.disable_depth.  If runtime PM isn't enabled on the bridge,
shouldn't we be able to test current_state and assume it won't change?
Thanks,

Alex


