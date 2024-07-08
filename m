Return-Path: <linux-pci+bounces-9927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554B92A34D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 14:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E355B2817C0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7CB84E13;
	Mon,  8 Jul 2024 12:54:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A510824A3;
	Mon,  8 Jul 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443250; cv=none; b=shzc//4TCz/ShNV6u7dDYnnfZQi0eTfdhyU2vHPO1jjKE6osdUkmG8MMV6pF8nkVbfNW+oUFbOGFputVHdE+lB1fdd28aVmzTi1W6rxFhHyxbGSgtUV4EmPgV8hqFucK8D8JappY5ykH+C3E4qpci/XcRoYa6qIMD0n2298yox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443250; c=relaxed/simple;
	bh=RMVniVhF/wGXXn+M2jkcQzFQemX/je9WFzpBwZlKox4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+BjmM2SSnPhmlmLfBHwEias06XK8wYKCGJJF/2Mht3gmXnQR1YwIRnwpWvSSMihrq25fcujlw7Iley1NUGKvU9qPrE/xoKiDj9rhgdPXKcYTlFMQ0l+IMCERF/I2wqK7MIMGqj4fbP+SX6UXq4EaVVP6NF2R2nJo24o+0/o+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 89319300000BD;
	Mon,  8 Jul 2024 14:54:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 713143512D; Mon,  8 Jul 2024 14:54:03 +0200 (CEST)
Date: Mon, 8 Jul 2024 14:54:03 +0200
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
Message-ID: <Zovha33CS76PwAMF@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
 <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
 <26715537-5dc4-46c1-bdcd-c760696dd418@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26715537-5dc4-46c1-bdcd-c760696dd418@amd.com>

On Mon, Jul 08, 2024 at 07:57:02PM +1000, Alexey Kardashevskiy wrote:
> > +	rc = spdm_exchange(spdm_state, req, req_sz, rsp, rsp_sz);
> 
> rsp_sz is 36 bytes here. And spdm_exchange() cannot return more than 36
> because this is how pci_doe() works...
> 
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	length = rc;
> > +	if (length < sizeof(*rsp) ||
> > +	    length < sizeof(*rsp) + rsp->param1 * sizeof(*req_alg_struct)) {
> > +		dev_err(spdm_state->dev, "Truncated algorithms response\n");
> 
> ... but here you expect more than 36 as realistically rsp->param1 > 0.
> How was this tested and what do I miss here?

I assume you tested this patch set against a libspdm responder
and got a "Truncated algorithms response" error.

The short answer is, it's a bug in libspdm and the issue should
go away once you update libspdm to version 3.1.0 or newer.

If you need to stay at an older version, consider cherry-picking
libspdm commits 941f0ae0d24e ("libspdm_rsp_algorithms: fixup spec
conformance") and 065fb17b74c7 ("responder: negotiate algorithms
conformance").

The bug was found and fixed by Wilfred Mallawa when testing the
in-kernel SPDM implementation against libspdm:

https://github.com/l1k/linux/issues/3
https://github.com/DMTF/libspdm/pull/2341
https://github.com/DMTF/libspdm/issues/2344
https://github.com/DMTF/libspdm/pull/2353

Problem is, most SPDM-enabled products right now are based on
libspdm (the DMTF reference implementation) and thus are bug-by-bug
compatible.  However such a software monoculture is dangerous and
having a from-scratch kernel implementation has already proven useful
to identify issues like this which otherwise wouldn't have been noticed.

The in-kernel SPDM implementation currently doesn't send any
ReqAlgStructs and per the spec, the responder isn't supposed to
send any RespAlgStructs which the requester didn't ask for.
Yet libspdm always sent a hardcoded array of RespAlgStructs.

So the *reference* implementation wasn't conforming to the spec. :(

Thanks,

Lukas

