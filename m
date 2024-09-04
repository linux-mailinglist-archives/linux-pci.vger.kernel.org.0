Return-Path: <linux-pci+bounces-12751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB3F96BEC9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 15:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D98AB2D47D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC9B1DA116;
	Wed,  4 Sep 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/9RN6ZY"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E091CF7B9
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456579; cv=none; b=UYKLifu7yuPKsDBjGAAPQCZSuFXaP6bhxISSf6f1oX6oRWDYohj2u2LsY5r4Jj5EvS16GVdD1LquCsrpTxv75eWMCPa1mHroKnHG1KRHRaaXEXaORunqHXxFQRFUZEigahryNF7Foqr/1irFRwM4xptYnodh6tCxOl+G21ogHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456579; c=relaxed/simple;
	bh=BSz60P1IrsR7U2d5P+R2ikILGxiRJcRQZaxSjdr0EAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f40ecbzzD/D1p0gLDxfP8g9AOMTrjKsuP9OYhJLz9V6CReAowULSwToSP/N0Jwnu4WhfKLgq2Hz4VfLTV3wE7RAUBJxLe5qASXhPAIjbX4DbQgo2ZEIsHcMF9ohm4U1Dyqvh1QkgyIO+D4nfEgw/c1rX5CNg+dQbw5pN22UHKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/9RN6ZY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725456576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLYHw9iWqzWp7KnKRWoIkY5cQ6gZDO+n4+MBojwCGY8=;
	b=Z/9RN6ZYxlbx+7SzeVRfuxooqh2DZzVYjHJ/OpXgxC3utfKOy2zJxNjT2VnnwofG3qdHzj
	YnN7C3+IEz228eCjsu4qN3/XfB43O13DW9/UEQtFJ869fkGfqtkEtTU7lYg1g+sguTxIqk
	3juK5qG3s+1lirI+aucHRsuqsTWU+pE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-o9sNHEVjPNKSB-bCV8A1Ng-1; Wed, 04 Sep 2024 09:29:35 -0400
X-MC-Unique: o9sNHEVjPNKSB-bCV8A1Ng-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb2899d57so7979365e9.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 06:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456574; x=1726061374;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLYHw9iWqzWp7KnKRWoIkY5cQ6gZDO+n4+MBojwCGY8=;
        b=T9mxJ33FizA5+Yf9DAQgibQIV4KRT1XpRqjrGntNCj4Xtk6tgc41YT+gFj0qRVbC+f
         hGEiH8X6zY2r/zbg1uhq7njyRNu1pFF8YRFE3KshdImTwjXl/y5a4aIAe8hbmiVG5Lg/
         IdWcZlYCaDWb77+nn8sQUAeas8pGgPOH7MrdXk4rh8R+hCkyxHMmWxEw2soiHw0nLolt
         AhYrcPczdMLt9b79hmOMYZuUz7yMcSfArbaRlARoE6D2Do7Qm7F3Xhz7q4Pu3Zbc4GXf
         Ezbk6oVFqd5nvwmSQOesUTv106aiQmmXTZJ/k+JNRgkH8kZm3oFmV6TPkknG8jFQcD5W
         fi/w==
X-Forwarded-Encrypted: i=1; AJvYcCWAdQ1jwAxzukaJQwoXQ90rPCwPAnHjFOYR8UhgshxIqD9KCvMCaAsn0Dn0PjWOEf1Mn4tLoXz/RDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiS4GqbsjcHFFeV5Clb+4oTBb6JlI8UsPMifkcDP+S6/icMjQJ
	1b81EoaHRdCE9tWDAATs4kpRV1vVPFfHYkzJOn4ag1N7RQqtCWjdbnSCU7igb077fbAraPHVGSd
	M6ICPYDXO98kUtwtrsu0x2K+mz6siiGfQ3l/09stEjpbGxYDdPH4HNYSaPg==
X-Received: by 2002:a05:600c:5125:b0:426:6667:bbbe with SMTP id 5b1f17b1804b1-42c9544f182mr21474895e9.9.1725456573979;
        Wed, 04 Sep 2024 06:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHik21ZJ3vWD7/R0bF3eBiU2vdlbN43GCOhBudbhWvH6uYy2AYEX29uwzkfipqdixElqtt8EA==
X-Received: by 2002:a05:600c:5125:b0:426:6667:bbbe with SMTP id 5b1f17b1804b1-42c9544f182mr21474505e9.9.1725456573277;
        Wed, 04 Sep 2024 06:29:33 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb85ffbadsm197858155e9.12.2024.09.04.06.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:29:32 -0700 (PDT)
Message-ID: <717e86b10072f7c69f2f9534eb4649f4effe0eb5.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Date: Wed, 04 Sep 2024 15:29:31 +0200
In-Reply-To: <20240904065726.1f7275b6.alex.williamson@redhat.com>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <20240903094431.63551744.alex.williamson@redhat.com>
	 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	 <20240904065726.1f7275b6.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 06:57 -0600, Alex Williamson wrote:
> On Wed, 04 Sep 2024 09:06:37 +0200
> Philipp Stanner <pstanner@redhat.com> wrote:
>=20
> > On Tue, 2024-09-03 at 09:44 -0600, Alex Williamson wrote:
> > > On Thu, 25 Jul 2024 14:07:30 +0200
> > > Philipp Stanner <pstanner@redhat.com> wrote:
> > > =C2=A0=20
> > > > pci_intx() is a function that becomes managed if
> > > > pcim_enable_device()
> > > > has been called in advance. Commit 25216afc9db5 ("PCI: Add
> > > > managed
> > > > pcim_intx()") changed this behavior so that pci_intx() always
> > > > leads
> > > > to
> > > > creation of a separate device resource for itself, whereas
> > > > earlier,
> > > > a
> > > > shared resource was used for all PCI devres operations.
> > > >=20
> > > > Unfortunately, pci_intx() seems to be used in some drivers'
> > > > remove()
> > > > paths; in the managed case this causes a device resource to be
> > > > created
> > > > on driver detach.
> > > >=20
> > > > Fix the regression by only redirecting pci_intx() to its
> > > > managed
> > > > twin
> > > > pcim_intx() if the pci_command changes.
> > > >=20
> > > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")=C2=A0=20
> > >=20
> > > I'm seeing another issue from this, which is maybe a more general
> > > problem with managed mode.=C2=A0 In my case I'm using vfio-pci to
> > > assign
> > > an
> > > ahci controller to a VM.=C2=A0=20
> >=20
> > "In my case" doesn't mean OOT, does it? I can't fully follow.
>=20
> "OOT" Out Of Tree?=C2=A0 No, "In my case" is simply introducing the
> scenario
> in which I see the issue.=C2=A0 vfio-pci is an in-tree driver used to
> attach
> devices to userspace drivers, such as QEMU.=C2=A0 The ahci driver is
> loaded
> during system boot, setting the is_managed flag.=C2=A0 The ahci driver is
> then unbound from the device and the vfio-pci driver is bound.=C2=A0 The
> vfio-pci driver provides a uAPI for userspace drivers to operate a
> device in an an IOMMU protected context.

Alright, thx for the clarification.

> =C2=A0
> > > =C2=A0 ahci_init_one() calls pcim_enable_device()
> > > which sets is_managed =3D true.=C2=A0 I notice that nothing ever sets
> > > is_managed to false.=C2=A0 Therefore now when I call pci_intx() from
> > > vfio-
> > > pci
> > > under spinlock, I get a lockdep warning=C2=A0=20
> >=20
> > I suppose you see the lockdep warning because the new pcim_intx()
> > can=20
> > now allocate, whereas before 25216afc9db5 it was
> > pcim_enable_device()
> > which allocated *everything* related to PCI devres.
> >=20
> > > =C2=A0as I no go through pcim_intx()
> > > code after 25216afc9db5=C2=A0=C2=A0=20
> >=20
> > You alwas went through pcim_intx()'s logic. The issue seems to be
> > that
> > the allocation step was moved.
>=20
> Unintentionally, yes, I believe so.=C2=A0 vfio-pci is not a managed,
> devres
> driver and therefore had no expectation of using the managed code
> path.

Yes, I agree this needs to be fixed through the solution you proposed.

>=20
> > > since the previous driver was managed.=C2=A0=20
> >=20
> > what do you mean by "previous driver"?
>=20
> As noted, the ahci driver is first bound to the device at boot,
> unbound, and the vfio-pci driver bound to the device.=C2=A0 The ahci
> driver
> is the previous driver.
>=20
> > > =C2=A0 It seems
> > > like we should be setting is_managed to false is the driver
> > > release
> > > path, right?=C2=A0=20
> >=20
> > So the issue seems to be that the same struct pci_dev can be used
> > by
> > different drivers, is that correct?
>=20
> Yes, and more generically, the driver release should undo everything
> that has been configured by the driver probe.
>=20
> > If so, I think that can be addressed trough having
> > pcim_disable_device() set is_managed to false as you suggest.
>=20
> If that's sufficient and drivers only call pcim_disable_device() in
> their release function.

pcim_disable_device() is not intended to be used directly by drivers.
It's basically the devres callback for pcim_enable_device() and is
called in everyone's release path automatically by devres.
(I agree that the naming is not superbe)

> =C2=A0 I also note that f748a07a0b64 ("PCI: Remove
> legacy pcim_release()") claims that:
>=20
> =C2=A0 Thanks to preceding cleanup steps, pcim_release() is now not neede=
d
> =C2=A0 anymore and can be replaced by pcim_disable_device(), which is the
> =C2=A0 exact counterpart to pcim_enable_device().
>=20
> However, that's not accurate as pcim_enable_device() adds a devm
> action, unconditionally calls pci_enable_device() and sets is_managed
> to true.

It's not accurate in regards with is_managed.

The rest is fine IMO. The devres callback shall be added, and the
unconditional call to pci_enable_device() is also desired.

> =C2=A0 If we assume pcim_pin_device() is a valid concept, don't we
> still need to remove the devm action as well?

No. As pcim_disable_device() is the very devres callback, it does not
need to remove itself. Devres calls it once and then it's gone.

However, pcim_pin_device() IMO is not a valid concept. Who wants such
behavior IMO shall use pci_enable_device() and pci_disable_device()
manually.
I proposed removing it here:
https://lore.kernel.org/all/20240822073815.12365-2-pstanner@redhat.com/

(Note that previously it could not be removed because
pcim_enable_device() also allocated all the stuff needed by
pci_request_region() etc.)

>=20
> > Another solution can could at least consider would be to use a
> > GFP_ATOMIC for allocation in get_or_create_intx_devres().
>=20
> If we look at what pci_intx() does without devres, it's simply
> reading
> and setting or clearing a bit in config space.=C2=A0 I can attest that a
> driver author would have no expectation that such a function
> allocates
> memory

A driver author would not have any expectation of a function implicitly
doing anything with devres. That's the reason why I did all this work
in the first place, to, ultimately, remove this hybrid behavior from
all pci_ functions.
So that devres functions are clearly marked with pcim_

That is, however, not that easy because everyone who uses
pcim_enable_device() in combination with pci_intx() first has to be
ported to a pci_intx()-version that has nothing to do with devres.


>  and there are scenarios where we want to call this with
> interrupts disabled, such as within an interrupt context.=C2=A0 So, TBH,
> it
> might make sense to consider whether an allocation in this path is
> appropriate at all, but I'm obviously no expert in devres.

The entire hybrid nature from pci_intx() should be removed.
I'm working on that.

The hybrid nature was always there, but the allocation was not. It
would be removed later together with the hybrid devres usage.

>=20
> > I suppose your solution is the better one, though.
>=20
> I see you've posted a patch, I'll test it as soon as I'm able.=C2=A0

If it works from what I understand that should solve those issues for
now until we can phase out pci_intx() usage that relies on the device
resource.

---
btw. I just looked into the old code and found that this one also
already had a similar half-bug with is_managed. It never sets it to
false again, but pci_intx() runs into:

static struct pci_devres *find_pci_dr(struct pci_dev *pdev)
{
	if (pci_is_managed(pdev))
		return devres_find(&pdev->dev, pcim_release, NULL,
NULL);
	return NULL;
}


So in your case pci_is_managed() would have also been true and the only
reason no problem occurred is that devres_find() doesn't find the
device resource of the previous driver anymore, so pci_intx() won't use
that memory.
---


Thanks for debugging,
P.

> Thanks,
>=20
> Alex
>=20


