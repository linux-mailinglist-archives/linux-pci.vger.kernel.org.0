Return-Path: <linux-pci+bounces-10022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8792C3ED
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 21:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AED1C2224D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E5118003A;
	Tue,  9 Jul 2024 19:33:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A41B86D5;
	Tue,  9 Jul 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553589; cv=none; b=MQONhcn6CmZOHnT6ZLniYnKvNpKsG2CmxjaeWOIKZXNFCQl5vsGRkyUoZEQQ5NR2yKSpffRNwN0g8l8/9hhtVvzqPU2fAxLO4ayAUJ6UvXXJbxCOtR1SMsJ9Cl01ebIoMmAoNkKesNpKA0RQWvcy9mysGkz2jD9QfMkXdogSOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553589; c=relaxed/simple;
	bh=hNXOWe8lteOgViqy/EYlSV9Y+hmjJwlEra6rH3zbBKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwMC4ISV5P6FNWlX1CL0wHtDxKNwVMDnNkUM8XX0BfuYddM3uS+OVYqts9PNvw87gOtZoxfRrcVi6tNCctci7cLU6N18yaWeopO8bOPcH/HHeAfiNF/uDov+ncQdjzwwjf0O9dRGssNeoN5JfIQMdlM1irTpq9EXctUQHaApOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6048210278761;
	Tue,  9 Jul 2024 21:32:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EA81C4A175; Tue,  9 Jul 2024 21:32:55 +0200 (CEST)
Date: Tue, 9 Jul 2024 21:32:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linuxarm@huawei.com,
	David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
	Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <Zo2QZ_4xkMR_Nmsf@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
 <6d4361f13a942efc4b4d33d22e56b564c4362328.1719771133.git.lukas@wunner.de>
 <668d7d318082b_102cc2942f@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668d7d318082b_102cc2942f@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jul 09, 2024 at 11:10:57AM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -121,6 +121,19 @@ config XEN_PCIDEV_FRONTEND
> >  config PCI_ATS
> >  	bool
> >  
> > +config PCI_CMA
> > +	bool "Component Measurement and Authentication (CMA-SPDM)"
> 
> What is driving the requirement for CMA to be built-in?

There is no way to auto-load modules needed for certain PCI features.
We'd have to call request_module() on PCI bus enumeration when
encountering devices with specific PCI features.  But what do we do
if module loading fails?  The PCI bus is enumerated in a subsys_initcall,
when neither the root filesystem has been mounted nor run_init_process()
has been called.  So any PCI core modules would have to be in the initrd.
What if they aren't?  Kernel panic?  That question seems particularly
pertinent for a security feature like CMA.

So we've made PCI core features non-modular by default.
In seven cases we even switched from tristate to bool because building
as modules turned out not to be working properly:

82280f7af729 ("PCI: shpchp: Convert SHPC to be builtin only")
a4959d8c1eaa ("PCI: Remove DPC tristate module option")
774104399459 ("PCI: Convert ioapic to be builtin only, not modular")
67f43f38eeb3 ("s390/pci/hotplug: convert to be builtin only")
c10cc483bf3f ("PCI: pciehp: Convert pciehp to be builtin only, not modular")
7cd29f4b22be ("PCI: hotplug: Convert to be builtin only, not modular")
6037a803b05e ("PCI: acpiphp: Convert acpiphp to be builtin only, not modular")

There has not been a single case where we switched from bool to tristate,
with the exception of PCI_IOAPIC with commit b95a7bd70046, but that was
subsequently reverted back to bool with the above-listed 774104399459.


> All of the use cases I know about to date are built around userspace
> policy auditing devices after the fact.

I think we should also support use cases where user space sets a policy
(e.g. not to bind devices to a driver unless they authenticate) and lets
the kernel do the rest (i.e. autonomously authenticate devices based on
a set of trusted root certificates).  User space does not *have* to be
the one auditing each device on a case-by-case basis, although I do see
the usefulness of such scenarios and am open to supporting them.  In fact
this v2 takes a step in that direction by exposing signatures received
from the device to user space and doing so even if the kernel cannot
validate the device's certificate chains as well-formed and trusted.

In other words, I'm trying to support both:  Fully autonomous in-kernel
authentication of certificates, but also allowing user space to make a
decision if it wants to.  It's simply not clear to me at the moment
what the use cases will be.  I can very well imagine that, say,
ChromeBooks will want to authenticate Thunderbolt-attached PCI devices
based on a keyring of trusted vendor certificates.  The fully autonomous
in-kernel authentication caters to such a use case.  I don't want to
preclude such use cases just because Confidential Computing in the
cloud happens to be the buzzword du jour.

Thanks,

Lukas

