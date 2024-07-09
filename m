Return-Path: <linux-pci+bounces-9986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675A892B297
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991B11C21C1D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B6146D6D;
	Tue,  9 Jul 2024 08:49:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4842153814;
	Tue,  9 Jul 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514981; cv=none; b=JUA9DRf2rreRveVIFyR/zQsfQBJBmsAGmPFyT+t5lMYSXlXB7w3S2Jqw03+pNJrqiM+IhoPI4bf14ZJ+uDgLwEz7Sv7L8YBiXjZWbkUkg12eWgQiYp3thjBds6wjzLnY7xJif3wwuuIPOOgjGkC9IdYcTgxlAqyOutmmVGDUjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514981; c=relaxed/simple;
	bh=1LGGttV5i62yDKUecr8vz54XeY4DPh2JWDsYY1rJrOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZNNbMf5Cg+qVVNZxuneJn4qX8WZbc6h/BTW1pA7KtrxLc2oHHnUFRGU+eXxyw81OwZzXSKaxbKqzjDlcUgy3LZqPGcJ5ExRmFY/mF1GX69hhaqSJ3P6OYxVG0R5aQQTunBCaTXt/ndv1zyeS7ADPF1O/L8LenNey3UWA4O3ivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AF9F21025A944;
	Tue,  9 Jul 2024 10:49:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7265B2D31A; Tue,  9 Jul 2024 10:49:36 +0200 (CEST)
Date: Tue, 9 Jul 2024 10:49:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alexey Kardashevskiy <aik@amd.com>
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
	David Box <david.e.box@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Li, Ming" <ming4.li@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
	Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Eric Biggers <ebiggers@google.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 07/18] spdm: Introduce library to authenticate devices
Message-ID: <Zoz5oHx8HxYLTftQ@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
 <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
 <26715537-5dc4-46c1-bdcd-c760696dd418@amd.com>
 <Zovha33CS76PwAMF@wunner.de>
 <ad7b3e48-2e61-476f-8fea-28424f46d306@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7b3e48-2e61-476f-8fea-28424f46d306@amd.com>

On Tue, Jul 09, 2024 at 10:45:27AM +1000, Alexey Kardashevskiy wrote:
> On 8/7/24 22:54, Lukas Wunner wrote:
> > The short answer is, it's a bug in libspdm and the issue should
> > go away once you update libspdm to version 3.1.0 or newer.
> 
> Easier to hack lib/spdm/req-authenticate.c just to see how far I can get
> with my device, now it is "Malformed certificate at slot 0 offset 0".

In that case all (up to 8) certificate chains should have been retrieved
and are available for examination in the certificates/ directory in sysfs
(below the PCI device's directory).

You can use ordinary openssl tooling to examine the certificates and
see what's wrong with them, see the ABI documentation in patch [12/18]
for examples:

https://lore.kernel.org/all/e42905e3e5f1d5be39355e833fefc349acb0b03c.1719771133.git.lukas@wunner.de/

The "Malformed certificate at slot 0 offset 0" message means that the
first certificate in the chain in slot 0 does not comply with
requirements set forth in the SPDM spec.  (E.g. Basic Constraints CA
value shall be false for leaf cert, true for intermediate and root certs
per SPDM 1.3.0 table 42.)

The expectation is that vendors will test their devices and fix issues
like this, so that end users never see those messages.

The error message is emitted by spdm_validate_cert_chain().
The implementation calls that to identify a certificate chain which is
considered valid by the kernel.  The first one found is used for
challenge-response authentication.  If none is found valid, the kernel
will try to perform challenge-response authentication with the first
*provisioned* slot, regardless of its validity.  That is done to
expose a signature in sysfs about which user space can make up its
own mind, see patch [17/18]:

https://lore.kernel.org/all/dff8bcb091a3123e1c7c685f8149595e39bbdb8f.1719771133.git.lukas@wunner.de/

So despite the error message you should see a signature with full SPDM
transcript and other ancillary data in the signatures/ directory in sysfs.

Not sure yet whether that feature (exposing a signature despite
cert chains' invalidity from the kernel POV) makes sense.
We can also discuss adding ABI which allows user space to force
challenge-response with a specific slot, or to declare a specific
slot valid.

Thanks,

Lukas

