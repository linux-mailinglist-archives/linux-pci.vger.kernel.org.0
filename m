Return-Path: <linux-pci+bounces-18163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0EB9ED2E0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D19A168350
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982EF1DDC2C;
	Wed, 11 Dec 2024 16:56:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7E1D63CA;
	Wed, 11 Dec 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936206; cv=none; b=USttrJmvkjjIwR+nL9vUTRjvfScTQXa+obKjz2APrw2ANFDd4UkDiuxrzNg/YrkMJwjl9cwEPNwkNaLtH51tsv0rkjUEWWW4IIlmpYbcxUQ9q0VU5qbo7Aq7wSCT9bEzPQZVuoMtyGhUX7p8CivZrcwV4kFvnBRPBHtHTHeU8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936206; c=relaxed/simple;
	bh=OvzFGwc+lNAvC1w165pMZVXDoBNGBX4g5eWt+rnYQTk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIsw3q91i3NuUMINGgSzMjsVU43qxK/tV2WIQi/Q/zE7fPZqALhJyoV6LmCshV5lmMFVIj9nmMAt1lQMBmnGJoSB+kbctiicZVKpRQPBzcR3tDRATca3MlqbsncOrBzv1bzz+JLl+GIxMtTEknL41Fo/K7kgFFXhsa2SnbRf4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7hW82jV1z6D8XN;
	Thu, 12 Dec 2024 00:53:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E8C01400CA;
	Thu, 12 Dec 2024 00:56:41 +0800 (CST)
Received: from localhost (10.48.145.145) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 17:56:40 +0100
Date: Wed, 11 Dec 2024 16:56:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Mahesh
 J Salgaonkar" <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 7/8] PCI: Create helper to print TLP Header and
 Prefix Log
Message-ID: <20241211165638.00006f33@huawei.com>
In-Reply-To: <20240913143632.5277-8-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
	<20240913143632.5277-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Sep 2024 17:36:31 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Add pcie_print_tlp_log() helper to print TLP Header and Prefix Log.
> Print End-End Prefixes only if they are non-zero.
>=20
> Consolidate the few places which currently print TLP using custom
> formatting.
>=20
> The first attempt used pr_cont() instead of building a string first but
> it turns out pr_cont() is not compatible with pci_err() and prints on a
> separate line. When I asked about this, Andy Shevchenko suggested
> pr_cont() should not be used in the first place (to eventually get rid
> of it) so pr_cont() is now replaced with building the string first.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

A couple of trivial things inline but looks good to me either way.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index def9dd7b73e8..097ac8514e96 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -6,6 +6,7 @@
>   */
> =20
>  #include <linux/aer.h>
> +#include <linux/array_size.h>
>  #include <linux/pci.h>
>  #include <linux/string.h>
> =20
> @@ -76,3 +77,33 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, =
int where2,
> =20
>  	return 0;
>  }
> +
> +/**
> + * pcie_print_tlp_log - Print TLP Header / Prefix Log contents
> + * @dev: PCIe device
> + * @log: TLP Log structure
> + * @pfx: String prefix (for print out indentation)

Code doesn't care if it is indentation or ponies.  So does it make
sense to say anything beyond String prefix?

> + *
> + * Prints TLP Header and Prefix Log information held by @log.
> + */
> +void pcie_print_tlp_log(const struct pci_dev *dev,
> +			const struct pcie_tlp_log *log, const char *pfx)
> +{
> +	char buf[(10 + 1) * (4 + ARRAY_SIZE(log->prefix)) + 14 + 1];

Can we associate the 14 with the prefixes string by having that as a
const char * and using strlen()  It was a tiny bit irritating to count
the characters whilst reviewing this ;)



> +	unsigned int i;
> +	int len;
> +
> +	len =3D scnprintf(buf, sizeof(buf), "%#010x %#010x %#010x %#010x",
> +			log->dw[0], log->dw[1], log->dw[2], log->dw[3]);
> +
> +	if (log->prefix[0])
> +		len +=3D scnprintf(buf + len, sizeof(buf) - len, " E-E Prefixes:");
> +	for (i =3D 0; i < ARRAY_SIZE(log->prefix); i++) {
> +		if (!log->prefix[i])
> +			break;
> +		len +=3D scnprintf(buf + len, sizeof(buf) - len,
> +				 " %#010x", log->prefix[i]);
> +	}
> +
> +	pci_err(dev, "%sTLP Header: %s\n", pfx, buf);
> +}


