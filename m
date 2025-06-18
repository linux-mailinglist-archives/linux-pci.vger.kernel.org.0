Return-Path: <linux-pci+bounces-30005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA84ADE2DE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 07:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530B33B3359
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 05:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF71E572F;
	Wed, 18 Jun 2025 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr0RUQVX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0A1DD9AD;
	Wed, 18 Jun 2025 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750223149; cv=none; b=g7lVN7+YGpH0xLkVCGRJvIMLRXjTGfd2v4Nwv5/TW1v9TKLPsFb3r9V/eCNxtMVpxC4xCJ6DgWmjtRXW4nhtMRV+PgBWZOCpIYI9TVBLEneNyGhd/KAYaZvV9Fxi7IkNcT+nYNC7qD2WKsREhYQZzoIhMt7cHZL2iWB9vhuTghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750223149; c=relaxed/simple;
	bh=pEYlweHTyd1FF6qYfyKbLz6rjLTrLgq8nUDmZK7/uEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBXFnQZ8zHNvwJkqHVSNJ/qrDqVeXUNaDyuGAYG8ISVQYbNZ1eXDmJG5CDwif4jz7HXTz0Pg6f4TDXj8BWUiU6bn9dz7sbpu/aJvh8/aK1BetMm84fdp6cv6RRy5p4XS2KYjBFyRkVjHeK4cHaI4srvofsHZuT86612DwGlIvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr0RUQVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BD7C4CEE7;
	Wed, 18 Jun 2025 05:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750223148;
	bh=pEYlweHTyd1FF6qYfyKbLz6rjLTrLgq8nUDmZK7/uEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rr0RUQVXs/qqfleg+3zkvpDQnGf8lbTC58heGkjSx2oNZMfE0YFI2OoRiMTpcWzU7
	 ZGuJggGNLEItjr8mDRmfafGebv5CkT4txl3jqjxemO/aO/eE8c90LToSrFtXpd9OOH
	 4/c2dcs5Xz0SZR+ezFLD+Nu6DRAZ4+GlF03D/CDBLnqmUn3mmIrq2UiW3ZqTBQl9Yj
	 uRaw0H6SvXoyKPbneCJ03Lq7KBS+n1k5fpYOM3Oaei60znCA9z8yEbk4b2wijdmhCi
	 LocVgBS4zA3O8axwy32I3RzoPPU2kCtjtTb6KCVOlmPpDIFwXcoqq/TDoXjwuHNS5c
	 1v8RvVbJ58S2g==
Date: Wed, 18 Jun 2025 10:35:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Lukas Wunner <lukas@wunner.de>, 
	kernel test robot <lkp@intel.com>, bhelgaas@google.com, oe-kbuild-all@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <f5qfkb543al3ihonj7n7fi4pcd3kopavweyo5ixdgv7o3lct4u@r73fkstrcl62>
References: <pwb4g7worzsnryimt3ymdfsxu7bxvhlr74rqodmiof5auolhrc@vpi7wzrp7osh>
 <20250617204406.GA1151053@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617204406.GA1151053@bhelgaas>

On Tue, Jun 17, 2025 at 03:44:06PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 16, 2025 at 07:14:50PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 16, 2025 at 03:30:27PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Jun 16, 2025 at 3:16 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > >
> > > > On Mon, Jun 16, 2025 at 06:07:48PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Jun 16, 2025 at 08:21:20PM +0800, kernel test robot wrote:
> > > > > >    ld: drivers/pci/probe.o: in function `pci_scan_single_device':
> > > > > > >> probe.c:(.text+0x2400): undefined reference to `pci_pwrctrl_create_device'
> > > > >
> > > > > Hmm, so we cannot have a built-in driver depend on a module...
> > > > >
> > > > > Bartosz, should we make CONFIG_PCI_PWRCTRL bool then? We can
> > > > > still allow the individual pwrctrl drivers be tristate.
> 
> I think I'm OK with making CONFIG_PCI_PWRCTRL bool.  What is the
> argument for making it a module?
> 

Only to avoid making the kernel image bigger.

> When pwrctrl is a module, it seems like we have no way to even
> indicate to the user that "there might be PCI devices here that could
> be powered on and enumerated."  That feels like information users
> ought to be able to get.
> 
> I do wonder if we're building a structure parallel to ACPI
> functionality and whether there could/should be some approach that
> unifies both.  But that's a tangent to this current issue.
> 

Well, pwrctrl is for non-ACPI platforms (mostly OF) and yes, it is parallel to
ACPI in some form, but that is inevitable since OF is just a hardware
description and ACPI is much more than that.

> > > > I guess the alternative is to just leave it in probe.c.  The
> > > > function is optimized away in the CONFIG_OF=n case because
> > > > of_pci_find_child_device() returns NULL.  It's unpleasant that
> > > > it lives outside of pwrctrl/core.c, but it doesn't occupy any
> > > > space in the compiled kernel at least on non-OF (e.g. ACPI)
> > > > platforms.
> 
> I don't like having pci_pwrctrl_create_device() in drivers/pci/probe.c
> and relying on the compiler to optimize it out when
> of_pci_find_child_device() returns NULL.  This is in the fundamental
> device enumeration path, and I think it's unnecessary confusion for
> every non-OF reader.
> 

Okay.

> > > And there's a third option of having this function live in a
> > > separate .c file under drivers/pci/pwrctl/ that would be always
> > > built-in even if PWRCTL itself is a module. The best/worst of two
> > > worlds? :)
> > 
> > I would try to avoid the third option at any cost ;) Because the
> > pwrctrl/core.c would no longer be the 'core' and the code structure
> > would look distorted.
> 
> I don't really see adding problem with a file in drivers/pci/pwrctrl/.
> 
> Whether it should be "core.c" or not, I dunno.  I think "core.c" could
> make sense for things that must be present always, e.g.,
> pci_pwrctrl_create_device(), and the driver itself could be
> "pwrctrl.c"
> 

Then it will always end up in confusion of where to place the functions and
such. For sure the Kconfig can define what each file stands for, but IMO it
feels weird to have 2 files for the same purpose.

But if you insist, I can go for it.

> If pwrctrl is built as a module, what is the module name?  I assume it
> must be "pwrctrl", though Kconfig doesn't mention it and I don't grok
> enough Makefile to figure it out.  "core" would be useless in the
> print_modules() output.
> 

It is 'pci-pwrctrl-core.ko'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

