Return-Path: <linux-pci+bounces-28580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D22AC7B3B
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C3E16DE0A
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414B26C397;
	Thu, 29 May 2025 09:40:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A820299B;
	Thu, 29 May 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511634; cv=none; b=kMx09N/rasm5oUJXlsmWNNs6BPqmWutQWmukDOwhUBXRinw25PIb1bDJd572OFShuV9N3TyRUmbc7fS1hGWo+ge1XY5DrCFWJKH/8RnLFztorJAF2ybAbThSg/RhkXl74k4quRj86iCXA/yDofS9P7o823I2fOwD+XGnn9so5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511634; c=relaxed/simple;
	bh=N2jkP1iEfBcx2MnZSi2BVAFp57oKiRPTxIoY88diJ+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny6V4EVeISCvX93lcnUGO9Q5NN1XUj3WzEMD8IQxtF2SNTXnexanKGCRub/l3nbXiWJjP18MHYAGArOtWYn66PPJhsHJtEDCvt1iLv5BpzUCQTj7uNbfqdouHXuePLOVdZH+QkQ5IJ7MUksiMRaojPHHnxTTtpMnfupTrK6toMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1579D2C000A8;
	Thu, 29 May 2025 11:40:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C87AC20BE58; Thu, 29 May 2025 11:40:21 +0200 (CEST)
Date: Thu, 29 May 2025 11:40:21 +0200
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
Message-ID: <aDgrhePailpBUMJU@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
 <2140c4e4-6df0-47c7-8301-c6eb70ada27d@amd.com>
 <ZovrK7GsDpOMp3Bz@wunner.de>
 <b1595ceb-a916-4ff0-97bd-1a223e0cef15@amd.com>
 <Z6zN8R-E9uJpkU7j@wunner.de>
 <dab69e0c-37c2-41f1-a9db-fe116fe4cbbd@amd.com>
 <91e2985f-0815-4918-b7cf-c593bc2fa96b@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e2985f-0815-4918-b7cf-c593bc2fa96b@amd.com>

On Thu, May 29, 2025 at 03:29:23PM +1000, Alexey Kardashevskiy wrote:
> On 20/5/25 18:35, Alexey Kardashevskiy wrote:
> > On 13/2/25 03:36, Lukas Wunner wrote:
> > > Please find a rebase of v2 on v6.14-rc2 on this branch:
> > > 
> > > https://github.com/l1k/linux/commits/doe
> > > 
> > > A portion of the crypto patches that were part of v2 have landed
> > > in v6.13. So the rebased version has shrunk.
> > > 
> > > There was a bit of fallout caused by the upstreamed crypto patches
> > > and dealing with that kept me occupied during the v6.13 cycle.
> > > However I'm now back working on the PCI/CMA patches,
> > 
> > Any luck with these? Asking as there is another respin
> > https://lore.kernel.org/r/20250516054732.2055093-1-dan.j.williams@intel.com
> > and it considers merge with yours. Thanks,
> 
> Ping?

I intend to push a new version to my repo after the merge window closes
and that'll use netlink multicast to convey signatures to userspace.

Thanks,

Lukas

