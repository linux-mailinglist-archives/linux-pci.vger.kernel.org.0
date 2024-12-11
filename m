Return-Path: <linux-pci+bounces-18160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636379ED223
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B3628247F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D821DDA3C;
	Wed, 11 Dec 2024 16:36:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2E19FA93;
	Wed, 11 Dec 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934998; cv=none; b=l+yEpd4GxCw2ZrkbJ/tj1ofGwt6dGFa8FT4KLdmqyfu5eSjfevh6fAoy9sZl6ExEhGWqKKPR4NHU6jQZyhXlRJZkyOhws1GolqGwkOVmbh8oNjzPHTJ4sK8qkWI9Sy8/TxS20B8I64+Mw1wTLq2WDDLsyc+zoEwK3YDPQxt2oec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934998; c=relaxed/simple;
	bh=vW2IVtWWDAdruhQy43BNtFJQ32FDy7zab3tyr8kCqwg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch0gA9+6CudnajdoLzFTGaL2Kit5wB2n4F3HTUXHhr0v6uZ3EhFWKOYKY3Y+pmmd1awwwV6D9P/986dlDegbc9pb31fSMLKb1EL9aW02RgsNQGve4Xc9pLKngv1Zwzu7TrfJHiUI15EGhgCSMMxwp0mg8To+w9DvUZaf1OfweRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7h2L3n3mz6K5mB;
	Thu, 12 Dec 2024 00:31:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 63AD21400CA;
	Thu, 12 Dec 2024 00:36:32 +0800 (CST)
Received: from localhost (10.48.145.145) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 17:36:31 +0100
Date: Wed, 11 Dec 2024 16:36:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Mahesh
 J Salgaonkar" <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 5/8] PCI: Store # of supported End-End TLP Prefixes
Message-ID: <20241211163629.00002937@huawei.com>
In-Reply-To: <20240913143632.5277-6-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
	<20240913143632.5277-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Sep 2024 17:36:29 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
> are supported by the path or not, the value is only calculated if
> CONFIG_PCI_PASID is set.
>=20
> The Max End-End TLP Prefixes field in the Device Capabilities Register
> 2 also tells how many (1-4) End-End TLP Prefixes are supported (PCIe r6
> sec 7.5.3.15). The number of supported End-End Prefixes is useful for
> reading correct number of DWORDs from TLP Prefix Log register in AER
> capability (PCIe r6 sec 7.8.4.12).
>=20
> Replace eetlp_prefix_path with eetlp_prefix_max and determine the
> number of supported End-End Prefixes regardless of CONFIG_PCI_PASID so
> that an upcoming commit generalizing TLP Prefix Log register reading
> does not have to read extra DWORDs for End-End Prefixes that never will
> be there.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/ats.c             |  2 +-
>  drivers/pci/probe.c           | 14 +++++++++-----
>  include/linux/pci.h           |  2 +-
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index c570892b2090..e13433dcfc82 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -377,7 +377,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int featur=
es)
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
> =20
> -	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
> +	if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
>  		return -EINVAL;
> =20
>  	if (!pasid)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..0ab70ea6840c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2228,8 +2228,8 @@ static void pci_configure_relaxed_ordering(struct p=
ci_dev *dev)
> =20
>  static void pci_configure_eetlp_prefix(struct pci_dev *dev)
>  {
> -#ifdef CONFIG_PCI_PASID
>  	struct pci_dev *bridge;
> +	unsigned int eetlp_max;
>  	int pcie_type;
>  	u32 cap;
> =20
> @@ -2241,15 +2241,19 @@ static void pci_configure_eetlp_prefix(struct pci=
_dev *dev)
>  		return;
> =20
>  	pcie_type =3D pci_pcie_type(dev);
> +
> +	eetlp_max =3D FIELD_GET(PCI_EXP_DEVCAP2_EE_PREFIX_MAX, cap);
> +	/* 00b means 4 */
> +	eetlp_max =3D eetlp_max ?: 4;
> +
>  	if (pcie_type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>  	    pcie_type =3D=3D PCI_EXP_TYPE_RC_END)
> -		dev->eetlp_prefix_path =3D 1;
> +		dev->eetlp_prefix_max =3D eetlp_max;
>  	else {
>  		bridge =3D pci_upstream_bridge(dev);
> -		if (bridge && bridge->eetlp_prefix_path)
> -			dev->eetlp_prefix_path =3D 1;
> +		if (bridge && bridge->eetlp_prefix_max)

What happens if they disagree?  That is the bridge supports 2
and the device 3?


> +			dev->eetlp_prefix_max =3D eetlp_max;
>  	}
> -#endif
>  }



> =20


