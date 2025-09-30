Return-Path: <linux-pci+bounces-37257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48092BAD170
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B0E3B2396
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743C425A326;
	Tue, 30 Sep 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S4An+vOC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CA2441B8;
	Tue, 30 Sep 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239704; cv=none; b=EgKRfq3TPFGTFpICFIcdCtvhr5a/+YnliVb2GhIuzcNWXaN/X7S4du2qg2TMuwph7wxdGVdBUysT2O/AGGG/UDZtmh5zYEZ3QKeg2pa2dLW/8xsPy8jQHTMp2LIhg/GFtnIpD6IkfOffmuFONL7HZeqxvQ7cHHIrdw0qX5VYEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239704; c=relaxed/simple;
	bh=8EzIsc5vh2LZNh+XJmFcPfCljx/czfi7mVYuIiXM7qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccR3J1aBt4QThPRyFZ2ehzyWwWFkH+scOWHJmOVfKJN+n70t1I8Kunav/3FE3qEx+5dfK2E6Qg/GnSkfms/+OGVmk2jBAUmsx0u8A+hfdcQ/JkiYM3P4JL224xC9UTF5oJsxwZ69hEY9mKez5njpmuKnH5rP0dwmYTXVOjBJiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S4An+vOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F25FC4CEF0;
	Tue, 30 Sep 2025 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759239703;
	bh=8EzIsc5vh2LZNh+XJmFcPfCljx/czfi7mVYuIiXM7qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4An+vOCQByBlE2r6eNH2dSXKnmU8qG4rmds7ze7nh1wnyLyYzR98QacHH4taEhqv
	 ArDeg4rbaVQTfW3k2VmcaLBQtcSgv4w+H+3PoK5GOZ3xvI/Wehx0vrh5qvrGEjAF16
	 CSatpq86/JB/mfkfeGx+8rVUhN/QwnN8E2c2l5V4=
Date: Tue, 30 Sep 2025 15:41:40 +0200
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
Message-ID: <2025093030-shrewdly-defiant-1f3e@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>

On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> On Mon, Sep 29, 2025 at 10:10 PM Chris Li <chrisl@kernel.org> wrote:
> >
> > On Mon, Sep 29, 2025 at 10:57 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > > > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > > > prepare callback.
> > > >
> > > > After kexec, use driver_set_override() to ensure the device is
> > > > bound only to the saved driver.
> > >
> > > This doesn't seem like a great idea, driver name should not be made
> > > ABI.
> >
> > Let's break it down with baby steps.
> >
> > 1) Do you agree the liveupdated PCI device needs to bind to the exact
> > same driver after kexec?
> > To me that is a firm yes. If the driver binds to another driver, we
> > can't expect the other driver will understand the original driver's
> > saved state.
> 
> Hi Chris,
> 
> Driver name does not have to be an ABI.

A driver name can NEVER be an abi, please don't do that.

> Drivers that support live
> updates should provide a live update-specific ABI to detect
> compatibility with the preserved data. We can use a preservation
> schema GUID for this.
> 
> > 2) Assume the 1) is yes from you. Are you just not happy that the
> > kernel saves the driver name? You want user space to save it, is that
> > it?
> > How does it reference the driver after kexec otherwise?
> 
> If we use GUID, drivers would advertise the GUIDs they support and we
> would modify the core device-driver matching process to use this
> information.
> 
> Each driver that supports this mechanism would need to declare an
> array of GUIDs it is compatible with. This would be a new field in its
> struct pci_driver.
> 
> static const guid_t my_driver_guids[] = {
>     GUID_INIT(0x123e4567, ...), // Schema V1
>     GUID_INIT(0x987a6543, ...), // Schema V2
>     {},
> };

That's crazy, who is going to be adding all of that to all drivers?  And
knowing to bump this if the internal data representaion changes?  And it
will change underneath it without the driver even knowing?  This feels
really really wrong, unless I'm missing something.

> static struct pci_driver my_pci_driver = {
>     .name       = "my_driver",
>     .id_table   = my_pci_ids,
>     .probe      = my_probe,
>     .live_update_guids = my_driver_guids,
> };
> 
> The kernel's PCI core would perform an extra check before falling back
> to the standard PCI ID matching.
> 1. When a PCI device is discovered, the core first asks the Live
> Update framework: "Is there a preserved GUID for this device?"
> 2. If a GUID is found, the core will only attempt to bind drivers that
> both match the device's PCI ID and have that specific GUID in their
> live_update_guids list.

What "core" is doing this?  And how exactly?

And why is PCI somehow special here?

> 3. If no GUID is preserved for the device, the core proceeds with the
> normal matching logic
> 4. If no driver matches the GUID, the device is left unbound. The
> state gets removed during finish(), and the device is reset.

How do you reset a device you are not bound to?  That feels ripe for
causing problems (think multi-function devices...)

And what about PCI drivers that are really just a aux-bus "root" point?
How is the sharing of all of the child devices going to work?

This feels really rough and might possibly work if you squint hard
enough and test it in a very limited way with almost no real hardware :)

good luck!

greg k-h

