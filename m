Return-Path: <linux-pci+bounces-32757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15246B0E513
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 22:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51497581157
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7DF221734;
	Tue, 22 Jul 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO6hZyB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A0A95C;
	Tue, 22 Jul 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217226; cv=none; b=TnUfT2hvqFzCqxkE20RiIxxnEvIUkfGmY8oEis7/U9WsDKrM+wXltcp4rcQhPJxY8FK0Q/Pp9lErnnnDKOJufconpBu/R6qCTqfYxYwL6RM4ZImkoCYLe/pGpoMbhbRVI5uGY7xSJQ+uHdh4DOKKiKxx+1DaaDl7AF2xY/L7vfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217226; c=relaxed/simple;
	bh=/sxFwYUyBdxHVgbNyek2wBg4Uk82NRyFiZxIzDBnIs4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aiqVHXdb+2n0RDDJXm1fU1Vfv41qSfV0eq3BQra2pn8ek1K+LyKFBdpiCzFLFwKB3yd/dsb5krT+AVa6lAzFFiygCI6SwZUXtGMItA8nGh2xsuO+UIDgdgPRW3tQWOr9ipU3H71M9NvlJ7VEwRS0nt3kWafwNJHFTAzYpvNpEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO6hZyB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88561C4CEEB;
	Tue, 22 Jul 2025 20:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753217225;
	bh=/sxFwYUyBdxHVgbNyek2wBg4Uk82NRyFiZxIzDBnIs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aO6hZyB7vN81Un5hba7wW6Ql7I5ci2Z6++fnxK1N+B6uWOg2jTwNX1Uau7rZiYT5e
	 AOcAgtWIFwH7Nz7plV0qxsFzT9sOlR4vz4FaTVau6e1tcQhlZgVhsEYur1Ddxb+2Up
	 i0uRqXQuq1y15hjJ7pQ+4offCfJ6eK6OlyzR/DZUiWo8J7wg9hheEgm24Fvt04kTFu
	 PoAVyzmb6Z4Ue4KyFxdq1k++Fo6uJE4HtCM1XFxyQCWhRClM2tMgz1jJyaSZFAWw32
	 mzbgFKQFD7LWON8AQD9BqQg+KisPWLzKmseMc4c8E+743oZjhhTP8RmpEU/MMmhORD
	 KezzqnP4+4FDg==
Date: Tue, 22 Jul 2025 15:47:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v3 0/6] PowerNV PCIe Hotplug Driver Fixes
Message-ID: <20250722204704.GA2815491@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717232752.GA2662535@bhelgaas>

[-> to: Madhavan, Michael, Mahesh; seeking acks]

On Thu, Jul 17, 2025 at 06:27:52PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 15, 2025 at 04:31:49PM -0500, Timothy Pearson wrote:
> > Hello all,
> > 
> > This series includes several fixes for bugs in the PowerNV PCIe hotplug
> > driver that were discovered in testing with a Microsemi Switchtec PM8533
> > PFX 48xG3 PCIe switch on a PowerNV system, as well as one workaround for
> > PCIe switches that don't correctly implement slot presence detection
> > such as the aforementioned one. Without the workaround, the switch works
> > and downstream devices can be hot-unplugged, but the devices never come
> > back online after being plugged in again until the system is rebooted.
> > Other hotplug drivers (like pciehp_hpc) use a similar workaround.
> > 
> > Also included are fixes for the EEH driver to make it hotplug safe,
> > and a small patch to enable all three attention indicator states per
> > the PCIe specification.
> > 
> > Thanks,
> > 
> > Shawn Anastasio (2):
> >   PCI: pnv_php: Properly clean up allocated IRQs on unplug
> >   PCI: pnv_php: Work around switches with broken presence detection
> > 
> > Timothy Pearson (4):
> >   powerpc/eeh: Export eeh_unfreeze_pe()
> >   powerpc/eeh: Make EEH driver device hotplug safe
> >   PCI: pnv_php: Fix surprise plug detection and recovery
> >   PCI: pnv_php: Enable third attention indicator state
> > 
> >  arch/powerpc/kernel/eeh.c         |   1 +
> >  arch/powerpc/kernel/eeh_driver.c  |  48 ++++--
> >  arch/powerpc/kernel/eeh_pe.c      |  10 +-
> >  arch/powerpc/kernel/pci-hotplug.c |   3 +
> >  drivers/pci/hotplug/pnv_php.c     | 244 +++++++++++++++++++++++++++---
> >  5 files changed, 263 insertions(+), 43 deletions(-)
> 
> I'm OK with this from a PCI perspective, and I optimistically put it
> on pci/hotplug.
> 
> I'm happy to merge via the PCI tree, but would need acks from the
> powerpc folks for the arch/powerpc parts.
> 
> Alternatively it could be merged via powerpc with my ack on the
> drivers/pci patches:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> If you do merge via powerpc, I made some comment formatting and commit
> log tweaks that I would like reflected in the drivers/pci part.  These
> are on
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=hotplug

Powerpc folks: let me know how you want to handle this.  I haven't
included it in pci/next yet because I don't have acks for the
arch/powerpc parts.

Bjorn

