Return-Path: <linux-pci+bounces-33182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08961B16245
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195FF5A49F4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927022D97B8;
	Wed, 30 Jul 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KtYoQVQp"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036522D613;
	Wed, 30 Jul 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884495; cv=none; b=A4W6EseVDE0KIWsY/cEAAfpYwSuBY55guBszEO3Zyll/bfYSbKGeFSCjL/WHr5TRJvUzz1yV7a9t3m6fUy84OemKZnsjFzicgUOr6xjgIZsLr5kUa78hFRk18necbVd6su9YBuaTfk2/p6BP/aS+Ctobuz4lA6ZeR6KtXrl5uQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884495; c=relaxed/simple;
	bh=4qN06aYWqCdevnRv228fo/mJknOx9jK0nGnVGme8AU0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmODqZhr38kK2JNtUMY40JuZauQ3VAbJck+GwPHtUxjVARN/zQaRopDMBAAIlngIeCF/H1km9zlw2B+8ZWLaYksoHjUVcXprIDuPO1wcSuUuZdR57y6hDFKWSdUfLfIMWCX9/evIIKp2Z5I/DCsg4xijCg9sUZiTG4EtDfpRBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KtYoQVQp; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aLFaj0S7+lXxci0zlPE1kg+B8n4wPOWKZLFrdpCey7c=;
	b=KtYoQVQpQ2yqgCuHlf3A29CwczNfKwuio5CcHgG2FzmcfI4/vjLAtP4BZCX4SCDJfxabwKb+S
	/PhpuFsDWqe+u7/HA2grrOdYL8gLvx7HKaGqnBSB0j8WTrRdUStCKDgKLNrfe3z7KzwU1EPehrv
	ayYIYTT23GNfIzhmuIq2ZjE=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4bsYsy46v3z1vp9X;
	Wed, 30 Jul 2025 22:06:30 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsYsV60YGz6L52h;
	Wed, 30 Jul 2025 22:06:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B7E361401DC;
	Wed, 30 Jul 2025 22:08:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:08:01 +0200
Date: Wed, 30 Jul 2025 15:08:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 19/38] coco: host: arm64: set_pubkey support
Message-ID: <20250730150800.0000246c@huawei.com>
In-Reply-To: <20250728135216.48084-20-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-20-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:21:56 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Add changes to share the device's public key with the RMM.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

A few minor comments inline.

> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
> index ec8c5bfcee35..3715e6d58c83 100644
> --- a/drivers/virt/coco/arm-cca-host/rmm-da.c
> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
> @@ -6,6 +6,9 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
>  #include <asm/rmi_cmds.h>
> +#include <crypto/internal/rsa.h>
> +#include <keys/asymmetric-type.h>
> +#include <keys/x509-parser.h>
>  
>  #include "rmm-da.h"
>  
> @@ -311,6 +314,136 @@ static int do_pdev_communicate(struct pci_tsm *tsm, int target_state)
>  	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state);
>  }
>  
> +static int parse_certificate_chain(struct pci_tsm *tsm)
> +{
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +	unsigned int chain_size;
> +	unsigned int offset = 0;
> +	u8 *chain_data;
> +	int ret = 0;
> +
> +	dsc_pf0 = to_cca_dsc_pf0(tsm->pdev);
> +	chain_size = dsc_pf0->cert_chain.cache.size;
> +	chain_data = dsc_pf0->cert_chain.cache.buf;
> +
> +	while (offset < chain_size) {
> +		unsigned int cert_len =
> +			x509_get_certificate_length(chain_data + offset,
> +						    chain_size - offset);
> +		struct x509_certificate *cert =
> +			x509_cert_parse(chain_data + offset, cert_len);
> +
> +		if (IS_ERR(cert)) {
> +			pr_warn("%s(): parsing of certificate chain not successful\n", __func__);
> +			ret = PTR_ERR(cert);

Direct return looks fine here.  Maybe add a DEFINE_FREE(x509_cert,...)
as then can use direct returns throughout.


> +			break;
> +		}
> +
> +		if (offset + cert_len == chain_size) {
> +			dsc_pf0->cert_chain.public_key = kzalloc(cert->pub->keylen, GFP_KERNEL);
> +			if (!dsc_pf0->cert_chain.public_key) {
> +				ret = -ENOMEM;
> +				x509_free_certificate(cert);
> +				break;
> +			}
> +
> +			if (!strcmp("ecdsa-nist-p256", cert->pub->pkey_algo)) {
> +				dsc_pf0->rmi_signature_algorithm = RMI_SIG_ECDSA_P256;
> +			} else if (!strcmp("ecdsa-nist-p384", cert->pub->pkey_algo)) {
> +				dsc_pf0->rmi_signature_algorithm = RMI_SIG_ECDSA_P384;
> +			} else if (!strcmp("rsa", cert->pub->pkey_algo)) {
> +				dsc_pf0->rmi_signature_algorithm = RMI_SIG_RSASSA_3072;
> +			} else {
> +				ret = -ENXIO;
> +				x509_free_certificate(cert);
> +				break;
> +			}
> +			memcpy(dsc_pf0->cert_chain.public_key, cert->pub->key, cert->pub->keylen);
> +			dsc_pf0->cert_chain.public_key_size = cert->pub->keylen;
> +		}
> +
> +		x509_free_certificate(cert);
> +
> +		offset += cert_len;
> +	}
> +
> +	if (ret == 0)
> +		dsc_pf0->cert_chain.valid = true;
	if (ret)
		return ret;

	dsc_pf0->cert_chain.valid = true;

	return 0;

would be my preference for style here but others may disagree.
> +
> +	return ret;
> +}
> +
> +static int pdev_set_public_key(struct pci_tsm *tsm)
> +{
> +	struct rmi_public_key_params *key_shared;
> +	unsigned long expected_key_len = 0;

Don't set this. It's only used in places where it is explicitly set and
if it is used anywhere else we want the compiler to tell us.

> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +	int ret;
> +
> +	dsc_pf0 = to_cca_dsc_pf0(tsm->pdev);
> +	/* Check that all the necessary information was captured from communication */
> +	if (!dsc_pf0->cert_chain.valid)
> +		return -EINVAL;
> +
> +	key_shared = (struct rmi_public_key_params *)get_zeroed_page(GFP_KERNEL);
> +	if (!key_shared)
> +		return -ENOMEM;
> +
> +	key_shared->rmi_signature_algorithm = dsc_pf0->rmi_signature_algorithm;
> +
> +	switch (key_shared->rmi_signature_algorithm) {
> +	case RMI_SIG_ECDSA_P384:
> +		expected_key_len = 97;
> +
> +		if (dsc_pf0->cert_chain.public_key_size != expected_key_len)
> +			return -EINVAL;
> +		key_shared->public_key_len = dsc_pf0->cert_chain.public_key_size;
> +		memcpy(key_shared->public_key,
> +		       dsc_pf0->cert_chain.public_key,
> +		       dsc_pf0->cert_chain.public_key_size);
> +		key_shared->metadata_len = 0;
> +		break;
> +	case RMI_SIG_ECDSA_P256:
> +		expected_key_len = 65;
> +
> +		if (dsc_pf0->cert_chain.public_key_size != expected_key_len)
> +			return -EINVAL;
> +		key_shared->public_key_len = dsc_pf0->cert_chain.public_key_size;
> +		memcpy(key_shared->public_key,
> +		       dsc_pf0->cert_chain.public_key,
> +		       dsc_pf0->cert_chain.public_key_size);
> +		key_shared->metadata_len = 0;
> +		break;
> +	case RMI_SIG_RSASSA_3072:
> +		expected_key_len = 385;
> +		struct rsa_key rsa_key = {0};

Shouldn't define this inline.  Maybe move up a line and add some {}
to set the scope to this case statement.

> +		int ret_rsa_parse = rsa_parse_pub_key(&rsa_key,
> +						      dsc_pf0->cert_chain.public_key,
> +						      dsc_pf0->cert_chain.public_key_size);
> +		/* This also checks the key_len */
> +		if (ret_rsa_parse)
> +			return ret_rsa_parse;
> +		/*
> +		 * exponent is usally 65537 (size = 24bits) but in rare cases
> +		 * it size can be as large as the modulus
> +		 */
> +		if (rsa_key.e_sz > expected_key_len)
> +			return -EINVAL;
> +		key_shared->public_key_len = rsa_key.n_sz;
> +		key_shared->metadata_len = rsa_key.e_sz;
> +		memcpy(key_shared->public_key, (unsigned char *)rsa_key.n, rsa_key.n_sz);

Why is the cast needed?


> +		memcpy(key_shared->metadata, (unsigned char *)rsa_key.e, rsa_key.e_sz);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = rmi_pdev_set_pubkey(virt_to_phys(dsc_pf0->rmm_pdev),
> +				  virt_to_phys(key_shared));
> +	free_page((unsigned long)key_shared);
> +	return ret;
> +}




