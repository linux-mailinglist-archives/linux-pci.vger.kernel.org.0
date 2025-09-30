Return-Path: <linux-pci+bounces-37264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962EBADE59
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DCCC4E1BCC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0B723A562;
	Tue, 30 Sep 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QNuYAsAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E98FBF6;
	Tue, 30 Sep 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246245; cv=none; b=jtqLB5b0p7TbzxQKLxlCkBrhZ6n6qPBQB5VglK6uovQW4ITqrauVDGwzWt2kfNAMlTaXgGCVLwOMAIgBKTJlkvJKF0O9I+S8UTJg1WOG0j2LOoiCM7rvqRUM/94Im2UZob/CEy15UurXbHFJkk8gW4iSEhBKOY55mJCqUtHI8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246245; c=relaxed/simple;
	bh=A9R2TyQIO4GxIihckYzb4VIyZgxkBqYddQJmUyHABaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP063NWuV0cx8FJQ7MCUWAzlQ7mylmA+zEe9blK3QEv8rGnGnsGW96s7VBAq1mJSF81SkjRUkGj4ljVEtaxsIfHWYtQm4dTaaBJr4GTgJkkaokvEA0cDKdMjBVKJyYK+O9rPQ/3mPBY/XJAVNGBHiRFlRVOeaTlzv3k39e1Uyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QNuYAsAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408BC4CEF0;
	Tue, 30 Sep 2025 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759246245;
	bh=A9R2TyQIO4GxIihckYzb4VIyZgxkBqYddQJmUyHABaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNuYAsAU7VjX/BXD2hf8k5eJDOKTw+Ss9A7S5FcnqOprLXfQQq4L3me1uLc0EfUUZ
	 jqABN3XAaCJ3zL6xhzFebkEU6DE7ATuhKiq7heCrT0f1fcUOgzfxY5EGeP+kE3up7W
	 wysVBoS21q0SB7JJpJoHAOVVKKe5HSL8svdpsRgU=
Date: Tue, 30 Sep 2025 17:08:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Chris Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <2025093052-resupply-unmixable-e9bb@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh>
 <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>

On Tue, Sep 30, 2025 at 10:53:50AM -0400, Pasha Tatashin wrote:
> On Tue, Sep 30, 2025 at 9:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> > > On Mon, Sep 29, 2025 at 10:10 PM Chris Li <chrisl@kernel.org> wrote:
> > > >
> > > > On Mon, Sep 29, 2025 at 10:57 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > > > > > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > > > > > prepare callback.
> > > > > >
> > > > > > After kexec, use driver_set_override() to ensure the device is
> > > > > > bound only to the saved driver.
> > > > >
> > > > > This doesn't seem like a great idea, driver name should not be made
> > > > > ABI.
> > > >
> > > > Let's break it down with baby steps.
> > > >
> > > > 1) Do you agree the liveupdated PCI device needs to bind to the exact
> > > > same driver after kexec?
> > > > To me that is a firm yes. If the driver binds to another driver, we
> > > > can't expect the other driver will understand the original driver's
> > > > saved state.
> > >
> > > Hi Chris,
> > >
> > > Driver name does not have to be an ABI.
> >
> > A driver name can NEVER be an abi, please don't do that.
> >
> > > Drivers that support live
> > > updates should provide a live update-specific ABI to detect
> > > compatibility with the preserved data. We can use a preservation
> > > schema GUID for this.
> > >
> > > > 2) Assume the 1) is yes from you. Are you just not happy that the
> > > > kernel saves the driver name? You want user space to save it, is that
> > > > it?
> > > > How does it reference the driver after kexec otherwise?
> > >
> > > If we use GUID, drivers would advertise the GUIDs they support and we
> > > would modify the core device-driver matching process to use this
> > > information.
> > >
> > > Each driver that supports this mechanism would need to declare an
> > > array of GUIDs it is compatible with. This would be a new field in its
> > > struct pci_driver.
> > >
> > > static const guid_t my_driver_guids[] = {
> > >     GUID_INIT(0x123e4567, ...), // Schema V1
> > >     GUID_INIT(0x987a6543, ...), // Schema V2
> > >     {},
> > > };
> >
> > That's crazy, who is going to be adding all of that to all drivers?  And
> 
> Only to the drivers that support live updates, that would be just a few drivers.
> 
> > knowing to bump this if the internal data representaion changes?  And it
> > will change underneath it without the driver even knowing?  This feels
> > really really wrong, unless I'm missing something.
> 
> A driver that preserves state across a reboot already has an implicit
> contract with its future self about that data's format. The GUID
> simply makes that contract explicit and machine-checkable. It does not
> have to be GUID, but nevertheless there has to be a specific contract.

So how are you going to "version" these GUID?  I see you use "schema Vx"
above, but how is that really going to work in the end?  Lots of data
structures change underneath the base driver that it knows nothing
about, not to mention basic things like compiler flags and the like
(think about how we have changed things for spectre issues over the
years...)

And when can you delete an old "schema"?  This feels like you are
forcing future developers to maintain things "for forever"...

thanks,

greg k-h

