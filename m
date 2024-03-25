Return-Path: <linux-pci+bounces-5129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445188B539
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 00:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7AB22977
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 21:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5DE6D1B9;
	Mon, 25 Mar 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7f4FnGU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371656D1B3
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402442; cv=none; b=LB5NQhdwAewhjom/GITDmNMtT2RpTe3nN8kFLFoWMUffI9D3H3VZbpwEdfDLevC3VAnJ1fWTR199RH2n4jPkLgrN+cvrbUuhGJ/E9znBX9FoEDD20qEaHsQXIB2MURmaWmVbYFmfCmxq7jocJAmHYLqWRXOTu7MtIf3W+FoWBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402442; c=relaxed/simple;
	bh=rriYC201J5WWCTYxZyMYstwQ9tKRJ9aWCdA+BwuBxss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zt6HDqwhVMwT3pgUr7SlipllNQDyAMZ83nGTTciHCKHxr1qOl/0oWzZGnFZ81gTr0xDGTUdqp6lr4wFUydmNWhhJ7xUnk246xZSUN10tyXsvJcpnm8HsUH0UQl5Cq/49azI24a0+UHnwMoEeZ9hwTVxhwphdz7JVMhC9vnZ+nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7f4FnGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D69AC433C7;
	Mon, 25 Mar 2024 21:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711402441;
	bh=rriYC201J5WWCTYxZyMYstwQ9tKRJ9aWCdA+BwuBxss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W7f4FnGUbt9RyefFi/Ncutoj1DWgqsA82p2EB7p5yXFQ01QgikLE+BUgvmoPvRD9c
	 dRmi2x/lVqdB7yw+MBxWKj1Ghj5TDZNeGtVcY74vLe6cdbAhA5u8nLIJLVLCHyP+ut
	 tS+tq2+o6XC24Akih5U5F5eBevwoOVlCytot/k87vlBszAQb+3VL+h1kzlUwBVViRH
	 loFICxhmHB9yTekcaaYtEJSJ5HNCjiBL0Xcoq1w4qipAdRe4b+k5pb1ZFZAJo657yr
	 JnwG98OfJsLZxqmd6XSw+TpWU7zOV3m1JMmqw5kEbaYh/qFuz+kJYgo1x56UkLicAw
	 7Voasq1lhalUQ==
Date: Mon, 25 Mar 2024 16:33:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-pci@vger.kernel.org
Subject: Re: does amd_iommu use INTx?
Message-ID: <20240325213359.GA1435356@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgEycC1c_d0RTPHW@8bytes.org>

On Mon, Mar 25, 2024 at 09:14:40AM +0100, Joerg Roedel wrote:
> On Fri, Mar 22, 2024 at 06:35:11PM -0500, Bjorn Helgaas wrote:
> > This is probably a stupid question, but does the AMD IOMMU itself ever
> > generate INTx interrupts, i.e., would it assert INTA, INTB, INTC,
> > INTD?
> 
> The AMD IOMMU hardware only signals IRQs via MSI, there is no hardware
> using INTx.

It seems that the IOMMU advertises 01h (INTA) in the Interrupt Pin
register, not 00h (doesn't use an interrupt pin).  Is that a hardware
defect, or do you mean the hardware is *capable* of using INTA, but
the Linux driver only uses MSI?

If the hardware truly can't use INTx at all, I wonder if we should add
a quirk to override that Interrupt Pin value so we don't bother with
any of the INTx routing stuff.

If INTA doesn't work, advertising it leads to lspci showing misleading
information and pointless searches of _PRT.

> > I'm hoping not, which would probably mean we could just ignore and
> > close bug reports about things like this:
> > 
> >   pci 0000:00:00.2: can't derive routing for PCI INT A
> 
> I hope this is fixed by a recent upstream commit:
> 
> commit 0feda94c868d396fac3b3cb14089d2d989a07c72
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Mon Jan 22 17:34:00 2024 -0600
> 
>     iommu/amd: Mark interrupt as managed

From https://bugzilla.kernel.org/show_bug.cgi?id=212261:

  00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
	  Interrupt: pin A routed to IRQ 25

  [    0.544306] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
  [    0.544643] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600
  [    0.567845] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
  [    0.567910] pci 0000:00:00.2: can't derive routing for PCI INT A
  [    0.567912] pci 0000:00:00.2: PCI INT A: not connected

I think 0feda94c868d will make the warnings go away, but I don't think
its commit log is quite right:

  According to the PCI spec [1] these routing entries
  are only required under PCI root bridges:
     The _PRT object is required under all PCI root bridges

  The IOMMU is directly connected to the root complex, so there is no
  parent bridge to look for a _PRT entry.

We look under the parent *root bridge*, not under a parent Root Port
or PCI-PCI bridge.  In this case there should be a _PRT under the PCI0
root bridge, and that's where we look for 00:00.2 INTx information.

I think if a device advertises an INTx pin, the _PRT *should* tell us
how it's routed.  If it doesn't, IMHO either the device is defective
(for advertising INTx that it doesn't use) or the firmware is
defective (not telling us via _PRT how it is routed).

Bjorn

