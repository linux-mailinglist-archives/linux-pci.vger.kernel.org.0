Return-Path: <linux-pci+bounces-12880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E896EAEA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FF81C21B5C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10925B216;
	Fri,  6 Sep 2024 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGXrhC6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB013BC0D
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605148; cv=none; b=OGE+lTbr06UN4cbM+wUVZGWUZhqcBb7Wh3HZ08m9IRvJxvQGHvURi0Jos0DtQ2zH6O7b8XzOSW+McJr5gxLUZwRKuKKHBu3Pej7eIHJZl0kRPkusjEPAUIULbZfBso/sUk7NxgrO4sQYR/0FgxdZI3P5ESsu4EJupdJ+Ai4gN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605148; c=relaxed/simple;
	bh=IB79HUNBcbGGCEC4njbUIzPzZkrd5FV4EfTXnrsOsQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cq7Y1Zxm59IH4m7UPUttYz3EN76br+mwtjbrnE1hrDKAsj5FC607iSS87gCa5fQt6d3vz17gPf8dC1YmsY7yeX/RGSbOLOVyROh+azFKnUozn7bWqMtyWtFlZTWgdAftXC2XrsvWQ16+jVJLqpPdsNbQ6rYc2siC52qOnqNVOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGXrhC6N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725605134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IB79HUNBcbGGCEC4njbUIzPzZkrd5FV4EfTXnrsOsQI=;
	b=jGXrhC6NnyexLZQozpTRoPd5krmwHdFWEYQMs13EWH737tqyL1TAlWNmFSHRzmGj7dlOit
	EMn5fqNSwLc5V6eDyWPmSh2x+oK53FYaXcSMJGmAB2P9Hw/G1yO5bU8tHEg9PBXcBwd4tG
	P6/YsW30N/leRZ9YSqDp0xKouoQ4k0Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-h8y7RK8AM56cRPx6tcupnA-1; Fri, 06 Sep 2024 02:45:32 -0400
X-MC-Unique: h8y7RK8AM56cRPx6tcupnA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb6f7e7adso13620755e9.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2024 23:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605131; x=1726209931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IB79HUNBcbGGCEC4njbUIzPzZkrd5FV4EfTXnrsOsQI=;
        b=CPGb/TS1Q3umQEdj2LPKF4zSHdv/lps03FNL+ezQ+oLlriLDj+J0jT4rAE2aFO8O9E
         Eq3TnXtkDSeWKXCa14jfYqIdM31ZIKubUTQiBaZjvItE7SmfAJJS5tKCWcgmQoKArhH3
         QBi1unvIu07yH4Shd4ODs5wMa4IFDGSH2waxj/JQYzBnOCAt00FBS1Wf/zRv8bEBPfSF
         /06bIYhcQgdINEXQmFW+H3/o03Wm2sMlXKJubbrOuD8TP3w0dtUeiLl9OwdCWHLnN2kL
         zi9anlYfJb4MY+Bjx4RKCpu2VcOVW+s7Lk5n3JwFCAmWmPgCV6/wlqNxQWpIPP3NJR4M
         L/rw==
X-Forwarded-Encrypted: i=1; AJvYcCXsbdiHMet2PbqOWcvk0oZV8YHgMvZwIzBFBEXt84H3TCLvuJ/d72QN/ms2a0krFzrkdMJsMkh53gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYk7RDplyMR59q0bFpr0MtwN3Fg4nLzighVBLseYVtRn9137Y
	gpanUbkWzeTCsFKAQ6OyW5S3QiCTOJpjOBRrEd2jLuBkwe9lPlaushMC+55Z6O1KSM4GkRDSC5K
	oowSHn3Oe1+LNcn3qg+bdqerKlQxOTSOyuXXjPbBGwBdrnrWpTYPeLfS1HA==
X-Received: by 2002:a5d:4388:0:b0:368:334d:aad4 with SMTP id ffacd0b85a97d-378895b7bdbmr949245f8f.4.1725605131067;
        Thu, 05 Sep 2024 23:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNprd2T+3wZhUq4Gjb4QJ/ioOPE150TbtB1bl0jeGltfCV70kogwrBXD5E8lgEg6FwzBaYtA==
X-Received: by 2002:a5d:4388:0:b0:368:334d:aad4 with SMTP id ffacd0b85a97d-378895b7bdbmr949225f8f.4.1725605130560;
        Thu, 05 Sep 2024 23:45:30 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d32:f900:8057:c371:3005:9e3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788dea8eabsm376653f8f.114.2024.09.05.23.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:45:30 -0700 (PDT)
Message-ID: <0726caa78b940c2f097b094c732a2c008ab0cbfe.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, Alex Williamson
	 <alex.williamson@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Sep 2024 08:45:29 +0200
In-Reply-To: <2072aac8-cdab-40e3-806c-399d38e683f9@kernel.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <20240903094431.63551744.alex.williamson@redhat.com>
	 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	 <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
	 <dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
	 <20240904120721.25626da9.alex.williamson@redhat.com>
	 <ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
	 <20240904151020.486f599e.alex.williamson@redhat.com>
	 <65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
	 <6a17c02077543f98b72662a7189407d0452e6d47.camel@redhat.com>
	 <2072aac8-cdab-40e3-806c-399d38e683f9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 09:37 +0900, Damien Le Moal wrote:
> On 9/5/24 16:13, Philipp Stanner wrote:
> > On Thu, 2024-09-05 at 09:33 +0900, Damien Le Moal wrote:
> > > On 2024/09/05 6:10, Alex Williamson wrote:
> > > > On Wed, 4 Sep 2024 23:24:53 +0300
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > >=20
> > > > > Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson
> > > > > kirjoitti:
> > > > > > On Wed, 04 Sep 2024 15:37:25 +0200
> > > > > > Philipp Stanner <pstanner@redhat.com> wrote:=C2=A0=20
> > > > > > > On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:=C2=
=A0
> > > > >=20
> > > > > ...
> > > > >=20
> > > > > > > If vfio-pci can get rid of pci_intx() alltogether, that
> > > > > > > might
> > > > > > > be a good
> > > > > > > thing. As far as I understood Andy Shevchenko, pci_intx()
> > > > > > > is
> > > > > > > outdated.
> > > > > > > There's only a hand full of users anyways.=C2=A0=20
> > > > > >=20
> > > > > > What's the alternative?=C2=A0=20
> > > > >=20
> > > > > From API perspective the pci_alloc_irq_vectors() & Co should
> > > > > be
> > > > > used.
> > > >=20
> > > > We can't replace a device level INTx control with a vector
> > > > allocation
> > > > function.
> > > > =C2=A0
> > > > > > vfio-pci has a potentially unique requirement
> > > > > > here, we don't know how to handle the device interrupt, we
> > > > > > only
> > > > > > forward
> > > > > > it to the userspace driver.=C2=A0 As a level triggered
> > > > > > interrupt,
> > > > > > INTx will
> > > > > > continue to assert until that userspace driver handles the
> > > > > > device.
> > > > > > That's obviously unacceptable from a host perspective, so
> > > > > > INTx
> > > > > > is
> > > > > > masked at the device via pci_intx() where available, or at
> > > > > > the
> > > > > > interrupt controller otherwise.=C2=A0 The API with the userspac=
e
> > > > > > driver
> > > > > > requires that driver to unmask the interrupt, again
> > > > > > resulting
> > > > > > in a call
> > > > > > to pci_intx() or unmasking the interrupt controller, in
> > > > > > order
> > > > > > to receive
> > > > > > further interrupts from the device.=C2=A0 Thanks,=C2=A0=20
> > > > >=20
> > > > > I briefly read the discussion and if I understand it
> > > > > correctly
> > > > > the problem here
> > > > > is in the flow: when the above mentioned API is being called.
> > > > > Hence it's design
> > > > > (or architectural) level of issue and changing call from
> > > > > foo() to
> > > > > bar() won't
> > > > > magically make problem go away. But I might be mistaken.
> > > >=20
> > > > Certainly from a vector allocation standpoint we can change to
> > > > whatever
> > > > is preferred, but the direct INTx manipulation functions are a
> > > > different thing entirely and afaik there's nothing else that
> > > > can
> > > > replace them at a low level, nor can we just get rid of our
> > > > calls
> > > > to
> > > > pci_intx().=C2=A0 Thanks,
> > >=20
> > > But can these calls be moved out of the spinlock context ? If
> > > not,
> > > then we need
> > > to clarify that pci_intx() can be called from any context, which
> > > will
> > > require
> > > changing to a GFP_ATOMIC for the resource allocation, even if the
> > > use
> > > case
> > > cannot trigger the allocation. This is needed to ensure the
> > > correctness of the
> > > pci_intx() function use.
> >=20
> > We could do that I guess. As I keep saying, it's not intended to
> > have
> > pci_intx() allocate _permanently_. This is a temporary situation.
> > pci_intx() should have neither devres nor allocation.
> >=20
> > > Frankly, I am surprised that the might sleep splat you
> > > got was not already reported before (fuzzying, static analyzers
> > > might
> > > eventually
> > > catch that though).
> >=20
> > It's a super rare situation:
> > =C2=A0* pci_intx() has very few callers
> > =C2=A0* It only allocates if pcim_enable_device() instead of
> > =C2=A0=C2=A0 pci_enable_device() ran.
> > =C2=A0* It only allocates when it's called for the FIRST TIME
> > =C2=A0* All of the above is only a problem while you hold a lock
> >=20
> > >=20
> > > The other solution would be a version of pci_intx() that has a
> > > gfp
> > > flags
> > > argument to allow callers to use the right gfp flags for the call
> > > context.
> >=20
> > I don't think that's a good idea. As I said, I want to clean up all
> > that in the mid term.
> >=20
> > As a matter of fact, there is already __pcim_intx() in pci/devres.c
> > as
> > a pure unmanaged pci_intx() as a means to split and then cleanup
> > the
> > APIs.
>=20
> Yeah. That naming is in fact confusing. __pcim_intx() should really
> be named
> pci_intx()...
>=20
> > One path towards getting the hybrid behavior out of pci_intx()
> > could be
> > to rename __pcim_intx() to pci_intx_unmanaged() and port everyone
> > who
> > uses pci_enable_device() + pci_intx() to that version. That would
> > be
> > better than to have a third version with a gfp_t argument.
>=20
> Sounds good. But ideally, all users that rely on the managed variant
> should be
> converted to use pcim_intx() and pci_intx() changed to not call in
> devres. But
> that may be too much code churn (I have not checked).

Exactly that is the plan.

I looked into that yesterday and my idea is to publish __pcim_intx()
under the name pci_intx_unmanaged(), then port everyone who doesn't
rely on managed behavior to that function and then port everyone who
does rely on it to pcim_intx() (as you suggest).
Afterwards you can remove pci_intx_unmanaged() again and also remove
the hybrid behavior from pci_intx().

It's doable on not that much code. Getting it merged might be
politically difficult, though.

The only thing I'm really a bit afraid of is the pci_intx() user in
pci/msi/ =E2=80=93 MSI calls that through yet another implicit devres call,
pcim_msi_release().
I *suspect* that pci_intx() in MSI can just be made
pci_intx_unmanaged(), but that should be checked carefully. The doubly
implicit devres magic caused some trouble in the past already, as we
had discussed here [1].


P.

[1] https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.ca=
mel@redhat.com/


