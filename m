Return-Path: <linux-pci+bounces-37476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E40BB57F0
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 23:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E560B3B3609
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3E1A9FB5;
	Thu,  2 Oct 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7NLE6GN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782A1E4AB
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441178; cv=none; b=n/BDXjsXZB5lNJeRBlnoj18pcESIHyaLKW+pO2bcgRZ2e4BZLJ8hsT5DFE3/VlFsa0Yd3VwEwqv/iUqE+zSv34PD2Ddrh9huvIs9dBC/j66bxXTuSCn1vftPwHA5OjSS97AaRYpkKouPQ6WeR0baDxn1nyKwq5Dh4/VOCojtSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441178; c=relaxed/simple;
	bh=ex6PQc0wXWx6TMj8K3rK3IDyeD8F4H6+MT/6qRBubA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFfzZDRHbfEOq+wvTvUpbBgRf3BBZ+lPVd2XsCjrz4ZiS53y9K7IgGBIu/GuXsriq5JIMeZ3459wIAp8E/HZwxkC64pk+mUIdFExwgjgeHVPCzEN7yqUyhmaNf6U5B4jQ34puKZsCcTuSddRxi3r1N7NfaWvIUQdIQlSMVcbEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7NLE6GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E073EC19422
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 21:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759441177;
	bh=ex6PQc0wXWx6TMj8K3rK3IDyeD8F4H6+MT/6qRBubA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F7NLE6GNmCOExbNx8AWWmFdszGKkDS79H9bRx09H223EZSVT08ADIIX+9LVhYbqZ8
	 2XrJeGmYsKZAQ31AMU7nLLJjBEjSwwadrZM+Wdch1ueYAMDo1vNevgz47xqQrNBmDQ
	 zbvHa1cySBAdhxpyer3SMq3S5NCWoDNBGg/ltfKg57Cydwt7I0pMwbgfuHMAV8+0uI
	 lrwISlqXch7UEEDnIAPfvEJIKfuw2EBlZ0X89wBSY9lJOHEQWoaUSCRmChpswnXIZf
	 GBQcSWYsTVtf/viNksBh1hoskOsy8xUkewUjTqjCJebkKjvPy3KsRtyl8rLAI4DCSL
	 X10YqQE/tcb2w==
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6089a139396so2052909d50.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsYWch5G4liyCFUqFdS480J9KwiNgUV9ASU1SBqWi1m35/cDMpKRvDXviuh3bonQx9r9lhuCRc9FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eXIUSLYhpGaxR6PuUskcLiEMQ3HDrCYo6L0gzxBEBQvWMLan
	4IW/yn5L7Ixno3TQ8L9aVYZ/4/CVgl/h4XJHEdkS6o9wTRUcG6hmcL71MmhLpmf8Tj7IhPD8tGf
	p39Q5TAjvqVWa4NxOhfD9PnbiANxdlOYg1/cmWP0Ojg==
X-Google-Smtp-Source: AGHT+IFqDarmQ9v4gLTtiLEN2s/MNB4zEb8TW4W8dJe+jN6E+wAqgXHnZfKnxjm153JlNRgMa66a/yo7cRXL6vFx6Wg=
X-Received: by 2002:a53:d8d1:0:b0:635:4ed0:571f with SMTP id
 956f58d0204a3-63b9965c422mr809130d50.23.1759441176979; Thu, 02 Oct 2025
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com> <20250930163732.GP2695987@ziepe.ca>
In-Reply-To: <20250930163732.GP2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 14:39:26 -0700
X-Gmail-Original-Message-ID: <CACePvbVXZ-rPmBi30eAO-2oF5K5hzQqQPo17M6hV7Pn4Dxrg9g@mail.gmail.com>
X-Gm-Features: AS18NWC4hZkC-DuL7JkglZ9HG1Kuo8rh0wtcRWye7eZGtmkdwbiQhcM2W2Wo-oE
Message-ID: <CACePvbVXZ-rPmBi30eAO-2oF5K5hzQqQPo17M6hV7Pn4Dxrg9g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:37=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> As I said, I would punt all of this to the initrd and let the initrd
> explicitly bind drivers.

You still need a mechanism to prevent after the PCI bridge scan,
create the pci_devices, not auto probe the drivers. If it is not
driver_override, it will be some new PCI API and liveupdate is the
first user of it.

I was afraid to add a new liveupdate specific PCI API for this
purpose. However, if that is what upstream wants, I can certainly do
it in the next version.

> The only behavior we need from the kernel is to not autobind some
> drivers so userspace can control it, and in a LUO type environment
> userspace should well know what drivers go where - or can get it from
> a preceeding kernel from a memfd.

There are two slightly different things here:
1) modprobe the driver. That is typically control by udev.
2) auto probing the drive after the driver has been loaded or PCI
device scanned.

In your envisioning, the initrd autobind controls both of the above
two spec of things, right?

Chris

