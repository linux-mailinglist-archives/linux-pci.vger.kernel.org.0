Return-Path: <linux-pci+bounces-37269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25B2BADF15
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754A33C5E15
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E64C2FB0BE;
	Tue, 30 Sep 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdbmKi6t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698EE1C5F27
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246901; cv=none; b=mG+/dwy2hEtaTUNh4CKc8XNEfY0MDLkhplOOMNkqZZ28EtH95ZFCSnF8nCdrNsKFI7foiTpu4Sg6ownQL3iImflbA3LXhZz77bWuP+8n66uDIN7EguhpmEEXduIzIPZQfleROz1o7jXFoYSqvsCZQWQXjy+yyXXJ7lpk7ocM8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246901; c=relaxed/simple;
	bh=HILxtH794LxX2LcYx+WlJIIQjfNADL2/g651LbTPUOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTAGdYHxYhzuO2h3td5GPVkiWHiOjPsz00g8sqx282KD6nEOYFXqTJmU3+pLGl3mUim9o49koZGb28zyQf/mqGrDUBF9aAzepfg3z3PJwbNIi93JirSvKG3/oY/RHM4gjmRXAxVmMZIyBi0nbYBdw7cFnsUHxYMn2IgS9wiVc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdbmKi6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E8EC116B1
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246901;
	bh=HILxtH794LxX2LcYx+WlJIIQjfNADL2/g651LbTPUOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BdbmKi6tvVzFmjHbsVeVkLjsBZ9qDcSj9aG63FfB6EDuPc16FlGZXfduhRvzMr6DH
	 89izW2OnYO3FgchULt0G1ZVHo3AqhPv5nGEelG5LdtoKy0si9aOu9N2DNIPh8FMWrO
	 dzsJAx73MP2rJxZZoJnO8kwSW+4f9/rWRwVTN2L0nvnsdh6+XA72CVREhGyAbyK4a2
	 NHOMWgJOvxwGUrts1XUdHAbeQNIu6tw7LFDoIWmO8oYMf8uFXI9k73qsP3vcQr6c97
	 gsJqPuGKKjjkS2s2eif53grnF4znqa/UEvsCxHYtqmsKltw2EXsdatVN6s1RC8A3iV
	 JTEp67P1oNr2g==
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6352a77add0so5356619d50.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 08:41:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUesfmxL9retrWHaxiTJSB16GaNtAsERLovevc3+LWNWW2Vr1ZVZ+K8RFC0m+ezEfszg6TmKgXXdHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXe+iHQK/fX5zzxMcivZAtn6v5ITBornIZlHtjvApgIznIUK2w
	s/hPiW1J6hte2Gek5KSf+14NeFjjOBoFUrPhWNG56mxC0cRhAMNhEvaAo81eT2tJPb0SmXO9AI7
	UuWWXn/mAnBYNglzG4GXODY+LoA3ecuHXluoiyFmqug==
X-Google-Smtp-Source: AGHT+IHnEWysjUTlXzGqmjNk0BACH5wHQsyC/hdMpqw50UGr2zQD5Mmp3w6QC1LocfY4iWrCYlcFLiJbaQADAeNE4wM=
X-Received: by 2002:a05:690e:4298:10b0:637:eb5f:7425 with SMTP id
 956f58d0204a3-63b6fd8a203mr499756d50.0.1759246900278; Tue, 30 Sep 2025
 08:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com> <2025093030-shrewdly-defiant-1f3e@gregkh>
In-Reply-To: <2025093030-shrewdly-defiant-1f3e@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 30 Sep 2025 08:41:29 -0700
X-Gmail-Original-Message-ID: <CACePvbXrbR=A43UveqPrBmQHAfvjuJGtw9XyUQvpYe941KwzuA@mail.gmail.com>
X-Gm-Features: AS18NWAC4fHMXW0R7YRu79v-JcoJYTEAG3XCAfO8__KvhcCcqK-49zqgQNbiKuQ
Message-ID: <CACePvbXrbR=A43UveqPrBmQHAfvjuJGtw9XyUQvpYe941KwzuA@mail.gmail.com>
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

On Tue, Sep 30, 2025 at 6:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> > On Mon, Sep 29, 2025 at 10:10=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > On Mon, Sep 29, 2025 at 10:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.c=
a> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > > > > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > > > > prepare callback.
> > > > >
> > > > > After kexec, use driver_set_override() to ensure the device is
> > > > > bound only to the saved driver.
> > > >
> > > > This doesn't seem like a great idea, driver name should not be made
> > > > ABI.
> > >
> > > Let's break it down with baby steps.
> > >
> > > 1) Do you agree the liveupdated PCI device needs to bind to the exact
> > > same driver after kexec?
> > > To me that is a firm yes. If the driver binds to another driver, we
> > > can't expect the other driver will understand the original driver's
> > > saved state.
> >
> > Hi Chris,
> >
> > Driver name does not have to be an ABI.
>
> A driver name can NEVER be an abi, please don't do that.

Can you please clarify that.

for example, the pci has this sysfs control api:

"/sys/bus/pci/devices/0000:04:00.0/driver_override" which takes the
*driver name* as data to override what driver is allowed to bind to
this device.
Does this driver_override consider it as using the driver name as part
of the abi? If not, why?

What live update wants is to make that driver_override persistent over
kexec. It does not introduce the "driver_override" API. That is
pre-existing conditions. The PCI liveupdate just wants to use it.

I want to get some basic understanding before adventure into the more
complex solutions.

> > Drivers that support live
> > updates should provide a live update-specific ABI to detect
> > compatibility with the preserved data. We can use a preservation
> > schema GUID for this.
> >
> > > 2) Assume the 1) is yes from you. Are you just not happy that the
> > > kernel saves the driver name? You want user space to save it, is that
> > > it?
> > > How does it reference the driver after kexec otherwise?
> >
> > If we use GUID, drivers would advertise the GUIDs they support and we
> > would modify the core device-driver matching process to use this
> > information.
> >
> > Each driver that supports this mechanism would need to declare an
> > array of GUIDs it is compatible with. This would be a new field in its
> > struct pci_driver.
> >
> > static const guid_t my_driver_guids[] =3D {
> >     GUID_INIT(0x123e4567, ...), // Schema V1
> >     GUID_INIT(0x987a6543, ...), // Schema V2
> >     {},
> > };
>
> That's crazy, who is going to be adding all of that to all drivers?  And
> knowing to bump this if the internal data representaion changes?  And it
> will change underneath it without the driver even knowing?  This feels
> really really wrong, unless I'm missing something.

The GUID is more complex than a driver name. I am fine with not using
GUID if you are so strongly opposed to it.

You are saying don't do A(driver name) and B(GUID). I am waiting for
the part where you say "please do C instead".

Do you have any other suggestion how to prevent the live update PCI
device bind to a different driver after kexec? I am happy to work on
the direction you point out and turn that into a patch for the
discussion purpose.

Thanks

Chris

> > static struct pci_driver my_pci_driver =3D {
> >     .name       =3D "my_driver",
> >     .id_table   =3D my_pci_ids,
> >     .probe      =3D my_probe,
> >     .live_update_guids =3D my_driver_guids,
> > };
> >
> > The kernel's PCI core would perform an extra check before falling back
> > to the standard PCI ID matching.
> > 1. When a PCI device is discovered, the core first asks the Live
> > Update framework: "Is there a preserved GUID for this device?"
> > 2. If a GUID is found, the core will only attempt to bind drivers that
> > both match the device's PCI ID and have that specific GUID in their
> > live_update_guids list.
>
> What "core" is doing this?  And how exactly?
>
> And why is PCI somehow special here?
>
> > 3. If no GUID is preserved for the device, the core proceeds with the
> > normal matching logic
> > 4. If no driver matches the GUID, the device is left unbound. The
> > state gets removed during finish(), and the device is reset.
>
> How do you reset a device you are not bound to?  That feels ripe for
> causing problems (think multi-function devices...)
>
> And what about PCI drivers that are really just a aux-bus "root" point?
> How is the sharing of all of the child devices going to work?
>
> This feels really rough and might possibly work if you squint hard
> enough and test it in a very limited way with almost no real hardware :)
>
> good luck!
>
> greg k-h

