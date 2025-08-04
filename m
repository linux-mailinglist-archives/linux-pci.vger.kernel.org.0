Return-Path: <linux-pci+bounces-33343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B14B19ABD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 06:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67277A3DE2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 04:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD81ADC7E;
	Mon,  4 Aug 2025 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfgKrFeX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9322259F;
	Mon,  4 Aug 2025 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754281804; cv=none; b=H4t6OFJagacDlbQSJRJSXru/BwwQW84V/KWR9hAPhBE78m6o7TQOVFIoGfWUGNu0boEWw7/TsDjseIeiiBlWKRFdo172q7Gq/oxFqQZJUhjEsyqwvH1Qxoy9TqakOGLeslJbtSjQtVguqmfaDvlaq6lgtY03OMwmo30s+8YJgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754281804; c=relaxed/simple;
	bh=IGSh0oJgi2WZV5bDKKJ/1KF8tFT3gDnsr/BIyaICoew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RsjnFkSk4TYodtHUCXkxgvmI+UeXLi9H7KEZEZzNT+D3rxkXr45X1EPhXpOqw6sGMIh0G5w8qU0llj+GZ9pqeq1R4VrrrsrxjO0v1u/GwcAF/Qvza3pA1T+FhISR4KiEyRZy+obJ0P3lcklnQojXCEhtDY85dDdyQsuNDsmsqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfgKrFeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1A6C4CEE7;
	Mon,  4 Aug 2025 04:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754281803;
	bh=IGSh0oJgi2WZV5bDKKJ/1KF8tFT3gDnsr/BIyaICoew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MfgKrFeX0TeYdhdft6l+RtBiUmJPDSyBEb8h+ac06xFoLYNHxBCZu86b/W9KGViyz
	 ptdslEtPWmI/NT1LszZDmaefsiOOMnMXff1L6NIi3kjc79cFM5Dax8zqfT0SwHPJmo
	 tmEEEmyOnWeg1SsFetoV08W0HZL600gVlP/SOfsZu6/DIPWEsCEXN0PxM9uZVxD8Ie
	 N/VdvCc5lMsT+LjbIQFG0kpOMufNIDRS1B0/gsHucgWQ8D496JpPTfmtiEcOCqIc05
	 sLRhNMzjoO6XJxQimJ4Tki7/Uqf+Pvy8N2Tgj0mRoxYetxPz9qK9lvapEuPvlEuyuJ
	 yJiiEhFPi0l4A==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 19/38] coco: host: arm64: set_pubkey support
In-Reply-To: <20250730150800.0000246c@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-20-aneesh.kumar@kernel.org>
 <20250730150800.0000246c@huawei.com>
Date: Mon, 04 Aug 2025 09:59:57 +0530
Message-ID: <yq5azfcf90ai.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Mon, 28 Jul 2025 19:21:56 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Add changes to share the device's public key with the RMM.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> A few minor comments inline.
>
>> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
>> index ec8c5bfcee35..3715e6d58c83 100644
>> --- a/drivers/virt/coco/arm-cca-host/rmm-da.c
>> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
>> @@ -6,6 +6,9 @@
>>  #include <linux/pci.h>
>>  #include <linux/pci-ecam.h>
>>  #include <asm/rmi_cmds.h>
>> +#include <crypto/internal/rsa.h>
>> +#include <keys/asymmetric-type.h>
>> +#include <keys/x509-parser.h>
>>  
>>  #include "rmm-da.h"
>>  
>> @@ -311,6 +314,136 @@ static int do_pdev_communicate(struct pci_tsm *tsm, int target_state)
>>  	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state);
>>  }
>>  
>> +static int parse_certificate_chain(struct pci_tsm *tsm)
>> +{
>> +	struct cca_host_dsc_pf0 *dsc_pf0;
>> +	unsigned int chain_size;
>> +	unsigned int offset = 0;
>> +	u8 *chain_data;
>> +	int ret = 0;
>> +
>> +	dsc_pf0 = to_cca_dsc_pf0(tsm->pdev);
>> +	chain_size = dsc_pf0->cert_chain.cache.size;
>> +	chain_data = dsc_pf0->cert_chain.cache.buf;
>> +
>> +	while (offset < chain_size) {
>> +		unsigned int cert_len =
>> +			x509_get_certificate_length(chain_data + offset,
>> +						    chain_size - offset);
>> +		struct x509_certificate *cert =
>> +			x509_cert_parse(chain_data + offset, cert_len);
>> +
>> +		if (IS_ERR(cert)) {
>> +			pr_warn("%s(): parsing of certificate chain not successful\n", __func__);
>> +			ret = PTR_ERR(cert);
>
> Direct return looks fine here.  Maybe add a DEFINE_FREE(x509_cert,...)
> as then can use direct returns throughout.
>
>
>> +			break;
>> +		}
>> +
>> +		if (offset + cert_len == chain_size) {
>> +			dsc_pf0->cert_chain.public_key = kzalloc(cert->pub->keylen, GFP_KERNEL);
>> +			if (!dsc_pf0->cert_chain.public_key) {
>> +				ret = -ENOMEM;
>> +				x509_free_certificate(cert);
>> +				break;
>> +			}
>> +
>> +			if (!strcmp("ecdsa-nist-p256", cert->pub->pkey_algo)) {
>> +				dsc_pf0->rmi_signature_algorithm = RMI_SIG_ECDSA_P256;
>> +			} else if (!strcmp("ecdsa-nist-p384", cert->pub->pkey_algo)) {
>> +				dsc_pf0->rmi_signature_algorithm = RMI_SIG_ECDSA_P384;
>> +			} else if (!strcmp("rsa", cert->pub->pkey_algo)) {
>> +				dsc_pf0->rmi_signature_algorithm = RMI_SIG_RSASSA_3072;
>> +			} else {
>> +				ret = -ENXIO;
>> +				x509_free_certificate(cert);
>> +				break;
>> +			}
>> +			memcpy(dsc_pf0->cert_chain.public_key, cert->pub->key, cert->pub->keylen);
>> +			dsc_pf0->cert_chain.public_key_size = cert->pub->keylen;
>> +		}
>> +
>> +		x509_free_certificate(cert);
>> +
>> +		offset += cert_len;
>> +	}
>> +
>> +	if (ret == 0)
>> +		dsc_pf0->cert_chain.valid = true;
> 	if (ret)
> 		return ret;
>
> 	dsc_pf0->cert_chain.valid = true;
>
> 	return 0;
>
> would be my preference for style here but others may disagree.
>> +
>> +	return ret;
>> +}
>> +
>> +static int pdev_set_public_key(struct pci_tsm *tsm)
>> +{
>> +	struct rmi_public_key_params *key_shared;
>> +	unsigned long expected_key_len = 0;
>
> Don't set this. It's only used in places where it is explicitly set and
> if it is used anywhere else we want the compiler to tell us.
>
>> +	struct cca_host_dsc_pf0 *dsc_pf0;
>> +	int ret;
>> +
>> +	dsc_pf0 = to_cca_dsc_pf0(tsm->pdev);
>> +	/* Check that all the necessary information was captured from communication */
>> +	if (!dsc_pf0->cert_chain.valid)
>> +		return -EINVAL;
>> +
>> +	key_shared = (struct rmi_public_key_params *)get_zeroed_page(GFP_KERNEL);
>> +	if (!key_shared)
>> +		return -ENOMEM;
>> +
>> +	key_shared->rmi_signature_algorithm = dsc_pf0->rmi_signature_algorithm;
>> +
>> +	switch (key_shared->rmi_signature_algorithm) {
>> +	case RMI_SIG_ECDSA_P384:
>> +		expected_key_len = 97;
>> +
>> +		if (dsc_pf0->cert_chain.public_key_size != expected_key_len)
>> +			return -EINVAL;
>> +		key_shared->public_key_len = dsc_pf0->cert_chain.public_key_size;
>> +		memcpy(key_shared->public_key,
>> +		       dsc_pf0->cert_chain.public_key,
>> +		       dsc_pf0->cert_chain.public_key_size);
>> +		key_shared->metadata_len = 0;
>> +		break;
>> +	case RMI_SIG_ECDSA_P256:
>> +		expected_key_len = 65;
>> +
>> +		if (dsc_pf0->cert_chain.public_key_size != expected_key_len)
>> +			return -EINVAL;
>> +		key_shared->public_key_len = dsc_pf0->cert_chain.public_key_size;
>> +		memcpy(key_shared->public_key,
>> +		       dsc_pf0->cert_chain.public_key,
>> +		       dsc_pf0->cert_chain.public_key_size);
>> +		key_shared->metadata_len = 0;
>> +		break;
>> +	case RMI_SIG_RSASSA_3072:
>> +		expected_key_len = 385;
>> +		struct rsa_key rsa_key = {0};
>
> Shouldn't define this inline.  Maybe move up a line and add some {}
> to set the scope to this case statement.
>
>> +		int ret_rsa_parse = rsa_parse_pub_key(&rsa_key,
>> +						      dsc_pf0->cert_chain.public_key,
>> +						      dsc_pf0->cert_chain.public_key_size);
>> +		/* This also checks the key_len */
>> +		if (ret_rsa_parse)
>> +			return ret_rsa_parse;
>> +		/*
>> +		 * exponent is usally 65537 (size = 24bits) but in rare cases
>> +		 * it size can be as large as the modulus
>> +		 */
>> +		if (rsa_key.e_sz > expected_key_len)
>> +			return -EINVAL;
>> +		key_shared->public_key_len = rsa_key.n_sz;
>> +		key_shared->metadata_len = rsa_key.e_sz;
>> +		memcpy(key_shared->public_key, (unsigned char *)rsa_key.n, rsa_key.n_sz);
>
> Why is the cast needed?
>
>
>> +		memcpy(key_shared->metadata, (unsigned char *)rsa_key.e, rsa_key.e_sz);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = rmi_pdev_set_pubkey(virt_to_phys(dsc_pf0->rmm_pdev),
>> +				  virt_to_phys(key_shared));
>> +	free_page((unsigned long)key_shared);
>> +	return ret;
>> +}

Thanks for the review comments. I'll update the patch with the suggested changes.

-aneesh

