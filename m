Return-Path: <linux-pci+bounces-37241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A16BAAF5A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 04:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0197A200C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 02:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDA91A5B84;
	Tue, 30 Sep 2025 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWtRMdox"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BAD35949
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198444; cv=none; b=YFHQfELgGVbG3+UGScWmdWBGIGdPs8tO4fe8iiXmBZAl2ZiOluq6ZGiZOUPdzO4Ci6tQ66B8ALgj/Fxo4aoo35ZXJ1vMa5ODzLBShBKvkrAM2yMxnmHbgmZVqJWirspI757Odwtim9Va+0Fztd6d8vk6Y0JKm8WGDEKB5mCJeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198444; c=relaxed/simple;
	bh=sgFwoYwv5aVSI/enTT58DazkhkLHGDpwlsYZbTap8gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh7NOsbZ9RIaYctbYXOfzy/AP5oRPK3fmPXaRu0HMMVdPfwjW+x6GocbWA9iYXBWdK+UuDMKAjlKHZJ/cIw4LawX0VmMMvqqbXUf/hXDnRuRgeIF43ZiCZOVSEn0gc8rmJZ5oiYoAfFxP+1ZAesomXU+aL579CgkC4/zkEvCp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWtRMdox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0ECC116C6
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 02:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759198444;
	bh=sgFwoYwv5aVSI/enTT58DazkhkLHGDpwlsYZbTap8gM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JWtRMdoxAd24Vd6gTwciLF+JF/3YFetRuZ/0qe9YC6Mc4Fp1mGKszCTlsuqxPqFnp
	 2fZLowEhzEGKhZUA+tdSa/WzNcaZ3DrGq3r2VQVi1ZkxnOSkKDk2i5e2gqWxIdmEys
	 AGUpJQxvcJtZxsIsCZkOFo2+4TqbWHAjcc9iwCGuPQwn6/BJGr4/q2sQUCYS4gLCmg
	 967ft4o0dm0hP9Mowsxe5z8mJvOfZiLXm3+r9jeUtEK+FAKB7YH2imeIHOb31Wcmfw
	 NdfYj/8YY116DzDS2oP7NYp2UkzhMb3RxA5aO85N32trhK9nCLFM4YbLCwzXEGjs2q
	 /CwMor2D3c5aw==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e3f213b59so35055e9.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 19:14:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxtvcrv+2WpbsaW0ZAKUaU9NFqat+fKCPyGUCpYQJhb2IwXtOznigbDhiktd6CAuA/f63fwOnUXwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVMW7py7hgwqBViMlp/9B+bpCGMu+JbXw2z0ELpBg3RB4mjrM
	tRnuF/aZyn4OKLRwJIBc6HGUehfGfSo87Z7heyWQn9IRQzxkYBwnW3QgI7+NsdTrSR4c30HffZZ
	7G7EIajpsa8xTIpRcsrSz6W2/I4RYo27OmghtHKkD
X-Google-Smtp-Source: AGHT+IG0hyI8CrBWxt4uG2S95BXydjZ1JZnknUID2lYAGfJoaGhfXiIb/KrySMIsrbUotODmIOhc6I1MLzwo30uw2eQ=
X-Received: by 2002:a05:600c:8906:b0:45b:74f7:9d30 with SMTP id
 5b1f17b1804b1-46e5ab15b96mr532365e9.1.1759198442704; Mon, 29 Sep 2025
 19:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org> <20250929174627.GI2695987@ziepe.ca>
In-Reply-To: <20250929174627.GI2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 29 Sep 2025 19:13:51 -0700
X-Gmail-Original-Message-ID: <CAF8kJuN2-Y7YZkY5PrerK=AdTUfsaX0140-yJJSTnNORucYfqQ@mail.gmail.com>
X-Gm-Features: AS18NWBgs7r7MLPH6Qz070zJ6W4iKaMalztL0g4aJARcfQWjXj7GPq_GPukoM14
Message-ID: <CAF8kJuN2-Y7YZkY5PrerK=AdTUfsaX0140-yJJSTnNORucYfqQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Sep 16, 2025 at 12:45:10AM -0700, Chris Li wrote:
> >  static int pci_liveupdate_prepare(void *arg, u64 *data)
> >  {
> > +     LIST_HEAD(requested_devices);
> > +
> >       pr_info("prepare data[%llx]\n", *data);
> > +
> > +     pci_lock_rescan_remove();
> > +     down_write(&pci_bus_sem);
> > +
> > +     build_liveupdate_devices(&requested_devices);
> > +     cleanup_liveupdate_devices(&requested_devices);
> > +
> > +     up_write(&pci_bus_sem);
> > +     pci_unlock_rescan_remove();
> >       return 0;
> >  }
>
> This doesn't seem conceptually right, PCI should not be preserving
> everything. Only devices and their related hierarchy that are opted
> into live update by iommufd should be preserved.

Can you elaborate? This is not preserving everything, for repserveding
bus master, only the device and the parent PCI bridge are added to the
requested_devies list. That is done in the
build_liveupdate_devices(), the device is added to the listhead pass
into the function. So it matches the "their related hierarchy" part.
Can you explain what unnecessary device was preserved in this?

It is not using iommufd, just the dev->lu.flags flags, the flags are
set when VFIO adds a device to VM. Here the PCI LU test driver just
adds the flag in the probe function to simulate that VFIO ioctl.

Iommufd is a separate series, not this one.

Chris


Chris

