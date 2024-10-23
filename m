Return-Path: <linux-pci+bounces-15152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71CC9AD654
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 23:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E24B21851
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B181E285A;
	Wed, 23 Oct 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dALpQjU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B3158868;
	Wed, 23 Oct 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717611; cv=none; b=oSEjqv/bPFiH4sxMD0SAB83iyP2NbFfwTbAps9L0kl3QLyUxg3VMOVJ9SUpsnZyWt6hfTVPI9N8x2IpGlSh1sq1yUdbvzZhNleXYW+W58qRIsuQ7YvdgZEksvP0bTkpZDj14jkKH8MhnYHlaMn+hB4FMPsDJxyJTDCy96HLNVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717611; c=relaxed/simple;
	bh=0AmIw1z06mHRZ0833V5n14SMbBkaDuFy9pBuPJVAumo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YxKLj6kHRQiIiFx8deQAwGdtNz+P3pTf0Xqeb/O4n4x64zJiXjst1whlSNR7hHBGA9CfJeifWZtdN5Yv2uHfvXyfFvmLlyo6eHBZH2Teft60jaXvlnG71CuB4rVuZOpJIxnBC2Mjb3PzazwOz9xCs+Bg7gSCDJq5TfewCgw/2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dALpQjU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22490C4CEC6;
	Wed, 23 Oct 2024 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729717611;
	bh=0AmIw1z06mHRZ0833V5n14SMbBkaDuFy9pBuPJVAumo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dALpQjU9iE166d2PIn2n/++csZZZGoF1NW0030z6i9svSwVwM9ILt3HbrMhlbNzTQ
	 ai/M0zL/4EHh2kMFHsDZIAajqwFApRGfeD+3I/iaLXHJlmBeqHcjMmYb2/sy64FtdX
	 YWkkaR+icZWVix1/nl5MZTltei98/hE6phGBT5SLjmPButAPEV58+Gw5351FIKUIjX
	 /uX6iXp2nen2wUDgsMg6yQh7sgydYGpPTSJVka5lQgNBxa/BvIuy162GqGZFZZKLKu
	 N2NYpA3S69ycgACtEsiTT1aezrGX4q/QOli67f3aHFBYfk+a/WltkJOVBVx73DpwtV
	 GG9JQ3mKj82vw==
Date: Wed, 23 Oct 2024 16:06:49 -0500
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
Message-ID: <20241023210649.GA934487@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023205818.GA930054@bhelgaas>

On Wed, Oct 23, 2024 at 03:58:21PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 29, 2024 at 11:32:47AM +0200, Lukas Wunner wrote:
> > On Wed, Aug 28, 2024 at 05:15:24PM -0400, Esther Shimanovich wrote:
> > > On Sun, Aug 25, 2024 at 10:49???AM Lukas Wunner <lukas@wunner.de> wrote:
> > > > On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > > > > --- a/drivers/pci/probe.c
> > > > > +++ b/drivers/pci/probe.c
> > > > > +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> > > > > +{
> > > > > +     struct fwnode_handle *fwnode;
> > > > > +
> > > > > +     /*
> > > > > +      * For USB4, the tunneled PCIe root or downstream ports are marked
> > > > > +      * with the "usb4-host-interface" ACPI property, so we look for
> > > > > +      * that first. This should cover most cases.
> > > > > +      */
> > > > > +     fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> > > > > +                                    "usb4-host-interface", 0);
> > > >
> > > > This is all ACPI only, so it should either be #ifdef'ed to CONFIG_ACPI
> > > > or moved to drivers/pci/pci-acpi.c.
> > > >
> > > > Alternatively, it could be moved to arch/x86/pci/ because ACPI can also
> > > > be enabled on arm64 or riscv but the issue seems to only affect x86.
> > > 
> > > Thanks for the feedback! Adding an #ifdef to CONFIG_ACPI seems more
> > > straightforward, but I do like the idea of not having unnecessary code
> > > run on non-x86 systems.
> > > 
> > > I'd appreciate some guidance here. How would I move a portion of a
> > > function into a completely different location in the kernel src?
> > > Could you show me an example?
> > 
> > One way to do this would be to move pcie_is_tunneled(),
> > pcie_has_usb4_host_interface() and pcie_switch_directly_under()
> > to arch/x86/pci/acpi.c.
> > 
> > Rename pcie_is_tunneled() to arch_pci_dev_is_removable() and remove
> > the "static" declaration specifier from that function.
> > 
> > Add a function declaration for arch_pci_dev_is_removable() to
> > include/linux/pci.h.
> > 
> > Add a __weak arch_pci_dev_is_removable() function which just returns
> > false in drivers/pci/probe.c right above pci_set_removable().
> > 
> > And that's it.
> > 
> > See pcibios_device_add() for an example.
> > 
> > That's one way to do it.  It ensures that the code is only compiled
> > on x86 and only if CONFIG_ACPI=y.  Basically the linker picks the
> > arch_pci_dev_is_removable() in arch/x86/pci/acpi.c, or the empty
> > __weak function of the same name on !x86 or if CONFIG_ACPI=n.
> > 
> > An alternative approach would involve using an empty static inline.
> > I think the difference is that an empty static inline is optimized
> > away by the compiler, whereas the empty __weak function is not
> > optimized away by the compiler, but may be optimized away by the
> > linker if CONFIG_LTO=y.
> > 
> > For the static inline it's basically the same but you omit the
> > __weak arch_pci_dev_is_removable() in drivers/pci/probe.c and
> > instead constrain the function declaration in include/linux/pci.h to:
> > #if defined(CONFIG_X86) && defined(CONFIG_ACPI)
> > ...and the #else branch would contain the empty static inline
> > which just returns false.
> > 
> > See pci_mmcfg_early_init() for an example.
> > 
> > Maybe the empty static inline is better because then the entire
> > "if (arch_pci_dev_is_removable(...))" clause can be optimized away
> > without reliance on CONFIG_LTO=y.
> 
> Was there ever any followup on this?  Do we need any?
> 
> This uses fwnode_find_reference("usb4-host-interface"), and while
> "usb4-host-interface" is only defined for ACPI systems (as far as I
> know), the fwnode_find_reference() interface itself is not
> ACPI-specific.
> 
> So maybe this is OK as-is, and it will just never find that property
> on non-ACPI systems?

Sigh, sorry for the noise.  Right after sending this, I noticed that
Esther had posted a v5 with this rework:
https://lore.kernel.org/r/20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org

Although I'm still unclear on whether we actually need to make this
ACPI-specific as v5 does.

I'm also not sure about making it x86-specific, since the
"usb4-host-interface" property doesn't seem x86-specific, other than
maybe as an accidental consequence of some hardware implementations.

Bjorn

