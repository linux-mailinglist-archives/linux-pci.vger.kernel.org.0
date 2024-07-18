Return-Path: <linux-pci+bounces-10522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A14B935041
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84D81F22DD7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B3B7E766;
	Thu, 18 Jul 2024 15:56:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6137144D09;
	Thu, 18 Jul 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318194; cv=none; b=W7gPPKRhTfgMa07DEAZkOQYTaZ8s/LvvCSZ91lsq+JKaxQQRbKt4TqHdTrbgsic+pkCZDNSQE1D36ty7aSkP2GjsGrODfwmX7+E/0urL+X2aSfrOYj20axhuJrBcyhqh0lOhOK+HNBvCFvdt4Agc+udk9gLObEYjHOqAH1mfkiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318194; c=relaxed/simple;
	bh=Lo4jqSKsydXxq6AsU34nSyXN5W6kwGKlU6z+Ewh5IsY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmP85QbQdxe8vA6d1kBoa2mRQe7t94QcsKt54mowKrtmSTppfMe5ilr7PL7mV5mjEa0OvZLkjblfznTpY6P+II1ZJ24qByiVBJEddK3kT2Szp+QoBFRd2lm4S+AgZoYcdgJgkPiXlsyw3XrJ4qNih4pMy43+K9B8FEpzuyBN+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPy6j5mh4z67NNP;
	Thu, 18 Jul 2024 23:54:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 26D4E140AE5;
	Thu, 18 Jul 2024 23:56:29 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 16:56:28 +0100
Date: Thu, 18 Jul 2024 16:56:27 +0100
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
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet
	<corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Alan
 Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 15/18] PCI/CMA: Expose a log of received signatures
 in sysfs
Message-ID: <20240718165627.000052bc@Huawei.com>
In-Reply-To: <77f549685f994981c010aebb1e9057aa3555b18a.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<77f549685f994981c010aebb1e9057aa3555b18a.1719771133.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 21:50:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> When authenticating a device with CMA-SPDM, the kernel verifies the
> challenge-response received from the device, but otherwise keeps it to
> itself.
>=20
> James Bottomley contends that's not good enough because user space or a
> remote attestation service may want to re-verify the challenge-response:
> Either because it mistrusts the kernel or because the kernel is unaware
> of policy constraints that user space or the remote attestation service
> want to apply.
>=20
> Facilitate such use cases by exposing a log in sysfs which consists of
> several files for each challenge-response event.  The files are prefixed
> with a monotonically increasing number, starting at 0:
>=20
> /sys/devices/.../signatures/0_signature
> /sys/devices/.../signatures/0_transcript
> /sys/devices/.../signatures/0_requester_nonce
> /sys/devices/.../signatures/0_responder_nonce
> /sys/devices/.../signatures/0_hash_algorithm
> /sys/devices/.../signatures/0_combined_spdm_prefix
> /sys/devices/.../signatures/0_certificate_chain
> /sys/devices/.../signatures/0_type
>=20
> The 0_signature is computed over the 0_transcript (a concatenation of
> all SPDM messages exchanged with the device).
>=20
> To verify the signature, 0_transcript is hashed with 0_hash_algorithm
> (e.g. "sha384") and prefixed by 0_combined_spdm_prefix.
>=20
> The public key to verify the signature against is the leaf certificate
> contained in 0_certificate_chain.
>=20
> The nonces chosen by requester and responder are exposed as separate
> attributes to ease verification of their freshness.  They're already
> contained in the transcript but their offsets within the transcript are
> variable, so user space would otherwise have to parse the SPDM messages
> in the transcript to find the nonces.
>=20
> The type attribute contains the event type:  Currently it is always
> "responder-challenge_auth signing".  In the future it may also contain
> "responder-measurements signing".
>=20
> This custom log format was chosen for lack of a better alternative.
> Although the TCG PFP Specification defines DEVICE_SECURITY_EVENT_DATA
> structures, those structures do not store the transcript (which can be
> a few kBytes or up to several MBytes in size).  They do store nonces,
> hence at least allow for verification of nonce freshness.  But without
> the transcript, user space cannot verify the signature:
>=20
> https://trustedcomputinggroup.org/resource/pc-client-specific-platform-fi=
rmware-profile-specification/
>=20
> Exposing the transcript as an attribute of its own has the benefit that
> it can directly be fed into a protocol dissector for debugging purposes
> (think Wireshark).
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: J=E9r=F4me Glisse <jglisse@google.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>

Nice - particularly the thorough ABI docs.  A few trivial comments inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +/**
> + * spdm_create_log_entry() - Allocate log entry for one received SPDM si=
gnature
> + *
> + * @spdm_state: SPDM session state
> + * @spdm_context: SPDM context (needed to create combined_spdm_prefix)
> + * @slot: Slot which was used to generate the signature
> + *	(needed to create certificate_chain symlink)
> + * @req_nonce_off: Requester nonce offset within the transcript
> + * @rsp_nonce_off: Responder nonce offset within the transcript
> + *
> + * Allocate and populate a struct spdm_log_entry upon device authenticat=
ion.
> + * Publish it in sysfs if the device has already been registered through
> + * device_add().
> + */
> +void spdm_create_log_entry(struct spdm_state *spdm_state,
> +			   const char *spdm_context, u8 slot,
> +			   size_t req_nonce_off, size_t rsp_nonce_off)
> +{
> +	struct spdm_log_entry *log =3D kmalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return;
> +
> +	*log =3D (struct spdm_log_entry) {
> +		.slot		   =3D slot,
> +		.version	   =3D spdm_state->version,
> +		.counter	   =3D spdm_state->log_counter,
> +		.list		   =3D LIST_HEAD_INIT(log->list),
> +
> +		.sig =3D {
> +			.attr.name =3D log->sig_name,
> +			.attr.mode =3D 0444,
> +			.read	   =3D sysfs_bin_attr_simple_read,
> +			.private   =3D spdm_state->transcript_end -
> +				     spdm_state->sig_len,
> +			.size	   =3D spdm_state->sig_len },

We might set other bin_attr callbacks sometime in future, so I would
add the trailing comma and move the }, to the next line for these.

> +
> +		.req_nonce =3D {
> +			.attr.name =3D log->req_nonce_name,
> +			.attr.mode =3D 0444,
> +			.read	   =3D sysfs_bin_attr_simple_read,
> +			.private   =3D spdm_state->transcript + req_nonce_off,
> +			.size	   =3D SPDM_NONCE_SZ },
> +
> +		.rsp_nonce =3D {
> +			.attr.name =3D log->rsp_nonce_name,
> +			.attr.mode =3D 0444,
> +			.read	   =3D sysfs_bin_attr_simple_read,
> +			.private   =3D spdm_state->transcript + rsp_nonce_off,
> +			.size	   =3D SPDM_NONCE_SZ },
> +
> +		.transcript =3D {
> +			.attr.name =3D log->transcript_name,
> +			.attr.mode =3D 0444,
> +			.read	   =3D sysfs_bin_attr_simple_read,
> +			.private   =3D spdm_state->transcript,
> +			.size	   =3D spdm_state->transcript_end -
> +				     spdm_state->transcript -
> +				     spdm_state->sig_len },
> +
> +		.combined_prefix =3D {
> +			.attr.name =3D log->combined_prefix_name,
> +			.attr.mode =3D 0444,
> +			.read	   =3D spdm_read_combined_prefix,
> +			.private   =3D log,
> +			.size	   =3D spdm_state->version <=3D 0x11 ? 0 :
> +				     SPDM_COMBINED_PREFIX_SZ },
> +
> +		.spdm_context =3D {
> +			.attr.attr.name =3D log->spdm_context_name,
> +			.attr.attr.mode =3D 0444,
> +			.attr.show =3D device_show_string,
> +			.var	   =3D (char *)spdm_context },
> +
> +		.hash_alg =3D {
> +			.attr.attr.name =3D log->hash_alg_name,
> +			.attr.attr.mode =3D 0444,
> +			.attr.show =3D device_show_string,
> +			.var	   =3D (char *)spdm_state->base_hash_alg_name },
> +	};
> +
> +	snprintf(log->sig_name, sizeof(log->sig_name),
> +		 "%u_signature", spdm_state->log_counter);
> +	snprintf(log->req_nonce_name, sizeof(log->req_nonce_name),
> +		 "%u_requester_nonce", spdm_state->log_counter);
> +	snprintf(log->rsp_nonce_name, sizeof(log->rsp_nonce_name),
> +		 "%u_responder_nonce", spdm_state->log_counter);
> +	snprintf(log->transcript_name, sizeof(log->transcript_name),
> +		 "%u_transcript", spdm_state->log_counter);
> +	snprintf(log->combined_prefix_name, sizeof(log->combined_prefix_name),
> +		 "%u_combined_spdm_prefix", spdm_state->log_counter);
> +	snprintf(log->spdm_context_name, sizeof(log->spdm_context_name),
> +		 "%u_type", spdm_state->log_counter);
> +	snprintf(log->hash_alg_name, sizeof(log->hash_alg_name),
> +		 "%u_hash_algorithm", spdm_state->log_counter);
> +
> +	sysfs_bin_attr_init(&log->sig);
> +	sysfs_bin_attr_init(&log->req_nonce);
> +	sysfs_bin_attr_init(&log->rsp_nonce);
> +	sysfs_bin_attr_init(&log->transcript);
> +	sysfs_bin_attr_init(&log->combined_prefix);
> +	sysfs_attr_init(&log->spdm_context.attr.attr);
> +	sysfs_attr_init(&log->hash_alg.attr.attr);
> +
> +	list_add_tail(&log->list, &spdm_state->log);
> +	spdm_state->log_counter++;

Sanity check for roll over maybe?=20

> +
> +	/* Steal transcript pointer ahead of spdm_free_transcript() */
> +	spdm_state->transcript =3D NULL;
> +
> +	if (device_is_registered(spdm_state->dev))
> +		spdm_publish_log_entry(&spdm_state->dev->kobj, log);
> +}
> +
> +/**
> + * spdm_publish_log() - Publish log of received SPDM signatures in sysfs
> + *
> + * @spdm_state: SPDM session state
> + *
> + * sysfs attributes representing received SPDM signatures are not static,
> + * but created dynamically upon authentication.  If a device was authent=
icated
> + * before it became visible in sysfs, the attributes could not be create=
d.
> + * This function retroactively creates those attributes in sysfs after t=
he
> + * device has become visible through device_add().
> + */
> +void spdm_publish_log(struct spdm_state *spdm_state)
> +{
> +	struct kobject *kobj =3D &spdm_state->dev->kobj;
> +	struct kernfs_node *grp_kn __free(kernfs_put);

As in previous reviews I'd keep constructor with destructor by declaring
these inline.

> +	struct spdm_log_entry *log;
> +
> +	grp_kn =3D kernfs_find_and_get(kobj->sd, spdm_signatures_group.name);
> +	if (WARN_ON(!grp_kn))
> +		return;
> +
> +	mutex_lock(&spdm_state->lock);

guard() perhaps.

> +	list_for_each_entry(log, &spdm_state->log, list) {
> +		struct kernfs_node *sig_kn __free(kernfs_put);
> +
> +		/*
> +		 * Skip over log entries created in-between device_add() and
> +		 * spdm_publish_log() as they've already been published.
> +		 */
> +		sig_kn =3D kernfs_find_and_get(grp_kn, log->sig_name);
> +		if (sig_kn)
> +			continue;
> +
> +		spdm_publish_log_entry(kobj, log);
> +	}
> +	mutex_unlock(&spdm_state->lock);
> +}
> +EXPORT_SYMBOL_GPL(spdm_publish_log);


