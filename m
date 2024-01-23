Return-Path: <linux-pci+bounces-2498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD678399DE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737C128E0F5
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 19:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB6382D6E;
	Tue, 23 Jan 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYLVP+0W"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12558003E
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039461; cv=none; b=na/52hqkBMLFA6ZaETv/nfwwWAh5VIasF6/AXg0o3jpuy/r522vW8Tr9ytDlQ6cBDvWysvbIxbhdvoLVTG/AxXVlv+buZr2/+zewsGDapbKpdwLL2QRCf5fg/CeckRHtfBsLGEYA8Y4LKO6YBmC1cEazkAhMXuEWaCNY8JucmvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039461; c=relaxed/simple;
	bh=atmMgFZ0VDdqm32h93eTnbeoKrST6AWDWJ94JSzbFu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeBbbBQ7whflirutDpwQoY8DIAkWsSkcjeerU0Fyopb9bVxJMBPfZhNpDv1lmBsEtVAKCIwVtK3ovw8s3Vs5F7BcEpkh37Va50FV8myCnz8fX4kWaKX3Vj4D7Z0q887c8dLrzOKXS1GDA+ysttk2Dz2z6oN/Ewx/QvV80PkWWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYLVP+0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706039458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IC4IyIp0l2vzZuTb5GTBEoynlCl+e0wgVjP+mQKMCmg=;
	b=OYLVP+0WDSHwWkBiVqAV0F2wR+5ywOjg04EAC3tGJMsoi3GkORS6AYZ1+kOQz58kIRczmm
	h43HIgwzlpaekRCk1D5aKvxeuDHF4IYfcgt6RlHsXZahcjY0ddJDruDtG03dBBoi8YQliT
	E19VAAcwfusMD2QeFyHvbJeOSvi4fE8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-eAZt0gnYMWKocIyNZZDhxw-1; Tue, 23 Jan 2024 14:50:57 -0500
X-MC-Unique: eAZt0gnYMWKocIyNZZDhxw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bbb6fd2cceso5378183b6e.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 11:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039456; x=1706644256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IC4IyIp0l2vzZuTb5GTBEoynlCl+e0wgVjP+mQKMCmg=;
        b=Si0WQxbbkz4WKlU7eb5MYrgbCX6w7NUWpr77qOfNARwlwxAAsSsgmzrrgJrvrf5YSV
         gdS/8qo5JWupBrksahwsqg/UVoBNy3uB8V1hR/M0f/g9oTvwDZNtzYk1Y9GCdsiLvX0p
         FwXEtcYHDjdSinVoxDr/yIyOx99GXpOwwet8drI2p8zW/SFlMMF5CtqTJtM0kw3pgY8E
         /FYPpq/ezTDSDEtyEiYJAvZj64JSj5wBcGvlPcMQz+QZlC1WmqSQJhyOHGh3PHosnaS3
         sURDz9KJRiXf8LduQUodjL1xEJ5vvCWlDz2BM4VkJr+QVnlJk0UVeynETV6GPsHQJetL
         Hpkg==
X-Gm-Message-State: AOJu0Yyyq4yRbTjFovvgJz1QkCT5boW6WAtwYvQrt6adG6FDFGQ4Rh6P
	kLgRaw2/VfE3tBSwpLeTemUVZDcp2QGbi7fFRXuCq+IJmO/YEZ3fscXaF7uDhqOeM28dnVgxuBF
	/lK/fQCAU7wmbeAvfB1pxvoibuAVqL3BJY0r59Y/jJxkDKG+SWsm6P5NnxQ==
X-Received: by 2002:a05:6808:319a:b0:3bd:a3ba:d81f with SMTP id cd26-20020a056808319a00b003bda3bad81fmr531602oib.64.1706039456259;
        Tue, 23 Jan 2024 11:50:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEIsnYse/U4amKYk68ygEt0fjqI3E8wFsPYvYpHD7fm9WTtAzHCv8t9K+5jZeyIydbcrGgoA==
X-Received: by 2002:a05:6808:319a:b0:3bd:a3ba:d81f with SMTP id cd26-20020a056808319a00b003bda3bad81fmr531588oib.64.1706039455942;
        Tue, 23 Jan 2024 11:50:55 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id r17-20020a544891000000b003bbc550c0cbsm2299460oic.28.2024.01.23.11.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:50:55 -0800 (PST)
Date: Tue, 23 Jan 2024 12:50:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
 mika.westerberg@linux.intel.com, sanath.s@amd.com
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
Message-ID: <20240123125052.133a42bc.alex.williamson@redhat.com>
In-Reply-To: <CAJZ5v0gcjxmBnFy=qrUfPCwJyvzS_gy139TqhoF=gf_U_E2jPA@mail.gmail.com>
References: <20240123185548.1040096-1-alex.williamson@redhat.com>
	<CAJZ5v0gcjxmBnFy=qrUfPCwJyvzS_gy139TqhoF=gf_U_E2jPA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 20:40:32 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Jan 23, 2024 at 7:56=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > The commit noted in fixes added a bogus requirement that runtime PM
> > managed devices need to be in the RPM_ACTIVE state for PME polling.
> > In fact, only devices in low power states should be polled.
> >
> > However there's still a requirement that the device config space must
> > be accessible, which has implications for both the current state of
> > the polled device and the parent bridge, when present.  It's not
> > sufficient to assume the bridge remains in D0 and cases have been
> > observed where the bridge passes the D0 test, but the PM state
> > indicates RPM_SUSPENDING and config space of the polled device becomes
> > inaccessible during pci_pme_wakeup().
> >
> > Therefore, since the bridge is already effectively required to be in
> > the RPM_ACTIVE state, formalize this in the code and elevate the PM
> > usage count to maintain the state while polling the subordinate
> > device.
> >
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
> > Reported-by: Sanath S <sanath.s@amd.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218360
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
> >  1 file changed, 22 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index bdbf8a94b4d0..764d7c977ef4 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work_struc=
t *work)
> >                 if (pdev->pme_poll) {
> >                         struct pci_dev *bridge =3D pdev->bus->self;
> >                         struct device *dev =3D &pdev->dev;
> > -                       int pm_status;
> > +                       struct device *bdev =3D bridge ? &bridge->dev :=
 NULL;
> > +                       int bref =3D 0;
> >
> >                         /*
> > -                        * If bridge is in low power state, the
> > -                        * configuration space of subordinate devices
> > -                        * may be not accessible
> > +                        * If we have a bridge, it should be in an acti=
ve/D0
> > +                        * state or the configuration space of subordin=
ate
> > +                        * devices may not be accessible or stable over=
 the
> > +                        * course of the call.
> >                          */
> > -                       if (bridge && bridge->current_state !=3D PCI_D0)
> > -                               continue;
> > +                       if (bdev) {
> > +                               bref =3D pm_runtime_get_if_active(bdev,=
 true);
> > +                               if (!bref) =20
>=20
> I would check bref <=3D 0 here.
>=20
> > +                                       continue;
> > +
> > +                               if (bridge->current_state !=3D PCI_D0) =
=20
>=20
> Isn't the power state guaranteed to be PCI_D0 at this point?  If it
> isn't, then why?

Both of these seem necessary to support !CONFIG_PM, where bref would be
-EINVAL and provides no indication of the current_state.  Is that
incorrect?  Thanks,

Alex


> > +                                       goto put_bridge;
> > +                       }
> >
> >                         /*
> > -                        * If the device is in a low power state it
> > -                        * should not be polled either.
> > +                        * The device itself should be suspended but co=
nfig
> > +                        * space must be accessible, therefore it canno=
t be in
> > +                        * D3cold.
> >                          */
> > -                       pm_status =3D pm_runtime_get_if_active(dev, tru=
e);
> > -                       if (!pm_status)
> > -                               continue;
> > -
> > -                       if (pdev->current_state !=3D PCI_D3cold)
> > +                       if (pm_runtime_suspended(dev) &&
> > +                           pdev->current_state !=3D PCI_D3cold)
> >                                 pci_pme_wakeup(pdev, NULL);
> >
> > -                       if (pm_status > 0)
> > -                               pm_runtime_put(dev);
> > +put_bridge:
> > +                       if (bref > 0)
> > +                               pm_runtime_put(bdev);
> >                 } else {
> >                         list_del(&pme_dev->list);
> >                         kfree(pme_dev);
> > -- =20
>=20


