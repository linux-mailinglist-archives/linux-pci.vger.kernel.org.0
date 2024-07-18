Return-Path: <linux-pci+bounces-10497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03B934C29
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 13:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CECB20AC0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149FE12A14C;
	Thu, 18 Jul 2024 11:04:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA930639;
	Thu, 18 Jul 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300649; cv=none; b=cXkwow47dNvr4ONpyTZrfquEHlReOehQavtig+w9ja2m9mNjXhbTYp7V+5thH4RgSzOoJNGIhc614uqP3TCX4Aegta8RJYo7KBCwAqmWnfj7nKJaqlYyOimr5R2ZMjMPWuBaaWtzcBEwJxCzwYGwPyDlpfO80Yg5khXito1DPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300649; c=relaxed/simple;
	bh=I/0ZzAVCOebuM9O7BzGpCAsAC3hNWzhHlKZRe6qlOJM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atanbCL04G+BRkeMtyq/uQaQp7VdKEzJhUYFx32eHQmCCvrqmRob0fD4a37M3lBA/oPrtHb6f/dN++WfaF+qugLm780OY94XG2BsvgnuCPoZidop1Cx9rSXSNDJwIWiwpiQKxmKufKPlcWAuvVSZwVe3g8ZGdA2H3aYYNIK5J5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPqdr6yQwz6HJdS;
	Thu, 18 Jul 2024 19:02:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 09F28140593;
	Thu, 18 Jul 2024 19:04:02 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 12:04:01 +0100
Date: Thu, 18 Jul 2024 12:04:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>, David Box
	<david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, Sean Christopherson <seanjc@google.com>, "Alexander
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Eric Biggers
	<ebiggers@google.com>
Subject: Re: [PATCH v2 03/18] X.509: Move certificate length retrieval into
 new helper
Message-ID: <20240718120400.00006a70@Huawei.com>
In-Reply-To: <cf34e283103de55b07fcddcbe39b60ea32b6d891.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<cf34e283103de55b07fcddcbe39b60ea32b6d891.1719771133.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 21:38:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> The upcoming in-kernel SPDM library (Security Protocol and Data Model,
> https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
> ASN.1 DER-encoded X.509 certificates.
> 
> Such code already exists in x509_load_certificate_list(), so move it
> into a new helper for reuse by SPDM.
> 
> Export the helper so that SPDM can be tristate.  (Some upcoming users of
> the SPDM libray may be modular, such as SCSI and ATA.)
> 
> No functional change intended.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Rereading some of these early patches to try and get my head back into
what is going on here..

Passing comments inline, but given you are just moving the code
rather than writing it for the first time I don't mind keeping it as
things stand.

> ---
>  crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
>  include/keys/asymmetric-type.h       |  2 ++
>  2 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
> index a41741326998..25ff027fad1d 100644
> --- a/crypto/asymmetric_keys/x509_loader.c
> +++ b/crypto/asymmetric_keys/x509_loader.c
> @@ -4,28 +4,42 @@
>  #include <linux/key.h>
>  #include <keys/asymmetric-type.h>
>  
> +ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
> +{
> +	ssize_t plen;
> +
> +	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
> +	 * than 256 bytes in size.
> +	 */
> +	if (buflen < 4)
> +		return -EINVAL;
> +
> +	if (p[0] != 0x30 &&
> +	    p[1] != 0x82)

Not sure readability would be hurt significantly by putting that on one line.

> +		return -EINVAL;
> +
> +	plen = (p[2] << 8) | p[3];

get_unaligned_be16() perhaps

> +	plen += 4;
It's kind of obvious, but maybe a comment no why +4 would be good.
> +	if (plen > buflen)
> +		return -EINVAL;
> +
> +	return plen;
> +}
> +EXPORT_SYMBOL_GPL(x509_get_certificate_length);
> +
>  int x509_load_certificate_list(const u8 cert_list[],
>  			       const unsigned long list_size,
>  			       const struct key *keyring)
>  {
>  	key_ref_t key;
>  	const u8 *p, *end;
> -	size_t plen;
> +	ssize_t plen;
>  
>  	p = cert_list;
>  	end = p + list_size;
>  	while (p < end) {
> -		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
> -		 * than 256 bytes in size.
> -		 */
> -		if (end - p < 4)
> -			goto dodgy_cert;
> -		if (p[0] != 0x30 &&
> -		    p[1] != 0x82)
> -			goto dodgy_cert;
> -		plen = (p[2] << 8) | p[3];
> -		plen += 4;
> -		if (plen > end - p)
> +		plen = x509_get_certificate_length(p, end - p);
> +		if (plen < 0)
>  			goto dodgy_cert;
>  
>  		key = key_create_or_update(make_key_ref(keyring, 1),
> diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
> index 69a13e1e5b2e..e2af07fec3c6 100644
> --- a/include/keys/asymmetric-type.h
> +++ b/include/keys/asymmetric-type.h
> @@ -84,6 +84,8 @@ extern struct key *find_asymmetric_key(struct key *keyring,
>  				       const struct asymmetric_key_id *id_2,
>  				       bool partial);
>  
> +ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen);
> +
>  int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
>  			       const struct key *keyring);
>  


