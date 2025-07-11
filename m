Return-Path: <linux-pci+bounces-31958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9670B0264C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1235C7BBE63
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F6E2288E3;
	Fri, 11 Jul 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH1Lj303"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9A1DE3CB;
	Fri, 11 Jul 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268783; cv=none; b=ZUQgLC9dBzhi7pNgy0DvpLx3Z/IcuQZKUCfw1GzW5uZsQmLIC0LLLZd+p+WrkPO5Lf2tOw0HHd1tTXyJ4EBWbyrJMf89U2giaGhYkrENwVzbvLwjBGTVVpRi4Pt/cr0rKEXNu92sXstkaOX5P2zF5DVVMkcWm3oD1+XMq6RHSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268783; c=relaxed/simple;
	bh=Y6ruZaklCb+BcpDgczIa2wplngYzuGzV5dv2F1vLS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dF0oZQ8JVbL2ix/iqZmn7kJRc5BM26B9CjQBMwSf2Hd+0HJicp1O019wzIPvKTV2ORYZoZGo7UTZ025D1howVmqQve5kOSS1oRgRYDP921pAobbGN4ldIOZp6ECUasiB+Kte1REqQXaQlTSM+GE+CCgPqJvzSCNrXC/v85S0xDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH1Lj303; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D16C4CEED;
	Fri, 11 Jul 2025 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752268782;
	bh=Y6ruZaklCb+BcpDgczIa2wplngYzuGzV5dv2F1vLS0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mH1Lj3030pRwdBffwlBwUNtfC/W9h1AGGbZjnM9KIqSD+rJJtEmooIW7m985xTw3n
	 uzbYN9BDtyFQW7MEOJfWpUAyJdNCpUaZcSxLy1IsGcN0+OhNUiN01iem6/WGz/KoFC
	 ctXT0ZD3n7cSOnT2DRCqxKhY5a6w0ltU5WNw3/Ik/BeyytNG1VpYG9/Hdzl9Ktcl+9
	 I7dzan0lFw1EFcS5l86tIVG7INFPeMjB3CzFM27BjrDxJ4y595ks9TXbVfwn2qP3GL
	 Gxj3GDcl2bibesmcqDI3tj4ewVkJ/jRWQuCVB2EsJ//IZVtOJi4CopQ7zKdkWrblzL
	 FSHj96XEGWaKA==
Date: Fri, 11 Jul 2025 16:19:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Box <david.e.box@linux.intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	bhelgaas@google.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	vicamo.yang@canonical.com, kenny@panix.com,
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Allow ASPM enablement for devices behind Intel
 VMD
Message-ID: <20250711211941.GA2306776@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ohil4of5wkoowdwouawjwlrmmmpeim2miscynn35v4ddg7zaoh@rebfuhcozirz>

On Fri, Jul 11, 2025 at 09:06:27AM -0700, David Box wrote:
> On Fri, Jul 11, 2025 at 05:49:03PM +0300, Ilpo Järvinen wrote:
> > On Fri, 11 Jul 2025, David Box wrote:
> > > On Thu, Jul 10, 2025 at 09:53:18PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, Jul 10, 2025 at 3:16 AM David E. Box
> > > > <david.e.box@linux.intel.com> wrote:
> > > > >
> > > > > Devices behind Intel's Volume Management Device (VMD) controller reside on
> > > > > a synthetic PCI hierarchy that is intentionally hidden from ACPI and
> > > > > firmware. As such, BIOS does not configure ASPM for these devices, and the
> > > > > responsibility for link power management, including ASPM and LTR, falls
> > > > > entirely to the VMD driver.
> > > > >
> > > > > However, the current PCIe ASPM code prevents ASPM configuration when the
> > > > > ACPI_FADT_NO_ASPM flag is set, disallowing OS management. This leaves ASPM
> > > > > permanently disabled for these devices, contrary to the platform's design
> > > > > intent.
> > > > >
> > > > > Introduce a callback mechanism that allows the VMD driver to enable ASPM
> > > > > for its domain, bypassing the global ACPI_FADT_NO_ASPM restriction that is
> > > > > not applicable in this context. This ensures that devices behind VMD can
> > > > > benefit from ASPM savings as originally intended.
> ...

> > > > > +       /*
> > > > > +        * Devices behind Intel VMD operate on a synthetic PCI bus that BIOS
> > > > > +        * and ACPI do not enumerate or configure. ASPM for these devices must
> > > > > +        * be managed by the VMD driver itself, independent of global ACPI ASPM
> > > > > +        * constraints. This callback mechanism allows selective ASPM
> > > > > +        * enablement for such domains.
> > > > > +        */
> > > > > +       vmd_aspm_default = pci_get_vmd_link_state(parent);
> > > > > +
> > > > >         /* Save default state */
> > > > > -       link->aspm_default = link->aspm_enabled;
> > > > > +       if (vmd_aspm_default < 0)
> > > > > +               link->aspm_default = link->aspm_enabled;
> > > > > +       else
> > > > > +               link->aspm_default = vmd_aspm_default;
> > > > 
> > > > Well, this is not nice.
> > > > 
> > > > First off, it adds VMD-specific stuff to otherwise generic
> > > > ASPM code.  Second, it doesn't actually do anything about the
> > > > aspm_disabled checks all over the place, so they will still
> > > > trigger even though ASPM will be effectively enabled for
> > > > devices on the VMD bus.
> > > 
> > > I agree that it's not nice to be mixing VMD specific code here.
> > > It's a working bad solution to come up with a working good
> > > solution :)
> > > 
> > > The reason this patch works is that the aspm_disabled checks
> > > only gate OS-controlled ASPM configuration. They don't affect
> > > the BIOS default values, which are what we're setting in
> > > link->aspm_default. The ASPM code uses link->aspm_default as the
> > > fallback when ASPM is globally disabled, which is exactly what
> > > we want for devices behind VMD where the driver, not BIOS,
> > > effectively is the platform provider of the defaults.
> > 
> > Oh, this was a big news to me.
> > 
> > So what you're saying is that if aspm_disabled is set,
> > ->aspm_disable cannot be set and thus pcie_config_aspm_link() that
> > is not gated by aspm_disabled can alter ASPM state despite OS not
> > having ASPM control???
> 
> Yes, that’s correct. Bjorn can confirm, but I believe this is by
> design. The aspm_disabled flag is really a bit of a misnomer. It
> probably should have been called something like os_aspm_disabled.
> The intent as I understand it is that, when disallowed, the OS
> cannot select or manage the active ASPM policy, but it can still
> configure the link to match the BIOS provided policy.

Right, there's a long ugly history of this, here's the pcie_no_aspm()
comment:

  /*
   * Disabling ASPM is intended to prevent the kernel from modifying
   * existing hardware state, not to clear existing state. To that end:
   * (a) set policy to POLICY_DEFAULT in order to avoid changing state
   * (b) prevent userspace from changing policy
   */
  if (!aspm_force) {
	  aspm_policy = POLICY_DEFAULT;
	  aspm_disabled = 1;
  }

which came from 3c076351c402 ("PCI: Rework ASPM disable code").  All
the ASPM disable, force, support_enabled, policy, etc flags make this
ugly and impossible to read.  I guess renaming might help a little.

> In other words, ASPM isn’t fully disabled. It’s just not under OS
> control. The BIOS values, reflected in link->aspm_default, remain
> valid and pcie_config_aspm_link() can apply them regardless of the
> aspm_disabled setting.
> 
> > ...That's really odd logic which the ASPM driver seems to be full of.

+10

Also the ugliness of pcie_aspm_init_link_state() being called
completely out of the usual enumeration flow.  And the parallel device
hierarchy maintained in struct pcie_link_state.  And config options to
set the default policy.  Ugh.

I hope we can avoid adding VMD-specific code in aspm.c.

Bjorn

