Return-Path: <linux-pci+bounces-10505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D794D934F11
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 16:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AA71C2154F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6901422C7;
	Thu, 18 Jul 2024 14:24:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8E7407A;
	Thu, 18 Jul 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312693; cv=none; b=ZqPJo1hkXEOiM3xRagUyekqquyDRJ3yHhtKeqpyWsJP+5FKEkXQu/EZJ6E4UWnYqpACWAuGVndwzeL3GfzqQILeDJSLqcn45UNIeLB7MKl2dGosL6fm30A/Hut5TtrAjnOx4fzp8uzuzE+BcIzaSxLO7/i3UsnqTPTofiQGk12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312693; c=relaxed/simple;
	bh=nlsMejGA836WlBBQOekvxaImRN4sWufbDdkEujMEnuY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0rQsoSW0V/zdfNLtQLr0Phc6RRbnKKDZqBo5zq88GYE9CnAqiOaCfZQg0IsYvtwBwfYlSEW5gaMKOG/UnDDXyOHguxxg7VBE7cUaruW+1oqi789uVL5zZvSIaX1Ccz3xM468VuNL2Qo3Gc3apmTKBM0NQMqcyaLCnksaFd0fe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPw4Q51pLz6K96L;
	Thu, 18 Jul 2024 22:22:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 78E7C140B33;
	Thu, 18 Jul 2024 22:24:46 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 15:24:45 +0100
Date: Thu, 18 Jul 2024 15:24:44 +0100
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
	<ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 07/18] spdm: Introduce library to authenticate
 devices
Message-ID: <20240718152444.00000882@Huawei.com>
In-Reply-To: <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 21:42:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The Security Protocol and Data Model (SPDM) allows for device
> authentication, measurement, key exchange and encrypted sessions.
> 
> SPDM was conceived by the Distributed Management Task Force (DMTF).
> Its specification defines a request/response protocol spoken between
> host and attached devices over a variety of transports:
> 
>   https://www.dmtf.org/dsp/DSP0274
> 
> This implementation supports SPDM 1.0 through 1.3 (the latest version).
> It is designed to be transport-agnostic as the kernel already supports
> four different SPDM-capable transports:
> 
> * PCIe Data Object Exchange, which is a mailbox in PCI config space
>   (PCIe r6.2 sec 6.30, drivers/pci/doe.c)
> * Management Component Transport Protocol
>   (MCTP, Documentation/networking/mctp.rst)
> * TCP/IP (in draft stage)
>   https://www.dmtf.org/sites/default/files/standards/documents/DSP0287_1.0.0WIP99.pdf
> * SCSI and ATA (in draft stage)
>   "SECURITY PROTOCOL IN/OUT" and "TRUSTED SEND/RECEIVE" commands
> 
> Use cases for SPDM include, but are not limited to:
> 
> * PCIe Component Measurement and Authentication (PCIe r6.2 sec 6.31)
> * Compute Express Link (CXL r3.0 sec 14.11.6)
> * Open Compute Project (Attestation of System Components v1.0)
>   https://www.opencompute.org/documents/attestation-v1-0-20201104-pdf
> * Open Compute Project (Datacenter NVMe SSD Specification v2.0)
>   https://www.opencompute.org/documents/datacenter-nvme-ssd-specification-v2-0r21-pdf
> 
> The initial focus of this implementation is enabling PCIe CMA device
> authentication.  As such, only a subset of the SPDM specification is
> contained herein, namely the request/response sequence GET_VERSION,
> GET_CAPABILITIES, NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE
> and CHALLENGE.
> 
> This sequence first negotiates the SPDM protocol version, capabilities
> and algorithms with the device.  It then retrieves the up to eight
> certificate chains which may be provisioned on the device.  Finally it
> performs challenge-response authentication with the device using one of
> those eight certificate chains and the algorithms negotiated before.
> The challenge-response authentication comprises computing a hash over
> all exchanged messages to detect modification by a man-in-the-middle
> or media error.  The hash is then signed with the device's private key
> and the resulting signature is verified by the kernel using the device's
> public key from the certificate chain.  Nonces are included in the
> message sequence to protect against replay attacks.
> 
> A simple API is provided for subsystems wishing to authenticate devices:
> spdm_create(), spdm_authenticate() (can be called repeatedly for
> reauthentication) and spdm_destroy().  Certificates presented by devices
> are validated against an in-kernel keyring of trusted root certificates.
> A pointer to the keyring is passed to spdm_create().
> 
> The set of supported cryptographic algorithms is limited to those
> declared mandatory in PCIe r6.2 sec 6.31.3.  Adding more algorithms
> is straightforward as long as the crypto subsystem supports them.
> 
> Future commits will extend this implementation with support for
> measurement, key exchange and encrypted sessions.
> 
> So far, only the SPDM requester role is implemented.  Care was taken to
> allow for effortless addition of the responder role at a later stage.
> This could be needed for a PCIe host bridge operating in endpoint mode.
> The responder role will be able to reuse struct definitions and helpers
> such as spdm_create_combined_prefix().
> 
> Credits:  Jonathan wrote a proof-of-concept of this SPDM implementation.
> Lukas reworked it for upstream.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
They published a 1.3.1 since you sent this (1st July).

Given it happened to be the version I have to hand I'll review against
that.

A few minor things inline.


> diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
> new file mode 100644
> index 000000000000..51fdb88f519b
> --- /dev/null
> +++ b/lib/spdm/req-authenticate.c
> @@ -0,0 +1,704 @@


> +static int spdm_validate_cert_chain(struct spdm_state *spdm_state, u8 slot)
> +{
> +	struct x509_certificate *cert __free(x509_free_certificate) = NULL;
> +	struct x509_certificate *prev __free(x509_free_certificate) = NULL;
> +	size_t header_length, total_length;
> +	bool is_leaf_cert;
> +	size_t offset = 0;
> +	struct key *key;
> +	int rc, length;
> +	u8 *certs;
> +
> +	header_length = sizeof(struct spdm_cert_chain) + spdm_state->hash_len;
> +	total_length = spdm_state->slot_sz[slot] - header_length;
> +	certs = (u8 *)spdm_state->slot[slot] + header_length;
> +
> +	do {
> +		rc = x509_get_certificate_length(certs + offset,
> +						 total_length - offset);
> +		if (rc < 0) {
> +			dev_err(spdm_state->dev, "Invalid certificate length "
> +				"at slot %u offset %zu\n", slot, offset);
> +			return rc;
> +		}
> +
> +		length = rc;
> +		is_leaf_cert = offset + length == total_length;
> +
> +		cert = x509_cert_parse(certs + offset, length);
> +		if (IS_ERR(cert)) {
> +			dev_err(spdm_state->dev, "Certificate parse error %pe "
> +				"at slot %u offset %zu\n", cert, slot, offset);
> +			return PTR_ERR(cert);
> +		}
> +		if (cert->unsupported_sig) {
> +			dev_err(spdm_state->dev, "Unsupported signature "
> +				"at slot %u offset %zu\n", slot, offset);
> +			return -EKEYREJECTED;
> +		}
> +		if (cert->blacklisted)
> +			return -EKEYREJECTED;
> +
> +		/*
> +		 * Basic Constraints CA value shall be false for leaf cert,
> +		 * true for intermediate and root certs (SPDM 1.3.0 table 42).
> +		 * Key Usage bit for digital signature shall be set, except
> +		 * for GenericCert in slot > 0 (SPDM 1.3.0 margin no 354).
> +		 * KeyCertSign bit must be 0 for non-CA (RFC 5280 sec 4.2.1.9).
> +		 */
> +		if ((is_leaf_cert ==
> +		     test_bit(KEY_EFLAG_CA, &cert->pub->key_eflags)) ||
> +		    (is_leaf_cert && slot == 0 &&
> +		     !test_bit(KEY_EFLAG_DIGITALSIG, &cert->pub->key_eflags)) ||
> +		    (is_leaf_cert &&
> +		     test_bit(KEY_EFLAG_KEYCERTSIGN, &cert->pub->key_eflags))) {
> +			dev_err(spdm_state->dev, "Malformed certificate "
> +				"at slot %u offset %zu\n", slot, offset);
> +			return -EKEYREJECTED;
> +		}
> +
> +		if (!prev) {
> +			/* First cert in chain, check against root_keyring */
> +			key = find_asymmetric_key(spdm_state->root_keyring,
> +						  cert->sig->auth_ids[0],
> +						  cert->sig->auth_ids[1],
> +						  cert->sig->auth_ids[2],
> +						  false);
> +			if (IS_ERR(key)) {
> +				dev_info(spdm_state->dev, "Root certificate "
> +					 "of slot %u not found in %s "
> +					 "keyring: %s\n", slot,
> +					 spdm_state->root_keyring->description,
> +					 cert->issuer);
> +				return PTR_ERR(key);
> +			}
> +
> +			rc = verify_signature(key, cert->sig);
> +			key_put(key);
> +		} else {
> +			/* Subsequent cert in chain, check against previous */
> +			rc = public_key_verify_signature(prev->pub, cert->sig);
> +		}
> +
> +		if (rc) {
> +			dev_err(spdm_state->dev, "Signature validation error "
> +				"%d at slot %u offset %zu\n", rc, slot, offset);
> +			return rc;
> +		}
> +
> +		x509_free_certificate(prev);
> +		prev = cert;

I'd steal that pointer with no_free_ptr()

> +		cert = ERR_PTR(-ENOKEY);

I think this is clearer as NULL which you will get from no_free_ptr()


> +
> +		offset += length;
> +	} while (offset < total_length);
> +
> +	/* Steal pub pointer ahead of x509_free_certificate() */
> +	spdm_state->leaf_key = prev->pub;
> +	prev->pub = NULL;
> +
> +	return 0;
> +}
> +

> +/**
> + * spdm_challenge_rsp_sz() - Calculate CHALLENGE_AUTH response size
> + *
> + * @spdm_state: SPDM session state
> + * @rsp: CHALLENGE_AUTH response (optional)
> + *
> + * A CHALLENGE_AUTH response contains multiple variable-length fields
> + * as well as optional fields.  This helper eases calculating its size.
> + *
> + * If @rsp is %NULL, assume the maximum OpaqueDataLength of 1024 bytes
> + * (SPDM 1.0.0 table 21).  Otherwise read OpaqueDataLength from @rsp.
> + * OpaqueDataLength can only be > 0 for SPDM 1.0 and 1.1, as they lack
> + * the OtherParamsSupport field in the NEGOTIATE_ALGORITHMS request.
> + * For SPDM 1.2+, we do not offer any Opaque Data Formats in that field,
> + * which forces OpaqueDataLength to 0 (SPDM 1.2.0 margin no 261).
> + */
> +static size_t spdm_challenge_rsp_sz(struct spdm_state *spdm_state,
> +				    struct spdm_challenge_rsp *rsp)
> +{
> +	size_t  size  = sizeof(*rsp)		/* Header */
> +		      + spdm_state->hash_len	/* CertChainHash */
> +		      + SPDM_NONCE_SZ;		/* Nonce */
> +
> +	if (rsp)
> +		/* May be unaligned if hash algorithm has odd length */
> +		size += get_unaligned_le16((u8 *)rsp + size);
> +	else
> +		size += SPDM_MAX_OPAQUE_DATA;	/* OpaqueData */
> +
> +	size += 2;				/* OpaqueDataLength */
> +
> +	if (spdm_state->version >= 0x13)
> +		size += 8;			/* RequesterContext */
> +
> +	return  size  + spdm_state->sig_len;	/* Signature */

Odd spacing.  Personally I'd not bother trying to align things other
than maybe the comments.


> +}
> +
> +static int spdm_challenge(struct spdm_state *spdm_state, u8 slot)
> +{
> +	struct spdm_challenge_rsp *rsp __free(kfree);
> +	struct spdm_challenge_req req = {
> +		.code = SPDM_CHALLENGE,
> +		.param1 = slot,
> +		.param2 = 0, /* No measurement summary hash */
> +	};
> +	size_t req_sz, rsp_sz, rsp_sz_max;
> +	int rc, length;
> +
> +	get_random_bytes(&req.nonce, sizeof(req.nonce));
> +
> +	if (spdm_state->version <= 0x12)
> +		req_sz = offsetofend(typeof(req), nonce);
> +	else
> +		req_sz = sizeof(req);
> +
> +	rsp_sz_max = spdm_challenge_rsp_sz(spdm_state, NULL);
> +	rsp = kzalloc(rsp_sz_max, GFP_KERNEL);

Pull the declaration down here so we don't have fragility that
an error check might be added before here.
I'm lazy so not digging out the reference but Linus came down
clearly in favor of just using inline declarations to put the
constructor and destructor together.

> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	rc = spdm_exchange(spdm_state, &req, req_sz, rsp, rsp_sz_max);
> +	if (rc < 0)
> +		return rc;
> +
It's probably overly paranoid but we could check some fields in the
response such as the slot..

> +	length = rc;
> +	rsp_sz = spdm_challenge_rsp_sz(spdm_state, rsp);
> +	if (length < rsp_sz) {
> +		dev_err(spdm_state->dev, "Truncated challenge_auth response\n");
> +		return -EIO;
> +	}
> +
> +	rc = spdm_append_transcript(spdm_state, &req, req_sz);
> +	if (rc)
> +		return rc;
> +
> +	rc = spdm_append_transcript(spdm_state, rsp, rsp_sz);
> +	if (rc)
> +		return rc;
> +
> +	/* Verify signature at end of transcript against leaf key */
> +	rc = spdm_verify_signature(spdm_state, spdm_context);
> +	if (rc)
> +		dev_err(spdm_state->dev,
> +			"Cannot verify challenge_auth signature: %d\n", rc);
> +	else
> +		dev_info(spdm_state->dev,
> +			 "Authenticated with certificate slot %u\n", slot);
> +
> +	return rc;
> +}
> +
> +/**
> + * spdm_authenticate() - Authenticate device
> + *
> + * @spdm_state: SPDM session state
> + *
> + * Authenticate a device through a sequence of GET_VERSION, GET_CAPABILITIES,
> + * NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE and CHALLENGE exchanges.
> + *
> + * Perform internal locking to serialize multiple concurrent invocations.
> + * Can be called repeatedly for reauthentication.
> + *
> + * Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
> + * indicates authentication is not supported by the device.
> + */
> +int spdm_authenticate(struct spdm_state *spdm_state)
> +{
> +	u8 slot;
> +	int rc;
> +
> +	mutex_lock(&spdm_state->lock);
> +	spdm_reset(spdm_state);
> +
> +	rc = spdm_alloc_transcript(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_get_version(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_get_capabilities(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_negotiate_algs(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_get_digests(spdm_state);
> +	if (rc)
> +		goto unlock;
> +
> +	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS) {

I never understood if you were actually allowed to do this without starting
the whole set again. Is there an example of multiple cert requesting
in the spec?  I vaguely recall poking our specification folk on this and
they couldn't give a clear answer so suggested doing whole sequence again
so the transcript matches the ones in the spec.

Logically I'd like it to work this way (and I assume libspdm does) but
I'd really like a reference or other argument for why...
The GET_CERTIFICATE / GET_CERTIFICATE_RESPONSE can definitely be multiple
messages to deal with large cert chains, but can we start again with a new
slot and still have the transcript updated correctly?

> +		rc = spdm_get_certificate(spdm_state, slot);
> +		if (rc)
> +			goto unlock;
> +	}
> +
> +	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS) {
> +		rc = spdm_validate_cert_chain(spdm_state, slot);
> +		if (rc == 0)
> +			break;
> +	}
> +	if (rc)
> +		goto unlock;
> +
> +	rc = spdm_challenge(spdm_state, slot);
> +
> +unlock:
> +	if (rc)
> +		spdm_reset(spdm_state);
> +	spdm_state->authenticated = !rc;
> +	spdm_free_transcript(spdm_state);
> +	mutex_unlock(&spdm_state->lock);

Dan suggested a nice cleanup for this to avoid the
goto dance.

> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(spdm_authenticate);



> diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
> new file mode 100644
> index 000000000000..3a104959ad53
> --- /dev/null
> +++ b/lib/spdm/spdm.h
> @@ -0,0 +1,520 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMTF Security Protocol and Data Model (SPDM)
> + * https://www.dmtf.org/dsp/DSP0274
> + *
> + * Copyright (C) 2021-22 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022-24 Intel Corporation
> + */
> +
> +#ifndef _LIB_SPDM_H_
> +#define _LIB_SPDM_H_
> +
> +#undef  DEFAULT_SYMBOL_NAMESPACE
> +#define DEFAULT_SYMBOL_NAMESPACE SPDM
> +
> +#define dev_fmt(fmt) "SPDM: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/mutex.h>
> +#include <linux/spdm.h>
> +
> +/* SPDM versions supported by this implementation */
> +#define SPDM_MIN_VER 0x10
> +#define SPDM_MAX_VER 0x13
> +
> +/* SPDM capabilities (SPDM 1.1.0 margin no 177, 178) */
> +#define SPDM_CACHE_CAP			BIT(0)		/* 1.0 resp only */
> +#define SPDM_CERT_CAP			BIT(1)		/* 1.0 */
> +#define SPDM_CHAL_CAP			BIT(2)		/* 1.0 */
> +#define SPDM_MEAS_CAP_MASK		GENMASK(4, 3)	/* 1.0 resp only */
> +#define   SPDM_MEAS_CAP_NO		0		/* 1.0 resp only */
> +#define   SPDM_MEAS_CAP_MEAS		1		/* 1.0 resp only */
> +#define   SPDM_MEAS_CAP_MEAS_SIG	2		/* 1.0 resp only */
> +#define SPDM_MEAS_FRESH_CAP		BIT(5)		/* 1.0 resp only */
> +#define SPDM_ENCRYPT_CAP		BIT(6)		/* 1.1 */
> +#define SPDM_MAC_CAP			BIT(7)		/* 1.1 */
> +#define SPDM_MUT_AUTH_CAP		BIT(8)		/* 1.1 */
> +#define SPDM_KEY_EX_CAP			BIT(9)		/* 1.1 */
> +#define SPDM_PSK_CAP_MASK		GENMASK(11, 10)	/* 1.1 */
> +#define   SPDM_PSK_CAP_NO		0		/* 1.1 */
> +#define   SPDM_PSK_CAP_PSK		1		/* 1.1 */
> +#define   SPDM_PSK_CAP_PSK_CTX		2		/* 1.1 resp only */
> +#define SPDM_ENCAP_CAP			BIT(12)		/* 1.1 */
> +#define SPDM_HBEAT_CAP			BIT(13)		/* 1.1 */
> +#define SPDM_KEY_UPD_CAP		BIT(14)		/* 1.1 */
> +#define SPDM_HANDSHAKE_ITC_CAP		BIT(15)		/* 1.1 */
> +#define SPDM_PUB_KEY_ID_CAP		BIT(16)		/* 1.1 */
> +#define SPDM_CHUNK_CAP			BIT(17)		/* 1.2 */
> +#define SPDM_ALIAS_CERT_CAP		BIT(18)		/* 1.2 resp only */
> +#define SPDM_SET_CERT_CAP		BIT(19)		/* 1.2 resp only */
> +#define SPDM_CSR_CAP			BIT(20)		/* 1.2 resp only */
> +#define SPDM_CERT_INST_RESET_CAP	BIT(21)		/* 1.2 resp only */

Some of these 1.2 only entries are non obvious from the 1.3.1 spec.
This one for instance is in the change log as a 1.3.0 addition

> +#define SPDM_EP_INFO_CAP_MASK		GENMASK(23, 22) /* 1.3 */
> +#define   SPDM_EP_INFO_CAP_NO		0		/* 1.3 */
> +#define   SPDM_EP_INFO_CAP_RSP		1		/* 1.3 */
> +#define   SPDM_EP_INFO_CAP_RSP_SIG	2		/* 1.3 */
> +#define SPDM_MEL_CAP			BIT(24)		/* 1.3 resp only */
> +#define SPDM_EVENT_CAP			BIT(25)		/* 1.3 */
> +#define SPDM_MULTI_KEY_CAP_MASK		GENMASK(27, 26)	/* 1.3 */
> +#define   SPDM_MULTI_KEY_CAP_NO		0		/* 1.3 */
> +#define   SPDM_MULTI_KEY_CAP_ONLY	1		/* 1.3 */
> +#define   SPDM_MULTI_KEY_CAP_SEL	2		/* 1.3 */
> +#define SPDM_GET_KEY_PAIR_INFO_CAP	BIT(28)		/* 1.3 resp only */
> +#define SPDM_SET_KEY_PAIR_INFO_CAP	BIT(29)		/* 1.3 resp only */


...

> +
> +#define SPDM_GET_CAPABILITIES 0xe1
> +#define SPDM_MIN_DATA_TRANSFER_SIZE 42 /* SPDM 1.2.0 margin no 226 */
> +
> +/*
> + * Newer SPDM versions insert fields at the end of messages (enlarging them)
> + * or use reserved space for new fields (leaving message size unchanged).
> + */
> +struct spdm_get_capabilities_req {
> +	u8 version;
> +	u8 code;
> +	u8 param1;
> +	u8 param2;
> +	/* End of SPDM 1.0 structure */
> +
> +	u8 reserved1;					/* 1.1 */
> +	u8 ctexponent;					/* 1.1 */
> +	u16 reserved2;					/* 1.1 */

Maybe should be consistent for resered fields in using u8 []
Doesn't matter much though.

> +	__le32 flags;					/* 1.1 */
> +	/* End of SPDM 1.1 structure */
> +
> +	__le32 data_transfer_size;			/* 1.2 */
> +	__le32 max_spdm_msg_size;			/* 1.2 */
> +} __packed;
> +
> +struct spdm_get_capabilities_rsp {
> +	u8 version;
> +	u8 code;
> +	u8 param1;
> +	u8 param2;
> +
> +	u8 reserved1;
> +	u8 ctexponent;
> +	u16 reserved2;

As above.

> +	__le32 flags;
> +	/* End of SPDM 1.0 structure */
> +
> +	__le32 data_transfer_size;			/* 1.2 */
> +	__le32 max_spdm_msg_size;			/* 1.2 */
> +	/* End of SPDM 1.2 structure */
> +
> +	/*
> +	 * Additional optional fields at end of this structure:
> +	 * - SupportedAlgorithms: variable size		 * 1.3 *
> +	 */
> +} __packed;
> +


> +#define SPDM_CHALLENGE 0x83
> +#define SPDM_NONCE_SZ 32 /* SPDM 1.0.0 table 20 */
> +#define SPDM_PREFIX_SZ 64 /* SPDM 1.2.0 margin no 803 */
> +#define SPDM_COMBINED_PREFIX_SZ 100 /* SPDM 1.2.0 margin no 806 */
> +#define SPDM_MAX_OPAQUE_DATA 1024 /* SPDM 1.0.0 table 21 */
> +
> +struct spdm_challenge_req {
> +	u8 version;
> +	u8 code;
> +	u8 param1; /* Slot number 0..7 */
> +	u8 param2; /* MeasurementSummaryHash type */
> +	u8 nonce[SPDM_NONCE_SZ];
> +	/* End of SPDM 1.2 (and earlier) structure */
> +
> +	u8 context[8];					/* 1.3 */
> +} __packed;
> +
> +struct spdm_challenge_rsp {
If we are matching the spec, oddly the response to a challenge request
is a challenge auth response.  Who knows why...

> +	u8 version;
> +	u8 code;
> +	u8 param1; /* Slot number 0..7 */

Do we want to add comment on Basic MutAuthrReq (deprecated) bit 7?
Might in theory bite us at somepoint.

> +	u8 param2; /* Slot mask */
> +	/*
> +	 * Additional fields at end of this structure:
> +	 * - CertChainHash: Hash of struct spdm_cert_chain for selected slot
> +	 * - Nonce: 32 bytes long
> +	 * - MeasurementSummaryHash: Optional hash of selected measurements
> +	 * - OpaqueDataLength: 2 bytes long
> +	 * - OpaqueData: Up to 1024 bytes long
> +	 * - RequesterContext: 8 bytes long		 * 1.3 *
> +	 *   (inserted, moves Signature field)
> +	 * - Signature
> +	 */
> +} __packed;
> +
> +#define SPDM_ERROR 0x7f

> +/**
> + * struct spdm_state - SPDM session state
> + *
> + * @dev: Responder device.  Used for error reporting and passed to @transport.
> + * @lock: Serializes multiple concurrent spdm_authenticate() calls.
> + * @authenticated: Whether device was authenticated successfully.
> + * @dev: Responder device.  Used for error reporting and passed to @transport.
Two dev entries.

Make sure to run the kernel-doc script over the files to catch these little
dos issues.

...

> + */
> +struct spdm_state {
> +	struct device *dev;
> +	struct mutex lock;
> +	unsigned int authenticated:1;



