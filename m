Return-Path: <linux-pci+bounces-19240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF10DA00C25
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4301884622
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE471BEF95;
	Fri,  3 Jan 2025 16:38:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD259B71;
	Fri,  3 Jan 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922308; cv=none; b=XpyW3vIXAK1U93XKvy0ESuY6UeQwdmWm09rF6cujG+FmcY5yFZ2gi2GD+JTCUsTHM7gxDjM2DtbFGk8aJd6lRMigogjSab4veYsTazSriFhHLi1LBtcvy/4reMVQjQjjpaWX34cOlU8HwS1W4hO/Yv37JP9DXdsf8QwBUd5N47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922308; c=relaxed/simple;
	bh=b9Wz5T09QYZihqzho0/7WPT0FEO5PDrMnfQzQQb9SVs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWpedpc3iF/YF2TEupT0z8VfwnevEu1xAII5przHJpM3DRtwsXnL6nqnFU7nAS1jazDNw+CeMOgbK1nCi4MJ3r98Fe0LIs5YUPDlqliSkt6Pt0XEMKAFLO0G9PRQaiZ7IRf2S0lLAFXanX2KHp8F8GAniXUQVBQAAUJHk+H9dss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPq091Y2Rz6K61Y;
	Sat,  4 Jan 2025 00:34:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A59A1404C4;
	Sat,  4 Jan 2025 00:38:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 17:38:22 +0100
Date: Fri, 3 Jan 2025 16:38:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Lukas Wunner
	<lukas@wunner.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 4/7] PCI: Use unsigned int i in pcie_read_tlp_log()
Message-ID: <20250103163821.00005521@huawei.com>
In-Reply-To: <20241218143747.3159-5-ilpo.jarvinen@linux.intel.com>
References: <20241218143747.3159-1-ilpo.jarvinen@linux.intel.com>
	<20241218143747.3159-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Dec 2024 16:37:44 +0200
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Loop variable i counting from 0 upwards does not need to be signed so
> make it unsigned int.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Whilst I find it hard to care, it is harmless so up to Bjorn if he
wants the churn or not.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pcie/tlp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 2bf15749cd31..65ac7b5d8a87 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -24,7 +24,8 @@
>  int pcie_read_tlp_log(struct pci_dev *dev, int where,
>  		      struct pcie_tlp_log *log)
>  {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
> =20
>  	memset(log, 0, sizeof(*log));
> =20


