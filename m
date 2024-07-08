Return-Path: <linux-pci+bounces-9929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC8892A3BC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 15:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC8D1F22272
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF588120D;
	Mon,  8 Jul 2024 13:35:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC47E56B;
	Mon,  8 Jul 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445750; cv=none; b=HrnWaFkTVAzwdy9/K2YcJZkkvgFzUrV0al77r93WFa3j2dyTq7qTdBxVDZand2NShRrNOB4q+h7Y3Ot/xwbWpC1oivC0cspGYtwh4Ppci3gxbsVeYDRqmW4iIkmna51A7a4L90Q4RqlYNkSg+flpMpRgLjSPoyJBjzw2PPoZ42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445750; c=relaxed/simple;
	bh=wgD9a4DNK3P6VEZab1/0rPVhR9Z/fDFUP3wzihfV+GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNi7HA2B7uV2Z6A59Qy0yGCL5u8Pkzx3dyvUi/SqCTDQM3G26qqPoQDCyPCBafpz0qIvfQx38Y0BCNUbukSNOTTKk3qSgmXvJC45ju7TFDvUTPkN10MTneC/cV85R+UPWVh4r1pmE6K8MC91OFUXIso/4S3Z9ggkLOq9B+zOEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id F044A100D9438;
	Mon,  8 Jul 2024 15:35:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BF9321F5CA; Mon,  8 Jul 2024 15:35:39 +0200 (CEST)
Date: Mon, 8 Jul 2024 15:35:39 +0200
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
Message-ID: <ZovrK7GsDpOMp3Bz@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
 <2140c4e4-6df0-47c7-8301-c6eb70ada27d@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2140c4e4-6df0-47c7-8301-c6eb70ada27d@amd.com>

On Mon, Jul 08, 2024 at 07:47:51PM +1000, Alexey Kardashevskiy wrote:
> On 1/7/24 05:35, Lukas Wunner wrote:
> > PCI device authentication v2
> > 
> > Authenticate PCI devices with CMA-SPDM (PCIe r6.2 sec 6.31) and
> > expose the result in sysfs.
> 
> What is it based on?

This series is based on v6.10-rc1.

I also successfully cherry-picked the patches onto v6.10-rc6 and
linux-next 20240628 (no merge conflicts and no issues reported by 0-day).

Older kernels than v6.10-rc1 won't work because they're missing
ecdsa-nist-p521 support as well as a few preparatory sysfs patches
of mine that went into v6.10-rc1.


> I am using https://github.com/l1k/linux.git branch cma_v2 for now but wonder
> if that's the right one.

Yes that's fine.

There's now also a kernel.org repository with a testing branch:

https://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git/

Future maintenance of the SPDM library is intended to be happening
in that repo.  I assumed that Bjorn may not be keen on having to
deal with SPDM patches forever, so creating a dedicated repo seemed
to make sense.

Most patches in this series with a "PCI/CMA: " subject actually
only change very few lines in the PCI core.  The bulk of the changes
is in the SPDM library instead.  I used that subject merely to
highlight that at least an ack from Bjorn is required.  The only
patches containing PCI core changes to speak of are patches 8, 9, 10.

The devsec group (short for Device Security Alphabet Soup) currently
only contains the spdm.git repo.  Going forward, further repos may be
added below the devsec umbrella, such as tsm.git to deal with a
vendor-neutral interface between kernel and Trusted Security Module.

Thanks,

Lukas

