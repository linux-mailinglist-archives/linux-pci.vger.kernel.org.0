Return-Path: <linux-pci+bounces-10970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9962293F83A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75D91C2206A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402F3187877;
	Mon, 29 Jul 2024 14:27:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29B187860;
	Mon, 29 Jul 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263278; cv=none; b=me+RYxMksE3VORYmHzJYa2A0hmsM7+Q0ywFgahuYKUiPTOZnQULgPkqBDqFQzFWnnj0X4CW5nWjV0J+pLXeGOzB0O4+Y4T0HQ4xsy69EcWDM4LwAVvzcNcb5FSjKR+egh3HThxQFkRxAbCm47UPkz3JCLSAs73KGf4RikilWJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263278; c=relaxed/simple;
	bh=vDORW42DYLZQwaRz1JRe/4e0oi7EknicdwRepT7tAko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSiGP4CiPCbLRVJm64TjTMsGniScpZMKIu/Rj6SMWzrtNZUUZkT5Y9J0167ilTA/htbQHFBN94819haT2CWhXJLBd70hlNaJlgSwI4tPVRaIkWdAvXVzizvkZoLGgitmqu9DIEThEpMhALPuJ2OhYiXAgXteb8QH6AK29IyK+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 921723000008D;
	Mon, 29 Jul 2024 16:27:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7C259357A59; Mon, 29 Jul 2024 16:27:47 +0200 (CEST)
Date: Mon, 29 Jul 2024 16:27:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>,
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
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
	Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Eric Biggers <ebiggers@google.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 06/18] crypto: ecdsa - Support P1363 signature encoding
Message-ID: <Zqem48z_qluJSI6j@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
 <d143bb81c65064654af926317f69e6578cf0cdb9.1719771133.git.lukas@wunner.de>
 <ZoHXyGwRzVvYkcTP@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoHXyGwRzVvYkcTP@gondor.apana.org.au>

On Mon, Jul 01, 2024 at 08:10:16AM +1000, Herbert Xu wrote:
> This should be implemented as a template.  Change ecdsa to use a
> "raw" encoding for r/s and then implement x962 and p1363 as templates
> which converts their respective encodings to the raw one.  You
> would then use "x962(ecdsa-nist-XXX)" or "p1363(ecdsa-nist-XXX)"
> to pick the encoding.

Understood, thank you for pointing me in the right direction.

I've just submitted a separate series for templatizing ecdsa
signature decoding:

https://lore.kernel.org/r/cover.1722260176.git.lukas@wunner.de/

Please let me know if this is what you had in mind.

Thanks!

Lukas

