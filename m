Return-Path: <linux-pci+bounces-24384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B424EA6C189
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372821B60FDA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174AF225A20;
	Fri, 21 Mar 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiH6bQ96"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7A2C181
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578221; cv=none; b=r4q3KbkGzrXC+cwzx7uCY8cLKoAfGmi9n1Vn0T34IEe/k2jpCuKO+Fl9vQNs/1UdPgVgVZXwkZ36DnudC9d8Ip+KWI4K/UUJ5kyFVAnooq1qB1UjuYFTwEHOi3/KtOEp92p4txT4hrkzcwMcIQkHsgHD6viRSfD2gUb9lRsehTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578221; c=relaxed/simple;
	bh=5kz/SWmhLdDFQ0oAMG7K0uRHHyfYdnhFiKTNxk1wYak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dpP2IuiU3XbyL2k9/DiFLE925IbODR1ThWjY0ncnGPHtKjpWbiGwvGeT98ZKVAnStLqTn8g/GTeHbG+r/zVtNPwwjWPg/Xd81CEoklwD1ylDELllBHgVQVSctCEYzF3aXRe9DjogL2zOV3K60fmDU3UyYAS6FIYl1qFvwYJFiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiH6bQ96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3693C4CEE3;
	Fri, 21 Mar 2025 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578220;
	bh=5kz/SWmhLdDFQ0oAMG7K0uRHHyfYdnhFiKTNxk1wYak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tiH6bQ96E17ImjQfiTgGuz13qIebqTBZ2Zy+qRfbFjZj9fG5ZWJFzNJL/LsKbH3yT
	 7sgNqsnRVhSOhrapUry8bGai7FRGBGHu5XFTBnpnar4erNM+vlY9EQUcyVVvaT1WKQ
	 v96/kLfHI1CiIq/8TWoEFPZc5+iTZ0mFru6Isn7vj1F+Ai34bcQOUJEvabDhEhh8k0
	 6g7/5s0SSpXYY/ahtvwlDRof+qrsz433GrbxBNIIgXkPbx30A9qvgiuBoPynyx7f5J
	 3KwayZ3fkHZVOPsFjZk6x7SC7RbMTjZnOOVZ/F5xh2Me4T6ncgzqQZrFlKEbHwy9s3
	 Uyjsnw76e1MvQ==
Date: Fri, 21 Mar 2025 12:30:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Query Regarding PCI Configuration Space Mapping and BAR
 Programming
Message-ID: <20250321173019.GA1133365@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+j5TMvoxsSQsgsLcuYqjwjS5Hu_6KXtJigWD-noQTeE9Q@mail.gmail.com>

On Fri, Mar 21, 2025 at 04:38:09PM +0530, Muni Sekhar wrote:
> On Thu, Mar 20, 2025 at 12:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Mar 19, 2025 at 11:27:07PM +0530, Muni Sekhar wrote:
> > > Dear Linux-PCI Maintainers,
> > >
> > > I have a few questions regarding PCI configuration space and Base
> > > Address Register (BAR) programming:
> > >
> > > PCI Configuration Space Mapping:
> > > PCI devices have standard registers (Device ID, Vendor ID, Status,
> > > Command, etc.) in their configuration space.
> > > These registers are mapped to memory locations.
> >
> > In general, config registers are not mapped to memory locations.
> >
> > Some systems use the ECAM mechanism for config access, which is
> > basically memory-mapped I/O that converts CPU memory accesses to PCI
> > config accesses.  This mechanism is hidden inside the Linux config
> > accessors (pci_read_config_word(), etc), and drivers should not use
> > ECAM directly.
> 
> Both pci_bus_read_config_word() and pci_user_read_config_word() eventually call:
> res = bus->ops->read(bus, devfn, pos, len, &data);
> ret = dev->bus->ops->read(dev->bus, dev->devfn, pos, sizeof(type), &data);
> 
> This suggests that both kernel-space (pci_read_config_*()) and
> user-space (pci_user_read_config_*()) accessors use the same
> underlying function for configuration space access.
> Could you confirm if my understanding is correct?

That's correct.

> I tried locating the implementation of bus->ops->read() but could not
> find its definition in the kernel source.Even using the function_graph
> tracer, I was unable to capture the exact function being executed.
> Could you point me to where this function is defined in the kernel?

Each struct pci_bus has a "struct pci_ops *ops" pointer.  The struct
pci_ops supplies config accessors.  These are platform-dependent or
host bridge-dependent.

For x86, it's typically pci_root_ops:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/pci/common.c?id=v6.13#n72

> > > How can we determine
> > > the exact memory location where these configuration space registers
> > > are mapped?
> >
> > Drivers use pci_read_config_word() and similar interfaces to access
> > config registers.  Userspace can use the setpci utility.
> >
> > > Base Address Registers (BARs) Programming:
> > > How are BAR registers programmed, and what ensures they do not
> > > conflict with other devices mapped memory in the system?
> > > If a BAR mapping clashes with another device’s memory range, how does
> > > the system handle this?
> > >
> > > Does the BIOS/firmware allocate BAR addresses, or does the OS have a
> > > role in reconfiguring them during device initialization?
> >
> > On x86 systems, the BIOS generally assigns BAR addresses.  Linux
> > doesn't change these unless they are invalid.  Some firmware does not
> > assign BARs, and generally firmware does not assign BARs for hot-added
> > devices.  In those cases, Linux assigns them.
>
> Once a hotplug event is detected (either via a PCIe hotplug interrupt
> or an ACPI event), which kernel function is responsible for
> dynamically assigning the Bus, Device, and Function (BDF) number to
> the new device?

The kernel doesn't assign the BDF.  The bus number is the bus on which
the new device lives.  This is determined by the PCI host bridge and
any bridges in the path to the device.  The PCI bus number below a
host bridge is determined by firmware or a native host bridge driver.

The bus numbers below other bridges are configured either by firmware
or by the Linux core setting the bridge secondary bus number.  This is
mostly in pci_scan_child_bus_extend().

The device and function numbers are basically a function of the
hardware device.

> Additionally, which function in the kernel assigns Base Address
> Registers (BARs) for the hotplugged device?

Start in pciehp_configure_device(), which calls
pci_assign_unassigned_bridge_resources():

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/hotplug/pciehp_pci.c?id=v6.13#n32

