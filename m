Return-Path: <linux-pci+bounces-10525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4D6935074
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A0DB210B3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA114375A;
	Thu, 18 Jul 2024 16:11:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E132E859;
	Thu, 18 Jul 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319114; cv=none; b=OLyaJb8h30sbGCQCVx9o+XWCiGcIldGa4oEMn3iQRLAXEW2USDU14sy4ul/ieUhY0ULEurT4qP89MoFsfAFalhFPeTZl49w6wE/BG+KDdMuGXVGRkx79AZ2mviqkj4Pt0DUk3XmftJ7jOBA8DGyEWGOrcpeWbdruK81XC8+d4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319114; c=relaxed/simple;
	bh=oM/UVR1OD4HiRfE65oLQ0NGxCO3Tc8qlppSBx2Y3Kh0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mapAMr/GwRKIl7/3eiVh0Eixsd2F6B9fLfMLrwhVYz/Cli+SgsvR7U/iM7w2FR80r1DxQa2Xmx5bZgI9dBv2IKffeYRMfnaGpQm8oKMCcp20CSiSQGTt7lgvgvPSUT81IejiEU8Ie4aQuvP9zvwOmpaaeDGDsEzhJtc1sxBqy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPyT05c8xz6J9mG;
	Fri, 19 Jul 2024 00:10:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CC19F140DD5;
	Fri, 19 Jul 2024 00:11:50 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 17:11:50 +0100
Date: Thu, 18 Jul 2024 17:11:49 +0100
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
	<corbet@lwn.net>
Subject: Re: [PATCH v2 18/18] spdm: Allow control of next requester nonce
 through sysfs
Message-ID: <20240718171149.000011b4@Huawei.com>
In-Reply-To: <ee3248f9f8d60cff9106a5a46c5f5d53ac81e60a.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<ee3248f9f8d60cff9106a5a46c5f5d53ac81e60a.1719771133.git.lukas@wunner.de>
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

On Sun, 30 Jun 2024 21:53:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> Remote attestation services may mistrust the kernel to always use a
> fresh nonce for SPDM authentication.
>=20
> So allow user space to set the next requester nonce by writing to a
> sysfs attribute.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: J=E9r=F4me Glisse <jglisse@google.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
Why is the group visibility callback in this patch?


Otherwise looks fine to me,

Jonathan


> ---
>  Documentation/ABI/testing/sysfs-devices-spdm | 29 ++++++++++++++++
>  lib/spdm/core.c                              |  1 +
>  lib/spdm/req-authenticate.c                  |  8 ++++-
>  lib/spdm/req-sysfs.c                         | 35 ++++++++++++++++++++
>  lib/spdm/spdm.h                              |  4 +++
>  5 files changed, 76 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation=
/ABI/testing/sysfs-devices-spdm
> index 5ce34ce10b9c..d315b47b4af0 100644
> --- a/Documentation/ABI/testing/sysfs-devices-spdm
> +++ b/Documentation/ABI/testing/sysfs-devices-spdm
> @@ -216,3 +216,32 @@ Description:
>  		necessary to parse the SPDM messages in the transcript to find
>  		and extract the nonces, which is cumbersome.  That's why they
>  		are exposed as separate files.
> +
> +
> +What:		/sys/devices/.../signatures/next_requester_nonce
> +Date:		June 2024
> +Contact:	Lukas Wunner <lukas@wunner.de>
> +Description:
> +		If you do not trust the kernel to always use a fresh nonce,
> +		write 32 bytes to this file to set the requester nonce used
> +		in the next SPDM authentication sequence.
> +
> +		Meant for remote attestation services.  You are responsible
> +		for providing a nonce with sufficient entropy.  The kernel
> +		only uses the nonce once, so provide a new one every time
> +		you reauthenticate the device.  If you do not provide a
> +		nonce, the kernel generates a random one.
> +
> +		After the nonce has been consumed, it becomes readable as
> +		the newest [0-9]*_requester_nonce, which proves its usage::
> +
> +		 # dd if=3D/dev/random bs=3D32 count=3D1 | \
> +		   tee signatures/next_requester_nonce | hexdump
> +		 0000000 e0 77 91 54 bd 56 99 c2 ea 4f 0b 1a 7f ba 6e 59
> +		 0000010 8f ee f6 b2 26 82 58 34 9e e5 8c 8a 31 58 29 7e
> +
> +		 # echo re > authenticated
> +
> +		 # hexdump $(\ls -t signatures/[0-9]*_requester_nonce | head -1)
> +		 0000000 e0 77 91 54 bd 56 99 c2 ea 4f 0b 1a 7f ba 6e 59
> +		 0000010 8f ee f6 b2 26 82 58 34 9e e5 8c 8a 31 58 29 7e
> diff --git a/lib/spdm/core.c b/lib/spdm/core.c
> index b6a46bdbb2f9..7371adb7a52f 100644
> --- a/lib/spdm/core.c
> +++ b/lib/spdm/core.c
> @@ -434,6 +434,7 @@ void spdm_destroy(struct spdm_state *spdm_state)
>  	spdm_reset(spdm_state);
>  	spdm_destroy_log(spdm_state);
>  	mutex_destroy(&spdm_state->lock);
> +	kfree(spdm_state->next_nonce);
>  	kfree(spdm_state);
>  }
>  EXPORT_SYMBOL_GPL(spdm_destroy);
> diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
> index 7c977f5835c1..489fc88de74d 100644
> --- a/lib/spdm/req-authenticate.c
> +++ b/lib/spdm/req-authenticate.c
> @@ -626,7 +626,13 @@ static int spdm_challenge(struct spdm_state *spdm_st=
ate, u8 slot, bool verify)
>  	};
>  	int rc, length;
> =20
> -	get_random_bytes(&req.nonce, sizeof(req.nonce));
> +	if (spdm_state->next_nonce) {
> +		memcpy(&req.nonce, spdm_state->next_nonce, sizeof(req.nonce));
> +		kfree(spdm_state->next_nonce);
> +		spdm_state->next_nonce =3D NULL;
> +	} else {
> +		get_random_bytes(&req.nonce, sizeof(req.nonce));
> +	}
> =20
>  	if (spdm_state->version <=3D 0x12)
>  		req_sz =3D offsetofend(typeof(req), nonce);
> diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
> index c782054f8e18..232d4a00a510 100644
> --- a/lib/spdm/req-sysfs.c
> +++ b/lib/spdm/req-sysfs.c
> @@ -176,13 +176,48 @@ const struct attribute_group spdm_certificates_grou=
p =3D {
> =20
>  /* signatures attributes */
> =20
> +static umode_t spdm_signatures_are_visible(struct kobject *kobj,
> +					   struct bin_attribute *a, int n)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct spdm_state *spdm_state =3D dev_to_spdm_state(dev);
> +
> +	if (IS_ERR_OR_NULL(spdm_state))
> +		return SYSFS_GROUP_INVISIBLE;
> +
> +	return a->attr.mode;
> +}
> +
> +static ssize_t next_requester_nonce_write(struct file *file,
> +					  struct kobject *kobj,
> +					  struct bin_attribute *attr,
> +					  char *buf, loff_t off, size_t count)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct spdm_state *spdm_state =3D dev_to_spdm_state(dev);
> +
> +	guard(mutex)(&spdm_state->lock);
> +
> +	if (!spdm_state->next_nonce) {
> +		spdm_state->next_nonce =3D kmalloc(SPDM_NONCE_SZ, GFP_KERNEL);
> +		if (!spdm_state->next_nonce)
> +			return -ENOMEM;
> +	}
> +
> +	memcpy(spdm_state->next_nonce + off, buf, count);
> +	return count;
> +}
> +static BIN_ATTR_WO(next_requester_nonce, SPDM_NONCE_SZ);
> +
>  static struct bin_attribute *spdm_signatures_bin_attrs[] =3D {
> +	&bin_attr_next_requester_nonce,
>  	NULL
>  };
> =20
>  const struct attribute_group spdm_signatures_group =3D {
>  	.name =3D "signatures",
>  	.bin_attrs =3D spdm_signatures_bin_attrs,
> +	.is_bin_visible =3D spdm_signatures_are_visible,
>  };
> =20
>  static unsigned int spdm_max_log_sz =3D SZ_16M; /* per device */
> diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
> index 448107c92db7..aa36aa55e718 100644
> --- a/lib/spdm/spdm.h
> +++ b/lib/spdm/spdm.h
> @@ -475,6 +475,9 @@ struct spdm_error_rsp {
>   *	itself and the transcript with trailing signature.
>   * @log_counter: Number of generated log entries so far.  Will be prefix=
ed to
>   *	the sysfs files of the next generated log entry.
> + * @next_nonce: Requester nonce to be used for the next authentication
> + *	sequence.  Populated from user space through sysfs.
> + *	If user space does not provide a nonce, the kernel uses a random one.
>   */
>  struct spdm_state {
>  	struct device *dev;
> @@ -521,6 +524,7 @@ struct spdm_state {
>  	struct list_head log;
>  	size_t log_sz;
>  	u32 log_counter;
> +	u8 *next_nonce;
>  };
> =20
>  extern struct list_head spdm_state_list;


