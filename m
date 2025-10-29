Return-Path: <linux-pci+bounces-39718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA34C1CD4B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAA5534BBDD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FC351FB9;
	Wed, 29 Oct 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aRcttS/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CB3563E3;
	Wed, 29 Oct 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764036; cv=none; b=iGYYNBaEuHMtux4oXVgmXJT8ZFCgPs+inXva7ZfJhyevc+rA2KcsgzvX4mh3gBXy8CC4WdnO44CETiQc1C6768XpC2WcedyLPlGb2KJgpWpHsA/4zxp6PKsMmKY7kFg/liQMp4CBsqmTOFH3eWhLcdNu4WvlUNVTVpbQI5m726k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764036; c=relaxed/simple;
	bh=QYApO3MfS9J0LIrWE7POhwN4+UJMBTuGqjI7z0wBsB0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=er5qdnOPcSb4kZvff9rAIP/Gb0mTVKkNWmxSD+Kddkiwn9rTxqcSvayvQyC58BYssq2lX/zLmotyrz8Spa6uPXHRSmN+EiDCmVuNXRWwhXssWEnW2e7K3pKo2cVWHwWOINkMFuuV52FWvGZc/bTNJLnexWzgAxPM86AZAGS8pEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aRcttS/R; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kHa9VxLTKrpVmQMTd3u1VXcvIkYKv0AO/Hnmqp/OGho=;
	b=aRcttS/RbiKAHRyXy99ro1Dg7gdjRzL8w03c0sjJg49oVWGQ55XjOu2wdqm1WLB9Q+w6Cdzly
	x3qmsDeZtSk41EsGoza0PisB8QuGLa42M/wTQNd6E7xLaSVb5lcrEry7DmiVu6lgXHMxmH5lllS
	6q9zh0GKJ93m6LC5zlDjMf0=
Received: from frasgout.his.huawei.com (unknown [172.18.146.32])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cxbwY0mJBzMlQs;
	Thu, 30 Oct 2025 02:53:00 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cxbwM4jNHzHnGct;
	Wed, 29 Oct 2025 18:52:51 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8455F1402EF;
	Thu, 30 Oct 2025 02:53:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 18:53:43 +0000
Date: Wed, 29 Oct 2025 18:53:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 12/12] coco: host: arm64: Register device
 public key with RMM
Message-ID: <20251029185342.00001dc2@huawei.com>
In-Reply-To: <20251027095602.1154418-13-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-13-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 15:26:02 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> - Introduce the SMC_RMI_PDEV_SET_PUBKEY helper and the associated struct
> rmi_public_key_params so the host can hand the device=E2=80=99s public ke=
y to
> the RMM.
>=20
> - Parse the certificate chain cached during IDE setup, extract the final
> certificate=E2=80=99s public key, and recognise RSA-3072, ECDSA-P256, and
> ECDSA-P384 keys before calling into the RMM.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Various comments inline.

Overall this patch set seems to be coming together nicely to me.

Jonathan

> diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.c b/drivers/virt/coco/=
arm-cca-host/rmi-da.c
> index 644609618a7a..c9780ca64c17 100644
> --- a/drivers/virt/coco/arm-cca-host/rmi-da.c
> +++ b/drivers/virt/coco/arm-cca-host/rmi-da.c
> @@ -8,6 +8,9 @@
>  #include <linux/pci-doe.h>
>  #include <linux/delay.h>
>  #include <asm/rmi_cmds.h>
> +#include <crypto/internal/rsa.h>
> +#include <keys/asymmetric-type.h>
> +#include <keys/x509-parser.h>
> =20
>  #include "rmi-da.h"
> =20
> @@ -361,6 +364,146 @@ static int do_pdev_communicate(struct pci_tsm *tsm,=
 enum rmi_pdev_state target_s
>  	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV=
_ERROR);
>  }
> =20
> +static int parse_certificate_chain(struct pci_tsm *tsm)
> +{
> +	struct cca_host_pf0_dsc *pf0_dsc;
> +	unsigned int chain_size;
> +	unsigned int offset =3D 0;
> +	u8 *chain_data;
> +
> +	pf0_dsc =3D to_cca_pf0_dsc(tsm->pdev);
> +
> +	/* If device communication didn't results in certificate caching. */
> +	if (!pf0_dsc->cert_chain.cache || !pf0_dsc->cert_chain.cache->offset)
> +		return -EINVAL;
> +
> +	chain_size =3D pf0_dsc->cert_chain.cache->offset;
> +	chain_data =3D pf0_dsc->cert_chain.cache->buf;
> +
> +	while (offset < chain_size) {
> +		ssize_t cert_len =3D
> +			x509_get_certificate_length(chain_data + offset,
> +						    chain_size - offset);
> +		if (cert_len < 0)
> +			return cert_len;
> +
> +		struct x509_certificate *cert __free(x509_free_certificate) =3D
> +			x509_cert_parse(chain_data + offset, cert_len);
> +
> +		if (IS_ERR(cert)) {
> +			pci_warn(tsm->pdev, "parsing of certificate chain not successful\n");
> +			return PTR_ERR(cert);
> +		}
> +
> +		/* The key in the last cert in the chain is used */
> +		if (offset + cert_len =3D=3D chain_size) {
> +			pf0_dsc->cert_chain.public_key =3D kzalloc(cert->pub->keylen, GFP_KER=
NEL);
I'd use a local variable for this + __free(kfree)
Then assign with no_free_ptr()
> +			if (!pf0_dsc->cert_chain.public_key)
> +				return -ENOMEM;
> +
> +			if (!strcmp("ecdsa-nist-p256", cert->pub->pkey_algo)) {
> +				pf0_dsc->rmi_signature_algorithm =3D RMI_SIG_ECDSA_P256;
> +			} else if (!strcmp("ecdsa-nist-p384", cert->pub->pkey_algo)) {
> +				pf0_dsc->rmi_signature_algorithm =3D RMI_SIG_ECDSA_P384;
> +			} else if (!strcmp("rsa", cert->pub->pkey_algo)) {
> +				pf0_dsc->rmi_signature_algorithm =3D RMI_SIG_RSASSA_3072;
> +			} else {
> +				kfree(pf0_dsc->cert_chain.public_key);
> +				pf0_dsc->cert_chain.public_key =3D NULL;
Set it only when succeeded (local variable until then).=20
> +				return -ENXIO;
> +			}
> +			memcpy(pf0_dsc->cert_chain.public_key, cert->pub->key, cert->pub->key=
len);
> +			pf0_dsc->cert_chain.public_key_size =3D cert->pub->keylen;
I think at this point we know we are at end of cert chain?  Break would mak=
e that obvious.

> +		}
> +
> +		offset +=3D cert_len;
> +	}
> +
> +	pf0_dsc->cert_chain.valid =3D true;
> +	return 0;
> +}
> +
> +DEFINE_FREE(free_page, unsigned long, if (_T) free_page(_T))

Fully agree with Jason on this one. If it make sense
belongs in appropriate header.
I'm a bit bothered by types though as the parameter is IIRC an unsigned lon=
g.

Might need some wrappers to deal with casting.  To me feels likely
to be controversial so pitch it separately from this series.

If you want a define free here create a local helper function tightly
scoped to the type you use it for below.

Or just wrap up the guts of the code in a helper function and
unconditionally free it the old fashioned way.


> +static int pdev_set_public_key(struct pci_tsm *tsm)
> +{
> +	unsigned long expected_key_len;
> +	struct cca_host_pf0_dsc *pf0_dsc;
> +	int ret;
> +
> +	pf0_dsc =3D to_cca_pf0_dsc(tsm->pdev);
> +	/* Check that all the necessary information was captured from communica=
tion */
> +	if (!pf0_dsc->cert_chain.valid)
> +		return -EINVAL;
> +
> +	struct rmi_public_key_params *key_params __free(free_page) =3D
> +		(struct rmi_public_key_params *)get_zeroed_page(GFP_KERNEL);
> +	if (!key_params)
> +		return -ENOMEM;
> +
> +	key_params->rmi_signature_algorithm =3D pf0_dsc->rmi_signature_algorith=
m;
> +
> +	switch (key_params->rmi_signature_algorithm) {
> +	case RMI_SIG_ECDSA_P384:
> +	{
> +		expected_key_len =3D 97;
That feels like it should be a define somewhere.
> +
> +		if (pf0_dsc->cert_chain.public_key_size !=3D expected_key_len)
> +			return -EINVAL;
> +
> +		key_params->public_key_len =3D pf0_dsc->cert_chain.public_key_size;
> +		memcpy(key_params->public_key,
> +		       pf0_dsc->cert_chain.public_key,
> +		       pf0_dsc->cert_chain.public_key_size);
> +		key_params->metadata_len =3D 0;
> +		break;
> +	}
> +	case RMI_SIG_ECDSA_P256:
> +	{
> +		expected_key_len =3D 65;
Same with this constant.

> +
> +		if (pf0_dsc->cert_chain.public_key_size !=3D expected_key_len)
> +			return -EINVAL;
> +
> +		key_params->public_key_len =3D pf0_dsc->cert_chain.public_key_size;
> +		memcpy(key_params->public_key,
> +		       pf0_dsc->cert_chain.public_key,
> +		       pf0_dsc->cert_chain.public_key_size);
> +		key_params->metadata_len =3D 0;
> +		break;
> +	}
> +	case RMI_SIG_RSASSA_3072:
> +	{
> +		struct rsa_key rsa_key =3D {0};
> +
> +		expected_key_len =3D 385;
And this one ;)
> +		int ret_rsa_parse =3D rsa_parse_pub_key(&rsa_key,
> +						      pf0_dsc->cert_chain.public_key,
> +						      pf0_dsc->cert_chain.public_key_size);
Don't mix declarations and code except for cleanup.h stuff.

> +		/* This also checks the key_len */
> +		if (ret_rsa_parse)
> +			return ret_rsa_parse;
> +		/*
> +		 * exponent is usually 65537 (size =3D 24bits) but in rare cases
> +		 * the size can be as large as the modulus
> +		 */
> +		if (rsa_key.e_sz > expected_key_len)
> +			return -EINVAL;
> +
> +		key_params->public_key_len =3D rsa_key.n_sz;
> +		key_params->metadata_len =3D rsa_key.e_sz;
> +		memcpy(key_params->public_key, rsa_key.n, rsa_key.n_sz);
> +		memcpy(key_params->metadata, rsa_key.e, rsa_key.e_sz);
> +		break;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret =3D rmi_pdev_set_pubkey(virt_to_phys(pf0_dsc->rmm_pdev),
> +				  virt_to_phys(key_params));
> +	return ret;

return rmi_pdev_set_pubkey();

> +}
> +
>  void pdev_communicate_work(struct work_struct *work)
>  {
>  	unsigned long state;
> @@ -410,7 +553,28 @@ static int submit_pdev_comm_work(struct pci_dev *pde=
v, int target_state)
> =20
>  int pdev_ide_setup(struct pci_dev *pdev)
>  {
> -	return submit_pdev_comm_work(pdev, RMI_PDEV_NEEDS_KEY);
> +	int ret;
> +
> +	ret =3D submit_pdev_comm_work(pdev, RMI_PDEV_NEEDS_KEY);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * we now have certificate chain in dsm->cert_chain. Parse

Wrap at 80 chars. This is a bit short.

> +	 * that and set the pubkey.
> +	 */
> +	ret =3D parse_certificate_chain(pdev->tsm);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pdev_set_public_key(pdev->tsm);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D submit_pdev_comm_work(pdev, RMI_PDEV_READY);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return submit_pdev_comm_work(...)

>  }



