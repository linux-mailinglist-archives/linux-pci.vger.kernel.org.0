Return-Path: <linux-pci+bounces-10159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E883692EB2F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F50E1F243CC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9916B15D5D9;
	Thu, 11 Jul 2024 15:00:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B316B743;
	Thu, 11 Jul 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710037; cv=none; b=dzQJvLy+IEuYf+ut96ILlapwvC06+MhuUJ3CYx5WuFYtUB6ICymq1+9TE/sSS9qx7uwafdixm5LQQ4C4RabIdrqhIb3Vg3CNhfimUj6G7wQaOpRqIwcxrcy8f21v0HDYI9MYf1hMG4RUCA84bH/lbw7Ee7sd4VL4zdjVm4O7BmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710037; c=relaxed/simple;
	bh=LudTEYRfZlnvYQXONEYRd3VAVe+JaXveGK9Bk1Rqur4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G1EMuzTidY7VdMQEWnTPbjbB7bo/Cd5ATKYih75/vFRYicYK9Dpkl8Qt0+1tFAVOZTtetUOeajubvt6WvLeqGAMfqk7VlKR13aWzz+Y27ZHu0FxYNiLGZOoo5FJ2hUfeOJflOrUbnMSp4xANHfDnUZzjmLG66toGpSHDJNBRvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1FB3830002534;
	Thu, 11 Jul 2024 17:00:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0F242EEAB0; Thu, 11 Jul 2024 17:00:26 +0200 (CEST)
Date: Thu, 11 Jul 2024 17:00:26 +0200
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
Message-ID: <Zo_zivacyWmBuQcM@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668f17d4553_6de2294ba@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <668dc8525d9e7_102cc294f8@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jul 09, 2024 at 04:31:30PM -0700, Dan Williams wrote:
> Non-authenticated operation is the status quo. CMA is a building block
> to other security features.

That's not quite correct:  Products exist which support CMA but neither
IDE nor TDISP.  CMA is not just a building block for IDE or TDISP,
but is useful on its own merits.

> Nothing currently cares about CMA being
> established before a driver loads and it is not clear that now is the
> time to for the kernel to paint itself into a corner to make that
> guarantee.

The PCI core initializes all of the device's capabilities upon enumeration.
CMA is no different than any of the other capabilities.

Chromebooks and many Linux distributions prevent driver binding to
Thunderbolt-attached devices unless they're authorized by the user.
I fully expect that vendors will want to additionally take advantage
of authentication.  I don't want to wait for Windows or macOS to go
ahead and add automatic authentication, then follow in their footsteps.
I want Linux to lead the way here, so yes, absolutely, that's the corner
I want the kernel to paint itself in, no less.

> I think you are conflating automatic authentication and built-in
> functionality. There are counter examples of security features like
> encrypted root filesystems built on top of module drivers.

Encrypted root filesystems are mounted after all initcall levels have run
and user space has been launched.  At that point it's possible to invoke
request_module().  But request_module() cannot be invoked from a
subsys_initcall(), which is when device capabilities are enumerated.

TSM can be a module because it's geared towards the passthrough use case
and passthrough only happens when user space is up and running.

> What I am trying to avoid is CMA setting unnecessary expectations that
> can not be duplicated by TSM like "all authentication capable PCI
> devices will be authenticated prior to driver attach".

I don't want to artificially cripple CMA in order to achieve only a
lowest common denominator with TSM.  Both, native CMA and TSM-driven
authentication have their respective use cases and (dis)advantages.
Should we try to strive for commonalities in the ABI?  Of course!
But not at the expense of reducing functionality.

> I agree that CMA should be in kernel, it's not clear that authentication
> needs to be automatic, and certainly not in a way that a driver can not
> opt-out of.

If there is a need to opt out, that feature can be retrofitted easily.
But systems need to be "secure by default":
https://en.wikipedia.org/wiki/Secure_by_default

> What if a use case cares about resume time latency?

Resume is parallelized (see dpm_noirq_resume_devices()), so the latency
is bounded by the time to authenticate a single device.

Unfortunately boot-time enumeration of the PCI bus is not parallelized
for historic reasons, we may indeed have to look into that.

> What if a driver
> knows that authentication is only needed later in the resume flow?

If authentication is not possible in the ->resume_noirq phase because
the driver needs to perform some initialization steps, it can just call
on the PCI core to reauthenticate the device after those steps.

The declaration of pci_cma_reauthenticate() can be moved from
drivers/pci/pci.h to include/linux/pci.h once that need arrives.

> At a minimum I think pci_cma_reauthenticate() should do something like:
> 
> /* not previously authenticated skip authentication */
> if (!spdm_state->authenticated)
> 	return;
> 
> ...so that spdm capable devices can opt-out of automatic reauthentication.

Unfortunately that doesn't work:

A device may have been reset due to a firmware update which adds
CMA support.  Or the keyring of trusted root certificates may have
been missing the certificate for authenticating the device, but the
certificate has since been added.  Or the device came back from reset
with a different certificate chain.  Or it was hot-replaced with a
CMA-capable one...

Thanks,

Lukas

