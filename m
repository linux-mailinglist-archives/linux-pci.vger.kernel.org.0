Return-Path: <linux-pci+bounces-21294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72225A32BF7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DC03AABD6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915E2586F3;
	Wed, 12 Feb 2025 16:36:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6625743C;
	Wed, 12 Feb 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378171; cv=none; b=i5FCg7lh0G8MvY5A4BvyK4FY6HMUeK9TTWAmOn6bDw1Y0/kx5NEfosty0MltGQdSdAr6r71peziqGoJmceVqDGLbM1l/qetoqpX8iGCHTlqzBaAM+Z8QqAhwZ8UlD9hG54LZKyP59+OU46YPzi6sMoM9v13RNMlgoPwxNhhddyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378171; c=relaxed/simple;
	bh=ozwS80Px8jgB+KR4DO9OSCcBIuaqE6z6a9AlLrJXX1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl6YH6OvlebB6L3X5HAa3CjLYXWxeRaASxdnIaRZab0O3n8jW7Q2HmSH11UhvHkwmdx2xDfF7Gymi5cS27623K8JfWIxJHzGKlhM65uY7fUSQENFg/QlfUQdjpBSdS1dkWxUml7yQl2oUwq6cKhBfP7G6yOjU/IBjQgUojmWdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5C348300135A1;
	Wed, 12 Feb 2025 17:36:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 452231B825A; Wed, 12 Feb 2025 17:36:01 +0100 (CET)
Date: Wed, 12 Feb 2025 17:36:01 +0100
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
	Stefan Berger <stefanb@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 00/18] PCI device authentication
Message-ID: <Z6zN8R-E9uJpkU7j@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
 <2140c4e4-6df0-47c7-8301-c6eb70ada27d@amd.com>
 <ZovrK7GsDpOMp3Bz@wunner.de>
 <b1595ceb-a916-4ff0-97bd-1a223e0cef15@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1595ceb-a916-4ff0-97bd-1a223e0cef15@amd.com>

On Tue, Feb 11, 2025 at 12:30:21PM +1100, Alexey Kardashevskiy wrote:
> > > On 1/7/24 05:35, Lukas Wunner wrote:
> > > > PCI device authentication v2
> > > > 
> > > > Authenticate PCI devices with CMA-SPDM (PCIe r6.2 sec 6.31) and
> > > > expose the result in sysfs.
> 
> Has any further development happened since then? I am asking as I have the
> CMA-v2 in my TSM exercise tree (to catch conflicts, etc) but I do not see
> any change in your github or kernel.org/devsec since v2 and that v2 does not
> merge nicely with the current upstream.

Please find a rebase of v2 on v6.14-rc2 on this branch:

https://github.com/l1k/linux/commits/doe

A portion of the crypto patches that were part of v2 have landed in v6.13.
So the rebased version has shrunk.

There was a bit of fallout caused by the upstreamed crypto patches
and dealing with that kept me occupied during the v6.13 cycle.
However I'm now back working on the PCI/CMA patches,
specifically the migration to netlink for retrieval of signatures
and measurements as discussed at Plumbers.

Thanks,

Lukas

