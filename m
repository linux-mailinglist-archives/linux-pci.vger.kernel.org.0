Return-Path: <linux-pci+bounces-15151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0739AD5E3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 22:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D40D1F22934
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225D1E2823;
	Wed, 23 Oct 2024 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdP/bcoT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406313AA2B;
	Wed, 23 Oct 2024 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717102; cv=none; b=fFZFVNNL4MVVBhh2MbkSiobQ/AN86HgFougvt5x5R5JFbS4L9ehGe9Zc02LFwj8ay+QCYcNeDtK1lqIvTT8HOKB9vKFp3SxkjttjdI4m2o7sunY8Sx9T7ZMx8NysgaAzbeIkbNeQMJabLGsxa1M+vh/5dBXS2ePw9ErgW0u4YiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717102; c=relaxed/simple;
	bh=ua6G8hOkmOlyX02Sg136mZtIxjo24HD4simPCtz5OZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cIBxYKruqwUTTkB35LK1vPreDBpbdYn/jQrxqFWvz9aslSOS64YughM7GhqVTfBSZeItl8rDkagNyu6v1oCpuUPL/sMY/PVF5mkysiAd7ldaR92fHOBgmR4l0LK65GlXGRSyhxnGw0zCZQmR89d+R+cn7+6exg3Z9i5dYOldLyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdP/bcoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAB7C4CEC6;
	Wed, 23 Oct 2024 20:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729717101;
	bh=ua6G8hOkmOlyX02Sg136mZtIxjo24HD4simPCtz5OZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PdP/bcoTtsZprA0eIGG5u683til6mhI+2kRWD3o/S2nGZ+8hK7kjC1REuHFOih+Ih
	 v37MvJhVrE9hq97QpWLW6squOv2WS9AHJ/X7ELVZUwQaeg+8rAnskfAe7V56aYMK77
	 GHluSzR8LEwbmG91VilndxpUv2XtGsUvOUmX1Dvj6sGEqwZLavPFg0Ldoo7oxv361E
	 FWeq76YDRJxjK4OKPdkCoX1IeeNNesvfi89x8sUm1XO0pjgfrcAZZywZXk3sEDKX/q
	 DQfDLX3y5rnHy3j5vIIhmvEk8m6pAZL0Q16bjEUZYYYO6fuNmD+W1cKGQhyUlZm4sN
	 Y7GnXdj2n8PFg==
Date: Wed, 23 Oct 2024 15:58:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20241023205818.GA930054@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBAP4TayLmdiya_@wunner.de>

On Thu, Aug 29, 2024 at 11:32:47AM +0200, Lukas Wunner wrote:
> On Wed, Aug 28, 2024 at 05:15:24PM -0400, Esther Shimanovich wrote:
> > On Sun, Aug 25, 2024 at 10:49???AM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> > > > +{
> > > > +     struct fwnode_handle *fwnode;
> > > > +
> > > > +     /*
> > > > +      * For USB4, the tunneled PCIe root or downstream ports are marked
> > > > +      * with the "usb4-host-interface" ACPI property, so we look for
> > > > +      * that first. This should cover most cases.
> > > > +      */
> > > > +     fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> > > > +                                    "usb4-host-interface", 0);
> > >
> > > This is all ACPI only, so it should either be #ifdef'ed to CONFIG_ACPI
> > > or moved to drivers/pci/pci-acpi.c.
> > >
> > > Alternatively, it could be moved to arch/x86/pci/ because ACPI can also
> > > be enabled on arm64 or riscv but the issue seems to only affect x86.
> > 
> > Thanks for the feedback! Adding an #ifdef to CONFIG_ACPI seems more
> > straightforward, but I do like the idea of not having unnecessary code
> > run on non-x86 systems.
> > 
> > I'd appreciate some guidance here. How would I move a portion of a
> > function into a completely different location in the kernel src?
> > Could you show me an example?
> 
> One way to do this would be to move pcie_is_tunneled(),
> pcie_has_usb4_host_interface() and pcie_switch_directly_under()
> to arch/x86/pci/acpi.c.
> 
> Rename pcie_is_tunneled() to arch_pci_dev_is_removable() and remove
> the "static" declaration specifier from that function.
> 
> Add a function declaration for arch_pci_dev_is_removable() to
> include/linux/pci.h.
> 
> Add a __weak arch_pci_dev_is_removable() function which just returns
> false in drivers/pci/probe.c right above pci_set_removable().
> 
> And that's it.
> 
> See pcibios_device_add() for an example.
> 
> That's one way to do it.  It ensures that the code is only compiled
> on x86 and only if CONFIG_ACPI=y.  Basically the linker picks the
> arch_pci_dev_is_removable() in arch/x86/pci/acpi.c, or the empty
> __weak function of the same name on !x86 or if CONFIG_ACPI=n.
> 
> An alternative approach would involve using an empty static inline.
> I think the difference is that an empty static inline is optimized
> away by the compiler, whereas the empty __weak function is not
> optimized away by the compiler, but may be optimized away by the
> linker if CONFIG_LTO=y.
> 
> For the static inline it's basically the same but you omit the
> __weak arch_pci_dev_is_removable() in drivers/pci/probe.c and
> instead constrain the function declaration in include/linux/pci.h to:
> #if defined(CONFIG_X86) && defined(CONFIG_ACPI)
> ...and the #else branch would contain the empty static inline
> which just returns false.
> 
> See pci_mmcfg_early_init() for an example.
> 
> Maybe the empty static inline is better because then the entire
> "if (arch_pci_dev_is_removable(...))" clause can be optimized away
> without reliance on CONFIG_LTO=y.

Was there ever any followup on this?  Do we need any?

This uses fwnode_find_reference("usb4-host-interface"), and while
"usb4-host-interface" is only defined for ACPI systems (as far as I
know), the fwnode_find_reference() interface itself is not
ACPI-specific.

So maybe this is OK as-is, and it will just never find that property
on non-ACPI systems?

Bjorn

