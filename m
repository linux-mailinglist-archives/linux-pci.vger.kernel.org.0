Return-Path: <linux-pci+bounces-15249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5A9AF4D1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 23:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8380E282F0C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 21:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992792010E5;
	Thu, 24 Oct 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqs6KHxw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707D20CCF9;
	Thu, 24 Oct 2024 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806475; cv=none; b=VW9le635j3eu4AKzGpxU9/Jo4Ciswfr/IlAAqJzEIPamrfnRbJlP0SAa/VuFiH17OqMvcCHu6EcT8hd58JvR0BWf2M9N0CsgEJvR+Zn7QQC1p9sgQQWfIYd6FZbq6f0q/HleKDXVdyMb7xiz4FIKMwSKbfagFBMQxfhj7X0ikmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806475; c=relaxed/simple;
	bh=hPDnop8lHMn8XH2CX7LLI3sQbn57tFmmwkFyeyycoao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lIryKdU5qBuKn0f6aAHD7HmdVNwFnM71PwhFcUNdBjJZmHscL78AL4q5J4AmcEwC4nuH+kQGivh0W9VPy7UD0v/sESSa0/J5JSG392OaQ58UmN/6U+6LKxrVDrCXv85FIdNhkhBzBcQ7qfUM+FuGJIjuHhrDoeUeKIZ0vMsx4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqs6KHxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A064DC4CEC7;
	Thu, 24 Oct 2024 21:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729806474;
	bh=hPDnop8lHMn8XH2CX7LLI3sQbn57tFmmwkFyeyycoao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aqs6KHxwvjYXjC/D4fGmGr+EnD7z1U1QdeUsPo88VjhCSmkBXTqB7UEwU8sLaLqmb
	 GPo/v0YKn5sLPP3SaA5UkIgj+/9ZD3Gd6XQvdbzvY14aECH/E4iWp4FXY+SqDeIS4V
	 rO5nFU0USMaeOMovkX7z0tHVVt3hhEykYEuV1xENIu/EGVPA3lcHG9UGErQ3Pn2aEe
	 gbgT4CFNWKGdDRzCM6rlMxDnMp8duDHTLsS8I/PO/B7OpzGiTEDVbL4AppXOklz7RR
	 JT0UFJfnrfA38ZnMBipLOCYjZRV8i5ZJbE/pD9SR7ej8qOzSZYf8yT8VMm4kFWhY+f
	 r8npU6e9nPNBg==
Date: Thu, 24 Oct 2024 16:47:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 00/16] AMD NB and SMN rework
Message-ID: <20241024214753.GA1005373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0018d26a-ffd5-42fc-8cc4-9e689834a808@amd.com>

On Thu, Oct 24, 2024 at 04:20:35PM -0500, Mario Limonciello wrote:
> On 10/24/2024 16:06, Bjorn Helgaas wrote:
> > On Thu, Oct 24, 2024 at 03:08:41PM -0500, Mario Limonciello wrote:
> > > On 10/24/2024 12:46, Bjorn Helgaas wrote:
> > > > On Thu, Oct 24, 2024 at 12:01:59PM -0400, Yazen Ghannam wrote:
> > > > > On Wed, Oct 23, 2024 at 12:59:28PM -0500, Bjorn Helgaas wrote:
> > > > > > On Wed, Oct 23, 2024 at 05:21:34PM +0000, Yazen Ghannam wrote:
> > > ...
> > 
> > > > > > The use of pci_get_slot() and pci_get_domain_bus_and_slot() is not
> > > > > > ideal since all those pci_get_*() interfaces are kind of ugly in my
> > > > > > opinion, and using them means we have to encode topology details in
> > > > > > the kernel.  But this still seems like a big improvement.
> > > > > 
> > > > > Thanks for the feedback. Hopefully, we'll come to some improved
> > > > > solution. :)
> > > > > 
> > > > > Can you please elaborate on your concern? Is it about saying "thing X is
> > > > > always at SBDF A:B:C.D" or something else?
> > > > 
> > > > "Thing X is always at SBDF A:B:C.D" is one big reason.  "A:B:C.D" says
> > > > nothing about the actual functionality of the device.  A PCI
> > > > Vendor/Device ID or a PNP ID identifies the device programming model
> > > > independent of its geographical location.  Inferring the functionality
> > > > and programming model from the location is a maintenance issue because
> > > > hardware may change the address.
> > > > 
> > > > PCI bus numbers are under software control, so in general it's not
> > > > safe to rely on them, although in this case these devices are probably
> > > > on root buses where the bus number is either fixed or determined by
> > > > BIOS configuration of the host bridge.
> > > > 
> > > > I don't like the pci_get_*() functions because they break the driver
> > > > model.  The usual .probe() model binds a device to a driver, which
> > > > essentially means the driver owns the device and its resources, and
> > > > the driver and doesn't have to worry about other code interfering.
> > > 
> > > Are you suggesting that perhaps we should be introducing amd_smn (patch 10)
> > > as a PCI driver that binds "to the root device" instead?
> > 
> > I don't know any of the specifics, so I can't really opine on that.
> > 
> > The PCI specs envision that a Vendor/Device ID defines the programming
> > model of the device, and you would only use a new Device ID when that
> > programming model changes.
> > 
> > Of course, vendors like to define a new set of Device IDs for every
> > new chipset even when no driver changes are required, so even if a new
> > SMN works exactly the same as in previous chipsets, you're probably
> > back to having to add a new Device ID for every new chipset.
> 
> Yeah; this I believe is why we're here today and trying to find something
> more manageable (IE this series).

Another alternative would be an ACPI device where you can use the same
_HID (or at least a _CID) for all the chipsets.

> > The Subsystem Vendor ID and Subsystem ID exist to solve a similar
> > problem (sort of in reverse).  If AMD could allocate a Subsystem ID
> > for this SMN programming model and use that same ID in every chipset,
> > you could make a pci_driver.id_table entry that would match them all,
> > e.g.,
> > 
> >    .vendor = PCI_VENDOR_ID_AMD,
> >    .device = PCI_ANY_ID,
> >    .subvendor = PCI_VENDOR_ID_AMD,
> >    .subdevice = PCI_SUBSYSTEM_AMD_SMN,
> > 
> > (pci_device_id.subdevice is misnamed; the spec calls it "Subsystem ID")
> 
> Isn't the subsystem ID based typically upon the platform it's
> running on?  For example I seem to recall on Dell systems it's used
> the value that was in the SBMIOS ProductSKU field here (IoW not
> something AMD would control).

Right, it is typically based on the platform; that's why I said "in
reverse."  I think all these devices are integrated into the chipset,
so I'm speculating that platform vendors would have no need (maybe
even no way) to use the Subsystem ID.  But maybe that's not the case.

> I mean I guess maybe we could do a:
> 
>     .vendor = PCI_VENDOR_ID_AMD,
>     .device = PCI_ANY_ID,
>     .class = PCI_CLASS_BRIDGE_HOST << 8
> 
> And then in probe() figure out if it's the right one, but that's still
> pretty ugly, eh?

I think there are some drivers that do this, and it's not completely
terrible.  The probe() can just return failure if it doesn't want the
device.

Bjorn

