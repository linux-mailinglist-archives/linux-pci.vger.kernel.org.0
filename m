Return-Path: <linux-pci+bounces-14877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1309A4340
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB501F216D3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7451FF5F7;
	Fri, 18 Oct 2024 16:08:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703E4207A;
	Fri, 18 Oct 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267687; cv=none; b=CfftZCEOJZdXCmH068sOhfsZyFKSBq6Cy+Chg6o7Jp82p1I7OGXo7QZ71MB/30MCDUrVEfV/OuviDg8bMuF/ay/PnWUWYH7JTalV6sZXWH3wUu0pgXaObSw+Wz3WjwW+74XLMbZaKUJTRl/KDgTyclyvDLq26TWSaHf/2PLc2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267687; c=relaxed/simple;
	bh=9EMHQ/87g+IuniVDCzsKbm27+9bb3hIIDF1TeSSL6bQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eImOqWxOvSfAw6iekwq+Ow/4ABk33JHEdhhmhpyMesEyx3ccUA97gUY+au8Y0mz4H9Ecnn6+lRwqLhHtWb4Z0d2gAecQpr8SQB2S1tMNW2EwSjDP26NvPt4IOMAMDqqWYONjoiAYOLdVEUgwKrxhmc6VoiqXPFUW6vbatOfiX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVV2N0wnkz6HJdf;
	Sat, 19 Oct 2024 00:06:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8419D140B63;
	Sat, 19 Oct 2024 00:07:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 18:07:35 +0200
Date: Fri, 18 Oct 2024 17:07:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: Use reverse logic in pci_read_bridge_bases()
Message-ID: <20241018170733.00007fe7@Huawei.com>
In-Reply-To: <20241017141111.44612-3-ilpo.jarvinen@linux.intel.com>
References: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
	<20241017141111.44612-3-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 17:11:10 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use reverse logic combined with return and continue to allow
> significant reduction in indentation level in pci_read_bridge_bases().
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/probe.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4243b1e6ece2..cc97dbda7e76 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -543,14 +543,15 @@ void pci_read_bridge_bases(struct pci_bus *child)
>  	pci_read_bridge_mmio(child->self, child->resource[1], false);
>  	pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
> =20
> -	if (dev->transparent) {
> -		pci_bus_for_each_resource(child->parent, res) {
> -			if (res && res->flags) {
> -				pci_bus_add_resource(child, res);
> -				pci_info(dev, "  bridge window %pR (subtractive decode)\n",
> -					   res);
> -			}
> -		}
> +	if (!dev->transparent)
> +		return;
> +
> +	pci_bus_for_each_resource(child->parent, res) {
> +		if (!res || !res->flags)
> +			continue;
> +
> +		pci_bus_add_resource(child, res);
> +		pci_info(dev, "  bridge window %pR (subtractive decode)\n", res);
>  	}
>  }
> =20


