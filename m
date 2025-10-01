Return-Path: <linux-pci+bounces-37325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDBEBAF20E
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 07:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCDB4A0A14
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 05:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4642D837B;
	Wed,  1 Oct 2025 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aRRn3uRP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B01519AC;
	Wed,  1 Oct 2025 05:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759295599; cv=none; b=KHdbzsdVNm1H6hvTWDQ3BoCnI53uWXGJNKmRmbgMSjvT2nr9l5qTeqgF5lbrlCWjZws/qRUENqo6PxNclJG5zkFjIMzoJ7yBsiSqQbFUn5KDGHz7XyrfcphwwUMx/7UDGPkSjJDzenjcSC+JR8HHAP0GZxDGMr39HbwwDXJNl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759295599; c=relaxed/simple;
	bh=VvaiPspEseNBWmlTfnUJizAdnLXv1vNWDyVyfzYotQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVhLG+HLlkjORlD331ue3V/aqCxg8qac/ufi8kJ88vgELY1qyrjliEu1y4WzOqMrFNlJYs2TNU8dMSPvcPaoCLIr2baDaujw5crZtmWTtnkXJyWkQWVerxW0+c+Tsf8rCbNhgIzg1S0wzTVe6FBSUpeuKkSjbBpk9Ys5YQcmkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aRRn3uRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFFDC4CEF4;
	Wed,  1 Oct 2025 05:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759295598;
	bh=VvaiPspEseNBWmlTfnUJizAdnLXv1vNWDyVyfzYotQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRRn3uRPDYgG/iCHCmJLXOA28x2twSrKCJiIYE5ZR5wMQpi813k3W2sXJj2b39mJ5
	 iZEviHXdNys/+7umcTaaJf18ZmmZ9iiLvZrQGxrDUmf3nEVjBculp1HMZrKkeAyyNa
	 zMcS0tC8yy/CtWILDQ3nY5ZvTA7tCF7xkJK2DHdQ=
Date: Wed, 1 Oct 2025 07:13:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <2025100142-slick-deserving-4aed@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh>
 <CACePvbXrbR=A43UveqPrBmQHAfvjuJGtw9XyUQvpYe941KwzuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbXrbR=A43UveqPrBmQHAfvjuJGtw9XyUQvpYe941KwzuA@mail.gmail.com>

On Tue, Sep 30, 2025 at 08:41:29AM -0700, Chris Li wrote:
> On Tue, Sep 30, 2025 at 6:41 AM Greg Kroah-Hartman
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
> 
> Can you please clarify that.
> 
> for example, the pci has this sysfs control api:
> 
> "/sys/bus/pci/devices/0000:04:00.0/driver_override" which takes the
> *driver name* as data to override what driver is allowed to bind to
> this device.
> Does this driver_override consider it as using the driver name as part
> of the abi? If not, why?

Because the bind/unbind/override was created as a debug facility for
doing kernel development and then people have turned it into a "let's
operate our massive cloud systems with this fragile feature".

We have never said that driver names will remain the same across
releases, and they have changed over time.  Device ids have also moved
from one driver to another as well, making the "control" of the device
seem to have changed names.

> What live update wants is to make that driver_override persistent over
> kexec. It does not introduce the "driver_override" API. That is
> pre-existing conditions. The PCI liveupdate just wants to use it.

That does not mean that this is the correct api to use at all.  Again,
this was a debugging aid, to help with users who wanted to add a device
id to a driver without having to rebuild it.  Don't make it something
that it was never intended to be.

Why not just make a new api as you are doing something new here?  That
way you get to define it to work exactly the way you need?

> I want to get some basic understanding before adventure into the more
> complex solutions.

You mean "real" solutions :)

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
> > knowing to bump this if the internal data representaion changes?  And it
> > will change underneath it without the driver even knowing?  This feels
> > really really wrong, unless I'm missing something.
> 
> The GUID is more complex than a driver name. I am fine with not using
> GUID if you are so strongly opposed to it.
> 
> You are saying don't do A(driver name) and B(GUID). I am waiting for
> the part where you say "please do C instead".

It's not my requirement to say "here is C", but rather I am saying "B is
not going to scale over time as GUIDs are a pain to manage".

> Do you have any other suggestion how to prevent the live update PCI
> device bind to a different driver after kexec? I am happy to work on
> the direction you point out and turn that into a patch for the
> discussion purpose.

Why prevent it?  Why not just have a special api just for drivers that
want to use this new feature?

thanks,

greg k-h

