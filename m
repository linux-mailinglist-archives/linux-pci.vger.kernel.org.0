Return-Path: <linux-pci+bounces-37477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E89BB5861
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 00:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A313AA24E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E323B632;
	Thu,  2 Oct 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+U7mH14"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4649235C01
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759442737; cv=none; b=aH4+cMj/NXCqfE9w+FPkswri829DsomvOETJ658FVfrJDdYzm4J5qSXKrMGrQDVhqbgKI35vp7xOL2r11FmVJ7H8z0xGF+TBsrAPmi4/HpmYfP2LP4msj/+u/GIT9ft3YPVtFZmZZQ1GLkNU5pGixmbAdqyFLkXBaNaoCM9OoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759442737; c=relaxed/simple;
	bh=1i2PGHOBlzesOlKb0KunNSlwKXJ8YEtYzNgdw1lIPCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqM2Bm8hj8i4gpkoOM2CMTqT6g+4DCnAH5697B8nx4EjFNEhInmT6aPzwgp7f+DW4Gr+UHE6TsLObB8vTMax9gyLUnrwk9gZYoOe4hSilv7U2JRx0l3gHPiVdw1O7065E/WkfgnqASmPZkH/DB5WwhO62QeGNYfiYc580g7ZNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+U7mH14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E1DC16AAE
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 22:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759442737;
	bh=1i2PGHOBlzesOlKb0KunNSlwKXJ8YEtYzNgdw1lIPCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a+U7mH14xtrkWaLGuLJBcwokOwfhjfRuSNt8H4dzjf/V7Y98PWGlbBj4U2vO2Dx0W
	 3i0NdOTdKNsEOY4VofKLwULGP3CbtYfj8qYVzRhOYFKGnd9hrG+bScaAg+U0eQ3vb0
	 x1JueHZ3scb99v7GouDKRqZsNZIDuUa4VGsW+qz5j+eOKjeTtMVm+bg/YvsWoruG9v
	 +vOnmSgG5EIgk34K4v/5Idli9PRTGxZ9fKKrY+KR6GkPVNGo8WJhN/Mtw+ZnoGoU2H
	 PzQCDrlrRn+wnlhuNi752niHMPhQbSy3mAsKVXbCstQA0QA05Mxlqf3U3vmomXH5Q/
	 IiRrcgF050Qxw==
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63470a6f339so1668733d50.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 15:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyk2Y/MgaSjbkh/uqlO+VpA952SkaoOqj15tSucBCkIpeMkA/Q7vcJcyOcLnSa8P0meDY7g3WJY9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHxjf/JMcnNrFWEIipuXP3NXBjemR6mTtzqPiuR6SoO+dstVN
	JLsHuYT6mIvsoUpG54dG6xwOlqOKt1npBBpe4r2pPLpFuUPsIHKOa2+pA6Bx2w7HEVF5QuS9n9F
	hzJugzSw03uwgyWs0tsA6+fhG9Mo1y5/ryP0BYX9NeA==
X-Google-Smtp-Source: AGHT+IEGz/E3gvgWQWJBpGvhYdizHBoqpgoHXPFVlDxboUphdex83hV8i8e33+KTknFYTQAzUSqc94p8KlQRHxX9MpY=
X-Received: by 2002:a05:690e:1042:b0:635:4ed0:5767 with SMTP id
 956f58d0204a3-63b9a0eb8e5mr564620d50.53.1759442736413; Thu, 02 Oct 2025
 15:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh> <CACePvbXrbR=A43UveqPrBmQHAfvjuJGtw9XyUQvpYe941KwzuA@mail.gmail.com>
 <2025100142-slick-deserving-4aed@gregkh>
In-Reply-To: <2025100142-slick-deserving-4aed@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 15:05:25 -0700
X-Gmail-Original-Message-ID: <CACePvbVCXGn-c3dVZfLTq+GbcFfjWchN0OwEHDNs_-EV6TJfyg@mail.gmail.com>
X-Gm-Features: AS18NWDQhcK4fgqdE0eBM-UDvfpXtCItsSWyIznJ_2678Y5nqftnJrabxisTIzg
Message-ID: <CACePvbVCXGn-c3dVZfLTq+GbcFfjWchN0OwEHDNs_-EV6TJfyg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> >
> > for example, the pci has this sysfs control api:
> >
> > "/sys/bus/pci/devices/0000:04:00.0/driver_override" which takes the
> > *driver name* as data to override what driver is allowed to bind to
> > this device.
> > Does this driver_override consider it as using the driver name as part
> > of the abi? If not, why?
>
> Because the bind/unbind/override was created as a debug facility for
> doing kernel development and then people have turned it into a "let's
> operate our massive cloud systems with this fragile feature".

Frankly, I did not know that it was a debug API or should be treated like o=
ne.

Let's say we want to make it right for now and future, any
suggestion/guide line for the new API?


> We have never said that driver names will remain the same across
> releases, and they have changed over time.  Device ids have also moved

That is fine. The LUO PCI just says that at the old kernel that does
the liveupdate from, that is the driver name "foo1" in the old kernel
A1. The new kernel A2 that gets boot will know about the old kernel
A1, at least in the typical data center. There will be a test live
update A1 to A2. Validation before officially rolling out the
liveupdate kernel. The new kernel A2 can know that, oh, on this old
kernel, A1, this driver "foo2" used to call "foo1" in A1.  Then it can
let the PCI core bind to the "foo2" for that device instead. Later
when A2 liveupdate to A3, A3 can drop the knowledge of the "foo1" if
we are sure the A1 kernel is no longer supported.

> from one driver to another as well, making the "control" of the device
> seem to have changed names.

The name can be changed, just the new kernel needs to know about the
change and handle it. Extra complexity but not impossible.

>
> > What live update wants is to make that driver_override persistent over
> > kexec. It does not introduce the "driver_override" API. That is
> > pre-existing conditions. The PCI liveupdate just wants to use it.
>
> That does not mean that this is the correct api to use at all.  Again,
> this was a debugging aid, to help with users who wanted to add a device
> id to a driver without having to rebuild it.  Don't make it something
> that it was never intended to be.
>
> Why not just make a new api as you are doing something new here?  That
> way you get to define it to work exactly the way you need?

Sure, I can invent a new API. I am just a bit afraid to introduce a
new API and carry the burden of supporting it forever.

Another idea is that we don't remember the driver's name. The kernel
just enforces that, if the device is liveupdate, no auto probe at all.
Then push the responsibility to the user space to load the driver and
manually bind the device to the right driver. The user space will
still need to know what is the previous driver name or some way to
identify the right driver for this liveupdate process. Somebody will
need to know something like a driver name and pass that to the new
kernel to restore it. But not the kernel.

It will have a drawback on extra latency of the black out window, now
after PCI scans the PCI bus, a user space program will be run to bind
and probe the driver.

>
> > I want to get some basic understanding before adventure into the more
> > complex solutions.
>
> You mean "real" solutions :)

I mean the more upstream accepted solutions.

> It's not my requirement to say "here is C", but rather I am saying "B is
> not going to scale over time as GUIDs are a pain to manage".

I can agree to that.

> > Do you have any other suggestion how to prevent the live update PCI
> > device bind to a different driver after kexec? I am happy to work on
> > the direction you point out and turn that into a patch for the
> > discussion purpose.
>
> Why prevent it?  Why not just have a special api just for drivers that
> want to use this new feature?

The typical GPU will bind to the VFIO driver when the VM is using it.
If we don't prevent auto probe, the PCI device will auto probe to the
native driver on the next kexec. Naturally, the native driver will
have no day to decode the data saved from the previous vfio driver.

Chris

