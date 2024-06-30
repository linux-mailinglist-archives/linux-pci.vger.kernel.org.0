Return-Path: <linux-pci+bounces-9488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3EC91D459
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 00:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CDA2812C6
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB464F215;
	Sun, 30 Jun 2024 22:11:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from norbury.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009D3C6AC;
	Sun, 30 Jun 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.24.177.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719785476; cv=none; b=ZwZfTyzs82xWn39jP0Ecz7GaX1gEUud/MnKLRWEPq+TcJgHeRXARIDnEp1obrG7r/QI7sa1Y/+Vj6uv77K6Ak5qD9Hz+52JkTxN1Mua3xVwMe9y9OfDpb84xYN9TG1tC3rfYh6TAPOw4PnyHzHEG5sF/GalIrTMHlGWAnCcA76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719785476; c=relaxed/simple;
	bh=tX6dUOvHGO9gAzRiumYdZMpZA1MkYOpepNhn6QftJI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csN5oZ7pQXwvMkdEdx9iYsUStSQVQB//JfxWBykBkHB7gaMyjXBzseERj6d3EKpw3Dgfd1NRghmZtTPiZne8H20fgW84i0c+38pEovbD8L32io1/gQvaxG9vxpquL7dB2pP0uJpElkpyG7xY+/Wfpdu7NXtq16HVE0J6SA9EdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=216.24.177.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sO2kR-004qfe-1k;
	Mon, 01 Jul 2024 08:10:16 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 01 Jul 2024 08:10:16 +1000
Date: Mon, 1 Jul 2024 08:10:16 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lukas Wunner <lukas@wunner.de>
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
Message-ID: <ZoHXyGwRzVvYkcTP@gondor.apana.org.au>
References: <cover.1719771133.git.lukas@wunner.de>
 <d143bb81c65064654af926317f69e6578cf0cdb9.1719771133.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d143bb81c65064654af926317f69e6578cf0cdb9.1719771133.git.lukas@wunner.de>

On Sun, Jun 30, 2024 at 09:41:00PM +0200, Lukas Wunner wrote:
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 258fffbf623d..8d412dec917f 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -139,6 +139,7 @@ static int ecdsa_verify(struct akcipher_request *req)
>  	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
>  	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
>  	size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
> +	size_t keylen = DIV_ROUND_UP(ctx->curve->nbits, 8);
>  	struct ecdsa_signature_ctx sig_ctx = {
>  		.curve = ctx->curve,
>  	};
> @@ -159,10 +160,21 @@ static int ecdsa_verify(struct akcipher_request *req)
>  		sg_nents_for_len(req->src, req->src_len + req->dst_len),
>  		buffer, req->src_len + req->dst_len, 0);
>  
> -	ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx,
> -			       buffer, req->src_len);
> -	if (ret < 0)
> +	if (strcmp(req->enc, "x962") == 0) {
> +		ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx,
> +				       buffer, req->src_len);
> +		if (ret < 0)
> +			goto error;
> +	} else if (strcmp(req->enc, "p1363") == 0 &&
> +		   req->src_len == 2 * keylen) {
> +		ecc_digits_from_bytes(buffer, keylen, sig_ctx.r,
> +				      ctx->curve->g.ndigits);
> +		ecc_digits_from_bytes(&buffer[keylen], keylen, sig_ctx.s,
> +				      ctx->curve->g.ndigits);
> +	} else {
> +		ret = -EINVAL;
>  		goto error;
> +	}

This should be implemented as a template.  Change ecdsa to use a
"raw" encoding for r/s and then implement x962 and p1363 as templates
which converts their respective encodings to the raw one.  You
would then use "x962(ecdsa-nist-XXX)" or "p1363(ecdsa-nist-XXX)"
to pick the encoding.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

