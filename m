Return-Path: <linux-pci+bounces-12778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663F96C5F7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1721C24586
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B051E1A2F;
	Wed,  4 Sep 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTM7/baz"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC81DFE2D
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473250; cv=none; b=YTeITJ40ayTU+MGVttqgWhbIQhFwNt8CQ0rk/KV3GKyWucynEwzxR7sv8pGEg91C4OC468CzMDcR6MkJJzADUmnFCG4Xru/SXLhdp9MGitvZaFYRfT9Z7/6X9aQ1Lslh3NW9pgKtnW454R+xxbgH/nA1i1rwfmE25gBy1bShxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473250; c=relaxed/simple;
	bh=4JDaN84/+l8BN++2AZOUB6dD85LB5EgN2v/54XgYlEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GM72buFKuIn+TYU3dl8aYpuVEof+KqVktswYV0xOkM9Wx00QzMH9FKPJW1R6hUhvygNfpjzBFxLW08BO2qBfpIxhTG2MoExQ13q6Ra0r1wpf63N79569kDSl6y76Hppzba+m2T7jVOGtWGwgCYP0//p+UC/C41IaTpYUUKE5LCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTM7/baz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725473247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu/yLk8/R1ac4Suy560HLYHSZgCY6o0Vy3qlUM3yxfQ=;
	b=KTM7/bazGAbMUV+HzF+Q/RBDYUVlhrsVEwgIpvEQXaHCUT42r8oCUhN64MwB/MWKCw+lby
	PAxzOhJOO/8F8geAudYVz1IJXRJ4dA0ZRyJkicQLGgLiR14682ua/Aa1NshHPfng7sXcL8
	PEw+p5uokNHKAZ/CbJr/ILce7XOHago=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-yRr7UKfONJ-5DXtQj2Wybg-1; Wed, 04 Sep 2024 14:07:24 -0400
X-MC-Unique: yRr7UKfONJ-5DXtQj2Wybg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f371d6dc0so3081585ab.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 11:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473243; x=1726078043;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iu/yLk8/R1ac4Suy560HLYHSZgCY6o0Vy3qlUM3yxfQ=;
        b=DgAG6UAVXWgZKuOoEteKlx824FGlC5O1Ge4E0sFiIpcvgbfGpkDEDPQyfaSlcQz4Ok
         PCtxl5XHyn8xQgm3ZjPm7bcg9JrLFx3FkLVvkBOBOtqMa449Pt+EzP40jXq3w8LOpuLm
         BxGjN0TneuEzUvSGR7jPkvLhX0Hr3xvNgJvWwRX/dCw/E1pn3FFTpBo4kGmYyGqRGGFe
         mNcqIA3pNYSvjNbI3BavW9JwnCK5EzvLJ3fCPSgK+xEDH0siR/KPHTR1v+FiAVPsupNc
         EeB6eWaFUxtbozm1HZHg/0QMZfHrWqdDmcXWkIKlrKBNNCOuIQJ1Chu1HvspgfZh+HOG
         tenQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwGiS3qiDNhCG8XfCnPjeFE9nCfqF6PPb353djEHXk99r5y5NxjDRWQGnlOn9uNqCIbOKdey10HWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1iZx4RKgQERNiVd2PNHtnUbJZuyqCtY9uErqCDmv1VB3zYtu
	obJo587XjKK6Y09+aqVBMGhtz2aLVaOy/5EaOsHBnUthtxR/0uTHGv2nUCTbaIoAESvsKURlNhk
	et1bzOXw6jKyz2FEldOBQObok0KENXeO3xnhnA7zITK6Z8/mtyq4gK7KMNQ==
X-Received: by 2002:a05:6e02:1fe1:b0:39f:74f9:f698 with SMTP id e9e14a558f8ab-39f74f9f815mr17962695ab.2.1725473243497;
        Wed, 04 Sep 2024 11:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWcwiNExNxy+wR3dqWCmTh7RxH4JM6kRZfF+jmEQTuy6fQuanUKOf4HT+2P2vnJOM28EurbQ==
X-Received: by 2002:a05:6e02:1fe1:b0:39f:74f9:f698 with SMTP id e9e14a558f8ab-39f74f9f815mr17962505ab.2.1725473243102;
        Wed, 04 Sep 2024 11:07:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afaf38bsm37811135ab.19.2024.09.04.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:07:22 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:07:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= 
 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240904120721.25626da9.alex.williamson@redhat.com>
In-Reply-To: <dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
References: <20240725120729.59788-2-pstanner@redhat.com>
	<20240903094431.63551744.alex.williamson@redhat.com>
	<2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	<24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
	<dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Sep 2024 15:37:25 +0200
Philipp Stanner <pstanner@redhat.com> wrote:

> On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:
> > On 2024/09/04 16:06, Philipp Stanner wrote: =20
> > > On Tue, 2024-09-03 at 09:44 -0600, Alex Williamson wrote: =20
> > > > On Thu, 25 Jul 2024 14:07:30 +0200
> > > > Philipp Stanner <pstanner@redhat.com> wrote:
> > > >  =20
> > > > > pci_intx() is a function that becomes managed if
> > > > > pcim_enable_device()
> > > > > has been called in advance. Commit 25216afc9db5 ("PCI: Add
> > > > > managed
> > > > > pcim_intx()") changed this behavior so that pci_intx() always
> > > > > leads
> > > > > to
> > > > > creation of a separate device resource for itself, whereas
> > > > > earlier,
> > > > > a
> > > > > shared resource was used for all PCI devres operations.
> > > > >=20
> > > > > Unfortunately, pci_intx() seems to be used in some drivers'
> > > > > remove()
> > > > > paths; in the managed case this causes a device resource to be
> > > > > created
> > > > > on driver detach.
> > > > >=20
> > > > > Fix the regression by only redirecting pci_intx() to its
> > > > > managed
> > > > > twin
> > > > > pcim_intx() if the pci_command changes.
> > > > >=20
> > > > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()") =20
> > > >=20
> > > > I'm seeing another issue from this, which is maybe a more general
> > > > problem with managed mode.=C2=A0 In my case I'm using vfio-pci to
> > > > assign
> > > > an
> > > > ahci controller to a VM. =20
> > >=20
> > > "In my case" doesn't mean OOT, does it? I can't fully follow.
> > >  =20
> > > > =C2=A0 ahci_init_one() calls pcim_enable_device()
> > > > which sets is_managed =3D true.=C2=A0 I notice that nothing ever se=
ts
> > > > is_managed to false.=C2=A0 Therefore now when I call pci_intx() from
> > > > vfio-
> > > > pci
> > > > under spinlock, I get a lockdep warning =20
> > >=20
> > > I suppose you see the lockdep warning because the new pcim_intx()
> > > can=20
> > > now allocate, whereas before 25216afc9db5 it was
> > > pcim_enable_device()
> > > which allocated *everything* related to PCI devres.
> > >  =20
> > > > =C2=A0as I no go through pcim_intx()
> > > > code after 25216afc9db5=C2=A0 =20
> > >=20
> > > You alwas went through pcim_intx()'s logic. The issue seems to be
> > > that
> > > the allocation step was moved.
> > >  =20
> > > > since the previous driver was managed. =20
> > >=20
> > > what do you mean by "previous driver"? =20
> >=20
> > The AHCI driver... When attaching a PCI dev to vfio to e.g.
> > passthrough to a VM,
> > the device driver must first be unbound and the device bound to vfio-
> > pci. So we
> > switch from ahci/libata driver to vfio. When vfio tries to enable
> > intx with
> > is_managed still true from the use of the device by ahci, problem
> > happen.
> >  =20
> > >  =20
> > > > =C2=A0 It seems
> > > > like we should be setting is_managed to false is the driver
> > > > release
> > > > path, right? =20
> > >=20
> > > So the issue seems to be that the same struct pci_dev can be used
> > > by
> > > different drivers, is that correct?
> > >=20
> > > If so, I think that can be addressed trough having
> > > pcim_disable_device() set is_managed to false as you suggest.
> > >=20
> > > Another solution can could at least consider would be to use a
> > > GFP_ATOMIC for allocation in get_or_create_intx_devres(). =20
> >=20
> > If it is allowed to call pci_intx() under a spin_lock, then we need
> > GFP_ATOMIC.
> > If not, then vfio-pci needs to move the call out of the spinlock. =20
>=20
> If vfio-pci can get rid of pci_intx() alltogether, that might be a good
> thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
> There's only a hand full of users anyways.

What's the alternative?  vfio-pci has a potentially unique requirement
here, we don't know how to handle the device interrupt, we only forward
it to the userspace driver.  As a level triggered interrupt, INTx will
continue to assert until that userspace driver handles the device.
That's obviously unacceptable from a host perspective, so INTx is
masked at the device via pci_intx() where available, or at the
interrupt controller otherwise.  The API with the userspace driver
requires that driver to unmask the interrupt, again resulting in a call
to pci_intx() or unmasking the interrupt controller, in order to receive
further interrupts from the device.  Thanks,

Alex


