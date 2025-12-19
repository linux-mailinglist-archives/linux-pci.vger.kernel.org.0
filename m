Return-Path: <linux-pci+bounces-43379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C47CCFC56
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1037430B496D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93033373E;
	Fri, 19 Dec 2025 12:07:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ACA332EBF
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146048; cv=none; b=lS5SSwE5hu35CF7Na3kt6VE1g3fynI0jyaK/ZDg3/htyHCQT71CNfU8wGRk7kfiTF9Rss8gW7lS2b3WMJVVx153WsqM6WuCqD+Aq9bDN5L9V1o31M8ahgk8bj/UTJ0ULOZ3RGisPGgnENXYChDOa6FBNKYz9S8F/t3Ggq5cZxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146048; c=relaxed/simple;
	bh=A2N4OGE9ltPfouEAyzIWTWuU/PbScHoSaGK3C6rUbjA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUv6uy9KGzXBmR+g4N2L+hP/KWHOuirco/6zu4AUFsEX2/ckhCWQsRLpymsmNtq8f8pLgNlvzQvn+xXIVQYXbWx/HPR7osvf+CYS4RplEllT/6xymqOjimYDY7rdy+E60iLUmU51fbrCVS4hm4oWzlOTQoetA+J+SE26KGfJ2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXmVP0nskzJ46BZ;
	Fri, 19 Dec 2025 20:06:53 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A999A40565;
	Fri, 19 Dec 2025 20:07:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:07:25 +0000
Date: Fri, 19 Dec 2025 12:07:23 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Ilpo
 =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/6] PCI/portdrv: Fix potential resource leak
Message-ID: <20251219120723.0000173d@huawei.com>
In-Reply-To: <e1c68c3b3f1af8427e98ca5e2c79f8bf0ebe2ce4.1764688034.git.u.kleine-koenig@baylibre.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
	<e1c68c3b3f1af8427e98ca5e2c79f8bf0ebe2ce4.1764688034.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  2 Dec 2025 16:13:49 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> pcie_port_probe_service() unconditionally calls get_device() (unless it
> fails). So drop that reference also unconditionally as it's fine for a
> pcie driver to not have a remove callback.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
> This isn't very urgent as I think there is no pcie driver without a
> remove callback

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/pci/pcie/portdrv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index d1b68c18444f..f13039378908 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -557,10 +557,10 @@ static int pcie_port_remove_service(struct device *=
dev)
> =20
>  	pciedev =3D to_pcie_device(dev);
>  	driver =3D to_service_driver(dev->driver);
> -	if (driver && driver->remove) {
> +	if (driver && driver->remove)
>  		driver->remove(pciedev);
> -		put_device(dev);
> -	}
> +
> +	put_device(dev);
>  	return 0;
>  }
> =20


