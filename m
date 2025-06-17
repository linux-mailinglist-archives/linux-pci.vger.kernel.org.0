Return-Path: <linux-pci+bounces-29978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BFADDD52
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5773A194018E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19A2528FD;
	Tue, 17 Jun 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juijGfqS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7212EFD8C;
	Tue, 17 Jun 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193048; cv=none; b=ezkt3OncxtGCC8CpqB0WW/mK3oU5VtjkMADf3NgBP3MUVTAXYb+7rZfUj0YpUF/jdwjz0PT7hczPtWGSTooI+CaSaMDPacjdBpOPVRapLOshnpXZvefBIEfLyw/0x4jFXksD+mjfZucIGCmLqkTHRzlr/2zE1UUkpp7jOd1T/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193048; c=relaxed/simple;
	bh=jFnXARC9BJC9TFd8zA3OkHO9qYcWjJfhhh7sAhe7/oE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J2OaM5RohvVKWZUpKY5DLiMYIp/Qyv6PLR7mqELL4PaINROpaOAEaXr98AfaVYCfBQrdSa0kvNtXSIuZQbnzLEShI2DURgyGDliiI6jQmxnaT8B6UHNCdMYydVnU9IKib0VUhJUxpzqHKlTTf+Fspaq4OKHmFTITOds2VRocPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juijGfqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41B6C4CEE3;
	Tue, 17 Jun 2025 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750193048;
	bh=jFnXARC9BJC9TFd8zA3OkHO9qYcWjJfhhh7sAhe7/oE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=juijGfqSThiZkVyVg0Y1zzpbjeFASpdI1Jfglif68aWizzSiJcb+WwC2oHOyxpAPX
	 QaDW0Eg5VaLvkZbm0+4A9d/7jyne58Jcdov45SyUfds5dq/1b3ddHx+PZb58jVXBMq
	 PciqjKtLn4dCvFUtYxuMhl/HV6Vr1VPmcnuh6OKzqD/I9oGYPd0fy5XzDxK11Glf8j
	 nduWjH/drTuzoWT5XxUCX/NZOeAp1fFgZBdAczMyf7y9dfb07XSpwJ6jkcUTts3O9B
	 iKMRqr1vfsBGakcJpDdf+xISo7E5dz7js9W5YvVEMOqU0U/PjrBYSCFb5mwwuS2NxH
	 fTADFWiFpF4nA==
Date: Tue, 17 Jun 2025 15:44:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Lukas Wunner <lukas@wunner.de>,
	kernel test robot <lkp@intel.com>, bhelgaas@google.com,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <20250617204406.GA1151053@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pwb4g7worzsnryimt3ymdfsxu7bxvhlr74rqodmiof5auolhrc@vpi7wzrp7osh>

On Mon, Jun 16, 2025 at 07:14:50PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 16, 2025 at 03:30:27PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Jun 16, 2025 at 3:16 PM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Mon, Jun 16, 2025 at 06:07:48PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Jun 16, 2025 at 08:21:20PM +0800, kernel test robot wrote:
> > > > >    ld: drivers/pci/probe.o: in function `pci_scan_single_device':
> > > > > >> probe.c:(.text+0x2400): undefined reference to `pci_pwrctrl_create_device'
> > > >
> > > > Hmm, so we cannot have a built-in driver depend on a module...
> > > >
> > > > Bartosz, should we make CONFIG_PCI_PWRCTRL bool then? We can
> > > > still allow the individual pwrctrl drivers be tristate.

I think I'm OK with making CONFIG_PCI_PWRCTRL bool.  What is the
argument for making it a module?

When pwrctrl is a module, it seems like we have no way to even
indicate to the user that "there might be PCI devices here that could
be powered on and enumerated."  That feels like information users
ought to be able to get.

I do wonder if we're building a structure parallel to ACPI
functionality and whether there could/should be some approach that
unifies both.  But that's a tangent to this current issue.

> > > I guess the alternative is to just leave it in probe.c.  The
> > > function is optimized away in the CONFIG_OF=n case because
> > > of_pci_find_child_device() returns NULL.  It's unpleasant that
> > > it lives outside of pwrctrl/core.c, but it doesn't occupy any
> > > space in the compiled kernel at least on non-OF (e.g. ACPI)
> > > platforms.

I don't like having pci_pwrctrl_create_device() in drivers/pci/probe.c
and relying on the compiler to optimize it out when
of_pci_find_child_device() returns NULL.  This is in the fundamental
device enumeration path, and I think it's unnecessary confusion for
every non-OF reader.

> > And there's a third option of having this function live in a
> > separate .c file under drivers/pci/pwrctl/ that would be always
> > built-in even if PWRCTL itself is a module. The best/worst of two
> > worlds? :)
> 
> I would try to avoid the third option at any cost ;) Because the
> pwrctrl/core.c would no longer be the 'core' and the code structure
> would look distorted.

I don't really see adding problem with a file in drivers/pci/pwrctrl/.

Whether it should be "core.c" or not, I dunno.  I think "core.c" could
make sense for things that must be present always, e.g.,
pci_pwrctrl_create_device(), and the driver itself could be
"pwrctrl.c"

If pwrctrl is built as a module, what is the module name?  I assume it
must be "pwrctrl", though Kconfig doesn't mention it and I don't grok
enough Makefile to figure it out.  "core" would be useless in the
print_modules() output.

> Let's see what Bjorn thinks about option 1 and 2. I did not account
> for the built-in vs modular dependency when Bjorn asked me if the
> move was possible. And I now vaguely remember that I kept it in
> probe.c initially because of this dependency.
>  
> - Mani
> 
> -- மணிவண்ணன் சதாசிவம்

