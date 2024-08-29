Return-Path: <linux-pci+bounces-12417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EB964031
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E88B2164A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551818CBE5;
	Thu, 29 Aug 2024 09:33:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40A9189BA3;
	Thu, 29 Aug 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923980; cv=none; b=oBfs/ZpnACQAJwqmAIExg1IksnvjYw0G1Dr3KP0Dm81Gb/IUTJcnYWznZnSNcviMLpQazUaog/DFXe2u0K4yDhPizNTtoY5Rpuz69nOhoXbqliymfu0t3CUaFoa9RPGtpnipjvEfEuU9Zg36NLdYRae/7GSdS/7IABbXWMaiVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923980; c=relaxed/simple;
	bh=yGCID0GCiA9pXFJg0fO8tvyOnGozjM+tId2ELiGSJsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic5en6ndqL4xYsJtIsE1PxM1VBludjpODUDnZqCY2NyXdxbIDfp44c9rYqJ0AZdBPaDJhjC68Jcj9QNz36js0fTf+MZv3uLq3LTlrIxWt5JTEG+zoQ7b/ggxfqUUUyOW3WlM8Fo70zcz1uS/Xixs3ciaDWZpszSq/3+XQl5W/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8E4AF28036B3A;
	Thu, 29 Aug 2024 11:32:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 676935B1ED; Thu, 29 Aug 2024 11:32:47 +0200 (CEST)
Date: Thu, 29 Aug 2024 11:32:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <ZtBAP4TayLmdiya_@wunner.de>
References: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org>
 <ZstCyti3FHZIeFO8@wunner.de>
 <CA+Y6NJE1p-nidmCZzJ7j-mJAmCLmC2q2meUf-5FFSWofWES-qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Y6NJE1p-nidmCZzJ7j-mJAmCLmC2q2meUf-5FFSWofWES-qA@mail.gmail.com>

On Wed, Aug 28, 2024 at 05:15:24PM -0400, Esther Shimanovich wrote:
> On Sun, Aug 25, 2024 at 10:49???AM Lukas Wunner <lukas@wunner.de> wrote:
> > On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> > > +{
> > > +     struct fwnode_handle *fwnode;
> > > +
> > > +     /*
> > > +      * For USB4, the tunneled PCIe root or downstream ports are marked
> > > +      * with the "usb4-host-interface" ACPI property, so we look for
> > > +      * that first. This should cover most cases.
> > > +      */
> > > +     fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> > > +                                    "usb4-host-interface", 0);
> >
> > This is all ACPI only, so it should either be #ifdef'ed to CONFIG_ACPI
> > or moved to drivers/pci/pci-acpi.c.
> >
> > Alternatively, it could be moved to arch/x86/pci/ because ACPI can also
> > be enabled on arm64 or riscv but the issue seems to only affect x86.
> 
> Thanks for the feedback! Adding an #ifdef to CONFIG_ACPI seems more
> straightforward, but I do like the idea of not having unnecessary code
> run on non-x86 systems.
> 
> I'd appreciate some guidance here. How would I move a portion of a
> function into a completely different location in the kernel src?
> Could you show me an example?

One way to do this would be to move pcie_is_tunneled(),
pcie_has_usb4_host_interface() and pcie_switch_directly_under()
to arch/x86/pci/acpi.c.

Rename pcie_is_tunneled() to arch_pci_dev_is_removable() and remove
the "static" declaration specifier from that function.

Add a function declaration for arch_pci_dev_is_removable() to
include/linux/pci.h.

Add a __weak arch_pci_dev_is_removable() function which just returns
false in drivers/pci/probe.c right above pci_set_removable().

And that's it.

See pcibios_device_add() for an example.

That's one way to do it.  It ensures that the code is only compiled
on x86 and only if CONFIG_ACPI=y.  Basically the linker picks the
arch_pci_dev_is_removable() in arch/x86/pci/acpi.c, or the empty
__weak function of the same name on !x86 or if CONFIG_ACPI=n.

An alternative approach would involve using an empty static inline.
I think the difference is that an empty static inline is optimized
away by the compiler, whereas the empty __weak function is not
optimized away by the compiler, but may be optimized away by the
linker if CONFIG_LTO=y.

For the static inline it's basically the same but you omit the
__weak arch_pci_dev_is_removable() in drivers/pci/probe.c and
instead constrain the function declaration in include/linux/pci.h to:
#if defined(CONFIG_X86) && defined(CONFIG_ACPI)
...and the #else branch would contain the empty static inline
which just returns false.

See pci_mmcfg_early_init() for an example.

Maybe the empty static inline is better because then the entire
"if (arch_pci_dev_is_removable(...))" clause can be optimized away
without reliance on CONFIG_LTO=y.

I hope I haven't confused you completely.

Thanks,

Lukas

