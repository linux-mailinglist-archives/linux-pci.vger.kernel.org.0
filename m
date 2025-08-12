Return-Path: <linux-pci+bounces-33879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FB8B2366E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60CF94E4D40
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4C2C21E0;
	Tue, 12 Aug 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVWOGhNy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255C260583;
	Tue, 12 Aug 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025238; cv=none; b=VXgNgowzI3egzTgOgIwW7nc4/gEXlj8i3Zw7xw0TUqDjAvIzg8jALcCn12F3XXZXeODFCZIGJxeof8elQgR2zD0DDVZT26xuVXBJ5tSc1rdQFfyMBkkeg0U0kbFDG1euFqUwQfmWj0/qM3ruUTQ7MQBfS18cCKEuQeHu/Hygw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025238; c=relaxed/simple;
	bh=d0JhCkkZyd2LY7+XqnhS+Q79Efyg7IxxniIo3QR/Suw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z/AZE5xPRDG8bUjpYtyfUpMW3cUgjHb84QhNsGZ3htpL2KGTozaOeM97g1PI5LGWez7pIEUHSebHUvdwKMOKjYUT/wHiNOMhrHZrGYsJ/0cimTKJq3me3Cc5abWcTbKyINE2HNVW+roLom4tf5Z+wo+RqDQT/egDv1Pr+kR62J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVWOGhNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5583AC4CEF0;
	Tue, 12 Aug 2025 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755025238;
	bh=d0JhCkkZyd2LY7+XqnhS+Q79Efyg7IxxniIo3QR/Suw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nVWOGhNybWSj0nPCPYVbra069XOzf10WpEJyHEUbxfnL0uzmlKWGLtDtCdEUxSCfY
	 xEBl73Eq+yz/Tc0o5m2EHHAEcmmQrRySFf2zJ3IPwU0EwjINxQ2zN+5CXJS0lwUebR
	 LwWyEsjYIzasdOn3aAgIEVt9T0SyEuPuBOP/vU6Pz7H/avKxSGcgoWrPDyDTku2uRX
	 sUmdRWQWuWJ9k5kFzclN2zOPRvcD1VImRtI4oY2+GkUpU+VzhbmG4UGacqfuRxqZlu
	 3q1ws8pzYKz8Sx+SG9/+KMbmoE2WnWY+ZlRanaUStCEhNbBarClpQ+Aq7AWpSzO9Hr
	 thzylI8hYYQhA==
Date: Tue, 12 Aug 2025 14:00:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <20250812190036.GA199875@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812182209.c31roKpC@linutronix.de>

On Tue, Aug 12, 2025 at 08:22:09PM +0200, Nam Cao wrote:
> On Tue, Aug 12, 2025 at 11:30:15AM -0500, Bjorn Helgaas wrote:
> > On Tue, Aug 12, 2025 at 08:49:50AM -0600, Keith Busch wrote:
> > > The doc you linked is riddled with errors. The original vmd commit
> > > message is more accurate: VMD domains support child devices with MSI and
> > > MSI-x interrupts. The VMD device can't even tell the difference which
> > > one the device is using. It just manipulates messages sent to the usual
> > > APIC address 0xfeeXXXXX.
> > 
> > Thanks, Keith!  I updated the commit log like this:
> > 
> >   d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()") added a
> >   WARN_ON sanity check that child devices support MSI-X, because VMD document
> >   says [1]:
> > 
> >     Intel VMD only supports MSIx Interrupts from child devices and therefore
> >     the BIOS must enable PCIe Hot Plug and MSIx interrups [sic].
> > 
> >   However, the VMD device can't even tell the difference between a child
> >   device using MSI and one using MSI-X.  Per 185a383ada2e ("x86/PCI: Add
> >   driver for Intel Volume Management Device (VMD)"), VMD does not support
> >   INTx interrupts, but does support child devices using either MSI or MSI-X.
> > 
> >   Remove the sanity check to avoid the unnecessary WARN_ON reported by Ammar.
> 
> Minor correction, it is not just an unnecessary WARN_ON, but child devices'
> drivers couldn't enable MSI at all.
> 
> So perhaps something like "Remove the sanity check to allow child devices
> which only support MSI".

Thanks, updated.

